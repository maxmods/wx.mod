' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxWindow
End Rem
Module wx.wxWindow

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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

Extern
	Function bmx_wxwindow_getchildren:wxWindow[](handle:Byte Ptr)
End Extern


Rem
bbdoc: wxWindow is the base type for all windows and represents any visible object on screen.
about: All controls, top level windows and so on are windows. Sizers and device contexts are not,
however, as they don't appear on screen themselves.
<p>
Please note that all children of the window will be deleted automatically by the destructor before
the window itself is deleted which means that you don't have to worry about deleting them manually.
Please see the window deletion overview for more information.
</p>
<p>
Also note that in this, and many others, wxWidgets classes some GetXXX() methods may be overloaded
(as, for example, GetSize or GetClientSize). In this case, the overloads are non-virtual because having
multiple virtual functions with the same name results in a virtual function name hiding at the derived
class level (in English, this means that the derived class has to override all overloaded variants if it
overrides any of them). To allow overriding them in the derived class, wxWidgets uses a unique protected
virtual DoGetXXX() method and all GetXXX() ones are forwarded to it, so overriding the former changes
the behaviour of the latter.
</p>
End Rem
Type wxWindow Extends wxEvtHandler

	Field _data:Object

	Rem
	bbdoc: Constructs a window, which can be a child of a frame, dialog or any other non-control window.
	End Rem
	Function CreateWindow:wxWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxWindow.CreateWin(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateWin:wxWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	' soft linking
	Function _create:wxWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxWindow = New wxWindow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxWindow = wxWindow(wxfind(wxObjectPtr))
			If Not window Then
				Return wxWindow._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Rem
	bbdoc: Called during window creation.
	about: Override this method to provide your own initialization, like adding controls etc.
	End Rem
	Method OnInit()
	End Method
	
	Rem
	bbdoc: Directs all mouse input to this window.
	about: Call wxWindow::ReleaseMouse to release the capture.
	<p>
	Note that wxWidgets maintains the stack of windows having captured the mouse and when the mouse is released
	the capture returns to the window which had had captured it previously and it is only really released if there
	were no previous window. In particular, this means that you must release the mouse as many times as you capture
	it, unless the window receives the wxMouseCaptureLostEvent event.
	</p>
	<p>
	Any application which captures the mouse in the beginning of some operation must handle wxMouseCaptureLostEvent
	and cancel this operation when it receives the event. The event handler must not recapture mouse.
	</p>
	End Rem
	Method CaptureMouse()
		bmx_wxwindow_capturemouse(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Centres the window.
	about: If the window is a top level one (i.e. doesn't have a parent), it will be centered
	relative to the screen anyhow.
	End Rem
	Method Center(direction:Int = wxBOTH)
		Centre(direction)
	End Method
	
	Rem
	bbdoc: Centres the window on its parent.
	about: This is a more readable synonym for Centre.
	<p>
	This methods provides for a way to center top level windows over their parents instead of the
	entire screen. If there is no parent or if the window is not a top level window, then behaviour
	is the same as wxWindow::Centre.
	</p>
	End Rem
	Method CenterOnParent(direction:Int = wxBOTH)
		CentreOnParent(direction)
	End Method
	
	Rem
	bbdoc: Centers the window on screen.
	about: This only works for top level windows - otherwise, the window will still be centered on its parent.
	End Rem
	Method CenterOnScreen(direction:Int = wxBOTH)
		CentreOnScreen(direction)
	End Method
	
	Rem
	bbdoc: Centres the window.
	about: If the window is a top level one (i.e. doesn't have a parent), it will be centered
	relative to the screen anyhow.
	End Rem
	Method Centre(direction:Int = wxBOTH)
		bmx_wxwindow_centre(wxObjectPtr, direction)
	End Method

	Rem
	bbdoc: Centres the window on its parent.
	about: This is a more readable synonym for Centre.
	<p>
	This methods provides for a way to center top level windows over their parents instead of the
	entire screen. If there is no parent or if the window is not a top level window, then behaviour
	is the same as wxWindow::Centre.
	</p>
	End Rem
	Method CentreOnParent(direction:Int = wxBOTH)
		bmx_wxwindow_centreonparent(wxObjectPtr, direction)
	End Method
	
	Rem
	bbdoc: Centres the window on screen.
	about: This only works for top level windows - otherwise, the window will still be centered on its parent.
	End Rem
	Method CentreOnScreen(direction:Int = wxBOTH)
	End Method
	
	Rem
	bbdoc: Clears the window by filling it with the current background colour.
	about: Does not cause an erase background event to be generated.
	End Rem
	Method ClearBackground()
		bmx_wxwindow_clearbackground(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Converts to screen coordinates from coordinates relative to this window.
	End Rem
	Method ClientToScreen(x:Int Var, y:Int Var)
		bmx_wxwindow_clienttoscreen(wxObjectPtr, Varptr x, Varptr y)
	End Method

	Rem
	bbdoc: This method simply generates a wxCloseEvent whose handler usually tries to close the window.
	about: It doesn't close the window itself, however.
	<p>
	Close calls the close handler for the window, providing an opportunity for the window to choose
	whether to destroy the window. Usually it is only used with the top level windows (wxFrame and
	wxDialog classes) as the others are not supposed to have any special OnClose() logic.
	</p>
	<p>
	The close handler should check whether the window is being deleted forcibly, using
	wxCloseEvent::CanVeto, in which case it should destroy the window using wxWindow::Destroy.
	</p>
	<p>
	Note that calling Close does not guarantee that the window will be destroyed; but it provides a way
	to simulate a manual close of a window, which may or may not be implemented by destroying the window.
	The default implementation of wxDialog::OnCloseWindow does not necessarily delete the dialog, since
	it will simply simulate an wxID_CANCEL event which is handled by the appropriate button event
	handler and may do anything at all.
	</p>
	<p>
	To guarantee that the window will be destroyed, call wxWindow::Destroy instead
	</p>
	End Rem
	Method Close:Int(force:Int = False)
		Return bmx_wxwindow_close(wxObjectPtr, force)
	End Method
	
	Rem
	bbdoc: Converts dimensions from dialog units to pixels.
	End Rem
	Method ConvertDialogToPixels(dx:Int, dy:Int, px:Int Var, py:Int Var)
		bmx_wxwindow_convertdialogtopixels(wxObjectPtr, dx, dy, Varptr px, Varptr py)
	End Method
	
	Rem
	bbdoc: Converts dimensions from pixels to dialog units
	End Rem
	Method ConvertPixelsToDialog(px:Int, py:Int, dx:Int Var, dy:Int Var)
		bmx_wxwindow_convertpixelstodialog(wxObjectPtr, px, py, Varptr dx, Varptr dy)
	End Method
	
	Rem
	bbdoc: Destroys the window safely.
	about: Use this method instead of the delete operator, since different window classes can be
	destroyed differently. Frames and dialogs are not destroyed immediately when this function
	is called -- they are added to a list of windows to be deleted on idle time, when all the window's
	events have been processed. This prevents problems with events being sent to non-existent windows.
	End Rem
	Method Destroy:Int()
		Return bmx_wxwindow_destroy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Destroys all children of a window.
	about: Called automatically by the destructor.
	End Rem
	Method DestroyChildren()
		bmx_wxwindow_destroyChildren(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Disables the window, same as Enable(false).
	returns: True if the window has been disabled, False if it had been already disabled before the call to
	this method.
	End Rem
	Method Disable:Int()
		Return bmx_wxwindow_disable(wxObjectPtr)
	End Method
	
	'Method DoGetBestSize(w:Int Var, h:Int Var)
	'End Method
	
	'Method DoUpdateWindowUI(event:wxEvent)
	'End Method
	
	Rem
	bbdoc: Enables or disables eligibility for drop file events (OnDropFiles).
	End Rem
	Method DragAcceptFiles(accept:Int)
		bmx_wxwindow_dragacceptfiles(wxObjectPtr, accept)
	End Method
	
	Rem
	bbdoc: Enable or disable the window for user input.
	returns: True if the window has been enabled or disabled, False if nothing was done, i.e. if the window had already been in the specified state.
	about: Note that when a parent window is disabled, all of its children are disabled as well and they are
	reenabled again when the parent is.
	End Rem
	Method Enable:Int(value:Int = True)
		Return bmx_wxwindow_enable(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Finds the window or control which currently has the keyboard focus.
	about: Note that this is a static function, so it can be called without needing a wxWindow .
	End Rem
	Function FindFocus:wxWindow()
		Return wxWindow._find(bmx_wxwindow_findfocus())
	End Function

	Rem
	bbdoc: Find a child of this window, by identifier.
	End Rem
	Method FindWindow:wxWindow(id:Int)
		Return _find(bmx_wxwindow_findwindow(wxObjectPtr, id))
	End Method
		
	Rem
	bbdoc: Find the first window with the given id.
	about: If parent is NULL, the search will start from all top-level frames and dialog boxes; if non-NULL,
	the search will be limited to the given window hierarchy. The search is recursive in both cases.
	End Rem
	Function FindWindowById:wxWindow(id:Int, parent:wxWindow = Null)
		If parent Then
			Return wxWindow._find(bmx_wxwindow_findwindowbyid(id, parent.wxObjectPtr))
		Else
			Return wxWindow._find(bmx_wxwindow_findwindowbyid(id, Null))
		End If
	End Function
	
	Rem
	bbdoc: Find a window by its name (as given in a window constructor or Create function call).
	about: If parent is NULL, the search will start from all top-level frames and dialog boxes; if non-NULL,
	the search will be limited to the given window hierarchy. The search is recursive in both cases.
	<p>
	If no window with such name is found, FindWindowByLabel is called.
	</p>
	End Rem
	Function FindWindowByName:wxWindow(name:String, parent:wxWindow = Null)
		If parent Then
			Return wxWindow._find(bmx_wxwindow_findwindowbyname(name, parent.wxObjectPtr))
		Else
			Return wxWindow._find(bmx_wxwindow_findwindowbyname(name, Null))
		End If
	End Function
	
	Rem
	bbdoc: Find a window by its label.
	about: Depending on the type of window, the label may be a window title or panel item label. If parent is Null,
	the search will start from all top-level frames and dialog boxes; if non-NULL, the search will be limited to
	the given window hierarchy. The search is recursive in both cases.
	End Rem
	Function FindWindowByLabel:wxWindow(label:String, parent:wxWindow = Null)
		If parent Then
			Return wxWindow._find(bmx_wxwindow_findwindowbylabel(label, parent.wxObjectPtr))
		Else
			Return wxWindow._find(bmx_wxwindow_findwindowbylabel(label, Null))
		End If
	End Function
	
	Rem
	bbdoc: Sizes the window so that it fits around its subwindows.
	about: This method won't do anything if there are no subwindows and will only really work correctly if the
	sizers are used for the subwindows layout. Also, if the window has exactly one subwindow it is better
	(faster and the result is more precise as Fit adds some margin to account for fuzziness of its calculations)
	to call :
	<pre>
    window.SetClientSize(child.GetSize())
	</pre>
	instead of calling Fit.
	End Rem
	Method Fit()
		bmx_wxwindow_fit(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Similar to Fit, but sizes the interior (virtual) size of a window.
	about: Mainly useful with scrolled windows to reset scrollbars after sizing changes that do not trigger a
	size event, and/or scrolled windows without an interior sizer. This method similarly won't do anything if
	there are no subwindows.
	End Rem
	Method FitInside()
		bmx_wxwindow_fitinside(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Freezes the window or, in other words, prevents any updates from taking place on screen, the window is not redrawn at all.
	about: Thaw must be called to reenable window redrawing. Calls to these two functions may be nested.
	<p>
	This method is useful for visual appearance optimization (for example, it is a good idea to use it before
	doing many large text insertions in a row into a wxTextCtrl under wxGTK) but is not implemented on all platforms
	nor for all controls so it is mostly just a hint to wxWidgets and not a mandatory directive.
	</p>
	End Rem
	Method Freeze()
		bmx_wxwindow_freeze(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAcceleratorTable:wxAcceleratorTable()
	End Method
	
	'Method GetAccessible()
	'End Method
	
	Rem
	bbdoc: Returns the background colour of the window.
	End Rem
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxwindow_getbackgroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the background style of the window.
	about: The background style indicates whether background colour should be determined by the system
	(wxBG_STYLE_SYSTEM), be set to a specific colour (wxBG_STYLE_COLOUR), or should be left to the application
	to implement (wxBG_STYLE_CUSTOM).
	<p>
	On GTK+, use of wxBG_STYLE_CUSTOM allows the flicker-free drawing of a custom background, such as a tiled
	bitmap. Currently the style has no effect on other platforms
	</p>
	End Rem
	Method GetBackgroundStyle:Int()
		Return bmx_wxwindow_getbackgroundstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Merges the window's best size into the min size and returns the result.
	about: This is the value used by sizers to determine the appropriate ammount of sapce to allocate for the widget.
	End Rem
	Method GetEffectiveMinSize(w:Int Var, h:Int Var)
		bmx_wxwindow_geteffectiveminsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: This method returns the best acceptable minimal size for the window.
	about: For example, for a static control, it will be the minimal size such that the control label is not
	truncated. For windows containing subwindows (typically wxPanel), the size returned by this function will
	be the same as the size the window would have had after calling Fit.
	End Rem
	Method GetBestSize(width:Int Var, height:Int Var)
		bmx_wxwindow_getbestsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Returns the currently captured window.
	End Rem
	Function GetCapture:wxWindow()
		Return wxWindow._find(bmx_wxwindow_getcapture())
	End Function
	
	Rem
	bbdoc: Returns the caret associated with the window.
	End Rem
	Method GetCaret:wxCaret()
		Return wxCaret._create(bmx_wxwindow_getcaret(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the character height for this window.
	End Rem
	Method GetCharHeight:Int()
		Return bmx_wxwindow_getcharheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the average character width for this window.
	End Rem
	Method GetCharWidth:Int()
		Return bmx_wxwindow_getcharwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a list of the window's children.
	End Rem
	Method GetChildren:wxWindow[]()
		Return bmx_wxwindow_getchildren(wxObjectPtr)
	End Method
	
	Function _newwindowarray:wxWindow[](size:Int)
		Return New wxWindow[size]
	End Function
	
	Function _setwindow(list:wxWindow[], index:Int, windowPtr:Byte Ptr)
		list[index] = wxWindow._find(windowPtr)
	End Function

	'Method GetClassDefaultAttributes()
	'End Method

	Rem
	bbdoc: This gets the size of the window 'client area' in pixels.
	about: The client area is the area which may be drawn on by the programmer, excluding title bar,
	border, scrollbars, etc.
	End Rem
	Method GetClientSize(width:Int Var, height:Int Var)
		bmx_wxwindow_getclientsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Return the sizer that this window is a member of, if any, otherwise Null.
	End Rem
	Method GetContainingSizer:wxSizer()
		Return wxSizer._find(bmx_wxwindow_getcontainingsizer(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Return the cursor associated with this window.
	End Rem
	Method GetCursor:wxCursor()
		Return wxCursor._create(bmx_wxwindow_getcursor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultAttributes:Int()
	End Method
	
	Rem
	bbdoc: Returns the associated drop target, which may be NULL.
	End Rem
	Method GetDropTarget:wxDropTarget()
		Return wxDropTarget._create(bmx_wxwindow_getdroptarget(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the event handler for this window.
	about: By default, the window is its own event handler.
	End Rem
	Method GetEventHandler:wxEvtHandler()
		Return wxEvtHandler._find(bmx_wxwindow_geteventhandler(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the extra style bits for the window.
	End Rem
	Method GetExtraStyle:Int()
		Return bmx_wxwindow_getextrastyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the font for this window.
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxwindow_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the foreground colour of the window.
	about: The interpretation of foreground colour is open to interpretation according to the window type;
	it may be the text colour or other colour, or it may not be used at all.
	End Rem
	Method GetForegroundColour:wxColour()
		Return wxColour._create(bmx_wxwindow_getforegroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the grandparent of a window, or Null if there isn't one.
	End Rem
	Method GetGrandParent:wxWindow()
		Return wxWindow._find(bmx_wxwindow_getgrandparent(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the platform-specific handle of the physical window, such as HWND for Windows, GtkWidget for GTK.
	End Rem
	Method GetHandle:Byte Ptr()
		Return bmx_wxwindow_gethandle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the help text to be used as context-sensitive help for this window.
	about: This method should be overridden if the help message depends on the position inside the
	window, otherwise GetHelpText can be used.
	End Rem
	Method GetHelpTextAtPoint:String(x:Int, y:Int, origin:Int)
		Return bmx_wxwindow_gethelptextatpoint(wxObjectPtr, x, y, origin)
	End Method
	
	Rem
	bbdoc: Gets the help text to be used as context-sensitive help for this window.
	about: Note that the text is actually stored by the current wxHelpProvider implementation, and not
	in the window object itself.
	End Rem
	Method GetHelpText:String()
		Return bmx_wxwindow_gethelptext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the identifier of the window.
	about: Each window has an integer identifier. If the application has not provided one (or the default
	wxID_ANY) an unique identifier with a negative value will be generated.
	End Rem
	Method GetId:Int()
		Return bmx_wxwindow_getid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Generic way of getting a label from any window, for identification purposes.
	about: The interpretation of this method differs from type to type. For frames and dialogs, the
	value returned is the title. For buttons or static text controls, it is the button text. This
	method can be useful for meta-programs (such as testing tools or special-needs access programs)
	which need to identify windows by name.
	End Rem
	Method GetLabel:String()
		Return bmx_wxwindow_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the maximum size of the window, an indication to the sizer layout mechanism that this is the maximum possible size.
	End Rem
	Method GetMaxSize(w:Int Var, h:Int Var)
		bmx_wxwindow_getmaxsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the minimum size of the window, an indication to the sizer layout mechanism that this is the minimum required size.
	about: It normally just returns the value set by SetMinSize, but it can be overridden to do the
	calculation on demand.
	End Rem
	Method GetMinSize(w:Int Var, h:Int Var)
		bmx_wxwindow_getminsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the window's name.
	about: This name is not guaranteed to be unique; it is up to the programmer to supply an appropriate name
	in the window constructor or via wxWindow::SetName.
	End Rem
	Method GetName:String()
		Return bmx_wxwindow_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the parent of the window, or Null if there is no parent.
	End Rem
	Method GetParent:wxWindow()
		Return wxWindow._find(bmx_wxwindow_getparent(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: This gets the position of the window in pixels, relative to the parent window for the child windows or relative to the display origin for the top level windows.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxwindow_getposition(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the size and position of the window.
	End Rem
	Method GetRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxwindow_getrect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the size and position of the window.
	End Rem
	Method GetRectRect:wxRect()
		Return wxRect._create(bmx_wxwindow_getrectrect(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the window position in screen coordinates, whether the window is a child window or a top level one.
	End Rem
	Method GetScreenPosition(x:Int Var, y:Int Var)
		bmx_wxwindow_getscreenposition(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the size and position of the window on the screen.
	End Rem
	Method GetScreenRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxwindow_getscreenrect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the size and position of the window on the screen.
	End Rem
	Method GetScreenRectRect:wxRect()
		Return wxRect._create(bmx_wxwindow_getscreenrectrect(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the built-in scrollbar position.
	End Rem
	Method GetScrollPos:Int(orientation:Int)
		Return bmx_wxwindow_getscrollpos(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: Returns the built-in scrollbar range.
	End Rem
	Method GetScrollRange:Int(orientation:Int)
		Return bmx_wxwindow_getscrollrange(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: Returns the built-in scrollbar thumb size.
	End Rem
	Method GetScrollThumb:Int(orientation:Int)
		Return bmx_wxwindow_getscrollthumb(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: This gets the size of the entire window in pixels, including title bar, border, scrollbars, etc.
	End Rem
	Method GetSize(w:Int Var, h:Int Var)
		bmx_wxwindow_getsize(wxObjectPtr, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Return the sizer associated with the window by a previous call to SetSizer() or null.
	End Rem
	Method GetSizer:wxSizer()
		Return wxSizer._find(bmx_wxwindow_getsizer(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTextExtent(text:String, x:Int Var, y:Int Var, descent:Int Var, ..
			externalLeading:Int Var, font:wxFont = Null, use16:Int = False)
		If font Then
			bmx_wxwindow_gettextextent(wxObjectPtr, text, Varptr x, Varptr y, Varptr descent, ..
				Varptr externalLeading, font.wxObjectPtr, use16)
		Else
			bmx_wxwindow_gettextextent(wxObjectPtr, text, Varptr x, Varptr y, Varptr descent, ..
				Varptr externalLeading, Null, use16)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetToolTip:wxToolTip()
'		Return bmx_wxwindow_gettooltip(wxObjectPtr)
	End Method

	Rem
	bbdoc: This gets the virtual size of the window in pixels.
	about: By default it returns the client size of the window, but after a call to
	SetVirtualSize it will return that size.
	End Rem
	Method GetVirtualSize(width:Int Var, height:Int Var)
		bmx_wxwindow_getvirtualsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Returns the size of the left/right and top/bottom borders of this window.
	End Rem
	Method GetWindowBorderSize(leftRight:Int Var, topBottom:Int Var)
		bmx_wxwindow_getwindowbordersize(wxObjectPtr, Varptr leftRight, Varptr topBottom)
	End Method
		
	Rem
	bbdoc: Gets the window style that was passed to the constructor or Create method.
	about: GetWindowStyle() is another name for the same function.
	End Rem
	Method GetWindowStyleFlag:Int()
		Return bmx_wxwindow_getwindowstyleflag(wxObjectPtr)
	End Method

	Rem
	bbdoc: Gets the window style that was passed to the constructor or Create method.
	End Rem
	Method GetWindowStyle:Int()
		Return GetWindowStyleFlag()
	End Method
	
	Rem
	bbdoc: Returns the value previously passed to wxWindow::SetWindowVariant.
	End Rem
	Method GetWindowVariant:Int()
		Return bmx_wxwindow_getwindowvariant(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this window has the current mouse capture.
	End Rem
	Method HasCapture:Int()
		Return bmx_wxwindow_hascapture(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the window has the given flag bit set.
	End Rem
	Method HasFlag:Int(flag:Int)
		Return bmx_wxwindow_hasflag(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: This method should be overridden to return true if this window has multiple pages.
	about: All standard types with multiple pages such as wxNotebook, wxListbook and wxTreebook already
	override it to return true and user-defined classes with similar behaviour should do it as well to
	allow the library to handle such windows appropriately.
	End Rem
	Method HasMultiplePages:Int()
		Return bmx_wxwindow_hasmultiplepages(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this window has a scroll bar for this orientation.
	End Rem
	Method HasScrollbar:Int(orient:Int)
		Return bmx_wxwindow_hasscrollbar(wxObjectPtr, orient)
	End Method
	
	Rem
	bbdoc: Returns true if this window background is transparent (as, for example, for wxStaticText) and should show the parent window background.
	about: This method is mostly used internally by the library itself and you normally shouldn't have to
	call it. You may, however, have to override it in your wxWindow-derived class to ensure that
	background is painted correctly.
	End Rem
	Method HasTransparentBackground:Int()
		' TODO : allow this to be overridden internally
		Return bmx_wxwindow_hastransparentbackground(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Equivalent to calling Show(false).
	End Rem
	Method Hide:Int()
		Return bmx_wxwindow_hide(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method is (or should be, in case of custom controls) called during window creation to intelligently set up the window visual attributes, that is the font and the foreground and background colours.
	about: By "intelligently" the following is meant: by default, all windows use their own default attributes.
	However if some of the parents attributes are explicitly (that is, using SetFont and not SetOwnFont)
	changed and if the corresponding attribute hadn't been explicitly set for this window itself, then this
	window takes the same value as used by the parent. In addition, if the window overrides
	ShouldInheritColours to return false, the colours will not be changed no matter what and only the
	font might.
	<p>
	This rather complicated logic is necessary in order to accommodate the different usage scenarios. The most
	common one is when all default attributes are used and in this case, nothing should be inherited as
	in modern GUIs different controls use different fonts (and colours) than their siblings so they can't
	inherit the same value from the parent. However it was also deemed desirable to allow to simply change
	the attributes of all children at once by just changing the font or colour of their common parent, hence
	in this case we do inherit the parents attributes.
	</p>
	End Rem
	Method InheritAttributes()
		bmx_wxwindow_inheritattributes(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sends an wxEVT_INIT_DIALOG event, whose handler usually transfers data to the dialog via validators.
	End Rem
	Method InitDialog()
		bmx_wxwindow_initdialog(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets the cached best size value so it will be recalculated the next time it is needed.
	End Rem
	Method InvalidateBestSize()
		bmx_wxwindow_invalidatebestsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the window contents is double-buffered by the system
	about: i.e. if any drawing done on the window is really done on a temporary backing surface and
	transferred to the screen all at once later.
	End Rem
	Method IsDoubleBuffered:Int()
		Return bmx_wxwindow_isdoublebuffered(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the window is enabled for input, False otherwise.
	End Rem
	Method IsEnabled:Int()
		Return bmx_wxwindow_isenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the given point or rectangle area has been exposed since the last repaint.
	about: Call this in an paint event handler to optimize redrawing by only redrawing those areas,
	which have been exposed.
	End Rem
	Method IsExposed:Int(x:Int, y:Int, w:Int = 0, h:Int = 0)
		Return bmx_wxwindow_isexposed(wxObjectPtr, x, y, w, h)
	End Method

	Rem
	bbdoc: Returns true if the given point or rectangle area has been exposed since the last repaint.
	about: Call this in an paint event handler to optimize redrawing by only redrawing those areas,
	which have been exposed.
	End Rem
	Method IsExposedRect:Int(rect:wxRect)
		Return bmx_wxwindow_isexposedrect(wxObjectPtr, rect.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the window is currently frozen by a call to Freeze().
	End Rem
	Method IsFrozen:Int()
		Return bmx_wxwindow_isfrozen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the window is retained, false otherwise.
	about: Retained windows are only available on X platforms.
	End Rem
	Method IsRetained:Int()
		Return bmx_wxwindow_isretained(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the window is shown, false if it has been hidden.
	End Rem
	Method IsShown:Int()
		Return bmx_wxwindow_isshown(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the window is physically visible on the screen
	about: i.e. it is shown and all its parents up to the toplevel window are shown as well.
	End Rem
	Method IsShownOnScreen:Int()
		Return bmx_wxwindow_isshownonscreen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the given window is a top-level one.
	about: Currently all frames and dialogs are considered to be top-level windows (even if they have
	a parent window).
	End Rem
	Method IsTopLevel:Int()
		Return bmx_wxwindow_istoplevel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Invokes the constraint-based layout algorithm or the sizer-based algorithm for this window.
	about: See wxWindow::SetAutoLayout: when auto layout is on, this function gets called automatically when the
	window is resized.
	End Rem
	Method Layout()
		bmx_wxwindow_layout(wxObjectPtr)
	End Method

	Rem
	bbdoc: This is just a wrapper for ScrollLines(1).
	End Rem
	Method LineDown()
		bmx_wxwindow_linedown(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This is just a wrapper for ScrollLines(-1).
	End Rem
	Method LineUp()
		bmx_wxwindow_lineup(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Lowers the window to the bottom of the window hierarchy (z-order).
	End Rem
	Method Lower()
		bmx_wxwindow_lower(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Disables all other windows in the application so that the user can only interact with this window.
	End Rem
	Method MakeModal(flag:Int)
		bmx_wxwindow_makemodal(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Moves the window to the given position.
	End Rem
	Method Move(x:Int, y:Int)
		bmx_wxwindow_move(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Moves this window in the tab navigation order after the specified win.
	about: This means that when the user presses TAB key on that other window, the focus switches to this window.
	<p>
	Default tab order is the same as creation order, this function and MoveBeforeInTabOrder() allow to change
	it after creating all the windows.
	</p>
	End Rem
	Method MoveAfterInTabOrder(win:wxWindow)
		bmx_wxwindow_moveafterintaborder(wxObjectPtr, win.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Same as MoveAfterInTabOrder except that it inserts this window just before win instead of putting it right after it.
	End Rem
	Method MoveBeforeInTabOrder(win:wxWindow)
		bmx_wxwindow_movebeforeintaborder(wxObjectPtr, win.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Does keyboard navigation from this window to another, by sending a wxNavigationKeyEvent.
	about: You may wish to call this from a text control custom keypress handler to do the default
	navigation behaviour for the tab key, since the standard default behaviour for a multiline text
	control with the wxTE_PROCESS_TAB style is to insert a tab and not navigate to the next control.
	End Rem
	Method Navigate:Int(flags:Int = wxNavigationKeyEvent.IsForward)
		bmx_wxwindow_navigate(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: This is just a wrapper for ScrollPages()(1).
	End Rem
	Method PageDown()
		bmx_wxwindow_pagedown(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This is just a wrapper for ScrollPages()(-1).
	End Rem
	Method PageUp()
		bmx_wxwindow_pageup(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes and returns the top-most event handler on the event handler stack.
	End Rem
	Method PopEventHandler:wxEvtHandler(deleteHandler:Int = False)
		Return wxEvtHandler._find(bmx_wxwindow_popeventhandler(wxObjectPtr, deleteHandler))
	End Method
	
	Rem
	bbdoc: Pops up the given menu at the specified coordinates, relative to this window, and returns control when the user has dismissed the menu.
	about: If a menu item is selected, the corresponding menu event is generated and will be processed as usual.
	If the coordinates are not specified, current mouse cursor position is used.
	<p>
	Just before the menu is popped up, wxMenu::UpdateUI is called to ensure that the menu items are in
	the correct state. The menu does not get deleted by the window.
	</p>
	<p>
	It is recommended to not explicitly specify coordinates when calling PopupMenu in response to mouse
	click, because some of the ports (namely, wxGTK) can do a better job of positioning the menu in that
	case.
	</p>
	End Rem
	Method PopupMenu:Int(menu:wxMenu, x:Int = -1, y:Int = -1)
		Return bmx_wxwindow_popupmenu(wxObjectPtr, menu.wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Call this method to prepare the device context for drawing
	End Rem
	Method PrepareDC(dc:wxDC)
		bmx_wxwindow_preparedc(wxObjectPtr, dc.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Pushes this event handler onto the event stack for the window.
	about: An event handler is an object that is capable of processing the events sent to a window.
	By default, the window is its own event handler, but an application may wish to substitute another,
	for example to allow central implementation of event-handling for a variety of different window classes.
	<p>
	wxWindow::PushEventHandler allows an application to set up a chain of event handlers, where an event not
	handled by one event handler is handed to the next one in the chain. Use wxWindow::PopEventHandler to
	remove the event handler.
	</p>
	End Rem
	Method PushEventHandler(handler:wxEvtHandler)
		bmx_wxwindow_pusheventhandler(wxObjectPtr, handler.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Raises the window to the top of the window hierarchy (z-order).
	about: In current version of wxWidgets this works both for managed and child windows.
	End Rem
	Method Raise()
		bmx_wxwindow_raise(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Causes this window, and all of its children recursively, to be repainted.
	about: Note that repainting doesn't happen immediately but only during the next event loop iteration,
	if you need to update the window immediately you should use Update instead.
	End Rem
	Method Refresh(eraseBackground:Int = True)
		bmx_wxwindow_refresh(wxObjectPtr, eraseBackground)
	End Method
	
	Rem
	bbdoc: Redraws the contents of the given rectangle: only the area inside it will be repainted.
	about: This is the same as Refresh but has a nicer syntax as it can be called with an argument like
	this RefreshRect(x, y, w, h).
	End Rem
	Method RefreshRect(x:Int, y:Int, w:Int, h:Int, eraseBackground:Int = True)
		bmx_wxwindow_refreshrect(wxObjectPtr, x, y, w, h, eraseBackground)
	End Method

	Rem
	bbdoc: Redraws the contents of the given rectangle: only the area inside it will be repainted.
	about: This is the same as Refresh but has a nicer syntax as it can be called with an argument like
	this RefreshRectRect(rect).
	End Rem
	Method RefreshRectRect(rect:wxRect, eraseBackground:Int = True)
		bmx_wxwindow_refreshrectrect(wxObjectPtr, rect.wxObjectPtr, eraseBackground)
	End Method
	
	Rem
	bbdoc: Registers a system wide hotkey.
	about: Every time the user presses the hotkey registered here, this window will receive
	a hotkey event. It will receive the event even if the application is in the background
	and does not have the input focus because the user is working with some other application.
	End Rem
	Method RegisterHotKey:Int(hotKeyId:Int, modifiers:Int, virtualKeyCode:Int)
		Return bmx_wxwindow_registerhotkey(wxObjectPtr, hotKeyId, modifiers, virtualKeyCode)
	End Method
	
	Rem
	bbdoc: Releases mouse input captured with wxWindow::CaptureMouse.
	End Rem
	Method ReleaseMouse()
		bmx_wxwindow_releasemouse(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Not implemented, cuz the docs say "Notice that this function is mostly internal to wxWidgets and shouldn't be called by the user code."
	End Rem
	Method RemoveChild(child:wxWindow)
		' nothing to see here, move along, move along.
	End Method
	
	Rem
	bbdoc: Find the given handler in the windows event handler chain and remove (but not delete) it from it.
	returns: True if it was found and False otherwise (this also results in an assert failure so this method should only be called when the handler is supposed to be there).
	End Rem
	Method RemoveEventHandler:Int(handler:wxEvtHandler)
		Return bmx_wxwindow_removeeventhandler(wxObjectPtr, handler.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Reparents the window
	about: i.e the window will be removed from its current parent window (e.g. a non-standard toolbar in
	a wxFrame) and then re-inserted into another.
	End Rem
	Method Reparent:Int(newParent:wxWindow)
		Return bmx_wxwindow_reparent(wxObjectPtr, newParent.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Converts from screen to client window coordinates.
	End Rem
	Method ScreenToClient(x:Int Var, y:Int Var)
		bmx_wxwindow_screentoclient(wxObjectPtr, Varptr x, Varptr y)
	End Method

	Rem
	bbdoc: Scrolls the window by the given number of lines down (if lines is positive) or up.
	about: This method is currently only implemented under MSW and wxTextCtrl under wxGTK (it also works for wxScrolledWindow derived classes under all platforms).
	End Rem
	Method ScrollLines:Int(lines:Int)
		Return bmx_wxwindow_scrolllines(wxObjectPtr, lines)
	End Method
	
	Rem
	bbdoc: Scrolls the window by the given number of pages down (if pages is positive) or up.
	about: This method is currently only implemented under MSW and wxGTK.
	End Rem
	Method ScrollPages:Int(pages:Int)
		Return bmx_wxwindow_scrollpages(wxObjectPtr, pages)
	End Method
	
	Method ScrollWindow(dx:Int, dy:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
	End Method

	Method ScrollWindowRect(dx:Int, dy:Int, rect:wxRect = Null)
	End Method
	
	

	Rem
	bbdoc: Determines whether the wxWindow::Layout function will be called automatically when the window is resized.
	about: Please note that this only happens for the windows usually used to contain children, namely wxPanel
	and wxTopLevelWindow (and the classes deriving from them).
	<p>
	This method is called implicitly by wxWindow::SetSizer but if you use wxWindow::SetConstraints you should
	call it manually or otherwise the window layout won't be correctly updated when its size changes.
	</p>
	End Rem
	Method SetAutoLayout(autoLayout:Int)
		bmx_wxwindow_setautolayout(wxObjectPtr, autoLayout)
	End Method
	
	Rem
	bbdoc: This sets the window to receive keyboard input.
	End Rem
	Method SetFocus()
		bmx_wxwindow_setfocus(wxObjectPtr)
	End Method

	' TODO : remove me?
	Method injectSelf()
	End Method
	
	Rem
	bbdoc: Sets the background colour of the window.
	about: The background colour is usually painted by the default wxEraseEvent event handler function under Windows and automatically under GTK.
	<p>
	Note that setting the background colour does not cause an immediate refresh, so you may wish to call
	wxWindow::ClearBackground or wxWindow::Refresh after calling this function.
	</p><p>
	Using this function will disable attempts to use themes for this window, if the system supports them.
	Use with care since usually the themes represent the appearance chosen by the user to be used for all
	applications on the system.
	</p>
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxwindow_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the background style of the window.
	about: The background style indicates whether background colour should be determined by the system
	(wxBG_STYLE_SYSTEM), be set to a specific colour (wxBG_STYLE_COLOUR), or should be left to the
	application to implement (wxBG_STYLE_CUSTOM).
	<p>
	On GTK+, use of wxBG_STYLE_CUSTOM allows the flicker-free drawing of a custom background, such as a
	tiled bitmap. Currently the style has no effect on other platforms.
	</p>
	End Rem
	Method SetBackgroundStyle(style:Int)
		bmx_wxwindow_setbackgroundstyle(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: A smart SetSize that will fill in default size components with the window's best size values.
	about: Also sets the window's minsize to the value passed in for use with sizers. This means that if
	a full or partial size is passed to this function then the sizers will use that size instead of the
	results of GetBestSize to determine the minimum needs of the window for layout.
	<p>
	Most controls will use this to set their initial size, and their min size to the passed in value
	(if any.)
	</p>
	End Rem
	Method SetInitialSize(w:Int = -1, h:Int = -1)
		bmx_wxwindow_setinitialsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Sets the caret associated with the window.
	End Rem
	Method SetCaret(caret:wxCaret)
		bmx_wxwindow_setcaret(wxObjectPtr, caret.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This sets the size of the window client area in pixels.
	about: Using this function to size a window tends to be more device-independent than wxWindow::SetSize,
	since the application need not worry about what dimensions the border or title bar have when trying
	to fit the window around panel items, for example.
	End Rem
	Method SetClientSize(width:Int, height:Int)
		bmx_wxwindow_setclientsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Not used. Use sizers instead.
	End Rem
	Method SetConstraints()
	 ' nothing to see here, move along, move along.
	End Method
	
	Rem
	bbdoc: This normally does not need to be called by user code.
	about: It is called when a window is added to a sizer, and is used so the window can remove itself
	from the sizer when it is destroyed.
	End Rem
	Method SetContainingSizer(sizer:wxSizer)
		bmx_wxwindow_setcontainingsizer(wxObjectPtr, sizer.wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Sets the window's cursor.
	about: Notice that the window cursor also sets it for the children of the window implicitly.
	<p>
	The cursor may be wxNullCursor in which case the window cursor will be reset back to default.
	</p>
	End Rem
	Method SetCursor(cursor:wxCursor)
		bmx_wxwindow_setcursor(wxObjectPtr, cursor.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Associates a drop target with this window.
	about: If the window already has a drop target, it is deleted.
	End Rem
	Method SetDropTarget(target:wxDropTarget)
		bmx_wxwindow_setdroptarget(wxObjectPtr, target.wxObjectPtr)
	End Method
	
	' Deprecated!
	'Rem
	'bbdoc: Sets the initial window size If none is given (i.e. at least one of the components of the size passed To ctor/Create() is wxDefaultCoord (-1, -1)).
	'End Rem
	'Method SetInitialBestSize(w:Int, h:Int)
	'	bmx_wxwindow_setinitialbestsize(wxObjectPtr, w, h)
	'End Method
	
	Rem
	bbdoc: Sets the event handler for this window.
	about: An event handler is an object that is capable of processing the events sent to a window.
	By default, the window is its own event handler, but an application may wish to substitute another,
	for example to allow central implementation of event-handling for a variety of different window
	classes.
	<p>
	It is usually better to use wxWindow::PushEventHandler since this sets up a chain of event handlers,
	where an event not handled by one event handler is handed to the next one in the chain.
	</p>
	End Rem
	Method SetEventHandler(handler:wxEvtHandler)
		bmx_wxwindow_seteventhandler(wxObjectPtr, handler.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the extra style bits for the window.
	about: The currently defined extra style bits are:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxWS_EX_VALIDATE_RECURSIVELY</td><td>TransferDataTo/FromWindow() and Validate() methods will
	recursively descend into all children of the window if it has this style flag set. </td></tr>
	<tr><td>wxWS_EX_BLOCK_EVENTS</td><td>Normally, the command events are propagated upwards to the window
	parent recursively until a handler for them is found. Using this style allows to prevent them from being
	propagated beyond this window. Notice that wxDialog has this style on by default for the reasons
	explained in the event processing overview.</td></tr>
	<tr><td>wxWS_EX_TRANSIENT</td><td>This can be used to prevent a window from being used as an implicit
	parent for the dialogs which were created without a parent. It is useful for the windows which can
	disappear at any moment as creating children of such windows results in fatal problems. </td></tr>
	<tr><td>wxWS_EX_CONTEXTHELP</td><td>Under Windows, puts a query button on the caption. When pressed,
	Windows will go into a context-sensitive help mode and wxWidgets will send a wxEVT_HELP event if the
	user clicked on an application window. This style cannot be used together with wxMAXIMIZE_BOX or
	wxMINIMIZE_BOX, so these two styles are automatically turned of if this one is used. </td></tr>
	<tr><td>wxWS_EX_PROCESS_IDLE</td><td>This window should always process idle events, even if the mode
	set by wxIdleEvent::SetMode is wxIDLE_PROCESS_SPECIFIED. </td></tr>
	<tr><td>wxWS_EX_PROCESS_UI_UPDATES</td><td>This window should always process UI update events, even
	if the mode set by wxUpdateUIEvent::SetMode is wxUPDATE_UI_PROCESS_SPECIFIED.</td></tr>
	</table>
	End Rem
	Method SetExtraStyle(style:Int)
		bmx_wxwindow_setextrastyle(wxObjectPtr, style)
	End Method
	
	' override me !!!!
	Method SetFocusFromKbd()
	End Method
	
	Rem
	bbdoc: Sets the font for this window.
	about: This method should not be called for the parent window if you don't want its font to be
	inherited by its children, use SetOwnFont instead in this case and see #InheritAttributes for more
	explanations.
	<p>
	Please notice that the given font is not automatically used for wxPaintDC objects associated with this
	window, you need to call wxDC::SetFont() too. However this font is used by any standard controls for
	drawing their text as well as by wxWindow::GetTextExtent().
	</p>
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxwindow_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the foreground colour of the window.
	End Rem
	Method SetForegroundColour(colour:wxColour)
		bmx_wxwindow_setforegroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the help text to be used as context-sensitive help for this window.
	about: Note that the text is actually stored by the current wxHelpProvider implementation, and not
	in the window object itself.
	End Rem
	Method SetHelpText(helpText:String)
		bmx_wxwindow_sethelptext(wxObjectPtr, helpText:String)
	End Method
	
	Rem
	bbdoc: Each window has an integer identifier.
	about: If the application has not provided one, an identifier will be generated. Normally, the
	identifier should be provided on creation and should not be modified subsequently.
	End Rem
	Method SetId(id:Int)
		bmx_wxwindow_setid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Sets the window's label.
	End Rem
	Method SetLabel(label:String)
		bmx_wxwindow_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: Sets the maximum size of the window, to indicate to the sizer layout mechanism that this is the maximum possible size.
	End Rem
	Method SetMaxSize(width:Int, height:Int)
		bmx_wxwindow_setmaxsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Sets the minimum size of the window, to indicate to the sizer layout mechanism that this is the minimum required size.
	about: You may need to call this if you change the window size after construction and before adding
	to its parent sizer.
	End Rem
	Method SetMinSize(width:Int, height:Int)
		bmx_wxwindow_setminsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Sets the window's name.
	End Rem
	Method SetName(name:String)
		bmx_wxwindow_setname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the background colour of the window but prevents it from being inherited by the children of this window.
	End Rem
	Method SetOwnBackgroundColour(colour:wxColour)
		bmx_wxwindow_setownbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font of the window but prevents it from being inherited by the children of this window.
	End Rem
	Method SetOwnFont(font:wxFont)
		bmx_wxwindow_setownfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the foreground colour of the window but prevents it from being inherited by the children of this window.
	End Rem
	Method SetOwnForegroundColour(colour:wxColour)
		bmx_wxwindow_setownforegroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the scrollbar properties of a built-in scrollbar.
	about: Let's say you wish to display 50 lines of text, using the same font. The window is sized so that you can only see 16
	lines at a time.
	<p>
	You would use:
	<pre>
	SetScrollbar(wxVERTICAL, 0, 16, 50)
	</pre>
	Note that with the window at this size, the thumb position can never go above 50 minus
	16, or 34.
	</p>
	<p>
	You can determine how many lines are currently visible by dividing the current view size
	by the character height in pixels.
	</p>
	<p>
	When defining your own scrollbar behaviour, you will always need to recalculate the
	scrollbar settings when the window size changes. You could therefore put your scrollbar
	calculations and SetScrollbar call into a function named AdjustScrollbars, which can be
	called initially and also from your wxSizeEvent handler function.
	</p>
	End Rem
	Method SetScrollbar(orientation:Int, position:Int, thumbsize:Int, range:Int, refresh:Int = True)
		bmx_wxwindow_setscrollbar(wxObjectPtr, orientation, position, thumbsize, range, refresh)
	End Method
	
	Rem
	bbdoc: Sets the position of one of the built-in scrollbars.
	about: This method does not directly affect the contents of the window: it is up to the
	application to take note of scrollbar attributes and redraw contents accordingly.
	End Rem
	Method SetScrollPos(orientation:Int, pos:Int, refresh:Int = True)
		bmx_wxwindow_setscrollpos(wxObjectPtr, orientation, pos, refresh)
	End Method
	
	Rem
	bbdoc: Sets the size and position of the window in pixels.
	End Rem
	Method SetDimensions(x:Int, y:Int, width:Int, height:Int, sizeFlags:Int = wxSIZE_AUTO)
		bmx_wxwindow_setdimensions(wxObjectPtr, x, y, width, height, sizeFlags)
	End Method

	Rem
	bbdoc: Sets the size and position of the window in pixels.
	End Rem
	Method SetDimensionsRect(rect:wxRect)
		bmx_wxwindow_setdimensionsrect(wxObjectPtr, rect.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the size of the window in pixels.
	End Rem
	Method SetSize(width:Int, height:Int)
		bmx_wxwindow_setsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Sets the position of the window in pixels.
	End Rem
	Method SetPosition(x:Int, y:Int)
		bmx_wxwindow_setposition(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Sets the window to have the given layout sizer.
	about: The window will then own the object, and will take care of its deletion. If an existing layout
	constraints object is already owned by the window, it will be deleted if the deleteOld parameter
	is true.
	<p>
	Note that this method will also call SetAutoLayout implicitly with true parameter if the sizer is
	non-NULL and false otherwise.
	</p>
	End Rem
	Method SetSizer(sizer:wxSizer, deleteOld:Int = True)
		bmx_wxwindow_setsizer(wxObjectPtr, sizer.wxSizerPtr, deleteOld)
	End Method

	Rem
	bbdoc: The same as SetSizer, except it also sets the size hints for the window based on the sizer's minimum size.
	End Rem
	Method SetSizerAndFit(sizer:wxSizer, deleteOld:Int = True)
		bmx_wxwindow_setsizerandfit(wxObjectPtr, sizer.wxSizerPtr, deleteOld)
	End Method
	
	Rem
	bbdoc: This method tells a window if it should use the system's "theme" code to draw the windows' background instead if its own background drawing code.
	about: This does not always have any effect since the underlying platform obviously needs to support the
	notion of themes in user defined windows. One such platform is GTK+ where windows can have (very colourful)
	backgrounds defined by a user's selected theme.
	<p>
	Dialogs, notebook pages and the status bar have this flag set to true by default so that the default look
	and feel is simulated best.
	</p>
	End Rem
	Method SetThemeEnabled(enable:Int)
		bmx_wxwindow_setthemeenabled(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: Attach a tooltip to the window.
	End Rem
	Method SetToolTip(tip:String)
		bmx_wxwindow_settooltip(wxObjectPtr, tip)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValidator()
	End Method
	
	Rem
	bbdoc: Sets the virtual size of the window in pixels.
	End Rem
	Method SetVirtualSize(width:Int, height:Int)
		bmx_wxwindow_setvirtualsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Allows specification of minimum and maximum virtual window sizes.
	about: If a pair of values is not set (or set to -1), the default values will be used.
	End Rem
	Method SetVirtualSizeHints(minW:Int = -1, minH:Int = -1, maxW:Int = -1, maxH:Int = -1)
		bmx_wxwindow_setvirtualsizehints(wxObjectPtr, minW, minH, maxW, maxH)
	End Method
	
	Rem
	bbdoc: Identical to SetWindowStyleFlag.
	End Rem
	Method SetWindowStyle(style:Int)
		bmx_wxwindow_setwindowstyle(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Sets the style of the window.
	about: Please note that some styles cannot be changed after the window creation and that
	Refresh() might need to be be called after changing the others for the change to take place immediately.
	End Rem
	Method SetWindowStyleFlag(style:Int)
		bmx_wxwindow_setwindowstyleflag(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: This method can be called under all platforms but only does anything under Mac OS X 10.3+ currently.
	about: Under this system, each of the standard control can exist in several sizes which
	correspond to the following values : 
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxWINDOW_VARIANT_NORMAL</td><td>Normal size</td></tr>
	<tr><td>wxWINDOW_VARIANT_SMALL</td><td>Smaller size (about 25 % smaller than normal )</td></tr>
	<tr><td>wxWINDOW_VARIANT_MINI</td><td>Mini size (about 33 % smaller than normal )</td></tr>
	<tr><td>wxWINDOW_VARIANT_LARGE</td><td>Large size (about 25 % larger than normal )</td></tr>
	</table>
	By default the controls use the normal size, of course, but this method can be used to change this.
	End Rem
	Method SetWindowVariant(variant:Int)
		bmx_wxwindow_setwindowvariant(wxObjectPtr, variant)
	End Method
	
	'Rem
	'bbdoc: Return True from here To allow the colours of this window To be changed by InheritAttributes, returning False forbids inheriting them from the parent window.
	'about: The base Type version returns False, but this Method is overridden in wxControl where it returns True.
	'End Rem
	'Method ShouldInheritColours:Int()
	'	Return bmx_wxwindow_shouldinheritcolours(wxObjectPtr)
	'End Method
	
	'Function _shouldinheritcolour:Int(window:wxWindow)
	'	Return window.ShouldInheritColours()
	'End Function
	
	
	Rem
	bbdoc: Shows or hides the window.
	returns: True if the window has been shown or hidden or False if nothing was done because it already was in the requested state.
	about: You may need to call #raise for a top level window if you want to bring it to top, although
	this is not needed if show is called immediately after the frame creation.
	End Rem
	Method Show:Int(value:Int = True)
		Return bmx_wxwindow_show(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Reenables window updating after a previous call to Freeze.
	about: To really thaw the control, it must be called exactly the same number of times as Freeze.
	End Rem
	Method Thaw()
		bmx_wxwindow_thaw(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Turns the given flag on if it's currently turned off and vice versa.
	returns: True if the style was turned on by this function, False if it was switched off.
	about: This method cannot be used if the value of the flag is 0 (which is often the case for default
	flags).
	<p>
	Also, please notice that not all styles can be changed after the control creation.
	</p>
	End Rem
	Method ToggleWindowStyle:Int(flag:Int)
		Return bmx_wxwindow_togglewindowstyle(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Transfers values from child controls to data areas specified by their validators.
	returns: False if a transfer failed.
	about: If the window has wxWS_EX_VALIDATE_RECURSIVELY extra style flag set, the method will also call
	TransferDataFromWindow() of all child windows.
	End Rem
	Method TransferDataFromWindow:Int()
		Return bmx_wxwindow_transferdatafromwindow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Transfers values to child controls from data areas specified by their validators.
	returns: False if a transfer failed.
	about: If the window has wxWS_EX_VALIDATE_RECURSIVELY extra style flag set, the method will also call
	TransferDataToWindow() of all child windows.
	End Rem
	Method TransferDataToWindow:Int()
		Return bmx_wxwindow_transferdatatowindow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Unregisters a system wide hotkey.
	about: This method is currently only implemented under MSW.
	End Rem
	Method UnregisterHotKey:Int(hotKeyId:Int)
		Return bmx_wxwindow_unregisterhotkey(wxObjectPtr, hotKeyId)
	End Method
	
	Rem
	bbdoc: Calling this method immediately repaints the invalidated area of the window and all of its children recursively while this would usually only happen when the flow of control returns to the event loop.
	about: Notice that this method doesn't invalidate any area of the window so nothing happens if nothing has
	been invalidated (i.e. marked as requiring a redraw). Use Refresh first if you want to immediately redraw
	the window unconditionally.
	End Rem
	Method Update()
		bmx_wxwindow_udpate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method sends wxUpdateUIEvents to the window.
	about: The particular implementation depends on the window; for example a wxToolBar will send an update
	UI event for each toolbar button, and a wxFrame will send an update UI event for each menubar menu item.
	You can call this function from your application to ensure that your UI is up-to-date at this point (as
	far as your wxUpdateUIEvent handlers are concerned). This may be necessary if you have called
	wxUpdateUIEvent::SetMode or wxUpdateUIEvent::SetUpdateInterval to limit the overhead that wxWidgets
	incurs by sending update UI events in idle time.
	<p>
	flags should be a bitlist of one or more of the following values :
	<ul>
	<li>wxUPDATE_UI_NONE - No particular value</li>
	<li>wxUPDATE_UI_RECURSE -  Call the function for descendants</li>
	<li>wxUPDATE_UI_FROMIDLE - Invoked from On(Internal)Idle</li>
	</ul>
	</p>
	<p>
	If you are calling this method from an OnInternalIdle or OnIdle function, make sure you pass
	the wxUPDATE_UI_FROMIDLE flag, since this tells the window to only update the UI elements that need to
	be updated in idle time. Some windows update their elements only when necessary, for example when a menu
	is about to be shown. The following is an example of how to call UpdateWindowUI from an idle function :
	<pre>
	Method OnInternalIdle()
		If wxUpdateUIEvent.CanUpdate(Self) Then
			UpdateWindowUI(wxUPDATE_UI_FROMIDLE)
		End If
	End Method
	</pre>
	</p>
	End Rem
	Method UpdateWindowUI(flags:Int = wxUPDATE_UI_NONE)
		bmx_wxwindow_updatewindowui(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Validates the current values of the child controls using their validators.
	returns: False if any of the validations failed.
	about: If the window has wxWS_EX_VALIDATE_RECURSIVELY extra style flag set, the method will also call
	Validate() of all child windows.
	End Rem
	Method Validate:Int()
		Return bmx_wxwindow_validate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves the pointer to the given position on the window.
	about: NB: This function is not supported under Mac because Apple Human Interface
	Guidelines forbid moving the mouse cursor programmatically.
	End Rem
	Method WarpPointer(x:Int, y:Int)
		bmx_wxwindow_warppointer(wxObjectPtr, x, y)
	End Method	
	
End Type


Type wxSizerItem

	Field wxSizerItemPtr:Byte Ptr
	
	Function _create:wxSizerItem(wxSizerItemPtr:Byte Ptr)
		Local this:wxSizerItem = New wxSizerItem
		
		this.wxSizerItemPtr = wxSizerItemPtr
		
		Return this
	End Function
	
End Type


Rem
bbdoc: wxSizer is the abstract base class used for laying out subwindows in a window.
about: You cannot use wxSizer directly; instead, you will have to use one of the sizer classes derived
from it. Currently there are #wxBoxSizer, #wxStaticBoxSizer, #wxGridSizer, #wxFlexGridSizer and
#wxGridBagSizer.
<p>
The layout algorithm used by sizers in wxWidgets is closely related to layout in other GUI toolkits,
such as Java's AWT, the GTK toolkit or the Qt toolkit. It is based upon the idea of the individual
subwindows reporting their minimal required size and their ability to get stretched if the size of the
parent window has changed. This will most often mean that the programmer does not set the original size
of a dialog in the beginning, rather the dialog will be assigned a sizer and this sizer will be queried
about the recommended size. The sizer in turn will query its children, which can be normal windows, empty
space or other sizers, so that a hierarchy of sizers can be constructed. Note that wxSizer does not
derive from wxWindow and thus does not interfere with tab ordering and requires very little resources
compared to a real window on screen.
</p>
<p>
What makes sizers so well fitted for use in wxWidgets is the fact that every control reports its own
minimal size and the algorithm can handle differences in font sizes or different window (dialog item)
sizes on different platforms without problems. If e.g. the standard font as well as the overall design
of Motif widgets requires more space than on Windows, the initial dialog size will automatically be
bigger on Motif than on Windows.
</p>
<p>
Sizers may also be used to control the layout of custom drawn items on the window. The Add, Insert, and
Prepend functions return a pointer to the newly added wxSizerItem. Just add empty space of the desired
size and attributes, and then use the wxSizerItem::GetRect method to determine where the drawing
operations should take place.
</p>
<p>
Please notice that sizers, like child windows, are owned by the library and will be deleted by it which
implies that they must be allocated on the heap. However if you create a sizer and do not add it to
another sizer or window, the library wouldn't be able to delete such an orphan sizer and in this,
and only this, case it should be deleted explicitly.
</p>
End Rem
Type wxSizer

	Field wxSizerPtr:Byte Ptr
	
	Function _create:wxSizer(wxSizerPtr:Byte Ptr)
		If wxSizerPtr Then
			Local this:wxSizer = New wxSizer
		
			this.wxSizerPtr = wxSizerPtr
		
			Return this
		End If
		
		Return Null
	End Function

	Function _find:wxSizer(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local sizer:wxSizer = wxSizer(wxfind(wxObjectPtr))
			If Not sizer Then
				Return wxSizer._create(wxObjectPtr)
			End If
			Return sizer
		End If
	End Function

	
	Rem
	bbdoc: Appends a wxWindow to the sizer.
	about: Its initial size (either set explicitly by the user or calculated internally when
	using default size (-1, -1)) is interpreted as the minimal and in many cases also the initial size.
	End Rem
	Method Add:wxSizerItem(window:wxWindow, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_add(wxSizerPtr, window.wxObjectPtr, proportion, flag, border))
	End Method
	
	Rem
	bbdoc: Appends a child-sizer to the sizer.
	about: This allows placing a child sizer in a sizer and thus to create hierarchies of sizers
	(typically a vertical box as the top sizer and several horizontal boxes on the level beneath).
	End Rem
	Method AddSizer:wxSizerItem(sizer:wxSizer, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_addsizer(wxSizerPtr, sizer.wxSizerPtr, proportion, flag, border))
	End Method

	Rem
	bbdoc: Appends a custom spacer to the sizer.
	about: Adding spacers to sizers gives more flexibility in the design of dialogs; imagine for
	example a horizontal box with two buttons at the bottom of a dialog: you might want to insert a
	space between the two buttons and make that space stretchable using the proportion flag and the
	result will be that the left button will be aligned with the left side of the dialog and the
	right button with the right side - the space in between will shrink and grow with the dialog.
	End Rem
	Method AddCustomSpacer:wxSizerItem(width:Int, height:Int, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_addcustomspacer(wxSizerPtr, width, height, proportion, flag, border))
	End Method
	
	Rem
	bbdoc: Adds non-stretchable space to the sizer.
	about: More readable way of calling AddCustomSpacer(size, size, 0).
	End Rem
	Method AddSpacer:wxSizerItem(size:Int)
		Return wxSizerItem._create(bmx_wxsizer_addspacer(wxSizerPtr, size))
	End Method
	
	Rem
	bbdoc: Adds stretchable space to the sizer.
	about: More readable way of calling AddCustomSpacer(0, 0, prop).
	End Rem
	Method AddStretchSpacer:wxSizerItem(proportion:Int = 1)
		Return wxSizerItem._create(bmx_wxsizer_addstretchspacer(wxSizerPtr, proportion))
	End Method
	
	Rem
	bbdoc: The sizer will do the actual calculation of its children minimal sizes.
	End Rem
	Method CalcMin(w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: Detaches all children from the sizer.
	about: If delete_windows is true then child windows will also be deleted.
	End Rem
	Method Clear(deleteWindows:Int = False)
		bmx_wxsizer_clear(wxSizerPtr, deleteWindows)
	End Method

	Rem
	bbdoc: Detach a child from the sizer without destroying it.
	End Rem
	Method Detach:Int(window:wxWindow)
		Return bmx_wxsizer_detach(wxSizerPtr, window.wxObjectPtr)
	End Method

	Rem
	bbdoc: Detach a child from the sizer without destroying it.
	End Rem
	Method DetachSizer:Int(sizer:wxSizer)
		Return bmx_wxsizer_detachsizer(wxSizerPtr, sizer.wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Tell the sizer to resize the window to match the sizer's minimal size.
	about: This is commonly done in the constructor of the window itself, see sample in the description
	of wxBoxSizer.
	<p>
	For a top level window this is the total window size, not client size.
	</p>
	End Rem
	Method Fit(window:wxWindow)
		bmx_wxsizer_fit(wxSizerPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Same as wxSizer::Fit, except that it returns the new size.
	End Rem
	Method FitSize(window:wxWindow, w:Int Var, h:Int Var)
		bmx_wxsizer_fitsize(wxSizerPtr, window.wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Tell the sizer to resize the virtual size of the window to match the sizer's minimal size.
	about: This will not alter the on screen size of the window, but may cause the
	addition/removal/alteration of scrollbars required to view the virtual area in windows which
	manage it.
	End Rem
	Method FitInside(window:wxWindow)
		bmx_wxsizer_fitinside(wxSizerPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the list of the items in this sizer.
	End Rem
	Method GetChildren()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns the window this sizer is used in or NULL if none.
	End Rem
	Method GetContainingWindow:wxWindow()
		Return wxWindow._find(bmx_wxsizer_getcontainingwindow(wxSizerPtr))
	End Method
	
	Rem
	bbdoc: Returns the current size of the sizer.
	End Rem
	Method GetSize(w:Int Var, h:Int Var)
		bmx_wxsizer_getsize(wxSizerPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the current position of the sizer.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxsizer_getposition(wxSizerPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the minimal size of the sizer.
	about: This is either the combined minimal size of all the children and their borders or the
	minimal size set by SetMinSize, depending on which is bigger.
	End Rem
	Method GetMinSize(w:Int Var, h:Int Var)
		bmx_wxsizer_getminsize(wxSizerPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Insert a child into the sizer before any existing item at index
	End Rem
	Method Insert:wxSizerItem(index:Int, window:wxWindow, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_insert(wxSizerPtr, index, window.wxObjectPtr, proportion, flag, border))
	End Method
	
	Rem
	bbdoc: Insert a child into the sizer before any existing item at index
	End Rem
	Method InsertSizer:wxSizerItem(index:Int, sizer:wxSizer, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_insertsizer(wxSizerPtr, index, sizer.wxSizerPtr, proportion, flag, border))
	End Method

	Rem
	bbdoc: Inserts non-stretchable space to the sizer.
	End Rem
	Method InsertSpacer:wxSizerItem(index:Int, size:Int)
		Return wxSizerItem._create(bmx_wxsizer_insertspacer(wxSizerPtr, index, size))
	End Method
	
	Rem
	bbdoc: Inserts stretchable space to the sizer.
	End Rem
	Method InsertStretchSpacer:wxSizerItem(index:Int, prop:Int = 1)
		Return wxSizerItem._create(bmx_wxsizer_insertstretchspacer(wxSizerPtr, index, prop))
	End Method
	
	Rem
	bbdoc: Returns true if the window is shown.
	End Rem
	Method IsWindowShown:Int(window:wxWindow)
		Return bmx_wxsizer_iswindowshown(wxSizerPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the sizer is shown.
	End Rem
	Method IsSizerShown:Int(sizer:wxSizer)
		Return bmx_wxsizer_issizershown(wxSizerPtr, sizer.wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the item at index is shown.
	End Rem
	Method IsShown:Int(index:Int)
		Return bmx_wxsizer_isshown(wxSizerPtr, index)
	End Method
	
	Rem
	bbdoc: Call this to force layout of the children anew, e.g. after having added a child to or removed a child (window, other sizer or space) from the sizer while keeping the current dimension.
	End Rem
	Method Layout()
		bmx_wxsizer_layout(wxSizerPtr)
	End Method

	Rem
	bbdoc: Same as wxSizer::Add, but prepends the window to the beginning of the list of items owned by this sizer.
	End Rem
	Method Prepend:wxSizerItem(window:wxWindow, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_prepend(wxSizerPtr, window.wxObjectPtr, proportion, flag, border))
	End Method

	Rem
	bbdoc: Same as wxSizer::AddSizer, but prepends the sizer to the beginning of the list of items owned by this sizer.
	End Rem
	Method PrependSizer:wxSizerItem(sizer:wxSizer, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_prependsizer(wxSizerPtr, sizer.wxSizerPtr, proportion, flag, border))
	End Method
	
	Rem
	bbdoc: Same as wxSizer::AddSpacer, but prepends the spacer to the beginning of the list of items owned by this sizer.
	End Rem
	Method PrependSpacer:wxSizerItem(size:Int)
		Return wxSizerItem._create(bmx_wxsizer_prependspacer(wxSizerPtr, size))
	End Method
	
	Rem
	bbdoc: Same as wxSizer::AddStretchSpacer, but prepends the spacer to the beginning of the list of items owned by this sizer.
	End Rem
	Method PrependStretchSpacer:wxSizerItem(prop:Int = 1)
		Return wxSizerItem._create(bmx_wxsizer_prependstretchspacer(wxSizerPtr, prop))
	End Method
	
	Rem
	bbdoc: The sizer will do the actual calculation of its children's positions and sizes.
	End Rem
	Method RecalcSizes()
		bmx_wxsizer_recalcsizes(wxSizerPtr)
	End Method
	
	Rem
	bbdoc:  This method is deprecated as it does not destroy the window as would usually be expected from Remove.
	returns: True if the child item was found and removed, false otherwise.
	You should use wxSizer::Detach in new code instead. There is currently no wxSizer method
	that will both detach and destroy a wxWindow item. For your convenience, Detach is called here anyway... but you've been warned :-p
	End Rem
	Method RemoveWindow:Int(window:wxWindow)
		Return Detach(window)
	End Method
	
	Rem
	bbdoc: Removes a child sizer from the sizer and destroys it if it.
	returns: True if the child item was found and removed, false otherwise.
	about: This method does not cause any layout or resizing to take place, call wxSizer::Layout
	to update the layout "on screen" after removing a child from the sizer.	
	End Rem
	Method RemoveSizer:Int(sizer:wxSizer)
		Return bmx_wxsizer_removesizer(wxSizerPtr, sizer.wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Removes a child item from the sizer and destroys it if it.
	returns: True if the child item was found and removed, false otherwise.
	about: This method does not cause any layout or resizing to take place, call wxSizer::Layout
	to update the layout "on screen" after removing a child from the sizer.	
	End Rem
	Method Remove:Int(index:Int)
		Return bmx_wxsizer_remove(wxSizerPtr, index)
	End Method
	
	Rem
	bbdoc: Detaches the given @oldWin child from the sizer and replaces it with the given window.
	about: The detached child is removed only if it is a sizer or a spacer (because windows are owned by their parent window, not the sizer).
	<p>
	Use parameter recursive to search the given element recursively in subsizers.
	</p>
	<p>
	This method does not cause any layout or resizing to take place, call wxSizer::Layout to
	update the layout "on screen" after replacing a child from the sizer.
	</p>
	End Rem
	Method ReplaceWindow:Int(oldWin:wxWindow, newWin:wxWindow, recursive:Int = False)
		Return bmx_wxsizer_replacewindow(wxSizerPtr, oldWin.wxObjectPtr, newWin.wxObjectPtr, recursive)
	End Method
	
	Rem
	bbdoc: Detaches the given @oldsz child from the sizer and replaces it with the given sizer.
	about: The detached child is removed only if it is a sizer or a spacer (because windows are owned by their parent window, not the sizer).
	<p>
	Use parameter recursive to search the given element recursively in subsizers.
	</p>
	<p>
	This method does not cause any layout or resizing to take place, call wxSizer::Layout to
	update the layout "on screen" after replacing a child from the sizer.
	</p>
	End Rem
	Method ReplaceSizer:Int(oldsz:wxSizer, newsz:wxSizer, recursive:Int = False)
		Return bmx_wxsizer_replacesizer(wxSizerPtr, oldsz.wxSizerPtr, newsz.wxSizerPtr, recursive)
	End Method
	
	Rem
	bbdoc: Detaches the given indexed child from the sizer and replaces it with the new item.
	about: The detached child is removed only if it is a sizer or a spacer (because windows are owned by their parent window, not the sizer).
	<p>
	Use parameter recursive to search the given element recursively in subsizers.
	</p>
	<p>
	This method does not cause any layout or resizing to take place, call wxSizer::Layout to
	update the layout "on screen" after replacing a child from the sizer.
	</p>
	End Rem
	Method Replace:Int(oldIndex:Int, newItem:wxSizerItem)
		Return bmx_wxsizer_replace(wxSizerPtr, oldIndex, newItem.wxSizerItemPtr)
	End Method
	
	Rem
	bbdoc: Call this to force the sizer to take the given dimension and thus force the items owned by the sizer to resize themselves according to the rules defined by the parameter in the Add and Prepend methods.
	End Rem
	Method SetDimension(x:Int, y:Int, width:Int, height:Int)
		bmx_wxsizer_setdimension(wxSizerPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: Call this to give the sizer a minimal size.
	about: Normally, the sizer will calculate its minimal size based purely on how much space
	its children need. After calling this method GetMinSize will return either the minimal size
	as requested by its children or the minimal size set here, depending on which is bigger.
	End Rem
	Method SetMinSize(width:Int, height:Int)
		bmx_wxsizer_setminsize(wxSizerPtr, width, height)
	End Method

	Rem
	bbdoc: Set an item's minimum size by position.
	about: The item will be found recursively in the sizer's descendants. This function enables an
	application to set the size of an item after initial creation.
	End Rem
	Method SetItemMinSize(index:Int, width:Int, height:Int)
		bmx_wxsizer_setitemminsize(wxSizerPtr, index, width, height)
	End Method

	Rem
	bbdoc: Set an item's minimum size by window.
	about: The item will be found recursively in the sizer's descendants. This function enables an
	application to set the size of an item after initial creation.
	End Rem
	Method SetItemMinSizeWindow(window:wxWindow, width:Int, height:Int)
		bmx_wxsizer_setitemminsizewindow(wxSizerPtr, window.wxObjectPtr, width, height)
	End Method

	Rem
	bbdoc: Set an item's minimum size by sizer.
	about: The item will be found recursively in the sizer's descendants. This function enables an
	application to set the size of an item after initial creation.
	End Rem
	Method SetItemMinSizeSizer(sizer:wxSizer, width:Int, height:Int)
		bmx_wxsizer_setitemminsizesizer(wxSizerPtr, sizer.wxSizerPtr, width, height)
	End Method
	
	Rem
	bbdoc: This method first calls wxSizer::Fit and then SetSizeHints on the window passed to it.
	about: This only makes sense when window is actually a wxTopLevelWindow such as a wxFrame or a
	wxDialog, since SetSizeHints only has any effect in these classes. It does nothing in normal
	windows or controls.
	<p>
	This method is commonly invoked in the constructor of a toplevel window itself (see the sample
	in the description of wxBoxSizer) if the toplevel window is resizable.
	</p>
	End Rem
	Method SetSizeHints(window:wxWindow)
		bmx_wxsizer_setsizehints(wxSizerPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Tell the sizer to set the minimal size of the window virtual area to match the sizer's minimal size.
	about: For windows with managed scrollbars this will set them appropriately.
	End Rem
	Method SetVirtualSizeHints(window:wxWindow)
		bmx_wxsizer_setvirtualsizehints(wxSizerPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Shows or hides the window.
	returns: True if the child item was found, False otherwise.
	about: To make a sizer item disappear or reappear, use Show() followed by Layout(). Use parameter
	recursive to show or hide elements found in subsizers.
	End Rem
	Method Show:Int(window:wxWindow, doShow:Int = True, recursive:Int = False)
		Return bmx_wxsizer_show(wxSizerPtr, window.wxObjectPtr, doShow, recursive)
	End Method
	
	Rem
	bbdoc: Shows or hides the sizer.
	returns: True if the child item was found, False otherwise.
	about: To make a sizer item disappear or reappear, use Show() followed by Layout(). Use parameter
	recursive to show or hide elements found in subsizers.
	End Rem
	Method ShowSizer:Int(sizer:wxSizer, doShow:Int = True, recursive:Int = False)
		Return bmx_wxsizer_showsizer(wxSizerPtr, sizer.wxSizerPtr, doShow, recursive)
	End Method
	
	Rem
	bbdoc: Shows or hides the item at @index.
	returns: True if the child item was found, False otherwise.
	about: To make a sizer item disappear or reappear, use Show() followed by Layout(). Use parameter
	recursive to show or hide elements found in subsizers.
	End Rem
	Method ShowItem:Int(index:Int, doShow:Int = True)
		Return bmx_wxsizer_showitem(wxSizerPtr, index, doShow)
	End Method
	
End Type

Rem
bbdoc: The basic idea behind a box sizer is that windows will most often be laid out in rather simple basic geometry, typically in a row or a column or several hierarchies of either.
about: As an example, we will construct a dialog that will contain a text field at the top and two
buttons at the bottom. This can be seen as a top-hierarchy column with the text at the top and
buttons at the bottom and a low-hierarchy row with an OK button to the left and a Cancel button
to the right. In many cases (particularly dialogs under Unix and normal frames) the main window
will be resizable by the user and this change of size will have to get propagated to its children.
In our case, we want the text area to grow with the dialog, whereas the button shall have a fixed
size. In addition, there will be a thin border around all controls to make the dialog look nice and
- to make matter worse - the buttons shall be centred as the width of the dialog changes.
<p>
It is the unique feature of a box sizer, that it can grow in both directions (height and width) but
can distribute its growth in the main direction (horizontal for a row) unevenly among its children.
In our example case, the vertical sizer is supposed to propagate all its height changes to only the
text area, not to the button area. This is determined by the proportion parameter when adding a
window (or another sizer) to a sizer. It is interpreted as a weight factor, i.e. it can be zero,
indicating that the window may not be resized at all, or above zero. If several windows have a value
above zero, the value is interpreted relative to the sum of all weight factors of the sizer, so when
adding two windows with a value of 1, they will both get resized equally much and each half as much
as the sizer owning them. Then what do we do when a column sizer changes its width? This behaviour
is controlled by flags (the second parameter of the Add() function): Zero or no flag indicates that
the window will preserve it is original size, wxGROW flag (same as wxEXPAND) forces the window to
grow with the sizer, and wxSHAPED flag tells the window to change it is size proportionally,
preserving original aspect ratio. When wxGROW flag is not used, the item can be aligned within
available space. wxALIGN_LEFT, wxALIGN_TOP, wxALIGN_RIGHT, wxALIGN_BOTTOM, wxALIGN_CENTER_HORIZONTAL
and wxALIGN_CENTER_VERTICAL do what they say. wxALIGN_CENTRE (same as wxALIGN_CENTER) is defined as
(wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL). Default alignment is wxALIGN_LEFT |
wxALIGN_TOP.
</p>
<p>
As mentioned above, any window belonging to a sizer may have border, and it can be specified which
of the four sides may have this border, using the wxTOP, wxLEFT, wxRIGHT and wxBOTTOM constants or
wxALL for all directions (and you may also use wxNORTH, wxWEST etc instead). These flags can be used
in combination with the alignment flags above as the second parameter of the Add() method using the
binary or operator |. The sizer of the border also must be made known, and it is the third parameter
in the Add() method. This means, that the entire behaviour of a sizer and its children can be
controlled by the three parameters of the Add() method.
</p>
<pre>
' we want to get a dialog that is stretchable because it
' has a text ctrl at the top and two buttons at the bottom 
Type MyDialog Extends wxDialog

	Function CreateMyDialog:MyDialog(parent:wxFrame, id:Int, title:String)
	    Return New MyDialog.Create(parent, id, title, -1, -1, -1, -1, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
	End Function

	Method OnInit:Int()
	
	  Local topsizer:wxBoxSizer = New wxBoxSizer.Create( wxVERTICAL )
	  ' create text ctrl with minimal size 100x60 
	  topsizer.Add( ..
	    New wxTextCtrl.Create( Self, -1, "My text.", -1, -1, 100, 60, wxTE_MULTILINE), ..
	    1,           .. ' make vertically stretchable 
	    wxEXPAND |   .. ' make horizontally stretchable 
	    wxALL,       .. '   and make border all around 
	    10 )            ' set border width to 10 
	  Local button_sizer:wxBoxSizer = New wxBoxSizer.Create( wxHORIZONTAL )
	  button_sizer.Add( ..
	     New wxButton.Create( Self, wxID_OK, "OK" ), ..
	     0,          .. ' make horizontally unstretchable 
	     wxALL,      .. ' make border all around (implicit top alignment) 
	     10 )           ' set border width to 10 
	  button_sizer.Add(  ..
	     New wxButton.Create( Self, wxID_CANCEL, "Cancel" ), ..
	     0,          .. ' make horizontally unstretchable 
	     wxALL,      .. ' make border all around (implicit top alignment) 
	     10 )           ' set border width to 10 
	  topsizer.AddSizer( .. 
	     button_sizer,  ..
	     0,             .. ' make vertically unstretchable 
	     wxALIGN_CENTER ) ' no border and centre horizontally 
	  SetSizer( topsizer )      ' use the sizer for layout 
	  topsizer.SetSizeHints( Self )   ' set size hints to honour minimum size 
	  
		Return True
	End Method

End Type
</pre>
End Rem
Type wxBoxSizer Extends wxSizer

	Function _create:wxBoxSizer(wxSizerPtr:Byte Ptr)
		If wxSizerPtr Then
			Local this: wxBoxSizer= New wxBoxSizer
		
			this.wxSizerPtr = wxSizerPtr
		
			Return this
		End If
		
		Return Null
	End Function

	Rem
	bbdoc: Constructor for a wxBoxSizer.
	about: @orient may be either of wxVERTICAL or wxHORIZONTAL for creating either a column sizer
	or a row sizer.
	End Rem
	Function CreateBoxSizer:wxBoxSizer(orient:Int)
		Return New wxBoxSizer.Create(orient)
	End Function
	
	Rem
	bbdoc: Creates a new wxBoxSizer.
	about: @orient may be either of wxVERTICAL or wxHORIZONTAL for creating either a column sizer
	or a row sizer.
	End Rem
	Method Create:wxBoxSizer(orient:Int)
		wxSizerPtr = bmx_wxboxsizer_create(Self, orient)
		Return Self
	End Method

	' Internal use only!
	'Method RecalcSizes()
	'	bmx_wxboxsizer_recalcsizes(wxSizerPtr)
	'End Method
	
	' Internal use only!
	'Method CalcMin(w:Int Var, h:Int Var)
	'	bmx_wxboxsizer_calcmin(wxSizerPtr, Varptr w, Varptr h)
	'End Method

	Rem
	bbdoc: Returns the orientation of the box sizer, either wxVERTICAL or wxHORIZONTAL.
	End Rem
	Method GetOrientation:Int()
		Return bmx_wxboxsizer_getorientation(wxSizerPtr)
	End Method
		
End Type

Rem
bbdoc: A grid sizer is a sizer which lays out its children in a two-dimensional table with all table fields having the same size, i.e. the width of each field is the width of the widest child, the height of each field is the height of the tallest child.
End Rem
Type wxGridSizer Extends wxSizer

	Rem
	bbdoc: Constructor for a wxGridSize, using rows and cols.
	End Rem
	Method CreateRC:wxGridSizer(rows:Int, cols:Int, vgap:Int, hgap:Int)
		wxSizerPtr = bmx_wxgridsizer_createrc(Self, rows, cols, vgap, hgap)
		Return Self
	End Method

	Rem
	bbdoc: Constructor for a wxGridSize.
	End Rem
	Method Create:wxGridSizer(cols:Int, vgap:Int = 0, hgap:Int = 0)
		wxSizerPtr = bmx_wxgridsizer_create(Self, cols, vgap, hgap)
		Return Self
	End Method

	Rem
	bbdoc: Returns the number of columns in the sizer.
	End Rem
	Method GetCols:Int()
		Return bmx_wxgridsizer_getcols(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Returns the horizontal gap (in pixels) between cells in the sizer.
	End Rem
	Method GetHGap:Int()
		Return bmx_wxgridsizer_gethgap(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of rows in the sizer.
	End Rem
	Method GetRows:Int()
		Return bmx_wxgridsizer_getrows(wxSizerPtr)
	End Method

	Rem
	bbdoc: Returns the vertical gap (in pixels) between the cells in the sizer.
	End Rem
	Method GetVGap:Int()
		Return bmx_wxgridsizer_getvgap(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Sets the number of columns in the sizer.
	End Rem
	Method SetCols(cols:Int)
		bmx_wxgridsizer_setcols(wxSizerPtr, cols)
	End Method
	
	Rem
	bbdoc: Sets the horizontal gap (in pixels) between cells in the sizer.
	End Rem
	Method SetHGap(hgap:Int)
		bmx_wxgridsizer_sethgap(wxSizerPtr, hgap)
	End Method
	
	Rem
	bbdoc: Sets the number of rows in the sizer.
	End Rem
	Method SetRows(rows:Int)
		bmx_wxgridsizer_setrows(wxSizerPtr, rows)
	End Method
	
	Rem
	bbdoc: Sets the vertical gap (in pixels) between the cells in the sizer.
	End Rem
	Method SetVGap(vgap:Int)
		bmx_wxgridsizer_setvgap(wxSizerPtr, vgap)
	End Method
	
End Type

Rem
bbdoc: A flex grid sizer is a sizer which lays out its children in a two-dimensional table with all table fields in one row having the same height and all fields in one column having the same width, but all rows or all columns are not necessarily the same height or width as in the wxGridSizer.
about: A wxFlexGridSizer can also size items equally in one direction but unequally ("flexibly") in the
other. If the sizer is only flexible in one direction (this can be changed using SetFlexibleDirection),
it needs to be decided how the sizer should grow in the other ("non-flexible") direction in order to
fill the available space. The SetNonFlexibleGrowMode method serves this purpose.
End Rem
Type wxFlexGridSizer Extends wxGridSizer

	Rem
	bbdoc: Constructor for a wxFlexGridSizer.
	about: @cols determine the number of columns and rows in the sizer - if either of the
	parameters is zero, it will be calculated to form the total number of children in the sizer,
	thus making the sizer grow dynamically. vgap and hgap define extra space between all children.
	End Rem
	Method Create:wxFlexGridSizer(cols:Int, vgap:Int = 0, hgap:Int = 0)
		wxSizerPtr = bmx_wxflexgridsizer_create(Self, cols, vgap, hgap)
		Return Self
	End Method

	Rem
	bbdoc: Constructor for a wxFlexGridSizer.
	about: @rows and @cols determine the number of columns and rows in the sizer - if either of the
	parameters is zero, it will be calculated to form the total number of children in the sizer,
	thus making the sizer grow dynamically. vgap and hgap define extra space between all children.
	End Rem
	Method CreateRC:wxFlexGridSizer(rows:Int, cols:Int, vgap:Int, hgap:Int)
		wxSizerPtr = bmx_wxflexgridsizer_createrc(Self, rows, cols, vgap, hgap)
		Return Self
	End Method

	Rem
	bbdoc: Specifies that column @idx (starting from zero) should be grown if there is extra space available to the sizer.
	about: The @proportion parameter has the same meaning as the stretch factor for the sizers except
	that if all proportions are 0, then all columns are resized equally (instead of not being resized
	at all).
	End Rem
	Method AddGrowableCol(idx:Int, proportion:Int = 0)
		bmx_wxflexgridsizer_addgrowablecol(wxSizerPtr, idx, proportion)
	End Method
	
	Rem
	bbdoc: Specifies that row @idx (starting from zero) should be grown if there is extra space available to the sizer.
	about: The @proportion parameter has the same meaning as the stretch factor for the sizers except
	that if all proportions are 0, then all rows are resized equally (instead of not being resized
	at all).
	End Rem
	Method AddGrowableRow(idx:Int, proportion:Int = 0)
		bmx_wxflexgridsizer_addgrowablerow(wxSizerPtr, idx, proportion)
	End Method
	
	Rem
	bbdoc: Returns a wxOrientation value that specifies whether the sizer flexibly resizes its columns, rows, or both (default).
	End Rem
	Method GetFlexibleDirection:Int()
		Return bmx_wxflexgridsizer_getflexibledirection(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Returns the value that specifies how the sizer grows in the "non-flexible" direction if there is one.
	End Rem
	Method GetNonFlexibleGrowMode:Int()
		Return bmx_wxflexgridsizer_getnonflexiblegrowmode(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Specifies that column idx is no longer growable.
	End Rem
	Method RemoveGrowableCol(idx:Int)
		bmx_wxflexgridsizer_removegrowablecol(wxSizerPtr, idx)
	End Method
	
	Rem
	bbdoc: Specifies that row idx is no longer growable.
	End Rem
	Method RemoveGrowableRow(idx:Int)
		bmx_wxflexgridsizer_removegrowablerow(wxSizerPtr, idx)
	End Method
	
	Rem
	bbdoc: Specifies whether the sizer should flexibly resize its columns, rows, or both.
	about: Argument direction can be wxVERTICAL, wxHORIZONTAL or wxBOTH (which is the default
	value). Any other value is ignored. See GetFlexibleDirection() for the explanation of these
	values.
	<p>
	Note that this method does not trigger relayout.
	</p>
	End Rem
	Method SetFlexibleDirection(direction:Int)
		bmx_wxflexgridsizer_setflexibledirection(wxSizerPtr, direction)
	End Method
	
	Rem
	bbdoc: Specifies how the sizer should grow in the non-flexible direction if there is one (so SetFlexibleDirection() must have been called previously).
	about: Argument mode can be one of those documented in GetNonFlexibleGrowMode, please see there
	for their explanation.
	<p>
	Note that this method does not trigger relayout.
	</p>
	End Rem
	Method SetNonFlexibleGrowMode(mode:Int)
		bmx_wxflexgridsizer_setnonflexiblegrowmode(wxSizerPtr, mode)
	End Method
		
End Type



Rem
bbdoc: This type is used for pseudo-events which are called by wxWidgets to give an application the chance to update various user interface elements.
about: Without update UI events, an application has to work hard to check/uncheck, enable/disable, show/hide,
and set the text for elements such as menu items and toolbar buttons. The code for doing this has to be mixed
up with the code that is invoked when an action is invoked for a menu item or button.
<p>
With update UI events, you define an event handler to look at the state of the application and change UI elements
accordingly. wxWidgets will call your member functions in idle time, so you don't have to worry where to
call this code. In addition to being a clearer and more declarative method, it also means you don't have to
worry whether you're updating a toolbar or menubar identifier. The same handler can update a menu item and
toolbar button, if the identifier is the same.
</p>
<p>
Instead of directly manipulating the menu or button, you call functions in the event object, such as
wxUpdateUIEvent::Check. wxWidgets will determine whether such a call has been made, and which UI element to update.
</p>
<p>
These events will work for popup menus as well as menubars. Just before a menu is popped up, wxMenu::UpdateUI
is called to process any UI events for the window that owns the menu.
</p>
<p>
If you find that the overhead of UI update processing is affecting your application, you can do one or both
of the following:
<ol>
<li>Call wxUpdateUIEvent::SetMode with a value of wxUPDATE_UI_PROCESS_SPECIFIED, and set the extra style
wxWS_EX_PROCESS_UPDATE_EVENTS for every window that should receive update events. No other windows will
receive update events.</li>
<li>Call wxUpdateUIEvent::SetUpdateInterval with a millisecond value to set the delay between updates.
You may need to call wxWindow::UpdateWindowUI at critical points, for example when a dialog is about to be
shown, in case the user sees a slight delay before windows are updated.</li>
</ol>
Note that although events are sent in idle time, defining a wxIdleEvent handler for a window does not affect
this because the events are sent from wxWindow::OnInternalIdle which is always called in idle time.
</p>
<p>
wxWidgets tries to optimize update events on some platforms. On Windows and GTK+, events for menubar items
are only sent when the menu is about to be shown, and not in idle time.
</p>
End Rem
Type wxUpdateUIEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxUpdateUIEvent = New wxUpdateUIEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if it is appropriate to update (send UI update events to) this window.
	about: This method looks at the mode used (see wxUpdateUIEvent::SetMode), the wxWS_EX_PROCESS_UPDATE_EVENTS
	flag in window, the time update events were last sent in idle time, and the update interval, to determine
	whether events should be sent to this window now. By default this will always return true because
	the update mode is initially wxUPDATE_UI_PROCESS_ALL and the interval is set to 0; so update events will be
	sent as often as possible. You can reduce the frequency that events are sent by changing the mode and/or
	setting an update interval.
	End Rem
	Function CanUpdate:Int(window:wxWindow)
		Return bmx_wxupdateeventui_canupdate(window.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Check or uncheck the UI element.
	End Rem
	Method Check(value:Int)
		bmx_wxupdateeventui_check(wxEventPtr, value)
	End Method
	
	Rem
	bbdoc: Enable or disable the UI element.
	End Rem
	Method Enable(value:Int)
		bmx_wxupdateeventui_enable(wxEventPtr, value)
	End Method
	
	Rem
	bbdoc: Show or hide the UI element.
	End Rem
	Method Show(value:Int)
		bmx_wxupdateeventui_show(wxEventPtr, value)
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be checked.
	End Rem
	Method GetChecked:Int()
		Return bmx_wxupdateeventui_getchecked(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be enabled.
	End Rem
	Method GetEnabled:Int()
		Return bmx_wxupdateeventui_getenabled(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be shown.
	End Rem
	Method GetShown:Int()
		Return bmx_wxupdateeventui_getshown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the text that should be set for the UI element.
	End Rem
	Method GetText:String()
		Return bmx_wxupdateeventui_gettext(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Static function returning a value specifying how wxWidgets will send update events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function GetMode:Int()
		Return bmx_wxupdateeventui_getmode()
	End Function
	
	Rem
	bbdoc: Returns the current interval between updates in milliseconds.
	about: -1 disables updates, 0 updates as frequently as possible.
	End Rem
	Function GetUpdateInterval:Int()
		Return bmx_wxupdateeventui_getupdateinterval()
	End Function

	Rem
	bbdoc: Specify how wxWidgets will send update events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function SetMode(mode:Int)
		bmx_wxupdateeventui_setmode(mode)
	End Function
	
	Rem
	bbdoc: Sets the text for this UI element.
	End Rem
	Method SetText(text:String)
		bmx_wxupdateeventui_settext(wxEventPtr, text)
	End Method
	
	Rem
	bbdoc: Sets the interval between updates in milliseconds.
	about: Set to -1 to disable updates, or to 0 to update as frequently as possible. The default is 0.
	<p>
	Use this to reduce the overhead of UI update events if your application has a lot of windows. If you set the
	value to -1 or greater than 0, you may also need to call wxWindow::UpdateWindowUI at appropriate points in
	your application, such as when a dialog is about to be shown.
	</p>
	End Rem
	Function SetUpdateInterval(interval:Int)
		bmx_wxupdateeventui_setupdateinterval(interval)
	End Function
	
End Type



Rem
bbdoc: A focus event is sent when a window's focus changes.
about: The window losing focus receives a "kill focus" event while the window gaining it gets a "set focus"
one.
<p>
Notice that the set focus event happens both when the user gives focus to the window (whether using
the mouse or keyboard) and when it is done from the program itself using SetFocus.
</p>
End Rem
Type wxFocusEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxFocusEvent = New wxFocusEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns the window associated with this event.
	about: That is the window which had the focus before for the wxEVT_SET_FOCUS event and
	the window which is going to receive focus for the wxEVT_KILL_FOCUS one.
	<p>
	Warning: the window may be NULL!
	</p>
	End Rem
	Method GetWindow:wxWindow()
		Return wxWindow._find(bmx_wxfocusevent_getwindow(wxEventPtr))
	End Method

End Type

Rem
bbdoc: This type represents the events generated by a control (typically a wxTextCtrl but other windows can generate these events as well) when its content gets copied or cut to, or pasted from the clipboard.
about: There are three types of corresponding events wxEVT_COMMAND_TEXT_COPY, wxEVT_COMMAND_TEXT_CUT and
wxEVT_COMMAND_TEXT_PASTE.
<p>
If any of these events is processed (without being skipped) by an event handler, the corresponding operation
doesn't take place which allows to prevent the text from being copied from or pasted to a control. It is
also possible to examine the clipboard contents in the PASTE event handler and transform it in some way
before inserting in a control -- for example, changing its case or removing invalid characters.
</p>
<p>
Finally notice that a CUT event is always preceded by the COPY event which makes it possible to only process
the latter if it doesn't matter if the text was copied or cut.
</p>
<p>
These events are currently only generated by wxComboBox and under Windows and wxTextCtrl under Windows
and GTK and are not generated for the text controls with wxTE_RICH style under Windows.
</p>
End Rem
Type wxClipboardTextEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxClipboardTextEvent = New wxClipboardTextEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: This type is used for idle events, which are generated when the system becomes idle.
about: Note that, unless you do something specifically, the idle events are not sent if the system remains idle
once it has become it, e.g. only a single idle event will be generated until something else resulting in more normal
events happens and only then is the next idle event sent again. If you need to ensure a continuous stream of idle
events, you can either use RequestMore method in your handler or call wxWakeUpIdle periodically (for example from
timer event), but note that both of these approaches (and especially the first one) increase the system load and so
should be avoided if possible.
<p>
By default, idle events are sent to all windows (and also wxApp, as usual). If this is causing a significant
overhead in your application, you can call wxIdleEvent::SetMode with the value wxIDLE_PROCESS_SPECIFIED, and set the
wxWS_EX_PROCESS_IDLE extra window style for every window which should receive idle events.
</p>
End Rem
Type wxIdleEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxIdleEvent = New wxIdleEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if it is appropriate to send idle events to this window.
	about: This function looks at the mode used (see wxIdleEvent::SetMode), and the wxWS_EX_PROCESS_IDLE
	style in window to determine whether idle events should be sent to this window now. By default this
	will always return true because the update mode is initially wxIDLE_PROCESS_ALL. You can change the
	mode to only send idle events to windows with the wxWS_EX_PROCESS_IDLE extra window style set.
	End Rem
	Function CanSend:Int(window:wxWindow)
		Return bmx_wxidleevent_cansend(window.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Returns a value specifying how wxWidgets will send idle events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function GetMode:Int()
		Return bmx_wxidleevent_getmode()
	End Function
	
	Rem
	bbdoc: Tells wxWidgets that more processing is required.
	about: This method can be called by an OnIdle handler for a window or window event handler to indicate
	that wxApp::OnIdle should forward the OnIdle event once more to the application windows. If no window
	calls this method during OnIdle, then the application will remain in a passive event loop (not calling
	OnIdle) until a new event is posted to the application by the windowing system.
	End Rem
	Method RequestMore(needMore:Int = True)
		bmx_wxidleevent_requestmore(wxEventPtr, needMore)
	End Method
	
	Rem
	bbdoc: Returns true if the OnIdle function processing this event requested more processing time.
	End Rem
	Method MoreRequested:Int()
		Return bmx_wxidleevent_morerequested(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Function for specifying how wxWidgets will send idle events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function SetMode(mode:Int)
		bmx_wxidleevent_setmode(mode)
	End Function
	
End Type

Rem
bbdoc: A wxPaintDC must be constructed if an application wishes to paint on the client area of a window from within an OnPaint event.
about: This should normally be constructed as a temporary stack object; don't store a wxPaintDC object.
If you have an OnPaint handler, you must create a wxPaintDC object within it even if you don't actually use
it.
<p>
Using wxPaintDC within OnPaint is important because it automatically sets the clipping area to the damaged
area of the window. Attempts to draw outside this area do not appear.
</p>
<p>
To draw on a window from outside OnPaint, construct a wxClientDC object.
</p>
<p>
To draw on the whole window including decorations, construct a wxWindowDC object (Windows only).
</p>
End Rem
Type wxPaintDC Extends wxWindowDC

	Rem
	bbdoc: Constructor.
	about: Pass the window on which you wish to paint.
	End Rem
	Method Create:wxPaintDC(window:wxWindow)
		wxObjectPtr = bmx_wxpaintdc_create(window.wxObjectPtr)
		Return Self
	End Method

	Method Delete()
		Free()
	End Method

	Method Free()
		If wxObjectPtr Then
			bmx_wxpaintdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Type wxWindowDC Extends wxDC
End Type

Rem
bbdoc: A wxClientDC must be constructed if an application wishes to paint on the client area of a window from outside an OnPaint event.
about: Remeber to call Free() to release the DC.
<p>
To draw on a window from within OnPaint, construct a wxPaintDC object.
</p>
<p>
To draw on the whole window including decorations, construct a wxWindowDC object (Windows only).
</p>
End Rem
Type wxClientDC Extends wxWindowDC

	Rem
	bbdoc: Constructor.
	about: Pass the window on which you wish to paint.
	End Rem
	Method Create:wxClientDC(window:wxWindow)
		wxObjectPtr = bmx_wxclientdc_create(window.wxObjectPtr)
		Return Self
	End Method

	Method Delete()
		Free()
	End Method

	Method Free()
		If wxObjectPtr Then
			bmx_wxclientdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: This type holds information about a tooltip associated with a window (see wxWindow::SetToolTip).
about: The two functions, wxToolTip::Enable and wxToolTip::SetDelay can be used to globally alter tooltips
behaviour.
End Rem
Type wxToolTip Extends wxObject

	Function _create:wxToolTip(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxToolTip = New wxToolTip
		
			this.wxObjectPtr = wxObjectPtr
		
			Return this
		End If
		
		Return Null
	End Function

	Rem
	bbdoc: Enable or disable tooltips globally.
	about: May not be supported on all platforms (eg. wxCocoa).
	End Rem
	Function Enable(flag:Int)
		bmx_wxtooltip_enable(flag)
	End Function
	
	Rem
	bbdoc: Set the delay after which the tooltip appears.
	about: May not be supported on all platforms (eg. wxCocoa).
	End Rem
	Function SetDelay(msecs:Int)
		bmx_wxtooltip_setdelay(msecs)
	End Function
	
	Rem
	bbdoc: Set the tooltip text.
	End Rem
	Method SetTip(tip:String)
		bmx_wxtooltip_settip(wxObjectPtr, tip)
	End Method
	
	Rem
	bbdoc: Get the tooltip text.
	End Rem
	Method GetTip:String()
		Return bmx_wxtooltip_gettip(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the associated window.
	End Rem
	Method GetWindow:wxWindow()
		Return wxWindow._find(bmx_wxtooltip_getwindow(wxObjectPtr))
	End Method
	
End Type


Rem
bbdoc: A caret is a blinking cursor showing the position where the typed text will appear.
about: The text controls usually have a caret but wxCaret class also allows to use a caret in
other windows.
<p>
Currently, the caret appears as a rectangle of the given size. In the future, it will be possible
to specify a bitmap to be used for the caret shape.
</p>
<p>
A caret is always associated with a window and the current caret can be retrieved using wxWindow::GetCaret.
The same caret can't be reused in two different windows.
</p>
End Rem
Type wxCaret

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxCaret(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCaret = New wxCaret
		
			this.wxObjectPtr = wxObjectPtr
		
			Return this
		End If
		
		Return Null
	End Function
	
	Function CreateCaret:wxCaret()
	End Function
	
	Method Create:wxCaret()
	End Method

End Type


Type TWindowEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_CLOSE_WINDOW, ..
					wxEVT_END_SESSION, ..
					wxEVT_QUERY_END_SESSION
				Return wxCloseEvent.Create(wxEventPtr, evt)
			Case wxEVT_UPDATE_UI
				Return wxUpdateUIEvent.Create(wxEventPtr, evt)
			Case wxEVT_SET_FOCUS, ..
					wxEVT_KILL_FOCUS
				Return wxFocusEvent.Create(wxEventPtr, evt)
			Case wxEVT_COMMAND_TEXT_COPY, ..
					wxEVT_COMMAND_TEXT_CUT, ..
					wxEVT_COMMAND_TEXT_PASTE
				Return wxClipboardTextEvent.Create(wxEventPtr, evt)
			Case wxEVT_IDLE
				Return wxIdleEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_CLOSE_WINDOW, ..
					wxEVT_END_SESSION, ..
					wxEVT_QUERY_END_SESSION, ..
					wxEVT_UPDATE_UI, ..
					wxEVT_SET_FOCUS, ..
					wxEVT_KILL_FOCUS, ..
					wxEVT_IDLE, ..
					wxEVT_COMMAND_TEXT_COPY, ..
					wxEVT_COMMAND_TEXT_CUT, ..
					wxEVT_COMMAND_TEXT_PASTE
			Return bmx_eventtype_value(eventType)
		End Select
	End Method
		
End Type

New TWindowEventFactory

