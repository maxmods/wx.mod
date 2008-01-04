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

	Function bmx_wxstockgdi_brush_black:Byte Ptr()
	Function bmx_wxstockgdi_brush_blue:Byte Ptr()
	Function bmx_wxstockgdi_brush_cyan:Byte Ptr()
	Function bmx_wxstockgdi_brush_green:Byte Ptr()
	Function bmx_wxstockgdi_brush_grey:Byte Ptr()
	Function bmx_wxstockgdi_brush_lightgrey:Byte Ptr()
	Function bmx_wxstockgdi_brush_mediumgrey:Byte Ptr()
	Function bmx_wxstockgdi_brush_red:Byte Ptr()
	Function bmx_wxstockgdi_brush_transparent:Byte Ptr()
	Function bmx_wxstockgdi_brush_white:Byte Ptr()
	
	Function bmx_wxbrush_create:Byte Ptr(name:String, style:Int)
	Function bmx_wxbrush_delete(handle:Byte Ptr)
	
	Function bmx_wxbrush_createfromcolour:Byte Ptr(colour:Byte Ptr, style:Int)
	Function bmx_wxbrush_getcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxbrush_getstipple:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxbrush_getstyle:Int(handle:Byte Ptr)
	Function bmx_wxbrush_ishatch:Int(handle:Byte Ptr)
	Function bmx_wxbrush_isok:Int(handle:Byte Ptr)
	Function bmx_wxbrush_setcolour(handle:Byte Ptr, colour:String)
	Function bmx_wxbrush_setfromcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxbrush_setfromrgb(handle:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wxbrush_setstipple(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxbrush_setstyle(handle:Byte Ptr, style:Int)

End Extern


