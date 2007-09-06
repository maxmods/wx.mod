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

MaxHyperlinkCtrl::MaxHyperlinkCtrl(BBObject * handle, wxWindow * parent, wxWindowID id,
		const wxString& label, const wxString& url, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxHyperlinkCtrl(parent, id, label, url, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxHyperlinkCtrl::~MaxHyperlinkCtrl() {
	wxunbind(this);
}



// *********************************************

MaxHyperlinkCtrl * bmx_wxhperlinkctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id,
		BBString * label, BBString * url, int x, int y, int w, int h, long style) {
	return new MaxHyperlinkCtrl(maxHandle, parent, id, wxStringFromBBString(label), wxStringFromBBString(url),
		x, y, w, h, style);
}

MaxColour * bmx_wxhyperlinkctrl_gethovercolour(wxHyperlinkCtrl * hyper) {
	wxColour c(hyper->GetHoverColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxhyperlinkctrl_getnormalcolour(wxHyperlinkCtrl * hyper) {
	wxColour c(hyper->GetNormalColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxhyperlinkctrl_getvisitedcolour(wxHyperlinkCtrl * hyper) {
	wxColour c(hyper->GetVisitedColour());
	return new MaxColour(c);
}

void bmx_wxhyperlinkctrl_sethovercolour(wxHyperlinkCtrl * hyper, MaxColour * colour) {
	hyper->SetHoverColour(colour->Colour());
}

void bmx_wxhyperlinkctrl_setvisitedcolour(wxHyperlinkCtrl * hyper, MaxColour * colour) {
	hyper->SetVisitedColour(colour->Colour());
}

void bmx_wxhyperlinkctrl_setnormalcolour(wxHyperlinkCtrl * hyper, MaxColour * colour) {
	hyper->SetNormalColour(colour->Colour());
}

bool bmx_wxhyperlinkctrl_getvisited(wxHyperlinkCtrl * hyper) {
	return hyper->GetVisited();
}

void bmx_wxhyperlinkctrl_setvisited(wxHyperlinkCtrl * hyper, bool visited) {
	hyper->SetVisited(visited);
}

BBString * bmx_wxhyperlinkctrl_geturl(wxHyperlinkCtrl * hyper) {
	return bbStringFromWxString(hyper->GetURL());
}

void bmx_wxhyperlinkctrl_seturl(wxHyperlinkCtrl * hyper, BBString * url) {
	hyper->SetURL(wxStringFromBBString(url));
}



int bmx_wxhyperlinkctrl_geteventtype(int type) {
	switch(type) {
		case 3700: return wxEVT_COMMAND_HYPERLINK;
	}
	
	return 0;
}

