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

MaxDirDialog::MaxDirDialog(BBObject * handle, wxWindow * parent, const wxString& message, const wxString& defaultPath,
		long style, int x, int y, int w, int h)
	: wxDirDialog(parent, message, defaultPath, style, wxPoint(x, y), wxSize(w, h))
{
	wxbind(this, handle);
}

MaxDirDialog::~MaxDirDialog() {
	wxunbind(this);
}


// *********************************************


MaxDirDialog * bmx_wxdirdialog_create(BBObject * handle, wxWindow * parent, BBString * message, 
		BBString * defaultPath, long style, int x, int y, int w, int h) {
	return new MaxDirDialog(handle, parent, wxStringFromBBString(message), wxStringFromBBString(defaultPath),
		style, x, y, w, h);
}

BBString * bmx_wxdirdialog_getpath(MaxDirDialog * dir) {
	return bbStringFromWxString(dir->GetPath());
}

BBString * bmx_wxdirdialog_getmessage(MaxDirDialog * dir) {
	return bbStringFromWxString(dir->GetMessage());
}

void bmx_wxdirdialog_setmessage(MaxDirDialog * dir, BBString * message) {
	dir->SetMessage(wxStringFromBBString(message));
}

void bmx_wxdirdialog_setpath(MaxDirDialog * dir, BBString * path) {
	dir->SetPath(wxStringFromBBString(path));
}

int bmx_wxdirdialog_showmodal(MaxDirDialog * dir) {
	return dir->ShowModal();
}

BBString * bmx_wxdirselector(BBString * message, BBString * defaultPath, long style, int x, int y, wxWindow *parent) {
	if (parent) {
		return bbStringFromWxString(wxDirSelector(wxStringFromBBString(message), wxStringFromBBString(defaultPath), 
			style, wxPoint(x, y), parent));
	} else {
		return bbStringFromWxString(wxDirSelector(wxStringFromBBString(message), wxStringFromBBString(defaultPath), 
			style, wxPoint(x, y), NULL));
	}
}

