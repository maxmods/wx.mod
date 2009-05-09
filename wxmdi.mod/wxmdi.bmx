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
bbdoc: wxMDI
End Rem
Module wx.wxMDI

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
bbdoc: An MDI (Multiple Document Interface) parent frame is a window which can contain MDI child frames in its own 'desktop'.
about: It is a convenient way to avoid window clutter, and is used in many popular Windows
applications, such as Microsoft Word(TM).
End Rem
Type wxMDIParentFrame Extends wxFrame

	' soft linking
	Function _create:wxMDIParentFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMDIParentFrame = New wxMDIParentFrame
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxMDIParentFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxMDIParentFrame = wxMDIParentFrame(wxfind(wxObjectPtr))
			If Not window Then
				Return wxMDIParentFrame._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Function _xrcNew:wxMDIParentFrame(wxObjectPtr:Byte Ptr)
		Return wxMDIParentFrame._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateMDIParentFrame:wxMDIParentFrame(parent:wxWindow = Null, id:Int = wxID_ANY, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL)
		Return New wxMDIParentFrame.Create(parent, id, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMDIParentFrame(parent:wxWindow = Null, id:Int = wxID_ANY, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL)
		If parent Then
			wxObjectPtr = bmx_wxmdiparentframe_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxmdiparentframe_create(Self, Null, id, title, x, y, w, h, style)
		End If
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Activates the MDI child following the currently active one.
	End Rem
	Method ActivateNext()
		bmx_wxmdiparentframe_activatenext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Activates the MDI child preceding the currently active one.
	End Rem
	Method ActivatePrevious()
		bmx_wxmdiparentframe_activateprevious(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Arranges any iconized (minimized) MDI child windows.
	End Rem
	Method ArrangeIcons()
		bmx_wxmdiparentframe_arrangeicons(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Arranges the MDI child windows in a cascade.
	End Rem
	Method Cascade()
		bmx_wxmdiparentframe_cascade(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This gets the size of the frame 'client area' in pixels.
	about: The client area is the area which may be drawn on by the programmer, excluding title bar,
	border, status bar, and toolbar if present.
	<p>
	If you wish to manage your own toolbar (or perhaps you have more than one), provide an OnSize
	event handler. Call GetClientSize to find how much space there is for your windows and don't
	forget to set the size and position of the MDI client window as well as your toolbar and other
	windows (but not the status bar).
	</p>
	<p>
	If you have set a toolbar with wxMDIParentFrame::SetToolbar, the client size returned will have
	subtracted the toolbar height. However, the available positions for the client window and other
	windows of the frame do not start at zero - you must add the toolbar height.
	</p>
	<p>
	The position and size of the status bar and toolbar (if known to the frame) are always managed
	by wxMDIParentFrame, regardless of what behaviour is defined in your OnSize event handler. However,
	the client window position and size are always set in OnSize, so if you override this event handler,
	make sure you deal with the client window.
	</p>
	<p>
	You do not have to manage the size and position of MDI child windows, since they are managed automatically
	by the client window.
	</p>
	End Rem
	Method GetClientSize(width:Int Var, height:Int Var)
		bmx_wxmdiparentframe_getclientsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Returns the active MDI child, if there is one.
	End Rem
	Method GetActiveChild:wxMDIChildFrame()
		Return wxMDIChildFrame._find(bmx_wxmdiparentframe_getactivechild(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the client window.
	End Rem
	Method GetClientWindow:wxMDIClientWindow()
		Return wxMDIClientWindow._find(bmx_wxmdiparentframe_getclientwindow(wxObjectPtr))
	End Method
	
?win32
	Rem
	bbdoc: Returns the current Window menu (added by wxWidgets to the menubar).
	about: This method is available under Windows only.
	End Rem
	Method GetWindowMenu:wxMenu()
		Return wxMenu._find(bmx_wxmdiparentframe_getwindowmenu(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Call this to change the current Window menu.
	about: Ownership of the menu object passes to the frame when you call this method.
	<p>
	This call is available under Windows only.
	</p>
	<p>
	To remove the window completely, use the wxFRAME_NO_WINDOW_MENU window style.
	</p>
	End Rem
	Method SetWindowMenu(menu:wxMenu)
		bmx_wxmdiparentframe_setwindowmenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
?
	
	Rem
	bbdoc: Tiles the MDI child windows either horizontally or vertically depending on whether orient is wxHORIZONTAL or wxVERTICAL.
	about: Currently only implemented for MSW, does nothing under the other platforms.
	End Rem
	Method Tile(orient:Int = wxHORIZONTAL)
		bmx_wxmdiparentframe_tile(wxObjectPtr, orient)
	End Method

End Type

Rem
bbdoc: An MDI child frame is a frame that can only exist on a wxMDIClientWindow, which is itself a child of wxMDIParentFrame.
End Rem
Type wxMDIChildFrame Extends wxFrame

	' soft linking
	Function _create:wxMDIChildFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMDIChildFrame = New wxMDIChildFrame
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxMDIChildFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxMDIChildFrame = wxMDIChildFrame(wxfind(wxObjectPtr))
			If Not window Then
				Return wxMDIChildFrame._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Function _xrcNew:wxMDIChildFrame(wxObjectPtr:Byte Ptr)
		Return wxMDIChildFrame._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateMDIChildFrame:wxMDIChildFrame(parent:wxMDIParentFrame, id:Int, title:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
		Return New wxMDIChildFrame.CreateCF(parent, id, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateCF:wxMDIChildFrame(parent:wxMDIParentFrame, id:Int, title:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
		wxObjectPtr = bmx_wxmdichildframe_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Activates this MDI child frame.
	End Rem
	Method Activate()
		bmx_wxmdichildframe_activate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Maximizes this MDI child frame.
	End Rem
	Method Maximize(value:Int)
		bmx_wxmdichildframe_maximize(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Restores this MDI child frame (unmaximizes).
	End Rem
	Method Restore()
		bmx_wxmdichildframe_restore(wxObjectPtr)
	End Method
	
End Type


Type wxMDIClientWindow Extends wxWindow

	' soft linking
	Function _create:wxMDIClientWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMDIClientWindow = New wxMDIClientWindow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxMDIClientWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxMDIClientWindow = wxMDIClientWindow(wxfind(wxObjectPtr))
			If Not window Then
				Return wxMDIClientWindow._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Type TMDIResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxmdi_addresourcehandler()
	End Method
		
End Type

New TMDIResourceFactory
