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
?linuxx86
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk2-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk2-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "src/*.h"
Import "src/knob.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxknob_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, value:Int, ..
		minValue:Int, maxValue:Int, minAngle:Int, maxAngle:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	
	Function bmx_wxknob_setrange(handle:Byte Ptr, minValue:Int, maxValue:Int)
	Function bmx_wxknob_getmin:Int(handle:Byte Ptr)
	Function bmx_wxknob_getmax:Int(handle:Byte Ptr)
	Function bmx_wxknob_setmin(handle:Byte Ptr, value:Int)
	Function bmx_wxknob_setmax(handle:Byte Ptr, value:Int)
	Function bmx_wxknob_getminangle:Int(handle:Byte Ptr)
	Function bmx_wxknob_getmaxangle:Int(handle:Byte Ptr)
	Function bmx_wxknob_getvalue:Int(handle:Byte Ptr)
	Function bmx_wxknob_setvalue(handle:Byte Ptr, value:Int)

End Extern
