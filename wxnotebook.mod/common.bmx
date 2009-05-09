' Copyright (c) 2007-2009 Bruce A Henderson
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
Import wx.wxBookCtrlBase
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

	Function bmx_wxnotebook_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxnotebook_getrowcount:Int(handle:Byte Ptr)
	Function bmx_wxnotebook_getthemebackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxnotebook_setpadding(handle:Byte Ptr, width:Int, height:Int)
	
	Function bmx_wxnotebook_addresourcehandler()

End Extern


Const wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED:Int = 802
Const wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING:Int = 803


Const wxNB_FIXEDWIDTH:Int = $0100
Const wxNB_MULTILINE:Int = $0200
Const wxNB_NOPAGETHEME:Int = $0400
Const wxNB_FLAT:Int = $0800

Const wxNB_HITTEST_NOWHERE:Int = wxBK_HITTEST_NOWHERE
Const wxNB_HITTEST_ONICON:Int = wxBK_HITTEST_ONICON
Const wxNB_HITTEST_ONLABEL:Int = wxBK_HITTEST_ONLABEL
Const wxNB_HITTEST_ONITEM:Int = wxBK_HITTEST_ONITEM
Const wxNB_HITTEST_ONPAGE:Int = wxBK_HITTEST_ONPAGE

Const wxNB_DEFAULT:Int = wxBK_DEFAULT
Const wxNB_TOP:Int = wxBK_TOP
Const wxNB_BOTTOM:Int = wxBK_BOTTOM
Const wxNB_LEFT:Int = wxBK_LEFT
Const wxNB_RIGHT:Int = wxBK_RIGHT
