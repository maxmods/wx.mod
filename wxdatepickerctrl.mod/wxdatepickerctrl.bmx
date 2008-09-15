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
bbdoc: wxDatePickerCtrl
End Rem
Module wx.wxDatePickerCtrl

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
bbdoc: This control allows the user to select a date.
about: Unlike wxCalendarCtrl, which is a relatively big control, wxDatePickerCtrl is implemented
as a small window showing the currently selected date. The control can be edited using the keyboard,
and can also display a popup window for more user-friendly date selection, depending on the styles
used and the platform.
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxDP_SPIN</td><td>Creates a control without a month calendar drop down but with
spin-control-like arrows to change individual date components. This style is not supported by
the generic version. </td></tr>
<tr><td>wxDP_DROPDOWN</td><td>Creates a control with a month calendar drop-down part from which
the user can select a date.</td></tr>
<tr><td>wxDP_DEFAULT</td><td>Creates a control with the style that is best supported for the
current platform (currently wxDP_SPIN under Windows and wxDP_DROPDOWN elsewhere). </td></tr>
<tr><td>wxDP_ALLOWNONE</td><td>With this style, the control allows the user to not enter any
valid date at all. Without it - the default - the control always has some valid date. </td></tr>
<tr><td>wxDP_SHOWCENTURY</td><td>Forces display of the century in the default date format.
Without this style the century could be displayed, or not, depending on the default date
representation in the system. </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_DATE_CHANGED</tt> - This event fires when the user changes the current selection in the control.</li>
</ul>
</p>
End Rem
Type wxDatePickerCtrl Extends wxControl

	Function _create:wxDatePickerCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDatePickerCtrl = New wxDatePickerCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxDatePickerCtrl(wxObjectPtr:Byte Ptr)
		Return wxDatePickerCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Creates a new wxDatePickerCtrl object.
	End Rem
	Function CreateDatePickerCtrl:wxDatePickerCtrl(parent:wxWindow, id:Int, dt:wxDateTime = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDP_DEFAULT | wxDP_SHOWCENTURY)
		Return New wxDatePickerCtrl.Create(parent, id, dt, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxDatePickerCtrl object.
	End Rem
	Method Create:wxDatePickerCtrl(parent:wxWindow, id:Int, dt:wxDateTime = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDP_DEFAULT | wxDP_SHOWCENTURY)
		If dt Then
			wxObjectPtr = bmx_wxdatepickerctrl_create(Self, parent.wxObjectPtr, id, dt.wxObjectPtr, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxdatepickerctrl_create(Self, parent.wxObjectPtr, id, Null, x, y, w, h, style)
		End If
		Return Self
	End Method

	Rem
	bbdoc: If the control had been previously limited to a range of dates using SetRange(), returns the lower and upper bounds of this range.
	returns: False if no range limits are currently set, True if at least one bound is set.
	about: If no range is set (or only one of the bounds is set), dt1 and/or dt2 are set to
	be invalid.
	End Rem
	Method GetRange:Int(dt1:wxDateTime = Null, dt2:wxDateTime = Null)
		If dt1 Then
			If dt2 Then
				Return bmx_wxdatepickerctrl_getrange(wxObjectPtr, dt1.wxObjectPtr, dt2.wxObjectPtr)
			Else
				Return bmx_wxdatepickerctrl_getrange(wxObjectPtr, dt1.wxObjectPtr, Null)
			End If
		Else
			If dt2 Then
				Return bmx_wxdatepickerctrl_getrange(wxObjectPtr, Null, dt2.wxObjectPtr)
			Else
				Return bmx_wxdatepickerctrl_getrange(wxObjectPtr, Null, Null)
			End If
		End If
	End Method
	
	Rem
	bbdoc: Returns the currently selected.
	about: If there is no selection or the selection is outside of the current range, an
	invalid object is returned.
	End Rem
	Method GetValue:wxDateTime()
		Return wxDateTime._create(bmx_wxdatepickerctrl_getvalue(wxObjectPtr))
	End Method
	
'	Rem
'	bbdoc: 
'	End Rem
'	Method SetFormat(format:String)
'		bmx_wxdatepickerctrl_setformat(wxObjectPtr, format)
'	End Method
	
	Rem
	bbdoc: Sets the valid range for the date selection.
	about: If dt1 is valid, it becomes the earliest date (inclusive) accepted by the control.
	If dt2 is valid, it becomes the latest possible date.
	End Rem
	Method SetRange(dt1:wxDateTime = Null, dt2:wxDateTime = Null)
		If dt1 Then
			If dt2 Then
				bmx_wxdatepickerctrl_setrange(wxObjectPtr, dt1.wxObjectPtr, dt2.wxObjectPtr)
			Else
				bmx_wxdatepickerctrl_setrange(wxObjectPtr, dt1.wxObjectPtr, Null)
			End If
		Else
			If dt2 Then
				bmx_wxdatepickerctrl_setrange(wxObjectPtr, Null, dt2.wxObjectPtr)
			Else
				bmx_wxdatepickerctrl_setrange(wxObjectPtr, Null, Null)
			End If
		End If
	End Method
	
	Rem
	bbdoc: Changes the current value of the control.
	about: The date should be valid and included in the currently selected range, if any.
	<p>
	Calling this method does not result in a date change event.
	</p>
	End Rem
	Method SetValue(dt:wxDateTime)
		bmx_wxdatepickerctrl_setvalue(wxObjectPtr, dt.wxObjectPtr)
	End Method

End Type

Type TDateEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_DATE_CHANGED Then
			Return wxDateEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_DATE_CHANGED Then
			Return bmx_wxdatepickerctrl_geteventtype(eventType)
		End If
	End Method

End Type

New TDateEventFactory


Type TDatePickerCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxdatepickerctrl_addresourcehandler()
	End Method
		
End Type

New TDatePickerCtrlResourceFactory
