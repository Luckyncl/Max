FasdUAS 1.101.10   ��   ��    k             l      �� ��   ��
	Library Auto Sorting Folder Action.
	----------------------------------
	
	By Diggory Laycock - http://www.monkeyfood.com
	
	 
	  This script is a folder action script designed to be used on any of the Library folders on Mac OS X  (except the /System/Library ) 
	  Its aim is to re-create the Classic OS's Finder's System Folder autosorting.
	  
	  We have to create a 'record' for every type that we wish to sort.
	  
	  To use the script:
	  1 -  copy it to the 'Folder Action Scripts' directory of the 'scripts' directory of one of your libraries.
	  2 -  Connect the script to your Libraries.  
	  		- Right click the Library folder and choose 'Attach a folder Action' 
			- Choose this script.

       	  l     ������  ��   	  
  
 l     ������  ��        j     	�� �� 0 saverrecord SaverRecord  K        ��  �� 0 	extension    m        saver     ��  
�� 
dscr  m        Screen Saver     �� ���� 0 	directory    m        Screen Savers   ��        j   
 �� ��  0 prefpanerecord prefpaneRecord  K   
    ��  �� 0 	extension    m        prefpane     ��   
�� 
dscr  m     ! !  System Preference Pane      �� "���� 0 	directory   " m     # #  preferencePanes   ��     $ % $ j    �� &�� 0 scriptrecord scriptRecord & K     ' ' �� ( )�� 0 	extension   ( m     * * 
 scpt    ) �� + ,
�� 
dscr + m     - -  Compiled AppleScript    , �� .���� 0 	directory   . m     / /  scripts   ��   %  0 1 0 j    -�� 2�� 0 servicerecord serviceRecord 2 K    , 3 3 �� 4 5�� 0 	extension   4 m    " 6 6  service    5 �� 7 8
�� 
dscr 7 m   # & 9 9  System Service    8 �� :���� 0 	directory   : m   ' * ; ;  services   ��   1  < = < j   . =�� >�� "0 frameworkrecord frameworkRecord > K   . < ? ? �� @ A�� 0 	extension   @ m   / 2 B B  	framework    A �� C D
�� 
dscr C m   3 6 E E  	Framework    D �� F���� 0 	directory   F m   7 : G G  
frameworks   ��   =  H I H j   > M�� J�� 20 scriptingadditionrecord scriptingAdditionRecord J K   > L K K �� L M�� 0 	extension   L m   ? B N N 
 osax    M �� O P
