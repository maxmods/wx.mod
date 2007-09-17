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

MaxColourPickerCtrl::MaxColourPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxColour& colour, int x, int y,
		int w, int h, long style)
	: wxColourPickerCtrl(parent, id, colour, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxColourPickerCtrl::~MaxColourPickerCtrl() {
	wxunbind(this);
}


// *********************************************

MaxColourPickerCtrl * bmx_wxcolourpickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		MaxColour * colour, int x, int y, int w, int h, long style) {
	if (colour) {
		return new MaxColourPickerCtrl(handle, parent, id, colour->Colour(), x, y, w, h, style);
	} else {
		return new MaxColourPickerCtrl(handle, parent, id, *wxBLACK, x, y, w, h, style);
	}
}

MaxColour * bmx_wxcolourpickerctrl_getcolour(wxColourPickerCtrl * picker) {
	wxColour c(picker->GetColour());
	return new MaxColour(c);
}

void bmx_wxcolourpickerctrl_setcolour(wxColourPickerCtrl * picker, MaxColour * colour) {
	picker->SetColour(colour->Colour());
}

void bmx_wxcolourpickerctrl_setcolourname(wxColourPickerCtrl * picker, BBString * name) {
	picker->SetColour(wxStringFromBBString(name));
}

MaxColour * bmx_wxcolourpickerevent_getcolour(wxColourPickerEvent & event) {
	wxColour c(event.GetColour());
	return new MaxColour(c);
}

void bmx_wxcolourpickerevent_setcolour(wxColourPickerEvent & event, MaxColour * colour) {
	event.SetColour(colour->Colour());
}


int bmx_wxcolourpickerctrl_geteventtype(int type) {
	switch(type) {
		case 11020: return wxEVT_COMMAND_COLOURPICKER_CHANGED;
	}
	
	return 0;
}

