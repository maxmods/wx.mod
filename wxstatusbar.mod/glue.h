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
#include "wx/xrc/xh_statbar.h"
#include "wx/xml/xml.h"

class MaxStatusBar;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxstatusbar_wxStatusBar__xrcNew)(wxStatusBar * statusbar);

	void bmx_wxstatusbar_injectSelf(MaxStatusBar * statusbar, BBObject * handle);
	
	MaxStatusBar * bmx_wxstatusbar_create(BBObject * handle, wxWindow * parent, int id, long style);
	int bmx_wxstatusbar_getfieldrect(wxStatusBar * statusbar, int index, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxstatusbar_getfieldrectrect(wxStatusBar * statusbar, int index);
	int bmx_wxstatusbar_getfieldscount(wxStatusBar * statusbar);
	BBString *  bmx_wxstatusbar_getstatustext(wxStatusBar * statusbar, int index);
	void bmx_wxstatusbar_popstatustext(wxStatusBar * statusbar, int index);
	void bmx_wxstatusbar_pushstatustext(wxStatusBar * statusbar, BBString * text, int index);
	void bmx_wxstatusbar_setfieldscount(wxStatusBar * statusbar, int count);
	void bmx_wxstatusbar_setminheight(wxStatusBar * statusbar, int height);
	void bmx_wxstatusbar_setstatustext(wxStatusBar * statusbar, BBString * text, int index);
	void bmx_wxstatusbar_setstatuswidths(wxStatusBar * statusbar, BBArray * widths);
	void bmx_wxstatusbar_setstatusstyles(wxStatusBar * statusbar, BBArray * styles);

	void bmx_wxstatusbar_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxStatusBar : public wxStatusBar
{
public:
	MaxStatusBar(wxWindow * parent, long style, wxWindowID id, const wxString& name);
	MaxStatusBar(BBObject * handle, wxWindow * parent, wxWindowID id, long style);
	MaxStatusBar();
	~MaxStatusBar();
	void injectSelf(BBObject * handle);

	void MaxBind(BBObject * handle);
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxStatusBarXmlHandler : public wxStatusBarXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxStatusBarXmlHandler)

public:
    MaxStatusBarXmlHandler();
    virtual wxObject *DoCreateResource();
};


