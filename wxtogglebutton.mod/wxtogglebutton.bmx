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
bbdoc: wxToggleButton
End Rem
Module wx.wxToggleButton

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
bbdoc: wxToggleButton is a button that stays pressed when clicked by the user.
about: In other words, it is similar to wxCheckBox in functionality but looks like a wxButton.
End Rem
Type wxToggleButton Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a toggle button.
	End Rem
	Function CreateToggleButton:wxToggleButton(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxToggleButton.Create(parent, id, label, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the toggle button for two-step construction.
	about: See CreateToggleButton for details. 
	End Rem
	Method Create:wxToggleButton(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxtogglebutton_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Gets the state of the toggle button.
	returns: True if it is pressed, False otherwise.
	End Rem
	Method GetValue:Int()
		Return bmx_wxtogglebutton_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the toggle button to the given state. This does not cause a EVT_TOGGLEBUTTON event to be emitted.
	End Rem
	Method SetValue(state:Int)
		bmx_wxtogglebutton_setvalue(wxObjectPtr, state)
	End Method

End Type


Type TToggleButtonEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_TOGGLEBUTTON_CLICKED Then
			Return wxCommandEvent.create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_TOGGLEBUTTON_CLICKED Then
			Return bmx_wxtogglebutton_geteventtype(eventType)
		End If
		
		Return Null
	End Method
		
End Type

New TToggleButtonEventFactory

