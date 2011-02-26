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


MaxSimpleHtmlListBox::MaxSimpleHtmlListBox(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSimpleHtmlListBox(parent, id, wxPoint(x, y), wxSize(w, h), wxArrayString(), style)
{
	wxbind(this, handle);
}

MaxSimpleHtmlListBox::MaxSimpleHtmlListBox()
{}

MaxSimpleHtmlListBox::~MaxSimpleHtmlListBox() {
	wxunbind(this);

	// we need to free any items
	int count = GetCount();
	for (int i = 0; i < count; i++) {
		void * data = GetClientData(i);
		if (data) {
			BBRELEASE((BBObject*)data);
		}
	}
}

void MaxSimpleHtmlListBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxSimpleHtmlListBox, wxSimpleHtmlListBox)
END_EVENT_TABLE()

MaxSimpleHtmlListBox * bmx_wxsimplehtmllistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSimpleHtmlListBox(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxsimplehtmllistbox_getselection(wxSimpleHtmlListBox * listbox) {
	return listbox->GetSelection();
}

int bmx_wxsimplehtmllistbox_getcount(wxSimpleHtmlListBox * listbox) {
	return listbox->GetCount();
}

bool bmx_wxsimplehtmllistbox_isempty(wxSimpleHtmlListBox * listbox) {
	return listbox->IsEmpty();
}

void bmx_wxsimplehtmllistbox_selectitem(wxItemContainerImmutable * listbox, int item) {
	listbox->Select(item);
}

int bmx_wxsimplehtmllistbox_append(wxSimpleHtmlListBox * listbox, BBString * item, BBObject * clientData) {
	if (clientData != &bbNullObject) {
		BBRETAIN(clientData);
	}
	return listbox->Append(wxStringFromBBString(item), clientData);
}

void bmx_wxsimplehtmllistbox_clear(wxSimpleHtmlListBox * listbox) {

	int count = listbox->GetCount();
	for (int i = 0; i < count; i++) {
		void * data = listbox->GetClientData(i);
		if (data) {
			BBRELEASE((BBObject*)data);
		}
	}

	listbox->Clear();
}

void bmx_wxsimplehtmllistbox_deleteitem(wxSimpleHtmlListBox * listbox, int item) {
	void * data = listbox->GetClientData(item);
	if (data) {
		BBRELEASE((BBObject*)data);
	}
	
	listbox->Delete(item);
}

int bmx_wxsimplehtmllistbox_insert(wxSimpleHtmlListBox * listbox, BBString * item, int pos, BBObject * clientData) {
	if (clientData != &bbNullObject) {
		BBRETAIN(clientData);
	}
	return listbox->Insert(wxStringFromBBString(item), pos, clientData);
}

BBString * bmx_wxsimplehtmllistbox_getstring(wxSimpleHtmlListBox * listbox, int item) {
	return bbStringFromWxString(listbox->GetString(item));
}

void bmx_wxsimplehtmllistbox_setselection(wxSimpleHtmlListBox * listbox, int item) {
	listbox->SetSelection(item);
}

void bmx_wxsimplehtmllistbox_appenditems(wxSimpleHtmlListBox * listbox, BBArray * items) {
	listbox->Append(bbStringArrayTowxArrayStr(items));
}

int bmx_wxsimplehtmllistbox_findstring(wxSimpleHtmlListBox * listbox, BBString * text, int caseSensitive) {
	return listbox->FindString(wxStringFromBBString(text), caseSensitive);
}

BBObject * bmx_wxsimplehtmllistbox_getclientdata(wxSimpleHtmlListBox * listbox, int item) {
	void * data = listbox->GetClientData(item);
	if (data) {
		return (BBObject*)data;
	} else {
		return &bbNullObject;
	}
}

BBArray * bmx_wxsimplehtmllistbox_getstrings(wxSimpleHtmlListBox * listbox) {
	return wxArrayStringToBBStringArray(listbox->GetStrings());
}

BBString * bmx_wxsimplehtmllistbox_getstringselection(wxSimpleHtmlListBox * listbox) {
	return bbStringFromWxString(listbox->GetStringSelection());
}

void bmx_wxsimplehtmllistbox_setclientdata(wxSimpleHtmlListBox * listbox, int item, BBObject * clientData) {
	void * data = listbox->GetClientData(item);
	if (data) {
		BBRELEASE((BBObject*)data);
	}
	listbox->SetClientData(item, clientData);
	if (clientData != &bbNullObject) {
		BBRETAIN(clientData);
	}
}

void bmx_wxsimplehtmllistbox_setstring(wxSimpleHtmlListBox * listbox, unsigned int item, BBString * text) {
	listbox->SetString(item, wxStringFromBBString(text));
}

void bmx_wxsimplehtmllistbox_setstringselection(wxSimpleHtmlListBox * listbox, BBString * text) {
	listbox->SetStringSelection(wxStringFromBBString(text));
}


