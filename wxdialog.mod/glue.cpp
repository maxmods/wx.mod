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

MaxDialog::MaxDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style)
	: wxDialog(parent, id, title, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxDialog::~MaxDialog() {
	wxunbind(this);
}


// *********************************************


MaxDialog * bmx_wxdialog_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * title, int x, int y,
		int w, int h, long style) {
	return new MaxDialog(maxHandle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
}

void bmx_wxdialog_free(wxDialog * dialog) {
	delete dialog;
}

void bmx_wxdialog_centre(wxDialog * dialog, int direction) {
	dialog->Centre(direction);
}

bool bmx_wxdialog_show(wxDialog * dialog, bool show) {
	return dialog->Show(show);
}

int bmx_wxdialog_showmodal(wxDialog * dialog) {
	return dialog->ShowModal();
}


wxSizer * bmx_wxdialog_createbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateButtonSizer(flags);
}

wxSizer * bmx_wxdialog_createseparatedbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateSeparatedButtonSizer(flags);
}

wxStdDialogButtonSizer * bmx_wxdialog_createstddialogbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateStdDialogButtonSizer(flags);
}

void bmx_wxdialog_endmodal(wxDialog * dialog, int retCode) {
	dialog->EndModal(retCode);
}

int bmx_wxdialog_getaffirmativeid(wxDialog * dialog) {
	return dialog->GetAffirmativeId();
}

int bmx_wxdialog_getescapeid(wxDialog * dialog) {
	return dialog->GetEscapeId();
}

int bmx_wxdialog_getreturncode(wxDialog * dialog) {
	return dialog->GetReturnCode();
}

void bmx_wxdialog_iconize(wxDialog * dialog, bool value) {
	dialog->Iconize(value);
}

bool bmx_wxdialog_isiconized(wxDialog * dialog) {
	return dialog->IsIconized();
}

bool bmx_wxdialog_ismodal(wxDialog * dialog) {
	return dialog->IsModal();
}

void bmx_wxdialog_setaffirmativeid(wxDialog * dialog, int id) {
	dialog->SetAffirmativeId(id);
}

void bmx_wxdialog_setescapeid(wxDialog * dialog, int id) {
	dialog->SetEscapeId(id);
}

void bmx_wxdialog_seticon(wxDialog * dialog, MaxIcon * icon) {
	dialog->SetIcon(icon->Icon());
}

void bmx_wxdialog_setreturncode(wxDialog * dialog, int retCode) {
	dialog->SetReturnCode(retCode);
}

