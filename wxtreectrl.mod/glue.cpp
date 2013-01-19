/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "glue.h"

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxTreeCtrl, wxTreeCtrl)

MaxTreeCtrl::MaxTreeCtrl() {
}

MaxTreeCtrl::MaxTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxTreeCtrl(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxTreeCtrl::MaxTreeCtrl(wxWindow * parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style)
	: wxTreeCtrl(parent, id, pos, size, style)
{
}

MaxTreeCtrl::~MaxTreeCtrl() {
	wxunbind(this);
}

int MaxTreeCtrl::OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2) {
	return _wx_wxtreectrl_wxTreeCtrl__OnCompareItems(maxHandle, new MaxTreeItem(item1), new MaxTreeItem(item2));
}

void MaxTreeCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
	maxHandle = handle;
}

MaxTreeItem::MaxTreeItem(wxTreeItemId treeItem)
	: item(treeItem)
{
}

wxTreeItemId MaxTreeItem::Item() {
	return item;
}


MaxTreeItemData::MaxTreeItemData(BBObject * data)
	: maxHandle(data)
{
	if (data != &bbNullObject) {
		BBRETAIN(data);
	}
}

MaxTreeItemData::~MaxTreeItemData() {
	if (maxHandle != &bbNullObject) {
		BBRELEASE(maxHandle);
	}
}

void MaxTreeItemData::SetData(BBObject * data) {
	if (maxHandle != &bbNullObject) {
		BBRELEASE(maxHandle);
	}
	
	maxHandle = data;
	
	if (data != &bbNullObject) {
		BBRETAIN(data);
	}	
}

BBObject * MaxTreeItemData::GetData() {
	return maxHandle;
}


// *********************************************

BEGIN_EVENT_TABLE(MaxTreeCtrl, wxTreeCtrl)
END_EVENT_TABLE()

MaxTreeCtrl * bmx_wxtreectrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {
	return new MaxTreeCtrl(maxHandle, parent, id, x, y, w, h, style);
}
	
MaxTreeItem * bmx_wxtreectrl_addroot(wxTreeCtrl * tree, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreectrl_appenditem(wxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage));
	}
}

void bmx_wxtreectrl_assignimagelist(wxTreeCtrl * tree, wxImageList * list) {
	// need to unbind the imagelist, just in case! (so we don't try to delete it later)
	wxunbind(list);
	tree->AssignImageList(list);
}

void bmx_wxtreectrl_assignstateimagelist(wxTreeCtrl * tree, wxImageList * imageList) {
	tree->AssignStateImageList(imageList);
}

void bmx_wxtreectrl_collapse(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->Collapse(item->Item());
}

void bmx_wxtreectrl_collapseall(wxTreeCtrl * tree) {
	tree->CollapseAll();
}

void bmx_wxtreectrl_collapseallchildren(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->CollapseAllChildren(item->Item());
}

void bmx_wxtreectrl_collapseandreset(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->CollapseAndReset(item->Item());
}

void bmx_wxtreectrl_deleteitem(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->Delete(item->Item());
}

void bmx_wxtreectrl_deleteallitems(wxTreeCtrl * tree) {
	tree->DeleteAllItems();
}

void bmx_wxtreectrl_deletechildren(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->DeleteChildren(item->Item());
}

void bmx_wxtreectrl_editlabel(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->EditLabel(item->Item());
}

void bmx_wxtreectrl_endeditlabel(wxTreeCtrl * tree, MaxTreeItem * item, bool cancelEdit) {
#ifdef WIN32
	tree->EndEditLabel(item->Item(), cancelEdit);
#endif
}

void bmx_wxtreectrl_ensurevisible(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->EnsureVisible(item->Item());
}

void bmx_wxtreectrl_expandall(wxTreeCtrl * tree) {
	tree->ExpandAll();
}

void bmx_wxtreectrl_expandallchildren(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->ExpandAllChildren(item->Item());
}

bool bmx_wxtreectrl_getboundingrect(wxTreeCtrl * tree, MaxTreeItem * item, int * x, int * y, int * w, int * h, bool textOnly) {
	wxRect r;
	bool ret = tree->GetBoundingRect(item->Item(), r, textOnly);
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
	return ret;
}

MaxRect * bmx_wxtreectrl_getboundingrectrect(wxTreeCtrl * tree, MaxTreeItem * item, bool textOnly) {
	wxRect r;
	bool ret = tree->GetBoundingRect(item->Item(), r, textOnly);
	if (ret) {
		return new MaxRect(r);
	}
	return 0;	
}

