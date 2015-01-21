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
#include "wx/spinctrl.h"
#include "wx/xrc/xh_spin.h"
#include "wx/xml/xml.h"

class MaxSpinCtrl;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxspinctrl_wxSpinCtrl__xrcNew)(wxSpinCtrl * spin);

	MaxSpinCtrl * bmx_wxspinctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y,
		int w, int h, long style, int min, int max, int initial);

	void bmx_wxspinctrl_setvalue(wxSpinCtrl * spin, int value);
	void bmx_wxspinctrl_settextvalue(wxSpinCtrl * spin, BBString * value);
	int bmx_wxspinctrl_getvalue(wxSpinCtrl * spin);
	void bmx_wxspinctrl_setrange(wxSpinCtrl * spin, int minVal, int maxVal);
	void bmx_wxspinctrl_setselection(wxSpinCtrl * spin, int fromPos, int toPos);
	int bmx_wxspinctrl_getmin(wxSpinCtrl * spin);
	int bmx_wxspinctrl_getmax(wxSpinCtrl * spin);

	int bmx_wxspinctrl_geteventtype(int type);
	
	void bmx_wxspinctrl_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSpinCtrl: public wxSpinCtrl
{
public:
	MaxSpinCtrl(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& value, int x, int y,
		int w, int h, long style, int min, int max, int initial);
	MaxSpinCtrl();
	~MaxSpinCtrl();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSpinCtrlXmlHandler : public wxSpinCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSpinCtrlXmlHandler)

public:
    MaxSpinCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};

