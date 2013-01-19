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

	Function bmx_wxhelpprovider_free(handle:Byte Ptr)
	Function bmx_wxhelpprovider_set:Byte Ptr(helpProvider:Byte Ptr)
	Function bmx_wxhelpprovider_get:Byte Ptr()
	Function bmx_wxhelpprovider_addhelp(handle:Byte Ptr, window:Byte Ptr, text:String)
	Function bmx_wxhelpprovider_addhelpid(handle:Byte Ptr, windowId:Int, text:String)
	Function bmx_wxhelpprovider_gethelp:String(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxhelpprovider_removehelp(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxhelpprovider_showhelp:Int(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxhelpprovider_showhelpatpoint:Int(handle:Byte Ptr, window:Byte Ptr, x:Int, y:Int, origin:Int)
	
	Function bmx_wxsimplehelpprovider_create:Byte Ptr()

End Extern
