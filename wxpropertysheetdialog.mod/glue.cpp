/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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

MaxPropertySheetDialog::MaxPropertySheetDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxPropertySheetDialog(parent, id, title, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxPropertySheetDialog::~MaxPropertySheetDialog() {
	wxunbind(this);
}

void MaxPropertySheetDialog::AddBookCtrl(wxSizer* sizer) {
	_wx_wxpropertysheetdialog_wxPropertySheetDialog__AddBookCtrl(maxHandle, sizer);
}

wxBookCtrlBase* MaxPropertySheetDialog::CreateBookCtrl() {
	return _wx_wxpropertysheetdialog_wxPropertySheetDialog__CreateBookCtrl(maxHandle);
}

void MaxPropertySheetDialog::AddBookCtrl_default(wxSizer* sizer) {
	wxPropertySheetDialog::AddBookCtrl(sizer);
}

wxBookCtrlBase* MaxPropertySheetDialog::CreateBookCtrl_default() {
	return wxPropertySheetDialog::CreateBookCtrl();
}

// *********************************************

BEGIN_EVENT_TABLE(MaxPropertySheetDialog, wxPropertySheetDialog)
END_EVENT_TABLE()


wxPropertySheetDialog * bmx_wxpropertysheetdialog_create(BBObject * handle, wxWindow * parent,
		wxWindowID id, BBString * title, int x, int y, int w, int h, long style) {
	return new MaxPropertySheetDialog(handle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
}

void bmx_wxpropertysheetdialog_addbookctrl(MaxPropertySheetDialog * dialog, wxSizer * sizer) {
	dialog->AddBookCtrl_default(sizer);
}

wxBookCtrlBase * bmx_wxpropertysheetdialog_createbookctrl(MaxPropertySheetDialog * dialog) {
	return dialog->CreateBookCtrl_default();
}

void bmx_wxpropertysheetdialog_createbuttons(wxPropertySheetDialog * dialog, int flags) {
	dialog->CreateButtons(flags);
}

wxBookCtrlBase * bmx_wxpropertysheetdialog_getbookctrl(wxPropertySheetDialog * dialog) {
	return dialog->GetBookCtrl();
}

wxSizer * bmx_wxpropertysheetdialog_getinnersizer(wxPropertySheetDialog * dialog) {
	return dialog->GetInnerSizer();
}

int bmx_wxpropertysheetdialog_getsheetstyle(wxPropertySheetDialog * dialog) {
	return dialog->GetSheetStyle();
}

void bmx_wxpropertysheetdialog_layoutdialog(wxPropertySheetDialog * dialog, int centreFlags) {
	dialog->LayoutDialog(centreFlags);
}

void bmx_wxpropertysheetdialog_setbookctrl(wxPropertySheetDialog * dialog, wxBookCtrlBase * bookCtrl) {
	dialog->SetBookCtrl(bookCtrl);
}


