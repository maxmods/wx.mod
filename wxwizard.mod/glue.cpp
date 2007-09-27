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

MaxWizard::MaxWizard(BBObject * handle, wxWindow * parent, int id, const wxString& title, 
		const wxBitmap& bitmap, int x, int y, long style)
	: wxWizard(parent, id, title, bitmap, wxPoint(x, y), style)
{
	wxbind(this, handle);
}

MaxWizard::~MaxWizard() {
	wxunbind(this);
}

MaxWizardPage::MaxWizardPage(BBObject * handle, wxWizard * parent, const wxBitmap& bitmap)
	: maxHandle(handle), wxWizardPage(parent, bitmap)
{
	wxbind(this, handle);
}

MaxWizardPage::~MaxWizardPage() {
	wxunbind(this);
}

wxWizardPage* MaxWizardPage::GetPrev() const {
	return _wx_wxwizard_wxWizardPage__GetPrev(maxHandle);
}

wxWizardPage* MaxWizardPage::GetNext() const {
	return _wx_wxwizard_wxWizardPage__GetNext(maxHandle);
}


MaxWizardPageSimple::MaxWizardPageSimple(BBObject * handle, wxWizard * parent, wxWizardPage * prev, wxWizardPage * next, const wxBitmap& bitmap)
	: wxWizardPageSimple(parent, prev, next, bitmap)
{
	wxbind(this, handle);
}

MaxWizardPageSimple::~MaxWizardPageSimple() {
	wxunbind(this);
}

// *********************************************

BEGIN_EVENT_TABLE(MaxWizard, wxWizard)
END_EVENT_TABLE()

BEGIN_EVENT_TABLE(MaxWizardPage, wxWizardPage)
END_EVENT_TABLE()

BEGIN_EVENT_TABLE(MaxWizardPageSimple, wxWizardPageSimple)
END_EVENT_TABLE()

MaxWizard * bmx_wxwizard_create(BBObject * handle, wxWindow * parent, int id, BBString * title, MaxBitmap * bitmap, int x, int y, long style) {
	if (!bitmap) {
		return new MaxWizard(handle, parent, id, wxStringFromBBString(title), wxNullBitmap, x, y, style);
	} else {
		return new MaxWizard(handle, parent, id, wxStringFromBBString(title), bitmap->Bitmap(), x, y, style);
	}
}

wxWizardPage * bmx_wxwizard_getcurrentpage(wxWizard * wizard) {
	return wizard->GetCurrentPage();
}

wxSizer * bmx_wxwizard_getpageareasizer(wxWizard * wizard) {
	return wizard->GetPageAreaSizer();
}

void bmx_wxwizard_getpagesize(wxWizard * wizard, int * w, int * h) {
	wxSize s = wizard->GetPageSize();
	*w = s.x;
	*h = s.y;
}

bool bmx_wxwizard_hasnextpage(wxWizard * wizard, wxWizardPage * page) {
	return wizard->HasNextPage(page);
}

bool bmx_wxwizard_hasprevpage(wxWizard * wizard, wxWizardPage * page) {
	return wizard->HasPrevPage(page);
}

bool bmx_wxwizard_runwizard(wxWizard * wizard, wxWizardPage * firstPage) {
	return wizard->RunWizard(firstPage);
}

void bmx_wxwizard_setborder(wxWizard * wizard, int border) {
	wizard->SetBorder(border);
}


MaxWizardPage * bmx_wxwizardpage_create(BBObject * handle, wxWizard * parent, MaxBitmap * bitmap) {
	if (!bitmap) {
		return new MaxWizardPage(handle, parent, wxNullBitmap);
	} else {
		return new MaxWizardPage(handle, parent, bitmap->Bitmap());
	}
}

wxWizardPage * bmx_wxwizardpage_getprev(wxWizardPage * page) {
	return page->GetPrev();
}

wxWizardPage * bmx_wxwizardpage_getnext(wxWizardPage * page) {
	return page->GetNext();
}

MaxBitmap * bmx_wxwizardpage_getbitmap(wxWizardPage * page) {
	wxBitmap b(page->GetBitmap());
	return new MaxBitmap(b);
}


MaxWizardPageSimple * bmx_wxwizardpagesimple_create(BBObject * handle, wxWizard * parent, wxWizardPage * prev, wxWizardPage * nxt, MaxBitmap * bitmap) {
	if (!bitmap) {
		return new MaxWizardPageSimple(handle, parent, prev, nxt, wxNullBitmap);
	} else {
		return new MaxWizardPageSimple(handle, parent, prev, nxt, bitmap->Bitmap());	
	}
}

void bmx_wxwizardpagesimple_setprev(wxWizardPageSimple * p, wxWizardPage * page) {
	p->SetPrev(page);
}

void bmx_wxwizardpagesimple_setnext(wxWizardPageSimple * p, wxWizardPage * page) {
	p->SetNext(page);
}

void bmx_wxwizardpagesimple_chain(wxWizardPageSimple * first, wxWizardPageSimple * second) {
	wxWizardPageSimple::Chain(first, second);
}

bool bmx_wxwizardevent_getdirection(wxWizardEvent & event) {
	return event.GetDirection();
}

wxWizardPage * bmx_wxwizardevent_getpage(wxWizardEvent & event) {
	return event.GetPage();
}

int bmx_wxwizard_geteventtype(int type) {
	switch(type) {
		case 900: return wxEVT_WIZARD_PAGE_CHANGED;
		case 901: return wxEVT_WIZARD_PAGE_CHANGING;
		case 902: return wxEVT_WIZARD_CANCEL;
		case 903: return wxEVT_WIZARD_HELP;
		case 904: return wxEVT_WIZARD_FINISHED;
	}
	
	return 0;
}
