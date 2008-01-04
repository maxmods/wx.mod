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

MaxFindReplaceDialog::MaxFindReplaceDialog(BBObject * handle, wxWindow * parent, wxFindReplaceData * data, const wxString& title, int style)
	: wxFindReplaceDialog(parent, data, title, style)
{
	wxbind(this, handle);
}

MaxFindReplaceDialog::~MaxFindReplaceDialog() {
	wxunbind(this);
}


// *********************************************


MaxFindReplaceDialog * bmx_wxfindreplacedialog_create(BBObject * handle, wxWindow * parent, wxFindReplaceData * data, BBString * title, int style) {
	return new MaxFindReplaceDialog(handle, parent, data, wxStringFromBBString(title), style);
}

wxFindReplaceData * bmx_wxfindreplacedata_create(BBObject * handle, wxUint32 flags) {
	wxFindReplaceData * data = new wxFindReplaceData(flags);
	wxbind(data, handle);
	return data;
}

BBString * bmx_wxfindreplacedata_getfindstring(wxFindReplaceData * data) {
	return bbStringFromWxString(data->GetFindString());
}

BBString * bmx_wxfindreplacedata_getreplacestring(wxFindReplaceData * data) {
	return bbStringFromWxString(data->GetReplaceString());
}

int bmx_wxfindreplacedata_getflags(wxFindReplaceData * data) {
	return data->GetFlags();
}

void bmx_wxfindreplacedata_setflags(wxFindReplaceData * data, int flags) {
	data->SetFlags(flags);
}

void bmx_wxfindreplacedata_setfindstring(wxFindReplaceData * data, BBString * str) {
	data->SetFindString(wxStringFromBBString(str));
}

void bmx_wxfindreplacedata_setreplacestring(wxFindReplaceData * data, BBString * str) {
	data->SetReplaceString(wxStringFromBBString(str));
}

void bmx_wxfindreplacedata_free(wxFindReplaceData * data) {
	wxunbind(data);
	delete data;
}


int bmx_wxfinddialogevent_getflags(wxFindDialogEvent & event) {
	return event.GetFlags();
}

BBString * bmx_wxfinddialogevent_getfindstring(wxFindDialogEvent & event) {
	return bbStringFromWxString(event.GetFindString());
}

BBString * bmx_wxfinddialogevent_getreplacestring(wxFindDialogEvent & event) {
	return bbStringFromWxString(event.GetReplaceString());
}

wxFindReplaceDialog * bmx_wxfinddialogevent_getdialog(wxFindDialogEvent & event) {
	return event.GetDialog();
}




int bmx_wxfindreplacedialog_geteventtype(int type) {

}

