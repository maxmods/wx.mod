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

MaxStatusBar::MaxStatusBar(wxWindow * parent, long style, wxWindowID id, const wxString& name)
	: wxStatusBar(parent, id, style, name)
{
}

MaxStatusBar::MaxStatusBar(BBObject * handle, wxWindow * parent, wxWindowID id, long style)
	: wxStatusBar(parent, id, style)
{
	wxbind(this, handle);
}

void MaxStatusBar::injectSelf(BBObject * handle) {
	wxbind(this, handle);
}

MaxStatusBar::~MaxStatusBar() {
	wxunbind(this);
}

// *********************************************



void bmx_wxstatusbar_injectSelf(MaxStatusBar * statusbar, BBObject * handle) {
	statusbar->injectSelf(handle);
}

BEGIN_EVENT_TABLE(MaxStatusBar, wxStatusBar)
END_EVENT_TABLE()


MaxStatusBar * bmx_wxstatusbar_create(BBObject * handle, wxWindow * parent, int id, long style) {
	return new MaxStatusBar(handle, parent, id, style);
}

bool bmx_wxstatusbar_getfieldrect(wxStatusBar * statusbar, int index, int * x, int * y, int * w, int * h) {
	wxRect r;
	bool ret = statusbar->GetFieldRect(index, r);
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
	return ret;
}

int bmx_wxstatusbar_getfieldscount(wxStatusBar * statusbar) {
	return statusbar->GetFieldsCount();
}

BBString *  bmx_wxstatusbar_getstatustext(wxStatusBar * statusbar, int index) {
	return bbStringFromWxString(statusbar->GetStatusText(index));
}

void bmx_wxstatusbar_popstatustext(wxStatusBar * statusbar, int index) {
	statusbar->PopStatusText(index);
}

void bmx_wxstatusbar_pushstatustext(wxStatusBar * statusbar, BBString * text, int index) {
	statusbar->PushStatusText(wxStringFromBBString(text), index);
}

void bmx_wxstatusbar_setfieldscount(wxStatusBar * statusbar, int count) {
	statusbar->SetFieldsCount(count);
}

void bmx_wxstatusbar_setminheight(wxStatusBar * statusbar, int height) {
	statusbar->SetMinHeight(height);
}

void bmx_wxstatusbar_setstatustext(wxStatusBar * statusbar, BBString * text, int index) {
	statusbar->SetStatusText(wxStringFromBBString(text), index);
}

void bmx_wxstatusbar_setstatuswidths(wxStatusBar * statusbar, BBArray * widths) {
	statusbar->SetStatusWidths(widths->scales[0], (int*)BBARRAYDATA( widths, widths->dims ));
}

void bmx_wxstatusbar_setstatusstyles(wxStatusBar * statusbar, BBArray * styles) {
	statusbar->SetStatusStyles(styles->scales[0], (int*)BBARRAYDATA( styles, styles->dims ));
}

