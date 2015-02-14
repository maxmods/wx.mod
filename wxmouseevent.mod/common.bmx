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
Import wx.wxDC
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

Import "glue.cpp"

Extern

	Function bmx_wxmouseevent_altdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_button:Int(event:Byte Ptr, but:Int)
	Function bmx_wxmouseevent_buttondclick:Int(event:Byte Ptr, but:Int)
	Function bmx_wxmouseevent_buttondown:Int(event:Byte Ptr, but:Int)
	Function bmx_wxmouseevent_buttonup:Int(event:Byte Ptr, but:Int)
	Function bmx_wxmouseevent_cmddown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_controldown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_dragging:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_entering:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getbutton:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getposition(event:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxmouseevent_getlinesperaction:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getwheelrotation:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getwheeldelta:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getx:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_gety:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_isbutton:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_ispagescroll:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_leaving:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_leftdclick:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_leftdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_leftisdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_leftup:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_metadown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_middledclick:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_middledown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_middleisdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_middleup:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_moving:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_rightdclick:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_rightdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_rightisdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_rightup:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_shiftdown:Int(event:Byte Ptr)
	Function bmx_wxmouseevent_getlogicalposition(event:Byte Ptr, dc:Byte Ptr, x:Int Ptr, y:Int Ptr)

End Extern


