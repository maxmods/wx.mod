' Copyright (c) 2007,2008 Bruce A Henderson & Oliver Skawronek
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

	Function bmx_wxgridbagsizer_create:Byte Ptr(handle:Object, vgap:Int, hgap:Int)
	Function bmx_wxgridbagsizer_add:Byte Ptr(handle:Byte Ptr, window:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addsizer:Byte Ptr(handle:Byte Ptr, sizer:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addspacer:Byte Ptr(handle:Byte Ptr, width:Int, height:Int, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addgbsizeritem:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxgridbagsizer_checkforintersection:Int(handle:Byte Ptr, item:Byte Ptr, excludeItem:Byte Ptr)
	Function bmx_wxgridbagsizer_checkforintersectionpos:Int(handle:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, excludeItem:Byte Ptr)
	Function bmx_wxgridbagsizer_getcellsize(handle:Byte Ptr, row:Int, col:Int, width:Int Ptr, height:Int Ptr)
	Function bmx_wxgridbagsizer_getemptycellsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxgridbagsizer_getitempositionwindow(handle:Byte Ptr, window:Byte Ptr, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitempositionsizer(handle:Byte Ptr, sizer:Byte Ptr, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitemposition(handle:Byte Ptr, index:Int, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspanwindow(handle:Byte Ptr, window:Byte Ptr, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspansizer(handle:Byte Ptr, sizer:Byte Ptr, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspan(handle:Byte Ptr, index:Int, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_setemptycellsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxgridbagsizer_setitempositionwindow:Int(handle:Byte Ptr, window:Byte Ptr, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitempositionsizer:Int(handle:Byte Ptr, sizer:Byte Ptr, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitemposition:Int(handle:Byte Ptr, index:Int, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitemspanwindow:Int(handle:Byte Ptr, window:Byte Ptr, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_setitemspansizer:Int(handle:Byte Ptr, sizer:Byte Ptr, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_setitemspan:Int(handle:Byte Ptr, index:Int, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_finditemwindow:Byte Ptr(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxgridbagsizer_finditemsizer:Byte Ptr(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxgridbagsizer_finditematpoint:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxgridbagsizer_finditematposition:Byte Ptr(handle:Byte Ptr, row:Int, col:Int)

End Extern
