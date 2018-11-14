' Copyright (c) 2007-2018 Bruce A Henderson
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

Module wx.wxCollapsibleHeaderCtrl

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2018 Bruce A Henderson"


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
bbdoc: Header control above a collapsible pane.
about: The collapsible header usually consists of a small indicator of the collapsed state and the label text beside it.
This type is used by the generic implementation of #wxCollapsiblePane but may be used in more complex layouts for other uses.
End Rem
Type wxCollapsibleHeaderCtrl Extends wxControl

	Rem
	bbdoc: Creates a new wxCollapsibleHeaderCtrl.
	End Rem
	Function CreateCollapsibleHeader:wxCollapsibleHeaderCtrl(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxBORDER_NONE)
		Return New wxCollapsibleHeaderCtrl.Create(parent, id, label, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxCollapsibleHeaderCtrl.
	End Rem
	Method Create:wxCollapsibleHeaderCtrl(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxBORDER_NONE)
		wxObjectPtr = bmx_wxcollapsibleheaderctrl_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Sets collapsed state of the header.
	End Rem
	Method SetCollapsed(collapsed:Int = True)
		bmx_wxcollapsibleheaderctrl_setcollapsed(wxObjectPtr, collapsed)
	End Method
	
	Rem
	bbdoc: Returns #True if the control is collapsed.
	End Rem
	Method IsCollapsed:Int()
		Return bmx_wxcollapsibleheaderctrl_iscollapsed(wxObjectPtr)
	End Method
	
End Type

Type TCollapsibleHeaderCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COLLAPSIBLEHEADER_CHANGED Then
			Return wxCommandEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COLLAPSIBLEHEADER_CHANGED Then
			Return bmx_wxcollapsibleheaderctrl_geteventtype(eventType)
		End If
	End Method
		
End Type

New TCollapsibleHeaderCtrlEventFactory
