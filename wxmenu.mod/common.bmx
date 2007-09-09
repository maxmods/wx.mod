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

	Function bmx_wxmenu_create:Byte Ptr(handle:Object, title:String, style:Int)
	Function bmx_wxmenu_append:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String, kind:Int)
	Function bmx_wxmenu_appendMenu:Byte Ptr(handle:Byte Ptr, id:Int, item:String, submenu:Byte Ptr, helpString:String)
	Function bmx_wxmenu_appendseparator:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenu_appendcheckitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_appendradioitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_break(handle:Byte Ptr)
	
	Function bmx_wxmenu_appendsubmenu:Byte Ptr(handle:Byte Ptr, submenu:Byte Ptr, item:String, helpString:String)
	Function bmx_wxmenu_check(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenu_delete(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_destroy(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_enable(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenu_finditem:Int(handle:Byte Ptr, itemString:String)
	Function bmx_wxmenu_finditembyposition:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxmenu_gethelpstring:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_getlabel:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_getmenuitemcount:Int(handle:Byte Ptr)
	Function bmx_wxmenu_gettitle:String(handle:Byte Ptr)
	Function bmx_wxmenu_insert:Byte Ptr(handle:Byte Ptr, pos:Int, id:Int, item:String, helpString:String, kind:Int)
	Function bmx_wxmenu_insertcheckitem:Byte Ptr(handle:Byte Ptr, pos:Int, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_insertradioitem:Byte Ptr(handle:Byte Ptr, pos:Int, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_insertseparator:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxmenu_ischecked:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_isenabled:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_prepend:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String, kind:Int)
	Function bmx_wxmenu_prependcheckitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_prependradioitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_prependseparator:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenu_remove(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_sethelpstring(handle:Byte Ptr, id:Int, helpString:String)
	Function bmx_wxmenu_setlabel(handle:Byte Ptr, id:Int, label:String)
	Function bmx_wxmenu_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxmenu_updateui(handle:Byte Ptr, source:Byte Ptr)
	
	Function bmx_wxmenu_geteventtype:Int(evt:Int)
End Extern

Const wxEVT_MENU_OPEN:Int = 421
Const wxEVT_MENU_CLOSE:Int = 422
Const wxEVT_MENU_HIGHLIGHT:Int = 423