�� 
dscr O m   C F Q Q  Scripting Addition    P �� R���� 0 	directory   R m   G J S S  ScriptingAdditions   ��   I  T U T j   N ]�� V�� "0 aiffsoundrecord aiffSoundRecord V K   N \ W W �� X Y�� 0 	extension   X m   O R Z Z 
 aiff    Y �� [ \
�� 
dscr [ m   S V ] ]  Macintosh Sound    \ �� ^���� 0 	directory   ^ m   W Z _ _  Sounds   ��   U  ` a ` j   ^ m�� b�� $0 aiffsound2record aiffSound2Record b K   ^ l c c �� d e�� 0 	extension   d m   _ b f f 	 aif    e �� g h
�� 
dscr g m   c f i i  Macintosh Sound    h �� j���� 0 	directory   j m   g j k k  Sounds   ��   a  l m l j   n }�� n�� 0 ttffontrecord ttfFontRecord n K   n | o o �� p q�� 0 	extension   p m   o r r r 	 ttf    q �� s t
�� 
dscr s m   s v u u  TrueType Font    t �� v���� 0 	directory   v m   w z w w  Fonts   ��   m  x y x j   ~ ��� z�� 0 dfontrecord dFontRecord z K   ~ � { { �� | }�� 0 	extension   | m    � ~ ~  dfont    } ��  �
�� 
dscr  m   � � � �  dFont    � �� ����� 0 	directory   � m   � � � �  Fonts   ��   y  � � � j   � ��� ��� 0 otffontrecord otfFontRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 	 otf    � �� � �
�� 
dscr � m   � � � �  otFont    � �� ����� 0 	directory   � m   � � � �  Fonts   ��   �  � � � j   � ��� ��� 0 	kthrecord 	kthRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 	 kth    � �� � �
�� 
dscr � m   � � � �  Keynote Theme    � �� ����� 0 	directory   � m   � � � � ( "Application Support:Keynote:Themes   ��   �  � � � j   � ��� ��� "0 colorsyncrecord colorSyncRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 	 icc    � �� � �
�� 
dscr � m   � � � �  ColorSync Profile    � �� ����� 0 	directory   � m   � � � �  ColorSync:Profiles   ��   �  � � � j   � ��� ��� 60 applicationenhancerrecord applicationEnhancerRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 	 ape    � �� � �
�� 
dscr � m   � � � � ! Application Enhancer Module    � �� ����� 0 	directory   � m   � � � �  Application Enhancers   ��   �  � � � j   � ��� ���  0 terminalrecord terminalRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 
 term    � �� � �
�� 
dscr � m   � � � �  Terminal Saved Windows    � �� ����� 0 	directory   � m   � � � � " Application Support:Terminal   ��   �  � � � j   � ��� ��� 0 widgetrecord widgetRecord � K   � � � � �� � ��� 0 	extension   � m   � � � � 
 wdgt    � �� � �
�� 
dscr � m   � � � �  Dashboard Widget    � �� ����� 0 	directory   � m   � � � � ! Application Support:Widgets   ��   �  � � � l     ������  ��   �  � � � l     �� ���   �  		********    �  � � � l     �� ���   � Q K	if you add a new record - don't forget to add it to the validRecords list:    �  � � � l     ������  ��   �  � � � j   ��� ��� 0 validrecords validRecords � J   � � �  � � � o   � ����� 0 saverrecord SaverRecord �  � � � o   � �����  0 prefpanerecord prefpaneRecord �  � � � o   � ����� 0 scriptrecord scriptRecord �  � � � o   � ����� 0 servicerecord serviceRecord �  � � � o   � ����� "0 frameworkrecord frameworkRecord �  � � � o   � ����� 20 scriptingadditionrecord scriptingAdditionRecord �  � � � o   � ����� "0 aiffsoundrecord aiffSoundRecord �  � � � o   � ����� 0 ttffontrecord ttfFontRecord �  � � � o   � ����� 0 dfontrecord dFontRecord �  � � � o   � ����� 0 otffontrecord otfFontRecord �  � � � o   � ����� 0 	kthrecord 	kthRecord �  � � � o   � ����� "0 colorsyncrecord colorSyncRecord �  � � � o   � ����� 60 applicationenhancerrecord applicationEnhancerRecord �  � � � o   � �����  0 terminalrecord terminalRecord �  ��� � o   � ����� 0 widgetrecord widgetRecord��   �  � � � l     ������  ��   �  � � � l     �� ���   � F @The handler for responding to when items are added to a folder:     �  � � � l     ������  ��   �  ��� � i   �  � I     ��
�� .facofgetnull���     alis o      ���� 0 targetfolder TargetFolder ����
�� 
flst o      ���� 0 droppeditems DroppedItems��    k     �  l     ������  ��    l     ��	��  	 5 /	set targetFolderAlias to targetFolder as alias    
��
 X     ��� k    �  l   ������  ��    O    ( k    '  r     l   �� n     1    �
� 
pnam o    �~�~ 0 targetfolder TargetFolder��   o      �}�} $0 targetfoldername targetFolderName  r     l    �|  n    !"! 1    �{
�{ 
pnam" o    �z�z 0 currentfile currentFile�|   o      �y�y "0 droppedfilename droppedFileName #�x# r     '$%$ I    %�w&�v
�w .sysonfo4asfe       ****& o     !�u�u 0 currentfile currentFile�v  % o      �t�t "0 droppedfileinfo droppedFileInfo�x   m    ''�null     ߷��  

Finder.app�ˠ    �%���(����    {�8   )       �(�$������|MACS  alis    b  WideBoy                    ��.1H+    

Finder.app                                                       2����        ����  	                CoreServices    ��.1      ���      
  
  
  .WideBoy:System:Library:CoreServices:Finder.app   
 F i n d e r . a p p    W i d e B o y  &System/Library/CoreServices/Finder.app  / ��   ()( l  ) )�s�r�s  �r  ) *+* X   ) �,�q-, Z   = �./�p�o. =  = D010 n   = @232 o   > @�n�n 0 	extension  3 o   = >�m�m 0 currentrecord currentRecord1 l  @ C4�l4 n   @ C565 1   A C�k
