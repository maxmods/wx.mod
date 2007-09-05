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
ModuleInfo "License:"
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
	Method AddRoot:wxTreeItemId(text:String, image:Int = -1, selImage:Int = -1, data:wxTreeItemData = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_addroot(wxObjectPtr, text, image, selImage, data.wxTreeItemDataPtr))
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
	Method AppendItem:wxTreeItemId(parent:wxTreeItemId, text:String, image:Int = -1, selImage:Int = -1, data:wxTreeItemData = Null)
		If data Then
			Return wxTreeItemId._create(bmx_wxtreectrl_appenditem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, data.wxTreeItemDataPtr))
		Else
			Return wxTreeItemId._create(bmx_wxtreectrl_appenditem(wxObjectPtr, parent.wxTreeItemIdPtr, text, image, selImage, Null))
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AssignButtonsImageList()
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
	bbdoc: 
	End Rem
	Method AssignStateImageList()
	End Method

	Rem
	bbdoc: Collapses the given item.
	End Rem
	Method Collapse(item:wxTreeItemId)
	End Method

	Rem
	bbdoc: Collapses the root item.
	End Rem
	Method CollapseAll()
	End Method

	Rem
	bbdoc: Collapses this item and all of its children, recursively.
	End Rem
	Method CollapseAllChildren(item:wxTreeItemId)
	End Method

	Rem
	bbdoc: Collapses the given item and removes all children.
	End Rem
	Method CollapseAndReset(item:wxTreeItemId)
	End Method

	Rem
	bbdoc: Deletes the specified item.
	about: An EVT_TREE_DELETE_ITEM event will be generated.
	<p>
	This method may cause a subsequent call to GetNextChild to fail.
	</p>
	End Rem
	Method DeleteItem(item:wxTreeItemId)
	End Method

	Rem
	bbdoc: Deletes all items in the control.
	about: Note that this may not generate EVT_TREE_DELETE_ITEM events under some Windows versions
	although normally such event is generated for each removed item.
	End Rem
	Method DeleteAllItems()
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
	End Method

	Rem
	bbdoc: 
	End Rem
	Method EndEditLabel()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method EnsureVisible()
	End Method

	Rem
	bbdoc: Expands the given item.
	End Rem
	Method Expand(item:wxTreeItemId)
		bmx_wxtreectrl_expand(wxObjectPtr, item.wxTreeItemIdPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ExpandAll()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ExpandAllChildren()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetBoundingRect()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetButtonsImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetChildrenCount()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetCount()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetEditControl()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetFirstChild()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetFirstVisibleItem()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetIndent()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemBackgroundColour()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemData()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemFont()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemImage()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemText()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemTextColour()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetLastChild()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetNextChild()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetNextSibling()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetNextVisible()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemParent()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetPrevSibling()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetPrevVisible()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetQuickBestSize()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetRootItem()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetItemSelectedImage()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetSelection()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetSelections()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetStateImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method HitTest()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method InsertItem()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsBold()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsEmpty()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsExpanded()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsSelected()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsVisible()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ItemHasChildren()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method OnCompareItems()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method PrependItem()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ScrollTo()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SelectItem()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetButtonsImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetIndent()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemBackgroundColour()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemBold()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemData()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemDropHighlight()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemFont()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemHasChildren()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemImage()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemSelectedImage()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemText()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetItemTextColour()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetQuickBestSize()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetStateImageList()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetWindowStyle()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SortChildren()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Toggle()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ToggleItemSelection()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Unselect()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method UnselectAll()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method UnselectItem()
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
		'Return bmx_wxtreeitemid_isok(wxTreeItemIdPtr)
	End Method

	Method Equals:Int(treeItem:wxTreeItemId)
		'Return bmx_wxtreeitemid_equals(wxTreeItemIdPtr, treeItem.wxTreeItemIdPtr)
	End Method
	
	Method Delete()
		If wxTreeItemIdPtr Then
			bmx_maxtreeitem_delete(wxTreeItemIdPtr)
			wxTreeItemIdPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: 
End Rem
Type wxTreeItemData

	Field wxTreeItemDataPtr:Byte Ptr
	
	Function _create:wxTreeItemData(wxTreeItemDataPtr:Byte Ptr)
		Local this:wxTreeItemData = New wxTreeItemData
	
		this.wxTreeItemDataPtr = wxTreeItemDataPtr
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Function Create:wxTreeItemData(data:Object = Null)
		Local this:wxTreeItemData = New wxTreeItemData
		
		'this.wxTreeItemDataPtr = bmx_wxtreeitemdata_create(this, data)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetData:Object()
		'Return bmx_wxtreeitemdata_getdata(wxTreeItemDataPtr)
	End Method
	
	Rem
	bbdoc: Returns the item associated with this node.
	End Rem
	Method GetId:wxTreeItemId()
		'Return wxTreeItemId._create(bmx_wxtreeitemdata_getid(wxTreeItemDataPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetData(data:Object)
		'bmx_wxtreeitemdata_setdata(wxTreeItemDataPtr, data)
	End Method
	
	Rem
	bbdoc: Sets the item associated with this node.
	End Rem
	Method SetId(id:wxTreeItemId)
		'bmx_wxtreeitemdata_setid(wxTreeItemId.wxTreeItemIdPtr)
	End Method
	
End Type


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


