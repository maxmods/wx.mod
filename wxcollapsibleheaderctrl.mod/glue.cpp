/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxCollapsibleHeaderCtrl::MaxCollapsibleHeaderCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxCollapsibleHeaderCtrl(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxCollapsibleHeaderCtrl::MaxCollapsibleHeaderCtrl()
{}

MaxCollapsibleHeaderCtrl::~MaxCollapsibleHeaderCtrl() {
	wxunbind(this);
}

void MaxCollapsibleHeaderCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// *********************************************

BEGIN_EVENT_TABLE(MaxCollapsibleHeaderCtrl, wxCollapsibleHeaderCtrl)
END_EVENT_TABLE()

wxCollapsibleHeaderCtrl * bmx_wxcollapsibleheaderctrl_create(BBObject * handle, wxWindow * parent, int id, BBString * label, int x, int y, int w, int h, int style) {
	return new MaxCollapsibleHeaderCtrl(handle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

void bmx_wxcollapsibleheaderctrl_setcollapsed(wxCollapsibleHeaderCtrl * ctrl, int collapsed) {
	ctrl->SetCollapsed(static_cast<bool>(collapsed));
}

int bmx_wxcollapsibleheaderctrl_iscollapsed(wxCollapsibleHeaderCtrl * ctrl) {
	return static_cast<int>(ctrl->IsCollapsed());
}


int bmx_wxcollapsibleheaderctrl_geteventtype(int evt) {
	switch(evt) {
		case -500: return wxEVT_COLLAPSIBLEHEADER_CHANGED;
	}
	
	return 0;
}


