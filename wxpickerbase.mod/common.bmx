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
Import wx.wxControl
Import wx.wxTextCtrl
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

	Function bmx_wxpickerbase_setinternalmargin(handle:Byte Ptr, margin:Int)
	Function bmx_wxpickerbase_getinternalmargin:Int(handle:Byte Ptr)
	Function bmx_wxpickerbase_settextctrlproportion(handle:Byte Ptr, prop:Int)
	Function bmx_wxpickerbase_setpickerctrlproportion(handle:Byte Ptr, prop:Int)
	Function bmx_wxpickerbase_gettextctrlproportion:Int(handle:Byte Ptr)
	Function bmx_wxpickerbase_getpickerctrlproportion:Int(handle:Byte Ptr)
	Function bmx_wxpickerbase_hastextctrl:Int(handle:Byte Ptr)
	Function bmx_wxpickerbase_gettextctrl:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpickerbase_istextctrlgrowable:Int(handle:Byte Ptr)
	Function bmx_wxpickerbase_setpickerctrlgrowable(handle:Byte Ptr, grow:Int)
	Function bmx_wxpickerbase_settextctrlgrowable(handle:Byte Ptr, grow:Int)
	Function bmx_wxpickerbase_ispickerctrlgrowable:Int(handle:Byte Ptr)

End Extern


Const wxPB_USE_TEXTCTRL:Int = $0002

