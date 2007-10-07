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

Rem
bbdoc: wxSplitterWindow
End Rem
Module wx.wxSplitterWindow

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
bbdoc: This type manages up to two subwindows.
about: The current view can be split into two programmatically (perhaps from a menu command), and unsplit
either programmatically or via the wxSplitterWindow user interface.
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxSP_3D</td><td>Draws a 3D effect border and sash. </td></tr>
<tr><td>wxSP_3DSASH</td><td>Draws a 3D effect sash. </td></tr>
<tr><td>wxSP_3DBORDER</td><td>Synonym for wxSP_BORDER. </td></tr>
<tr><td>wxSP_BORDER</td><td>Draws a standard border.</td></tr>
<tr><td>wxSP_NOBORDER</td><td>No border (default). </td></tr>
<tr><td>wxSP_NO_XP_THEME</td><td>Under Windows XP, switches off the attempt to draw the splitter
using Windows XP theming, so the borders and sash will take on the pre-XP look. </td></tr>
<tr><td>wxSP_PERMIT_UNSPLIT</td><td>Always allow to unsplit, even with the minimum pane size other than zero. </td></tr>
<tr><td>wxSP_LIVE_UPDATE</td><td>Don't draw XOR line but resize the child windows immediately.</td></tr>
</table>
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING</tt> - The sash position is in the process of being changed.
May be used to modify the position of the tracking bar to properly reflect the position that would be set
if the drag were to be completed at this point.</li>
<li><tt>wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED</tt> - The sash position was changed. May be used to modify
the sash position before it is set, or to prevent the change from taking place.</li>
<li><tt>wxEVT_COMMAND_SPLITTER_UNSPLIT</tt> - The splitter has been just unsplit.</li>
<li><tt>wxEVT_COMMAND_SPLITTER_DOUBLECLICKED</tt> - The sash was double clicked. The default behaviour is to
unsplit the window when this happens (unless the minimum pane size has been set to a value greater than zero).</li>
</ul>
</p>
End Rem
Type wxSplitterWindow Extends wxWindow

	Rem
	bbdoc:Constructor for creating the window.
	about: After using the constructor, you must create either one or two subwindows with the splitter
	window as parent, and then call one of wxSplitterWindow::Initialize, wxSplitterWindow::SplitVertically
	and wxSplitterWindow::SplitHorizontally in order to set the pane(s).
	<p>
	You can create two windows, with one hidden when not being shown; or you can create and delete the second
	pane on demand.
	</p>
	End Rem
	Function CreateSplitterWindow:wxSplitterWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSP_3D)
		Return New wxSplitterWindow.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. See wxSplitterWindow::wxSplitterWindow for details.
	End Rem
	Method Create:wxSplitterWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSP_3D)
		
		wxObjectPtr = bmx_wxsplitterwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the current minimum pane size (defaults to zero).
	End Rem
	Method GetMinimumPaneSize:Int()
		Return bmx_wxsplitterwindow_getminimumpanesize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current sash gravity.
	End Rem
	Method GetSashGravity:Double()
		Return bmx_wxsplitterwindow_getsashgravity(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current sash position.
	End Rem
	Method GetSashPosition:Int()
		Return bmx_wxsplitterwindow_getsashposition(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the split mode.
	End Rem
	Method GetSplitMode:Int()
		Return bmx_wxsplitterwindow_getsplitmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the left/top or only pane.
	End Rem
	Method GetWindow1:wxWindow()
		Local wPtr:Byte Ptr = bmx_wxsplitterwindow_getwindow1(wxObjectPtr)
		Local win:wxWindow = wxWindow(wxfind(wPtr))
		If Not win Then
			win = wxWindow._create(wPtr)
		End If
		Return win
	End Method
	
	Rem
	bbdoc: Returns the right/bottom pane.
	End Rem
	Method GetWindow2:wxWindow()
		Local wPtr:Byte Ptr = bmx_wxsplitterwindow_getwindow2(wxObjectPtr)
		Local win:wxWindow = wxWindow(wxfind(wPtr))
		If Not win Then
			win = wxWindow._create(wPtr)
		End If
		Return win
	End Method
	
	Rem
	bbdoc: Initializes the splitter window to have one pane.
	about: The child window is shown if it is currently hidden.
	<p>
	This should be called if you wish to initially view only a single pane in the splitter window.
	</p>
	End Rem
	Method Initialize(window:wxWindow)
		bmx_wxsplitterwindow_initialize(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the window is split, False otherwise.
	End Rem
	Method IsSplit:Int()
		Return bmx_wxsplitterwindow_issplit(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method replaces one of the windows managed by the wxSplitterWindow with another one.
	about: It is in general better to use it instead of calling Unsplit() and then resplitting the window
	back because it will provoke much less flicker (if any). It is valid to call this function whether
	the splitter has two windows or only one.
	<p>
	Both parameters should be non-NULL and winOld must specify one of the windows managed by the splitter.
	If the parameters are incorrect or the window couldn't be replaced, false is returned. Otherwise the
	function will return true, but please notice that it will not delete the replaced window and you may wish
	to do it yourself.
	</p>
	End Rem
	Method ReplaceWindow:Int(winOld:wxWindow, winNew:wxWindow)
		Return bmx_wxsplitterwindow_replacewindow(wxObjectPtr, winOld.wxObjectPtr, winNew.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the sash gravity.
	about: Gravity is real factor which controls position of sash while resizing wxSplitterWindow.
	Gravity tells wxSplitterWindow how much will left/top window grow while resizing.
	<p>
	Example values: 
	<ul>
	<li>0.0 - only the bottom/right window is automatically resized</li>
	<li>0.5 - both windows grow by equal size </li>
	<li>1.0 - only left/top window grows </li>
	</ul>
	</p>
	<p>
	Gravity should be a real value between 0.0 and 1.0.
	</p>
	<p>
	Default value of sash gravity is 0.0.
	</p>
	End Rem
	Method SetSashGravity(gravity:Double)
		bmx_wxsplitterwindow_setsashgravity(wxObjectPtr, gravity)
	End Method
	
	Rem
	bbdoc: Sets the sash position.
	about: Does not currently check for an out-of-range value.
	End Rem
	Method SetSashPosition(position:Int, redraw:Int = True)
		bmx_wxsplitterwindow_setsashposition(wxObjectPtr, position, redraw)
	End Method
	
	Rem
	bbdoc: Sets the sash size.
	about: Normally, the sash size is determined according to the metrics of each platform, but the
	application can override this, for example to show a thin sash that the user is not expected to
	drag. If size is more -1, the custom sash size will be used.
	End Rem
	Method SetSashSize(size:Int)
		bmx_wxsplitterwindow_setsashsize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the minimum pane size.
	about: The default minimum pane size is zero, which means that either pane can be reduced to zero
	by dragging the sash, thus removing one of the panes. To prevent this behaviour (and veto out-of-range
	sash dragging), set a minimum size, for example 20 pixels. If the wxSP_PERMIT_UNSPLIT style is
	used when a splitter window is created, the window may be unsplit even if minimum size is non-zero.
	End Rem
	Method SetMinimumPaneSize(paneSize:Int)
		bmx_wxsplitterwindow_setminimumpanesize(wxObjectPtr, paneSize)
	End Method
	
	Rem
	bbdoc: Sets the split mode.
	about: Only sets the internal variable; does not update the display.
	End Rem
	Method SetSplitMode(mode:Int)
		bmx_wxsplitterwindow_setsplitmode(wxObjectPtr, mode)
	End Method
	
	Rem
	bbdoc: Initializes the top and bottom panes of the splitter window.
	about: The child windows are shown if they are currently hidden.
	End Rem
	Method SplitHorizontally:Int(window1:wxWindow, window2:wxWindow, sashPosition:Int = 0)
		Return bmx_wxsplitterwindow_splithorizontally(wxObjectPtr, window1.wxObjectPtr, window2.wxObjectPtr, sashPosition)
	End Method
	
	Rem
	bbdoc: Initializes the left and right panes of the splitter window.
	about: The child windows are shown if they are currently hidden.
	End Rem
	Method SplitVertically:Int(window1:wxWindow, window2:wxWindow, sashPosition:Int = 0)
		Return bmx_wxsplitterwindow_splitvertically(wxObjectPtr, window1.wxObjectPtr, window2.wxObjectPtr, sashPosition)
	End Method
	
	Rem
	bbdoc: Unsplits the window.
	End Rem
	Method Unsplit:Int(toRemove:wxWindow = Null)
		If toRemove Then
			Return bmx_wxsplitterwindow_unsplit(wxObjectPtr, toRemove.wxObjectPtr)
		Else
			Return bmx_wxsplitterwindow_unsplit(wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Causes any pending sizing of the sash and child panes to take place immediately.
	about: Such resizing normally takes place in idle time, in order to wait for layout to be completed.
	However, this can cause unacceptable flicker as the panes are resized after the window has been shown.
	To work around this, you can perform window layout (for example by sending a size event to the parent
	window), and then call this function, before showing the top-level window.
	End Rem
	Method UpdateSize()
		bmx_wxsplitterwindow_updatesize(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: This type represents the events generated by a splitter control.
about: Also there is only one event type, the data associated to the different events is not the same
and so not all accessor functions may be called for each event. The documentation mentions the kind of
event(s) for which the given accessor function makes sense: calling it for other types of events will
result in assert failure (in debug mode) and will return meaningless results.
End Rem
Type wxSplitterEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSplitterEvent = New wxSplitterEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the new sash position.
	about: May only be called while processing wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING and
	wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED events.
	End Rem
	Method GetSashPosition:Int()
		Return bmx_wxsplitterevent_getsashposition(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the x coordinate of the double-click point.
	about: May only be called while processing wxEVT_COMMAND_SPLITTER_DOUBLECLICKED events.
	End Rem
	Method GetX:Int()
		Return bmx_wxsplitterevent_getx(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the y coordinate of the double-click point.
	about: May only be called while processing wxEVT_COMMAND_SPLITTER_DOUBLECLICKED events.
	End Rem
	Method GetY:Int()
		Return bmx_wxsplitterevent_gety(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the window being removed when a splitter window is unsplit.
	about: May only be called while processing wxEVT_COMMAND_SPLITTER_UNSPLIT events.
	End Rem
	Method GetWindowBeingRemoved:wxWindow()
		Local wPtr:Byte Ptr = bmx_wxsplitterevent_getwindowbeingremoved(wxEventPtr)
		Local win:wxWindow = wxWindow(wxfind(wPtr))
		If Not win Then
			win = wxWindow._create(wPtr)
		End If
		Return win
	End Method
	
	Rem
	bbdoc: In the case of wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED events, sets the new sash position. In the case of wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING events, sets the new tracking bar position so visual feedback during dragging will represent that change that will actually take place.
	about: Set to -1 from the event handler code to prevent repositioning.
	<p>
	May only be called while processing wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING and
	wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED events.
	</p>
	End Rem
	Method SetSashPosition(pos:Int)
		bmx_wxsplitterevent_setsashposition(wxEventPtr, pos)
	End Method
	
End Type

Type TSplitterEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, ..
					wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, ..
					wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, ..
					wxEVT_COMMAND_SPLITTER_UNSPLIT
				Return wxSplitterEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, ..
					wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, ..
					wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, ..
					wxEVT_COMMAND_SPLITTER_UNSPLIT
				Return bmx_wxsplitterwindow_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TSplitterEventFactory


