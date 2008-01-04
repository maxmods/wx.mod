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
bbdoc: wxSashWindow
End Rem
Module wx.wxSashWindow

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
bbdoc: wxSashWindow allows any of its edges to have a sash which can be dragged to resize the window.
about: The actual content window will be created by the application as a child of wxSashWindow. The window
(or an ancestor) will be notified of a drag via a wxSashEvent notification.
End Rem
Type wxSashWindow Extends wxWindow

	Rem
	bbdoc: Constructs a sash window, which can be a child of a frame, dialog or any other non-control window.
	End Rem
	Function CreateSashWindow:wxSashWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, ..
			h:Int = -1, style:Int = wxCLIP_CHILDREN | wxSW_3D)
		Return New wxSashWindow.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSashWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, ..
			h:Int = -1, style:Int = wxCLIP_CHILDREN | wxSW_3D)
		wxObjectPtr = bmx_wxsashwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Returns true if a sash is visible on the given edge, false otherwise.
	End Rem
	Method GetSashVisible:Int(edge:Int)
		Return bmx_wxsashwindow_getsashvisible(wxObjectPtr, edge)
	End Method
	
	Rem
	bbdoc: Gets the maximum window size in the x direction.
	End Rem
	Method GetMaximumSizeX:Int()
		Return bmx_wxsashwindow_getmaximumsizex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the maximum window size in the y direction.
	End Rem
	Method GetMaximumSizeY:Int()
		Return bmx_wxsashwindow_getmaximumsizey(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the minimum window size in the x direction.
	End Rem
	Method GetMinimumSizeX:Int()
		Return bmx_wxsashwindow_getminimumsizex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the minimum window size in the y direction.
	End Rem
	Method GetMinimumSizeY:Int()
		Return bmx_wxsashwindow_getminimumsizey(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the maximum window size in the x direction.
	End Rem
	Method SetMaximumSizeX(size:Int)
		bmx_wxsashwindow_setmaximumsizex(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the maximum window size in the y direction.
	End Rem
	Method SetMaximumSizeY(size:Int)
		bmx_wxsashwindow_setmaximumsizey(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the minimum window size in the x direction.
	End Rem
	Method SetMinimumSizeX(size:Int)
		bmx_wxsashwindow_setminimumsizex(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the minimum window size in the y direction.
	End Rem
	Method SetMinimumSizeY(size:Int)
		bmx_wxsashwindow_setminimumsizey(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Call this method to make a sash visible or invisible on a particular edge.
	End Rem
	Method SetSashVisible(edge:Int, visible:Int)
		bmx_wxsashwindow_setsashvisible(wxObjectPtr, edge, visible)
	End Method
	
End Type

Rem
bbdoc: A sash event is sent when the sash of a wxSashWindow has been dragged by the user.
about: When a sash belonging to a sash window is dragged by the user, and then released, this event is sent
to the window, where it may be processed by an event table entry in a derived class, a plug-in event handler
or an ancestor class.
<p>
Note that the wxSashWindow doesn't change the window's size itself. It relies on the application's event
handler to do that. This is because the application may have to handle other consequences of the resize,
or it may wish to veto it altogether. The event handler should look at the drag rectangle: see
wxSashEvent::GetDragRect to see what the new size of the window would be if the resize were to be applied.
It should also call wxSashEvent::GetDragStatus to see whether the drag was OK or out of the current
allowed range.
</p>
End Rem
Type wxSashEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSashEvent = New wxSashEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the dragged edge.
	returns: One of wxSASH_TOP, wxSASH_RIGHT, wxSASH_BOTTOM, wxSASH_LEFT.
	End Rem
	Method GetEdge:Int()
		Return bmx_wxsashevent_getedge(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the rectangle representing the new size the window would be if the resize was applied.
	about: It is up to the application to set the window size if required.
	End Rem
	Method GetDragRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxsashevent_getdragrect(wxEventPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the rectangle representing the new size the window would be if the resize was applied.
	about: It is up to the application to set the window size if required.
	End Rem
	Method GetDragRectRect:wxRect()
		Return wxRect._create(bmx_wxsashevent_getdragrectrect(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Returns the status of the sash: one of wxSASH_STATUS_OK, wxSASH_STATUS_OUT_OF_RANGE.
	about: If the drag caused the notional bounding box of the window to flip over, for example, the drag
	will be out of rage.
	End Rem
	Method GetDragStatus:Int()
		Return bmx_wxsashevent_getdragstatus(wxEventPtr)
	End Method

End Type

Type TSashEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_SASH_DRAGGED Then
			Return wxSashEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_SASH_DRAGGED Then
			Return bmx_wxsashwindow_geteventtype(eventType)
		End If
	End Method
		
End Type

New TSashEventFactory
