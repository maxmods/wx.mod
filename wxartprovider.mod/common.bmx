' Copyright (c) 2007-2013 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import wx.wx
Import wx.wxIcon
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "glue.cpp"

Extern

	Function bmx_wxartprovider_create:Byte Ptr(handle:Object)
	
	Function bmx_wxartprovider_getbitmap:Byte Ptr(id:String, client:String, w:Int, h:Int)
	Function bmx_wxartprovider_geticon:Byte Ptr(id:String, client:String, w:Int, h:Int)
	Function bmx_wxartprovider_getsizehint(client:String, platformDefault:Int, width:Int Ptr, height:Int Ptr)

	Function bmx_wxartprovider_deleteprovider:Int(provider:Byte Ptr)
	Function bmx_wxartprovider_insert(provider:Byte Ptr)
	Function bmx_wxartprovider_pop:Int()
	Function bmx_wxartprovider_push(provider:Byte Ptr)
	Function bmx_wxartprovider_remove:Int(provider:Byte Ptr)
	
End Extern

Const wxART_TOOLBAR:String = "wxART_TOOLBAR_C"
Const wxART_MENU:String = "wxART_MENU_C"
Const wxART_FRAME_ICON:String = "wxART_FRAME_ICON_C"
Const wxART_CMN_DIALOG:String = "wxART_CMN_DIALOG_C"
Const wxART_HELP_BROWSER:String = "wxART_HELP_BROWSER_C"
Const wxART_MESSAGE_BOX:String = "wxART_MESSAGE_BOX_C"
Const wxART_BUTTON:String = "wxART_BUTTON_C"
Const wxART_OTHER:String = "wxART_OTHER_C"

Const wxART_ADD_BOOKMARK:String = "wxART_ADD_BOOKMARK"
Const wxART_DEL_BOOKMARK:String = "wxART_DEL_BOOKMARK"
Const wxART_HELP_SIDE_PANEL:String = "wxART_HELP_SIDE_PANEL"
Const wxART_HELP_SETTINGS:String = "wxART_HELP_SETTINGS"
Const wxART_HELP_BOOK:String = "wxART_HELP_BOOK"
Const wxART_HELP_FOLDER:String = "wxART_HELP_FOLDER"
Const wxART_HELP_PAGE:String = "wxART_HELP_PAGE"
Const wxART_GO_BACK:String = "wxART_GO_BACK"
Const wxART_GO_FORWARD:String = "wxART_GO_FORWARD"
Const wxART_GO_UP:String = "wxART_GO_UP"
Const wxART_GO_DOWN:String = "wxART_GO_DOWN"
Const wxART_GO_TO_PARENT:String = "wxART_GO_TO_PARENT"
Const wxART_GO_HOME:String = "wxART_GO_HOME"
Const wxART_FILE_OPEN:String = "wxART_FILE_OPEN"
Const wxART_FILE_SAVE:String = "wxART_FILE_SAVE"
Const wxART_FILE_SAVE_AS:String = "wxART_FILE_SAVE_AS"
Const wxART_PRINT:String = "wxART_PRINT"
Const wxART_HELP:String = "wxART_HELP"
Const wxART_TIP:String = "wxART_TIP"
Const wxART_REPORT_VIEW:String = "wxART_REPORT_VIEW"
Const wxART_LIST_VIEW:String = "wxART_LIST_VIEW"
Const wxART_NEW_DIR:String = "wxART_NEW_DIR"
Const wxART_HARDDISK:String = "wxART_HARDDISK"
Const wxART_FLOPPY:String = "wxART_FLOPPY"
Const wxART_CDROM:String = "wxART_CDROM"
Const wxART_REMOVABLE:String = "wxART_REMOVABLE"
Const wxART_FOLDER:String = "wxART_FOLDER"
Const wxART_FOLDER_OPEN:String = "wxART_FOLDER_OPEN"
Const wxART_GO_DIR_UP:String = "wxART_GO_DIR_UP"
Const wxART_EXECUTABLE_FILE:String = "wxART_EXECUTABLE_FILE"
Const wxART_NORMAL_FILE:String = "wxART_NORMAL_FILE"
Const wxART_TICK_MARK:String = "wxART_TICK_MARK"
Const wxART_CROSS_MARK:String = "wxART_CROSS_MARK"
Const wxART_ERROR:String = "wxART_ERROR"
Const wxART_QUESTION:String = "wxART_QUESTION"
Const wxART_WARNING:String = "wxART_WARNING"
Const wxART_INFORMATION:String = "wxART_INFORMATION"
Const wxART_MISSING_IMAGE:String = "wxART_MISSING_IMAGE"
Const wxART_COPY:String = "wxART_COPY"
Const wxART_CUT:String = "wxART_CUT"
Const wxART_PASTE:String = "wxART_PASTE"
Const wxART_DELETE:String = "wxART_DELETE"
Const wxART_NEW:String = "wxART_NEW"
Const wxART_UNDO:String = "wxART_UNDO"
Const wxART_REDO:String = "wxART_REDO"
Const wxART_PLUS:String = "wxART_PLUS"
Const wxART_MINUS:String = "wxART_MINUS"
Const wxART_QUIT:String = "wxART_QUIT"
Const wxART_FIND:String = "wxART_FIND"
Const wxART_FIND_AND_REPLACE:String = "wxART_FIND_AND_REPLACE"
