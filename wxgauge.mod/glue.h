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
#include "wx/gauge.h"
#include "wx/xrc/xh_gauge.h"
#include "wx/xml/xml.h"

class MaxGauge;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxgauge_wxGauge__xrcNew)(wxGauge * gauge);

	MaxGauge * bmx_wxgauge_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int range, int x, int y,
		int w, int h, long style);
	int bmx_wxgauge_getbezelface(wxGauge * gauge);
	int bmx_wxgauge_getrange(wxGauge * gauge);
	int bmx_wxgauge_getshadowwidth(wxGauge * gauge);
	int bmx_wxgauge_getvalue(wxGauge * gauge);
	int bmx_wxgauge_isvertical(wxGauge * gauge);
	void bmx_wxgauge_setbezelface(wxGauge * gauge, int width);
	void bmx_wxgauge_setrange(wxGauge * gauge, int range);
	void bmx_wxgauge_setshadowwidth(wxGauge * gauge, int width);
	void bmx_wxgauge_setvalue(wxGauge * gauge, int pos);
	void bmx_wxgauge_pulse(wxGauge * gauge);

	void bmx_wxgauge_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGauge : public wxGauge
{
public:
	MaxGauge(BBObject * handle, wxWindow * parent, wxWindowID id, int range, int x, int y,
		int w, int h, long style);
	MaxGauge();
	~MaxGauge();

	void MaxBind(BBObject * handle);
	
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGaugeXmlHandler : public wxGaugeXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxGaugeXmlHandler)

public:
    MaxGaugeXmlHandler();
    virtual wxObject *DoCreateResource();
};
