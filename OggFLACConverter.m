/*
 *  $Id$
 *
 *  Copyright (C) 2005, 2006 Stephen F. Booth <me@sbooth.org>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#import "OggFLACConverter.h"
#import "MallocException.h"
#import "IOException.h"
#import "StopException.h"
#import "FLACException.h"

#include <fcntl.h>		// open, write
#include <sys/stat.h>	// stat

@interface OggFLACConverter (Private)
- (void) writeFrame:(const FLAC__Frame *)frame buffer:(const FLAC__int32 * const [])buffer;
@end

static FLAC__StreamDecoderWriteStatus 
writeCallback(const OggFLAC__FileDecoder *decoder, const FLAC__Frame *frame, const FLAC__int32 * const buffer[], void *client_data)
{
	OggFLACConverter *converter = (OggFLACConverter *) client_data;
	[converter writeFrame:frame buffer:buffer];
	
	// Always return continue; an exception will be thrown if this isn't the case
	return FLAC__STREAM_DECODER_WRITE_STATUS_CONTINUE;
}

static void
metadataCallback(const OggFLAC__FileDecoder *decoder, const FLAC__StreamMetadata *metadata, void *client_data)
{
	OggFLACConverter *converter = (OggFLACConverter *) client_data;
	
	// Only accept 16-bit 2-channel FLAC files
	if(FLAC__METADATA_TYPE_STREAMINFO == metadata->type) {
		if(16 != metadata->data.stream_info.bits_per_sample && 2 != metadata->data.stream_info.channels) {
			[converter setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
			@throw [FLACException exceptionWithReason:@"OggFLAC stream is not 16-bit stereo" userInfo:nil];
		}
	}
}

static void
errorCallback(const OggFLAC__FileDecoder *decoder, FLAC__StreamDecoderErrorStatus status, void *client_data)
{
	OggFLACConverter *converter = (OggFLACConverter *) client_data;
	
	NSLog(@"errorCallback");
	
	[converter setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
	@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(decoder)]] userInfo:nil];
}

@implementation OggFLACConverter

- (id) initWithInputFilename:(NSString *)inputFilename
{
	if((self = [super initWithInputFilename:inputFilename])) {	
		
		_fd  = -1;
		
		// Create and setup FLAC decoder
		_flac = OggFLAC__file_decoder_new();
		if(NULL == _flac) {
			@throw [MallocException exceptionWithReason:@"Unable to create FLAC decoder" userInfo:nil];
		}
		
		if(NO == OggFLAC__file_decoder_set_filename(_flac, [_inputFilename UTF8String])) {
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		
		// Setup callbacks
		if(NO == OggFLAC__file_decoder_set_write_callback(_flac, writeCallback)) {
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		if(NO == OggFLAC__file_decoder_set_metadata_callback(_flac, metadataCallback)) {
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		if(NO == OggFLAC__file_decoder_set_error_callback(_flac, errorCallback)) {
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		if(NO == OggFLAC__file_decoder_set_client_data(_flac, self)) {
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		
		return self;
	}
	return nil;
}

- (void) dealloc
{
	OggFLAC__file_decoder_delete(_flac);
	[super dealloc];
}

- (void) convertToFile:(int)file
{
	FLAC__uint64		bytesRead			= 0;
	FLAC__uint64		bytesToRead			= 0;
	FLAC__uint64		totalBytes			= 0;
	
	
	// Tell our owner we are starting
	_startTime = [[NSDate date] retain];
	
	[self setValue:[NSNumber numberWithBool:YES] forKey:@"started"];
	[self setValue:[NSNumber numberWithDouble:0.0] forKey:@"percentComplete"];
	
	_fd = file;
	
	// Get input file information
	struct stat sourceStat;
	if(-1 == stat([_inputFilename UTF8String], &sourceStat)) {
		[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
		@throw [IOException exceptionWithReason:[NSString stringWithFormat:@"Unable to stat input file (%i:%s) [%s:%i]", errno, strerror(errno), __FILE__, __LINE__] userInfo:nil];
	}
	
	totalBytes		= (FLAC__uint64)sourceStat.st_size;
	bytesToRead		= totalBytes;
	
	// Initialize decoder
	if(OggFLAC__FILE_DECODER_OK != OggFLAC__file_decoder_init(_flac)) {
		[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
		@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
	}
	
	for(;;) {
		// Check if we should stop, and if so throw an exception
		if([_shouldStop boolValue]) {
			[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
			@throw [StopException exceptionWithReason:@"Stop requested by user" userInfo:nil];
		}
		
		// Decode the data
		if(NO == OggFLAC__file_decoder_process_single(_flac)) {
			[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		
		// EOF?
		if(OggFLAC__FILE_DECODER_END_OF_FILE == OggFLAC__file_decoder_get_state(_flac)) {
			break;
		}
		
		// Determine bytes processed (TBD)
		/*
		if(NO == OggFLAC__file_decoder_get_decode_position(_flac, &bytesRead)) {
			[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
			@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
		}
		
		
		// Update status
		bytesToRead = totalBytes - bytesRead;
		[self setValue:[NSNumber numberWithDouble:((double)(totalBytes - bytesToRead)/(double) totalBytes) * 100.0] forKey:@"percentComplete"];
		NSTimeInterval interval = -1.0 * [_startTime timeIntervalSinceNow];
		unsigned int timeRemaining = interval / ((double)(totalBytes - bytesToRead)/(double) totalBytes) - interval;
		[self setValue:[NSString stringWithFormat:@"%i:%02i", timeRemaining / 60, timeRemaining % 60] forKey:@"timeRemaining"];
		*/
	}
	
	// Flush buffers
	if(NO == OggFLAC__file_decoder_finish(_flac)) {
		[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
		@throw [FLACException exceptionWithReason:[NSString stringWithUTF8String:OggFLAC__FileDecoderStateString[OggFLAC__file_decoder_get_state(_flac)]] userInfo:nil];
	}
	
	// Finish up
	_fd  = -1;
	
	[self setValue:[NSNumber numberWithBool:YES] forKey:@"completed"];
	[self setValue:[NSNumber numberWithDouble:100.0] forKey:@"percentComplete"];
	
	_endTime = [[NSDate date] retain];
}

