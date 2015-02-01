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
Import wx.wxImage
Import wx.wxPalette
Import BRL.Blitz
Import BRL.Pixmap


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
	Function bmx_wxbitmap_create:Byte Ptr(makeNull:Int)
	Function bmx_wxbitmap_delete(handle:Byte Ptr)

	Function bmx_wxbitmap_createfromimage:Byte Ptr(image:Byte Ptr, depth:Int)
	Function bmx_wxbitmap_createempty:Byte Ptr(width:Int, height:Int, depth:Int)
	Function bmx_wxbitmap_createfromfile:Byte Ptr(name:String, flag:Int)
	
	Function bmx_wxbitmap_loadfile:Int(handle:Byte Ptr, name:String, kind:Int)
	Function bmx_wxbitmap_converttoimage:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxbitmap_getdepth:Int(handle:Byte Ptr)
	Function bmx_wxbitmap_getheight:Int(handle:Byte Ptr)
	Function bmx_wxbitmap_getwidth:Int(handle:Byte Ptr)	
	Function bmx_wxbitmap_setdepth(handle:Byte Ptr, depth:Int)
	Function bmx_wxbitmap_setheight(handle:Byte Ptr, height:Int)
	Function bmx_wxbitmap_setwidth(handle:Byte Ptr, width:Int)
	
	Function bmx_wxbitmap_getpalette:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxbitmap_setpalette(handle:Byte Ptr, palette:Byte Ptr)
	
	Function bmx_wxbitmap_getsubbitmap:Byte Ptr(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxbitmap_getsubbitmaprect:Byte Ptr(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxbitmap_getmask:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxbitmap_setmask(handle:Byte Ptr, mask:Byte Ptr)
	
	Function bmx_wxbitmap_isok:Int(handle:Byte Ptr)

	Function bmx_wxmask_create:Byte Ptr(bitmap:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxmask_delete(handle:Byte Ptr)

	Function bmx_wxbitmap_createfrompixmap:Byte Ptr(pixels:Byte Ptr, width:Int, height:Int, pitch:Int, bytesPerPixel:Int, bitsPerPixel:Int)

	Function bmx_wxbitmap_colourize(bitmap:Byte Ptr, colour:Byte Ptr)

	Function bmx_wxbitmap_savefile:Int(handle:Byte Ptr, name:String, kind:Int, palette:Byte Ptr)

End Extern
