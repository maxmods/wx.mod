' Copyright (c) 2007-2009 Bruce A Henderson
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
Import wx.wxWindow
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

	Function bmx_wxsplitterwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxsplitterwindow_getminimumpanesize:Int(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_getsashgravity:Double(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_getsashposition:Int(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_getsplitmode:Int(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_initialize(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsplitterwindow_issplit:Int(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_setsashgravity(handle:Byte Ptr, gravity:Double)
	Function bmx_wxsplitterwindow_setsashposition(handle:Byte Ptr, position:Int, redraw:Int)
	Function bmx_wxsplitterwindow_setsashsize(handle:Byte Ptr, size:Int)
	Function bmx_wxsplitterwindow_setminimumpanesize(handle:Byte Ptr, paneSize:Int)
	Function bmx_wxsplitterwindow_setsplitmode(handle:Byte Ptr, mode:Int)
	Function bmx_wxsplitterwindow_splithorizontally:Int(handle:Byte Ptr, window1:Byte Ptr, window2:Byte Ptr, sashPosition:Int)
	Function bmx_wxsplitterwindow_splitvertically:Int(handle:Byte Ptr, window1:Byte Ptr, window2:Byte Ptr, sashPosition:Int)
	Function bmx_wxsplitterwindow_updatesize(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_getwindow1:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_getwindow2:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsplitterwindow_replacewindow:Int(handle:Byte Ptr, oldwin:Byte Ptr, newwin:Byte Ptr)
	Function bmx_wxsplitterwindow_unsplit:Int(handle:Byte Ptr, rep:Byte Ptr)

	Function bmx_wxsplitterevent_getsashposition:Int(handle:Byte Ptr)
	Function bmx_wxsplitterevent_getx:Int(handle:Byte Ptr)
	Function bmx_wxsplitterevent_gety:Int(handle:Byte Ptr)
	Function bmx_wxsplitterevent_getwindowbeingremoved:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsplitterevent_setsashposition(handle:Byte Ptr, pos:Int)

	Function bmx_wxsplitterwindow_geteventtype:Int(evt:Int)
	
	Function bmx_wxsplitterwindow_addresourcehandler()
	
End Extern

Const wxSPLIT_HORIZONTAL:Int = 1
Const wxSPLIT_VERTICAL:Int = 2

Const wxSPLIT_DRAG_NONE:Int = 0
Const wxSPLIT_DRAG_DRAGGING:Int = 1
Const wxSPLIT_DRAG_LEFT_DOWN:Int = 2

Const wxSP_NOBORDER:Int = $0000
Const wxSP_NOSASH:Int = $0010
Const wxSP_PERMIT_UNSPLIT:Int = $0040
Const wxSP_LIVE_UPDATE:Int = $0080
Const wxSP_3DSASH:Int = $0100
Const wxSP_3DBORDER:Int = $0200
Const wxSP_NO_XP_THEME:Int = $0400
Const wxSP_BORDER:Int = wxSP_3DBORDER
Const wxSP_3D:Int = wxSP_3DBORDER | wxSP_3DSASH


Const wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED:Int = 850
Const wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING:Int = 851
Const wxEVT_COMMAND_SPLITTER_DOUBLECLICKED:Int = 852
Const wxEVT_COMMAND_SPLITTER_UNSPLIT:Int = 853

