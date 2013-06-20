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
Import wx.wxBitmap
Import wx.wxDC
Import wx.wxBookCtrlBase
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
	Function bmx_wxauimanager_create:Byte Ptr(handle:Object, window:Byte Ptr, flags:Int)
	Function bmx_wxauimanager_addpane:Int(handle:Byte Ptr, window:Byte Ptr, direction:Int, caption:String)
	Function bmx_wxauimanager_addpaneinfo:Int(handle:Byte Ptr, window:Byte Ptr, panelinfo:Byte Ptr, dx:Int, dy:Int)
	Function bmx_wxauimanager_detachpane:Int(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxauimanager_getdocksizeconstraint(handle:Byte Ptr, width:Double Ptr, height:Double Ptr)
	Function bmx_wxauimanager_getflags:Int(handle:Byte Ptr)
	Function bmx_wxauimanager_getmanagedwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauimanager_getmanager:Byte Ptr(window:Byte Ptr)
	Function bmx_wxauimanager_getpane:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxauimanager_getpanewindow:Byte Ptr(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxauimanager_hidehint(handle:Byte Ptr)
	Function bmx_wxauimanager_insertpane:Int(handle:Byte Ptr, window:Byte Ptr, location:Byte Ptr, level:Int)
	Function bmx_wxauimanager_loadpaneinfo:Byte Ptr(handle:Byte Ptr, panePart:String)
	Function bmx_wxauimanager_loadperspective:Int(handle:Byte Ptr, perspective:String, update:Int)
	Function bmx_wxauimanager_savepaneinfo:String(handle:Byte Ptr, info:Byte Ptr)
	Function bmx_wxauimanager_saveperspective:String(handle:Byte Ptr)
	Function bmx_wxauimanager_setdocksizeconstraint(handle:Byte Ptr, width:Double, height:Double)
	Function bmx_wxauimanager_setflags(handle:Byte Ptr, flags:Int)
	Function bmx_wxauimanager_setmanagedwindow(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxauimanager_showhint(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxauimanager_uninit(handle:Byte Ptr)
	Function bmx_wxauimanager_update(handle:Byte Ptr)
	Function bmx_wxauimanager_getartprovider:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauimanager_setartprovider(handle:Byte Ptr, artProvider:Byte Ptr)

	Function bmx_wxauipaneinfo_create:Byte Ptr()
	Function bmx_wxauipaneinfo_delete(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_bestsize:Byte Ptr(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxauipaneinfo_bottom:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_bottomdockable:Byte Ptr(handle:Byte Ptr, dockable:Int)
	Function bmx_wxauipaneinfo_caption:Byte Ptr(handle:Byte Ptr, caption:String)
	Function bmx_wxauipaneinfo_captionvisible:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_centre:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_center:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_centrepane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_centerpane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_closebutton:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_defaultpane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_destroyonclose:Byte Ptr(handle:Byte Ptr, dest:Int)
	Function bmx_wxauipaneinfo_direction:Byte Ptr(handle:Byte Ptr, dir:Int)
	Function bmx_wxauipaneinfo_dock:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_dockable:Byte Ptr(handle:Byte Ptr, dock:Int)
	Function bmx_wxauipaneinfo_fixed:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_floatpane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_floatable:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_floatingposition:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxauipaneinfo_floatingsize:Byte Ptr(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxauipaneinfo_gripper:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_grippertop:Byte Ptr(handle:Byte Ptr, attop:Int)
	
	Function bmx_wxauipaneinfo_hasborder:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hascaption:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hasclosebutton:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hasflag:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxauipaneinfo_hasgripper:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hasgrippertop:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hasmaximizebutton:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_hasminimizebutton:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_haspinbutton:Int(handle:Byte Ptr)
	
	Function bmx_wxauipaneinfo_hide:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isbottomdockable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isdocked:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isfixed:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isfloatable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isfloating:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isleftdockable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_ismovable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isok:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isresizable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isrightdockable:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_isshown:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_istoolbar:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_istopdockable:Int(handle:Byte Ptr)
	
	Function bmx_wxauipaneinfo_layer:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_left:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_leftdockable:Byte Ptr(handle:Byte Ptr, dockable:Int)
	Function bmx_wxauipaneinfo_maxsize:Byte Ptr(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxauipaneinfo_maximizebutton:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_minsize:Byte Ptr(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxauipaneinfo_minimizebutton:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_movable:Byte Ptr(handle:Byte Ptr, move:Int)
	Function bmx_wxauipaneinfo_name:Byte Ptr(handle:Byte Ptr, n:String)
	Function bmx_wxauipaneinfo_paneborder:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_pinbutton:Byte Ptr(handle:Byte Ptr, visible:Int)
	Function bmx_wxauipaneinfo_position:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxauipaneinfo_resizable:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_right:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_rightdockable:Byte Ptr(handle:Byte Ptr, dockable:Int)
	Function bmx_wxauipaneinfo_row:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_safeset(handle:Byte Ptr, info:Byte Ptr)
	Function bmx_wxauipaneinfo_setflag:Byte Ptr(handle:Byte Ptr, flag:Int, optionState:Int)
	Function bmx_wxauipaneinfo_show:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_toolbarpane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_top:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_topdocakable:Byte Ptr(handle:Byte Ptr, value:Int)
	Function bmx_wxauipaneinfo_window:Byte Ptr(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxauipaneinfo_dockfixed:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxauipaneinfo_getcaption:String(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getname:String(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getstate:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getdirection:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getlayer:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getrow:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getpos:Int(handle:Byte Ptr)
	Function bmx_wxauipaneinfo_getfloatingpos(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxauipaneinfo_getfloatingsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxauipaneinfo_getwindow:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxauimanagerevent_getpane:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_getbutton:Int(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_veto(handle:Byte Ptr, veto:Int)
	Function bmx_wxauimanagerevent_getmanager:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_getdc:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_getveto:Int(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_canveto:Int(handle:Byte Ptr)
	Function bmx_wxauimanagerevent_setcanveto(handle:Byte Ptr, canVeto:Int)

	Function bmx_wxauidockart_getmetric:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxauidockart_getcolor:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxauidockart_getcolour:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxauidockart_setmetric(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxauidockart_setcolor(handle:Byte Ptr, id:Int, colour:Byte Ptr)
	Function bmx_wxauidockart_setcolour(handle:Byte Ptr, id:Int, colour:Byte Ptr)
	Function bmx_wxauidockart_getfont:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxauidockart_setfont(handle:Byte Ptr, id:Int, font:Byte Ptr)

	Function bmx_wxauinotebook_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxauinotebook_addpage:Int(handle:Byte Ptr, page:Byte Ptr, caption:String, sel:Int, bitmap:Byte Ptr)

	Function bmx_wxauinotebook_advanceselection(handle:Byte Ptr, forward:Int)
	Function bmx_wxauinotebook_deletepage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_getartprovider:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxauinotebook_getheightforpageheight:Int(handle:Byte Ptr, pageHeight:Int)
	Function bmx_wxauinotebook_getpage:Byte Ptr(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_getpagebitmap:Byte Ptr(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_getpagecount:Int(handle:Byte Ptr)
	Function bmx_wxauinotebook_getpageindex:Int(handle:Byte Ptr, page:Byte Ptr)
	Function bmx_wxauinotebook_getpagetext:String(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_getselection:Int(handle:Byte Ptr)
	Function bmx_wxauinotebook_gettabctrlheight:Int(handle:Byte Ptr)
	Function bmx_wxauinotebook_insertpage:Int(handle:Byte Ptr, index:Int, page:Byte Ptr, caption:String, sel:Int, bitmap:Byte Ptr)
	Function bmx_wxauinotebook_removepage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_setartprovider(handle:Byte Ptr, art:Byte Ptr)
	Function bmx_wxauinotebook_setfont:Int(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxauinotebook_setnormalfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxauinotebook_setselectedfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxauinotebook_setmeasuringfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxauinotebook_setpagebitmap:Int(handle:Byte Ptr, page:Int, bitmap:Byte Ptr)
	Function bmx_wxauinotebook_setpagetext:Int(handle:Byte Ptr, page:Int, text:String)
	Function bmx_wxauinotebook_setselection:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxauinotebook_settabctrlheight(handle:Byte Ptr, height:Int)
	Function bmx_wxauinotebook_setuniformbitmapsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxauinotebook_split(handle:Byte Ptr, page:Int, direction:Int)
	Function bmx_wxauinotebook_showwindowmenu:Int(handle:Byte Ptr)

	Function bmx_wxaui_geteventtype:Int(evt:Int)
	
End Extern


Const wxAUI_DOCK_NONE:Int = 0
Const wxAUI_DOCK_TOP:Int = 1
Const wxAUI_DOCK_RIGHT:Int = 2
Const wxAUI_DOCK_BOTTOM:Int = 3
Const wxAUI_DOCK_LEFT:Int = 4
Const wxAUI_DOCK_CENTER:Int = 5
Const wxAUI_DOCK_CENTRE:Int = wxAUI_DOCK_CENTER

Const wxAUI_MGR_ALLOW_FLOATING:Int = 1 Shl 0
Const wxAUI_MGR_ALLOW_ACTIVE_PANE:Int = 1 Shl 1
Const wxAUI_MGR_TRANSPARENT_DRAG:Int = 1 Shl 2
Const wxAUI_MGR_TRANSPARENT_HINT:Int = 1 Shl 3
Const wxAUI_MGR_VENETIAN_BLINDS_HINT:Int = 1 Shl 4
Const wxAUI_MGR_RECTANGLE_HINT:Int = 1 Shl 5
Const wxAUI_MGR_HINT_FADE:Int = 1 Shl 6
Const wxAUI_MGR_NO_VENETIAN_BLINDS_FADE:Int = 1 Shl 7

Const wxAUI_MGR_DEFAULT:Int = wxAUI_MGR_ALLOW_FLOATING | wxAUI_MGR_TRANSPARENT_HINT | wxAUI_MGR_HINT_FADE | ..
		wxAUI_MGR_NO_VENETIAN_BLINDS_FADE

Const wxAUI_INSERT_PANE:Int = 0
Const wxAUI_INSERT_ROW:Int = 1
Const wxAUI_INSERT_DOCK:Int = 2


Const wxAUI_DOCKART_SASH_SIZE:Int = 0
Const wxAUI_DOCKART_CAPTION_SIZE:Int = 1
Const wxAUI_DOCKART_GRIPPER_SIZE:Int = 2
Const wxAUI_DOCKART_PANE_BORDER_SIZE:Int = 3
Const wxAUI_DOCKART_PANE_BUTTON_SIZE:Int = 4
Const wxAUI_DOCKART_BACKGROUND_COLOUR:Int = 5
Const wxAUI_DOCKART_SASH_COLOUR:Int = 6
Const wxAUI_DOCKART_ACTIVE_CAPTION_COLOUR:Int = 7
Const wxAUI_DOCKART_ACTIVE_CAPTION_GRADIENT_COLOUR:Int = 8
Const wxAUI_DOCKART_INACTIVE_CAPTION_COLOUR:Int = 9
Const wxAUI_DOCKART_INACTIVE_CAPTION_GRADIENT_COLOUR:Int = 10
Const wxAUI_DOCKART_ACTIVE_CAPTION_TEXT_COLOUR:Int = 11
Const wxAUI_DOCKART_INACTIVE_CAPTION_TEXT_COLOUR:Int = 12
Const wxAUI_DOCKART_BORDER_COLOUR:Int = 13
Const wxAUI_DOCKART_GRIPPER_COLOUR:Int = 14
Const wxAUI_DOCKART_CAPTION_FONT:Int = 15
Const wxAUI_DOCKART_GRADIENT_TYPE:Int = 16

Const wxAUI_GRADIENT_NONE:Int = 0
Const wxAUI_GRADIENT_VERTICAL:Int = 1
Const wxAUI_GRADIENT_HORIZONTAL:Int = 2

Const wxAUI_BUTTON_STATE_NORMAL:Int = 0
Const wxAUI_BUTTON_STATE_HOVER:Int = 1
Const wxAUI_BUTTON_STATE_PRESSED:Int = 2

Const wxAUI_BUTTON_CLOSE:Int = 101
Const wxAUI_BUTTON_MAXIMIZE_RESTORE:Int = 102
Const wxAUI_BUTTON_MINIMIZE:Int = 103
Const wxAUI_BUTTON_PIN:Int = 104
Const wxAUI_BUTTON_OPTIONS:Int = 105
Const wxAUI_BUTTON_WINDOWLIST:Int = 106
Const wxAUI_BUTTON_LEFT:Int = 107
Const wxAUI_BUTTON_RIGHT:Int = 108
Const wxAUI_BUTTON_UP:Int = 109
Const wxAUI_BUTTON_DOWN:Int = 110
Const wxAUI_BUTTON_CUSTOM1:Int = 201
Const wxAUI_BUTTON_CUSTOM2:Int = 202
Const wxAUI_BUTTON_CUSTOM3:Int = 203

Const wxAUI_NB_TOP:Int = 1 Shl 0
Const wxAUI_NB_LEFT:Int = 1 Shl 1
Const wxAUI_NB_RIGHT:Int = 1 Shl 2
Const wxAUI_NB_BOTTOM:Int = 1 Shl 3
Const wxAUI_NB_TAB_SPLIT:Int = 1 Shl 4
Const wxAUI_NB_TAB_MOVE:Int = 1 Shl 5
Const wxAUI_NB_TAB_EXTERNAL_MOVE:Int = 1 Shl 6
Const wxAUI_NB_TAB_FIXED_WIDTH:Int = 1 Shl 7
Const wxAUI_NB_SCROLL_BUTTONS:Int = 1 Shl 8
Const wxAUI_NB_WINDOWLIST_BUTTON:Int = 1 Shl 9
Const wxAUI_NB_CLOSE_BUTTON:Int = 1 Shl 10
Const wxAUI_NB_CLOSE_ON_ACTIVE_TAB:Int = 1 Shl 11
Const wxAUI_NB_CLOSE_ON_ALL_TABS:Int = 1 Shl 12

Const wxAUI_NB_DEFAULT_STYLE:Int = wxAUI_NB_TOP | wxAUI_NB_TAB_SPLIT | wxAUI_NB_TAB_MOVE | ..
		wxAUI_NB_SCROLL_BUTTONS | wxAUI_NB_CLOSE_ON_ACTIVE_TAB

Const wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE:Int = -20
Const wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSED:Int = -21
Const wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED:Int = -22
Const wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING:Int = -23
Const wxEVT_COMMAND_AUINOTEBOOK_BUTTON:Int = -24
Const wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG:Int = -25
Const wxEVT_COMMAND_AUINOTEBOOK_END_DRAG:Int = -26
Const wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION:Int = -27
Const wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND:Int = -28

Const wxEVT_AUI_PANE_BUTTON:Int = -29
Const wxEVT_AUI_PANE_CLOSE:Int = -30
Const wxEVT_AUI_PANE_MAXIMIZE:Int = -31
Const wxEVT_AUI_PANE_RESTORE:Int = -32
Const wxEVT_AUI_RENDER:Int = -33
Const wxEVT_AUI_FIND_MANAGER:Int = -34

Const wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_DOWN:Int = -35
Const wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_UP:Int = -36
Const wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_DOWN:Int = -37
Const wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_UP:Int = -38
Const wxEVT_COMMAND_AUINOTEBOOK_DRAG_DONE:Int = -39
Const wxEVT_COMMAND_AUINOTEBOOK_BG_DCLICK:Int = -40

