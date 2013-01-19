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
Import wx.wxWindow
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

	Function bmx_wxhelpcontrollerbase_initialize:Int(handle:Byte Ptr, file:String)

	Function bmx_wxhelpcontrollerbase_displayBlock:Int(handle:Byte Ptr, blockNo:Int)
	Function bmx_wxhelpcontrollerbase_displaycontextpopup:Int(handle:Byte Ptr, contextId:Int)
	Function bmx_wxhelpcontrollerbase_displaysection:Int(handle:Byte Ptr, sectionNo:Int)
	Function bmx_wxhelpcontrollerbase_displaysectionbyname:Int(handle:Byte Ptr, section:String)
	Function bmx_wxhelpcontrollerbase_displaytextpopup:Int(handle:Byte Ptr, text:String, x:Int, y:Int)
	Function bmx_wxhelpcontrollerbase_getparentwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhelpcontrollerbase_quit:Int(handle:Byte Ptr)

	Function bmx_wxhelpcontrollerbase_keywordsearch:Int(handle:Byte Ptr, keyword:String, mode:Int)
	Function bmx_wxhelpcontrollerbase_displaycontents(handle:Byte Ptr)

End Extern

Const wxHELP_NETSCAPE:Int = 1

Const wxHELP_SEARCH_INDEX:Int = 0
Const wxHELP_SEARCH_ALL:Int = 1


' This style indicates that the window is
' embedded in the application And must Not be
' destroyed by the help controller.
Const wxHF_EMBEDDED:Int = $00008000

' Create a dialog For the help window.
Const wxHF_DIALOG:Int = $00010000

' Create a frame For the help window.
Const wxHF_FRAME:Int = $00020000

' Make the dialog modal when displaying help.
Const wxHF_MODAL:Int = $00040000


Const wxHF_TOOLBAR:Int = $0001
Const wxHF_CONTENTS:Int = $0002
Const wxHF_INDEX:Int = $0004
Const wxHF_SEARCH:Int = $0008
Const wxHF_BOOKMARKS:Int = $0010
Const wxHF_OPEN_FILES:Int = $0020
Const wxHF_PRINT:Int = $0040
Const wxHF_FLAT_TOOLBAR:Int = $0080
Const wxHF_MERGE_BOOKS:Int = $0100
Const wxHF_ICONS_BOOK:Int = $0200
Const wxHF_ICONS_BOOK_CHAPTER:Int = $0400
Const wxHF_ICONS_FOLDER:Int = $0000 ' this is 0 since it is Default
Const wxHF_DEFAULT_STYLE:Int = wxHF_TOOLBAR | wxHF_CONTENTS | ..
	wxHF_INDEX | wxHF_SEARCH | wxHF_BOOKMARKS | wxHF_PRINT