int bmx_wxtreectrl_getchildrencount(wxTreeCtrl * tree, MaxTreeItem * item, bool recursively) {
	return tree->GetChildrenCount(item->Item(), recursively);
}

int bmx_wxtreectrl_getcount(wxTreeCtrl * tree) {
	return tree->GetCount();
}

wxTextCtrl * bmx_wxtreectrl_geteditcontrol(wxTreeCtrl * tree) {
	return tree->GetEditControl();
}


BBObject * bmx_wxtreectrl_getitemdata(wxTreeCtrl * tree, MaxTreeItem * item) {
	MaxTreeItemData * data = (MaxTreeItemData*)tree->GetItemData(item->Item());
	if (data) {
		return data->GetData();
	}
	return &bbNullObject;
}

MaxTreeItem * bmx_wxtreectrl_getfirstchild(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue) {
	return new MaxTreeItem(tree->GetFirstChild(item->Item(), *idvalue));
}

MaxTreeItem * bmx_wxtreectrl_getfirstvisibleitem(wxTreeCtrl * tree) {
	return new MaxTreeItem(tree->GetFirstVisibleItem());
}

MaxTreeItem * bmx_wxtreectrl_getnextchild(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue) {
	return new MaxTreeItem(tree->GetNextChild(item->Item(), *idvalue));
}

int bmx_wxtreectrl_getindent(wxTreeCtrl * tree) {
	return tree->GetIndent();
}

MaxColour * bmx_wxtreectrl_getitembackgroundcolour(wxTreeCtrl * tree, MaxTreeItem * item) {
	wxColour c(tree->GetItemBackgroundColour(item->Item()));
	return new MaxColour(c);
}

MaxFont * bmx_wxtreectrl_getitemfont(wxTreeCtrl * tree, MaxTreeItem * item) {
	wxFont f(tree->GetItemFont(item->Item()));
	return new MaxFont(f);
}

int bmx_wxtreectrl_getitemimage(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIcon which) {
	return tree->GetItemImage(item->Item(), which);
}

BBString * bmx_wxtreectrl_getitemtext(wxTreeCtrl * tree, MaxTreeItem * item) {
	return bbStringFromWxString(tree->GetItemText(item->Item()));
}

MaxColour * bmx_wxtreectrl_getitemtextcolour(wxTreeCtrl * tree, MaxTreeItem * item) {
	wxColour c(tree->GetItemTextColour(item->Item()));
	return new MaxColour(c);
}

MaxTreeItem * bmx_wxtreectrl_getlastchild(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetLastChild(item->Item()));
}

MaxTreeItem * bmx_wxtreectrl_getnextsibling(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNextSibling(item->Item()));
}

MaxTreeItem * bmx_wxtreectrl_getnextvisible(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNextVisible(item->Item()));
}

MaxTreeItem * bmx_wxtreectrl_getitemparent(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetItemParent(item->Item()));
}

MaxTreeItem * bmx_wxtreectrl_getprevsibling(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrevSibling(item->Item()));
}

MaxTreeItem * bmx_wxtreectrl_getprevvisible(wxTreeCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrevVisible(item->Item()));
}

int bmx_wxtreectrl_getquickbestsize(wxTreeCtrl * tree) {
	return tree->GetQuickBestSize();
}

MaxTreeItem * bmx_wxtreectrl_getrootitem(wxTreeCtrl * tree) {
	return new MaxTreeItem(tree->GetRootItem());
}

MaxTreeItem * bmx_wxtreectrl_getselection(wxTreeCtrl * tree) {
	return new MaxTreeItem(tree->GetSelection());
}

bool bmx_wxtreectrl_isbold(wxTreeCtrl * tree, MaxTreeItem * item) {
	return tree->IsBold(item->Item());
}

bool bmx_wxtreectrl_isempty(wxTreeCtrl * tree) {
	return tree->IsEmpty();
}

bool bmx_wxtreectrl_isexpanded(wxTreeCtrl * tree, MaxTreeItem * item) {
	return tree->IsExpanded(item->Item());
}

bool bmx_wxtreectrl_isselected(wxTreeCtrl * tree, MaxTreeItem * item) {
	return tree->IsSelected(item->Item());
}

bool bmx_wxtreectrl_isvisible(wxTreeCtrl * tree, MaxTreeItem * item) {
	return tree->IsVisible(item->Item());
}

