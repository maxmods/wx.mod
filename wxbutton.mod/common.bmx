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
Import wx.wxControl
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

	Function bmx_wxbutton_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, label:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxbutton_getlabel:String(handle:Byte Ptr)
	Function bmx_wxbutton_getdefaultsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxbutton_setdefault(handle:Byte Ptr)
	Function bmx_wxbutton_setlabel(handle:Byte Ptr, label:String)
	
	Function bmx_wxbutton_geteventtype:Int(evt:Int)
	
	Function bmx_wxbutton_addresourcehandler()
End Extern


Const wxEVT_COMMAND_BUTTON_CLICKED:Int = 1

Const wxBU_LEFT:Int = $0040
Const wxBU_TOP:Int = $0080
Const wxBU_RIGHT:Int = $0100
Const wxBU_BOTTOM:Int = $0200
Const wxBU_ALIGN_MASK:Int = wxBU_LEFT | wxBU_TOP | wxBU_RIGHT | wxBU_BOTTOM


Const wxBU_NOAUTODRAW:Int = $0000
Const wxBU_AUTODRAW:Int = $0004

Const wxBU_EXACTFIT:Int = $0001

