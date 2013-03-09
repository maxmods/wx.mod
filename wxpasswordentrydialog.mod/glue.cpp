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

MaxPasswordEntryDialog::MaxPasswordEntryDialog(BBObject * handle, wxWindow * parent, const wxString& message,
		const wxString& caption, const wxString& defaultValue, long style, int x, int y)
	: wxPasswordEntryDialog(parent, message, caption, defaultValue, style, wxPoint(x, y))
{
	wxbind(this, handle);
}

MaxPasswordEntryDialog::~MaxPasswordEntryDialog() {
	wxunbind(this);
}


// *********************************************

wxPasswordEntryDialog * bmx_wxpasswordentrydialog_create(BBObject * handle, wxWindow * parent, BBString * message,
		BBString * caption, BBString * defaultValue, long style, int x, int y) {

	return new MaxPasswordEntryDialog(handle, parent, wxStringFromBBString(message), wxStringFromBBString(caption),
		wxStringFromBBString(defaultValue), style, x, y);
}


BBString * bmx_wxgetpasswordfromuser(BBString * message, BBString * caption, BBString * defaultValue, wxWindow * parent,
	int x, int y, int centre) {

	if (parent) {
		return bbStringFromWxString(wxGetPasswordFromUser(wxStringFromBBString(message), wxStringFromBBString(caption), wxStringFromBBString(defaultValue), 
			parent, x, y, static_cast<bool>(centre)));
	} else {
		return bbStringFromWxString(wxGetPasswordFromUser(wxStringFromBBString(message), wxStringFromBBString(caption), wxStringFromBBString(defaultValue), 
			NULL, x, y, static_cast<bool>(centre)));
	}
}