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
Import wx.wxValidator
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

	Function bmx_wxtextvalidator_create:Byte Ptr(style:Int)
	Function bmx_wxtextvalidator_getwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextvalidator_setwindow(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxtextvalidator_getexcludes:String[](handle:Byte Ptr)
	Function bmx_wxtextvalidator_getincludes:String[](handle:Byte Ptr)
	Function bmx_wxtextvalidator_getstyle:Int(handle:Byte Ptr)
	Function bmx_wxtextvalidator_setexcludes(handle:Byte Ptr, list:String[])
	Function bmx_wxtextvalidator_setincludes(handle:Byte Ptr, list:String[])
	Function bmx_wxtextvalidator_setstyle(handle:Byte Ptr, style:Int)

End Extern


Const wxFILTER_NONE:Int = $0000
Const wxFILTER_ASCII:Int = $0001
Const wxFILTER_ALPHA:Int = $0002
Const wxFILTER_ALPHANUMERIC:Int = $0004
Const wxFILTER_NUMERIC:Int = $0008
Const wxFILTER_INCLUDE_LIST:Int = $0010
Const wxFILTER_EXCLUDE_LIST:Int = $0020
Const wxFILTER_INCLUDE_CHAR_LIST:Int = $0040
Const wxFILTER_EXCLUDE_CHAR_LIST:Int = $0080

