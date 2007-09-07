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

MaxNotebook::MaxNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxNotebook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxNotebook::~MaxNotebook() {
	wxunbind(this);
}

// *********************************************

MaxNotebook * bmx_wxnotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxNotebook(maxHandle, parent, id, x, y, w, h, style);
}

bool bmx_wxnotebook_addpage(wxNotebook * notebook, wxWindow * page, BBString * text, bool selected, int imageId) {
	return notebook->AddPage(page, wxStringFromBBString(text), selected, imageId);
}

bool bmx_wxnotebook_insertpage(wxNotebook * notebook, int index, wxWindow * page, BBString * text, bool selected, int imageId) {
	return notebook->InsertPage(index, page, wxStringFromBBString(text), selected, imageId);
}

void bmx_wxnotebook_advanceselection(wxNotebook * notebook, bool forward) {
	notebook->AdvanceSelection(forward);
}

int bmx_wxnotebookevent_getoldselection(wxNotebookEvent & event) {
	return event.GetOldSelection();
}

int bmx_wxnotebookevent_getselection(wxNotebookEvent & event) {
	return event.GetSelection();
}

void bmx_wxnotebookevent_setoldselection(wxNotebookEvent & event, int page) {
	event.SetOldSelection(page);
}

void bmx_wxnotebookevent_setselection(wxNotebookEvent & event, int page) {
	event.SetSelection(page);
}

int bmx_wxnotebook_geteventtype(int type) {
	switch(type) {
		case 802: return wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED;
		case 803: return wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING;
	}
	
	return 0;
}

void bmx_wxnotebook_assignimagelist(wxNotebook * notebook, wxImageList * list) {
	// need to unbind the imagelist, just in case! (so we don't try to delete it later)
	wxunbind(list);
	notebook->AssignImageList(list);
}

void bmx_wxnotebook_setimagelist(wxNotebook * notebook, wxImageList * list) {
	notebook->SetImageList(list);
}

bool bmx_wxnotebook_deleteallpages(wxNotebook * notebook) {
	return notebook->DeleteAllPages();
}

bool bmx_wxnotebook_deletepage(wxNotebook * notebook, int page) {
	return notebook->DeletePage(page);
}

wxWindow *  bmx_wxnotebook_getcurrentpage(wxNotebook * notebook) {
	return notebook->GetCurrentPage();
}

wxWindow * bmx_wxnotebook_getpage(wxNotebook * notebook, int page) {
	return notebook->GetPage(page);
}

int bmx_wxnotebook_getpagecount(wxNotebook * notebook) {
	return notebook->GetPageCount();
}

int bmx_wxnotebook_getpageimage(wxNotebook * notebook, int page) {
	return notebook->GetPageImage(page);
}

BBString * bmx_wxnotebook_getpagetext(wxNotebook * notebook, int page) {
	return bbStringFromWxString(notebook->GetPageText(page));
}

int bmx_wxnotebook_getrowcount(wxNotebook * notebook) {
	return notebook->GetRowCount();
}

int bmx_wxnotebook_getselection(wxNotebook * notebook) {
	return notebook->GetSelection();
}

MaxColour * bmx_wxnotebook_getthemebackgroundcolour(wxNotebook * notebook) {
	wxColour c(notebook->GetThemeBackgroundColour());
	return new MaxColour(c);
}

int bmx_wxnotebook_hittest(wxNotebook * notebook, int x, int y, long * flags) {
	return notebook->HitTest(wxPoint(x, y), flags);
}

bool bmx_wxnotebook_removepage(wxNotebook * notebook, int page) {
	return notebook->RemovePage(page);
}

void bmx_wxnotebook_setpadding(wxNotebook * notebook, int width, int height) {
	notebook->SetPadding(wxSize(width, height));
}

void bmx_wxnotebook_setpagesize(wxNotebook * notebook, int width, int height) {
	notebook->SetPageSize(wxSize(width, height));
}

bool bmx_wxnotebook_setpageimage(wxNotebook * notebook, int page, int image) {
	return notebook->SetPageImage(page, image);
}

bool bmx_wxnotebook_setpagetext(wxNotebook * notebook, int page, BBString * text) {
	return notebook->SetPageText(page, wxStringFromBBString(text));
}

int bmx_wxnotebook_setselection(wxNotebook * notebook, int page) {
	return notebook->SetSelection(page);
}

int bmx_wxnotebook_changeselection(wxNotebook * notebook, int page) {
	return notebook->ChangeSelection(page);
}


