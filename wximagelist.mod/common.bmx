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
Import wx.wxIcon
Import wx.wxDC
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

	Function bmx_wximagelist_create:Byte Ptr(handle:Object, width:Int, height:Int, mask:Int, initialCount:Int)
	Function bmx_wximagelist_add:Int(handle:Byte Ptr, bitmap:Byte Ptr, mask:Byte Ptr)
	Function bmx_wximagelist_delete(handle:Byte Ptr)
	Function bmx_wximagelist_addwithcolourmask:Int(handle:Byte Ptr, bitmap:Byte Ptr, maskColour:Byte Ptr)
	Function bmx_wximagelist_addicon:Int(handle:Byte Ptr, icon:Byte Ptr)

	Function bmx_wximagelist_getbitmap:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wximagelist_geticon:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wximagelist_getimagecount:Int(handle:Byte Ptr)
	Function bmx_wximagelist_getsize:Int(handle:Byte Ptr, index:Int, width:Int Ptr, height:Int Ptr)
	Function bmx_wximagelist_remove:Int(handle:Byte Ptr, index:Int)
	Function bmx_wximagelist_removeall:Int(handle:Byte Ptr)
	Function bmx_wximagelist_replace:Int(handle:Byte Ptr, index:Int, bitmap:Byte Ptr, mask:Byte Ptr)
	Function bmx_wximagelist_replaceicon:Int(handle:Byte Ptr, index:Int, icon:Byte Ptr)

	Function bmx_wximagelist_draw:Int(handle:Byte Ptr, index:Int, dc:Byte Ptr, x:Int, y:Int, flags:Int, solidBackground:Int)

End Extern
