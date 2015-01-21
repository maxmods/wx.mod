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

MaxSearchCtrl::MaxSearchCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style, const wxValidator & val)
	: wxSearchCtrl(parent, id, value, wxPoint(x, y), wxSize(w, h), style, val)
{
	wxbind(this, handle);
}

MaxSearchCtrl::MaxSearchCtrl()
{}

MaxSearchCtrl::~MaxSearchCtrl() {
	wxunbind(this);
}

void MaxSearchCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxSearchCtrlXmlHandler, wxSearchCtrlXmlHandler)

MaxSearchCtrlXmlHandler::MaxSearchCtrlXmlHandler()
	: wxSearchCtrlXmlHandler()
{}

wxObject *MaxSearchCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(ctrl, MaxSearchCtrl)

    ctrl->Create(m_parentAsWindow,
                 GetID(),
                 GetText(wxT("value")),
                 GetPosition(),
                 GetSize(),
                 GetStyle(wxT("style"), wxTE_LEFT),
                 wxDefaultValidator,
                 GetName());

	ctrl->MaxBind(CB_PREF(wx_wxsearchctrl_wxSearchCtrl__xrcNew)(ctrl));

    SetupWindow(ctrl);

    return ctrl;
}

// *********************************************


BEGIN_EVENT_TABLE(MaxSearchCtrl, wxSearchCtrl)
END_EVENT_TABLE()

MaxSearchCtrl * bmx_wxsearchctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style, wxValidator * validator) {
	if (validator) {
		return new MaxSearchCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, *validator);
	} else {
		return new MaxSearchCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, wxDefaultValidator);
	}
}

void bmx_wxsearchctrl_setmenu(wxSearchCtrl * search, wxMenu * menu) {
	search->SetMenu(menu);
}

wxMenu * bmx_wxsearchctrl_getmenu(wxSearchCtrl * search) {
	return search->GetMenu();
}

void bmx_wxsearchctrl_showsearchbutton(wxSearchCtrl * search, int show) {
	search->ShowSearchButton(static_cast<bool>(show));
}

int bmx_wxsearchctrl_issearchbuttonvisible(wxSearchCtrl * search) {
	return static_cast<int>(search->IsSearchButtonVisible());
}

void  bmx_wxsearchctrl_showcancelbutton(wxSearchCtrl * search, int show) {
	search->ShowCancelButton(static_cast<bool>(show));
}

int bmx_wxsearchctrl_iscancelbuttonvisible(wxSearchCtrl * search) {
	return static_cast<int>(search->IsCancelButtonVisible());
}

int bmx_wxsearchctrl_geteventtype(int type) {
	switch(type) {
		case 1119: return wxEVT_COMMAND_SEARCHCTRL_CANCEL_BTN;
		case 1120: return wxEVT_COMMAND_SEARCHCTRL_SEARCH_BTN;
	}
	
	return 0;
}

// *********************************************

void bmx_wxsearchctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxSearchCtrlXmlHandler);
}
