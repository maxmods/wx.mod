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

	Function bmx_wxregion_create:Byte Ptr(x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxregion_createwithrect:Byte Ptr(rect:Byte Ptr)
	Function bmx_wxregion_createwithpoints:Byte Ptr(points:Int[], fillStyle:Int)
	Function bmx_wxregion_createwithbitmap:Byte Ptr(bmp:Byte Ptr, colour:Byte Ptr, tolerance:Int)
	Function bmx_wxregion_clear(handle:Byte Ptr)
	Function bmx_wxregion_contains:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxregion_containsrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxregion_converttobitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxregion_getbox(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxregion_getboxrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxregion_intersect:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxregion_intersectrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxregion_intersectregion:Int(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxregion_isempty:Int(handle:Byte Ptr)
	Function bmx_wxregion_isequal:Int(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxregion_subtract:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxregion_subtractrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxregion_subtractregion:Int(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxregion_offset:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxregion_union:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxregion_unionrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxregion_unionregion:Int(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxregion_unionbitmap:Int(handle:Byte Ptr, bmp:Byte Ptr)
	Function bmx_wxregion_xor:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxregion_xorrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxregion_xorregion:Int(handle:Byte Ptr, region:Byte Ptr)
	Function bmx_wxregion_delete(handle:Byte Ptr)

End Extern


Const wxOutRegion:Int = 0
Const wxPartRegion:Int = 1
Const wxInRegion:Int = 2


Const wxRGN_AND:Int = 0
Const wxRGN_COPY:Int = 1
Const wxRGN_DIFF:Int = 2
Const wxRGN_OR:Int = 3
Const wxRGN_XOR:Int = 4
