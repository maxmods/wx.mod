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

MaxGauge::MaxGauge(BBObject * handle, wxWindow * parent, wxWindowID id, int range, int x, int y,
		int w, int h, long style)
	: wxGauge(parent, id, range, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxGauge::~MaxGauge() {
	wxunbind(this);
}


// *********************************************


MaxGauge * bmx_wxgauge_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int range, int x, int y,
		int w, int h, long style) {

	return new MaxGauge(maxHandle, parent, id, range, x, y, w, h, style);
}

int bmx_wxgauge_getbezelface(wxGauge * gauge) {
	return gauge->GetBezelFace();
}

int bmx_wxgauge_getrange(wxGauge * gauge) {
	return gauge->GetRange();
}

int bmx_wxgauge_getshadowwidth(wxGauge * gauge) {
	return gauge->GetShadowWidth();
}

int bmx_wxgauge_getvalue(wxGauge * gauge) {
	return gauge->GetValue();
}

bool bmx_wxgauge_isvertical(wxGauge * gauge) {
	return gauge->IsVertical();
}

void bmx_wxgauge_setbezelface(wxGauge * gauge, int width) {
	gauge->SetBezelFace(width);
}

void bmx_wxgauge_setrange(wxGauge * gauge, int range) {
	gauge->SetRange(range);
}

void bmx_wxgauge_setshadowwidth(wxGauge * gauge, int width) {
	gauge->SetShadowWidth(width);
}

void bmx_wxgauge_setvalue(wxGauge * gauge, int pos) {
	gauge->SetValue(pos);
}

void bmx_wxgauge_pulse(wxGauge * gauge) {
	gauge->Pulse();
}

