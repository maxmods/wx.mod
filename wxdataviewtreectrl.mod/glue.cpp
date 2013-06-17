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

MaxDataViewTreeCtrl::MaxDataViewTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxDataViewTreeCtrl(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxDataViewTreeCtrl::MaxDataViewTreeCtrl()
{}

MaxDataViewTreeCtrl::~MaxDataViewTreeCtrl() {
	wxunbind(this);
}

void MaxDataViewTreeCtrl::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxDataViewTreeCtrl, wxDataViewTreeCtrl)
END_EVENT_TABLE()

MaxDataViewTreeCtrl * bmx_wxdataviewtreectrl_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, int style) {
	return new MaxDataViewTreeCtrl(handle, parent, id, x, y, w, h, style);
}

MaxDataViewItem * bmx_wxdataviewtreectrl_appendcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, int expanded, BBObject * data) {
	return new MaxDataViewItem(tree->AppendContainer(parent->Item(), wxStringFromBBString(text), icon, expanded, NULL));
}

MaxDataViewItem * bmx_wxdataviewtreectrl_appenditem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, BBObject * data) {
	return new MaxDataViewItem(tree->AppendItem(parent->Item(), wxStringFromBBString(text), icon, NULL));
}

void bmx_wxdataviewtreectrl_deleteallitems(wxDataViewTreeCtrl * tree) {
	tree->DeleteAllItems();
}

void bmx_wxdataviewtreectrl_deletechildren(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	tree->DeleteChildren(item->Item());
}

void bmx_wxdataviewtreectrl_deleteitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	tree->DeleteItem(item->Item());
}

int bmx_wxdataviewtreectrl_getchildcount(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent) {
	return tree->GetChildCount(parent->Item());
}

wxImageList * bmx_wxdataviewtreectrl_getimagelist(wxDataViewTreeCtrl * tree) {
	return tree->GetImageList();
}

MaxIcon * bmx_wxdataviewtreectrl_getitemexpandedicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	return new MaxIcon(tree->GetItemExpandedIcon(item->Item()));
}

MaxIcon * bmx_wxdataviewtreectrl_getitemicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	return new MaxIcon(tree->GetItemIcon(item->Item()));
}

BBString * bmx_wxdataviewtreectrl_getitemtext(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	return bbStringFromWxString(tree->GetItemText(item->Item()));	
}

MaxDataViewItem * bmx_wxdataviewtreectrl_getnthchild(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, int pos) {
	return new MaxDataViewItem(tree->GetNthChild(parent->Item(), pos));
}

MaxDataViewItem * bmx_wxdataviewtreectrl_insertcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, MaxDataViewItem * previous, BBString * text, int icon, int expanded, BBObject * data) {
	return new MaxDataViewItem(tree->InsertContainer(parent->Item(), previous->Item(), wxStringFromBBString(text), icon, expanded, NULL));
}

MaxDataViewItem * bmx_wxdataviewtreectrl_insertitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, MaxDataViewItem * previous, BBString * text, int icon, BBObject * data) {
	return new MaxDataViewItem(tree->InsertItem(parent->Item(), previous->Item(), wxStringFromBBString(text), icon, NULL));
}

int bmx_wxdataviewtreectrl_iscontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * item) {
	return static_cast<int>(tree->IsContainer(item->Item()));
}

MaxDataViewItem * bmx_wxdataviewtreectrl_prependcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, int expanded, BBObject * data) {
	return new MaxDataViewItem(tree->PrependContainer(parent->Item(), wxStringFromBBString(text), icon, expanded, NULL));
}

MaxDataViewItem * bmx_wxdataviewtreectrl_prependitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, BBObject * data) {
	return new MaxDataViewItem(tree->PrependItem(parent->Item(), wxStringFromBBString(text), icon, NULL));
}

void bmx_wxdataviewtreectrl_setimagelist(wxDataViewTreeCtrl * tree, wxImageList * imageList) {
	tree->SetImageList(imageList);
}

void bmx_wxdataviewtreectrl_setitemexpandedicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, MaxIcon * icon) {
	tree->SetItemExpandedIcon(item->Item(), icon->Icon());
}

void bmx_wxdataviewtreectrl_setitemicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, MaxIcon * icon) {
	tree->SetItemIcon(item->Item(), icon->Icon());
}

void bmx_wxdataviewtreectrl_setitemtext(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, BBString * text) {
	tree->SetItemText(item->Item(), wxStringFromBBString(text));
}

