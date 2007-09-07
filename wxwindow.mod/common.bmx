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
	Function bmx_wxwindow_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_sethelptext(handle:Byte Ptr, helpText:String)
	Function bmx_wxwindow_setid(handle:Byte Ptr, id:Int)
	Function bmx_wxwindow_setlabel(handle:Byte Ptr, label:String)
	Function bmx_wxwindow_setscrollbar(handle:Byte Ptr, orientation:Int, position:Int, thumbsize:Int, range:Int, refresh:Int)
	Function bmx_wxwindow_setscrollpos(handle:Byte Ptr, orientation:Int, pos:Int, refresh:Int)
	
	Function bmx_wxwindow_setcursor(handle:Byte Ptr, cursor:Byte Ptr)
	Function bmx_wxwindow_setwindowstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setwindowstyleflag(handle:Byte Ptr, style:Int)

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

End Extern
