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

#ifndef _WX_MAX_SPINCTRLDOUBLE_H_
#define _WX_MAX_SPINCTRLDOUBLE_H_

#include "wxglue.h"
#include "wx/spinctrl.h"

class MaxSpinCtrlDouble;

extern "C" {

#include <blitz.h>

	MaxSpinCtrlDouble * bmx_wxspinctrldouble_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y,
		int w, int h, long style, double min, double max, double initial);

	void bmx_wxspinctrldouble_setvalue(wxSpinCtrlDouble * spin, double value);
	void bmx_wxspinctrldouble_settextvalue(wxSpinCtrlDouble * spin, BBString * value);
	void bmx_wxspinctrldouble_setrange(wxSpinCtrlDouble * spin, double minVal, double maxVal);
	void bmx_wxspinctrldouble_setincrement(wxSpinCtrlDouble * spin, double increment);
	void bmx_wxspinctrldouble_setdigits(wxSpinCtrlDouble * spin, int digits);
	double bmx_wxspinctrldouble_getvalue(wxSpinCtrlDouble * spin);
	double bmx_wxspinctrldouble_getmin(wxSpinCtrlDouble * spin);
	double bmx_wxspinctrldouble_getmax(wxSpinCtrlDouble * spin);
	double bmx_wxspinctrldouble_getincrement(wxSpinCtrlDouble * spin);
	int bmx_wxspinctrldouble_getdigits(wxSpinCtrlDouble * spin);

	double bmx_wxspindoubleevent_getvalue(wxSpinDoubleEvent & event);
	void bmx_wxspindoubleevent_setvalue(wxSpinDoubleEvent & event, double pos);

	int bmx_wxspinctrldouble_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSpinCtrlDouble: public wxSpinCtrlDouble
{
public:
	MaxSpinCtrlDouble(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& value, int x, int y,
		int w, int h, long style, double min, double max, double initial);
	MaxSpinCtrlDouble();
	~MaxSpinCtrlDouble();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#endif // _WX_MAX_SPINCTRLDOUBLE_H_