�k 
nmxt6 o   @ A�j�j "0 droppedfileinfo droppedFileInfo�l  / k   G �77 898 l  G G�i�h�i  �h  9 :;: O   G �<=< k   K �>> ?@? r   K UABA l  K SC�gC n   K SDED 5   L S�fF�e
�f 
cfolF l  M QG�dG n   M QHIH o   N P�c�c 0 	directory  I o   M N�b�b 0 currentrecord currentRecord�d  
�e kfrmnameE o   K L�a�a 0 targetfolder TargetFolder�g  B o      �`�` "0 newtargetfolder newTargetFolder@ J�_J Z   V �KL�^MK I  V [�]N�\
�] .coredoexbool        obj N o   V W�[�[ "0 newtargetfolder newTargetFolder�\  L l  ^ �OPO k   ^ �QQ RSR I  ^ e�ZTU
�Z .coremoveobj        obj T o   ^ _�Y�Y 0 currentfile currentFileU �XV�W
�X 
inshV o   ` a�V�V "0 newtargetfolder newTargetFolder�W  S WXW r   f sYZY b   f q[\[ b   f m]^] b   f i_`_ o   f g�U�U $0 targetfoldername targetFolderName` m   g haa   has auto-sorted a    ^ n   i lbcb 1   j l�T
�T 
dscrc o   i j�S�S 0 currentrecord currentRecord\ m   m pdd  .   Z o      �R�R $0 notificationtext notificationTextX efe l  t t�Qg�Q  g ` Zdisplay dialog notificationText buttons {"�"} default button 1 giving up after 3 --seconds   f hih l  t t�P�O�P  �O  i j�Nj O   t �klk k   z �mm non l  z z�Mp�M  p j d							notify title "Sorted" description notificationText icon of application "Finder.app" sticky no   o qrq l  z z�L�K�L  �K  r sts r   z �uvu J   z ww x�Jx m   z }yy  libraryFileSorted   �J  v o      �I�I  0 myallnoteslist myAllNotesListt z{z I  � ��H�G|
�H .registernull��� ��� null�G  | �F}~
�F 
appl} m   � � + %Library AutoSorter folderActionScript   ~ �E��
�E 
anot� o   � ��D�D  0 myallnoteslist myAllNotesList� �C��
�C 
dnot� o   � ��B�B  0 myallnoteslist myAllNotesList� �A��@
�A 
iapp� m   � ���  Finder   �@  { ��� l  � ��?�>�?  �>  � ��� I  � ��=�<�
�= .notifygrnull��� ��� null�<  � �;��
�; 
name� m   � ���  libraryFileSorted   � �:��
�: 
titl� m   � ���  Sorted   � �9��
�9 
desc� o   � ��8�8 $0 notificationtext notificationText� �7��6
�7 
appl� m   � ��� + %Library AutoSorter folderActionScript   �6  � ��� l  � ��5�4�5  �4  � ��3� l  � ��2�1�2  �1  �3  l m   t w��Lnull     ߀�� y��GrowlHelperApp.app%���(���@   Z{��   )       �(�$�����p|GRRR   alis    �  WideBoy                    ��.1H+   y��GrowlHelperApp.app                                              y�پ���        ����  	                	Resources     ��.1      ����     y�� y�� y�� +m �� ��  |  bWideBoy:Users:diggory:Library:PreferencePanes:Growl.prefPane:Contents:Resources:GrowlHelperApp.app  &  G r o w l H e l p e r A p p . a p p    W i d e B o y  ZUsers/diggory/Library/PreferencePanes/Growl.prefPane/Contents/Resources/GrowlHelperApp.app  /    ��  �N  P . ( not sure about validity of this line...   �^  M I  � ��0��
�0 .sysodlogaskr        TEXT� m   � ���  the folder isn't there!   � �/��.
�/ 
btns� J   � ��� ��-� m   � ���  OK   �-  �.  �_  = m   G H'; ��,� l  � ��+�*�+  �*  �,  �p  �o  �q 0 currentrecord currentRecord- o   , 1�)�) 0 validrecords validRecords+ ��(� l  � ��'�&�'  �&  �(  �� 0 currentfile currentFile o    �%�% 0 droppeditems DroppedItems��  ��       �$��������������������$  � �#�"�!� ���������������# 0 saverrecord SaverRecord�"  0 prefpanerecord prefpaneRecord�! 0 scriptrecord scriptRecord�  0 servicerecord serviceRecord� "0 frameworkrecord frameworkRecord� 20 scriptingadditionrecord scriptingAdditionRecord� "0 aiffsoundrecord aiffSoundRecord� $0 aiffsound2record aiffSound2Record� 0 ttffontrecord ttfFontRecord� 0 dfontrecord dFontRecord� 0 otffontrecord otfFontRecord� 0 	kthrecord 	kthRecord� "0 colorsyncrecord colorSyncRecord� 60 applicationenhancerrecord applicationEnhancerRecord�  0 terminalrecord terminalRecord� 0 widgetrecord widgetRecord� 0 validrecords validRecords
� .facofgetnull���     alis� � �� 0 	extension  � � �
� 
dscr� � �� 0 	directory  �  � � �� 0 	extension  � � !�
� 
dscr� � #�
� 0 	directory  �
  � �	 *��	 0 	extension  � � -�
� 
dscr� � /�� 0 	directory  �  � � 6�� 0 	extension  � � 9�
� 
dscr� � ;�� 0 	directory  �  � � B�� 0 	extension  � �  E�
�  
dscr� �� G���� 0 	directory  ��  � �� N��� 0 	extension  � �� Q�
�� 
dscr� �� S���� 0 	directory  ��  � �� Z��� 0 	extension  � �� ]�
�� 
dscr� �� _���� 0 	directory  ��  � �� f��� 0 	extension  � �� i�
�� 
dscr� �� k���� 0 	directory  ��  � �� r��� 0 	extension  � �� u�
�� 
dscr� �� w���� 0 	directory  ��  � �� ~��� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � �� ���� 0 	extension  � �� ��
�� 
dscr� �� ����� 0 	directory  ��  � ����� �  ���������������� �� ��������
�� .facofgetnull���     alis�� 0 targetfolder TargetFolder�� ������
�� 
flst�� 0 droppeditems DroppedItems��  � 
���������������������� 0 targetfolder TargetFolder�� 0 droppeditems DroppedItems�� 0 currentfile currentFile�� $0 targetfoldername targetFolderName�� "0 droppedfilename droppedFileName�� "0 droppedfileinfo droppedFileInfo�� 0 currentrecord currentRecord�� "0 newtargetfolder newTargetFolder�� $0 notificationtext notificationText��  0 myallnoteslist myAllNotesList� &������'��������������������a��d�y������������������������������
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pnam
�� .sysonfo4asfe       ****�� 0 	extension  
�� 
nmxt
�� 
cfol�� 0 	directory  
�� kfrmname
�� .coredoexbool        obj 
�� 
insh
�� .coremoveobj        obj 
�� 
dscr
�� 
appl
�� 
anot
�� 
dnot
�� 
iapp�� 
�� .registernull��� ��� null
�� 
name
�� 
titl
�� 
desc
�� .notifygrnull��� ��� null
�� 
btns
�� .sysodlogaskr        TEXT�� � �[��l kh � ��,E�O��,E�O�j E�UO �b  [��l kh ��,��,  �� ����,E�0E�O�j  e��l O��%��,%a %E�Oa  Ea kvE�O*a a a �a �a a a  O*a a a a a �a a  a  !OPUY a "a #a $kvl %UOPY h[OY�`OP[OY�, ascr  ��ޭ