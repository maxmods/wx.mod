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
bbdoc: wxHyperlinkCtrl
End Rem
Module wx.wxHyperlinkCtrl

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
bbdoc: This type shows a static text element which links to a URL.
about: Appearance and behaviour is completely customizable. In fact, when the user clicks on the hyperlink,
a wxHyperlinkEvent is sent but if that event is not handled (or it's skipped; see wxEvent::Skip), then a
call to wxLaunchDefaultBrowser is done with the hyperlink's URL.
<p>
Note that standard wxWindow functions like SetBackgroundColour, SetFont, SetCursor, SetLabel can be used
to customize appearance of the hyperlink.
</p>
End Rem
Type wxHyperlinkCtrl Extends wxControl

	Rem
	bbdoc: Constructor.
	End Rem
	Function CreateHyperLink:wxHyperlinkCtrl(parent:wxWindow, id:Int, label:String, url:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxHyperlinkCtrl.Create(parent, id, label, url, x, y, w, h, style)
	End Function

	Rem
	bbdoc: Creates the hyperlink control.
	End Rem
	Method Create:wxHyperlinkCtrl(parent:wxWindow, id:Int, label:String, url:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
	
		wxObjectPtr = bmx_wxhyperlinkctrl_create(Self, parent.wxObjectPtr, id, label, url, x, y, w, h, style)
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the colour used to print the label of the hyperlink when the mouse is over the control.
	End Rem
	Method GetHoverColour:wxColour()
		Return wxColour._create(bmx_wxhyperlinkctrl_gethovercolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the colour used to print the label of the hyperlink when the mouse is over the control.
	End Rem
	Method SetHoverColour(colour:wxColour)
		bmx_wxhyperlinkctrl_sethovercolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the colour used to print the label when the link has never been clicked before (i.e. the link has not been visited) and the mouse is not over the control.
	End Rem
	Method GetNormalColour:wxColour()
		Return wxColour._create(bmx_wxhyperlinkctrl_getnormalcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the colour used to print the label when the link has never been clicked before (i.e. the link has not been visited) and the mouse is not over the control.
	End Rem
	Method SetNormalColour(colour:wxColour)
		bmx_wxhyperlinkctrl_setnormalcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the colour used to print the label when the mouse is not over the control and the link has already been clicked before (i.e. the link has been visited).
	End Rem
	Method GetVisitedColour:wxColour()
		Return wxColour._create(bmx_wxhyperlinkctrl_getvisitedcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the colour used to print the label when the mouse is not over the control and the link has already been clicked before (i.e. the link has been visited).
	End Rem
	Method SetVisitedColour(colour:wxColour)
		bmx_wxhyperlinkctrl_setvisitedcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the hyperlink has already been clicked by the user at least one time.
	End Rem
	Method GetVisited:Int()
		Return bmx_wxhyperlinkctrl_getvisited(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Marks the hyperlink as visited (see SetVisitedColour).
	End Rem
	Method SetVisited(visited:Int = True)
		bmx_wxhyperlinkctrl_setvisited(wxObjectPtr, visited)
	End Method
	
	Rem
	bbdoc: Returns the URL associated with the hyperlink.
	End Rem
	Method GetURL:String()
		Return bmx_wxhyperlinkctrl_geturl(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the URL associated with the hyperlink.
	End Rem
	Method SetURL(url:String)
		bmx_wxhyperlinkctrl_seturl(wxObjectPtr, url)
	End Method	
	
End Type

Rem
bbdoc: This event type is used for the events generated by wxHyperlinkCtrl.
End Rem
Type wxHyperlinkEvent Extends wxCommandEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxHyperlinkEvent = New wxHyperlinkEvent 
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

	Rem
	bbdoc: Returns the URL of the hyperlink where the user has just clicked.
	End Rem
	Method GetURL:String()
	End Method
	
	Rem
	bbdoc: Sets the URL associated with the event.
	End Rem
	Method SetURL(url:String)
	End Method
	
End Type

Type THyperlinkEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_HYPERLINK Then
			Return wxHyperlinkEvent.create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_HYPERLINK Then
			Return bmx_wxhyperlinkctrl_geteventtype(eventType)
		End If
	End Method
		
End Type

New THyperlinkEventFactory
