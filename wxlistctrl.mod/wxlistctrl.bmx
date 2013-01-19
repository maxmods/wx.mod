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
bbdoc: wxListCtrl
End Rem
Module wx.wxListCtrl

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
bbdoc: A list control presents lists in a number of formats: list view, report view, icon view and small icon view.
about: In any case, elements are numbered from zero. For all these modes, the items are stored in the control
and must be added to it using InsertItem method.
<p>
A special case of report view quite different from the other modes of the list control is a virtual
control in which the items data (including text, images and attributes) is managed by the main program
and is requested by the control itself only when needed which allows to have controls with millions of
items without consuming much memory. To use virtual list control you must use SetItemCount first and
overload at least OnGetItemText (and optionally OnGetItemImage or OnGetItemColumnImage and OnGetItemAttr)
to return the information about the items when the control requests it. Virtual list control can be used
as a normal one except that no operations which can take time proportional to the number of items in the
control happen -- this is required to allow having a practically infinite number of items. For example,
in a multiple selection virtual list control, the selections won't be sent when many items are selected at
once because this could mean iterating over all the items.
</p>
<p>
Using many of wxListCtrl features is shown in the corresponding sample.
</p>
<p>
To intercept events from a list control, use the event table (TODO! change this) macros described in wxListEvent.
</p>
<p>
Mac Note: wxListCtrl uses a native implementation for report mode, and uses a generic implementation
for other modes. You can use the generic implementation for report mode as well by setting
the <tt>mac.listctrl.always_use_generic</tt> wxSystemOption to 1.
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxLC_LIST </td><td>Multicolumn list view, with optional small icons. Columns are computed automatically, i.e. you don't set columns as in wxLC_REPORT. In other words, the list wraps, unlike a wxListBox. </td></tr>
<tr><td>wxLC_REPORT </td><td>Single or multicolumn report view, with optional header. </td></tr>
<tr><td>wxLC_VIRTUAL </td><td>The application provides items text on demand. May only be used with wxLC_REPORT. </td></tr>
<tr><td>wxLC_ICON </td><td>Large icon view, with optional labels. </td></tr>
<tr><td>wxLC_SMALL_ICON </td><td>Small icon view, with optional labels. </td></tr>
<tr><td>wxLC_ALIGN_TOP </td><td>Icons align to the top. Win32 default, Win32 only. </td></tr>
<tr><td>wxLC_ALIGN_LEFT </td><td>Icons align to the left. </td></tr>
<tr><td>wxLC_AUTOARRANGE </td><td>Icons arrange themselves. Win32 only. </td></tr>
<tr><td>wxLC_EDIT_LABELS </td><td>Labels are editable: the application will be notified when editing starts. </td></tr>
<tr><td>wxLC_NO_HEADER </td><td>No header in report mode. </td></tr>
<tr><td>wxLC_SINGLE_SEL </td><td>Single selection (default is multiple). </td></tr>
<tr><td>wxLC_SORT_ASCENDING </td><td>Sort in ascending order (must still supply a comparison callback in SortItems. </td></tr>
<tr><td>wxLC_SORT_DESCENDING /td><td>Sort in descending order (must still supply a comparison callback in SortItems. </td></tr>
<tr><td>wxLC_HRULES </td><td>Draws light horizontal rules between rows in report mode. </td></tr>
<tr><td>wxLC_VRULES </td><td>Draws light vertical rules between columns in report mode. </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_LIST_BEGIN_DRAG</tt> - Begin dragging with the left mouse button. </li>
<li><tt>wxEVT_LIST_BEGIN_RDRAG</tt> - Begin dragging with the right mouse button. </li>
<li><tt>wxEVT_LIST_BEGIN_LABEL_EDIT</tt> - Begin editing a label. This can be prevented by calling Veto(). </li>
<li><tt>wxEVT_LIST_END_LABEL_EDIT</tt> - Finish editing a label. This can be prevented by calling Veto(). </li>
<li><tt>wxEVT_LIST_DELETE_ITEM</tt> - Delete an item. </li>
<li><tt>wxEVT_LIST_DELETE_ALL_ITEMS</tt> - Delete all items. </li>
<li><tt>wxEVT_LIST_ITEM_SELECTED</tt> - The item has been selected. </li>
<li><tt>wxEVT_LIST_ITEM_DESELECTED</tt> - The item has been deselected. </li>
<li><tt>wxEVT_LIST_ITEM_ACTIVATED</tt> - The item has been activated (ENTER or double click). </li>
<li><tt>wxEVT_LIST_ITEM_FOCUSED</tt> - The currently focused item has changed. </li>
<li><tt>wxEVT_LIST_ITEM_MIDDLE_CLICK</tt> - The middle mouse button has been clicked on an item. </li>
<li><tt>wxEVT_LIST_ITEM_RIGHT_CLICK</tt> - The right mouse button has been clicked on an item. </li>
<li><tt>wxEVT_LIST_KEY_DOWN</tt> - A key has been pressed. </li>
<li><tt>wxEVT_LIST_INSERT_ITEM</tt> - An item has been inserted. </li>
<li><tt>wxEVT_LIST_COL_CLICK</tt> - A column has been left-clicked. </li>
<li><tt>wxEVT_LIST_COL_RIGHT_CLICK</tt> - A column has been right-clicked. </li>
<li><tt>xwEVT_LIST_COL_BEGIN_DRAG</tt> - The user started resizing a column - can be vetoed. </li>
<li><tt>wxEVT_LIST_COL_DRAGGING</tt> - The divider between columns is being dragged. </li>
<li><tt>wxEVT_LIST_COL_END_DRAG</tt> - A column has been resized by the user. </li>
<li><tt>wxEVT_LIST_CACHE_HINT</tt> - Prepare cache for a virtual list control </li>
</ul>
</p>
End Rem
Type wxListCtrl Extends wxControl

	Field callback:Int(item1:Object, item2:Object, data:Object)
	Field callbackData:Object

	Function _create:wxListCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxListCtrl = New wxListCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxListCtrl(wxObjectPtr:Byte Ptr)
		Return wxListCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a list control.
	End Rem
	Function CreateListCtrl:wxListCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxLC_ICON)
		Return New wxListCtrl.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the list control.
	about: See CreateListCtrl for further details.
	End Rem
	Method Create:wxListCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxLC_ICON)
		wxObjectPtr = bmx_wxlistctrl_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Arranges the items in icon or small icon view.
	about: This only has effect on Win32. @flag is one of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_ALIGN_DEFAULT</td><td>Default alignment. </td></tr>
	<tr><td>wxLIST_ALIGN_LEFT </td><td>Align to the left side of the control. </td></tr>
	<tr><td>wxLIST_ALIGN_TOP </td><td>Align to the top side of the control. </td></tr>
	<tr><td>wxLIST_ALIGN_SNAP_TO_GRID </td><td>Snap to grid. </td></tr>
	</table
	End Rem
	Method Arrange:Int(flag:Int = wxLIST_ALIGN_DEFAULT)
		Return bmx_wxlistctrl_arrange(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the image list associated with the control and takes ownership of it (i.e. the control will, unlike when using SetImageList, delete the list when destroyed).
	about: @which is one of wxIMAGE_LIST_NORMAL, wxIMAGE_LIST_SMALL, wxIMAGE_LIST_STATE
	(the last is unimplemented).
	End Rem
	Method AssignImageList(imageList:wxImageList, which:Int)
		bmx_wxlistctrl_assignimagelist(wxObjectPtr, imageList.wxObjectPtr, which)
	End Method
	
	Rem
	bbdoc: Deletes all items and all columns.
	End Rem
	Method ClearAll()
		bmx_wxlistctrl_clearall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes all items in the list control.
	about: This method does not send the wxEVT_COMMAND_LIST_DELETE_ITEM event because deleting many
	items from the control would be too slow then (unlike DeleteItem).
	End Rem
	Method DeleteAllItems:Int()
		Return bmx_wxlistctrl_deleteallitems(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes a column.
	End Rem
	Method DeleteColumn:Int(col:Int)
		Return bmx_wxlistctrl_deletecolumn(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: Deletes the specified item.
	about: This method sends the wxEVT_COMMAND_LIST_DELETE_ITEM event for the item being deleted.
	End Rem
	Method DeleteItem:Int(item:Int)
		Return bmx_wxlistctrl_deleteitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Starts editing the label of the given item.
	about: This method generates a EVT_LIST_BEGIN_LABEL_EDIT event which can be vetoed so that no text
	control will appear for in-place editing.
	<p>
	If the user changed the label (i.e. s/he does not press ESC or leave the text control without changes,
	a EVT_LIST_END_LABEL_EDIT event will be sent which can be vetoed as well.
	</p>
	End Rem
	Method EditLabel(item:Int)
		bmx_wxlistctrl_editlabel(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Ensures this item is visible.
	End Rem
	Method EnsureVisible:Int(item:Int)
		Return bmx_wxlistctrl_ensurevisible(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Find an item whose label matches this string, starting from start or the beginning if start is -1.
	about: The string comparison is case insensitive. If partial is true then this method will look for
	items which begin with @text.
	End Rem
	Method FindItem:Int(start:Int, text:String, partial:Int = False)
		Return bmx_wxlistctrl_finditem(wxObjectPtr, start, text, partial)
	End Method
	
	Rem
	bbdoc: Find an item whose data matches this data, starting from start or the beginning if 'start' is -1.
	End Rem
	Method FindItemData:Int(start:Int, data:Object)
		Return bmx_wxlistctrl_finditemdata(wxObjectPtr, data)
	End Method
	
	Rem
	bbdoc: Find an item nearest this position in the specified direction, starting from start or the beginning if start is -1.
	End Rem
	Method FindItemAtPos:Int(start:Int, x:Int, y:Int, direction:Int)
		Return bmx_wxlistctrl_finditematpos(wxObjectPtr, start, x, y, direction)
	End Method
	
	Rem
	bbdoc: Gets information about this column.
	about: See wxListCtrl::SetItem for more information.
	End Rem
	Method GetColumn:Int(col:Int, item:wxListItem)
		Return bmx_wxlistctrl_getcolumn(wxObjectPtr, col, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of columns.
	End Rem
	Method GetColumnCount:Int()
		Return bmx_wxlistctrl_getcolumncount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the column width (report view only).
	End Rem
	Method GetColumnWidth:Int(col:Int)
		Return bmx_wxlistctrl_getcolumnwidth(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: Gets the number of items that can fit vertically in the visible area of the list control (list or report view) or the total number of items in the list control (icon or small icon view).
	End Rem
	Method GetCountPerPage:Int()
		Return bmx_wxlistctrl_getcountperpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the edit control being currently used to edit a label.
	about: Returns Null if no label is being edited.
	<p>
	It is currently only implemented for wxMSW and the generic version, not for the native Mac OS X version.
	</p>
	End Rem
	Method GetEditControl:wxTextCtrl()
		Return wxTextCtrl._create(bmx_wxlistctrl_geteditcontrol(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the specified image list.
	about: @which may be one of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxIMAGE_LIST_NORMAL</td><td>The normal (large icon) image list. </td></tr>
	<tr><td>wxIMAGE_LIST_SMALL</td><td>The small icon image list. </td></tr>
	<tr><td>wxIMAGE_LIST_STATE</td><td>The user-defined state image list (unimplemented). </td></tr>
	</table>
	End Rem
	Method GetImageList:wxImageList(which:Int)
		Return wxImageList._create(bmx_wxlistctrl_getimagelist(wxObjectPtr, which))
	End Method
	
	Rem
	bbdoc: Gets information about the item.
	about: See wxListCtrl::SetItem for more information.
	<p>
	You must call info.SetId() to the ID of item you're interested in before calling this method.
	</p>
	End Rem
	Method GetItem:Int(info:wxListItem)
		Return bmx_wxlistctrl_getitem(wxObjectPtr, info.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the colour for this item.
	about: If the item has no specific colour, returns an invalid colour (and not the default
	background control of the control itself).
	End Rem
	Method GetItemBackgroundColour:wxColour(item:Int)
		Return wxColour._create(bmx_wxlistctrl_getitembackgroundcolour(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Returns the number of items in the list control.
	End Rem
	Method GetItemCount:Int()
		Return bmx_wxlistctrl_getitemcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the application-defined data associated with this item.
	End Rem
	Method GetItemData:Object(item:Int)
		Return bmx_wxlistctrl_getitemdata(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the item's font.
	End Rem
	Method GetItemFont:wxFont(item:Int)
		Return wxFont._create(bmx_wxlistctrl_getitemfont(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Returns the position of the item, in icon or small icon view.
	End Rem
	Method GetItemPosition:Int(item:Int, x:Int Var, y:Int Var)
		Return bmx_wxlistctrl_getitemposition(wxObjectPtr, item, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the rectangle representing the item's size and position, in physical coordinates.
	about: @code is one of wxLIST_RECT_BOUNDS, wxLIST_RECT_ICON, wxLIST_RECT_LABEL.
	End Rem
	Method GetItemRect:Int(item:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var, code:Int = wxLIST_RECT_BOUNDS)
		Return bmx_wxlistctrl_getitemrect(wxObjectPtr, item, Varptr x, Varptr y, Varptr w, Varptr h, code)
	End Method
	
	Rem
	bbdoc: Returns the rectangle representing the size and position, in physical coordinates, of the given subitem, i.e. the part of the row item in the column subItem.
	about: This method is only meaningful when the wxListCtrl is in the report mode. If subItem parameter
	is equal to the special value wxLIST_GETSUBITEMRECT_WHOLEITEM the return value is the same as for
	GetItemRect.
	<p>
	@code can be one of wxLIST_RECT_BOUNDS, wxLIST_RECT_ICON or wxLIST_RECT_LABEL.
	</p>
	End Rem
	Method GetSubItemRect:Int(item:Int, subItem:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var, code:Int = wxLIST_RECT_BOUNDS)
		Return bmx_wxlistctrl_getsubitemrect(wxObjectPtr, item, subItem, Varptr x, Varptr y, Varptr w, Varptr h, code)
	End Method
	
	Rem
	bbdoc: Retrieves the spacing between icons in pixels.
	End Rem
	Method GetItemSpacing(horiz:Int Var, vert:Int Var)
		bmx_wxlistctrl_getitemspacing(wxObjectPtr, Varptr horiz, Varptr vert)
	End Method
	
	Rem
	bbdoc: Gets the item state.
	about: For a list of state flags, see wxListCtrl::SetItem.
	<p>
	The @stateMask indicates which state flags are of interest.
	</p>
	End Rem
	Method GetItemState:Int(item:Int, stateMask:Int)
		Return bmx_wxlistctrl_getitemstate(wxObjectPtr, item, stateMask)
	End Method
	
	Rem
	bbdoc: Gets the item text for this item.
	End Rem
	Method GetItemText:String(item:Int)
		Return bmx_wxlistctrl_getitemtext(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the colour for this item.
	about: If the item has no specific colour, returns an invalid colour (and not the default foreground
	control of the control itself as this wouldn't allow distinguishing between items having the same
	colour as the current control foreground and items with default colour which, hence, have always the
	same colour as the control).
	End Rem
	Method GetItemTextColour:wxColour(item:Int)
		Return wxColour._create(bmx_wxlistctrl_getitemtextcolour(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Searches for an item with the given geometry or state, starting from item but excluding the item itself.
	returns: The first item with given state following item or -1 if no such item found.
	about: If item is -1, the first item that matches the specified flags will be returned.
	<p>
	This method may be used to find all selected items in the control like this:
	<pre>
	Local item:Int = -1
	
	While True
		item = listctrl.GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED)
		
		If item = -1 Then
			Exit
		End If
		
		' this item is selected - do whatever is needed with it 
		wxLogMessage("Item " + item + " is selected.") 
	Wend
	</pre>
	</p>
	<p>
	@geometry can be one of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_NEXT_ABOVE </td><td>Searches for an item above the specified item. </td></tr>
	<tr><td>wxLIST_NEXT_ALL </td><td>Searches for subsequent item by index. </td></tr>
	<tr><td>wxLIST_NEXT_BELOW </td><td>Searches for an item below the specified item. </td></tr>
	<tr><td>wxLIST_NEXT_LEFT </td><td>Searches for an item to the left of the specified item. </td></tr>
	<tr><td>wxLIST_NEXT_RIGHT </td><td>Searches for an item to the right of the specified item. </td></tr>
	</table>
	NB : this parameter is only supported by wxMSW currently and ignored on other platforms.
	</p>
	<p>
	@state can be a bitlist of the following:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_STATE_DONTCARE </td><td>Don't care what the state is. </td></tr>
	<tr><td>wxLIST_STATE_DROPHILITED </td><td>The item indicates it is a drop target. </td></tr>
	<tr><td>wxLIST_STATE_FOCUSED </td><td>The item has the focus. </td></tr>
	<tr><td>wxLIST_STATE_SELECTED </td><td>The item is selected. </td></tr>
	<tr><td>wxLIST_STATE_CUT </td><td>The item is selected as part of a cut and paste operation. </td></tr>
	</table>
	</p>
	End Rem
	Method GetNextItem:Int(item:Int, geometry:Int = wxLIST_NEXT_ALL, state:Int = wxLIST_STATE_DONTCARE)
		Return bmx_wxlistctrl_getnextitem(wxObjectPtr, item, geometry, state)
	End Method
	
	Rem
	bbdoc: Returns the number of selected items in the list control.
	End Rem
	Method GetSelectedItemCount:Int()
		Return bmx_wxlistctrl_getselecteditemcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the text colour of the list control.
	End Rem
	Method GetTextColour:wxColour()
		Return wxColour._create(bmx_wxlistctrl_gettextcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the index of the topmost visible item when in list or report view.
	End Rem
	Method GetTopItem:Int()
		Return bmx_wxlistctrl_gettopitem(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the rectangle taken by all items in the control.
	about: In other words, if the controls client size were equal to the size of this rectangle, no
	scrollbars would be needed and no free space would be left.
	<p>
	Note that this method only works in the icon and small icon views, not in list or report views
	(this is a limitation of the native Win32 control).
	</p>
	End Rem
	Method GetViewRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxlistctrl_getviewrect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Determines which item (if any) is at the specified point, giving details in flags.
	about: Returns index of the item or wxNOT_FOUND if no item is at the specified point. @flags will be a
	combination of the following flags:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_HITTEST_ABOVE </td><td>Above the client area. </td></tr>
	<tr><td>wxLIST_HITTEST_BELOW </td><td>Below the client area. </td></tr>
	<tr><td>wxLIST_HITTEST_NOWHERE </td><td>In the client area but below the last item. </td></tr>
	<tr><td>wxLIST_HITTEST_ONITEMICON </td><td>On the bitmap associated with an item. </td></tr>
	<tr><td>wxLIST_HITTEST_ONITEMLABEL </td><td>On the label (string) associated with an item. </td></tr>
	<tr><td>wxLIST_HITTEST_ONITEMRIGHT </td><td>In the area to the right of an item. </td></tr>
	<tr><td>wxLIST_HITTEST_ONITEMSTATEICON </td><td>On the state icon for a tree view item that is in a user-defined state. </td></tr>
	<tr><td>wxLIST_HITTEST_TOLEFT </td><td>To the right of the client area. </td></tr>
	<tr><td>wxLIST_HITTEST_TORIGHT </td><td>To the left of the client area. </td></tr>
	<tr><td>wxLIST_HITTEST_ONITEM </td><td>Combination of wxLIST_HITTEST_ONITEMICON, wxLIST_HITTEST_ONITEMLABEL, wxLIST_HITTEST_ONITEMSTATEICON. </td></tr>
	</table>
	End Rem
	Method HitTest:Int(x:Int, y:Int, flags:Int Var)
		Local subItem:Int
		Return HitTestSub(x, y, flags, subItem)
	End Method

	Rem
	bbdoc: See HitTest.
	End Rem
	Method HitTestSub:Int(x:Int, y:Int, flags:Int Var, subItem:Int Var)
		Return bmx_wxlistctrl_hittest(wxObjectPtr, x, y, Varptr flags, Varptr subItem)
	End Method
	
	Rem
	bbdoc: For report view mode (only), Creates a column using a header string only.
	End Rem
	Method InsertColumn:Int(col:Int, heading:String, format:Int = wxLIST_FORMAT_LEFT, width:Int = -1)
		Return bmx_wxlistctrl_insertcolumn(wxObjectPtr, col, heading, format, width)
	End Method
	
	Rem
	bbdoc: For report view mode (only), Creates a column using a wxListItem. 
	End Rem
	Method InsertColumnItem:Int(col:Int, info:wxListItem)
		Return bmx_wxlistctrl_insertcolumnitem(wxObjectPtr, col, info.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inserts an item, returning the index of the new item if successful, -1 otherwise.
	End Rem
	Method InsertItem:Int(item:wxListItem)
		Return bmx_wxlistctrl_insertitem(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inserts a string item, returning the index of the new item if successful, -1 otherwise.
	End Rem
	Method InsertStringItem:Int(index:Int, label:String)
		Return bmx_wxlistctrl_insertstringitem(wxObjectPtr, index, label)
	End Method
	
	Rem
	bbdoc: Inserts an image item, returning the index of the new item if successful, -1 otherwise.
	End Rem
	Method InsertImageItem:Int(index:Int, imageIndex:Int)
		Return bmx_wxlistctrl_insertimageitem(wxObjectPtr, index, imageIndex)
	End Method
	
	Rem
	bbdoc: Insert an image/string item, returning the index of the new item if successful, -1 otherwise.
	End Rem
	Method InsertImageStringItem:Int(index:Int, label:String, imageIndex:Int)
		Return bmx_wxlistctrl_insertimagestringitem(wxObjectPtr, index, label, imageIndex)
	End Method
	
	Rem
	bbdoc: Redraws the given item.
	about: This is only useful for the virtual list controls as without calling this function the
	displayed value of the item doesn't change even when the underlying data does change.
	End Rem
	Method RefreshItem(item:Int)
		bmx_wxlistctrl_refreshitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Redraws the items between @itemFrom and @itemTo.
	about: The starting item must be less than or equal to the ending one.
	<p>
	Just as RefreshItem this is only useful for virtual list controls.
	</p>
	End Rem
	Method RefreshItems(itemFrom:Int, itemTo:Int)
		bmx_wxlistctrl_refreshitems(wxObjectPtr, itemFrom, itemTo)
	End Method
	
	Rem
	bbdoc: Scrolls the list control.
	about: If in icon, small icon or report view mode, dx specifies the number of pixels to scroll. If in
	list view mode, dx specifies the number of columns to scroll. dy always specifies the number of
	pixels to scroll vertically.
	<p>
	NB: This method is currently only implemented in the Windows version.
	</p>
	End Rem
	Method ScrollList:Int(dx:Int, dy:Int)
		Return bmx_wxlistctrl_scrolllist(wxObjectPtr, dx, dy)
	End Method
	
	Rem
	bbdoc: Sets the background colour (GetBackgroundColour already implicit in wxWindow type).
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxlistctrl_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets information about this column.
	about: See wxListCtrl::SetItem for more information.
	End Rem
	Method SetColumn:Int(col:Int, item:wxListItem)
		Return bmx_wxlistctrl_setcolumn(wxObjectPtr, col, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the column width.
	about: @width can be a width in pixels or wxLIST_AUTOSIZE (-1) or wxLIST_AUTOSIZE_USEHEADER (-2).
	wxLIST_AUTOSIZE will resize the column to the length of its longest item. wxLIST_AUTOSIZE_USEHEADER
	will resize the column to the length of the header (Win32) or 80 pixels (other platforms).
	<p>
	In small or normal icon view, col must be -1, and the column width is set for all columns.
	</p>
	End Rem
	Method SetColumnWidth:Int(col:Int, width:Int)
		Return bmx_wxlistctrl_setcolumnwidth(wxObjectPtr, col, width)
	End Method
	
	Rem
	bbdoc: Sets the image list associated with the control.
	about: @which is one of wxIMAGE_LIST_NORMAL, wxIMAGE_LIST_SMALL, wxIMAGE_LIST_STATE (the last is
	unimplemented).
	<p>
	This method does not take ownership of the image list, you have to delete it yourself.
	</p>
	End Rem
	Method SetImageList(imageList:wxImageList, which:Int)
		bmx_wxlistctrl_setimagelist(wxObjectPtr, imageList.wxObjectPtr, which)
	End Method
	
	Rem
	bbdoc: Sets information about the given wxListItem.
	about: wxListItem is a type with the following members:
	<ul>
	<li><b>mask</b> - Indicates which fields are valid. See the list of valid mask flags below.</li>
	<li><b>id</b> - The zero-based item position.</li>
	<li><b>column</b> - Zero-based column, if in report mode.</li>
	<li><b>state</b> - The state of the item. See the list of valid state flags below.</li>
	<li><b>stateMask</b> - A mask indicating which state flags are valid. See the list of valid state flags below.</li>
	<li><b>text</b> - The label/header text. </li>
	<li><b>image</b> - The zero-based index into an image list. </li>
	<li><b>data</b> - Application-defined data.</li>
	<li><b>format</b> - For columns only: the format. Can be wxLIST_FORMAT_LEFT, wxLIST_FORMAT_RIGHT or wxLIST_FORMAT_CENTRE. </li>
	<li><b>width</b> - For columns only: the column width.</li>
	</ul>
	<p>
	The mask member contains a bitlist specifying which of the other fields are valid. The flags are:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_MASK_STATE </td><td>The <b>state</b field is valid.</td></tr>
	<tr><td>wxLIST_MASK_TEXT </td><td>The <b>text</b field is valid.</td></tr>
	<tr><td>wxLIST_MASK_IMAGE </td><td>The <b>image</b field is valid.</td></tr>
	<tr><td>wxLIST_MASK_DATA </td><td>The <b>data</b field is valid.</td></tr>
	<tr><td>wxLIST_MASK_WIDTH </td><td>The <b>width</b field is valid.</td></tr>
	<tr><td>wxLIST_MASK_FORMAT </td><td>The <b>format</b field is valid.</td></tr>
	</table>
	</p>
	<p>
	The stateMask and state members take flags from the following:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_STATE_DONTCARE</td><td>Don't care what the state is. Win32 only.</td></tr>
	<tr><td>wxLIST_STATE_DROPHILITED</td><td>The item is highlighted to receive a drop event. Win32 only. </td></tr>
	<tr><td>wxLIST_STATE_FOCUSED</td><td>The item has the focus.</td></tr>
	<tr><td>wxLIST_STATE_SELECTED</td><td>The item is selected. </td></tr>
	<tr><td>wxLIST_STATE_CUT</td><td>The item is in the cut state. Win32 only.</td></tr>
	</table>
	The wxListItem object can also contain item-specific colour and font information: for this
	you need to call one of SetTextColour(), SetBackgroundColour() or SetFont() method on it
	passing it the colour/font to use. If the colour/font is not specified, the default list
	control colour/font is used.
	</p>
	End Rem
	Method SetItem:Int(item:wxListItem)
		Return bmx_wxlistctrl_setitem(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets a string or image at a given location. 
	End Rem
	Method SetStringItem:Int(item:Int, col:Int, label:String, imageId:Int = -1)
		Return bmx_wxlistctrl_setstringitem(wxObjectPtr, item, col, label, imageId)
	End Method
	
	Rem
	bbdoc: Sets the background colour for this item.
	about: This method only works in report view.
	<p>
	The colour can be retrieved using GetItemBackgroundColour.
	</p>
	End Rem
	Method SetItemBackgroundColour(item:Int, colour:wxColour)
		bmx_wxlistctrl_setitembackgroundcolour(wxObjectPtr, item, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method can only be used with virtual list controls.
	about: It is used to indicate to the control the number of items it contains. After calling it,
	the main program should be ready to handle calls to various item callbacks (such as OnGetItemText)
	for all items in the range from 0 to count.
	End Rem
	Method SetItemCount(count:Int)
		bmx_wxlistctrl_setitemcount(wxObjectPtr, count)
	End Method
	
	Rem
	bbdoc: Associates application-defined data with this item.
	End Rem
	Method SetItemData:Int(item:Int, data:Object)
		Return bmx_wxlistctrl_setitemdata(wxObjectPtr, item, data)
	End Method
	
	Rem
	bbdoc: Sets the item's font.
	End Rem
	Method SetItemFont(item:Int, font:wxFont)
		bmx_wxlistctrl_setitemfont(wxObjectPtr, item, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the image associated with the item.
	about: The image is an index into the image list associated with the list control. In report view,
	this only sets the image for the first column.
	End Rem
	Method SetItemImage:Int(item:Int, image:Int)
		Return bmx_wxlistctrl_setitemimage(wxObjectPtr, item, image)
	End Method
	
	Rem
	bbdoc: Sets the image associated with the item.
	about: In report view, you can specify the column. The image is an index into the image list
	associated with the list control.
	End Rem
	Method SetItemColumnImage:Int(item:Int, col:Int, image:Int)
		Return bmx_wxlistctrl_setitemcolumnimage(wxObjectPtr, item, col, image)
	End Method
	
	Rem
	bbdoc: Sets the position of the item, in icon or small icon view.
	about: Windows only.
	End Rem
	Method SetItemPosition:Int(item:Int, x:Int, y:Int)
		Return bmx_wxlistctrl_setitemposition(wxObjectPtr, item, x, y)
	End Method
	
	Rem
	bbdoc: Sets the item state.
	about: For a list of state flags, see wxListCtrl::SetItem.
	<p>
	The stateMask indicates which state flags are valid.
	</p>
	End Rem
	Method SetItemState:Int(item:Int, state:Int, stateMask:Int)
		Return bmx_wxlistctrl_setitemstate(wxObjectPtr, item, state, stateMask)
	End Method
	
	Rem
	bbdoc: Sets the item text for this item.
	End Rem
	Method SetItemText(item:Int, text:String)
		bmx_wxlistctrl_setitemtext(wxObjectPtr, item, text)
	End Method
	
	Rem
	bbdoc: Sets the colour for this item.
	about: This method only works in report view.
	<p>
	The colour can be retrieved using GetItemTextColour.
	</p>
	End Rem
	Method SetItemTextColour(item:Int, colour:wxColour)
		bmx_wxlistctrl_setitemtextcolour(wxObjectPtr, item, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds or removes a single window style.
	End Rem
	Method SetSingleStyle(style:Int, add:Int = True)
		bmx_wxlistctrl_setsinglestyle(wxObjectPtr, style, add)
	End Method
	
	Rem
	bbdoc: Sets the text colour of the list control.
	End Rem
	Method SetTextColour(colour:wxColour)
		bmx_wxlistctrl_settextcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the whole window style, deleting all items.
	End Rem
	Method SetWindowStyleFlag(style:Int)
		bmx_wxlistctrl_setwindowstyleflag(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SortItems:Int(compare:Int(item1:Object, item2:Object, data:Object), data:Object)
		callback = compare
		callbackData = data
		Return bmx_wxlistctrl_sortitems(wxObjectPtr)
	End Method
	
	Function _sortCallback:Int(item1:Object, item2:Object, data:Object)
		Return wxListCtrl(data).callback(item1, item2, wxListCtrl(data).callbackData)
	End Function
	
	Rem
	bbdoc: This method may be overloaded in the derived type for a control with wxLC_VIRTUAL style.
	about: It should return the attribute for the for the specified item or NULL to use the default
	appearance parameters.
	<p>
	wxListCtrl will not delete the pointer or keep a reference of it. You can return the same
	wxListItemAttr pointer for every OnGetItemAttr call.
	</p>
	<p>
	The base class version always returns Null.
	</p>
	End Rem
	Method OnGetItemAttr:wxListItemAttr(item:Int)
		Return Null
	End Method
	
	Function _OnGetItemAttr:Byte Ptr(obj:Object, item:Int)
		Local attr:wxListItemAttr = wxListCtrl(obj).OnGetItemAttr(item)
		If attr Then
			Return attr.wxItemAttrPtr
		Else
			Return Null
		End If
	End Function

	Rem
	bbdoc: This function <b>must</b> be overloaded in the derived type for a control with wxLC_VIRTUAL style.
	about: It should return the string containing the text of the given column for the specified item.
	End Rem
	Method OnGetItemText:String(item:Int, column:Int)
	End Method
	
	Function _OnGetItemText:String(obj:Object, item:Int, column:Int)
		Return wxListCtrl(obj).OnGetItemText(item, column)
	End Function
	
	Rem
	bbdoc: Overload this method in the derived type for a control with wxLC_VIRTUAL and wxLC_REPORT styles in order to specify the image index for the given line and column.
	about: The base type version always calls OnGetItemImage for the first column, else it returns -1.
	End Rem
	Method OnGetItemColumnImage:Int(item:Int, column:Int)
		Return -1
	End Method
	
	Function _OnGetItemColumnImage:Int(obj:Object, item:Int, column:Int)
		Return wxListCtrl(obj).OnGetItemColumnImage(item, column)
	End Function
	
	Rem
	bbdoc: This method must be overloaded in the derived class for a control with wxLC_VIRTUAL style having an image list (if the control doesn't have an image list, it is not necessary to overload it).
	about: It should return the index of the items image in the controls image list or -1 for no image. In a
	control with wxLC_REPORT style, OnGetItemImage only gets called for the first column of each line.
	<p>
	The base type version always returns -1.
	</p>
	End Rem
	Method OnGetItemImage:Int(item:Int)
		Return -1
	End Method

	Function _OnGetItemImage:Int(obj:Object, item:Int)
		Return wxListCtrl(obj).OnGetItemImage(item)
	End Function
	
End Type

Rem
bbdoc: This type stores information about a wxListCtrl item or column.
End Rem
Type wxListItem Extends wxObject

	Function _create:wxListItem(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxListItem = New wxListItem
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates a new wxListItem
	End Rem
	Function CreateListItem:wxListItem()
		Return New wxListItem.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxListItem
	End Rem
	Method Create:wxListItem()
		wxObjectPtr = bmx_wxlistitem_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Resets the item state to the default.
	End Rem
	Method Clear()
		bmx_wxlistitem_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the alignment for this item.
	about: Can be one of wxLIST_FORMAT_LEFT, wxLIST_FORMAT_RIGHT or wxLIST_FORMAT_CENTRE.
	End Rem
	Method GetAlign:Int()
		Return bmx_wxlistitem_getalign(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the item attributes, if any.
	End Rem
	Method GetAttributes:wxListItemAttr()
		Return wxListItemAttr._create(bmx_wxlistitem_getattributes(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the background colour for this item.
	End Rem
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxlistitem_getbackgroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the zero-based column; meaningful only in report mode.
	End Rem
	Method GetColumn:Int()
		Return bmx_wxlistitem_getcolumn(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns client data associated with the control.
	about: Please note that client data is associated with the item and not with subitems.
	End Rem
	Method GetData:Object()
		Return bmx_wxlistitem_getdata(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the font used to display the item.
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxlistitem_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the zero-based item position.
	End Rem
	Method GetId:Int()
		Return bmx_wxlistitem_getid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the zero-based index of the image associated with the item into the image list.
	End Rem
	Method GetImage:Int()
		Return bmx_wxlistitem_getimage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a bit mask indicating which fields of the structure are valid.
	about: Can be any combination of the following values:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_MASK_STATE </td><td>GetState is valid. </td></tr>
	<tr><td>wxLIST_MASK_TEXT </td><td>GetText is valid. </td></tr>
	<tr><td>wxLIST_MASK_IMAGE </td><td>GetImage is valid. </td></tr>
	<tr><td>wxLIST_MASK_DATA </td><td>GetData is valid. </td></tr>
	<tr><td>wxLIST_MASK_WIDTH </td><td>GetWidth is valid. </td></tr>
	<tr><td>wxLIST_MASK_FORMAT </td><td>GetFormat is valid. </td></tr>
	</table>
	End Rem
	Method GetMask:Int()
		Return bmx_wxlistitem_getmask(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxLIST_STATE_DONTCARE </td><td>Don't care what the state is. Win32 only.</td></tr>
	<tr><td>wxLIST_STATE_DROPHILITED </td><td>The item is highlighted to receive a drop event. Win32 only.</td></tr>
	<tr><td>wxLIST_STATE_FOCUSED </td><td>The item has the focus. </td></tr>
	<tr><td>wxLIST_STATE_SELECTED </td><td>The item is selected. </td></tr>
	<tr><td>wxLIST_STATE_CUT </td><td>The item is in the cut state. Win32 only.</td></tr>
	</table>
	End Rem
	Method GetState:Int()
		Return bmx_wxlistitem_getstate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the label/header text.
	End Rem
	Method GetText:String()
		Return bmx_wxlistitem_gettext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the text colour.
	End Rem
	Method GetTextColour:wxColour()
		Return wxColour._create(bmx_wxlistitem_gettextcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Meaningful only for column headers in report mode. Returns the column width.
	End Rem
	Method GetWidth:Int()
		Return bmx_wxlistitem_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the item has attributes.
	End Rem
	Method HasAttributes:Int()
		Return bmx_wxlistitem_hasattributes(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the alignment for the item.
	about: See also wxListItem::GetAlign
	End Rem
	Method SetAlign(align:Int)
		bmx_wxlistitem_setalign(wxObjectPtr, align)
	End Method
	
	Rem
	bbdoc: Sets the background colour for the item.
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxlistitem_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the zero-based column.
	about: Meaningful only in report mode.
	End Rem
	Method SetColumn(col:Int)
		bmx_wxlistitem_setcolumn(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: Sets client data for the item.
	about: Please note that client data is associated with the item and not with subitems.
	<p>
	Also note that this is only a reference to the data. You will need to manage that reference yourself,
	otherwise it may be garbage-collected.
	</p>
	End Rem
	Method SetData(data:Object)
		bmx_wxlistitem_setdata(wxObjectPtr, data)
	End Method
	
	Rem
	bbdoc: Sets the font for the item.
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxlistitem_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the zero-based item position.
	End Rem
	Method SetId(id:Int)
		bmx_wxlistitem_setid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Sets the zero-based index of the image associated with the item into the image list.
	End Rem
	Method SetImage(image:Int)
		bmx_wxlistitem_setimage(wxObjectPtr, image)
	End Method
	
	Rem
	bbdoc: Sets the mask of valid fields.
	about: See wxListItem::GetMask.
	End Rem
	Method SetMask(mask:Int)
		bmx_wxlistitem_setmask(wxObjectPtr, mask)
	End Method
	
	Rem
	bbdoc: Sets the item state flags (note that the valid state flags are influenced by the value of the state mask, see wxListItem::SetStateMask).
	about: See wxListItem::GetState for valid flag values.
	End Rem
	Method SetState(state:Int)
		bmx_wxlistitem_setstate(wxObjectPtr, state)
	End Method
	
	Rem
	bbdoc: Sets the bitmask that is used to determine which of the state flags are to be set.
	about: See also wxListItem::SetState.
	End Rem
	Method SetStateMask(stateMask:Int)
		bmx_wxlistitem_setstatemask(wxObjectPtr, stateMask)
	End Method
	
	Rem
	bbdoc: Sets the text label for the item.
	End Rem
	Method SetText(text:String)
		bmx_wxlistitem_settext(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Sets the text colour for the item.
	End Rem
	Method SetTextColour(colour:wxColour)
		bmx_wxlistitem_settextcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the column width.
	about: Meaningful only for column headers in report mode.
	End Rem
	Method SetWidth(width:Int)
		bmx_wxlistitem_setwidth(wxObjectPtr, width)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxlistitem_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Represents the attributes (color, font, ...) of a wxListCtrl wxListItem.
End Rem
Type wxListItemAttr

	Field wxItemAttrPtr:Byte Ptr
	
	Function _create:wxListItemAttr(wxItemAttrPtr:Byte Ptr)
		If wxItemAttrPtr Then
			Local this:wxListItemAttr = New wxListItemAttr
			this.wxItemAttrPtr = wxItemAttrPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Construct a wxListItemAttr with the optionally specified foreground and background colors and font.
	End Rem
	Function CreateItemAttr:wxListItemAttr(textCol:wxColour = Null, backCol:wxColour = Null, font:wxColour = Null)
		Return New wxListItemAttr.Create(textCol, backCol, font)
	End Function
	
	Rem
	bbdoc: Construct a wxListItemAttr with the optionally specified foreground and background colors and font.
	End Rem
	Method Create:wxListItemAttr(textCol:wxColour = Null, backCol:wxColour = Null, font:wxColour = Null)
		If textCol Then
			If backCol Then
				If font Then
					wxItemAttrPtr = bmx_wxlistitemattr_create(textCol.wxObjectPtr, backCol.wxObjectPtr, font.wxObjectPtr)
				Else
					wxItemAttrPtr = bmx_wxlistitemattr_create(textCol.wxObjectPtr, backCol.wxObjectPtr, Null)
				End If
			Else
				If font Then
					wxItemAttrPtr = bmx_wxlistitemattr_create(textCol.wxObjectPtr, Null, font.wxObjectPtr)
				Else
					wxItemAttrPtr = bmx_wxlistitemattr_create(textCol.wxObjectPtr, Null, Null)
				End If
			End If
		Else
			If backCol Then
				If font Then
					wxItemAttrPtr = bmx_wxlistitemattr_create(Null, backCol.wxObjectPtr, font.wxObjectPtr)
				Else
					wxItemAttrPtr = bmx_wxlistitemattr_create(Null, backCol.wxObjectPtr, Null)
				End If
			Else
				If font Then
					wxItemAttrPtr = bmx_wxlistitemattr_create(Null, Null, font.wxObjectPtr)
				Else
					wxItemAttrPtr = bmx_wxlistitemattr_create(Null, Null, Null)
				End If
			End If
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the currently set background color.
	End Rem
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxlistitemattr_getbackgroundcolour(wxItemAttrPtr))
	End Method
	
	Rem
	bbdoc: Returns the currently set font.
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxlistitemattr_getfont(wxItemAttrPtr))
	End Method
	
	Rem
	bbdoc: Returns the currently set text color.
	End Rem
	Method GetTextColour:wxColour()
		Return wxColour._create(bmx_wxlistitemattr_gettextcolour(wxItemAttrPtr))
	End Method
	
	Rem
	bbdoc: Returns true if the currently set background color is valid.
	End Rem
	Method HasBackgroundColour:Int()
		Return bmx_wxlistitemattr_hasbackgroundcolour(wxItemAttrPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the currently set font is valid.
	End Rem
	Method HasFont:Int()
		Return bmx_wxlistitemattr_hasfont(wxItemAttrPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the currently set text color is valid.
	End Rem
	Method HasTextColour:Int()
		Return bmx_wxlistitemattr_hastextcolour(wxItemAttrPtr)
	End Method
	
	Rem
	bbdoc: Sets a new background colour.
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxlistitemattr_setbackgroundcolour(wxItemAttrPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets a new font.
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxlistitemattr_setfont(wxItemAttrPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets a new text colour.
	End Rem
	Method SetTextColour(colour:wxColour)
		bmx_wxlistitemattr_settextcolour(wxItemAttrPtr, colour.wxObjectPtr)
	End Method
	
	Method Delete()
		If wxItemAttrPtr Then
			bmx_wxlistitemattr_delete(wxItemAttrPtr)
			wxItemAttrPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: A list event holds information about events associated with wxListCtrl objects.
End Rem
Type wxListEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxListEvent = New wxListEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: For wxEVT_COMMAND_LIST_CACHE_HINT event only: returns the first item which the list control advises us to cache.
	End Rem
	Method GetCacheFrom:Int()
		Return bmx_wxlistevent_getcachefrom(wxEventPtr)
	End Method
	
	Rem
	bbdoc: For wxEVT_COMMAND_LIST_CACHE_HINT event only: returns the last item (inclusive) which the list control advises us to cache.
	End Rem
	Method GetCacheTo:Int()
		Return bmx_wxlistevent_getcacheto(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Key code if the event is a keypress event.
	End Rem
	Method GetKeyCode:Int()
		Return bmx_wxlistevent_getkeycode(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The item index.
	End Rem
	Method GetIndex:Int()
		Return bmx_wxlistevent_getindex(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The column position: it is only used with COL events.
	about: For the column dragging events, it is the column to the left of the divider being dragged, for the
	column click events it may be -1 if the user clicked in the list control header outside any column.
	End Rem
	Method GetColumn:Int()
		Return bmx_wxlistevent_getcolumn(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The position of the mouse pointer if the event is a drag event.
	End Rem
	Method GetPoint(x:Int Var, y:Int Var)
		bmx_wxlistevent_getpoint(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: The (new) item label for wxEVT_COMMAND_LIST_END_LABEL_EDIT event.
	End Rem
	Method GetLabel:String()
		Return bmx_wxlistevent_getlabel(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The text.
	End Rem
	Method GetText:String()
		Return bmx_wxlistevent_gettext(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The image.
	End Rem
	Method GetImage:Int()
		Return bmx_wxlistevent_getimage(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The data.
	End Rem
	Method GetData:Int()
		Return bmx_wxlistevent_getdata(wxEventPtr)
	End Method
	
	Rem
	bbdoc: The mask.
	End Rem
	Method GetMask:Int()
		Return bmx_wxlistevent_getmask(wxEventPtr)
	End Method
	
	Rem
	bbdoc: An item object, used by some events.
	about: See also wxListCtrl::SetItem.
	End Rem
	Method GetItem:wxListItem()
		Return wxListItem._create(bmx_wxlistevent_getitem(wxEventPtr))
	End Method
	
	Rem
	bbdoc: This method only makes sense for wxEVT_COMMAND_LIST_END_LABEL_EDIT message and returns true if it the label editing has been cancelled by the user (GetLabel returns an empty string in this case but it doesn't allow the application to distinguish between really cancelling the edit and the admittedly rare case when the user wants to rename it to an empty string).
	End Rem
	Method IsEditCancelled:Int()
		Return bmx_wxlistevent_iseditcancelled(wxEventPtr)
	End Method
	
End Type

Type TListEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_LIST_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_RDRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_END_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_DELETE_ITEM, ..
					wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, ..
					wxEVT_COMMAND_LIST_ITEM_SELECTED, ..
					wxEVT_COMMAND_LIST_ITEM_DESELECTED, ..
					wxEVT_COMMAND_LIST_KEY_DOWN, ..
					wxEVT_COMMAND_LIST_INSERT_ITEM, ..
					wxEVT_COMMAND_LIST_COL_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_LIST_CACHE_HINT, ..
					wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_COL_DRAGGING, ..
					wxEVT_COMMAND_LIST_COL_END_DRAG, ..
					wxEVT_COMMAND_LIST_ITEM_FOCUSED
				Return wxListEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_LIST_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_RDRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_END_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_DELETE_ITEM, ..
					wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, ..
					wxEVT_COMMAND_LIST_ITEM_SELECTED, ..
					wxEVT_COMMAND_LIST_ITEM_DESELECTED, ..
					wxEVT_COMMAND_LIST_KEY_DOWN, ..
					wxEVT_COMMAND_LIST_INSERT_ITEM, ..
					wxEVT_COMMAND_LIST_COL_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_LIST_CACHE_HINT, ..
					wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_COL_DRAGGING, ..
					wxEVT_COMMAND_LIST_COL_END_DRAG, ..
					wxEVT_COMMAND_LIST_ITEM_FOCUSED
				Return bmx_wxlistctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TListEventFactory

Type TListCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxlistctrl_addresourcehandler()
	End Method
		
End Type

New TListCtrlResourceFactory
