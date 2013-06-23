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
	Function bmx_wxmenu_appenditem:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxmenu_appendseparator:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenu_appendcheckitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_appendradioitem:Byte Ptr(handle:Byte Ptr, id:Int, item:String, helpString:String)
	Function bmx_wxmenu_break(handle:Byte Ptr)
	Function bmx_wxmenu_free(handle:Byte Ptr)
	
	Function bmx_wxmenu_appendsubmenu:Byte Ptr(handle:Byte Ptr, submenu:Byte Ptr, item:String, helpString:String)
	Function bmx_wxmenu_check(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenu_delete(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_destroy(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_destroyitem(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxmenu_enable(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenu_finditem:Int(handle:Byte Ptr, itemString:String)
	Function bmx_wxmenu_finditembyposition:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxmenu_gethelpstring:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_getlabel:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenu_getmenuitemcount:Int(handle:Byte Ptr)
	Function bmx_wxmenu_gettitle:String(handle:Byte Ptr)
	Function bmx_wxmenu_insert:Byte Ptr(handle:Byte Ptr, pos:Int, id:Int, item:String, helpString:String, kind:Int)
	Function bmx_wxmenu_insertitem:Byte Ptr(handle:Byte Ptr, pos:Int, item:Byte Ptr)
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
	Function bmx_wxmenu_findchilditem:Byte Ptr(handle:Byte Ptr, id:Int, pos:Int Ptr)

	Function bmx_wxmenuitem_create:Byte Ptr(parentMenu:Byte Ptr, id:Int, text:String, helpString:String, kind:Int, subMenu:Byte Ptr)
	Function bmx_wxmenuitem_delete(handle:Byte Ptr)
	Function bmx_wxmenuitem_check(handle:Byte Ptr, value:Int)
	Function bmx_wxmenuitem_enable(handle:Byte Ptr, value:Int)
	Function bmx_wxmenuitem_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuitem_getbitmap:Byte Ptr(handle:Byte Ptr, checked:Int)
	Function bmx_wxmenuitem_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuitem_gethelp:String(handle:Byte Ptr)
	Function bmx_wxmenuitem_getid:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_getkind:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_getitemlabeltext:String(handle:Byte Ptr)
	Function bmx_wxmenuitem_getlabeltext:String(text:String)
	Function bmx_wxmenuitem_getmarginwidth:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_getmenu:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuitem_getitemlabel:String(handle:Byte Ptr)
	Function bmx_wxmenuitem_getsubmenu:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuitem_gettextcolour:Byte Ptr(handle:Byte Ptr)	
	Function bmx_wxmenuitem_ischeckable:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_ischecked:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_isenabled:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_isseparator:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_issubmenu:Int(handle:Byte Ptr)
	Function bmx_wxmenuitem_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxmenuitem_setbitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxmenuitem_setbitmaps(handle:Byte Ptr, checked:Byte Ptr, unchecked:Byte Ptr)
	Function bmx_wxmenuitem_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxmenuitem_sethelp(handle:Byte Ptr, helpString:String)
	Function bmx_wxmenuitem_setmarginwidth(handle:Byte Ptr, width:Int)
	Function bmx_wxmenuitem_setmenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxmenuitem_setsubmenu(handle:Byte Ptr, submenu:Byte Ptr)
	Function bmx_wxmenuitem_setitemlabel(handle:Byte Ptr, text:String)
	Function bmx_wxmenuitem_settextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxmenuitem_toggle(handle:Byte Ptr)
	Function bmx_wxmenuitem_getaccel:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuitem_setcheckable(handle:Byte Ptr, checkable:Int)

	Function bmx_wxmenuevent_getmenu:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxmenuevent_getmenuid:Int(handle:Byte Ptr)
	Function bmx_wxmenuevent_ispopup:Int(handle:Byte Ptr)

	Function bmx_wxmenu_geteventtype:Int(evt:Int)
	
	Function bmx_wxmenu_addresourcehandler()

	Function bmx_wxacceleratorentry_create:Byte Ptr(flags:Int, keyCode:Int, cmd:Int, item:Byte Ptr)
	Function bmx_wxacceleratorentry_getcommand:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_getflags:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_getkeycode:Int(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_set(handle:Byte Ptr, flags:Int, keyCode:Int, cmd:Int)
	Function bmx_wxacceleratorentry_delete(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_fromstring:Int(handle:Byte Ptr, text:String)
	Function bmx_wxacceleratorentry_torawstring:String(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_tostring:String(handle:Byte Ptr)
	Function bmx_wxacceleratorentry_getmenuitem:Byte Ptr(handle:Byte Ptr)

End Extern

Const wxEVT_MENU_OPEN:Int = 421
Const wxEVT_MENU_CLOSE:Int = 422
Const wxEVT_MENU_HIGHLIGHT:Int = 423

Const wxID_SEPARATOR:Int = -2

