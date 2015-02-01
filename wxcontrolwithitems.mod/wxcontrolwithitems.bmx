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
bbdoc: wxControlWithItems
End Rem
Module wx.wxControlWithItems

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
bbdoc: This type is an abstract base type for some wxWidgets controls which contain several items, such as
wxListBox, wxCheckListBox, wxChoice and wxComboBox derived from it.
<p>
It defines the methods for accessing the controls items and although each of the derived classes implements
them differently, they still all conform to the same interface.
</p>
<p>
The items in a wxControlWithItems have (non-empty) string labels and, optionally, client data associated with them.
</p>
End Rem
Type wxControlWithItems Extends wxControl Abstract

	Rem
	bbdoc: Adds the item to the end of the list box, associating the optionally given client data with the item.
	returns: The index of the newly added item which may be different from the last one if the control is sorted (e.g. has wxLB_SORT or wxCB_SORT style).
	End Rem
	Method Append:Int(item:String, clientData:Object = Null)
		Return bmx_wxcontrolwithitems_append(wxObjectPtr, item, clientData)
	End Method
	
	Rem
	bbdoc: Appends several items at once to the control.
	about: Notice that calling this method may be much faster than appending the items one by one
	if you need to add a lot of items.
	End Rem
	Method AppendItems(items:String[])
		bmx_wxcontrolwithitems_appenditems(wxObjectPtr, items)
	End Method
	
	Rem
	bbdoc: Removes all items from the control.
	End Rem
	Method Clear()
		bmx_wxcontrolwithitems_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes an item from the control.
	about: Note that it is an error (signalled by an assert failure in debug builds) to remove an item
	with the index negative or greater or equal than the number of items in the control.
	End Rem
	Method DeleteItem(item:Int)
		bmx_wxcontrolwithitems_deleteitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Finds an item whose label matches the given string.
	returns: The zero-based position of the item, or wxNOT_FOUND if the string was not found.
	End Rem
	Method FindString:Int(text:String, caseSensitive:Int = False)
		Return bmx_wxcontrolwithitems_findstring(wxObjectPtr, text, caseSensitive)
	End Method
	
	Rem
	bbdoc: Returns the client data associated with the given item (if any).
	returns: The client data, or Null if not present.
	End Rem
	Method GetItemClientData:Object(item:Int)
		Return bmx_wxcontrolwithitems_getclientdata(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the number of items in the control.
	End Rem
	Method GetCount:Int()
		Return bmx_wxcontrolwithitems_getcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the selected item or wxNOT_FOUND if no item is selected.
	about: This method can be used with single selection list boxes only, you should use
	wxListBox::GetSelections for the list boxes with wxLB_MULTIPLE style.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxcontrolwithitems_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the label of the item with the given index.
	returns: The label of the item or an empty string if the position was invalid.
	End Rem
	Method GetString:String(item:Int)
		Return bmx_wxcontrolwithitems_getstring(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the array of the labels of all items in the control.
	End Rem
	Method GetStrings:String[]()
		Return bmx_wxcontrolwithitems_getstrings(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the label of the selected item or an empty string if no item is selected.
	End Rem
	Method GetStringSelection:String()
		Return bmx_wxcontrolwithitems_getstringselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inserts the item into the list before pos, associating the optional clientData with the item.
	returns: The return value is the index of the newly inserted item. If the insertion failed for some reason, -1 is returned.
	about: Not valid for wxLB_SORT or wxCB_SORT styles, use Append instead.
	End Rem
	Method Insert:Int(item:String, pos:Int, clientData:Object = Null)
		Return bmx_wxcontrolwithitems_insert(wxObjectPtr, item, pos, clientData)
	End Method
	
	Rem
	bbdoc: Returns True if the control is empty or Talse if it has some items.
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxcontrolwithitems_isempty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This is the same as SetSelection and exists only because it is slightly more natural for controls which support multiple selection.
	End Rem
	Method SelectItem(item:Int)
		bmx_wxcontrolwithitems_selectitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Associates the given client data with the given item.
	End Rem
	Method SetItemClientData(item:Int, data:Object)
		bmx_wxcontrolwithitems_setclientdata(wxObjectPtr, item, data)
	End Method
	
	Rem
	bbdoc: Sets the selection to the given item n or removes the selection entirely if n == wxNOT_FOUND.
	about: Note that this does not cause any command events to be emitted nor does it deselect any
	other items in the controls which support multiple selections.
	End Rem
	Method SetSelection(item:Int)
		bmx_wxcontrolwithitems_setselection(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Sets the label for the given item.
	End Rem
	Method SetString(item:Int, text:String)
		bmx_wxcontrolwithitems_setstring(wxObjectPtr, item, text)
	End Method
	
	Rem
	bbdoc: Selects the item with the specified string in the control.
	returns: True if the specified string has been selected, False if it wasn't found in the control.
	about: This doesn't cause any command events being emitted.
	End Rem
	Method SetStringSelection:Int(text:String)
		Return bmx_wxcontrolwithitems_setstringselection(wxObjectPtr, text)
	End Method

End Type

