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
Import wx.wxCommandProcessor
Import wx.wxWindow
Import wx.wxPrintout
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

	Function bmx_wxdocument_create:Byte Ptr(handle:Object)
	Function bmx_wxdocument_addview:Int(handle:Byte Ptr, view:Byte Ptr)
	Function bmx_wxdocument_close:Int(handle:Byte Ptr)
	Function bmx_wxdocument_deleteallviews:Int(handle:Byte Ptr)
	Function bmx_wxdocument_getcommandprocessor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumenttemplate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentmanager:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentname:String(handle:Byte Ptr)
	Function bmx_wxdocument_getdocumentwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getfilename:String(handle:Byte Ptr)
	Function bmx_wxdocument_getfirstview:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_getprintablename:String(handle:Byte Ptr)
	Function bmx_wxdocument_gettitle:String(handle:Byte Ptr)
	Function bmx_wxdocument_ismodified:Int(handle:Byte Ptr)
	Function bmx_wxdocument_loadobject:Byte Ptr(handle:Byte Ptr, stream:Byte Ptr)
	Function bmx_wxdocument_modify(handle:Byte Ptr, doModify:Int)
	Function bmx_wxdocument_onchangedviewlist(handle:Byte Ptr)
	Function bmx_wxdocument_onclosedocument:Int(handle:Byte Ptr)
	Function bmx_wxdocument_oncreate:Int(handle:Byte Ptr, path:String, flags:Int)
	Function bmx_wxdocument_oncreatecommandprocessor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdocument_onnewdocument:Int(handle:Byte Ptr)
	Function bmx_wxdocument_onopendocument:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxdocument_onsavedocument:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxdocument_onsavemodified:Int(handle:Byte Ptr)
	Function bmx_wxdocument_removeview:Int(handle:Byte Ptr, view:Byte Ptr)
	Function bmx_wxdocument_save:Int(handle:Byte Ptr)
	Function bmx_wxdocument_saveas:Int(handle:Byte Ptr)
	Function bmx_wxdocument_saveobject:Byte Ptr(handle:Byte Ptr, stream:Byte Ptr)
	Function bmx_wxdocument_setcommandprocessor(handle:Byte Ptr, processor:Byte Ptr)
	Function bmx_wxdocument_setdocumentname(handle:Byte Ptr, name:String)
	Function bmx_wxdocument_setdocumenttemplate(handle:Byte Ptr, templ:Byte Ptr)
	Function bmx_wxdocument_setfilename(handle:Byte Ptr, filename:String, notifyViews:Int)
	Function bmx_wxdocument_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxdocument_updateallviews(handle:Byte Ptr, sender:Byte Ptr)

End Extern
