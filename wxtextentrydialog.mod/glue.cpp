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

MaxTextEntryDialog::MaxTextEntryDialog(BBObject * handle, wxWindow * parent, const wxString& message,
		const wxString& caption, const wxString& defaultValue, long style, int x, int y)
	: wxTextEntryDialog(parent, message, caption, defaultValue, style, wxPoint(x, y))
{
	wxbind(this, handle);
}

MaxTextEntryDialog::~MaxTextEntryDialog() {
	wxunbind(this);
}


// *********************************************

wxTextEntryDialog * bmx_wxtextentrydialog_create(BBObject * handle, wxWindow * parent, BBString * message,
		BBString * caption, BBString * defaultValue, long style, int x, int y) {

	return new MaxTextEntryDialog(handle, parent, wxStringFromBBString(message), wxStringFromBBString(caption),
		wxStringFromBBString(defaultValue), style, x, y);
}

BBString * bmx_wxtextentrydialog_getvalue(wxTextEntryDialog * dialog) {
	return bbStringFromWxString(dialog->GetValue());
}

void bmx_wxtextentrydialog_setvalue(wxTextEntryDialog * dialog, BBString * value) {
	dialog->SetValue(wxStringFromBBString(value));
}

int bmx_wxtextentrydialog_showmodal(wxTextEntryDialog * dialog) {
	return dialog->ShowModal();
}



BBString * bmx_wxgettextfromuser(BBString * message, BBString * caption, BBString * defaultValue, wxWindow * parent,
	int x, int y, bool centre) {

	if (parent) {
		return bbStringFromWxString(wxGetTextFromUser(wxStringFromBBString(message), wxStringFromBBString(caption), wxStringFromBBString(defaultValue), 
			parent, x, y, centre));
	} else {
		return bbStringFromWxString(wxGetTextFromUser(wxStringFromBBString(message), wxStringFromBBString(caption), wxStringFromBBString(defaultValue), 
			NULL, x, y, centre));
	}
}