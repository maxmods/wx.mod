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

	Function bmx_wxicon_create:Byte Ptr()
	Function bmx_wxicon_copyfrombitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxicon_createfromfile:Byte Ptr(name:String, kind:Int, desiredWidth:Int, desiredHeight:Int)
	Function bmx_wxicon_loadfile:Int(handle:Byte Ptr, name:String, kind:Int)
	Function bmx_wxicon_delete(handle:Byte Ptr)
	Function bmx_wxicon_null:Byte Ptr()

	Function bmx_wxicon_getdepth:Int(handle:Byte Ptr)
	Function bmx_wxicon_getheight:Int(handle:Byte Ptr)
	Function bmx_wxicon_getwidth:Int(handle:Byte Ptr)	
	Function bmx_wxicon_setdepth(handle:Byte Ptr, depth:Int)
	Function bmx_wxicon_setheight(handle:Byte Ptr, height:Int)
	Function bmx_wxicon_setwidth(handle:Byte Ptr, width:Int)
	
	Function bmx_wxicon_isok:Int(handle:Byte Ptr)

	Function bmx_iconbundle_create:Byte Ptr(filename:String, ftype:Int)
	Function bmx_wxiconbundle_createwithicon:Byte Ptr(icon:Byte Ptr)
	Function bmx_wxiconbundle_addicon(handle:Byte Ptr, file:String, ftype:Int)
	Function bmx_wxiconbundle_addiconicon(handle:Byte Ptr, icon:Byte Ptr)
	Function bmx_wxiconbundle_geticon:Byte Ptr(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxiconbundle_delete(handle:Byte Ptr)

End Extern
