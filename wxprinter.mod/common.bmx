' Copyright (c) 2007-2009 Bruce A Henderson
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
Import wx.wxPrintout
Import wx.wxDC
Import wx.wxPrintDialog
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

	Function bmx_wxprinter_create:Byte Ptr(data:Byte Ptr)
	Function bmx_wxprinter_delete(handle:Byte Ptr)

	Function bmx_wxprinter_createabortwindow(handle:Byte Ptr, parent:Byte Ptr, printout:Byte Ptr)
	Function bmx_wxprinter_getabort:Int(handle:Byte Ptr)
	Function bmx_wxprinter_getlasterror:Int()
	Function bmx_wxprinter_print:Int(handle:Byte Ptr, parent:Byte Ptr, printout:Byte Ptr, prompt:Int)
	Function bmx_wxprinter_getprintdialogdata:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxprinter_printdialog:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr)
	Function bmx_wxprinter_setup(handle:Byte Ptr, parent:Byte Ptr)
	
	Function bmx_wxprinter_reporterror(handle:Byte Ptr, parent:Byte Ptr, printout:Byte Ptr, message:String)


End Extern

Const wxPRINTER_NO_ERROR:Int = 0
Const wxPRINTER_CANCELLED:Int = 1
Const wxPRINTER_ERROR:Int = 2
