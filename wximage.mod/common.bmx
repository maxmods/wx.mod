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
Import wx.wxPalette
Import wx.wxStream
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

	Function bmx_wximage_createempty:Byte Ptr(width:Int, height:Int)
	Function bmx_wximage_create:Byte Ptr(name:String, flag:Int, index:Int)
	Function bmx_wximage_delete(handle:Byte Ptr)
	Function bmx_wximage_createnull:Byte Ptr()
	
	Function bmx_wximage_setrgb(handle:Byte Ptr, x:Int, y:Int, r:Int, g:Int, b:Int)
	Function bmx_wximage_rescale(handle:Byte Ptr, width:Int, height:Int, quality:Int)
	Function bmx_wximage_getwidth:Int(handle:Byte Ptr)
	Function bmx_wximage_resize(handle:Byte Ptr, width:Int, height:Int, x:Int, y:Int, red:Int, green:Int, blue:Int)
	Function bmx_wximage_rotate:Byte Ptr(handle:Byte Ptr, angle:Double, centreX:Int, centreY:Int, interpolating:Int, offsetX:Int Ptr, offsetY:Int Ptr)

	Function bmx_wximage_blur:Byte Ptr(handle:Byte Ptr, blurRadius:Int)
	Function bmx_wximage_blurhorizontal:Byte Ptr(handle:Byte Ptr, blurRadius:Int)
	Function bmx_wximage_blurvertical:Byte Ptr(handle:Byte Ptr, blurRadius:Int)
	Function bmx_wximage_convertalphatomask:Int(handle:Byte Ptr, threshold:Int)
	Function bmx_wximage_converttogreyscale:Byte Ptr(handle:Byte Ptr, lr:Double, lg:Double, lb:Double)
	Function bmx_wximage_converttomono:Byte Ptr(handle:Byte Ptr, r:Int, g:Int, b:Int)
	Function bmx_wximage_copy:Byte Ptr(handle:Byte Ptr)
	Function bmx_wximage_destroy(handle:Byte Ptr)
	Function bmx_wximage_findfirstunusedcolour:Int(handle:Byte Ptr, r:Int Ptr, g:Int Ptr, b:Int Ptr, startR:Int, startG:Int, startB:Int)
	Function bmx_wximage_getimageextwildcard:String()
	Function bmx_wximage_getalpha:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wximage_getblue:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wximage_getdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wximage_getgreen:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wximage_getheight:Int(handle:Byte Ptr)
	Function bmx_wximage_getmaskblue:Int(handle:Byte Ptr)
	Function bmx_wximage_getmaskgreen:Int(handle:Byte Ptr)
	Function bmx_wximage_getmaskred:Int(handle:Byte Ptr)
	Function bmx_wximage_getorfindmaskcolour:Int(handle:Byte Ptr, r:Int Ptr, g:Int Ptr, b:Int Ptr)
	Function bmx_wximage_getred:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wximage_getsubimage:Byte Ptr(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wximage_hasalpha:Int(handle:Byte Ptr)
	Function bmx_wximage_hasmask:Int(handle:Byte Ptr)
	Function bmx_wximage_getoption:String(handle:Byte Ptr, name:String)
	Function bmx_wximage_getoptionint:Int(handle:Byte Ptr, name:String)
	Function bmx_wximage_hasoption:Int(handle:Byte Ptr, name:String)
	Function bmx_wximage_initalpha(handle:Byte Ptr)
	Function bmx_wximage_inserthandler(handle:Byte Ptr)
	Function bmx_wximage_istransparent:Int(handle:Byte Ptr, x:Int, y:Int, threshold:Int)
	Function bmx_wximage_isok:Int(handle:Byte Ptr)
	Function bmx_wximage_removehandler:Int(name:String)

	Function bmx_wximage_mirror:Byte Ptr(handle:Byte Ptr, horizontally:Int)
	Function bmx_wximage_replace(handle:Byte Ptr, r1:Int, g1:Int, b1:Int, r2:Int, g2:Int, b2:Int)
	Function bmx_wximage_setrgbrange(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, red:Int, green:Int, blue:Int)
	Function bmx_wximage_setrgbrect(handle:Byte Ptr, rect:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wximage_setpalette(handle:Byte Ptr, palette:Byte Ptr)
	Function bmx_wximage_setoption(handle:Byte Ptr, name:String, value:String)
	Function bmx_wximage_setoptionint(handle:Byte Ptr, name:String, value:Int)
	Function bmx_wximage_setalpha(handle:Byte Ptr, x:Int, y:Int, alpha:Int)
	Function bmx_wximage_setdata(handle:Byte Ptr, data:Byte Ptr)
	Function bmx_wximage_setmask(handle:Byte Ptr, hasMask:Int)
	Function bmx_wximage_setmaskcolour(handle:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wximage_setmaskfromimage:Int(handle:Byte Ptr, mask:Byte Ptr, mr:Int, mg:Int, mb:Int)
	Function bmx_wximage_scale:Byte Ptr(handle:Byte Ptr, width:Int, height:Int, quality:Int)
	Function bmx_wximage_size:Byte Ptr(handle:Byte Ptr, width:Int, height:Int, x:Int, y:Int, red:Int, green:Int, blue:Int)
	Function bmx_wximage_rotatehue(handle:Byte Ptr, angle:Double)
	Function bmx_wximage_rotate90:Byte Ptr(handle:Byte Ptr, clockwise:Int)

	Function bmx_wximage_addhandler(handler:Byte Ptr)	
	Function bmx_wxpnghandler_create:Byte Ptr()
	Function bmx_wxxpmhandler_create:Byte Ptr()

	Function bmx_wximage_createfromstream:Byte Ptr(stream:Byte Ptr, kind:Int, index:Int)
	
	Function bmx_wximage_null:Byte Ptr()
End Extern


Const wxIMAGE_QUALITY_NORMAL:Int = 0
Const wxIMAGE_QUALITY_HIGH:Int = 1

Const wxIMAGE_RESOLUTION_INCHES:Int = 1
Const wxIMAGE_RESOLUTION_CM:Int = 2
