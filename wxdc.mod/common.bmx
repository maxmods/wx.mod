' Copyright (c) 2007 Bruce A Henderson
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
Import wx.wxIcon
Import wx.wxBrush
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

	Function bmx_wxdc_clear(handle:Byte Ptr)
	Function bmx_wxdc_setbackground(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_wxdc_drawtext(handle:Byte Ptr, text:String, x:Int, y:Int)
	
	Function bmx_wxdc_getcharheight:Int(handle:Byte Ptr)
	Function bmx_wxdc_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxdc_settextbackground(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxdc_settextforeground(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxdc_gettextextent(handle:Byte Ptr, text:String, w:Int Ptr, h:Int Ptr)
	Function bmx_wxdc_setmapmode(handle:Byte Ptr, mode:Int)
	Function bmx_wxdc_setpen(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_wxdc_setuserscale(handle:Byte Ptr, xscale:Double, yscale:Double)
	Function bmx_wxdc_drawline(handle:Byte Ptr, x1:Int, y1:Int, x2:Int, y2:Int)
	Function bmx_wxdc_setbackgroundmode(handle:Byte Ptr, mode:Int)
	Function bmx_wxdc_setbrush(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_wxdc_setclippingregion(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxdc_setdeviceorigin(handle:Byte Ptr, x:Int, y:Int)
	
	Function bmx_wxdc_drawellipse(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxdc_drawrectangle(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxdc_drawroundedrectangle(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, radius:Double)

	Function wx_wxdc_calcboundingbox(handle:Byte Ptr, x:Int, y:Int)
	Function wx_wxdc_computescaleandorigin(handle:Byte Ptr)
	Function wx_wxdc_crosshair(handle:Byte Ptr, x:Int, y:Int)
	Function wx_wxdc_destroyclippingregion(handle:Byte Ptr)
	Function wx_wxdc_devicetologicalx:Int(handle:Byte Ptr, x:Int)
	Function wx_wxdc_devicetologicalxrel:Int(handle:Byte Ptr, x:Int)
	Function wx_wxdc_devicetologicaly:Int(handle:Byte Ptr, y:Int)
	Function wx_wxdc_devicetologicalyrel:Int(handle:Byte Ptr, y:Int)
	Function wx_wxdc_drawarc(handle:Byte Ptr, x1:Int, y1:Int, x2:Int, y2:Int, xc:Int, yc:Int)
	Function wx_wxdc_drawbitmap(handle:Byte Ptr, bitmap:Byte Ptr, x:Int, y:Int, transparent:Int)
	Function wx_wxdc_drawcheckmark(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function wx_wxdc_drawcircle(handle:Byte Ptr, x:Int, y:Int, radius:Int)
	

	Function bmx_wxmirrordc_create:Byte Ptr(dc:Byte Ptr, mirror:Int)
	
End Extern
