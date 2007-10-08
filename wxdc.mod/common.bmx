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
Import wx.wxPen
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
	Function bmx_wxdc_drawellipserect(handle:Byte Ptr, rect:Byte Ptr)
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
	Function wx_wxdc_drawcheckmarkrect(handle:Byte Ptr, rect:Byte Ptr)
	Function wx_wxdc_drawcircle(handle:Byte Ptr, x:Int, y:Int, radius:Int)
	
	Function bmx_wxdc_drawellipticarc(handle:Byte Ptr, x:Int, y:Int, width:Int, height:Int, _start:Double, _end:Double)
	Function bmx_wxdc_drawicon(handle:Byte Ptr, icon:Byte Ptr, x:Int, y:Int)
	Function bmx_wxdc_drawlabel(handle:Byte Ptr, text:String, x:Int, y:Int, w:Int, h:Int, image:Byte Ptr, alignment:Int, indexAccel:Int)
	Function bmx_wxdc_drawlabelrect(handle:Byte Ptr, text:String, rect:Byte Ptr, image:Byte Ptr, alignment:Int, indexAccel:Int)
	Function bmx_wxdc_drawlines(handle:Byte Ptr, points:Int[], xOffset:Int, yOffset:Int)
	Function bmx_wxdc_drawpolygon(handle:Byte Ptr, points:Int[], xOffset:Int, yOffset:Int, fillStyle:Int)
	Function bmx_wxdc_drawpoint(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxdc_drawrotatedtext(handle:Byte Ptr, text:String, x:Int, y:Int, angle:Double)
	Function bmx_wxdc_drawspline(handle:Byte Ptr, points:Int[])
	Function bmx_wxdc_enddoc(handle:Byte Ptr)
	Function bmx_wxdc_endpage(handle:Byte Ptr)
	Function bmx_wxdc_floodfill:Int(handle:Byte Ptr, x:Int, y:Int, colour:Byte Ptr, style:Int)
	Function bmx_wxdc_getbackground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_getbackgroundmode:Int(handle:Byte Ptr)
	Function bmx_wxdc_getbrush:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_getcharwidth:Int(handle:Byte Ptr)
	Function bmx_wxdc_getclippingbox(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxdc_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_getlayoutdirection:Int(handle:Byte Ptr)
	Function bmx_wxdc_getlogicalfunction:Int(handle:Byte Ptr)
	Function bmx_wxdc_getmapmode:Int(handle:Byte Ptr)

	Function bmx_wxdc_getmultilinetextextent(handle:Byte Ptr, text:String, width:Int Ptr, height:Int Ptr, heightline:Int Ptr)
	Function bmx_wxdc_getpartialtextextents:Int[](handle:Byte Ptr, text:String)
	Function bmx_wxdc_getpen:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_getpixel:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxdc_getppi(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxdc_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxdc_getsizemm(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxdc_gettextbackground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_gettextforeground:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdc_getuserscale(handle:Byte Ptr, x:Double Ptr, y:Double Ptr)
	Function bmx_wxdc_gradientfillconcentric(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, initialColour:Byte Ptr, destColour:Byte Ptr)
	Function bmx_wxdc_gradientfillconcentriccentre(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, initialColour:Byte Ptr, destColour:Byte Ptr, centreX:Int, centreY:Int)
	Function bmx_wxdc_gradientfilllinear(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, initialColour:Byte Ptr, destColour:Byte Ptr, direction:Int)
	Function bmx_wxdc_gradientfillconcentricrect(handle:Byte Ptr, rect:Byte Ptr, initialColour:Byte Ptr, destColour:Byte Ptr)
	Function bmx_wxdc_gradientfillconcentriccentrerect(handle:Byte Ptr, rect:Byte Ptr, initialColour:Byte Ptr, destColour:Byte Ptr, centreX:Int, centreY:Int)
	Function bmx_wxdc_gradientfilllinearrect(handle:Byte Ptr, rect:Byte Ptr, initialColour:Byte Ptr, destColour:Byte Ptr, direction:Int)
	Function bmx_wxdc_logicaltodevicex:Int(handle:Byte Ptr, x:Int)
	Function bmx_wxdc_logicaltodevicexrel:Int(handle:Byte Ptr, x:Int)
	Function bmx_wxdc_logicaltodevicey:Int(handle:Byte Ptr, y:Int)
	Function bmx_wxdc_logicaltodeviceyrel:Int(handle:Byte Ptr, y:Int)
	Function bmx_wxdc_maxx:Int(handle:Byte Ptr)
	Function bmx_wxdc_maxy:Int(handle:Byte Ptr)
	Function bmx_wxdc_minx:Int(handle:Byte Ptr)
	Function bmx_wxdc_miny:Int(handle:Byte Ptr)
	Function bmx_wxdc_isok:Int(handle:Byte Ptr)
	Function bmx_wxdc_resetboundingbox(handle:Byte Ptr)
	Function bmx_wxdc_setaxisorientation(handle:Byte Ptr, leftRight:Int, topBottom:Int)
	Function bmx_wxdc_setlayoutdirection(handle:Byte Ptr, dir:Int)
	Function bmx_wxdc_setlogicalfunction(handle:Byte Ptr, func:Int)
	Function bmx_wxdc_setpalette(handle:Byte Ptr, palette:Byte Ptr)
	Function bmx_wxdc_startdoc(handle:Byte Ptr, message:String)
	Function bmx_wxdc_startpage(handle:Byte Ptr)


	Function bmx_wxmirrordc_create:Byte Ptr(dc:Byte Ptr, mirror:Int)

	Function bmx_wxclientdc_create:Byte Ptr(window:Byte Ptr)
	Function bmx_wxclientdc_delete(handle:Byte Ptr)

End Extern



Const wxCLEAR:Int = 0
Const wxXOR:Int = 1
Const wxINVERT:Int = 2
Const wxOR_REVERSE:Int = 3
Const wxAND_REVERSE:Int = 4
Const wxCOPY:Int = 5
Const wxAND:Int = 6
Const wxAND_INVERT:Int = 7
Const wxNO_OP:Int = 8
Const wxNOR:Int = 9
Const wxEQUIV:Int = 10
Const wxSRC_INVERT:Int = 11
Const wxOR_INVERT:Int = 12
Const wxNAND:Int = 13
Const wxOR:Int = 14
Const wxSET:Int = 15

Const wxFLOOD_SURFACE:Int = 1
Const wxFLOOD_BORDER:Int = 2

Const wxODDEVEN_RULE:Int = 1
Const wxWINDING_RULE:Int = 2
