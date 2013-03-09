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

MaxProgressDialog::MaxProgressDialog(BBObject * handle, const wxString& title, const wxString& message, int max,
		wxWindow * parent, int style)
	: wxProgressDialog(title, message, max, parent, style)
{
	wxbind(this, handle);
}

MaxProgressDialog::~MaxProgressDialog() {
	wxunbind(this);
}


// *********************************************

wxProgressDialog * bmx_wxprogressdialog_create(BBObject * handle, BBString * title, BBString * message, int maximum, wxWindow * parent, int style) {
	if (parent) {
		return new MaxProgressDialog(handle, wxStringFromBBString(title), wxStringFromBBString(message), maximum, parent, style);
	} else {
		return new MaxProgressDialog(handle, wxStringFromBBString(title), wxStringFromBBString(message), maximum, NULL, style);
	}
}

void bmx_wxprogressdialog_resume(wxProgressDialog * dialog) {
	dialog->Resume();
}

int bmx_wxprogressdialog_updateprogress(wxProgressDialog * dialog, int value, BBString * newMessage, int * skip) {
	bool sk;
	bool ret = dialog->Update(value, wxStringFromBBString(newMessage), &sk);
	*skip = static_cast<int>(sk);
	return static_cast<int>(ret);
}

int bmx_wxprogressdialog_pulse(wxProgressDialog * dialog, BBString * newMessage, bool * skip) {
	bool sk;
	bool ret = dialog->Pulse(wxStringFromBBString(newMessage), &sk);
	*skip = static_cast<int>(sk);
	return static_cast<int>(ret);
}


