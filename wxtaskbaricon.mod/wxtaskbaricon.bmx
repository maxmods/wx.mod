' Copyright (c) 2007,2008 Bruce A Henderson & Oliver Skawronek
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
bbdoc: wxTaskBarIcon
End Rem
Module wx.wxTaskBarIcon

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
bbdoc: This class represents a taskbar icon.
about: A taskbar icon is an icon that appears in the 'system tray' and
responds to mouse clicks, optionally with a tooltip above it to help provide information.
<p>
X Window System Note:<br />
Under X Window System, the window manager must support either the System Tray Protocol
by freedesktop.org (WMs used by modern desktop environments such as GNOME >= 2, KDE >= 3
and XFCE >= 4 all do) or the older methods used in GNOME 1.2 and KDE 1 and 2. If it doesn't,
the icon will appear as a toplevel window on user's desktop.
</p>
<p>
Because not all window managers have system tray, there's no guarantee that wxTaskBarIcon will
work correctly under X Window System and so the applications should use it only as an optional
component of their user interface. The user should be required to explicitly enable the taskbar
icon on Unix, it shouldn't be on by default.
</p>
End Rem
Type wxTaskBarIcon Extends wxEvtHandler

	' creates a "soft link" to a wxMenu*
	Function _create:wxTaskBarIcon(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxTaskBarIcon = New wxTaskBarIcon
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _find:wxTaskBarIcon(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local taskBarIcon:wxTaskBarIcon = wxTaskBarIcon(wxfind(wxObjectPtr))
			If Not taskBarIcon Then
				Return _create(wxObjectPtr)
			End If
			Return taskBarIcon
		End If
	End Function

	Rem
	bbdoc: Constructs a #wxTaskBarIcon object.
	about: TODO
	End Rem
	Function CreateTaskBarIcon:wxTaskBarIcon()
		Return New wxTaskBarIcon.Create()
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxTaskBarIcon()
		wxObjectPtr = bmx_wxtaskbaricon_create(Self)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: This method is called by the library when the user requests popup menu.
	about: On Windows and Unix platforms, this is when the user right-clicks the icon.
	<p>
	Override this function in order to provide popup menu associated with the icon.
	</p>
	<p>
    If CreatePopupMenu returns NULL (this happens by default), no menu is shown, otherwise the menu is displayed
    and then deleted by the library as soon as the user dismisses it. The events can be handled by a class derived
    from wxTaskBarIcon.
	</p>
	End Rem
	Method CreatePopupMenu:wxMenu()
		Return Null
	End Method
	
	Function _CreatePopupMenu:Byte Ptr(taskbaricon:wxTaskBarIcon)
		Local menu:wxMenu = taskbaricon.CreatePopupMenu()
		If menu Then
			Return menu.wxObjectPtr
		Else
			Return Null
		End If
	End Function
	
	Rem
	bbdoc: Returns true if SetIcon was called with no subsequent RemoveIcon.
	about: TODO
	End Rem
	Method IsIconInstalled:Int()
		Return bmx_wxtaskbaricon_isiconinstalled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the object initialized successfully.
	about: TODO
	End Rem
	Method IsOk:Int()
		Return bmx_wxtaskbaricon_isok(wxObjectPtr)
	End Method
	
'	Rem
'	bbdoc: Pops up a menu at the current mouse position.
'	about: The events can be handled by a class derived from #wxTaskBarIcon.
'	It is recommended To override #CreatePopupMenu callback instead of calling this Method from event handler,
'	because some ports (e.g. wxCocoa) May Not implement PopupMenu And mouse click events at all.
'	End Rem
'	Method PopupMenu:Int(menu:wxMenu)
'		Return bmx_wxtaskbaricon_popupmenu(wxObjectPtr, menu.wxObjectPtr)
'	End Method
	
	Rem
	bbdoc: Removes the icon previously set with SetIcon.
	about: TODO
	End Rem
	Method RemoveIcon:Int()
		Return bmx_wxtaskbaricon_removeicon(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the icon, and optional tooltip text.
	about: TODO
	End Rem
	Method SetIcon:Int(icon:wxIcon, tooltip:String)
		Return bmx_wxtaskbaricon_seticon(wxObjectPtr, icon.wxObjectPtr, tooltip)
	End Method

	Rem
	bbdoc: Deletes this TaskBarIcon
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxtaskbaricon_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Rem
	bbdoc: Returns true if system tray is available in the desktop environment the app runs under.
	about: On Windows and Mac OS X, the tray is always available and this function simply returns true.
	<p>
	On Unix, X11 environment may or may not provide the tray, depending on user's desktop environment.
	Most modern desktops support the tray via the System Tray Protocol by
	freedesktop.org (<a href="http://freedesktop.org/wiki/Specifications/systemtray-spec">http://freedesktop.org/wiki/Specifications/systemtray-spec</a>).
	</p>
	End Rem
	Function IsAvailable:Int()
		Return bmx_wxtaskbaricon_isavailable()
	End Function
	
End Type


Type wxTaskBarIconEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxTaskBarIconEvent = New wxTaskBarIconEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
End Type

Type TTaskBarIconEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_TASKBAR_MOVE, ..
					wxEVT_TASKBAR_LEFT_DOWN, ..
					wxEVT_TASKBAR_LEFT_UP, ..
					wxEVT_TASKBAR_RIGHT_DOWN, ..
					wxEVT_TASKBAR_RIGHT_UP, ..
					wxEVT_TASKBAR_LEFT_DCLICK, ..
					wxEVT_TASKBAR_RIGHT_DCLICK
				Return wxTaskBarIconEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_TASKBAR_MOVE, ..
					wxEVT_TASKBAR_LEFT_DOWN, ..
					wxEVT_TASKBAR_LEFT_UP, ..
					wxEVT_TASKBAR_RIGHT_DOWN, ..
					wxEVT_TASKBAR_RIGHT_UP, ..
					wxEVT_TASKBAR_LEFT_DCLICK, ..
					wxEVT_TASKBAR_RIGHT_DCLICK
				Return bmx_wxtaskbariconevent_geteventtype(eventType)
		End Select
	End Method
	
End Type

New TTaskBarIconEventFactory