bool bmx_wxtreectrl_itemhaschildren(wxTreeCtrl * tree, MaxTreeItem * item) {
	return tree->ItemHasChildren(item->Item());
}


void bmx_wxtreectrl_scrollto(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->ScrollTo(item->Item());
}

void bmx_wxtreectrl_selectitem(wxTreeCtrl * tree, MaxTreeItem * item, bool selected) {
	tree->SelectItem(item->Item(), selected);
}

void bmx_wxtreectrl_setindent(wxTreeCtrl * tree, int indent) {
	tree->SetIndent(indent);
}

void bmx_wxtreectrl_setimagelist(wxTreeCtrl * tree, wxImageList * imageList) {
	tree->SetImageList(imageList);
}

void bmx_wxtreectrl_setitembackgroundcolour(wxTreeCtrl * tree, MaxTreeItem * item, MaxColour * colour) {
	tree->SetItemBackgroundColour(item->Item(), colour->Colour());
}

void bmx_wxtreectrl_setitembold(wxTreeCtrl * tree, MaxTreeItem * item, bool bold) {
	tree->SetItemBold(item->Item(), bold);
}

void bmx_wxtreectrl_setitemdata(wxTreeCtrl * tree, MaxTreeItem * item, BBObject * data) {
	MaxTreeItemData * itemdata = (MaxTreeItemData*)tree->GetItemData(item->Item());
	
	if (!itemdata) {
		tree->SetItemData(item->Item(), new MaxTreeItemData(data));
	} else {
		itemdata->SetData(data);
	}	
}

void bmx_wxtreectrl_setitemdrophighlight(wxTreeCtrl * tree, MaxTreeItem * item, bool highlight) {
	tree->SetItemDropHighlight(item->Item(), highlight);
}

void bmx_wxtreectrl_setitemfont(wxTreeCtrl * tree, MaxTreeItem * item, MaxFont * font) {
	tree->SetItemFont(item->Item(), font->Font());
}

void bmx_wxtreectrl_setitemhaschildren(wxTreeCtrl * tree, MaxTreeItem * item, bool hasChildren) {
	tree->SetItemHasChildren(item->Item(), hasChildren);
}

void bmx_wxtreectrl_setitemimage(wxTreeCtrl * tree, MaxTreeItem * item, int image, wxTreeItemIcon which) {
	tree->SetItemImage(item->Item(), image, which);
}

void bmx_wxtreectrl_setitemtext(wxTreeCtrl * tree, MaxTreeItem * item, BBString * text) {
	tree->SetItemText(item->Item(), wxStringFromBBString(text));
}

void bmx_wxtreectrl_setitemtextcolour(wxTreeCtrl * tree, MaxTreeItem * item, MaxColour * colour) {
	tree->SetItemTextColour(item->Item(), colour->Colour());
}

void bmx_wxtreectrl_setquickbestsize(wxTreeCtrl * tree, int quickBestSize) {
	tree->SetQuickBestSize(quickBestSize);
}

void bmx_wxtreectrl_setstateimagelist(wxTreeCtrl * tree, wxImageList * imageList) {
	tree->SetStateImageList(imageList);
}

void bmx_wxtreectrl_setwindowstyle(wxTreeCtrl * tree, long style) {
	tree->SetWindowStyle(style);
}

void bmx_wxtreectrl_sortchildren(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->SortChildren(item->Item());
}

void bmx_wxtreectrl_toggle(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->Toggle(item->Item());
}

void bmx_wxtreectrl_toggleitemselection(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->ToggleItemSelection(item->Item());
}

void bmx_wxtreectrl_unselect(wxTreeCtrl * tree) {
	tree->Unselect();
}

void bmx_wxtreectrl_unselectall(wxTreeCtrl * tree) {
	tree->UnselectAll();
}

void bmx_wxtreectrl_unselectitem(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->UnselectItem(item->Item());
}

MaxTreeItem * bmx_wxtreectrl_hittest(wxTreeCtrl * tree, int x, int y, int * flags) {
	int f = *flags;
	MaxTreeItem * item = new MaxTreeItem(tree->HitTest(wxPoint(x, y), f));
	*flags = f;
	return item;
}

