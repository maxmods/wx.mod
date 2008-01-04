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
bbdoc: wxRadioButton
End Rem
Module wx.wxRadioButton

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
bbdoc: A radio button item is a button which usually denotes one of several mutually exclusive options.
about: It has a text label next to a (usually) round button.
<p>
You can create a group of mutually-exclusive radio buttons by specifying wxRB_GROUP for the first in the
group. The group ends when another radio button group is created, or there are no more radio buttons.
</p>
End Rem
Type wxRadioButton Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a radio button.
	End Rem
	Function CreateRadioButton:wxRadioButton(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		Return New wxRadioButton.Create(parent, id, label, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateRadioButton.
	End Rem
	Method Create:wxRadioButton(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxradiobutton_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		Return Self
	End Method

	Rem
	bbdoc: Returns True if the radio button is depressed, False otherwise.
	End Rem
	Method GetValue:Int()
		Return bmx_wxradiobutton_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the radio button to selected or deselected status.
	about: This does not cause a wxEVT_COMMAND_RADIOBUTTON_SELECTED event to get emitted.
	End Rem
	Method SetValue(value:Int)
		bmx_wxradiobutton_setvalue(wxObjectPtr, value)
	End Method
	
End Type

Type TRadioButtonEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_RADIOBUTTON_SELECTED Then
			Return wxCommandEvent.create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_RADIOBUTTON_SELECTED Then
			Return bmx_wxradiobutton_geteventtype(eventType)
		End If
	End Method
		
End Type

New TRadioButtonEventFactory
