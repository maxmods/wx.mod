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



// *********************************************


wxXmlResource * bmx_wxxmlresource_get() {
	return wxXmlResource::Get();
}

void bmx_wxxmlresource_initallhandlers(wxXmlResource * res) {
    // these are the handlers, which we always have
    res->AddHandler(new wxUnknownWidgetXmlHandler);
    res->AddHandler(new wxBitmapXmlHandler);
    res->AddHandler(new wxIconXmlHandler);
}

bool bmx_wxxmlresource_load(wxXmlResource * res, BBString * filemask) {
	return res->Load(wxStringFromBBString(filemask));
}

wxFrame * bmx_wxxmlresource_loadframe(wxXmlResource * res, wxWindow * parent, BBString * name) {
	return res->LoadFrame(parent, wxStringFromBBString(name));
}

wxWindow * bmx_wxxmlresource_xrcctrl(wxWindow * parent, BBString * id) {
	return parent->FindWindow(bmx_wxxmlresource_wrcid(id));
}

int bmx_wxxmlresource_wrcid(BBString * name) {
	return wxXmlResource::GetXRCID(wxStringFromBBString(name));
}

wxObject * bmx_wxxmlresource_loadobject(wxXmlResource * res, BBObject * win, wxWindow * parent, 
		BBString * name, BBString * classname) {

	wxObject * obj = res->LoadObject(parent, wxStringFromBBString(name), wxStringFromBBString(classname));
	
	if (obj) {
		// unbind from automatic-newly created object
		wxunbind(obj);
		// bind to *our* newly created object
		wxbind(obj, win);
	}
	
	return obj;
}

void bmx_wxxmlresource_clearhandlers(wxXmlResource * res) {
	res->ClearHandlers();
}

long bmx_wxxmlresource_getflags(wxXmlResource * res) {
	return res->GetFlags();
}

wxDialog * bmx_wxxmlresource_loaddialog(wxXmlResource * res, wxWindow * parent, BBString * name) {
	return res->LoadDialog(parent, wxStringFromBBString(name));
}



