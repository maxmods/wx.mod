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
Import wx.wxControl
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

	Function bmx_wxwebview_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, url:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxwebview_getcurrenttitle:String(handle:Byte Ptr)
	Function bmx_wxwebview_getcurrenturl:String(handle:Byte Ptr)
	Function bmx_wxwebview_getpagesource:String(handle:Byte Ptr)
	Function bmx_wxwebview_getpagetext:String(handle:Byte Ptr)
	Function bmx_wxwebview_isbusy:Int(handle:Byte Ptr)
	Function bmx_wxwebview_iseditable:Int(handle:Byte Ptr)
	Function bmx_wxwebview_loadurl(handle:Byte Ptr, url:String)
	Function bmx_wxwebview_print(handle:Byte Ptr)
	Function bmx_wxwebview_reload(handle:Byte Ptr, flags:Int)
	Function bmx_wxwebview_runscript(handle:Byte Ptr, script:String)
	Function bmx_wxwebview_seteditable(handle:Byte Ptr, enable:Int)
	Function bmx_wxwebview_setpage(handle:Byte Ptr, html:String, baseUrl:String)
	Function bmx_wxwebview_setpagestream(handle:Byte Ptr, html:Byte Ptr, baseUrl:String)
	Function bmx_wxwebview_stop(handle:Byte Ptr)
	Function bmx_wxwebview_cancopy:Int(handle:Byte Ptr)
	Function bmx_wxwebview_cancut:Int(handle:Byte Ptr)
	Function bmx_wxwebview_canpaste:Int(handle:Byte Ptr)
	Function bmx_wxwebview_copy(handle:Byte Ptr)
	Function bmx_wxwebview_cut(handle:Byte Ptr)
	Function bmx_wxwebview_paste(handle:Byte Ptr)
	Function bmx_wxwebview_enablecontextmenu(handle:Byte Ptr, enable:Int)
	Function bmx_wxwebview_iscontextmenuenabled:Int(handle:Byte Ptr)
	Function bmx_wxwebview_cangoback:Int(handle:Byte Ptr)
	Function bmx_wxwebview_cangoforward:Int(handle:Byte Ptr)
	Function bmx_wxwebview_clearhistory(handle:Byte Ptr)
	Function bmx_wxwebview_enablehistory(handle:Byte Ptr, enable:Int)
	Function bmx_wxwebview_goback(handle:Byte Ptr)
	Function bmx_wxwebview_goforward(handle:Byte Ptr)
	Function bmx_wxwebview_loadhistoryitem(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxwebview_clearselection(handle:Byte Ptr)
	Function bmx_wxwebview_deleteselection(handle:Byte Ptr)
	Function bmx_wxwebview_getselectedsource:String(handle:Byte Ptr)
	Function bmx_wxwebview_getselectedtext:String(handle:Byte Ptr)
	Function bmx_wxwebview_hasselection:Int(handle:Byte Ptr)
	Function bmx_wxwebview_selectall(handle:Byte Ptr)
	Function bmx_wxwebview_canredo:Int(handle:Byte Ptr)
	Function bmx_wxwebview_canundo:Int(handle:Byte Ptr)
	Function bmx_wxwebview_redo(handle:Byte Ptr)
	Function bmx_wxwebview_undo(handle:Byte Ptr)
	Function bmx_wxwebview_find:Int(handle:Byte Ptr, text:String, flags:Int)
	Function bmx_wxwebview_cansetzoomtype:Int(handle:Byte Ptr, zoomtype:Int)
	Function bmx_wxwebview_getzoom:Int(handle:Byte Ptr)
	Function bmx_wxwebview_getzoomtype:Int(handle:Byte Ptr)
	Function bmx_wxwebview_setzoom(handle:Byte Ptr, zoom:Int)
	Function bmx_wxwebview_setzoomtype(handle:Byte Ptr, zoomType:Int)

	Function bmx_wxwebviewhistoryitem_create:Byte Ptr(url:String, title:String)
	Function bmx_wxwebviewhistoryitem_geturl:String(handle:Byte Ptr)
	Function bmx_wxwebviewhistoryitem_gettitle:String(handle:Byte Ptr)
	Function bmx_wxwebviewhistoryitem_free(handle:Byte Ptr)

	Function bmx_wxwebviewevent_gettarget:String(handle:Byte Ptr)
	Function bmx_wxwebviewevent_geturl:String(handle:Byte Ptr)

	Function bmx_wxwebview_geteventtype:Int(evt:Int)

End Extern

Const wxEVT_COMMAND_WEB_VIEW_NAVIGATING:Int = -61
Const wxEVT_COMMAND_WEB_VIEW_NAVIGATED:Int = -62
Const wxEVT_COMMAND_WEB_VIEW_LOADED:Int = -63
Const wxEVT_COMMAND_WEB_VIEW_ERROR:Int = -64
Const wxEVT_COMMAND_WEB_VIEW_NEWWINDOW:Int = -65
Const wxEVT_COMMAND_WEB_VIEW_TITLE_CHANGED:Int = -66
					
Const wxWEB_VIEW_FIND_WRAP:Int = $0001
Const wxWEB_VIEW_FIND_ENTIRE_WORD:Int = $0002
Const wxWEB_VIEW_FIND_MATCH_CASE:Int = $0004
Const wxWEB_VIEW_FIND_HIGHLIGHT_RESULT:Int = $0008
Const wxWEB_VIEW_FIND_BACKWARDS:Int = $0010
Const wxWEB_VIEW_FIND_DEFAULT:Int = 0

Const wxWEB_VIEW_ZOOM_TINY:Int = 0
Const wxWEB_VIEW_ZOOM_SMALL:Int = 1
Const wxWEB_VIEW_ZOOM_MEDIUM:Int = 2
Const wxWEB_VIEW_ZOOM_LARGE:Int = 3
Const wxWEB_VIEW_ZOOM_LARGEST:Int = 4

Const wxWEB_VIEW_ZOOM_TYPE_LAYOUT:Int = 0
Const wxWEB_VIEW_ZOOM_TYPE_TEXT:Int = 1

Const wxWEB_NAV_ERR_CONNECTION:Int = 0
Const wxWEB_NAV_ERR_CERTIFICATE:Int = 1
Const wxWEB_NAV_ERR_AUTH:Int = 2
Const wxWEB_NAV_ERR_SECURITY:Int = 3
Const wxWEB_NAV_ERR_NOT_FOUND:Int = 4
Const wxWEB_NAV_ERR_REQUEST:Int = 5
Const wxWEB_NAV_ERR_USER_CANCELLED:Int = 6
Const wxWEB_NAV_ERR_OTHER:Int = 7

Const wxWEB_VIEW_RELOAD_DEFAULT:Int = 0
Const wxWEB_VIEW_RELOAD_NO_CACHE:Int = 1

