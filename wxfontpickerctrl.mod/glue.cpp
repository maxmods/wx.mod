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

MaxFontPickerCtrl::MaxFontPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxFont& font, int x, int y,
		int w, int h, long style)
	: wxFontPickerCtrl(parent, id, font, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxFontPickerCtrl::~MaxFontPickerCtrl() {
	wxunbind(this);
}


// *********************************************

MaxFontPickerCtrl * bmx_wxfontpickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		MaxFont * font, int x, int y, int w, int h, long style) {
	if (font) {
		return new MaxFontPickerCtrl(handle, parent, id, font->Font(), x, y, w, h, style);
	} else {
		return new MaxFontPickerCtrl(handle, parent, id, wxNullFont, x, y, w, h, style);
	}
}

MaxFont * bmx_wxfontpickerctrl_getselectedfont(wxFontPickerCtrl * picker) {
	wxFont f(picker->GetSelectedFont());
	return new MaxFont(f);
}

void bmx_wxfontpickerctrl_setselectedfont(wxFontPickerCtrl * picker, MaxFont * font) {
	picker->SetSelectedFont(font->Font());
}

unsigned int bmx_wxfontpickerctrl_getmaxpointsize(wxFontPickerCtrl * picker) {
	return picker->GetMaxPointSize();
}

void bmx_wxfontpickerctrl_setmaxpointsize(wxFontPickerCtrl * picker, unsigned int value) {
	picker->SetMaxPointSize(value);
}


MaxFont * bmx_wxfontpickerevent_getfont(wxFontPickerEvent & event) {
	wxFont f(event.GetFont());
	return new MaxFont(f);
}

void bmx_wxfontpickerevent_setfont(wxFontPickerEvent & event, MaxFont * font) {
	event.SetFont(font->Font());
}


int bmx_wxfontpickerctrl_geteventtype(int type) {
	switch(type) {
		case 11022: return wxEVT_COMMAND_FONTPICKER_CHANGED;
	}
	
	return 0;
}

