/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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
#include "wx/activityindicator.h"
#include "wx/xrc/xh_activityindicator.h"

class MaxActivityIndicator;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxactivityindicator_wxActivityIndicator__xrcNew)(wxActivityIndicator * indicator);

	wxActivityIndicator * bmx_wxactivityindicator_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, int style);
	void bmx_wxactivityindicator_start(wxActivityIndicator * indicator);
	void bmx_wxactivityindicator_stop(wxActivityIndicator * indicator);
	int bmx_wxactivityindicator_isrunning(wxActivityIndicator * indicator);

	void bmx_wxactivityindicator_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxActivityIndicator : public wxActivityIndicator
{
public:
	MaxActivityIndicator(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxActivityIndicator();
	~MaxActivityIndicator();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxActivityIndicatorXmlHandler : public wxActivityIndicatorXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxActivityIndicatorXmlHandler)

public:
    MaxActivityIndicatorXmlHandler();
    virtual wxObject *DoCreateResource();
};
