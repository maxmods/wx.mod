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

Rem
bbdoc: wxTopLevelWindow
End Rem
Module wx.wxTopLevelWindow

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"



Rem
bbdoc: wxTopLevelWindow is a common base type for wxDialog and wxFrame.
about: It is an abstract base type meaning that you never work with objects of this type directly,
but all of its methods are also applicable for the two types above.
End Rem
Type wxTopLevelWindow Extends wxWindow

	Rem
	bbdoc: Returns true if the platform supports making the window translucent.
	End Rem
	Method CanSetTransparent:Int()
		Return bmx_wxtoplevelwindow_cansettransparent(wxObjectPtr)
	End Method

	Rem
	bbdoc: Centres the window on screen.
	about: This only works for top level windows - otherwise, the window will still be centered on its parent.
	End Rem
	Method CentreOnScreen(direction:Int = wxBOTH)
		bmx_wxtoplevelwindow_centreonscreen(wxObjectPtr, direction)
	End Method

	Rem
	bbdoc: Centers the window on screen.
	about: This only works for top level windows - otherwise, the window will still be centered on its parent.
	End Rem
	Method CenterOnScreen(direction:Int = wxBOTH)
		bmx_wxtoplevelwindow_centeronscreen(wxObjectPtr, direction)
	End Method

	Rem
	bbdoc: Enables or disables the Close button (most often in the right upper corner of a dialog) and the Close entry of the system menu (most often in the left upper corner of the dialog).
	about: Currently only implemented for wxMSW and wxGTK. Returns true if operation was successful. This may
	be wrong on X11 (including GTK+) where the window manager may not support this operation and there is no
	way to find out.
	End Rem
	Method EnableCloseButton:Int(value:Int)
		Return bmx_wxtoplevelwindow_enableclosebutton(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Returns the button which is the default for this window, or NULL.
	about: The default button is the one activated by pressing the Enter key.
	End Rem
	Method GetDefaultItem:wxWindow()
		Return wxWindow._find(bmx_wxtoplevelwindow_getdefaultitem(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the standard icon of the window.
	about: The icon will be invalid if it hadn't been previously set by SetIcon.
	End Rem
	Method GetIcon:wxIcon()
		Return wxIcon._create(bmx_wxtoplevelwindow_geticon(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns all icons associated with the window, there will be none of them if neither SetIcon nor SetIcons had been called before.
	about: Use GetIcon to get the main icon of the window.
	End Rem
	Method GetIcons:wxIconBundle()
		Return wxIconBundle._create(bmx_wxtoplevelwindow_geticons(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets a string containing the window title.
	End Rem
	Method GetTitle:String()
		Return bmx_wxtoplevelwindow_gettitle(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if this window is currently active, i.e. if the user is currently working with it.
	End Rem
	Method IsActive:Int()
		Return bmx_wxtoplevelwindow_isactive(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if this window is expected to be always maximized, either due to platform policy or due to local policy regarding particular class.
	End Rem
	Method IsAlwaysMaximized:Int()
		Return bmx_wxtoplevelwindow_isalwaysmaximized(wxObjectPtr)
	End Method

	Rem
	bbdoc: Iconizes or restores the window.
	End Rem
	Method Iconize(value:Int)
		bmx_wxtoplevelwindow_iconize(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Returns True if the window is in fullscreen mode.
	End Rem
	Method IsFullScreen:Int()
		Return bmx_wxtoplevelwindow_isfullscreen(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if the window is iconized.
	End Rem
	Method IsIconized:Int()
		Return bmx_wxtoplevelwindow_isiconized(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if the window is maximized.
	End Rem
	Method IsMaximized:Int()
		Return bmx_wxtoplevelwindow_ismaximized(wxObjectPtr)
	End Method

	Rem
	bbdoc: Maximizes or restores the window.
	End Rem
	Method Maximize(value:Int)
		bmx_wxtoplevelwindow_maximize(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Use a system-dependent way to attract users attention to the window when it is in background.
	about: @flags may have the value of either wxUSER_ATTENTION_INFO (default) or wxUSER_ATTENTION_ERROR
	which results in a more drastic action. When in doubt, use the default value.
	<p>
	Note that this function should normally be only used when the application is not already in foreground.
	</p>
	<p>
	This method is currently implemented for Win32 where it flashes the window icon in the taskbar,
	and for wxGTK with task bars supporting it.
	</p>
	End Rem
	Method RequestUserAttention(flags:Int = wxUSER_ATTENTION_INFO)
		bmx_wxtoplevelwindow_requestuserattention(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Changes the default item for the panel, usually @win is a button.
	End Rem
	Method SetDefaultItem(win:wxWindow)
		bmx_wxtoplevelwindow_setdefaultitem(wxObjectPtr, win.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the icon for this window.
	End Rem
	Method SetIcon(icon:wxIcon)
		bmx_wxtoplevelwindow_seticon(wxObjectPtr, icon.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets several icons of different sizes for this window.
	about: This allows to use different icons for different situations (e.g. task switching bar, taskbar,
	window title bar) instead of scaling, with possibly bad looking results, the only icon set by SetIcon.
	End Rem
	Method SetIcons(icons:wxIconBundle)
		bmx_wxtoplevelwindow_seticons(wxObjectPtr, icons.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: A simpler interface for setting the size hints than SetSizeHints.
	End Rem
	Method SetMaxSize(w:Int, h:Int)
		bmx_wxtoplevelwindow_setmaxsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: A simpler interface for setting the size hints than SetSizeHints.
	End Rem
	Method SetMinSize(w:Int, h:Int)
		bmx_wxtoplevelwindow_setminsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Allows specification of minimum and maximum window sizes.
	about: If this method is called, the user will not be able to size the window outside the given bounds.
	End Rem
	Method SetSizeHints(minW:Int, minH:Int, maxW:Int = -1, maxH:Int = -1)
		bmx_wxtoplevelwindow_setsizehints(wxObjectPtr, minW, minH, maxW, maxH)
	End Method
	
	Rem
	bbdoc: If the platform supports it, sets the shape of the window to that depicted by region.
	about: The system will not display or respond to any mouse event for the pixels that lie outside of the region.
	To reset the window to the normal rectangular shape simply call SetShape again with an empty region.
	Returns True if the operation is successful.
	End Rem
	Method SetShape:Int(region:wxRegion)
		Return bmx_wxtoplevelwindow_setshape(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the window title.
	End Rem
	Method SetTitle(title:String)
		bmx_wxtoplevelwindow_settitle(wxObjectPtr, title)
	End Method
	
	Rem
	bbdoc: If the platform supports it will set the window to be translucent.
	End Rem
	Method SetTransparent(alpha:Int)
		bmx_wxtoplevelwindow_settransparent(wxObjectPtr, alpha)
	End Method
	
	Rem
	bbdoc: This method is not meant to be called directly but can be overridden to return False (it returns true by default) to allow the application to close even if this, presumably not very important, window is still opened. By default, the application stays alive as long as there are any open top level windows.
	End Rem
	Method ShouldPreventAppExit:Int()
		Return True
	End Method
	
	Function _myShouldPreventAppExit:Int(window:Object)
		If wxTopLevelWindow(window) Then
			Return wxTopLevelWindow(window).ShouldPreventAppExit()
		End If
		
		Return True
	End Function
	
	Rem
	bbdoc: Depending on the value of show parameter the window is either shown full screen or restored to its normal state.
	about: @style is a bit list containing some or all of the following values, which indicate what elements
	of the window to hide in full-screen mode:
	<ul>
	<li>wxFULLSCREEN_NOMENUBAR</li>
	<li>wxFULLSCREEN_NOTOOLBAR</li>
	<li>wxFULLSCREEN_NOSTATUSBAR</li>
	<li>wxFULLSCREEN_NOBORDER</li>
	<li>wxFULLSCREEN_NOCAPTION</li>
	<li>wxFULLSCREEN_ALL (all of the above)</li>
	</ul>
	This method has not been tested with MDI frames.
	<p>
	Note that showing a window full screen also actually Show()s if it hadn't been shown yet.
	</p>
	End Rem
	Method ShowFullScreen:Int(show:Int, style:Int = wxFULLSCREEN_ALL)
		Return bmx_wxtoplevelwindow_showfullscreen(wxObjectPtr, show, style)
	End Method
'?macos
'	Method MacGetWindowRef:Byte Ptr()
'		Return bmx_wxtoplevelwindow_macgetwindowref(wxObjectPtr)
'	End Method
'?

End Type

Type TTopLevelWindowEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Select evt.eventType
			Case wxEVT_MAXIMIZE
				Return wxMaximizeEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_MAXIMIZE
				Return bmx_wxtoplevelwindow_geteventtype(eventType)
		End Select
	End Method

End Type

New TTopLevelWindowEventFactory

