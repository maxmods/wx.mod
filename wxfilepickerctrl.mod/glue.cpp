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

MaxFilePickerCtrl::MaxFilePickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& path,
		const wxString& message, const wxString& wildcard, int x, int y, int w, int h, long style)
	: wxFilePickerCtrl(parent, id, path, message, wildcard, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxFilePickerCtrl::~MaxFilePickerCtrl() {
	wxunbind(this);
}

MaxDirPickerCtrl::MaxDirPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& path,
		const wxString& message, int x, int y, int w, int h, long style)
	: wxDirPickerCtrl(parent, id, path, message, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxDirPickerCtrl::~MaxDirPickerCtrl() {
	wxunbind(this);
}

// *********************************************

BEGIN_EVENT_TABLE(MaxFilePickerCtrl, wxFilePickerCtrl)
END_EVENT_TABLE()

MaxFilePickerCtrl * bmx_wxfilepickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		BBString * path, BBString * message, BBString * wildcard, int x, int y, int w, int h, long style) {
	return new MaxFilePickerCtrl(handle, parent, id, wxStringFromBBString(path), wxStringFromBBString(message),
		wxStringFromBBString(wildcard), x, y, w, h, style);
}

BBString * bmx_wxfilepickerctrl_getpath(wxFilePickerCtrl * picker) {
	return bbStringFromWxString(picker->GetPath());
}

void bmx_wxfilepickerctrl_setpath(wxFilePickerCtrl * picker, BBString * filename) {
	picker->SetPath(wxStringFromBBString(filename));
}

BEGIN_EVENT_TABLE(MaxDirPickerCtrl, wxDirPickerCtrl)
END_EVENT_TABLE()

MaxDirPickerCtrl * bmx_wxdirpickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		BBString * path, BBString * message, int x, int y, int w, int h, long style) {
	return new MaxDirPickerCtrl(handle, parent, id, wxStringFromBBString(path), wxStringFromBBString(message),
		x, y, w, h, style);
}

BBString * bmx_wxdirpickerctrl_getpath(wxDirPickerCtrl * picker) {
	return bbStringFromWxString(picker->GetPath());
}

void bmx_wxdirpickerctrl_setpath(wxDirPickerCtrl * picker, BBString * dirname) {
	picker->SetPath(wxStringFromBBString(dirname));
}


BBString * wx_wxfiledirpickerevent_getpath(wxFileDirPickerEvent & event) {
	return bbStringFromWxString(event.GetPath());
}

void wx_wxfiledirpickerevent_setpath(wxFileDirPickerEvent & event, BBString * path) {
	event.SetPath(wxStringFromBBString(path));
}


int bmx_wxfilepickerctrl_geteventtype(int type) {
	switch(type) {
		case 11021: return wxEVT_COMMAND_FILEPICKER_CHANGED;
		case 11031: return wxEVT_COMMAND_DIRPICKER_CHANGED;
	}
	
	return 0;
}

