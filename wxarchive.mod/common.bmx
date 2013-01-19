' Copyright (c) 2007-2013 Bruce A Henderson
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
Import wx.wxDateTime
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

	Function bmx_wxarchiveentry_getinternalformat:Int(handle:Byte Ptr)
	Function bmx_wxarchiveentry_getinternalname:String(handle:Byte Ptr)
	Function bmx_wxarchiveentry_getname:String(handle:Byte Ptr, format:Int)
	Function bmx_wxarchiveentry_getoffset:Int(handle:Byte Ptr)
	Function bmx_wxarchiveentry_getsize:Int(handle:Byte Ptr)
	Function bmx_wxarchiveentry_isdir:Int(handle:Byte Ptr)
	Function bmx_wxarchiveentry_isreadonly:Int(handle:Byte Ptr)

	Function bmx_wxarchiveinputstream_closeentry:Int(handle:Byte Ptr)
	Function bmx_wxarchiveinputstream_getnextentry:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxarchiveinputstream_openentry:Int(handle:Byte Ptr, entry:Byte Ptr)

End Extern
