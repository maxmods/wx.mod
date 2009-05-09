/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxListView::MaxListView(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxListView(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

wxString MaxListView::OnGetItemText(long item, long column) const {
	return wxStringFromBBString(_wx_wxlistctrl_wxListCtrl__OnGetItemText(maxHandle, item, column));
}

int MaxListView::OnGetItemColumnImage(long item, long column) const {
	return _wx_wxlistctrl_wxListCtrl__OnGetItemColumnImage(maxHandle, item, column);
}

wxListItemAttr * MaxListView::OnGetItemAttr(long item) const {
	return _wx_wxlistctrl_wxListCtrl__OnGetItemAttr(maxHandle, item);
}

int MaxListView::OnGetItemImage(long item) const {
	return _wx_wxlistctrl_wxListCtrl__OnGetItemImage(maxHandle, item);
}

MaxListView::~MaxListView() {
	bmx_releaseallclientdata(this);
	wxunbind(this);
}

// *********************************************


BEGIN_EVENT_TABLE(MaxListView, wxListView)
END_EVENT_TABLE()

MaxListView * bmx_wxlistview_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, long style) {
	return new MaxListView(handle, parent, id, x, y, w, h, style);
}

void bmx_wxlistview_clearcolumnimage(wxListView * list, int col) {
	list->ClearColumnImage(col);
}

void bmx_wxlistview_focus(wxListView * list, long index) {
	list->Focus(index);
}

long bmx_wxlistview_getfirstselected(wxListView * list) {
	return list->GetFirstSelected();
}

long bmx_wxlistview_getfocuseditem(wxListView * list) {
	return list->GetFocusedItem();
}

long bmx_wxlistview_getnextselected(wxListView * list, long item) {
	return list->GetNextSelected(item);
}

bool bmx_wxlistview_isselected(wxListView * list, long index) {
	return list->IsSelected(index);
}

void bmx_wxlistview_selectitem(wxListView * list, long item, bool on) {
	list->Select(item, on);
}

void bmx_wxlistview_setcolumnimage(wxListView * list, int col, int image) {
	list->SetColumnImage(col, image);
}


