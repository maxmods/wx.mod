' Copyright (c) 2007 Bruce A Henderson
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

Import "events.bmx"
Import "fonts.bmx"
'Import "common.bmx"



Rem
bbdoc: TODO
End Rem
Type wxApp Abstract

	Global app:wxApp
	
	Method New()
		app = Self
	End Method

	Rem
	bbdoc: TODO
	End Rem
	Method OnInit:Int() Abstract

	Function _OnInit:Int()
		Return app.OnInit()
	End Function

	Rem
	bbdoc: TODO
	End Rem
	Method Run:Int()
		Return bmx_app_wxentry()
	End Method
	
	Method SetTopWindow(window:wxWindow)
		bmx_wxapp_settopwindow(window.wxObjectPtr)
	End Method
	
	
	Method SetAppName(name:String)
		bmx_wxapp_setappname(name)
	End Method
	
	Rem
	bbdoc: Yields control to pending messages in the windowing system.
	about: This can be useful, for example, when a time-consuming process writes to a text window.
	Without an occasional yield, the text window will not be updated properly, and on systems with
	cooperative multitasking, such as Windows 3.1 other processes will not respond.
	<p>
	Caution should be exercised, however, since yielding may allow the user to perform actions which
	are not compatible with the current task. Disabling menu items or whole menus during processing
	can avoid unwanted reentrance of code: see ::wxSafeYield for a better function.
	</p>
	<p>
	Note that Yield() will not flush the message logs. This is intentional as calling Yield() is
	usually done to quickly update the screen and popping up a message box dialog may be undesirable.
	If you do wish to flush the log messages immediately (otherwise it will be done during the next
	idle loop iteration), call wxLog::FlushActive.
	</p>
	<p>
	Calling Yield() recursively is normally an error and an assert failure is raised in debug build
	if such situation is detected. However if the onlyIfNeeded parameter is true, the method will just
	silently return false instead.
	</p>
	End Rem
	Method Yield:Int(onlyIfNeeded:Int = False)
		Return bmx_wxapp_yield(onlyIfNeeded)
	End Method
	
