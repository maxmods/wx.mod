' Copyright (c) 2007-2011 Bruce A Henderson
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
bbdoc: wxBitmapComboBox
End Rem
Module wx.wxBitmapComboBox

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A combobox that displays bitmap in front of the list items.
about: It currently only allows using bitmaps of one size, and resizes itself so that a bitmap can be shown
next to the text field.
<p>
Notes: Since BlitzMax doesn't allow method overloading, some of the methods here have the suffix "Bitmap". For example,
instead of Append(), we use AppendBitmap().
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxCB_READONLY</td><td>Creates a combobox without a text editor. On some platforms the
control may appear very different when this style is used. </td></tr>
<tr><td>wxCB_SORT</td><td>Sorts the entries in the list alphabetically. </td></tr>
<tr><td>wxTE_PROCESS_ENTER</td><td>The control will generate the event wxEVT_COMMAND_TEXT_ENTER
(otherwise pressing Enter key is either processed internally by the control or used for
navigation between dialog controls). Windows only.</td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_COMBOBOX_SELECTED </tt> - Process a wxCommandEvent, when an item on the list is selected. </li>
<li><tt>wxEVT_COMMAND_TEXT_UPDATED </tt> - Process a wxCommandEvent, when the combobox text changes.</li>
<li><tt>wxEVT_COMMAND_TEXT_ENTER </tt> - Process a wxCommandEvent, when &lt;RETURN&gt; is pressed in the combobox.</li>
</ul>
</p>
End Rem
Type wxBitmapComboBox Extends wxComboBox

	Function _create:wxBitmapComboBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBitmapComboBox = New wxBitmapComboBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxBitmapComboBox(wxObjectPtr:Byte Ptr)
		Return wxBitmapComboBox._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a combobox.
	End Rem
	Function CreateBitmapComboBox:wxBitmapComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, ..
			y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		
		Return New wxBitmapComboBox.Create(parent, id, value, choices, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the combobox for two-step construction. 
	about: See wxBitmapComboBox::wxBitmapComboBox for further details.
	End Rem
	Method Create:wxBitmapComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxbitmapcombobox_create(Self, parent.wxObjectPtr, id, value, choices, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Adds the item to the end of the combo box, associating the given client data with the item.
	End Rem
	Method AppendBitmap:Int(item:String, bitmap:wxBitmap = Null, clientData:Object = Null)
		If bitmap Then
			Return bmx_wxbitmapcombobox_append(wxObjectPtr, item, bitmap.wxObjectPtr, clientData)
		Else
			Return bmx_wxbitmapcombobox_append(wxObjectPtr, item, Null, clientData)
		End If
	End Method
	
	Method Append:Int(item:String, clientData:Object = Null)
		Assert Null, "Use AppendBitmap() instead of Append() for wxBitmapComboBox"
	End Method

	Rem
	bbdoc: Returns size of bitmaps used in the list.
	End Rem
	Method GetBitmapSize(w:Int Var, h:Int Var)
		bmx_wxbitmapcombobox_getbitmapsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the bitmap of the item with the given index.
	End Rem
	Method GetItemBitmap:wxBitmap(item:Int)
		Return wxBitmap._create(bmx_wxbitmapcombobox_getitembitmap(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Inserts the item into the list before pos, associating the given client data with the item.
	about: Not valid for wxCB_SORT style, use Append instead.
	End Rem
	Method InsertBitmap:Int(pos:Int, item:String, bitmap:wxBitmap = Null, clientData:Object = Null)
		If bitmap Then
			Return bmx_wxbitmapcombobox_insert(wxObjectPtr, pos, item, bitmap.wxObjectPtr, clientData)
		Else
			Return bmx_wxbitmapcombobox_insert(wxObjectPtr, pos, item, Null, clientData)
		End If
	End Method

	Method Insert:Int(item:String, pos:Int, clientData:Object = Null)
		Assert Null, "Use InsertBitmap() instead of Insert() for wxBitmapComboBox"
	End Method

	Rem
	bbdoc: Sets the bitmap for the given item.
	End Rem
	Method SetItemBitmap(item:Int, bitmap:wxBitmap)
		bmx_wxbitmapcombobox_setitembitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Rem
	bbdoc: This is the same as SetSelection and exists only because it is slightly more natural for controls which support multiple selection.
	End Rem
	Method SelectItem(item:Int)
		bmx_wxbitmapcombobox_selectitem(wxObjectPtr, item)
	End Method

	Rem
	bbdoc: Sets the selection to the given item n or removes the selection entirely if n == wxNOT_FOUND.
	about: Note that this does not cause any command events to be emitted nor does it deselect any
	other items in the controls which support multiple selections.
	End Rem
	Method SetSelection(item:Int)
		bmx_wxbitmapcombobox_setselection(wxObjectPtr, item)
	End Method

	Rem
	bbdoc: Removes all items from the control.
	End Rem
	Method Clear()
		bmx_wxbitmapcombobox_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes an item from the control.
	about: Note that it is an error (signalled by an assert failure in debug builds) to remove an item
	with the index negative or greater or equal than the number of items in the control.
	End Rem
	Method DeleteItem(item:Int)
		bmx_wxbitmapcombobox_deleteitem(wxObjectPtr, item)
	End Method

	Rem
	bbdoc: Returns the number of items in the control.
	End Rem
	Method GetCount:Int()
		Return bmx_wxbitmapcombobox_getcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the selected item or wxNOT_FOUND if no item is selected.
	about: This method can be used with single selection list boxes only, you should use
	wxListBox::GetSelections for the list boxes with wxLB_MULTIPLE style.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxbitmapcombobox_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the label of the item with the given index.
	returns: The label of the item or an empty string if the position was invalid.
	End Rem
	Method GetString:String(item:Int)
		Return bmx_wxbitmapcombobox_getstring(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the array of the labels of all items in the control.
	End Rem
	Method GetStrings:String[]()
		Return bmx_wxbitmapcombobox_getstrings(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the label of the selected item or an empty string if no item is selected.
	End Rem
	Method GetStringSelection:String()
		Return bmx_wxbitmapcombobox_getstringselection(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if the control is empty or False if it has some items.
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxbitmapcombobox_isempty(wxObjectPtr)
	End Method

End Type

Type TBitmapComboBoxResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxbitmapcombobox_addresourcehandler()
	End Method
		
End Type

New TBitmapComboBoxResourceFactory

