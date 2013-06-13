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
bbdoc: wxComboBox
End Rem
Module wx.wxComboBox

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
bbdoc: A combobox is like a combination of an edit control and a listbox.
about: It can be displayed as static list with editable or read-only text field; or a drop-down list with text field;
or a drop-down list without a text field.
<p>
A combobox permits a single selection only. Combobox items are numbered from zero.
</p>
<p>
If you need a customized combobox, have a look at wxComboCtrl, wxOwnerDrawnComboBox, wxComboPopup and the
ready-to-use wxBitmapComboBox.
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxCB_SIMPLE</td><td>Creates a combobox with a permanently displayed list. Windows only.</td></tr>
<tr><td>wxCB_DROPDOWN</td><td>Creates a combobox with a drop-down list. </td></tr>
<tr><td>wxCB_READONLY</td><td>Same as wxCB_DROPDOWN but only the strings specified as the
combobox choices can be selected, it is impossible to select (even from a program) a string
which is not in the choices list. </td></tr>
<tr><td>wxCB_SORT</td><td>Sorts the entries in the list alphabetically. </td></tr>
<tr><td>wxTE_PROCESS_ENTER</td><td>The control will generate the event wxEVT_COMMAND_TEXT_ENTER
(otherwise pressing Enter key is either processed internally by the control or used for
navigation between dialog controls). Windows only. </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_COMBOBOX_SELECTED </tt> - Process a wxCommandEvent, when an item on the list is selected. Note that calling GetValue returns the new value of selection. </li>
<li><tt>wxEVT_COMMAND_TEXT_UPDATED </tt> - Process a wxCommandEvent, when the combobox text changes. </li>
<li><tt>wxEVT_COMMAND_TEXT_ENTER </tt> - Process a wxCommandEvent, when <RETURN> is pressed in the combobox. </li>
</ul>
</p>
End Rem
Type wxComboBox Extends wxControlWithItems

	Function _create:wxComboBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxComboBox = New wxComboBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxComboBox(wxObjectPtr:Byte Ptr)
		Return wxComboBox._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateComboBox:wxComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxComboBox.Create(parent, id, value, choices, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxcombobox_create(Self, parent.wxObjectPtr, id, value, choices, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns true if the combobox is editable and there is a text selection to copy to the clipboard.
	about: Only available on Windows.
	End Rem
	Method CanCopy:Int()
		Return bmx_wxcombobox_cancopy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the combobox is editable and there is a text selection to copy to the clipboard.
	about: Only available on Windows.
	End Rem
	Method CanCut:Int()
		Return bmx_wxcombobox_cancut(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the combobox is editable and there is text on the clipboard that can be pasted into the text field.
	about: Only available on Windows.
	End Rem
	Method CanPaste:Int()
		Return bmx_wxcombobox_canpaste(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the combobox is editable and the last undo can be redone.
	about: Only available on Windows.
	End Rem
	Method CanRedo:Int()
		Return bmx_wxcombobox_canredo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the combobox is editable and the last edit can be undone.
	about: Only available on Windows.
	End Rem
	Method CanUndo:Int()
		Return bmx_wxcombobox_canundo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Copies the selected text to the clipboard.
	End Rem
	Method Copy()
		bmx_wxcombobox_copy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Copies the selected text to the clipboard and removes the selection.
	End Rem
	Method Cut()
		bmx_wxcombobox_cut(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method does the same things as wxChoice::GetCurrentSelection and returns the item currently selected in the dropdown list if it's open or the same thing as GetSelection otherwise.
	End Rem
	Method GetCurrentSelection:Int()
		Return bmx_wxcombobox_getcurrentselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the insertion point for the combobox's text field.
	about: On Win32, this function always returns 0 if the combobox doesn't have the focus.
	End Rem
	Method GetInsertionPoint:Int()
		Return bmx_wxcombobox_getinsertionpoint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the last position in the combobox text field.
	End Rem
	Method GetLastPosition:Int()
		Return bmx_wxcombobox_getlastposition(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This is the same as wxTextCtrl::GetSelection for the text control which is part of the combobox.
	about: Currently this method is only implemented in wxMSW and wxGTK.
	End Rem
	Method GetTextSelection(fromPos:Int Var, toPos:Int Var)
		bmx_wxcombobox_gettextselection(wxObjectPtr, Varptr fromPos, Varptr toPos)
	End Method
	
	Rem
	bbdoc: Returns the current value in the combobox text field.
	End Rem
	Method GetValue:String()
		Return bmx_wxcombobox_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Pastes text from the clipboard to the text field.
	End Rem
	Method Paste()
		bmx_wxcombobox_paste(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Redoes the last undo in the text field.
	about: Windows only
	End Rem
	Method Redo()
		bmx_wxcombobox_redo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Replaces the text between two positions with the given text, in the combobox text field.
	End Rem
	Method Replace(fromPos:Int, toPos:Int, text:String)
		bmx_wxcombobox_replace(wxObjectPtr, fromPos, toPos, text)
	End Method
	
	Rem
	bbdoc: Removes the text between the two positions in the combobox text field.
	about: 
	End Rem
	Method Remove(fromPos:Int, toPos:Int)
		bmx_wxcombobox_remove(wxObjectPtr, fromPos, toPos)
	End Method
	
	Rem
	bbdoc: Sets the insertion point in the combobox text field.
	about: 
	End Rem
	Method SetInsertionPoint(pos:Int)
		bmx_wxcombobox_setinsertionpoint(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Sets the insertion point at the end of the combobox text field.
	End Rem
	Method SetInsertionPointEnd()
		bmx_wxcombobox_setinsertionpointend(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Selects the text between the two positions, in the combobox text field.
	about: 
	End Rem
	Method SetTextSelection(fromPos:Int, toPos:Int)
		bmx_wxcombobox_settextselection(wxObjectPtr, fromPos, toPos)
	End Method
	
	Rem
	bbdoc: Sets the text for the combobox text field.
	about: NB: For a combobox with wxCB_READONLY style the string must be in the combobox choices list, otherwise
	the call to SetValue() is ignored.
	End Rem
	Method SetValue(text:String)
		bmx_wxcombobox_setvalue(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Undoes the last edit in the text field.
	about: Windows only.
	End Rem
	Method Undo()
		bmx_wxcombobox_undo(wxObjectPtr)
	End Method
	
End Type



Type TComboEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Select evt.eventType
			Case wxEVT_COMMAND_COMBOBOX_SELECTED, ..
				wxEVT_COMMAND_TEXT_UPDATED, ..
				wxEVT_COMMAND_TEXT_ENTER, ..
				wxEVT_COMMAND_COMBOBOX_DROPDOWN, ..
				wxEVT_COMMAND_COMBOBOX_CLOSEUP
					Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_COMBOBOX_SELECTED, ..
				wxEVT_COMMAND_TEXT_UPDATED, ..
				wxEVT_COMMAND_TEXT_ENTER, ..
				wxEVT_COMMAND_COMBOBOX_DROPDOWN, ..
				wxEVT_COMMAND_COMBOBOX_CLOSEUP
			Return bmx_wxcombobox_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TComboEventFactory

Type TComboBoxResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxcombobox_addresourcehandler()
	End Method
		
End Type

New TComboBoxResourceFactory

