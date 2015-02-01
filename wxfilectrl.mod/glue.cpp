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

MaxFileCtrl::MaxFileCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * defaultDirectory, BBString * defaultFilename, BBString * wildcard, 
		int x, int y, int w, int h, long style)
	: maxHandle(handle), wxFileCtrl(parent, id, wxStringFromBBString(defaultDirectory), wxStringFromBBString(defaultFilename), wxStringFromBBString(wildcard), style, wxPoint(x, y), wxSize(w, h))
{
	wxbind(this, handle);
}

MaxFileCtrl::MaxFileCtrl()
{}

MaxFileCtrl::~MaxFileCtrl() {
	wxunbind(this);
}

void MaxFileCtrl::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxFileCtrlXmlHandler, wxFileCtrlXmlHandler)

MaxFileCtrlXmlHandler::MaxFileCtrlXmlHandler()
	: wxFileCtrlXmlHandler()
{}


wxObject * MaxFileCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(filectrl, MaxFileCtrl)

    filectrl->Create(m_parentAsWindow,
                     GetID(),
                     GetText(wxT("defaultdirectory")),
                     GetText(wxT("defaultfilename")),
                     GetParamValue(wxT("wildcard")),
                     GetStyle(wxT("style"), wxFC_DEFAULT_STYLE),
                     GetPosition(),
                     GetSize(),
                     GetName());

	filectrl->MaxBind(CB_PREF(wx_wxfilectrl_wxFileCtrl__xrcNew)(filectrl));

    SetupWindow(filectrl);
    return filectrl;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxFileCtrl, wxFileCtrl)
END_EVENT_TABLE()

MaxFileCtrl * bmx_wxfilectrl_create(BBObject * handle, wxWindow * parent, int id, BBString * defaultDirectory, BBString * defaultFilename, BBString * wildcard, int x, int y, int w, int h, int style) {
	return new MaxFileCtrl(handle, parent, id, defaultDirectory, defaultFilename, wildcard, x, y, w, h, style);
}

BBString * bmx_wxfilectrl_getdirectory(wxFileCtrl * control) {
	return bbStringFromWxString(control->GetDirectory());
}

BBString * bmx_wxfilectrl_getfilename(wxFileCtrl * control) {
	return bbStringFromWxString(control->GetFilename());
}

BBArray * bmx_wxfilectrl_getfilenames(wxFileCtrl * control) {
	wxArrayString arr;
	control->GetFilenames(arr);
	return wxArrayStringToBBStringArray(arr);
}

int bmx_wxfilectrl_getfilterindex(wxFileCtrl * control) {
	return control->GetFilterIndex();
}

BBString * bmx_wxfilectrl_getpath(wxFileCtrl * control) {
	return bbStringFromWxString(control->GetPath());
}

BBArray * bmx_wxfilectrl_getpaths(wxFileCtrl * control) {
	wxArrayString arr;
	control->GetPaths(arr);
	return wxArrayStringToBBStringArray(arr);
}

BBString * bmx_wxfilectrl_getwildcard(wxFileCtrl * control) {
	return bbStringFromWxString(control->GetWildcard());
}

int bmx_wxfilectrl_setdirectory(wxFileCtrl * control, BBString * directory) {
	return control->SetDirectory(wxStringFromBBString(directory));
}

int bmx_wxfilectrl_setfilename(wxFileCtrl * control, BBString * filename) {
	return control->SetFilename(wxStringFromBBString(filename));
}

int bmx_wxfilectrl_setpath(wxFileCtrl * control, BBString * path) {
	return control->SetPath(wxStringFromBBString(path));
}

void bmx_wxfilectrl_setfilterindex(wxFileCtrl * control, int index) {
	control->SetFilterIndex(index);
}

void bmx_wxfilectrl_setwildcard(wxFileCtrl * control, BBString * wildcard) {
	control->SetWildcard(wxStringFromBBString(wildcard));
}

void bmx_wxfilectrl_showhidden(wxFileCtrl * control, int show) {
	control->ShowHidden(show);
}
	
// *********************************************

BBString * bmx_wxfilectrlevent_getdirectory(wxFileCtrlEvent * event) {
	return bbStringFromWxString(event->GetDirectory());
}

BBString * bmx_wxfilectrlevent_getfile(wxFileCtrlEvent * event) {
	return bbStringFromWxString(event->GetFile());
}

BBArray * bmx_wxfilectrlevent_getfiles(wxFileCtrlEvent * event) {
	return wxArrayStringToBBStringArray(event->GetFiles());
}

int bmx_wxfilectrlevent_getfilterindex(wxFileCtrlEvent * event) {
	return event->GetFilterIndex();
}

void bmx_wxfilectrlevent_setfiles(wxFileCtrlEvent * event, BBArray * files) {
	event->SetFiles(bbStringArrayTowxArrayStr(files));
}

void bmx_wxfilectrlevent_setdirectory(wxFileCtrlEvent * event, BBString * directory) {
	event->SetDirectory(wxStringFromBBString(directory));
}

void bmx_wxfilectrlevent_setfilterindex(wxFileCtrlEvent * event, int index) {
	event->SetFilterIndex(index);
}

// *********************************************

int bmx_wxfilectrl_geteventtype(int type) {
	switch(type) {
		case -140: return wxEVT_FILECTRL_SELECTIONCHANGED;
		case -141: return wxEVT_FILECTRL_FILEACTIVATED;
		case -142: return wxEVT_FILECTRL_FOLDERCHANGED;
		case -143: return wxEVT_FILECTRL_FILTERCHANGED;
	}
	
	return 0;
}

void bmx_wxfilectrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxFileCtrlXmlHandler);
}
