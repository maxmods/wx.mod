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
Import wx.wxDC
Import wx.wxCursor
Import wx.wxMenu
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

	Function bmx_wxwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxwindow_show:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxwindow_close:Int(handle:Byte Ptr, force:Int)
	Function bmx_wxwindow_setsizer(handle:Byte Ptr, sizer:Byte Ptr, deleteOld:Int)
	Function bmx_wxwindow_setautolayout(handle:Byte Ptr, autoLayout:Int)
	Function bmx_wxwindow_delete(handle:Byte Ptr)
	Function bmx_wxwindow_getsizer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_layout(handle:Byte Ptr)
	Function bmx_wxwindow_getwindowstyleflag:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getbestsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_setfocus(handle:Byte Ptr)
	Function bmx_wxwindow_clearbackground(handle:Byte Ptr)
	Function bmx_wxwindow_clienttoscreen(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxwindow_setforegroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_gethelptext:String(handle:Byte Ptr)
	Function bmx_wxwindow_getid:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getlabel:String(handle:Byte Ptr)
	Function bmx_wxwindow_preparedc(handle:Byte Ptr, dc:Byte Ptr)
	Function bmx_wxwindow_refresh(handle:Byte Ptr, eraseBackground:Int)
	Function bmx_wxwindow_getparent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getscrollpos:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getscrollrange:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getscrollthumb:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getcharheight:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getcharwidth:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getclientsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxwindow_getforegroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getgrandparent:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxwindow_gethelptextatpoint:String(handle:Byte Ptr, x:Int, y:Int, origin:Int)
	Function bmx_wxwindow_getmaxsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getminsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getname:String(handle:Byte Ptr)
	Function bmx_wxwindow_getposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_getrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getscreenposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_getscreenrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getrectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getscreenrectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_sethelptext(handle:Byte Ptr, helpText:String)
	Function bmx_wxwindow_setid(handle:Byte Ptr, id:Int)
	Function bmx_wxwindow_setlabel(handle:Byte Ptr, label:String)
	Function bmx_wxwindow_setscrollbar(handle:Byte Ptr, orientation:Int, position:Int, thumbsize:Int, range:Int, refresh:Int)
	Function bmx_wxwindow_setscrollpos(handle:Byte Ptr, orientation:Int, pos:Int, refresh:Int)
	
	Function bmx_wxwindow_setcursor(handle:Byte Ptr, cursor:Byte Ptr)
	Function bmx_wxwindow_setwindowstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setwindowstyleflag(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_hide:Int(handle:Byte Ptr)
	Function bmx_wxwindow_move(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxwindow_setdimensions(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, flags:Int)
	Function bmx_wxwindow_setdimensionsrect(handle:Byte Ptr, rect:Byte ptr)
	Function bmx_wxwindow_pusheventhandler(handle:Byte Ptr, evt:Byte Ptr)

	Function bmx_wxwindow_getwindowvariant:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hascapture:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hasflag:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxwindow_hasmultiplepages:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hastransparentbackground:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hasscrollbar:Int(handle:Byte Ptr, orient:Int)
	Function bmx_wxwindow_inheritattributes(handle:Byte Ptr)
	Function bmx_wxwindow_initdialog(handle:Byte Ptr)
	Function bmx_wxwindow_invalidatebestsize(handle:Byte Ptr)
	Function bmx_wxwindow_isdoublebuffered:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isenabled:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isexposed:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxwindow_isexposedrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxwindow_isfrozen:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isretained:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isshown:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isshownonscreen:Int(handle:Byte Ptr)
	Function bmx_wxwindow_istoplevel:Int(handle:Byte Ptr)
	Function bmx_wxwindow_reparent:Int(handle:Byte Ptr, parent:Byte Ptr)
	
	Function bmx_wxwindow_destroy:Int(handle:Byte Ptr)
	Function bmx_wxwindow_destroyChildren(handle:Byte Ptr)
	Function bmx_wxwindow_disable:Int(handle:Byte Ptr)
	Function bmx_wxwindow_dragacceptfiles(handle:Byte Ptr, accept:Int)
	Function bmx_wxwindow_enable:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxwindow_fit(handle:Byte Ptr)
	Function bmx_wxwindow_fitinside(handle:Byte Ptr)
	Function bmx_wxwindow_freeze(handle:Byte Ptr)
	Function bmx_wxwindow_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getbackgroundstyle:Int(handle:Byte Ptr)
	Function bmx_wxwindow_geteffectiveminsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_capturemouse(handle:Byte Ptr)
	Function bmx_wxwindow_centre(handle:Byte Ptr, direction:Int)
	Function bmx_wxwindow_centreonparent(handle:Byte Ptr, direction:Int)
	Function bmx_wxwindow_popupmenu:Int(handle:Byte Ptr, menu:Byte Ptr, x:Int, y:Int)
	Function bmx_wxwindow_refreshrect(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, erase:Int)
	Function bmx_wxwindow_refreshrectrect(handle:Byte Ptr, rect:Byte Ptr, erase:Int)
	Function bmx_wxwindow_releasemouse(handle:Byte Ptr)
	Function bmx_wxwindow_screentoclient(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_setsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setposition(handle:Byte Ptr, x:Int, y:Int)

	Function bmx_wxwindow_gethandle:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_linedown(handle:Byte Ptr)
	Function bmx_wxwindow_lineup(handle:Byte Ptr)
	Function bmx_wxwindow_lower(handle:Byte Ptr)
	Function bmx_wxwindow_makemodal(handle:Byte Ptr, flag:Int)
	Function bmx_wxwindow_moveafterintaborder(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxwindow_movebeforeintaborder(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxwindow_pagedown(handle:Byte Ptr)
	Function bmx_wxwindow_pageup(handle:Byte Ptr)
	Function bmx_wxwindow_popeventhandler:Byte Ptr(handle:Byte Ptr, deleteHandler:Int)
	Function bmx_wxwindow_raise(handler:Byte Ptr)
	Function bmx_wxwindow_removeeventhandler:Int(handle:Byte Ptr, handler:Byte Ptr)
	Function bmx_wxwindow_setbackgroundstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setinitialsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_setclientsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_setcontainingsizer(handle:Byte Ptr, sizer:Byte Ptr)
	'Function bmx_wxwindow_setinitialbestsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_seteventhandler(handle:Byte Ptr, handler:Byte Ptr)
	Function bmx_wxwindow_setextrastyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setmaxsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setminsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setname(handle:Byte Ptr, name:String)
	Function bmx_wxwindow_setownbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_setownfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxwindow_setownforegroundcolour(handle:Byte Ptr, colour:Byte Ptr)

	Function bmx_wxwindow_findfocus:Byte Ptr()
	Function bmx_wxwindow_thaw(handle:Byte Ptr)
	Function bmx_wxwindow_togglewindowstyle:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxwindow_transferdatafromwindow:Int(handle:Byte Ptr)
	Function bmx_wxwindow_transferdatatowindow:Int(handle:Byte Ptr)
	Function bmx_wxwindow_udpate(handle:Byte Ptr)
	Function bmx_wxwindow_updatewindowui(handle:Byte Ptr, flags:Int)
	Function bmx_wxwindow_validate:Int(handle:Byte Ptr)
	Function bmx_wxwindow_setsizerandfit(handle:Byte Ptr, sizer:Byte Ptr, deleteOld:Int)
	Function bmx_wxwindow_setthemeenabled(handle:Byte Ptr, enable:Int)
	Function bmx_wxwindow_settooltip(handle:Byte Ptr, tip:String)
	Function bmx_wxwindow_setvirtualsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setvirtualsizehints(handle:Byte Ptr, minW:Int, minH:Int, maxW:Int, maxH:Int)

	Function bmx_wxboxsizer_create:Byte Ptr(handle:Object, orient:Int)
	Function bmx_wxsizer_add:Byte Ptr(handler:Byte Ptr, window:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addsizer:Byte Ptr(handler:Byte Ptr, sizer:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_detach:Int(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_detachsizer:Int(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxsizer_insert:Byte Ptr(handler:Byte Ptr, index:Int, window:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_insertsizer:Byte Ptr(handler:Byte Ptr, index:Int, sizer:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addcustomspacer:Byte Ptr(handler:Byte Ptr, width:Int, height:Int, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addspacer:Byte Ptr(handler:Byte Ptr, size:Int)
	Function bmx_wxsizer_addstretchspacer:Byte Ptr(handler:Byte Ptr, prop:Int)
	Function bmx_wxsizer_setitemminsize(handler:Byte Ptr, index:Int, width:Int, height:Int)
	Function bmx_wxsizer_setitemminsizewindow(handler:Byte Ptr, window:Byte Ptr, width:Int, height:Int)
	Function bmx_wxsizer_setitemminsizesizer(handler:Byte Ptr, sizer:Byte Ptr, width:Int, height:Int)
	Function bmx_wxgridsizer_create:Byte Ptr(handle:Object, cols:Int, vgap:Int, hgap:Int)
	Function bmx_wxgridsizer_createrc:Byte Ptr(handle:Object, rows:Int, cols:Int, vgap:Int, hgap:Int)
	Function bmx_wxgridsizer_getcols:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_gethgap:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_getrows:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_getvgap:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_setcols(handle:Byte Ptr, cols:Int)
	Function bmx_wxgridsizer_sethgap(handle:Byte Ptr, hgap:Int)
	Function bmx_wxgridsizer_setrows(handle:Byte Ptr, rows:Int)
	Function bmx_wxgridsizer_setvgap(handle:Byte Ptr, vgap:Int)
	Function bmx_wxsizer_setsizehints(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxflexgridsizer_create:Byte Ptr(handle:Object, cols:Int, vgap:Int, hgap:Int)
	Function bmx_wxflexgridsizer_addgrowablecol(handle:Byte Ptr, index:Int, prop:Int)
	Function bmx_wxflexgridsizer_addgrowablerow(handle:Byte Ptr, index:Int, prop:Int)
	Function bmx_wxsizer_fit(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_fitsize(handle:Byte Ptr, window:Byte Ptr, w:Int Ptr, h:Int Ptr)
	
	Function bmx_wxtooltip_enable(flag:Int)
	Function bmx_wxtooltip_setdelay(msecs:Int)

	Function bmx_wxupdateeventui_canupdate:Int(window:Byte Ptr)
	Function bmx_wxupdateeventui_getchecked:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getenabled:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getshown:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_gettext:String(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getmode:Int()
	Function bmx_wxupdateeventui_getupdateinterval:Int()
	Function bmx_wxupdateeventui_setmode(mode:Int)
	Function bmx_wxupdateeventui_settext(handle:Byte Ptr, text:String)
	Function bmx_wxupdateeventui_setupdateinterval(interval:Int)

	Function bmx_wxidleevent_cansend:Int(window:Byte Ptr)
	Function bmx_wxidleevent_getmode:Int()
	Function bmx_wxidleevent_requestmore(handle:Byte Ptr, needMore:Int)
	Function bmx_wxidleevent_morerequested:Int(handle:Byte Ptr)
	Function bmx_wxidleevent_setmode(mode:Int)

End Extern


Const wxEVT_SET_FOCUS:Int = 112
Const wxEVT_KILL_FOCUS:Int = 113

' Clipboard events
Const wxEVT_COMMAND_TEXT_COPY:Int = 444
Const wxEVT_COMMAND_TEXT_CUT:Int = 445
Const wxEVT_COMMAND_TEXT_PASTE:Int = 446

