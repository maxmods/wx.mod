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


MaxButton::MaxButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxButton(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxButton::~MaxButton() {
	wxunbind(this);
}


// *********************************************

MaxButton * bmx_wxbutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxButton(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

BBString * bmx_wxbutton_getlabel(MaxButton * button) {
	return bbStringFromWxString(button->GetLabel());
}

void bmx_wxbutton_getdefaultsize(MaxButton * button, int * width, int * height) {
	wxSize size = button->GetDefaultSize();
	*width = size.x;
	*height = size.y;
}

void bmx_wxbutton_setdefault(MaxButton * button) {
	button->SetDefault();
}

void bmx_wxbutton_setlabel(MaxButton * button, BBString * label) {
	button->SetLabel(wxStringFromBBString(label));
}

int bmx_wxbutton_geteventtype(int type) {
	switch(type) {
		case 1: return wxEVT_COMMAND_BUTTON_CLICKED;
	}
	
	return 0;
}

