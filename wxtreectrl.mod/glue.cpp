/*
  Copyright (c) 2007 Bruce A Henderson
 
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

MaxTreeCtrl::MaxTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxTreeCtrl(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxTreeCtrl::~MaxTreeCtrl() {
	wxunbind(this);
}

MaxTreeItem::MaxTreeItem(wxTreeItemId treeItem)
	: item(treeItem)
{
}

wxTreeItemId MaxTreeItem::Item() {
	return item;
}

// *********************************************

MaxTreeCtrl * bmx_wxtreectrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {
	return new MaxTreeCtrl(maxHandle, parent, id, x, y, w, h, style);
}
	
MaxTreeItem * bmx_wxtreectrl_addroot(wxTreeCtrl * tree, BBString * text, int image, int selImage, wxTreeItemData * data) {
	if (data) {
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage, data));
	} else {
		return new MaxTreeItem(tree->AddRoot(wxStringFromBBString(text), image, selImage));
	}
}

MaxTreeItem * bmx_wxtreectrl_appenditem(wxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, wxTreeItemData * data) {
	if (data) {
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage, data));
	} else {
		return new MaxTreeItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), image, selImage));
	}
}

void bmx_wxtreectrl_assignimagelist(wxTreeCtrl * tree, wxImageList * list) {
	// need to unbind the imagelist, just in case! (so we don't try to delete it later)
	wxunbind(list);
	tree->AssignImageList(list);

}

void bmx_wxtreectrl_expand(wxTreeCtrl * tree, MaxTreeItem * item) {
	tree->Expand(item->Item());
}

void bmx_maxtreeitem_delete(MaxTreeItem * item) {
	delete item;
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
