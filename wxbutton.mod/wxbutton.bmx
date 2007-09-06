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
bbdoc: wxButton
End Rem
Module wx.wxButton

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
bbdoc: A button is a control that contains a text string, and is one of the most common elements of a GUI.
about: It may be placed on a dialog box or panel, or indeed almost any other window.
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxBU_LEFT</td><td>Left-justifies the label. Windows and GTK+ only.</td></tr>
<tr><td>wxBU_TOP</td><td>Aligns the label to the top of the button. Windows and GTK+ only.</td></tr>
<tr><td>wxBU_RIGHT</td><td>Right-justifies the bitmap label. Windows and GTK+ only.</td></tr>
<tr><td>wxBU_BOTTOM</td><td>Aligns the label to the bottom of the button. Windows and GTK+ only.</td></tr>
<tr><td>wxBU_EXACTFIT</td><td>Creates the button as small as possible instead of making it of the standard size (which is the default behaviour ). </td></tr>
<tr><td>wxNO_BORDER</td><td>Creates a flat button. Windows and GTK+ only.</td></tr>
</table>
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_BUTTON_CLICKED</tt> - handle button click.</li>
</ul>
</p>
End Rem
Type wxButton Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a button.
	about: The preferred way to create standard buttons is to use default value of label. If no label is supplied
	and id is one of standard IDs from this list, standard label will be used. In addition to that, the button will
	be decorated with stock icons under GTK+ 2.
	End Rem
	Function CreateButton:wxButton(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		Return New wxButton.Create(parent, id, label, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateButton.
	End Rem
	Method Create:wxButton(parent:wxWindow, id:Int, label:Object = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxbutton_create(Self, parent.wxObjectPtr, id, String(label), x, y, w, h, style)
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the string label for the button.
	returns: The button's label.
	End Rem
	Method GetLabel:String()
		Return bmx_wxbutton_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the default size for the buttons.
	about: It is advised to make all the dialog buttons of the same size and this function allows to
	retrieve the (platform and current font dependent size) which should be the best suited for this.
	End Rem
	Method GetDefaultSize(width:Int Var, height:Int Var)
		bmx_wxbutton_getdefaultsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: This sets the button to be the default item for the panel or dialog box.
	about: Under Windows, only dialog box buttons respond to this function. As normal under Windows, pressing
	return causes the default button to be depressed when the return key is pressed. See also wxWindow::SetFocus
	which sets the keyboard focus for windows and text panel items, and wxTopLevelWindow::SetDefaultItem.
	End Rem
	Method SetDefault()
		bmx_wxbutton_setdefault(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the string label for the button.
	End Rem
	Method SetLabel(text:String)
		bmx_wxbutton_setlabel(wxObjectPtr, text)
	End Method

End Type


Type TButtonEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_BUTTON_CLICKED Then
			Return wxCommandEvent.create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_BUTTON_CLICKED Then
			Return bmx_wxbutton_geteventtype(eventType)
		End If
	End Method
		
End Type

New TButtonEventFactory

