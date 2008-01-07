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
bbdoc: wxSpinCtrl
End Rem
Module wx.wxSpinCtrl

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
bbdoc: wxSpinCtrl combines wxTextCtrl and wxSpinButton in one control.
End Rem
Type wxSpinCtrl Extends wxControl

	Function CreateSpinCtrl:wxSpinCtrl(parent:wxWindow, id:Int, value:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSP_ARROW_KEYS, minimum:Int = 0, maximum:Int = 100, initial:Int = 0)
			
		Return New wxSpinCtrl.Create(parent, id, value, x, y, w, h, style, minimum, maximum, initial)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateButton.
	End Rem
	Method Create:wxSpinCtrl(parent:wxWindow, id:Int, value:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSP_ARROW_KEYS, minimum:Int = 0, maximum:Int = 100, initial:Int = 0)
			
		wxObjectPtr = bmx_wxspinctrl_create(Self, parent.wxObjectPtr, id, value, x, y, w, h, style, minimum, maximum, initial)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Sets the value of the spin control.
	End Rem
	Method SetValue(value:Int)
		bmx_wxspinctrl_setvalue(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value of the spin control.
	End Rem
	Method SetTextValue(value:String)
		bmx_wxspinctrl_settextvalue(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Gets the value of the spin control.
	End Rem
	Method GetValue:Int()
		Return bmx_wxspinctrl_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets range of allowable values.
	End Rem
	Method SetRange(minVal:Int, maxVal:Int)
		bmx_wxspinctrl_setrange(wxObjectPtr, minVal, maxVal)
	End Method
	
	Rem
	bbdoc: Select the text in the text part of the control between positions from (inclusive) and to (exclusive).
	about: This is similar to wxTextCtrl::SetSelection.
	<p>
	NB: this is currently only implemented for Windows and generic versions of the control.
	</p>
	End Rem
	Method SetSelection(fromPos:Int, toPos:Int)
		bmx_wxspinctrl_setselection(wxObjectPtr, fromPos, toPos)
	End Method
	
	Rem
	bbdoc: Gets minimal allowable value.
	End Rem
	Method GetMin:Int()
		Return bmx_wxspinctrl_getmin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets maximal allowable value.
	End Rem
	Method GetMax:Int()
		Return bmx_wxspinctrl_getmax(wxObjectPtr)
	End Method
	
End Type


Type TSpinCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_SPINCTRL_UPDATED Then
			Return wxSpinEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_SPINCTRL_UPDATED Then
			Return bmx_wxspinctrl_geteventtype(eventType)
		End If
	End Method
		
End Type

New TSpinCtrlEventFactory

