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
Import wx.wxDialog
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

	Function bmx_wxgetfontfromuser:Byte Ptr(parent:Byte Ptr, font:Byte Ptr, caption:String)

	Function bmx_wxfontdata_create:Byte Ptr()
	Function bmx_wxfontdata_enableeffects(handle:Byte Ptr, enable:Int)
	Function bmx_wxfontdata_getallowsymbols:Int(handle:Byte Ptr)
	Function bmx_wxfontdata_getcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxfontdata_getchosenfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxfontdata_getenableeffects:Int(handle:Byte Ptr)
	Function bmx_wxfontdata_getinitialfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxfontdata_getshowhelp:Int(handle:Byte Ptr)
	Function bmx_wxfontdata_setallowsymbols(handle:Byte Ptr, allowSymbols:Int)
	Function bmx_wxfontdata_setchosenfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxfontdata_setcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxfontdata_setinitialfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxfontdata_setrange(handle:Byte Ptr, minSize:Int, maxSize:Int)
	Function bmx_wxfontdata_setshowhelp(handle:Byte Ptr, showhelp:Int)

End Extern
