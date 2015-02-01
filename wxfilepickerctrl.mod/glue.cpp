/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

MaxFilePickerCtrl::MaxFilePickerCtrl()
{}

MaxFilePickerCtrl::~MaxFilePickerCtrl() {
	wxunbind(this);
}

void MaxFilePickerCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

MaxDirPickerCtrl::MaxDirPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& path,
		const wxString& message, int x, int y, int w, int h, long style)
	: wxDirPickerCtrl(parent, id, path, message, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxDirPickerCtrl::MaxDirPickerCtrl()
{}

MaxDirPickerCtrl::~MaxDirPickerCtrl() {
	wxunbind(this);
}

void MaxDirPickerCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxFilePickerCtrlXmlHandler, wxFilePickerCtrlXmlHandler)

MaxFilePickerCtrlXmlHandler::MaxFilePickerCtrlXmlHandler()
	: wxFilePickerCtrlXmlHandler()
{}


wxObject * MaxFilePickerCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(picker, MaxFilePickerCtrl)

    picker->Create(m_parentAsWindow,
                  GetID(),
                  GetParamValue(wxT("value")),
                  GetParamValue(wxT("message")),
                  GetParamValue(wxT("wildcard")),
                  GetPosition(), GetSize(),
                  GetStyle(_T("style"), wxFLP_DEFAULT_STYLE),
                  wxDefaultValidator,
                  GetName());

	picker->MaxBind(CB_PREF(wx_wxfilepickerctrl_wxFilePickerCtrl__xrcNew)(picker));

    SetupWindow(picker);
    return picker;

}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxDirPickerCtrlXmlHandler, wxDirPickerCtrlXmlHandler)

MaxDirPickerCtrlXmlHandler::MaxDirPickerCtrlXmlHandler()
	: wxDirPickerCtrlXmlHandler()
{}


wxObject * MaxDirPickerCtrlXmlHandler::DoCreateResource()
{
   XRC_MAKE_INSTANCE(picker, MaxDirPickerCtrl)

   picker->Create(m_parentAsWindow,
                  GetID(),
                  GetParamValue(wxT("value")),
                  GetParamValue(wxT("message")),
                  GetPosition(), GetSize(),
                  GetStyle(_T("style"), wxDIRP_DEFAULT_STYLE),
                  wxDefaultValidator,
                  GetName());

	picker->MaxBind(CB_PREF(wx_wxfilepickerctrl_wxDirPickerCtrl__xrcNew)(picker));

    SetupWindow(picker);

    return picker;

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


BBString * bmx_wxfiledirpickerevent_getpath(wxFileDirPickerEvent & event) {
	return bbStringFromWxString(event.GetPath());
}

void bmx_wxfiledirpickerevent_setpath(wxFileDirPickerEvent & event, BBString * path) {
	event.SetPath(wxStringFromBBString(path));
}


int bmx_wxfilepickerctrl_geteventtype(int type) {
	switch(type) {
		case 11021: return wxEVT_COMMAND_FILEPICKER_CHANGED;
		case 11031: return wxEVT_COMMAND_DIRPICKER_CHANGED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxfiledir_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxFilePickerCtrlXmlHandler);
	wxXmlResource::Get()->AddHandler(new MaxDirPickerCtrlXmlHandler);
}
