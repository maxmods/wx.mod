' Copyright (c) 2007,2008 Bruce A Henderson
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

	Function bmx_wxstatusbar_injectSelf(handle:Byte Ptr, obj:Object)
	
	Function bmx_wxstatusbar_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, style:Int)
	Function bmx_wxstatusbar_getfieldrect:Int(handle:Byte Ptr, index:Int, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxstatusbar_getfieldrectrect:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wxstatusbar_getfieldscount:Int(handle:Byte Ptr)
	Function bmx_wxstatusbar_getstatustext:String(handle:Byte Ptr, index:Int)
	Function bmx_wxstatusbar_popstatustext(handle:Byte Ptr, index:Int)
	Function bmx_wxstatusbar_pushstatustext(handle:Byte Ptr, text:String, index:Int)
	Function bmx_wxstatusbar_setfieldscount(handle:Byte Ptr, count:Int)
	Function bmx_wxstatusbar_setminheight(handle:Byte Ptr, height:Int)
	Function bmx_wxstatusbar_setstatustext(handle:Byte Ptr, text:String, index:Int)
	Function bmx_wxstatusbar_setstatuswidths(handle:Byte Ptr, widths:Int[])
	Function bmx_wxstatusbar_setstatusstyles(handle:Byte Ptr, styles:Int[])
	
	Function bmx_wxstatusbar_addresourcehandler()

End Extern

Const wxST_SIZEGRIP:Int = $0010

Const wxSB_NORMAL:Int = $0000
Const wxSB_FLAT:Int = $0001
Const wxSB_RAISED:Int = $0002


