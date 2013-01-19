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
Import wx.wxDialog
Import wx.wxPanel
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

	Function bmx_wxwizard_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, title:String, bitmap:Byte Ptr, x:Int, y:Int, style:Int)
	Function bmx_wxwizard_getcurrentpage:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwizard_getpageareasizer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwizard_getpagesize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwizard_hasnextpage:Int(handle:Byte Ptr, page:Byte Ptr)
	Function bmx_wxwizard_hasprevpage:Int(handle:Byte Ptr, page:Byte Ptr)
	Function bmx_wxwizard_runwizard:Int(handle:Byte Ptr, firstPage:Byte Ptr)
	Function bmx_wxwizard_setborder(handle:Byte Ptr, border:Int)

	Function bmx_wxwizardpage_create:Byte Ptr(handle:Object, parent:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxwizardpage_getprev:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwizardpage_getnext:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwizardpage_getbitmap:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxwizardpagesimple_create:Byte Ptr(handle:Object, parent:Byte Ptr, prev:Byte Ptr, nxt:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxwizardpagesimple_setprev(handle:Byte Ptr, page:Byte Ptr)
	Function bmx_wxwizardpagesimple_setnext(handle:Byte Ptr, page:Byte Ptr)
	Function bmx_wxwizardpagesimple_chain(First:Byte Ptr, Second:Byte Ptr)

	Function bmx_wxwizardevent_getdirection:Int(evt:Byte Ptr)
	Function bmx_wxwizardevent_getpage:Byte Ptr(evt:Byte Ptr)

	Function bmx_wxwizard_geteventtype:Int(evt:Int)
	
	Function bmx_wxwizard_addresourcehandler()

End Extern

Const wxEVT_WIZARD_PAGE_CHANGED:Int = 900
Const wxEVT_WIZARD_PAGE_CHANGING:Int = 901
Const wxEVT_WIZARD_CANCEL:Int = 902
Const wxEVT_WIZARD_HELP:Int = 903
Const wxEVT_WIZARD_FINISHED:Int = 904

