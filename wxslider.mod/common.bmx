' Copyright (c) 2007-2015 Bruce A Henderson
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

	Function bmx_wxslider_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, value:Int, minValue:Int, maxValue:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxslider_getlinesize:Int(handle:Byte Ptr)
	Function bmx_wxslider_getmax:Int(handle:Byte Ptr)
	Function bmx_wxslider_getmin:Int(handle:Byte Ptr)
	Function bmx_wxslider_getpagesize:Int(handle:Byte Ptr)
	Function bmx_wxslider_getvalue:Int(handle:Byte Ptr)
	Function bmx_wxslider_setlinesize(handle:Byte Ptr, size:Int)
	Function bmx_wxslider_setpagesize(handle:Byte Ptr, size:Int)
	Function bmx_wxslider_setrange(handle:Byte Ptr, minValue:Int, maxValue:Int)
	Function bmx_wxslider_setvalue(handle:Byte Ptr, value:Int)

	Function bmx_wxslider_addresourcehandler()

End Extern


Const wxSL_HORIZONTAL:Int = wxHORIZONTAL ' $0004 */
Const wxSL_VERTICAL:Int = wxVERTICAL   ' $0008 */

Const wxSL_TICKS:Int = $0010
Const wxSL_AUTOTICKS:Int = wxSL_TICKS ' we don't support manual ticks
Const wxSL_LABELS:Int = $0020
Const wxSL_LEFT:Int = $0040
Const wxSL_TOP:Int = $0080
Const wxSL_RIGHT:Int = $0100
Const wxSL_BOTTOM:Int = $0200
Const wxSL_BOTH:Int = $0400
Const wxSL_SELRANGE:Int = $0800
Const wxSL_INVERSE:Int = $1000

