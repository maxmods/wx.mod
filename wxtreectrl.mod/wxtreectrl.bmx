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
bbdoc: wxTreeCtrl
End Rem
Module wx.wxTreeCtrl

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
bbdoc: A tree control presents information as a hierarchy, with items that may be expanded to show further items.
about: Items in a tree control are referenced by wxTreeItemId handles, which may be tested for
validity by calling wxTreeItemId::IsOk.
End Rem
Type wxTreeCtrl Extends wxControl

	Field wxTreeItemIdValuePtr:Byte Ptr

	Rem
	bbdoc: Constructor, creating and showing a tree control.
	End Rem
	Function CreateTreeCtrl:wxTreeCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTR_HAS_BUTTONS)
			
		Return New wxTreeCtrl.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateTreeCtrl.
	End Rem
	Method Create:wxTreeCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTR_HAS_BUTTONS)
			
		wxObjectPtr = bmx_wxtreectrl_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		Return Self
	End Method

	Rem
	bbdoc: Adds the root node to the tree, returning the new item.
	about: The image and selImage parameters are an index within the normal image list specifying
	the image to use for unselected and selected items, respectively. If image > -1 and selImage
	is -1, the same image is used for both selected and unselected items.
	End Rem
	Method AddRoot:wxTreeItemId(text:String, image:Int = -1, selImage:Int = -1, data:Object = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_addroot(wxObjectPtr, text, image, selImage, data))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_addroot(wxObjectPtr, text, image, selImage, Null))
		End If
	End Method
	
	Rem
	bbdoc: Appends an item to the end of the branch identified by parent, return a new item id.
	about: The image and selImage parameters are an index within the normal image list specifying the
	image to use for unselected and selected items, respectively. If image > -1 and selImage is -1,
	the same image is used for both selected and unselected items.
	End Rem
	Method AppendItem:wxTreeItemId(parent:wxTreeItemId, text:String, image:Int = -1, selImage:Int = -1, data:Object = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_appenditem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, data))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_appenditem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, Null))
		End If
	End Method
	
	Rem
	bbdoc: Sets the buttons image list.
	about: The button images assigned with this method will be automatically deleted by wxTreeCtrl as
	appropriate (i.e. it takes ownership of the list).
	<p>
	Setting or assigning the button image list enables the display of image buttons. Once enabled, 
	the only way to disable the display of button images is to set the button image list to Null.
	</p>
	<p>
	This method is only available in the generic version.
	</p>
	End Rem
	Method AssignButtonsImageList(imageList:wxImageList)
		bmx_wxtreectrl_assignbuttonsimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the state image list.
	about: Image list assigned with this method will be automatically deleted by wxTreeCtrl
	as appropriate (i.e. it takes ownership of the list).
	End Rem
	Method AssignImageList(imageList:wxImageList)
		bmx_wxtreectrl_assignimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the state image list.
	about: Image list assigned with this method will be automatically deleted by wxTreeCtrl as
	appropriate (i.e. it takes ownership of the list).
	End Rem
	Method AssignStateImageList(imageList:wxImageList)
		bmx_wxtreectrl_assignstateimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Collapses the given item.
	End Rem
	Method Collapse(item:wxTreeItemId)
		bmx_wxtreectrl_collapse(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Collapses the root item.
	End Rem
	Method CollapseAll()
		bmx_wxtreectrl_collapseall(wxObjectPtr)
	End Method

	Rem
	bbdoc: Collapses this item and all of its children, recursively.
	End Rem
	Method CollapseAllChildren(item:wxTreeItemId)
		bmx_wxtreectrl_collapseallchildren(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Collapses the given item and removes all children.
	End Rem
	Method CollapseAndReset(item:wxTreeItemId)
		bmx_wxtreectrl_collapseandreset(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Deletes the specified item.
	about: An wxEVT_TREE_DELETE_ITEM event will be generated.
	<p>
	This method may cause a subsequent call to GetNextChild to fail.
	</p>
	End Rem
	Method DeleteItem(item:wxTreeItemId)
		bmx_wxtreectrl_deleteitem(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Deletes all items in the control.
	about: Note that this may not generate EVT_TREE_DELETE_ITEM events under some Windows versions
	although normally such event is generated for each removed item.
	End Rem
	Method DeleteAllItems()
		bmx_wxtreectrl_deleteallitems(wxObjectPtr)
	End Method

	Rem
	bbdoc: Deletes all children of the given item (but not the item itself).
	about: Note that this will not generate any events unlike DeleteItem method.
	<p>
	If you have called wxTreeCtrl::SetItemHasChildren, you may need to call it again since
	DeleteChildren does not automatically clear the setting.
	</p>
	End Rem
	Method DeleteChildren(item:wxTreeItemId)
		bmx_wxtreectrl_deletechildren(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Starts editing the label of the given item.
	about: This method generates an EVT_TREE_BEGIN_LABEL_EDIT event which can be vetoed so that no text
	control will appear for in-place editing.
	<p>
	If the user changed the label (i.e. s/he does not press ESC or leave the text control without
	changes, an EVT_TREE_END_LABEL_EDIT event will be sent which can be vetoed as well.
	</p>
	End Rem
	Method EditLabel(item:wxTreeItemId)
		bmx_wxtreectrl_editlabel(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Ends label editing.
	about: If @cancelEdit is true, the edit will be cancelled.
	<p>
	This method is currently supported under Windows only.
	</p>
	End Rem
	Method EndEditLabel(cancelEdit:Int)
		bmx_wxtreectrl_endeditlabel(wxObjectPtr, cancelEdit)
	End Method

	Rem
	bbdoc: Scrolls and/or expands items to ensure that the given item is visible.
	End Rem
	Method EnsureVisible(item:wxTreeItemId)
		bmx_wxtreectrl_ensurevisible(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Expands the given item.
	End Rem
	Method Expand(item:wxTreeItemId)
		bmx_wxtreectrl_expand(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Expands all items in the tree.
	End Rem
	Method ExpandAll()
		bmx_wxtreectrl_expandall(wxObjectPtr)
	End Method

	Rem
	bbdoc: Expands the given item and all its children recursively
	End Rem
	Method ExpandAllChildren(item:wxTreeItemId)
		bmx_wxtreectrl_expandallchildren(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Retrieves the rectangle bounding the item.
	about: If textOnly is true, only the rectangle around the item's label will be returned, otherwise the
	item's image is also taken into account.
	<p>
	The return value is true if the rectangle was successfully retrieved or false if it was not (in this
	case rect is not changed) -- for example, if the item is currently invisible.
	</p>
	<p>
	Notice that the rectangle coordinates are logical, not physical ones. So, for example, the x
	coordinate may be negative if the tree has a horizontal scrollbar and its position is not 0.
	</p>
	End Rem
	Method GetBoundingRect:Int(item:wxTreeItemId, x:Int Var, y:Int Var, w:Int Var, h:Int Var, textOnly:Int = False)
		Return bmx_wxtreectrl_getboundingrect(wxObjectPtr, item.wxTreeItemIdPtr, Varptr x, Varptr y, Varptr w, Varptr h, textOnly)
	End Method

	Rem
	bbdoc: Returns the buttons image list (from which application-defined button images are taken).
	about: This method is only available in the generic version.
	End Rem
	Method GetButtonsImageList:wxImageList()
		' todo
		' bmx_wxtreectrl_getbuttonsimagelist(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the number of items in the branch.
	about: If recursively is true, returns the total number of descendants, otherwise only one level of
	children is counted.
	End Rem
	Method GetChildrenCount:Int(item:wxTreeItemId, recursively:Int = True)
		Return bmx_wxtreectrl_getchildrencount(wxObjectPtr, item.wxTreeItemIdPtr, recursively)
	End Method

	Rem
	bbdoc: Returns the number of items in the control.
	End Rem
	Method GetCount:Int()
		Return bmx_wxtreectrl_getcount(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the edit control being currently used to edit a label.
	about: Returns Null if no label is being edited.
	<p>
	NB: It is currently only implemented for wxMSW.
	</p>
	End Rem
	Method GetEditControl:wxTextCtrl()
		Return wxTextCtrl._create(bmx_wxtreectrl_geteditcontrol(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the first child
	about: Call wxTreeCtrl::GetNextChild for the next child.
	<p>
	Returns an invalid tree item (i.e. IsOk() returns False) if there are no further children.
	</p>
	End Rem
	Method GetFirstChild:wxTreeItemId(item:wxTreeItemId)
		If Not wxTreeItemIdValuePtr Then
			wxTreeItemIdValuePtr = bmx_wxtreeitemidvalue_create()
		End If
		
		Return wxTreeItemId._create(bmx_wxtreectrl_getfirstchild(wxObjectPtr, item.wxTreeItemIdPtr, wxTreeItemIdValuePtr))
	End Method

	Rem
	bbdoc: Returns the first visible item.
	End Rem
	Method GetFirstVisibleItem:wxTreeItemId()
		Return wxTreeItemId._create(bmx_wxtreectrl_getfirstvisibleitem(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the normal image list.
	End Rem
	Method GetImageList:wxImageList()
	End Method

	Rem
	bbdoc: Returns the current tree control indentation.
	End Rem
	Method GetIndent:Int()
		Return bmx_wxtreectrl_getindent(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the background colour of the item.
	End Rem
	Method GetItemBackgroundColour:wxColour(item:wxTreeItemId)
		Return wxColour._create(bmx_wxtreectrl_getitembackgroundcolour(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the tree item data associated with the item.
	End Rem
	Method GetItemData:Object(item:wxTreeItemId)
		Return bmx_wxtreectrl_getitemdata(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns the font of the item label.
	End Rem
	Method GetItemFont:wxFont(item:wxTreeItemId)
		Return wxFont._create(bmx_wxtreectrl_getitemfont(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Gets the specified item image.
	about: The value of which may be:
	<ul>
	<li>wxTreeItemIcon_Normal to get the normal item image</li>
	<li>wxTreeItemIcon_Selected to get the selected item image (i.e. the image which is shown when the
	item is currently selected) </li>
	<li>wxTreeItemIcon_Expanded to get the expanded image (this only makes sense for items which have
	children - then this image is shown when the item is expanded and the normal image is shown when
	it is collapsed) </li>
	<li>wxTreeItemIcon_SelectedExpanded to get the selected expanded image (which is shown when an
	expanded item is currently selected) </li>
	</ul>
	End Rem
	Method GetItemImage:Int(item:wxTreeItemId, which:Int = wxTreeItemIcon_Normal)
		Return bmx_wxtreectrl_getitemimage(wxObjectPtr, item.wxTreeItemIdPtr, which)
	End Method

	Rem
	bbdoc: Returns the item label.
	End Rem
	Method GetItemText:String(item:wxTreeItemId)
		Return bmx_wxtreectrl_getitemtext(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns the colour of the item label.
	End Rem
	Method GetItemTextColour:wxColour(item:wxTreeItemId)
		Return wxColour._create(bmx_wxtreectrl_getitemtextcolour(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the last child of the item (or an invalid tree item if this item has no children).
	End Rem
	Method GetLastChild:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getlastchild(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the next child.
	about: Call wxTreeCtrl::GetFirstChild for the first child.
	<p>
	Returns an invalid tree item if there are no further children.
	</p>
	End Rem
	Method GetNextChild:wxTreeItemId(item:wxTreeItemId)
		If Not wxTreeItemIdValuePtr Then
			wxTreeItemIdValuePtr = bmx_wxtreeitemidvalue_create()
		End If
		
		Return wxTreeItemId._create(bmx_wxtreectrl_getnextchild(wxObjectPtr, item.wxTreeItemIdPtr, wxTreeItemIdValuePtr))
	End Method

	Rem
	bbdoc: Returns the next sibling of the specified item.
	about: Call wxTreeCtrl::GetPrevSibling for the previous sibling.
	<p>
	Returns an invalid tree item if there are no further siblings.
	</p>
	End Rem
	Method GetNextSibling:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getnextsibling(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the next visible item.
	End Rem
	Method GetNextVisible:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getnextvisible(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the item's parent.
	End Rem
	Method GetItemParent:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getitemparent(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the previous sibling of the specified item
	about: Call wxTreeCtrl::GetNextSibling for the next sibling.
	<p>
	Returns an invalid tree item if there are no further children.
	</p>
	End Rem
	Method GetPrevSibling:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getprevsibling(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns the previous visible item.
	End Rem
	Method GetPrevVisible:wxTreeItemId(item:wxTreeItemId)
		Return wxTreeItemId._create(bmx_wxtreectrl_getprevvisible(wxObjectPtr, item.wxTreeItemIdPtr))
	End Method

	Rem
	bbdoc: Returns true if the control will use a quick calculation for the best size, looking only at the first and last items.
	about: The default is false.
	End Rem
	Method GetQuickBestSize:Int()
		Return bmx_wxtreectrl_getquickbestsize(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the root item for the tree control.
	End Rem
	Method GetRootItem:wxTreeItemId()
		Return wxTreeItemId._create(bmx_wxtreectrl_getrootitem(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the selection, or an invalid item if there is no selection.
	about: This method only works with the controls without wxTR_MULTIPLE style, use GetSelections for
	the controls which do have this style.
	End Rem
	Method GetSelection:wxTreeItemId()
		Return wxTreeItemId._create(bmx_wxtreectrl_getselection(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns an array of tree items of the currently selected items.
	about: This method can be called only if the control has the wxTR_MULTIPLE style.
	End Rem
	Method GetSelections:wxTreeItemId[]()
	End Method

	Rem
	bbdoc: Returns the state image list (from which application-defined state images are taken).
	End Rem
	Method GetStateImageList:wxImageList()
	End Method

	Rem
	bbdoc: Calculates which (if any) item is under the given point, returning the tree item id at this point plus extra information @flags.
	End Rem
	Method HitTest:wxTreeItemId(x:Int, y:Int, flags:Int Var)
		Return wxTreeItemId._create(bmx_wxtreectrl_hittest(wxObjectPtr, x, y, Varptr flags))
	End Method

	Rem
	bbdoc: Inserts an item after a given one (@previous).
	about: The image and selImage parameters are an index within the normal image list specifying the image to use for
	unselected and selected items, respectively. If image &gt; -1 and selImage is -1, the same image is used
	for both selected and unselected items.
	End Rem
	Method InsertItem:wxTreeItemId(parent:wxTreeItemId, previous:wxTreeItemId, text:String, image:Int = -1, selImage:Int = -1, data:Object = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_insertitem(wxObjectPtr, parent.wxTreeItemIdPtr, previous.wxTreeItemIdPtr, text, image, selImage, data))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_insertitem(wxObjectPtr, parent.wxTreeItemIdPtr, previous.wxTreeItemIdPtr, text, image, selImage, Null))
		End If
	End Method

	Rem
	bbdoc: Inserts an item before one identified by its position (@before).
	about: @before must be less than the number of children.
	<p>		
	The image and selImage parameters are an index within the normal image list specifying the image to use for
	unselected and selected items, respectively. If image &gt; -1 and selImage is -1, the same image is used
	for both selected and unselected items.
	</p>
	End Rem
	Method InsertItemBefore:wxTreeItemId(parent:wxTreeItemId, before:Int, text:String, image:Int = -1, selImage:Int = -1, data:Object = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_insertitembefore(wxObjectPtr, parent.wxTreeItemIdPtr, before, text, image, selImage, data))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_insertitembefore(wxObjectPtr, parent.wxTreeItemIdPtr, before, text, image, selImage, Null))
		End If
	End Method

	Rem
	bbdoc: Returns true if the given item is in bold state.
	End Rem
	Method IsBold:Int(item:wxTreeItemId)
		Return bmx_wxtreectrl_isbold(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns true if the control is empty (i.e. has no items, even no root one).
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxtreectrl_isempty(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the item is expanded (only makes sense if it has children).
	End Rem
	Method IsExpanded:Int(item:wxTreeItemId)
		Return bmx_wxtreectrl_isexpanded(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns true if the item is selected.
	End Rem
	Method IsSelected:Int(item:wxTreeItemId)
		Return bmx_wxtreectrl_isselected(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns true if the item is visible (it might be outside the view, or not expanded).
	End Rem
	Method IsVisible:Int(item:wxTreeItemId)
		Return bmx_wxtreectrl_isvisible(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns true if the item has children.
	End Rem
	Method ItemHasChildren:Int(item:wxTreeItemId)
		Return bmx_wxtreectrl_itemhaschildren(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Override this method in the derived type to change the sort order of the items in the tree control.
	about: The method should return a negative, zero or positive value if the first item is less than, equal
	to or greater than the second one.
	End Rem
	Method OnCompareItems:Int(item1:wxTreeItemId, item2:wxTreeItemId)
		Return 0
	End Method
	
	' internal callback
	Function _OnCompareItems:Int(obj:Object, item1:Byte Ptr, item2:Byte Ptr)
		Return wxTreeCtrl(obj).OnCompareItems(wxTreeItemId._create(item1), wxTreeItemId._create(item2))
	End Function

	Rem
	bbdoc: Appends an item as the first child of parent, return a new item id.
	about: The image and selImage parameters are an index within the normal image list specifying the
	image to use for unselected and selected items, respectively. If image &gt; -1 and selImage is -1, the
	same image is used for both selected and unselected items.
	End Rem
	Method PrependItem:wxTreeItemId(parent:wxTreeItemId, text:String, image:Int = -1, selImage:Int = -1, data:Object = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_prependitem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, data))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_prependitem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, Null))
		End If
	End Method

	Rem
	bbdoc: Scrolls the specified item into view.
	End Rem
	Method ScrollTo(item:wxTreeItemId)
		bmx_wxtreectrl_scrollto(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Selects the given item.
	about: In multiple selection controls, can be also used to deselect a currently selected item if
	the value of @selected is false.
	End Rem
	Method SelectItem(item:wxTreeItemId, selected:Int = True)
		bmx_wxtreectrl_selectitem(wxObjectPtr, item.wxTreeItemIdPtr, selected)
	End Method

	Rem
	bbdoc: Sets the buttons image list (from which application-defined button images are taken).
	about: The button images assigned with this method will not be deleted by wxTreeCtrl's destructor,
	you must delete it yourself.
	<p>
	Setting or assigning the button image list enables the display of image buttons. Once enabled, the only way to disable the display of button images is to set the button image list to NULL.
	</p>
	<p>
	This method is only available in the generic version.
	</p>
	End Rem
	Method SetButtonsImageList(imageList:wxImageList)
		bmx_wxtreectrl_setbuttonsimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the indentation for the tree control.
	End Rem
	Method SetIndent(indent:Int)
		bmx_wxtreectrl_setindent(wxObjectPtr, indent)
	End Method

	Rem
	bbdoc: Sets the normal image list.
	about: Image list assigned with this method will not be deleted by wxTreeCtrl's destructor, you must
	delete it yourself.
	End Rem
	Method SetImageList(imageList:wxImageList)
		bmx_wxtreectrl_setimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the colour of the item's background.
	End Rem
	Method SetItemBackgroundColour(item:wxTreeItemId, colour:wxColour)
		bmx_wxtreectrl_setitembackgroundcolour(wxObjectPtr, item.wxTreeItemIdPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Makes item appear in bold font if bold parameter is true or resets it to the normal state.
	End Rem
	Method SetItemBold(item:wxTreeItemId, bold:Int = True)
		bmx_wxtreectrl_setitembold(wxObjectPtr, item.wxTreeItemIdPtr, bold)
	End Method

	Rem
	bbdoc: Sets the item client data.
	End Rem
	Method SetItemData(item:wxTreeItemId, data:Object)
		bmx_wxtreectrl_setitemdata(wxObjectPtr, item.wxTreeItemIdPtr, data)
	End Method

	Rem
	bbdoc: Gives the item the visual feedback for Drag'n'Drop actions, which is useful if something is dragged from the outside onto the tree control (as opposed to a DnD operation within the tree control, which already is implemented internally).
	End Rem
	Method SetItemDropHighlight(item:wxTreeItemId, highlight:Int = True)
		bmx_wxtreectrl_setitemdrophighlight(wxObjectPtr, item.wxTreeItemIdPtr, highlight)
	End Method

	Rem
	bbdoc: Sets the item's font.
	about: All items in the tree should have the same height to avoid text clipping, so the fonts height
	should be the same for all of them, although font attributes may vary.
	End Rem
	Method SetItemFont(item:wxTreeItemId, font:wxFont)
		bmx_wxtreectrl_setitemfont(wxObjectPtr, item.wxTreeItemIdPtr, font.wxObjectPtr)
	End Method

	Rem
	bbdoc: Force appearance of the button next to the item.
	about: This is useful to allow the user to expand the items which don't have any children now, but
	instead adding them only when needed, thus minimizing memory usage and loading time.
	End Rem
	Method SetItemHasChildren(item:wxTreeItemId, hasChildren:Int = True)
		bmx_wxtreectrl_setitemhaschildren(wxObjectPtr, item.wxTreeItemIdPtr, hasChildren)
	End Method

	Rem
	bbdoc: Sets the specified item image.
	about: See GetItemImage for the description of the which parameter.
	End Rem
	Method SetItemImage(item:wxTreeItemId, image:Int, which:Int = wxTreeItemIcon_Normal)
		bmx_wxtreectrl_setitemimage(wxObjectPtr, item.wxTreeItemIdPtr, image, which)
	End Method

	Rem
	bbdoc: Sets the item label.
	End Rem
	Method SetItemText(item:wxTreeItemId, text:String)
		bmx_wxtreectrl_setitemtext(wxObjectPtr, item.wxTreeItemIdPtr, text)
	End Method

	Rem
	bbdoc: Sets the colour of the item's text.
	End Rem
	Method SetItemTextColour(item:wxTreeItemId, colour:wxColour)
		bmx_wxtreectrl_setitemtextcolour(wxObjectPtr, item.wxTreeItemIdPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: If true is passed, specifies that the control will use a quick calculation for the best size, looking only at the first and last items.
	about: Otherwise, it will look at all items. The default is False.
	End Rem
	Method SetQuickBestSize(quickBestSize:Int)
		bmx_wxtreectrl_setquickbestsize(wxObjectPtr, quickBestSize)
	End Method

	Rem
	bbdoc: Sets the state image list (from which application-defined state images are taken).
	about: Image list assigned with this method will not be deleted by wxTreeCtrl's destructor, you
	must delete it yourself.
	End Rem
	Method SetStateImageList(imageList:wxImageList)
		bmx_wxtreectrl_setstateimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the mode flags associated with the display of the tree control.
	about: The new mode takes effect immediately. (Generic only; MSW ignores changes.)
	End Rem
	Method SetWindowStyle(style:Int)
		bmx_wxtreectrl_setwindowstyle(wxObjectPtr, style)
	End Method

	Rem
	bbdoc: Sorts the children of the given item using OnCompareItems method of wxTreeCtrl.
	about: You should override that method to change the sort order (the default is ascending case-sensitive
	alphabetical order).
	End Rem
	Method SortChildren(item:wxTreeItemId)
		bmx_wxtreectrl_sortchildren(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Toggles the given item between collapsed and expanded states.
	End Rem
	Method Toggle(item:wxTreeItemId)
		bmx_wxtreectrl_toggle(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Toggles the given item between selected and unselected states. For multiselection controls only.
	End Rem
	Method ToggleItemSelection(item:wxTreeItemId)
		bmx_wxtreectrl_toggleitemselection(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Removes the selection from the currently selected item (if any).
	End Rem
	Method Unselect()
		bmx_wxtreectrl_unselect(wxObjectPtr)
	End Method

	Rem
	bbdoc: This method either behaves the same as Unselect if the control doesn't have wxTR_MULTIPLE style, or removes the selection from all items if it does have this style.
	End Rem
	Method UnselectAll()
		bmx_wxtreectrl_unselectall(wxObjectPtr)
	End Method

	Rem
	bbdoc: Unselects the given item.
	about: This works in multiselection controls only.
	End Rem
	Method UnselectItem(item:wxTreeItemId)
		bmx_wxtreectrl_unselectitem(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Method Delete()
		If wxTreeItemIdValuePtr Then
			bmx_wxtreeitemidvalue_delete(wxTreeItemIdValuePtr)
			wxTreeItemIdValuePtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: An opaque reference to a tree item.
End Rem
Type wxTreeItemId

	Field wxTreeItemIdPtr:Byte Ptr
	
	Function _create:wxTreeItemId(wxTreeItemIdPtr:Byte Ptr)
		Local this:wxTreeItemId = New wxTreeItemId
		
		this.wxTreeItemIdPtr = wxTreeItemIdPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns True if this instance is referencing a valid tree item.
	End Rem
	Method IsOk:Int()
		Return bmx_wxtreeitemid_isok(wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: Returns True if this instance is equal to @treeItem
	End Rem
	Method Equals:Int(treeItem:wxTreeItemId)
		Return bmx_wxtreeitemid_equals(wxTreeItemIdPtr, treeItem.wxTreeItemIdPtr)
	End Method
	
	Method Delete()
		If wxTreeItemIdPtr Then
			bmx_wxtreeitemid_delete(wxTreeItemIdPtr)
			wxTreeItemIdPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: 

Type wxTreeItemData

	Field wxTreeItemDataPtr:Byte Ptr
	
	Function _create:wxTreeItemData(wxTreeItemDataPtr:Byte Ptr)
		Local this:wxTreeItemData = New wxTreeItemData
	
		this.wxTreeItemDataPtr = wxTreeItemDataPtr
		
		Return this
	End Function

	Rem
	bbdoc: 
	'End Rem
	Function Create:wxTreeItemData(data:Object = Null)
		Local this:wxTreeItemData = New wxTreeItemData
		
		'this.wxTreeItemDataPtr = bmx_wxtreeitemdata_create(this, data)
		
		Return this
	End Function

	Rem
	bbdoc: 
	'End Rem
	Method GetData:Object()
		'Return bmx_wxtreeitemdata_getdata(wxTreeItemDataPtr)
	End Method
	
	Rem
	bbdoc: Returns the item associated with this node.
	'End Rem
	Method GetId:wxTreeItemId()
		'Return wxTreeItemId._create(bmx_wxtreeitemdata_getid(wxTreeItemDataPtr))
	End Method
	
	Rem
	bbdoc: 
	'End Rem
	Method SetData(data:Object)
		'bmx_wxtreeitemdata_setdata(wxTreeItemDataPtr, data)
	End Method
	
	Rem
	bbdoc: Sets the item associated with this node.
	'End Rem
	Method SetId(id:wxTreeItemId)
		'bmx_wxtreeitemdata_setid(wxTreeItemId.wxTreeItemIdPtr)
	End Method
	
End Type
End Rem

Rem
bbdoc: A tree event holds information about events associated with wxTreeCtrl objects.
End Rem
Type wxTreeEvent Extends wxNotifyEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxTreeEvent = New wxTreeEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type


Type TTreeEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TREE_BEGIN_DRAG, ..
					wxEVT_COMMAND_TREE_BEGIN_RDRAG, ..
					wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_TREE_END_LABEL_EDIT, ..
					wxEVT_COMMAND_TREE_DELETE_ITEM, ..
					wxEVT_COMMAND_TREE_GET_INFO, ..
					wxEVT_COMMAND_TREE_SET_INFO, ..
					wxEVT_COMMAND_TREE_ITEM_EXPANDED, ..
					wxEVT_COMMAND_TREE_ITEM_EXPANDING, ..
					wxEVT_COMMAND_TREE_ITEM_COLLAPSED, ..
					wxEVT_COMMAND_TREE_ITEM_COLLAPSING, ..
					wxEVT_COMMAND_TREE_SEL_CHANGED, ..
					wxEVT_COMMAND_TREE_SEL_CHANGING, ..
					wxEVT_COMMAND_TREE_KEY_DOWN, ..
					wxEVT_COMMAND_TREE_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_TREE_END_DRAG, ..
					wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK, ..
					wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP, ..
					wxEVT_COMMAND_TREE_ITEM_MENU
			
				Return wxTreeEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TREE_BEGIN_DRAG, ..
					wxEVT_COMMAND_TREE_BEGIN_RDRAG, ..
					wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_TREE_END_LABEL_EDIT, ..
					wxEVT_COMMAND_TREE_DELETE_ITEM, ..
					wxEVT_COMMAND_TREE_GET_INFO, ..
					wxEVT_COMMAND_TREE_SET_INFO, ..
					wxEVT_COMMAND_TREE_ITEM_EXPANDED, ..
					wxEVT_COMMAND_TREE_ITEM_EXPANDING, ..
					wxEVT_COMMAND_TREE_ITEM_COLLAPSED, ..
					wxEVT_COMMAND_TREE_ITEM_COLLAPSING, ..
					wxEVT_COMMAND_TREE_SEL_CHANGED, ..
					wxEVT_COMMAND_TREE_SEL_CHANGING, ..
					wxEVT_COMMAND_TREE_KEY_DOWN, ..
					wxEVT_COMMAND_TREE_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_TREE_END_DRAG, ..
					wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK, ..
					wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP, ..
					wxEVT_COMMAND_TREE_ITEM_MENU
				Return bmx_wxtreectrl_geteventtype(eventType)
		End Select
	End Method
	
End Type

New TTreeEventFactory


