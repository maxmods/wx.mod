/*
  Copyright (c) 2010 Bruce A Henderson
 
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


IMPLEMENT_DYNAMIC_CLASS(MaxTreeListCtrl, wxTreeListCtrl)

MaxTreeListCtrl::MaxTreeListCtrl() {
}

MaxTreeListCtrl::MaxTreeListCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxTreeListCtrl(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxTreeListCtrl::MaxTreeListCtrl(wxWindow * parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style)
	: wxTreeListCtrl(parent, id, pos, size, style)
{
}

MaxTreeListCtrl::~MaxTreeListCtrl() {
	wxunbind(this);
}

int MaxTreeListCtrl::OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2) {
	return _wx_wxtreelistctrl_wxTreeListCtrl__OnCompareItems(maxHandle, new MaxTreeItem(item1), new MaxTreeItem(item2));
}

void MaxTreeListCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
	maxHandle = handle;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxTreeListCtrl, wxTreeListCtrl)
END_EVENT_TABLE()

MaxTreeListCtrl * bmx_wxtreelistctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {
	return new MaxTreeListCtrl(maxHandle, parent, id, x, y, w, h, style);
}
	
MaxTreeItem * bmx_wxtreelistctrl_addroot(wxTreeListCtrl * tree, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreelistctrl_appenditem(wxTreeListCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage));
	}
}

void bmx_wxtreelistctrl_assignimagelist(wxTreeListCtrl * tree, wxImageList * list) {
	// need to unbind the imagelist, just in case! (so we don't try to delete it later)
	wxunbind(list);
	tree->AssignImageList(list);
}

void bmx_wxtreelistctrl_assignstateimagelist(wxTreeListCtrl * tree, wxImageList * imageList) {
	tree->AssignStateImageList(imageList);
}

void bmx_wxtreelistctrl_collapse(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->Collapse(item->Item());
}

void bmx_wxtreelistctrl_collapseandreset(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->CollapseAndReset(item->Item());
}

void bmx_wxtreelistctrl_deleteitem(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->Delete(item->Item());
}

void bmx_wxtreelistctrl_deletechildren(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->DeleteChildren(item->Item());
}

void bmx_wxtreelistctrl_editlabel(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->EditLabel(item->Item());
}

void bmx_wxtreelistctrl_ensurevisible(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->EnsureVisible(item->Item());
}

bool bmx_wxtreelistctrl_getboundingrect(wxTreeListCtrl * tree, MaxTreeItem * item, int * x, int * y, int * w, int * h, bool textOnly) {
	wxRect r;
	bool ret = tree->GetBoundingRect(item->Item(), r, textOnly);
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
	return ret;
}

MaxRect * bmx_wxtreelistctrl_getboundingrectrect(wxTreeListCtrl * tree, MaxTreeItem * item, bool textOnly) {
	wxRect r;
	bool ret = tree->GetBoundingRect(item->Item(), r, textOnly);
	if (ret) {
		return new MaxRect(r);
	}
	return 0;	
}

int bmx_wxtreelistctrl_getchildrencount(wxTreeListCtrl * tree, MaxTreeItem * item, bool recursively) {
	return tree->GetChildrenCount(item->Item(), recursively);
}

int bmx_wxtreelistctrl_getcount(wxTreeListCtrl * tree) {
	return tree->GetCount();
}


BBObject * bmx_wxtreelistctrl_getitemdata(wxTreeListCtrl * tree, MaxTreeItem * item) {
	MaxTreeItemData * data = (MaxTreeItemData*)tree->GetItemData(item->Item());
	if (data) {
		return data->GetData();
	}
	return &bbNullObject;
}

MaxTreeItem * bmx_wxtreelistctrl_getfirstchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue) {
	return new MaxTreeItem(tree->GetFirstChild(item->Item(), *idvalue));
}

MaxTreeItem * bmx_wxtreelistctrl_getfirstvisibleitem(wxTreeListCtrl * tree) {
	return new MaxTreeItem(tree->GetFirstVisibleItem());
}

MaxTreeItem * bmx_wxtreelistctrl_getnextchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue) {
	return new MaxTreeItem(tree->GetNextChild(item->Item(), *idvalue));
}

int bmx_wxtreelistctrl_getindent(wxTreeListCtrl * tree) {
	return tree->GetIndent();
}

MaxColour * bmx_wxtreelistctrl_getitembackgroundcolour(wxTreeListCtrl * tree, MaxTreeItem * item) {
	wxColour c(tree->GetItemBackgroundColour(item->Item()));
	return new MaxColour(c);
}

MaxFont * bmx_wxtreelistctrl_getitemfont(wxTreeListCtrl * tree, MaxTreeItem * item) {
	wxFont f(tree->GetItemFont(item->Item()));
	return new MaxFont(f);
}

int bmx_wxtreelistctrl_getitemimage(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIcon which) {
	return tree->GetItemImage(item->Item(), which);
}

MaxColour * bmx_wxtreelistctrl_getitemtextcolour(wxTreeListCtrl * tree, MaxTreeItem * item) {
	wxColour c(tree->GetItemTextColour(item->Item()));
	return new MaxColour(c);
}

MaxTreeItem * bmx_wxtreelistctrl_getlastchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * value) {
	return new MaxTreeItem(tree->GetLastChild(item->Item(), *value));
}

MaxTreeItem * bmx_wxtreelistctrl_getnextsibling(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNextSibling(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getnextvisible(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNextVisible(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getitemparent(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetItemParent(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getprevsibling(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrevSibling(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getprevvisible(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrevVisible(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getrootitem(wxTreeListCtrl * tree) {
	return new MaxTreeItem(tree->GetRootItem());
}

MaxTreeItem * bmx_wxtreelistctrl_getselection(wxTreeListCtrl * tree) {
	return new MaxTreeItem(tree->GetSelection());
}

bool bmx_wxtreelistctrl_isbold(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return tree->IsBold(item->Item());
}

bool bmx_wxtreelistctrl_isexpanded(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return tree->IsExpanded(item->Item());
}

bool bmx_wxtreelistctrl_isselected(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return tree->IsSelected(item->Item());
}

bool bmx_wxtreelistctrl_isvisible(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return tree->IsVisible(item->Item());
}

void bmx_wxtreelistctrl_scrollto(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->ScrollTo(item->Item());
}

int bmx_wxtreelistctrl_selectitem(wxTreeListCtrl * tree, MaxTreeItem * item, MaxTreeItem * last, int selected) {
	if (last) {
		return static_cast<int>(tree->SelectItem(item->Item(), last->Item(), static_cast<bool>(selected)));
	} else {
		return static_cast<int>(tree->SelectItem(item->Item(), NULL, static_cast<bool>(selected)));
	}
}

void bmx_wxtreelistctrl_setindent(wxTreeListCtrl * tree, int indent) {
	tree->SetIndent(indent);
}

void bmx_wxtreelistctrl_setimagelist(wxTreeListCtrl * tree, wxImageList * imageList) {
	tree->SetImageList(imageList);
}

void bmx_wxtreelistctrl_setitembackgroundcolour(wxTreeListCtrl * tree, MaxTreeItem * item, MaxColour * colour) {
	tree->SetItemBackgroundColour(item->Item(), colour->Colour());
}

void bmx_wxtreelistctrl_setitembold(wxTreeListCtrl * tree, MaxTreeItem * item, int bold) {
	tree->SetItemBold(item->Item(), static_cast<bool>(bold));
}

void bmx_wxtreelistctrl_setitemdata(wxTreeListCtrl * tree, MaxTreeItem * item, BBObject * data) {
	MaxTreeItemData * itemdata = (MaxTreeItemData*)tree->GetItemData(item->Item());
	
	if (!itemdata) {
		tree->SetItemData(item->Item(), new MaxTreeItemData(data));
	} else {
		itemdata->SetData(data);
	}	
}

void bmx_wxtreelistctrl_setitemfont(wxTreeListCtrl * tree, MaxTreeItem * item, MaxFont * font) {
	tree->SetItemFont(item->Item(), font->Font());
}

void bmx_wxtreelistctrl_setitemhaschildren(wxTreeListCtrl * tree, MaxTreeItem * item, int hasChildren) {
	tree->SetItemHasChildren(item->Item(), static_cast<bool>(hasChildren));
}

void bmx_wxtreelistctrl_setitemtextcolour(wxTreeListCtrl * tree, MaxTreeItem * item, MaxColour * colour) {
	tree->SetItemTextColour(item->Item(), colour->Colour());
}

void bmx_wxtreelistctrl_setstateimagelist(wxTreeListCtrl * tree, wxImageList * imageList) {
	tree->SetStateImageList(imageList);
}

void bmx_wxtreelistctrl_setwindowstyle(wxTreeListCtrl * tree, long style) {
	tree->SetWindowStyle(style);
}

void bmx_wxtreelistctrl_sortchildren(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->SortChildren(item->Item());
}

void bmx_wxtreelistctrl_toggle(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->Toggle(item->Item());
}

void bmx_wxtreelistctrl_unselect(wxTreeListCtrl * tree) {
	tree->Unselect();
}

void bmx_wxtreelistctrl_unselectall(wxTreeListCtrl * tree) {
	tree->UnselectAll();
}

MaxTreeItem * bmx_wxtreelistctrl_hittest(wxTreeListCtrl * tree, int x, int y, int * flags) {
	int f = *flags;
	MaxTreeItem * item = new MaxTreeItem(tree->HitTest(wxPoint(x, y), f));
	*flags = f;
	return item;
}

MaxTreeItem * bmx_wxtreelistctrl_insertitem(wxTreeListCtrl * tree, MaxTreeItem * parent, MaxTreeItem * previous, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->InsertItem(parent->Item(), previous->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->InsertItem(parent->Item(), previous->Item(), wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreelistctrl_insertitembefore(wxTreeListCtrl * tree, MaxTreeItem * parent, int before, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->InsertItem(parent->Item(), before, wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->InsertItem(parent->Item(), before, wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreelistctrl_prependitem(wxTreeListCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data) {
	if (data != &bbNullObject) {
		MaxTreeItemData * itemdata = new MaxTreeItemData(data);
		return new MaxTreeItem(tree->PrependItem(parent->Item(), wxStringFromBBString(text), image, selImage, itemdata));
	} else {
		return new MaxTreeItem(tree->PrependItem(parent->Item(), wxStringFromBBString(text), image, selImage));
	}
}

void bmx_wxtreelistctrl_expand(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->Expand(item->Item());
}


BBArray * bmx_wxtreelistctrl_getselections(wxTreeListCtrl * tree) {
	wxArrayTreeItemIds selection;
	int count = tree->GetSelections(selection);
	
	BBArray * array = _wx_wxtreelistctrl_wxTreeListCtrl__newSelections(count);
	
	if (count > 0) {
		for (int i = 0; i < count; i++) {
			MaxTreeItem * item = new MaxTreeItem(selection.Item(i));
			_wx_wxtreelistctrl_wxTreeListCtrl__setSelection(array, i, item);
		}
	}

	return array;
}

void bmx_wxtreelistctrl_deleteroot(wxTreeListCtrl * tree) {
	tree->DeleteRoot();
}

MaxTreeItem * bmx_wxtreelistctrl_finditem(wxTreeListCtrl * tree, MaxTreeItem * item, BBString * text, int flags) {
	return new MaxTreeItem(tree->FindItem(item->Item(), wxStringFromBBString(text), flags));
}

MaxTreeItem * bmx_wxtreelistctrl_getfirstexpandeditem(wxTreeListCtrl * tree) {
	return new MaxTreeItem(tree->GetFirstExpandedItem());
}

void bmx_wxtreelistctrl_expandall(wxTreeListCtrl * tree, MaxTreeItem * item) {
	tree->ExpandAll(item->Item());
}

BBString * bmx_wxtreelistctrl_getitemtext(wxTreeListCtrl * tree, MaxTreeItem * item, int column) {
	return bbStringFromWxString(tree->GetItemText(item->Item(), column));
}

int bmx_wxtreelistctrl_getlinespacing(wxTreeListCtrl * tree) {
	return tree->GetLineSpacing();
}

MaxTreeItem * bmx_wxtreelistctrl_getnext(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNext(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getnextexpanded(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetNextExpanded(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getprev(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrev(item->Item()));
}

MaxTreeItem * bmx_wxtreelistctrl_getprevexpanded(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return new MaxTreeItem(tree->GetPrevExpanded(item->Item()));
}

int bmx_wxtreelistctrl_haschildren(wxTreeListCtrl * tree, MaxTreeItem * item) {
	return static_cast<int>(tree->HasChildren(item->Item()));
}

void bmx_wxtreelistctrl_setitemimage(wxTreeListCtrl * tree, MaxTreeItem * item, int image, int column, int which) {
	tree->SetItemImage(item->Item(), column, image, (wxTreeItemIcon)which);
}

void bmx_wxtreelistctrl_setitemtext(wxTreeListCtrl * tree, MaxTreeItem * item, BBString * text, int column) {
	tree->SetItemText(item->Item(), column, wxStringFromBBString(text));
}

void bmx_wxtreelistctrl_setlinespacing(wxTreeListCtrl * tree, int value) {
	tree->SetLineSpacing(value);
}

void bmx_wxtreelistctrl_addcolumn(wxTreeListCtrl * tree, BBString * text, int width, int alignment) {
	tree->AddColumn(wxStringFromBBString(text), width, alignment);
}

int bmx_wxtreelistctrl_getcolumnalignment(wxTreeListCtrl * tree, int column) {
	return tree->GetColumnAlignment(column);
}

int bmx_wxtreelistctrl_getcolumncount(wxTreeListCtrl * tree) {
	return tree->GetColumnCount();
}

int bmx_wxtreelistctrl_getcolumnimage(wxTreeListCtrl * tree, int column) {
	return tree->GetColumnImage(column);
}

BBString * bmx_wxtreelistctrl_getcolumntext(wxTreeListCtrl * tree, int column) {
	return bbStringFromWxString(tree->GetColumnText(column));
}

int bmx_wxtreelistctrl_getcolumnwidth(wxTreeListCtrl * tree, int column) {
	return tree->GetColumnWidth(column);
}

void bmx_wxtreelistctrl_insertcolumn(wxTreeListCtrl * tree, int before, BBString * text, int width, int alignment) {
	tree->InsertColumn(before, wxStringFromBBString(text), width, alignment);
}

int bmx_wxtreelistctrl_iscolumnshown(wxTreeListCtrl * tree, int column) {
	return static_cast<int>(tree->IsColumnShown(column));
}

void bmx_wxtreelistctrl_removecolumn(wxTreeListCtrl * tree, int column) {
	tree->RemoveColumn(column);
}

void bmx_wxtreelistctrl_setcolumnalignment(wxTreeListCtrl * tree, int column, int align) {
	tree->SetColumnAlignment(column, align);
}

void bmx_wxtreelistctrl_setcolumnimage(wxTreeListCtrl * tree, int column, int image) {
	tree->SetColumnImage(column, image);
}

void bmx_wxtreelistctrl_setcolumntext(wxTreeListCtrl * tree, int column, BBString * text) {
	tree->SetColumnText(column, wxStringFromBBString(text));
}

void bmx_wxtreelistctrl_setcolumnwidth(wxTreeListCtrl * tree, int column, int width) {
	tree->SetColumnWidth(column, width);
}

void bmx_wxtreelistctrl_setmaincolumn(wxTreeListCtrl * tree, int column) {
	tree->SetMainColumn(column);
}




