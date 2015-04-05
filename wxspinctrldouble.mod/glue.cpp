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

MaxSpinCtrlDouble::MaxSpinCtrlDouble(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& value, int x, int y,
		int w, int h, long style, double min, double max, double initial)
	: wxSpinCtrlDouble(parent, id, value, wxPoint(x, y), wxSize(w, h), style, min, max, initial)
{
	wxbind(this, handle);
}

MaxSpinCtrlDouble::MaxSpinCtrlDouble()
{}

MaxSpinCtrlDouble::~MaxSpinCtrlDouble() {
	wxunbind(this);
}

void MaxSpinCtrlDouble::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------



// *********************************************

BEGIN_EVENT_TABLE(MaxSpinCtrlDouble, wxSpinCtrlDouble)
END_EVENT_TABLE()


MaxSpinCtrlDouble * bmx_wxspinctrldouble_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y,
		int w, int h, long style, double min, double max, double initial) {
	return new MaxSpinCtrlDouble(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, min, max, initial);
}

void bmx_wxspinctrldouble_setvalue(wxSpinCtrlDouble * spin, double value) {
	spin->SetValue(value);
}

void bmx_wxspinctrldouble_settextvalue(wxSpinCtrlDouble * spin, BBString * value) {
	spin->SetValue(wxStringFromBBString(value));
}

void bmx_wxspinctrldouble_setrange(wxSpinCtrlDouble * spin, double minVal, double maxVal) {
	spin->SetRange(minVal, maxVal);
}

void bmx_wxspinctrldouble_setincrement(wxSpinCtrlDouble * spin, double increment) {
	spin->SetIncrement(increment);
}

void bmx_wxspinctrldouble_setdigits(wxSpinCtrlDouble * spin, int digits) {
	spin->SetDigits(digits);
}

double bmx_wxspinctrldouble_getvalue(wxSpinCtrlDouble * spin) {
	return spin->GetValue();
}

double bmx_wxspinctrldouble_getmin(wxSpinCtrlDouble * spin) {
	return spin->GetMin();
}

double bmx_wxspinctrldouble_getmax(wxSpinCtrlDouble * spin) {
	return spin->GetMax();
}

double bmx_wxspinctrldouble_getincrement(wxSpinCtrlDouble * spin) {
	return spin->GetIncrement();
}

int bmx_wxspinctrldouble_getdigits(wxSpinCtrlDouble * spin) {
	return spin->GetDigits();
}

// *********************************************

double bmx_wxspindoubleevent_getvalue(wxSpinDoubleEvent & event) {
	return event.GetValue();
}

void bmx_wxspindoubleevent_setvalue(wxSpinDoubleEvent & event, double pos) {
	event.SetValue(pos);
}

// *********************************************

int bmx_wxspinctrldouble_geteventtype(int type) {

	switch(type) {
		case -1322: return wxEVT_SPINCTRLDOUBLE;
	}
	return 0;
}

