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

#include "wxglue.h"
#include "wx/clrpicker.h"

class MaxColourPickerCtrl;

extern "C" {

#include <blitz.h>

	MaxColourPickerCtrl * bmx_wxcolourpickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		MaxColour * colour, int x, int y, int w, int h, long style);
	MaxColour * bmx_wxcolourpickerctrl_getcolour(wxColourPickerCtrl * picker);
	void bmx_wxcolourpickerctrl_setcolour(wxColourPickerCtrl * picker, MaxColour * colour);
	void bmx_wxcolourpickerctrl_setcolourname(wxColourPickerCtrl * picker, BBString * name);

	MaxColour * bmx_wxcolourpickerevent_getcolour(wxColourPickerEvent & event);
	void bmx_wxcolourpickerevent_setcolour(wxColourPickerEvent & event, MaxColour * colour);

	int bmx_wxcolourpickerctrl_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxColourPickerCtrl : public wxColourPickerCtrl
{
public:
	MaxColourPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxColour& colour, int x, int y,
		int w, int h, long style);
	~MaxColourPickerCtrl();
	
};
