' Copyright (c) 2007-2015 Bruce A Henderson
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
Import wx.wxFrame
Import wx.wxScrolledWindow
Import wx.wxMouseEvent
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

	Function bmx_wxhtmlwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxhtmlwindow_setpage:Int(handle:Byte Ptr, source:String)

	Function bmx_wxhtmlwindow_appendtopage:Int(handle:Byte Ptr, source:String)
	Function bmx_wxhtmlwindow_getopenedanchor:String(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_getopenedpage:String(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_getopenedpagetitle:String(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_getrelatedframe:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_historyback:Int(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_hisotrycanback:Int(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_historycanforward:Int(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_historyclear(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_historyforward:Int(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_loadpage:Int(handle:Byte Ptr, location:String)
	Function bmx_wxhtmlwindow_selectall(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_selectiontotext:String(handle:Byte Ptr)
	Function bmx_wxhtmlwindow_selectline(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxhtmlwindow_selectword(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxhtmlwindow_setborders(handle:Byte Ptr, size:Int)
	Function bmx_wxhtmlwindow_setfonts(handle:Byte Ptr, normalFace:String, fixedFace:String, sizes:Int[])
	Function bmx_wxhtmlwindow_setrelatedframe(handle:Byte Ptr, frame:Byte Ptr, format:String)
	Function bmx_wxhtmlwindow_setrelatedstatusbar(handle:Byte Ptr, bar:Int)
	Function bmx_wxhtmlwindow_totext:String(handle:Byte Ptr)

	Function bmx_wxhtmlwindow_addprocessor(handle:Byte Ptr, processor:Byte Ptr)

	Function bmx_wxhtmlprocessor_create:Byte Ptr(handle:Object)
	Function bmx_wxhtmlprocessor_enable(handle:Byte Ptr, value:Int)
	Function bmx_wxhtmlprocessor_isenabled:Int(handle:Byte Ptr)

	Function bmx_wxhtmllinkevent_getlinkinfo:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxhtmlcellevent_getpoint(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxhtmlcellevent_setlinkclicked(handle:Byte Ptr, clicked:Int)
	Function bmx_wxhtmlcellevent_getlinkclicked:Int(handle:Byte Ptr)
	Function bmx_wxhtmlcellevent_getcell:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxhtmllinkinfo_getevent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmllinkinfo_gethref:String(handle:Byte Ptr)
	Function bmx_wxhtmllinkinfo_gettarget:String(handle:Byte Ptr)
	Function bmx_wxhtmllinkinfo_delete(handle:Byte Ptr)

	Function bmx_wxhtmlevent_geteventtype:Int(evt:Int)
	
	Function bmx_wxhtmltagsmodule_create:Byte Ptr(handle:Object)
	
	Function bmx_wxhtmltaghandler_create:Byte Ptr(handle:Object)
	Function bmx_wxhtmltaghandler_getparser:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmltaghandler_parseinner(handle:Byte Ptr, tag:Byte Ptr)

	Function bmx_wxhtmlcontainercell_insertcell(handle:Byte Ptr, cell:Byte Ptr)
	Function bmx_wxhtmlwidgetcell_create:Byte Ptr(wnd:Byte Ptr, w:Int)

	Function bmx_wxhtmltag_delete(handle:Byte Ptr)
	Function bmx_wxhtmltag_getallparams:String(handle:Byte Ptr)
	Function bmx_wxhtmltag_getbeginpos:Int(handle:Byte Ptr)
	Function bmx_wxhtmltag_getendpos1:Int(handle:Byte Ptr)
	Function bmx_wxhtmltag_getendpos2:Int(handle:Byte Ptr)
	Function bmx_wxhtmltag_getname:String(handle:Byte Ptr)
	Function bmx_wxhtmltag_getparam:String(handle:Byte Ptr, par:String, withCommas:Int)
	Function bmx_wxhtmltag_getparamascolour:Byte Ptr(handle:Byte Ptr, par:String)
	Function bmx_wxhtmltag_getparamasint:Int(handle:Byte Ptr, par:String, value:Int Ptr)
	Function bmx_wxhtmltag_hasending:Int(handle:Byte Ptr)
	Function bmx_wxhtmltag_hasparam:Int(handle:Byte Ptr, par:String)

	Function bmx_wxhtmlparser_addtaghandler(handle:Byte Ptr, handler:Byte Ptr)

	Function bmx_wxhtmlwinparser_getcontainer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhtmlwinparser_getwindowinterface:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxhtmlwindowinterface_gethtmlwindow:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxhtmlwindow_addresourcehandler()
	
End Extern

Const wxHW_SCROLLBAR_NEVER:Int = $0002
Const wxHW_SCROLLBAR_AUTO:Int = $0004
Const wxHW_NO_SELECTION:Int = $0008
Const wxHW_DEFAULT_STYLE:Int = wxHW_SCROLLBAR_AUTO

Const wxHTML_OPEN:Int = 0
Const wxHTML_BLOCK:Int = 1
Const wxHTML_REDIRECT:Int = 2

Const wxHTML_ALIGN_LEFT:Int = $0000
Const wxHTML_ALIGN_RIGHT:Int = $0002
Const wxHTML_ALIGN_JUSTIFY:Int = $0010

Const wxHTML_ALIGN_TOP:Int = $0004
Const wxHTML_ALIGN_BOTTOM:Int = $0008

Const wxHTML_ALIGN_CENTER:Int = $0001

Const wxHTML_CLR_FOREGROUND:Int = $0001
Const wxHTML_CLR_BACKGROUND:Int = $0002

Const wxHTML_UNITS_PIXELS:Int = $0001
Const wxHTML_UNITS_PERCENT:Int = $0002

Const wxHTML_INDENT_LEFT:Int = $0010
Const wxHTML_INDENT_RIGHT:Int = $0020
Const wxHTML_INDENT_TOP:Int = $0040
Const wxHTML_INDENT_BOTTOM:Int = $0080

Const wxHTML_INDENT_HORIZONTAL:Int = wxHTML_INDENT_LEFT | wxHTML_INDENT_RIGHT
Const wxHTML_INDENT_VERTICAL:Int = wxHTML_INDENT_TOP | wxHTML_INDENT_BOTTOM
Const wxHTML_INDENT_ALL:Int = wxHTML_INDENT_VERTICAL | wxHTML_INDENT_HORIZONTAL

Const wxHTML_COND_ISANCHOR:Int = 1

Const wxHTML_COND_USER:Int = 10000


Const wxEVT_COMMAND_HTML_CELL_CLICKED:Int = 1000
Const wxEVT_COMMAND_HTML_CELL_HOVER:Int = 1001
Const wxEVT_COMMAND_HTML_LINK_CLICKED:Int = 1002

