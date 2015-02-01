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
	Function bmx_wxsystemsettings_getcolour:Byte Ptr(index:Int)
	Function bmx_wxsystemsettings_getfont:Byte Ptr(index:Int)
	Function bmx_wxsystemsettings_getmetric:Int(index:Int, window:Byte Ptr)
	Function bmx_wxsystemsettings_getscreentype:Int()

End Extern


Const wxSYS_OEM_FIXED_FONT:Int = 10
Const wxSYS_ANSI_FIXED_FONT:Int = 11
Const wxSYS_ANSI_VAR_FONT:Int = 12
Const wxSYS_SYSTEM_FONT:Int = 13
Const wxSYS_DEVICE_DEFAULT_FONT:Int = 14
Const wxSYS_DEFAULT_PALETTE:Int = 15
Const wxSYS_SYSTEM_FIXED_FONT:Int = 16
Const wxSYS_DEFAULT_GUI_FONT:Int = 17

Const wxSYS_COLOUR_SCROLLBAR:Int = 0
Const wxSYS_COLOUR_BACKGROUND:Int = 1
Const wxSYS_COLOUR_DESKTOP:Int = wxSYS_COLOUR_BACKGROUND
Const wxSYS_COLOUR_ACTIVECAPTION:Int = 2
Const wxSYS_COLOUR_INACTIVECAPTION:Int = 3
Const wxSYS_COLOUR_MENU:Int = 4
Const wxSYS_COLOUR_WINDOW:Int = 5
Const wxSYS_COLOUR_WINDOWFRAME:Int = 6
Const wxSYS_COLOUR_MENUTEXT:Int = 7
Const wxSYS_COLOUR_WINDOWTEXT:Int = 8
Const wxSYS_COLOUR_CAPTIONTEXT:Int = 9
Const wxSYS_COLOUR_ACTIVEBORDER:Int = 10
Const wxSYS_COLOUR_INACTIVEBORDER:Int = 11
Const wxSYS_COLOUR_APPWORKSPACE:Int = 12
Const wxSYS_COLOUR_HIGHLIGHT:Int = 13
Const wxSYS_COLOUR_HIGHLIGHTTEXT:Int = 14
Const wxSYS_COLOUR_BTNFACE:Int = 15
Const wxSYS_COLOUR_3DFACE:Int = wxSYS_COLOUR_BTNFACE
Const wxSYS_COLOUR_BTNSHADOW:Int = 16
Const wxSYS_COLOUR_3DSHADOW:Int = wxSYS_COLOUR_BTNSHADOW
Const wxSYS_COLOUR_GRAYTEXT:Int = 17
Const wxSYS_COLOUR_BTNTEXT:Int = 18
Const wxSYS_COLOUR_INACTIVECAPTIONTEXT:Int = 19
Const wxSYS_COLOUR_BTNHIGHLIGHT:Int = 20
Const wxSYS_COLOUR_BTNHILIGHT:Int = wxSYS_COLOUR_BTNHIGHLIGHT
Const wxSYS_COLOUR_3DHIGHLIGHT:Int = wxSYS_COLOUR_BTNHIGHLIGHT
Const wxSYS_COLOUR_3DHILIGHT:Int = wxSYS_COLOUR_BTNHIGHLIGHT
Const wxSYS_COLOUR_3DDKSHADOW:Int = 21
Const wxSYS_COLOUR_3DLIGHT:Int = 22
Const wxSYS_COLOUR_INFOTEXT:Int = 23
Const wxSYS_COLOUR_INFOBK:Int = 24
Const wxSYS_COLOUR_LISTBOX:Int = 25
Const wxSYS_COLOUR_HOTLIGHT:Int = 26
Const wxSYS_COLOUR_GRADIENTACTIVECAPTION:Int = 27
Const wxSYS_COLOUR_GRADIENTINACTIVECAPTION:Int = 28
Const wxSYS_COLOUR_MENUHILIGHT:Int = 29
Const wxSYS_COLOUR_MENUBAR:Int = 30

Const wxSYS_MOUSE_BUTTONS:Int = 1
Const wxSYS_BORDER_X:Int = 2
Const wxSYS_BORDER_Y:Int = 3
Const wxSYS_CURSOR_X:Int = 4
Const wxSYS_CURSOR_Y:Int = 5
Const wxSYS_DCLICK_X:Int = 6
Const wxSYS_DCLICK_Y:Int = 7
Const wxSYS_DRAG_X:Int = 8
Const wxSYS_DRAG_Y:Int = 9
Const wxSYS_EDGE_X:Int = 10
Const wxSYS_EDGE_Y:Int = 11
Const wxSYS_HSCROLL_ARROW_X:Int = 12
Const wxSYS_HSCROLL_ARROW_Y:Int = 13
Const wxSYS_HTHUMB_X:Int = 14
Const wxSYS_ICON_X:Int = 15
Const wxSYS_ICON_Y:Int = 16
Const wxSYS_ICONSPACING_X:Int = 17
Const wxSYS_ICONSPACING_Y:Int = 18
Const wxSYS_WINDOWMIN_X:Int = 19
Const wxSYS_WINDOWMIN_Y:Int = 20
Const wxSYS_SCREEN_X:Int = 21
Const wxSYS_SCREEN_Y:Int = 22
Const wxSYS_FRAMESIZE_X:Int = 23
Const wxSYS_FRAMESIZE_Y:Int = 24
Const wxSYS_SMALLICON_X:Int = 25
Const wxSYS_SMALLICON_Y:Int = 26
Const wxSYS_HSCROLL_Y:Int = 27
Const wxSYS_VSCROLL_X:Int = 28
Const wxSYS_VSCROLL_ARROW_X:Int = 29
Const wxSYS_VSCROLL_ARROW_Y:Int = 30
Const wxSYS_VTHUMB_Y:Int = 31
Const wxSYS_CAPTION_Y:Int = 32
Const wxSYS_MENU_Y:Int = 33
Const wxSYS_NETWORK_PRESENT:Int = 34
Const wxSYS_PENWINDOWS_PRESENT:Int = 35
Const wxSYS_SHOW_SOUNDS:Int = 36
Const wxSYS_SWAP_BUTTONS:Int = 37


Const wxSYS_SCREEN_NONE:Int = 0  '   Not yet defined
Const wxSYS_SCREEN_TINY:Int = 1      '   <
Const wxSYS_SCREEN_PDA:Int = 2       '   >= 320x240
Const wxSYS_SCREEN_SMALL:Int = 3     '   >= 640x480
Const wxSYS_SCREEN_DESKTOP:Int = 4    '   >= 800x600




