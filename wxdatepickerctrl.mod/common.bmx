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
Import wx.wxDateTime
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

	Function bmx_wxdatepickerctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, dt:Byte Ptr, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxdatepickerctrl_getrange:Int(handle:Byte Ptr, dt1:Byte Ptr, dt2:Byte Ptr)
	Function bmx_wxdatepickerctrl_getvalue:Byte Ptr(handle:Byte Ptr)
'	Function bmx_wxdatepickerctrl_setformat(handle:Byte Ptr, format:String)
	Function bmx_wxdatepickerctrl_setrange(handle:Byte Ptr, dt1:Byte Ptr, dt2:Byte Ptr)
	Function bmx_wxdatepickerctrl_setvalue(handle:Byte Ptr, dt:Byte Ptr)

	Function bmx_wxdatepickerctrl_geteventtype:Int(evt:Int)
	
	Function bmx_wxdatepickerctrl_addresourcehandler()
	
End Extern

Const wxDP_DEFAULT:Int = 0
Const wxDP_SPIN:Int = 1
Const wxDP_DROPDOWN:Int = 2
Const wxDP_SHOWCENTURY:Int = 4
Const wxDP_ALLOWNONE:Int = 8

Const wxEVT_DATE_CHANGED:Int = 1101