MaxTreeItem * bmx_wxtreectrl_insertitem(wxTreeCtrl * tree, MaxTreeItem * parent, MaxTreeItem * previous, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->InsertItem(parent->Item(), previous->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->InsertItem(parent->Item(), previous->Item(), wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreectrl_insertitembefore(wxTreeCtrl * tree, MaxTreeItem * parent, int before, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->InsertItem(parent->Item(), before, wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->InsertItem(parent->Item(), before, wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreectrl_prependitem(wxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->PrependItem(parent->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->PrependItem(parent->Item(), wxStringFromBBString(text), image, selImage));
	}
}


wxTreeItemIdValue * bmx_wxtreeitemidvalue_create() {
	return new wxTreeItemIdValue();
}

void bmx_wxtreeitemidvalue_delete(wxTreeItemIdValue * idvalue) {
	delete idvalue;
}

void bmx_wxtreectrl_expand(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->Expand(item->Item());
}


bool bmx_wxtreeitemid_isok(MaxTreeItem * item) {
	return item->Item().IsOk();
}

bool bmx_wxtreeitemid_equals(MaxTreeItem * item, MaxTreeItem * otheritem) {
	return item->Item() == otheritem->Item();
}

void bmx_wxtreeitemid_delete(MaxTreeItem * item) {
	delete item;
}

BBArray * bmx_wxtreectrl_getselections(wxTreeCtrl * tree) {
	wxArrayTreeItemIds selection;
	int count = tree->GetSelections(selection);
	
	BBArray * array = _wx_wxtreectrl_wxTreeCtrl__newSelections(count);
	
	if (count > 0) {
		for (int i = 0; i < count; i++) {
			MaxTreeItem * item = new MaxTreeItem(selection.Item(i));
			_wx_wxtreectrl_wxTreeCtrl__setSelection(array, i, item);
		}
	}

	return array;
}

int bmx_wxtreeevent_getkeycode(wxTreeEvent & event) {
	return event.GetKeyCode();
}

MaxTreeItem * bmx_wxtreeevent_getitem(wxTreeEvent & event) {
	return new MaxTreeItem(event.GetItem());
}

const wxKeyEvent & bmx_wxtreeevent_getkeyevent(wxTreeEvent & event) {
	return event.GetKeyEvent();
}

BBString * bmx_wxtreeevent_getlabel(wxTreeEvent & event) {
	return bbStringFromWxString(event.GetLabel());
}

MaxTreeItem * bmx_wxtreeevent_getolditem(wxTreeEvent & event) {
	return new MaxTreeItem(event.GetOldItem());
}

void bmx_wxtreeevent_getpoint(wxTreeEvent & event, int * x, int * y) {
	wxPoint p = event.GetPoint();
	*x = p.x;
	*y = p.y;
}

bool bmx_wxtreeevent_iseditcancelled(wxTreeEvent & event) {
	return event.IsEditCancelled();
}

void bmx_wxtreeevent_settooltip(wxTreeEvent & event, BBString * tip) {
	event.SetToolTip(wxStringFromBBString(tip));
}



int bmx_wxtreectrl_geteventtype(int type) {
	switch(type) {
		case 600: return wxEVT_COMMAND_TREE_BEGIN_DRAG;
		case 601: return wxEVT_COMMAND_TREE_BEGIN_RDRAG;
		case 602: return wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT;
		case 603: return wxEVT_COMMAND_TREE_END_LABEL_EDIT;
		case 604: return wxEVT_COMMAND_TREE_DELETE_ITEM;
		case 605: return wxEVT_COMMAND_TREE_GET_INFO;
		case 606: return wxEVT_COMMAND_TREE_SET_INFO;
		case 607: return wxEVT_COMMAND_TREE_ITEM_EXPANDED;
		case 608: return wxEVT_COMMAND_TREE_ITEM_EXPANDING;
		case 609: return wxEVT_COMMAND_TREE_ITEM_COLLAPSED;
		case 610: return wxEVT_COMMAND_TREE_ITEM_COLLAPSING;
		case 611: return wxEVT_COMMAND_TREE_SEL_CHANGED;
		case 612: return wxEVT_COMMAND_TREE_SEL_CHANGING;
		case 613: return wxEVT_COMMAND_TREE_KEY_DOWN;
		case 614: return wxEVT_COMMAND_TREE_ITEM_ACTIVATED;
		case 615: return wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK;
		case 616: return wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK;
		case 617: return wxEVT_COMMAND_TREE_END_DRAG;
		case 618: return wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK;
		case 619: return wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP;
		case 620: return wxEVT_COMMAND_TREE_ITEM_MENU;
	}
	
	return 0;
}
