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

Rem
bbdoc: wxSystemSettings
End Rem
Module wx.wxSystemSettings

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxSystemSettings allows the application to ask for details about the system.
about: This can include settings such as standard colours, fonts, and user interface element sizes.
End Rem
Type wxSystemSettings

	Rem
	bbdoc: Returns a system colour.
	about: @index can be one of:
	<table align="center" width="90%">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxSYS_COLOUR_SCROLLBAR</td><td>The scrollbar grey area. </td></tr>
	<tr><td>wxSYS_COLOUR_BACKGROUND</td><td>The desktop colour.</td></tr>
	<tr><td>wxSYS_COLOUR_ACTIVECAPTION</td><td>Active window caption. </td></tr>
	<tr><td>wxSYS_COLOUR_INACTIVECAPTION</td><td>Inactive window caption. </td></tr>
	<tr><td>wxSYS_COLOUR_MENU</td><td>Menu background. </td></tr>
	<tr><td>wxSYS_COLOUR_WINDOW</td><td>Window background. </td></tr>
	<tr><td>wxSYS_COLOUR_WINDOWFRAME</td><td>Window frame. </td></tr>
	<tr><td>wxSYS_COLOUR_MENUTEXT</td><td>Menu text. </td></tr>
	<tr><td>wxSYS_COLOUR_WINDOWTEXT</td><td>Text in windows. </td></tr>
	<tr><td>wxSYS_COLOUR_CAPTIONTEXT</td><td>Text in caption, size box and scrollbar arrow box. </td></tr>
	<tr><td>wxSYS_COLOUR_ACTIVEBORDER</td><td>Active window border.</td></tr>
	<tr><td>wxSYS_COLOUR_INACTIVEBORDER</td><td>Inactive window border.</td></tr>
	<tr><td>wxSYS_COLOUR_APPWORKSPACE</td><td>Background colour MDI applications. </td></tr>
	<tr><td>wxSYS_COLOUR_HIGHLIGHT</td><td>Item(s) selected in a control. </td></tr>
	<tr><td>wxSYS_COLOUR_HIGHLIGHTTEXT</td><td>Text of item(s) selected in a control. </td></tr>
	<tr><td>wxSYS_COLOUR_BTNFACE</td><td>Face shading on push buttons. </td></tr>
	<tr><td>wxSYS_COLOUR_BTNSHADOW</td><td>Edge shading on push buttons. </td></tr>
	<tr><td>wxSYS_COLOUR_GRAYTEXT</td><td>Greyed (disabled) text. </td></tr>
	<tr><td>wxSYS_COLOUR_BTNTEXT</td><td>Text on push buttons. </td></tr>
	<tr><td>wxSYS_COLOUR_INACTIVECAPTIONTEXT</td><td>Colour of text in active captions. </td></tr>
	<tr><td>wxSYS_COLOUR_BTNHIGHLIGHT</td><td>Highlight colour for buttons (same as wxSYS_COLOUR_3DHILIGHT). </td></tr>
	<tr><td>wxSYS_COLOUR_3DDKSHADOW</td><td>Dark shadow for three-dimensional display elements. </td></tr>
	<tr><td>wxSYS_COLOUR_3DLIGHT</td><td>Light colour for three-dimensional display elements. </td></tr>
	<tr><td>wxSYS_COLOUR_INFOTEXT</td><td>Text colour for tooltip controls. </td></tr>
	<tr><td>wxSYS_COLOUR_INFOBK</td><td>Background colour for tooltip controls. </td></tr>
	<tr><td>wxSYS_COLOUR_DESKTOP</td><td>Same as wxSYS_COLOUR_BACKGROUND. </td></tr>
	<tr><td>wxSYS_COLOUR_3DFACE</td><td>Same as wxSYS_COLOUR_BTNFACE.</td></tr>
	<tr><td>wxSYS_COLOUR_3DSHADOW</td><td>Same as wxSYS_COLOUR_BTNSHADOW.</td></tr>
	<tr><td>wxSYS_COLOUR_3DHIGHLIGHT</td><td>Same as wxSYS_COLOUR_BTNHIGHLIGHT.</td></tr>
	<tr><td>wxSYS_COLOUR_3DHILIGHT</td><td>Same as wxSYS_COLOUR_BTNHIGHLIGHT.</td></tr>
	<tr><td>wxSYS_COLOUR_BTNHILIGHT</td><td>Same as wxSYS_COLOUR_BTNHIGHLIGHT.</td></tr>
	</table>
	End Rem
	Function GetColour:wxColour(index:Int)
		Return wxColour._create(bmx_wxsystemsettings_getcolour(index))
	End Function
	
	Rem
	bbdoc: Returns a system font.
	about: @index can be one of:
	<table align="center" width="90%">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxSYS_OEM_FIXED_FONT</td><td>Original equipment manufacturer dependent fixed-pitch font. </td></tr>
	<tr><td>wxSYS_ANSI_FIXED_FONT</td><td>Windows fixed-pitch font. </td></tr>
	<tr><td>wxSYS_ANSI_VAR_FONT</td><td>Windows variable-pitch (proportional) font. </td></tr>
	<tr><td>wxSYS_SYSTEM_FONT</td><td>System font. </td></tr>
	<tr><td>wxSYS_DEVICE_DEFAULT_FONT</td><td>Device-dependent font (Windows NT only). </td></tr>
	<tr><td>wxSYS_DEFAULT_GUI_FONT</td><td>Default font for user interface objects such as menus and
	dialog boxes. Note that with modern GUIs nothing guarantees that the same font is used for all
	GUI elements, so some controls might use a different font by default. </td></tr>
	</table>
	End Rem
	Function GetFont:wxFont(index:Int)
		Return wxFont._create(bmx_wxsystemsettings_getfont(index))
	End Function
	
	Rem
	bbdoc: Returns the value of a system metric, or -1 if the metric is not supported on the current system.
	about: The value of win determines if the metric returned is a global value or a wxWindow based value,
	in which case it might determine the widget, the display the window is on, or something similar.
	The window given should be as close to the metric as possible (e.g a wxTopLevelWindow in case of
	the wxSYS_CAPTION_Y metric).
	<p>
	@index can be one of:
	<table align="center" width="90%">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxSYS_MOUSE_BUTTONS</td><td>Number of buttons on mouse, or zero if no mouse was installed. </td></tr>
	<tr><td>wxSYS_BORDER_X</td><td>Width of single border.</td></tr>
	<tr><td>wxSYS_BORDER_Y</td><td>Height of single border.</td></tr>
	<tr><td>wxSYS_CURSOR_X</td><td>Width of cursor.</td></tr>
	<tr><td>wxSYS_CURSOR_Y</td><td>Height of cursor.</td></tr>
	<tr><td>wxSYS_DCLICK_X</td><td>Width in pixels of rectangle within which two successive mouse clicks must fall to generate a double-click.</td></tr>
	<tr><td>wxSYS_DCLICK_Y</td><td>Height in pixels of rectangle within which two successive mouse clicks must fall to generate a double-click. </td></tr>
	<tr><td>wxSYS_DRAG_X</td><td>Width in pixels of a rectangle centered on a drag point to allow for limited movement of the mouse pointer before a drag operation begins. </td></tr>
	<tr><td>wxSYS_DRAG_Y</td><td>Height in pixels of a rectangle centered on a drag point to allow for limited movement of the mouse pointer before a drag operation begins. </td></tr>
	<tr><td>wxSYS_EDGE_X</td><td>Width of a 3D border, in pixels. </td></tr>
	<tr><td>wxSYS_EDGE_Y</td><td>Height of a 3D border, in pixels. </td></tr>
	<tr><td>wxSYS_HSCROLL_ARROW_X</td><td>Width of arrow bitmap on horizontal scrollbar.</td></tr>
	<tr><td>wxSYS_HSCROLL_ARROW_Y</td><td>Height of arrow bitmap on horizontal scrollbar.</td></tr>
	<tr><td>wxSYS_HTHUMB_X</td><td>Width of horizontal scrollbar thumb. </td></tr>
	<tr><td>wxSYS_ICON_X</td><td>The default width of an icon. </td></tr>
	<tr><td>wxSYS_ICON_Y</td><td>The default height of an icon. </td></tr>
	<tr><td>wxSYS_ICONSPACING_X</td><td>Width of a grid cell for items in large icon view, in pixels. Each item fits into a rectangle of this size when arranged.</td></tr>
	<tr><td>wxSYS_ICONSPACING_Y</td><td>Height of a grid cell for items in large icon view, in pixels. Each item fits into a rectangle of this size when arranged.</td></tr>
	<tr><td>wxSYS_WINDOWMIN_X</td><td>Minimum width of a window.</td></tr>
	<tr><td>wxSYS_WINDOWMIN_Y</td><td>Minimum height of a window.</td></tr>
	<tr><td>wxSYS_SCREEN_X</td><td>Width of the screen in pixels. </td></tr>
	<tr><td>wxSYS_SCREEN_Y</td><td>Height of the screen in pixels. </td></tr>
	<tr><td>wxSYS_FRAMESIZE_X</td><td>Width of the window frame for a wxTHICK_FRAME window.</td></tr>
	<tr><td>wxSYS_FRAMESIZE_Y</td><td>Height of the window frame for a wxTHICK_FRAME window.</td></tr>
	<tr><td>wxSYS_SMALLICON_X</td><td>Recommended width of a small icon (in window captions, and small icon view).</td></tr>
	<tr><td>wxSYS_SMALLICON_Y</td><td>Recommended height of a small icon (in window captions, and small icon view). </td></tr>
	<tr><td>wxSYS_HSCROLL_Y</td><td>Height of horizontal scrollbar in pixels. </td></tr>
	<tr><td>wxSYS_VSCROLL_X</td><td>Width of vertical scrollbar in pixels. </td></tr>
	<tr><td>wxSYS_VSCROLL_ARROW_X</td><td>Width of arrow bitmap on a vertical scrollbar.</td></tr>
	<tr><td>wxSYS_VSCROLL_ARROW_Y</td><td>Height of arrow bitmap on a vertical scrollbar.</td></tr>
	<tr><td>wxSYS_VTHUMB_Y</td><td>Height of vertical scrollbar thumb. </td></tr>
	<tr><td>wxSYS_CAPTION_Y</td><td>Height of normal caption area. </td></tr>
	<tr><td>wxSYS_MENU_Y</td><td>Height of single-line menu bar.</td></tr>
	<tr><td>wxSYS_NETWORK_PRESENT</td><td>1 if there is a network present, 0 otherwise. </td></tr>
	<tr><td>wxSYS_PENWINDOWS_PRESENT</td><td>1 if PenWindows is installed, 0 otherwise. </td></tr>
	<tr><td>wxSYS_SHOW_SOUNDS</td><td>Non-zero if the user requires an application to present information visually in situations where it would otherwise present the information only in audible form; zero otherwise. </td></tr>
	<tr><td>wxSYS_SWAP_BUTTONS</td><td>Non-zero if the meanings of the left and right mouse buttons are swapped; zero otherwise. </td></tr>
	</table>
	</p>
	@window is a reference to the window for which the metric is requested. Specifying the win parameter
	is encouraged, because some metrics on some ports are not supported without one, or they might be
	capable of reporting better values if given one. If a window does not make sense for a metric,
	one should still be given, as for example it might determine which displays cursor width is
	requested with wxSYS_CURSOR_X.
	End Rem
	Function GetMetric:Int(index:Int, window:wxWindow = Null)
		If window Then
			Return bmx_wxsystemsettings_getmetric(index, window.wxObjectPtr)
		Else
			Return bmx_wxsystemsettings_getmetric(index, Null)
		End If
	End Function
	
	Rem
	bbdoc: Returns the screen type.
	about: The return value is one of:
	<table align="center" width="90%">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxSYS_SCREEN_NONE</td><td>Undefined screen type </td></tr>
	<tr><td>wxSYS_SCREEN_TINY</td><td>Tiny screen, less than 320x240 </td></tr>
	<tr><td>wxSYS_SCREEN_PDA</td><td>PDA screen, 320x240 or more but less than 640x480 </td></tr>
	<tr><td>wxSYS_SCREEN_SMALL</td><td>Small screen, 640x480 or more but less than 800x600 </td></tr>
	<tr><td>wxSYS_SCREEN_DESKTOP</td><td>Desktop screen, 800x600 or more </td></tr>
	</table>
	End Rem
	Function GetScreenType:Int()
		Return bmx_wxsystemsettings_getscreentype()
	End Function

End Type