End Type


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

	Method OnInit()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CaptureMouse()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Center(direction:Int = wxBOTH)
		Centre(direction)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CenterOnParent(direction:Int = wxBOTH)
		CentreOnParent(direction)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CenterOnScreen(direction:Int = wxBOTH)
		CentreOnScreen(direction)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Centre(direction:Int = wxBOTH)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CentreOnParent(direction:Int = wxBOTH)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CentreOnScreen(direction:Int = wxBOTH)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearBackground()
		bmx_wxwindow_clearbackground(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
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
	
	Method ConvertDialogToPixel(dx:Int, dy:Int, px:Int Var, py:Int Var)
	End Method
	
	Method ConvertPixelsToDialog(dx:Int, dy:Int, px:Int Var, py:Int Var)
	End Method
	
	Rem
	bbdoc: Destroys the window safely.
	about: Use this method instead of the delete operator, since different window classes can be
	destroyed differently. Frames and dialogs are not destroyed immediately when this function
	is called -- they are added to a list of windows to be deleted on idle time, when all the window's
	events have been processed. This prevents problems with events being sent to non-existent windows.
	End Rem
	Method Destroy:Int()
	End Method
	
	Rem
	bbdoc: Destroys all children of a window.
	about: Called automatically by the destructor.
	End Rem
	Method DestroyChildren()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Disable:Int()
	End Method
	
	'Method DoGetBestSize(w:Int Var, h:Int Var)
	'End Method
	
	'Method DoUpdateWindowUI(event:wxEvent)
	'End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DragAcceptFiles(accept:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Enable:Int(_enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FindFocus:wxWindow()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function FindWindowById:wxWindow(id:Int, parent:wxWindow = Null)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function FindWindowByName:wxWindow(name:String, parent:wxWindow = Null)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function FindWindowByLabel:wxWindow(label:String, parent:wxWindow = Null)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Fit()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FitInside()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Freeze()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAcceleratorTable:wxAcceleratorTable()
	End Method
	
	'Method GetAccessible()
	'End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAdjustedBestSize(w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBackgroundColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBackgroundStyle:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEffectiveMinSize(w:Int Var, h:Int Var)
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
	
	Function GetCapture:wxWindow()
	End Function
	
	'Method GetCaret()
	'End Method
	
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
	
	'Method GetChildren()
	'End Method

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
	End Method
	
	Rem
	bbdoc: not yet implemented
	End Rem
	Method GetCursor()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultAttributes:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDropTarget()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetExtraStyle:Int()
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
		Local win:Byte Ptr = bmx_wxwindow_getgrandparent(wxObjectPtr)
		If win Then
			Local window:wxWindow = wxWindow(wxfind(win))
			If Not window Then
				Return _create(win)
			End If
			Return window
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetHandle:Byte Ptr()
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
		Local win:Byte Ptr = bmx_wxwindow_getparent(wxObjectPtr)
		If win Then
			Local window:wxWindow = wxWindow(wxfind(win))
			If Not window Then
				Return _create(win)
			End If
			Return window
		End If
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
		Return wxSizer._create(bmx_wxwindow_getsizer(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTextExtent(text:String, x:Int Var, y:Int Var, descent:Int Var, ..
			externalLeading:Int Var, font:wxFont = Null, use16:Int = False)
		
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetToolTip:wxToolTip()
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
	bbdoc: 
	End Rem
	Method GetWindowVariant:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasCapture:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasFlag:Int(flag:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasMultiplePages:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasScrollbar:Int(orient:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasTransparentBackground:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Hide:Int()
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
	bbdoc: Call this method to prepare the device context for drawing
	End Rem
	Method PrepareDC(dc:_wxDC)
		bmx_wxwindow_preparedc(wxObjectPtr, dc.wxObjectPtr)
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


	Method injectSelf()
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
	bbdoc: 
	End Rem
	Method SetBackgroundStyle(style:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetInitialSize(w:Int = -1, h:Int = -1)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCaret()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetClientSize(width:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetConstraints()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetContainingSizer(sizer:wxSizer)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCursor()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDropTarget()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetInitialBestSize(w:Int, h:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetExtraStyle(style:Int)
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
	bbdoc: 
	End Rem
	Method SetMaxSize(width:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinSize(width:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetName(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOwnBackgroundColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOwnFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOwnForegroundColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPalette()
	End Method
	
	Rem
	bbdoc: Sets the scrollbar properties of a built-in scrollbar.
	End Rem
	Method SetScrollbar(orientation:Int, position:Int, thumbsize:Int, range:Int, refresh:Int = True)
		bmx_wxwindow_setscrollbar(wxObjectPtr, orientation, position, thumbsize, range, refresh)
	End Method
	
	Rem
	bbdoc: Sets the position of one of the built-in scrollbars.
	End Rem
	Method SetScrollPos(orientation:Int, pos:Int, refresh:Int = True)
		bmx_wxwindow_setscrollpos(wxObjectPtr, orientation, pos, refresh)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDimensions(x:Int, y:Int, width:Int, height:Int, sizeFlags:Int = wxSIZE_AUTO)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSize(width:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPosition(x:Int, y:Int)
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
	bbdoc: 
	End Rem
	Method SetSizerAndFit(sizer:wxSizer, deleteOld:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetThemeEnabled(enable:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToolTip(tip:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValidator()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetVirtualSize(width:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetVirtualSizeHints(minW:Int = -1, minH:Int = -1, maxW:Int = -1, maxH:Int = -1)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetWindowStyle(style:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetWindowStyleFlag(style:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetWindowVariant(variant:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShouldInheritColours:Int()
	End Method
	
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
	bbdoc: 
	End Rem
	Method Thaw()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToggleWindowStyle:Int(flag:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TransferDataFromWindow:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TransferDataToWindow:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method UnregisterHotKey:Int(hotKeyId:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Update()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method UpdateWindowUI(flags:Int = wxUPDATE_UI_NONE)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Validate:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WarpPointer(x:Int, y:Int)
	End Method	
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxwindow_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: TODO
End Rem
Type wxMenu Extends wxEvtHandler

'	Field wxMenuPtr:Byte Ptr

	' creates a "soft link" to a wxMenu*
	Function _create:wxMenu(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMenu = New wxMenu
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a #wxMenu object.
	about: TODO
	End Rem
	Function CreateMenu:wxMenu(title:String = "", style:Int = 0)
		Return New wxMenu.Create(title, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMenu(title:String = "", style:Int = 0)
		wxObjectPtr = bmx_wxmenu_create(Self, title, style)
		Return Self
	End Method

	Rem
	bbdoc: Adds a string item to the end of the menu.
	about: @kind may be wxITEM_SEPARATOR, wxITEM_NORMAL, wxITEM_CHECK, or wxITEM_RADIO
	TODO
	End Rem
	Method Append(id:Int, item:String = "", helpString:String = "", kind:Int = wxITEM_NORMAL)
		bmx_wxmenu_append(wxObjectPtr, id, item, helpString, kind)
	End Method
	
	Rem
	bbdoc: 
	about: TODO
	End Rem
	Method AppendMenu(id:Int, item:String = "", subMenu:wxMenu, helpString:String = "")
		bmx_wxmenu_appendmenu(wxObjectPtr, id, item, subMenu.wxObjectPtr, helpString)
	End Method

	Rem
	bbdoc: Adds a checkable item to the end of the menu.
	End Rem
	Method AppendCheckItem(id:Int, item:String = "", helpString:String = "")
		bmx_wxmenu_appendcheckitem(wxObjectPtr, id, item, helpString)
	End Method

	Rem
	bbdoc: Adds a radio item to the end of the menu.
	about: All consequent radio items form a group and when an item in the group is checked, all the others are
	automatically unchecked.
	End Rem
	Method AppendRadioItem(id:Int, item:String = "", helpString:String = "")
		bmx_wxmenu_appendradioitem(wxObjectPtr, id, item, helpString)
	End Method
	
	Rem
	bbdoc: Inserts a break in a menu, causing the next appended item to appear in a new column.
	End Rem
	Method Break()
		bmx_wxmenu_break(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method SetTitle(title:String)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method GetTitle:String()
	End Method
	
	Rem
	bbdoc: Checks or unchecks the menu item.
	End Rem
	Method Check(id:Int, value:Int)
		
	End Method
	
	Rem
	bbdoc: Determines whether a menu item is checked.
	returns: True if the menu item is checked, False otherwise.
	about: TODO
	End Rem
	Method IsChecked:Int(id:Int)
	
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method Enable(id:Int, value:Int)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method IsEnabled:Int(id:Int)
	End Method
	
	Rem
	bbdoc: Adds a separator to the end of the menu.
	End Rem
	Method AppendSeparator()
		bmx_wxmenu_appendseparator(wxObjectPtr)
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
	
	Rem
	bbdoc: 
	End Rem
	Method Add:wxSizerItem(window:wxWindow, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_add(wxSizerPtr, window.wxObjectPtr, proportion, flag, border))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddSizer:wxSizerItem(sizer:wxSizer, proportion:Int = 0, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxsizer_addsizer(wxSizerPtr, sizer.wxSizerPtr, proportion, flag, border))
	End Method

	Rem
	bbdoc: 
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
	
End Type

Rem
bbdoc: 
End Rem
Type wxBoxSizer Extends wxSizer

	Rem
	bbdoc: Constructor for a wxBoxSizer.
	about: @orient may be either of wxVERTICAL or wxHORIZONTAL for creating either a column sizer
	or a row sizer.
	End Rem
	Function CreateBoxSizer:wxBoxSizer(orient:Int)
		Return New wxBoxSizer.Create(orient)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxBoxSizer(orient:Int)
		wxSizerPtr = bmx_wxboxsizer_create(Self, orient)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxStatixBoxSizer Extends wxBoxSizer

End Type

Rem
bbdoc: A grid sizer is a sizer which lays out its children in a two-dimensional table with all table fields having the same size, i.e. the width of each field is the width of the widest child, the height of each field is the height of the tallest child.
End Rem
Type wxGridSizer Extends wxSizer

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
	bbdoc: Constructor for a wxGridSizer.
	about: rows and cols determine the number of columns and rows in the sizer - if either of the
	parameters is zero, it will be calculated to form the total number of children in the sizer,
	thus making the sizer grow dynamically. vgap and hgap define extra space between all children.
	End Rem
	Method Create:wxFlexGridSizer(cols:Int, vgap:Int = 0, hgap:Int = 0)
		wxSizerPtr = bmx_wxflexgridsizer_create(Self, cols, vgap, hgap)
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
	bbdoc: 
	End Rem
	Method GetFlexibleDirection:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNonFlexibleGrowMode:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RemoveGrowableCol(idx:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RemoveGrowableRow(idx:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFlexibleDirection(direction:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetNonFlexibleGrowMode(mode:Int)
	End Method
		
End Type

Type wxToolTip
End Type


Rem
bbdoc: 

Type wxArrayString

	Field wxArrayStringPtr:Byte Ptr
	
	Function Create:wxArrayString()
		Local this:wxArrayString = New wxArrayString
		
		this.wxArrayStringPtr = bmx_wxarraystring_create()
		
		Return this
	End Function
	
	'Rem
	'bbdoc: 
	'End Rem
	Method Add:Int(txt:String, copies:Int = 1)
		Return bmx_wxarraystring_add(wxArrayStringPtr, txt, copies)
	End Method

	'Rem
	'bbdoc: Preallocates enough memory To store nCount items.
	'about: This Function May be used To improve array class performance before adding a known number
	'of items consecutively.
	'End Rem
	Method Alloc(count:Int)
		bmx_wxarraystring_alloc(wxArrayStringPtr, count)
	End Method
	
	
	Method Delete()
		If wxArrayStringPtr Then
			bmx_wxarraystring_delete(wxArrayStringPtr)
			wxArrayStringPtr = Null
		End If
	End Method
	
End Type
End Rem

Rem
bbdoc: A colour is an object representing a combination of Red, Green, and Blue (RGB) intensity values, and is used to determine drawing colours.
about: See the entry for wxColourDatabase for how a pointer to a predefined, named colour may be returned
instead of creating a new colour.
<p>
Valid RGB values are in the range 0 to 255.
</p>
<p>
You can retrieve the current system colour settings with wxSystemSettings.
</p>
End Rem
Type wxColour Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateColour:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		Return New wxColour.Create(r, g, b, a)
	End Function
	
	Rem
	bbdoc: Constructs a colour from red, green, blue and alpha values.
	End Rem
	Method Create:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		wxObjectPtr = bmx_wxcolour_create(r, g, b, a)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a colour using the given string.
	End Rem
	Method CreateNamedColour:wxColour(name:String)
		wxObjectPtr = bmx_wxcolour_createnamedcolour(name)
		Return Self
	End Method

	Function _create:wxColour(wxObjectPtr:Byte Ptr)
		Local this:wxColour = New wxColour
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Method Alpha:Int()
		Return bmx_wxcolour_alpha(wxObjectPtr)
	End Method
	
	Method Blue:Int()
		Return bmx_wxcolour_blue(wxObjectPtr)
	End Method
	
	Method GetAsString:String(flags:Int)
		Return bmx_wxcolour_getasstring(wxObjectPtr, flags)
	End Method
	
	Method Green:Int()
		Return bmx_wxcolour_green(wxObjectPtr)
	End Method
	
	Method IsOk:Int()
		Return bmx_wxcolour_isok(wxObjectPtr)
	End Method
	
	Method Red:Int()
		Return bmx_wxcolour_red(wxObjectPtr)
	End Method
	
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcolour_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: A brush is a drawing tool for filling in areas. It is used for painting the background of rectangles, ellipses, etc. It has a colour and a style.
End Rem
Type wxBrush Extends wxGDIObject

	Function _create:wxBrush(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBrush = New wxBrush
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a brush from a colour name and style.
	End Rem
	Method Create:wxBrush(name:String, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxbrush_create(name, style)
		Return Self
	End Method
	
	Method CreateFromColour:wxBrush(colour:wxColour, style:Int = wxSOLID)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxbrush_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPen Extends wxGDIObject

	Function _create:wxPen(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPen = New wxPen
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a pen from a colour name, pen width and style.
	End Rem
	Method Create:wxPen(name:String, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_create(name, width, style)
		Return Self
	End Method

	Rem
	bbdoc: Constructs a pen from a colour object, pen width and style.
	End Rem
	Method CreateFromColour:wxPen(colour:wxColour, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_createfromcolour(colour.wxObjectPtr, width, style)
		Return Self
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpen_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type




Type wxStreamBase

End Type

Type wxInputStream Extends wxStreamBase

	

End Type

' wraps an input stream...
Type TInputStreamHandler

	 

End Type

Type wxAcceleratorTable

End Type

Type wxRegion

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

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxUpdateUIEvent = New wxUpdateUIEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
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
	Method CanUpdate:Int(window:wxWindow)
	End Method
	
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
	End Method
	
	Rem
	bbdoc: Show or hide the UI element.
	End Rem
	Method Show(value:Int)
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be checked.
	End Rem
	Method GetChecked:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be enabled.
	End Rem
	Method GetEnabled:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the UI element should be shown.
	End Rem
	Method GetShown:Int()
	End Method
	
	Rem
	bbdoc: Returns the text that should be set for the UI element.
	End Rem
	Method GetText:String()
	End Method
	
	Rem
	bbdoc: Static function returning a value specifying how wxWidgets will send update events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function GetMode:Int()
	End Function
	
	Rem
	bbdoc: Returns the current interval between updates in milliseconds.
	about: -1 disables updates, 0 updates as frequently as possible.
	End Rem
	Function GetUpdateInterval:Int()
	End Function
	
	'Rem
	'bbdoc: 
	'End Rem
	'Function ResetUpdateTime()
	'End Function
	
	Rem
	bbdoc: Specify how wxWidgets will send update events: to all windows, or only to those which specify that they will process the events.
	End Rem
	Function SetMode(mode:Int)
	End Function
	
	Rem
	bbdoc: Sets the text for this UI element.
	End Rem
	Method SetText(text:String)
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
	End Function
	
End Type

Rem
bbdoc: An erase event is sent when a window's background needs to be repainted.
about: On some platforms, such as GTK+, this event is simulated (simply generated just before the paint event)
and may cause flicker. It is therefore recommended that you set the text background colour explicitly in order
to prevent flicker. The default background colour under GTK+ is grey.
<p>
You must call wxEraseEvent::GetDC and use the returned device context if it is non-NULL. If it is NULL,
create your own temporary wxClientDC object. 
</p>
End Rem
Type wxEraseEvent Extends wxEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxEraseEvent = New wxEraseEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function
	

	Rem
	bbdoc: Returns the device context associated with the erase event to draw on.
	End Rem
'	Method GetDC:_wxDC()
'	End Method
	
End Type

Rem
bbdoc: Returns the string containing the description of the current platform in a user-readable form.
about: For example, this function may return strings like Windows NT Version 4.0 or Linux 2.2.2 i386.
End Rem
Function wxGetOsDescription:String()
	Return bmx_wxgetosdescription()
End Function


Type TCoreEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		' TODO: determine the correct event, and return that type....
		Select evt.eventType
			Case wxEVT_COMMAND_CHOICE_SELECTED, ..
					wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_RADIOBOX_SELECTED, ..
					wxEVT_COMMAND_RADIOBUTTON_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER
				Return wxCommandEvent.create(wxEventPtr, evt)
			Case wxEVT_CLOSE_WINDOW, ..
					wxEVT_END_SESSION, ..
					wxEVT_QUERY_END_SESSION
				Return wxCloseEvent.create(wxEventPtr, evt)
			Case wxEVT_MOVE
				Return wxMoveEvent.create(wxEventPtr, evt)
			Case wxEVT_UPDATE_UI
				Return wxUpdateUIEvent.create(wxEventPtr, evt)
			Case wxEVT_PAINT
				Return wxPaintEvent.create(wxEventPtr, evt)
			Case wxEVT_SIZE
				Return wxSizeEvent.create(wxEventPtr, evt)
			Case wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE
				Return wxScrollWinEvent.create(wxEventPtr, evt)
			Case wxEVT_IDLE
				Return wxIdleEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method
	
	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_CHOICE_SELECTED, ..
					wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_RADIOBOX_SELECTED, ..
					wxEVT_COMMAND_RADIOBUTTON_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER, ..
					wxEVT_CLOSE_WINDOW, ..
					wxEVT_END_SESSION, ..
					wxEVT_QUERY_END_SESSION, ..
					wxEVT_MOVE, ..
					wxEVT_UPDATE_UI, ..
					wxEVT_PAINT, ..
					wxEVT_SIZE, ..
					wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE, ..
					wxEVT_IDLE
				Return bmx_eventtype_value(eventType)
		End Select
	End Method
	
End Type

New TCoreEventFactory
