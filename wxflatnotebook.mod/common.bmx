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

Import "include/*.h"

Import "src/wxFlatNotebook/fnb_customize_dlg.cpp"
Import "src/wxFlatNotebook/popup_dlg.cpp"
Import "src/wxFlatNotebook/wxFlatNotebook.cpp"
Import "src/wxFlatNotebook/fnb_resources.cpp"
Import "src/wxFlatNotebook/renderer.cpp"
Import "src/wxFlatNotebook/xh_fnb.cpp"


Import "glue.cpp"

Extern

	Function bmx_wxflatnotebook_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)

	Function bmx_wxflatnotebook_advanceselection(handle:Byte Ptr, forward:Int)
	Function bmx_wxflatnotebook_addpage:Int(handle:Byte Ptr, window:Byte Ptr, caption:String, selected:Int, imgIndex:Int)
	Function bmx_wxflatnotebook_insertpage:Int(handle:Byte Ptr, index:Int, page:Byte Ptr, text:String, selected:Int, imgIndex:Int)
	Function bmx_wxflatnotebook_setselection(handle:Byte Ptr, page:Int)
	Function bmx_wxflatnotebook_deletepage(handle:Byte Ptr, page:Int, _notify:Int)
	Function bmx_wxflatnotebook_deleteallpages:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getpagecount:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getcurrentpage:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getpage:Byte Ptr(handle:Byte Ptr, page:Int)
	Function bmx_wxflatnotebook_getpageindex:Int(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxflatnotebook_getselection:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getpreviousselection:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getpageshapeangle:Int(handle:Byte Ptr, page:Int, result:Int Ptr)
	Function bmx_wxflatnotebook_setpageshapeangle(handle:Byte Ptr, page:Int, angle:Int)
	Function bmx_wxflatnotebook_setallpagesshapeangle(handle:Byte Ptr, angle:Int)
	Function bmx_wxflatnotebook_getpagebestsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxflatnotebook_setpagetext:Int(handle:Byte Ptr, page:Int, text:String)
	Function bmx_wxflatnotebook_removepage:Int(handle:Byte Ptr, page:Int, _notify:Int)
	Function bmx_wxflatnotebook_setpadding(handle:Byte Ptr, padW:Int, padH:Int)
	Function bmx_wxflatnotebook_setwindowstyleflag(handle:Byte Ptr, style:Int)
	Function bmx_wxflatnotebook_setrightclickmenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxflatnotebook_getpagetext(handle:Byte Ptr, page:Int)
	Function bmx_wxflatnotebook_setpageimageindex(handle:Byte Ptr, page:Int, imgIndex:Int)
	Function bmx_wxflatnotebook_getpageimageindex:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxflatnotebook_setgradientcolors(handle:Byte Ptr, colFrom:Byte Ptr, colTo:Byte Ptr, border:Byte Ptr)
	Function bmx_wxflatnotebook_setgradientcolorfrom(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_setgradientcolorto(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_setgradientcolorborder(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_enablepage(handle:Byte Ptr, page:Int, enabled:Int)
	Function bmx_wxflatnotebook_getpageenabled:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxflatnotebook_setactivetabtextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_getgradientcolorfrom:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getgradientcolorto:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getgradientcolorborder:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getactivetabtextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getnonactivetabtextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_setnonactivetabtextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_gettabarea:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_gettabareacolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_settabareacolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_getactivetabcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxflatnotebook_setactivetabcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxflatnotebook_getpadding:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_setcustomizeoptions(handle:Byte Ptr, options:Int)
	Function bmx_wxflatnotebook_getcustomizeoptions:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_setforceselection(handle:Byte Ptr, force:Int)
	Function bmx_wxflatnotebook_getforceselection:Int(handle:Byte Ptr)
	Function bmx_wxflatnotebook_getmainsizer:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxflatnotebook_geteventtype:Int(eventType:Int)

	Function bmx_wxflatnotebookevent_setselection(handle:Byte Ptr, selection:Int)
	Function bmx_wxflatnotebookevent_setoldselection(handle:Byte Ptr, selection:Int)
	Function bmx_wxflatnotebookevent_getselection(handle:Byte Ptr)
	Function bmx_wxflatnotebookevent_getoldselection(handle:Byte Ptr)

	Function bmx_wxflatnotebook_setimagelist:Byte Ptr(handle:Byte Ptr, list:wxBitmap[])
	Function bmx_wxflatnotebook_getimagelist:wxBitmap[](handle:Byte Ptr)
	Function bmx_wxflatnotebook_deleteimagelist(handle:Byte Ptr)

End Extern


Const wxFNB_VC71:Int = $00000001
Const wxFNB_FANCY_TABS:Int = $00000002
Const wxFNB_TABS_BORDER_SIMPLE:Int = $00000004
Const wxFNB_NO_X_BUTTON:Int = $00000008
Const wxFNB_NO_NAV_BUTTONS:Int = $00000010
Const wxFNB_MOUSE_MIDDLE_CLOSES_TABS:Int = $00000020
Const wxFNB_BOTTOM:Int = $00000040
Const wxFNB_NODRAG:Int = $00000080
Const wxFNB_VC8:Int = $00000100
Const wxFNB_X_ON_TAB:Int = $00000200
Const wxFNB_BACKGROUND_GRADIENT:Int = $00000400
Const wxFNB_COLORFUL_TABS:Int = $00000800
Const wxFNB_DCLICK_CLOSES_TABS:Int = $00001000
Const wxFNB_SMART_TABS:Int = $00002000
Const wxFNB_DROPDOWN_TABS_LIST:Int = $00004000
Const wxFNB_ALLOW_FOREIGN_DND:Int = $00008000
Const wxFNB_FF2:Int = $00010000		' Firefox 2 tabs style
Const wxFNB_CUSTOM_DLG:Int = $00020000		' Popup customize dialog using right click
Const wxFNB_BOTTOM_LINE_COLOR_CHANGE:Int = $00100000
Const wxFNB_INVERSE_COLOR_LINE_VC8:Int = $00200000
Const wxFNB_PREVIEW_SELECT_TAB:Int = $00400000

Const wxFNB_DEFAULT_STYLE:Int = wxFNB_MOUSE_MIDDLE_CLOSES_TABS
Const wxFNB_CUSTOM_TAB_LOOK:Int = $00000001
Const wxFNB_CUSTOM_ORIENTATION:Int = $00000002
Const wxFNB_CUSTOM_FOREIGN_DRAG:Int = $00000004	
Const wxFNB_CUSTOM_LOCAL_DRAG:Int = $00000008
Const wxFNB_CUSTOM_CLOSE_BUTTON:Int = $00000010
Const wxFNB_CUSTOM_ALL:Int = wxFNB_CUSTOM_TAB_LOOK | wxFNB_CUSTOM_ORIENTATION | ..
	wxFNB_CUSTOM_FOREIGN_DRAG | wxFNB_CUSTOM_LOCAL_DRAG | wxFNB_CUSTOM_CLOSE_BUTTON 

Const wxFNB_BTN_PRESSED:Int = 0
Const wxFNB_BTN_HOVER:Int = 1
Const wxFNB_BTN_NONE:Int = 2

Const wxFNB_TAB:Int = 0
Const wxFNB_X:Int = 1
Const wxFNB_TAB_X:Int = 2
Const wxFNB_LEFT_ARROW:Int = 3
Const wxFNB_RIGHT_ARROW:Int = 4
Const wxFNB_DROP_DOWN_ARROW:Int = 5
Const wxFNB_NOWHERE:Int = 6


Const wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGED:Int = 50000
Const wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGING:Int = 50001
Const wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSING:Int = 50002
Const wxEVT_COMMAND_FLATNOTEBOOK_CONTEXT_MENU:Int = 50003
Const wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSED:Int = 50004


