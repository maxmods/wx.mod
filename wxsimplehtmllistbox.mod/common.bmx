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
Import wx.wxHtmlListBox
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

	Function bmx_wxsimplehtmllistbox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)

	Function bmx_wxsimplehtmllistbox_getselection:Int(handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_getcount:Int(handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_isempty:Int(handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_selectitem(handle:Byte Ptr, item:Int)
	Function bmx_wxsimplehtmllistbox_append:Int(handle:Byte Ptr, item:String, clientData:Object)
	Function bmx_wxsimplehtmllistbox_clear(handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_deleteitem(handle:Byte Ptr, item:Int)
	Function bmx_wxsimplehtmllistbox_insert:Int(handle:Byte Ptr, item:String, pos:Int, clientData:Object)
	Function bmx_wxsimplehtmllistbox_getstring:String(handle:Byte Ptr, item:Int)
	Function bmx_wxsimplehtmllistbox_setselection(handle:Byte Ptr, item:Int)

	Function bmx_wxsimplehtmllistbox_appenditems:Int(handle:Byte Ptr, items:String[])
	Function bmx_wxsimplehtmllistbox_findstring:Int(handle:Byte Ptr, text:String, caseSensitive:Int)
	Function bmx_wxsimplehtmllistbox_getclientdata:Object(handle:Byte Ptr, item:Int)
	Function bmx_wxsimplehtmllistbox_getstrings:String[](handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_getstringselection:String(handle:Byte Ptr)
	Function bmx_wxsimplehtmllistbox_setclientdata(handle:Byte Ptr, item:Int, clientData:Object)
	Function bmx_wxsimplehtmllistbox_setstring(handle:Byte Ptr, item:Int, text:String)
	Function bmx_wxsimplehtmllistbox_setstringselection(handle:Byte Ptr, text:String)


End Extern


Const wxHLB_DEFAULT_STYLE:Int = wxBORDER_SUNKEN
Const wxHLB_MULTIPLE:Int = wxLB_MULTIPLE
