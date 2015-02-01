/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

MaxVListBox::MaxVListBox(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxVListBox(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxVListBox::~MaxVListBox() {
	wxunbind(this);
}

void MaxVListBox::OnDrawItem(wxDC &dc, const wxRect &rect, size_t n) const {
	// TODO - callback into max code
}

wxCoord 	MaxVListBox::OnMeasureItem (size_t n) const {
	// TODO - callback into max code
}


// *********************************************

BEGIN_EVENT_TABLE(MaxVListBox, wxVListBox)
END_EVENT_TABLE()


wxVListBox * bmx_wxvlistbox_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxVListBox(handle, parent, id, x, y, w, h, style);
}

void bmx_wxvlistbox_clear(wxVListBox * listbox) {
	listbox->Clear();
}

int bmx_wxvlistbox_deselectall(wxVListBox * listbox) {
	return listbox->DeselectAll();
}

int bmx_wxvlistbox_getfirstselected(wxVListBox * listbox, unsigned long * cookie) {
	return listbox->GetFirstSelected(*cookie);
}

int bmx_wxvlistbox_getitemcount(wxVListBox * listbox) {
	return static_cast<int>(listbox->GetItemCount());
}

void bmx_wxvlistbox_getmargins(wxVListBox * listbox, int * x, int * y) {
	wxPoint p(listbox->GetMargins());
	*x = p.x;
	*y = p.y;
}

void bmx_wxvlistbox_getitemrect(wxVListBox * listbox, int item, int * x, int * y, int * w, int * h) {
	wxRect r(listbox->GetItemRect(static_cast<size_t>(item)));
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

MaxRect * bmx_wxvlistbox_getitemrectrect(wxVListBox * listbox, int item) {
	return new MaxRect(listbox->GetItemRect(static_cast<size_t>(item)));
}

int bmx_wxvlistbox_getnextselected(wxVListBox * listbox, unsigned long * cookie) {
	return listbox->GetNextSelected(*cookie);
}

int bmx_wxvlistbox_getselectedcount(wxVListBox * listbox) {
	return static_cast<int>(listbox->GetSelectedCount());
}

int bmx_wxvlistbox_getselection(wxVListBox * listbox) {
	return listbox->GetSelection();
}

MaxColour * bmx_wxvlistbox_getselectionbackground(wxVListBox * listbox) {
	wxColour c(listbox->GetSelectionBackground());
	return new MaxColour(c);
}

int bmx_wxvlistbox_hasmultipleselection(wxVListBox * listbox) {
	return listbox->HasMultipleSelection();
}

int bmx_wxvlistbox_iscurrent(wxVListBox * listbox, int item) {
	return listbox->IsCurrent(static_cast<size_t>(item));
}

int bmx_wxvlistbox_isselected(wxVListBox * listbox, int item) {
	return listbox->IsSelected(static_cast<size_t>(item));
}

int bmx_wxvlistbox_selectitem(wxVListBox * listbox, int item) {
	return listbox->Select(static_cast<size_t>(item));
}

int bmx_wxvlistbox_selectall(wxVListBox * listbox) {
	return listbox->SelectAll();
}

int bmx_wxvlistbox_selectrange(wxVListBox * listbox, int rangeFrom, int rangeTo) {
	return listbox->SelectRange(static_cast<size_t>(rangeFrom), static_cast<size_t>(rangeTo));
}

void bmx_wxvlistbox_setitemcount(wxVListBox * listbox, int count) {
	listbox->SetItemCount(static_cast<size_t>(count));
}

void bmx_wxvlistbox_setselection(wxVListBox * listbox, int selection) {
	listbox->SetSelection(selection);
}

void bmx_wxvlistbox_setselectionbackground(wxVListBox * listbox, MaxColour * col) {
	listbox->SetSelectionBackground(col->Colour());
}

void bmx_wxvlistbox_toggle(wxVListBox * listbox, int item) {
	listbox->Toggle(static_cast<size_t>(item));
}

void bmx_wxvlistbox_setmargins(wxVListBox * listbox, int x, int y) {
	listbox->SetMargins(wxPoint(x, y));
}


