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
Import wx.wxWindow
Import wx.wxPageSetupDialogData
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

	Function bmx_wxhtmleasyprinting_create:Byte Ptr(name:String, parent:Byte Ptr)
	Function bmx_wxhtmleasyprinting_previewfile:Int(handle:Byte Ptr, htmlFile:String)
	Function bmx_wxhtmleasyprinting_previewtext:Int(handle:Byte Ptr, htmlText:String, basePath:String)
	Function bmx_wxhtmleasyprinting_printfile:Int(handle:Byte Ptr, htmlFile:String)
	Function bmx_wxhtmleasyprinting_printtext:Int(handle:Byte Ptr, htmlText:String, basePath:String)
	Function bmx_wxhtmleasyprinting_pagesetup(handle:Byte Ptr)
	Function bmx_wxhtmleasyprinting_setfonts(handle:Byte Ptr, normalFace:String, fixedFace:String, sizes:Int[])
	Function bmx_wxhtmleasyprinting_setheader(handle:Byte Ptr, header:String, page:Int)
	Function bmx_wxhtmleasyprinting_setfooter(handle:Byte Ptr, footer:String, page:Int)
	Function bmx_wxhtmleasyprinting_getprintdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmleasyprinting_getpagesetupdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmleasyprinting_setparentwindow(handle:Byte Ptr, parent:Byte Ptr)

End Extern


Const wxPAGE_ODD:Int = 0
Const wxPAGE_EVEN:Int = 1
Const wxPAGE_ALL:Int = 2

