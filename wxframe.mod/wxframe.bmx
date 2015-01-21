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

Rem
bbdoc: wxFrame
End Rem
Module wx.wxFrame

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
bbdoc: A frame is a window whose size and position can (usually) be changed by the user.
about: It usually has thick borders and a title bar, and can optionally contain a menu bar, toolbar and
status bar. A frame can contain any window that is not a frame or dialog.
<p>
A frame that has a status bar and toolbar created via the CreateStatusBar/CreateToolBar functions manages
these windows, and adjusts the value returned by GetClientSize to reflect the remaining size available
to application windows.
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxDEFAULT_FRAME_STYLE </td><td>Defined as wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxRESIZE_BORDER | wxSYSTEM_MENU | wxCAPTION | wxCLOSE_BOX | wxCLIP_CHILDREN.</td></tr>
<tr><td>wxICONIZE </td><td>Display the frame iconized (minimized). Windows only. </td></tr>
<tr><td>wxCAPTION </td><td>Puts a caption on the frame.</td></tr>
<tr><td>wxMINIMIZE </td><td>Identical to wxICONIZE. Windows only. </td></tr>
<tr><td>wxMINIMIZE_BOX </td><td>Displays a minimize box on the frame. </td></tr>
<tr><td>wxMAXIMIZE </td><td>Displays the frame maximized. Windows only. </td></tr>
<tr><td>wxMAXIMIZE_BOX </td><td>Displays a maximize box on the frame. </td></tr>
<tr><td>wxCLOSE_BOX </td><td>Displays a close box on the frame. </td></tr>
<tr><td>wxSTAY_ON_TOP </td><td>Stay on top of all other windows, see also wxFRAME_FLOAT_ON_PARENT. </td></tr>
<tr><td>wxSYSTEM_MENU </td><td>Displays a system menu. </td></tr>
<tr><td>wxRESIZE_BORDER </td><td>Displays a resizeable border around the window. </td></tr>
<tr><td>wxFRAME_TOOL_WINDOW </td><td>Causes a frame with a small titlebar to be created; the frame does not appear in the taskbar under Windows or GTK+. </td></tr>
<tr><td>wxFRAME_NO_TASKBAR </td><td>Creates an otherwise normal frame but it does not appear in the taskbar under Windows or GTK+ (note that
it will minimize to the desktop window under Windows which may seem strange to the users and thus it might be better to use this style
only without wxMINIMIZE_BOX style). In wxGTK, the flag is respected only if GTK+ is at least version 2.2 and the window manager
supports _NET_WM_STATE_SKIP_TASKBAR hint. Has no effect under other platforms. </td></tr>
<tr><td>wxFRAME_FLOAT_ON_PARENT </td><td>The frame will always be on top of its parent (unlike wxSTAY_ON_TOP). A frame created with this style must have a non-NULL parent. </td></tr>
<tr><td>wxFRAME_EX_CONTEXTHELP </td><td>Under Windows, puts a query button on the caption. When pressed, Windows will go into a
context-sensitive help mode and wxWidgets will send a wxEVT_HELP event if the user clicked on an application window. Note that this is an
<i>extra</i> style and must be set by calling <tt>SetExtraStyle</tt>. You cannot use this style
together with wxMAXIMIZE_BOX or wxMINIMIZE_BOX, so you should use wxDEFAULT_FRAME_STYLE &amp; ~ (wxMINIMIZE_BOX | wxMAXIMIZE_BOX) for the
frames having this style (the dialogs don't have a minimize or a maximize box by default) </td></tr>
<tr><td>wxFRAME_SHAPED </td><td>Windows with this style are allowed to have their shape changed with the SetShape method. </td></tr>
<tr><td>wxFRAME_EX_METAL </td><td>On Mac OS X, frames with this style will be shown with a metallic look. This is an <i>extra</i> style. </td></tr>
</table>
</p>
<p>
The default frame style is for normal, resizeable frames. To create a frame which can not be resized by user,
you may use the following combination of styles:
<tt>wxDEFAULT_FRAME_STYLE &amp; ~ (wxRESIZE_BORDER | wxRESIZE_BOX | wxMAXIMIZE_BOX)</tt>.
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_SIZE</tt> - If the frame has exactly one child window, not counting the status and toolbar, this child is resized to
take the entire frame client area. If two or more windows are present, they should be laid out explicitly either by manually
handling wxEVT_SIZE or using sizers </li>
<li><tt>wxEVT_MENU_HIGHLIGHT</tt> - The default implementation displays the help string associated with the selected item in the first pane of the status bar, if there is one. </li>
</ul>
</p>
<p>
An application should normally define a #wxCloseEvent handler for the frame to respond to system close events,
for example so that related data and subwindows can be cleaned up.
</p>
End Rem
Type wxFrame Extends wxTopLevelWindow

	Field menuBar:wxMenuBar
	'Field statusBar:wxStatusBar
	
	Function _create:wxFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFrame = New wxFrame
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _find:wxFrame(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local frame:wxFrame = wxFrame(wxfind(wxObjectPtr))
			If Not frame Then
				Return wxFrame._create(wxObjectPtr)
			End If
			Return frame
		End If
	End Function
	
	Function _xrcNew:wxFrame(wxObjectPtr:Byte Ptr)
		Return wxFrame._create(wxObjectPtr)
	End Function
	
	Rem
	bbdoc: TODO
	End Rem
	Function CreateFrame:wxFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
	
		Return New wxFrame.Create(parent, id, title, x, y, w, h, style)
		
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
	
		If parent Then
			wxObjectPtr = bmx_wxframe_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxframe_create(Self, Null, id, title, x, y, w, h, style)
		End If
		
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Called during frame creation.
	about: Override this method to provide your own initialization, like adding menus, controls etc.
	End Rem
	Method OnInit:Int()
	End Method
	
	Rem
	bbdoc: Tells the frame to show the given menu bar.
	about: If the frame is destroyed, the menu bar and its menus will be destroyed also, so do not delete the
	menu bar explicitly (except by resetting the frame's menu bar to another frame or NULL).
	<p>
	Under Windows, a size event is generated, so be sure to initialize data members properly before calling
	SetMenuBar.
	</p>
	<p>
	Note that on some platforms, it is not possible to call this function twice for the same frame object.
	</p>
	End Rem
	Method SetMenuBar(menuBar:wxMenuBar)

		If Not Self.menuBar Then
			Self.menuBar = menuBar
			bmx_wxframe_setmenubar(wxObjectPtr, menuBar.wxObjectPtr)
		End If
		
	End Method
	
	Rem
	bbdoc: Creates a status bar at the bottom of the frame.
	End Rem
	Method CreateStatusBar:wxStatusBar(number:Int = 1, style:Int = 0, id:Int = -1)
		Local sb:wxStatusBar = wxStatusBar._create(bmx_wxframe_createstatusbar(wxObjectPtr, number, style, id))
		sb.injectSelf()
		Return sb
	End Method
	
	Rem
	bbdoc: Sets the status bar text and redraws the status bar.
	about: 
	End Rem
	Method SetStatusText(text:String, number:Int = 0)
		bmx_wxframe_setstatustext(wxObjectPtr, text, number)
	End Method
	
	Rem
	bbdoc: Returns the menubar currently associated with the frame (if any).
	End Rem
	Method GetMenuBar:wxMenuBar()
		Return wxMenuBar(wxfind(bmx_wxframe_getmenubar(wxObjectPtr)))
	End Method
	
	Rem
	bbdoc: Associates a status bar with the frame.
	End Rem
	Method SetStatusBar(statusbar:wxStatusBar)
		If statusbar Then
			bmx_wxframe_setstatusbar(wxObjectPtr, statusbar.wxObjectPtr)
		Else
			bmx_wxframe_setstatusbar(wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Returns the status bar currently associated with the frame (if any).
	End Rem
	Method GetStatusBar:wxStatusBar()
		Local sbPtr:Byte Ptr = bmx_wxframe_getstatusbar(wxObjectPtr)
		If sbptr Then
			Local sb:wxStatusBar = wxStatusBar(wxfind(sbPtr))
			If Not sb Then
				sb = wxStatusBar._create(sbPtr)
			End If
			Return sb
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PositionStatusBar()
		bmx_wxframe_positionstatusbar(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the status bar pane used to display menu and toolbar help.
	about: Using -1 disables help display.
	End Rem
	Method SetStatusBarPane(n:Int)
		bmx_wxframe_setstatusbarpane(wxObjectPtr, n)
	End Method
	
	Rem
	bbdoc: Creates a toolbar at the top or left of the frame
	End Rem
	Method CreateToolBar:wxToolBar(style:Int = wxNO_BORDER | wxTB_HORIZONTAL, id:Int = -1)
		Local tb:wxToolBar = wxToolBar._create(bmx_wxframe_createtoolbar(wxObjectPtr, style, id))
		tb.injectSelf()
		Return tb
	End Method
	
	Rem
	bbdoc: Returns the toolbar currently associated with the frame (if any).
	End Rem
	Method GetToolBar:wxToolBar()
		Local tbPtr:Byte Ptr = bmx_wxframe_gettoolbar(wxObjectPtr)
		If tbptr Then
			Local tb:wxToolBar = wxToolBar(wxfind(tbPtr))
			If Not tb Then
				tb = wxToolBar._create(tbPtr)
			End If
			Return tb
		End If
	End Method
	
	Rem
	bbdoc: Associates a toolbar with the frame.
	End Rem
	Method SetToolBar(toolbar:wxToolBar)
		bmx_wxframe_settoolbar(wxObjectPtr, toolbar.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Simulate a menu command.
	End Rem
	Method ProcessCommand(id:Int)
		bmx_wxframe_processcommand(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: This method sends a dummy size event to the frame forcing it to reevaluate its children positions.
	about: It is sometimes useful to call this function after adding or deleting a children after the frame
	creation or if a child size changes.
	<p>
	Note that if the frame is using either sizers or constraints for the children layout, it is enough to call
	Layout() directly and this function should not be used in this case.
	</p>
	End Rem
	Method SendSizeEvent()
		bmx_wxframe_sendsizeevent(wxObjectPtr)
	End Method
	
End Type

Type TFrameResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxframe_addresourcehandler()
	End Method
		
End Type

New TFrameResourceFactory
