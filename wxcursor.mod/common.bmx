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
Import wx.wxBitmap
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

	Function bmx_wxcursor_stockcreate:Byte Ptr(id:Int)
	Function bmx_wxcursor_isok:Int(handle:Byte Ptr)
	Function bmx_wxcursor_createfromimage:Byte Ptr(image:Byte Ptr)
	
	Function bmx_wxstockgdi_cursor_cross:Byte Ptr()
	Function bmx_wxstockgdi_cursor_hourglass:Byte Ptr()
	Function bmx_wxstockgdi_cursor_standard:Byte Ptr()
	
	Function bmx_wxcursor_delete(handle:Byte Ptr)

	Function bmx_wxsetcursor(handle:Byte Ptr)
	
End Extern

Const wxCURSOR_NONE:Int = 0
Const wxCURSOR_ARROW:Int = 1
Const wxCURSOR_RIGHT_ARROW:Int = 2
Const wxCURSOR_BULLSEYE:Int = 3
Const wxCURSOR_CHAR:Int = 4
Const wxCURSOR_CROSS:Int = 5
Const wxCURSOR_HAND:Int = 6
Const wxCURSOR_IBEAM:Int = 7
Const wxCURSOR_LEFT_BUTTON:Int = 8
Const wxCURSOR_MAGNIFIER:Int = 9
Const wxCURSOR_MIDDLE_BUTTON:Int = 10
Const wxCURSOR_NO_ENTRY:Int = 11
Const wxCURSOR_PAINT_BRUSH:Int = 12
Const wxCURSOR_PENCIL:Int = 13
Const wxCURSOR_POINT_LEFT:Int = 14
Const wxCURSOR_POINT_RIGHT:Int = 15
Const wxCURSOR_QUESTION_ARROW:Int = 16
Const wxCURSOR_RIGHT_BUTTON:Int = 17
Const wxCURSOR_SIZENESW:Int = 18
Const wxCURSOR_SIZENS:Int = 19
Const wxCURSOR_SIZENWSE:Int = 20
Const wxCURSOR_SIZEWE:Int = 21
Const wxCURSOR_SIZING:Int = 22
Const wxCURSOR_SPRAYCAN:Int = 23
Const wxCURSOR_WAIT:Int = 24
Const wxCURSOR_WATCH:Int = 25
Const wxCURSOR_BLANK:Int = 26
?linux
Const wxCURSOR_DEFAULT:Int = 27
?macos
Const wxCURSOR_COPY_ARROW:Int = 27
Const wxCURSOR_ARROWWAIT:Int = 28
?linux
Const wxCURSOR_CROSS_REVERSE:Int = 27
Const wxCURSOR_DOUBLE_ARROW:Int = 28
Const wxCURSOR_BASED_ARROW_UP:Int = 29
Const wxCURSOR_BASED_ARROW_DOWN:Int = 30
Const wxCURSOR_ARROWWAIT:Int = 31
?win32
Const wxCURSOR_ARROWWAIT:Int = 27
?
