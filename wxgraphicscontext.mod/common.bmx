' Copyright (c) 2007-2011 Bruce A Henderson
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
Import wx.wxPen
Import wx.wxBrush
Import wx.wxRegion
Import wx.wxWindow
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

	Function bmx_wxgraphicscontext_create:Byte Ptr(dc:Byte Ptr)
	Function bmx_wxgraphicscontext_createfromwindow:Byte Ptr(window:Byte Ptr)
	Function bmx_wxgraphicscontext_createpen:Byte Ptr(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_wxgraphicscontext_createbrush:Byte Ptr(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_wxgraphicscontext_createradialgradientbrush:Byte Ptr(handle:Byte Ptr, xo:Double, yo:Double, xc:Double, yc:Double, radius:Double, oColour:Byte Ptr, cColour:Byte Ptr)
	Function bmx_wxgraphicscontext_createlineargradientbrush:Byte Ptr(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, c1:Byte Ptr, c2:Byte Ptr)
	Function bmx_wxgraphicscontext_createfont:Byte Ptr(handle:Byte Ptr, font:Byte Ptr, col:Byte Ptr)
	Function bmx_wxgraphicscontext_creatematrix:Byte Ptr(handle:Byte Ptr, a:Double, b:Double, c:Double, d:Double, tx:Double, ty:Double)
	Function bmx_wxgraphicscontext_createpath:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgraphicscontext_clip(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicscontext_clipregion(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxgraphicscontext_resetclip(handle:Byte Ptr)
	Function bmx_wxgraphicscontext_drawbitmap(handle:Byte Ptr, bmp:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicscontext_drawellipse(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicscontext_drawicon(handle:Byte Ptr, icon:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicscontext_drawlines(handle:Byte Ptr, points:Double[], fillStyle:Int)
	Function bmx_wxgraphicscontext_drawpath(handle:Byte Ptr, path:Byte Ptr, fillStyle:Int)
	Function bmx_wxgraphicscontext_drawrectangle(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicscontext_drawroundedrectangle(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, radius:Double)
	Function bmx_wxgraphicscontext_drawtext(handle:Byte Ptr, text:String, x:Double, y:Double, angle:Double)
	Function bmx_wxgraphicscontext_fillpath(handle:Byte Ptr, path:Byte Ptr, fillStyle:Int)
	Function bmx_wxgraphicscontext_strokepath(handle:Byte Ptr, path:Byte Ptr)
	Function bmx_wxgraphicscontext_getnativecontext:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgraphicscontext_getpartialtextextents:Double[](handle:Byte Ptr, text:String)
	Function bmx_wxgraphicscontext_gettextextent(handle:Byte Ptr, text:String, width:Double Ptr, height:Double Ptr, descent:Double Ptr, externalLeading:Double Ptr)
	Function bmx_wxgraphicscontext_rotate(handle:Byte Ptr, angle:Double)
	Function bmx_wxgraphicscontext_scale(handle:Byte Ptr, xScale:Double, yScale:Double)
	Function bmx_wxgraphicscontext_translate(handle:Byte Ptr, dx:Double, dy:Double)
	Function bmx_wxgraphicscontext_gettransform:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgraphicscontext_settransform(handle:Byte Ptr, matrix:Byte Ptr)
	Function bmx_wxgraphicscontext_concattransform(handle:Byte Ptr, matrix:Byte Ptr)
	Function bmx_wxgraphicscontext_setbrush(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_wxgraphicscontext_setbrushnative(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_wxgraphicscontext_setfont(handle:Byte Ptr, font:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxgraphicscontext_setfontnative(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxgraphicscontext_setpen(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_wxgraphicscontext_setpennative(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_wxgraphicscontext_strokeline(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double)
	Function bmx_wxgraphicscontext_strokelines(handle:Byte Ptr, points:Double[])
	Function bmx_wxgraphicscontext_strokedisconnectedlines(handle:Byte Ptr, startPoints:Double[], endPoints:Double[])

	
	Function bmx_wxgraphicsfont_delete(handle:Byte Ptr)
	Function bmx_wxgraphicspen_delete(handle:Byte Ptr)
	Function bmx_wxgraphicsbrush_delete(handle:Byte Ptr)
	Function bmx_wxgraphicspath_delete(handle:Byte Ptr)
	Function bmx_wxgraphicsmatrix_delete(handle:Byte Ptr)

	Function bmx_wxgraphicsmatrix_concat(handle:Byte Ptr, t:Byte Ptr)
	Function bmx_wxgraphicsmatrix_get(handle:Byte Ptr, a:Double Ptr, b:Double Ptr, c:Double Ptr, d:Double Ptr, tx:Double Ptr, ty:Double Ptr)
	Function bmx_wxgraphicsmatrix_getnativematrix:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgraphicsmatrix_invert(handle:Byte Ptr)
	Function bmx_wxgraphicsmatrix_isequal:Int(handle:Byte Ptr, t:Byte Ptr)
	Function bmx_wxgraphicsmatrix_isidentity:Int(handle:Byte Ptr)
	Function bmx_wxgraphicsmatrix_rotate(handle:Byte Ptr, angle:Double)
	Function bmx_wxgraphicsmatrix_scale(handle:Byte Ptr, xScale:Double, yScale:Double)
	Function bmx_wxgraphicsmatrix_translate(handle:Byte Ptr, dx:Double, dy:Double)
	Function bmx_wxgraphicsmatrix_set(handle:Byte Ptr, a:Double, b:Double, c:Double, d:Double, tx:Double, ty:Double)
	Function bmx_wxgraphicsmatrix_transformpoint(handle:Byte Ptr, x:Double Ptr, y:Double Ptr)
	Function bmx_wxgraphicsmatrix_transformdistance(handle:Byte Ptr, dx:Double Ptr, dy:Double Ptr)

	Function bmx_wxgraphicspath_movetopoint(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxgraphicspath_addarc(handle:Byte Ptr, x:Double, y:Double, r:Double, startAngle:Double, endAngle:Double, clockwise:Int)
	Function bmx_wxgraphicspath_addarctopoint(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, radius:Double)
	Function bmx_wxgraphicspath_addcircle(handle:Byte Ptr, x:Double, y:Double, radius:Double)
	Function bmx_wxgraphicspath_addcurvetopoint(handle:Byte Ptr, cx1:Double, cy1:Double, cx2:Double, cy2:Double, x:Double, y:Double)
	Function bmx_wxgraphicspath_addellipse(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicspath_addlinetopoint(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxgraphicspath_addpath(handle:Byte Ptr, path:Byte Ptr)
	Function bmx_wxgraphicspath_addquadcurvetopoint(handle:Byte Ptr, cx:Double, cy:Double, x:Double, y:Double)
	Function bmx_wxgraphicspath_addrectangle(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_wxgraphicspath_addroundedrectangle(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, radius:Double)
	Function bmx_wxgraphicspath_closesubpath(handle:Byte Ptr)
	Function bmx_wxgraphicspath_contains:Int(handle:Byte Ptr, x:Double, y:Double, fillStyle:Int)
	Function bmx_wxgraphicspath_getbox(handle:Byte Ptr, x:Double Ptr, y:Double Ptr, w:Double Ptr, h:Double Ptr)
	Function bmx_wxgraphicspath_getcurrentpoint(handle:Byte Ptr, x:Double Ptr, y:Double Ptr)
	Function bmx_wxgraphicspath_transform(handle:Byte Ptr, matrix:Byte Ptr)
	Function bmx_wxgraphicspath_getnativepath:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgraphicspath_ungetnativepath(handle:Byte Ptr, path:Byte Ptr)

End Extern
