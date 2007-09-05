' Copyright (c) 2007 Bruce A Henderson
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
Import wx.wxControlWithItems
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

	Function bmx_wxlistbox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, choices:String[], x:Int, y:Int, w:Int, h:Int, style:Int)
	
	Function bmx_wxlistbox_insertitems(handle:Byte Ptr, items:String[], pos:Int)
	Function bmx_wxlistbox_getselections:Int[](handle:Byte Ptr)
	
	Function bmx_wxlistbox_isselected:Int(handle:Byte Ptr, item:Int)
	Function bmx_wxlistbox_deselect(handle:Byte Ptr, item:Int)
	Function bmx_wxlistbox_hittest:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxlistbox_setfirstitem(handle:Byte Ptr, item:Int)
	Function bmx_wxlistbox_setfirstitemstr(handle:Byte Ptr, item:String)
	
	Function bmx_wxlistbox_geteventtype:Int(evt:Int)
	
End Extern


' Styles For wxListBox
Const wxLB_SORT:Int = $0010
Const wxLB_SINGLE:Int = $0020
Const wxLB_MULTIPLE:Int = $0040
Const wxLB_EXTENDED:Int = $0080
'  wxLB_OWNERDRAW is Windows-only */
Const wxLB_OWNERDRAW:Int = $0100
Const wxLB_NEEDED_SB:Int = $0200
Const wxLB_ALWAYS_SB:Int = $0400
Const wxLB_HSCROLL:Int = wxHSCROLL
'  always show an entire number of rows */
Const wxLB_INT_HEIGHT:Int = $0800
