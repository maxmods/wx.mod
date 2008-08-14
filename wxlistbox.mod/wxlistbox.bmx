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
bbdoc: wxListBox
End Rem
Module wx.wxListBox

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
bbdoc: A listbox is used to select one or more of a list of strings.
about: The strings are displayed in a scrolling box, with the selected string(s) marked in reverse video.
A listbox can be single selection (if an item is selected, the previous selection is removed) or multiple
selection (clicking an item toggles the item on or off independently of other selections).
<p>
List box elements are numbered from zero. Their number may be limited under some platforms.
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxLB_SINGLE</td><td>Single-selection list.</td></tr>
<tr><td>wxLB_MULTIPLE</td><td>Multiple-selection list: the user can toggle multiple items on and off.</td></tr>
<tr><td>wxLB_EXTENDED</td><td>Extended-selection list: the user can select multiple items using the SHIFT key and the mouse or special key combinations.</td></tr>
<tr><td>wxLB_HSCROLL</td><td>Create horizontal scrollbar if contents are too wide (Windows only).</td></tr>
<tr><td>wxLB_HSCROLL</td><td>Always show a vertical scrollbar.</td></tr>
<tr><td>wxLB_NEEDED_SB</td><td>Only create a vertical scrollbar if needed.</td></tr>
<tr><td>wxLB_SORT</td><td>The listbox contents are sorted in alphabetical order.</td></tr>
</table>
Note that wxLB_SINGLE, wxLB_MULTIPLE and wxLB_EXTENDED styles are mutually exclusive and you can specify at most
one of them (single selection is the default).
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_LISTBOX_SELECTED</tt> - handle single clicks.</li>
<li><tt>wxEVT_COMMAND_LISTBOX_DOUBLE_CLICKED</tt> - handle double clicks.</li>
</ul>
</p>
End Rem
Type wxListBox Extends wxControlWithItems

	Function _create:wxListBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxListBox = New wxListBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxListBox(wxObjectPtr:Byte Ptr)
		Return wxListBox._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a list box.
	End Rem
	Function CreateListBox:wxListBox(parent:wxWindow, id:Int, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxListBox.Create(parent, id, choices, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the listbox for two-step construction.
	about: See CreateListBox for further details.
	End Rem
	Method Create:wxListBox(parent:wxWindow, id:Int, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxlistbox_create(Self, parent.wxObjectPtr, id, choices, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Deselects an item in the list box.
	End Rem
	Method Deselect(item:Int)
		bmx_wxlistbox_deselect(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns an array of ints with the positions of the currently selected items
	about: Use this with a multiple selection listbox.
	End Rem
	Method GetSelections:Int[]()
		Return bmx_wxlistbox_getselections(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Insert the given list of strings before the specified position.
	End Rem
	Method InsertItems(items:String[], pos:Int)
		bmx_wxlistbox_insertitems(wxObjectPtr, items, pos)
	End Method
	
	Rem
	bbdoc: Returns the item located at point, or wxNOT_FOUND if there is no item located at point.
	about: 
	End Rem
	Method HitTest:Int(x:Int, y:Int)
		Return bmx_wxlistbox_hittest(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Determines whether an item is selected.
	returns: True if the given item is selected, False otherwise.
	End Rem
	Method IsSelected:Int(item:Int)
		Return bmx_wxlistbox_isselected(wxObjectPtr, item)
	End Method

	Rem
	bbdoc: Set the specified item to be the first visible item.
	End Rem
	Method SetFirstItem(item:Int)
		bmx_wxlistbox_setfirstitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Set the specified item to be the first visible item.
	End Rem
	Method SetFirstItemString(item:String)
		bmx_wxlistbox_setfirstitemstr(wxObjectPtr, item)
	End Method
	
End Type


Type TListBoxEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, ..
					wxEVT_COMMAND_LISTBOX_SELECTED
				Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, ..
					wxEVT_COMMAND_LISTBOX_SELECTED
			Return bmx_wxlistbox_geteventtype(eventType)
		End Select
	End Method
	
End Type

New TListBoxEventFactory

Type TListBoxResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxlistbox_addresourcehandler()
	End Method
		
End Type

New TListBoxResourceFactory
