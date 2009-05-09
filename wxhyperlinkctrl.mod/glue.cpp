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

MaxHyperlinkCtrl::MaxHyperlinkCtrl(BBObject * handle, wxWindow * parent, wxWindowID id,
		const wxString& label, const wxString& url, int x, int y, int w, int h, long style)
	: wxHyperlinkCtrl(parent, id, label, url, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxHyperlinkCtrl::MaxHyperlinkCtrl()
{}

MaxHyperlinkCtrl::~MaxHyperlinkCtrl() {
	wxunbind(this);
}

void MaxHyperlinkCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxHyperlinkCtrlXmlHandler, wxHyperlinkCtrlXmlHandler)

MaxHyperlinkCtrlXmlHandler::MaxHyperlinkCtrlXmlHandler()
	: wxHyperlinkCtrlXmlHandler()
{}

wxObject * MaxHyperlinkCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxHyperlinkCtrl)

    control->Create(m_parentAsWindow, GetID(),
        GetParamValue(wxT("label")), GetParamValue(wxT("url")),
        GetPosition(), GetSize(),
        GetStyle(wxT("style"), wxHL_DEFAULT_STYLE),
        GetName());

	control->MaxBind(_wx_wxhyperlinkctrl_wxHyperlinkCtrl__xrcNew(control));

    SetupWindow(control);

    return control;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxHyperlinkCtrl, wxHyperlinkCtrl)
END_EVENT_TABLE()

MaxHyperlinkCtrl * bmx_wxhyperlinkctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id,
		BBString * label, BBString * url, int x, int y, int w, int h, long style) {
	return new MaxHyperlinkCtrl(maxHandle, parent, id, wxStringFromBBString(label), wxStringFromBBString(url),
		x, y, w, h, style);
}

MaxColour * bmx_wxhyperlinkctrl_gethovercolour(wxHyperlinkCtrl * hlink) {
	wxColour c(hlink->GetHoverColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxhyperlinkctrl_getnormalcolour(wxHyperlinkCtrl * hlink) {
	wxColour c(hlink->GetNormalColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxhyperlinkctrl_getvisitedcolour(wxHyperlinkCtrl * hlink) {
	wxColour c(hlink->GetVisitedColour());
	return new MaxColour(c);
}

void bmx_wxhyperlinkctrl_sethovercolour(wxHyperlinkCtrl * hlink, MaxColour * colour) {
	hlink->SetHoverColour(colour->Colour());
}

void bmx_wxhyperlinkctrl_setvisitedcolour(wxHyperlinkCtrl * hlink, MaxColour * colour) {
	hlink->SetVisitedColour(colour->Colour());
}

void bmx_wxhyperlinkctrl_setnormalcolour(wxHyperlinkCtrl * hlink, MaxColour * colour) {
	hlink->SetNormalColour(colour->Colour());
}

bool bmx_wxhyperlinkctrl_getvisited(wxHyperlinkCtrl * hlink) {
	return hlink->GetVisited();
}

void bmx_wxhyperlinkctrl_setvisited(wxHyperlinkCtrl * hlink, bool visited) {
	hlink->SetVisited(visited);
}

BBString * bmx_wxhyperlinkctrl_geturl(wxHyperlinkCtrl * hlink) {
	return bbStringFromWxString(hlink->GetURL());
}

void bmx_wxhyperlinkctrl_seturl(wxHyperlinkCtrl * hlink, BBString * url) {
	hlink->SetURL(wxStringFromBBString(url));
}

BBString * bmx_wxhyperlinkevent_geturl(wxHyperlinkEvent & event) {
	return bbStringFromWxString(event.GetURL());
}

void bmx_wxhyperlinkevent_seturl(wxHyperlinkEvent & event, BBString * url) {
	event.SetURL(wxStringFromBBString(url));
}


int bmx_wxhyperlinkctrl_geteventtype(int type) {
	switch(type) {
		case 3700: return wxEVT_COMMAND_HYPERLINK;
	}
	
	return 0;
}

// *********************************************

void bmx_wxhyperlinkctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxHyperlinkCtrlXmlHandler);
}
