/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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
#include "wx/slider.h"
#include "wx/xrc/xh_slidr.h"
#include "wx/xml/xml.h"

class MaxSlider;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxslider_wxSlider__xrcNew)(wxSlider * slider);

	MaxSlider * bmx_wxslider_create(BBObject * handle, wxWindow * parent, int id, int value,
			int minValue, int maxValue, int x, int y, int w, int h, long style);
	int bmx_wxslider_getlinesize(wxSlider * slider);
	int bmx_wxslider_getmax(wxSlider * slider);
	int bmx_wxslider_getmin(wxSlider * slider);
	int bmx_wxslider_getpagesize(wxSlider * slider);
	int bmx_wxslider_getvalue(wxSlider * slider);
	void bmx_wxslider_setlinesize(wxSlider * slider, int size);
	void bmx_wxslider_setpagesize(wxSlider * slider, int size);
	void bmx_wxslider_setrange(wxSlider * slider, int minValue, int maxValue);
	void bmx_wxslider_setvalue(wxSlider * slider, int value);

	void bmx_wxslider_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSlider : public wxSlider
{
public:
	MaxSlider(BBObject * handle, wxWindow * parent, wxWindowID id, int value, int minValue, int maxValue, 
			int x, int y, int w, int h, long style);
	MaxSlider();
	~MaxSlider();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSliderXmlHandler : public wxSliderXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSliderXmlHandler)

public:
    MaxSliderXmlHandler();
    virtual wxObject *DoCreateResource();
};