- (void) writeFrame:(const FLAC__Frame *)frame buffer:(const FLAC__int32 * const [])buffer
{
	// We need to interleave the buffers for PCM output
	ssize_t			pcmBufferLen;
	int16_t			*pcmBuffer, *pos, *limit;
	FLAC__int32		*leftPCM, *rightPCM;
	
	pcmBufferLen	= frame->header.channels * frame->header.blocksize;
	pcmBuffer		= calloc(pcmBufferLen, sizeof(int16_t));
	if(NULL == pcmBuffer) {
		[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
		@throw [MallocException exceptionWithReason:@"Unable to create buffer" userInfo:nil];
	}
	
	// Interleave (16-bit sample size hard-coded)
	leftPCM			= (FLAC__int32 *)buffer[0];
	rightPCM		= (FLAC__int32 *)buffer[1];
	pos				= pcmBuffer;
	limit			= pcmBuffer + pcmBufferLen;
	while(pos < limit) {
		*pos++ = (int16_t)*leftPCM++;
		*pos++ = (int16_t)*rightPCM++;
	}
	
	// Write
	if(-1 == write(_fd, pcmBuffer, pcmBufferLen * sizeof(int16_t))) {
		[self setValue:[NSNumber numberWithBool:YES] forKey:@"stopped"];
		@throw [IOException exceptionWithReason:[NSString stringWithFormat:@"Unable to stat input file (%i:%s) [%s:%i]", errno, strerror(errno), __FILE__, __LINE__] userInfo:nil];
	}
	
	// Clean up
	free(pcmBuffer);
}

@end