/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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


MaxNumberEntryDialog::MaxNumberEntryDialog(BBObject * handle, wxWindow * parent, const wxString& message,
		const wxString& prompt, const wxString& caption, long value, long min, long max, int x, int y)
	: wxNumberEntryDialog(parent, message, prompt, caption, value, min, max, wxPoint(x, y))
{
	wxbind(this, handle);
}

MaxNumberEntryDialog::~MaxNumberEntryDialog()
{
	wxunbind(this);
}

// *********************************************


long bmx_wxgetnumberfromuser(BBString * message, BBString * prompt, BBString * caption, long value, 
		long min, long max, wxWindow * parent, int x, int y) {

	if (parent) {
		return wxGetNumberFromUser(wxStringFromBBString(message), wxStringFromBBString(prompt), 
			wxStringFromBBString(caption), value, min, max, parent, wxPoint(x, y));
	} else {
		return wxGetNumberFromUser(wxStringFromBBString(message), wxStringFromBBString(prompt), 
			wxStringFromBBString(caption), value, min, max, NULL, wxPoint(x, y));
	}
}

// *********************************************

wxNumberEntryDialog * bmx_wxnumberentrydialog_create(BBObject * handle, wxWindow * parent,
		BBString * message, BBString * prompt, BBString * caption, long value, long minimum, long maximum, int x, int y) {
	return new MaxNumberEntryDialog(handle, parent, wxStringFromBBString(message), wxStringFromBBString(prompt),
		wxStringFromBBString(caption), value, minimum, maximum, x, y);
}

long bmx_wxnumberentrydialog_getvalue(wxNumberEntryDialog * dialog) {
	return dialog->GetValue();
}
