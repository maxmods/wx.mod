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
bbdoc: wxCollapsiblePane
End Rem
Module wx.wxCollapsiblePane

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
bbdoc: A collapsible pane is a container with an embedded button-like control which can be used by the user to collapse or expand the pane's contents.
about: Once constructed you should use the GetPane function to access the pane and add your controls inside
it (i.e. use the GetPane's returned pointer as parent for the controls which must go in the pane, NOT the
wxCollapsiblePane itself!).
<p>
Note that because of its nature of control which can dynamically (and drastically) change its size at
run-time under user-input, when putting wxCollapsiblePane inside a wxSizer you should be careful to add it
with a proportion value of zero; this is because otherwise all other windows with non-null proportion
values would automatically get resized each time the user expands or collapse the pane window resulting
usually in a weird, flickering effect.
</p>
<p>
Usage sample:
<pre>
Local collpane:wxCollapsiblePane = new wxCollapsiblePane.Create(Self, wxID_ANY, "Details:") 

' add the pane with a zero proportion value to the 'sz' sizer which contains it
sz.Add(collpane, 0, wxGROW | wxALL, 5)

' now add a test label in the collapsible pane using a sizer to layout it: 
Local win:wxWindow = collpane.GetPane()
Local paneSz:wxSizer = new wxBoxSizer.Create(wxVERTICAL)
paneSz.Add(new wxStaticText.Create(win, wxID_ANY, "test!"), 1, wxGROW | wxALL, 2)
win.SetSizer(paneSz)
paneSz.SetSizeHints(win)
</pre>
</p>
End Rem
Type wxCollapsiblePane Extends wxControl

	Function _create:wxCollapsiblePane(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCollapsiblePane = New wxCollapsiblePane
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxCollapsiblePane(wxObjectPtr:Byte Ptr)
		Return wxCollapsiblePane._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructs a new wxCollapsiblePane.
	End Rem
	Function CreateCollapsiblePane:wxCollapsiblePane(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxCP_DEFAULT_STYLE)
		Return New wxCollapsiblePane.Create(parent, id, label, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Constructs a new wxCollapsiblePane.
	End Rem
	Method Create:wxCollapsiblePane(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxCP_DEFAULT_STYLE)
		wxObjectPtr = bmx_wxcollapsiblepane_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns True if the pane window is currently hidden.
	End Rem
	Method IsCollapsed:Int()
		Return bmx_wxcollapsiblepane_iscollapsed(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the pane window is currently shown.
	End Rem
	Method IsExpanded:Int()
		Return bmx_wxcollapsiblepane_isexpanded(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Collapses or expands the pane window.
	End Rem
	Method Collapse(value:Int = True)
		bmx_wxcollapsiblepane_collapse(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Same as Collapse(False).
	End Rem
	Method Expand()
		bmx_wxcollapsiblepane_expand(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the pane window.
	about: Add controls to the returned wxWindow to make them collapsible.
	End Rem
	Method GetPane:wxWindow()
		Return wxWindow._create(bmx_wxcollapsiblepane_getpane(wxObjectPtr))
	End Method

End Type

Rem
bbdoc: This event type is used for the events generated by wxCollapsiblePane.
End Rem
Type wxCollapsiblePaneEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxCollapsiblePaneEvent = New wxCollapsiblePaneEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if the pane has been collapsed.
	End Rem
	Method GetCollapsed:Int()
		Return bmx_wxcollapsiblepaneevent_getcollapsed(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets this as a collapsed pane event (if @collapsed is true) or as an expanded pane event (if @collapsed is false).
	End Rem
	Method SetCollapsed(collapsed:Int)
		bmx_wxcollapsiblepaneevent_setcollapsed(wxEventPtr, collapsed)
	End Method
	
End Type

Type TCollapsiblePaneEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_COLLPANE_CHANGED Then
			Return wxCollapsiblePaneEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_COLLPANE_CHANGED Then
			Return bmx_wxcollapsiblepane_geteventtype(eventType)
		End If
	End Method
		
End Type

New TCollapsiblePaneEventFactory

Type TCollapsiblePaneResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxcollapsiblepane_addresourcehandler()
	End Method
		
End Type

New TCollapsiblePaneResourceFactory
