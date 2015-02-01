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

#include "wxglue.h"
#include "wx/splitter.h"
#include "wx/xrc/xh_split.h"
#include "wx/xml/xml.h"


class MaxSplitterWindow;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxsplitterwindow_wxSplitterWindow__xrcNew)(wxSplitterWindow * window);

	MaxSplitterWindow * bmx_wxsplitterwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	int bmx_wxsplitterwindow_getminimumpanesize(wxSplitterWindow * splitter);
	double bmx_wxsplitterwindow_getsashgravity(wxSplitterWindow * splitter);
	int bmx_wxsplitterwindow_getsashposition(wxSplitterWindow * splitter);
	int bmx_wxsplitterwindow_getsplitmode(wxSplitterWindow * splitter);
	void bmx_wxsplitterwindow_initialize(wxSplitterWindow * splitter, wxWindow * window);
	int bmx_wxsplitterwindow_issplit(wxSplitterWindow * splitter);
	void bmx_wxsplitterwindow_setsashgravity(wxSplitterWindow * splitter, double gravity);
	void bmx_wxsplitterwindow_setsashposition(wxSplitterWindow * splitter, int position, int redraw);
	void bmx_wxsplitterwindow_setsashsize(wxSplitterWindow * splitter, int size);
	void bmx_wxsplitterwindow_setminimumpanesize(wxSplitterWindow * splitter, int paneSize);
	void bmx_wxsplitterwindow_setsplitmode(wxSplitterWindow * splitter, int mode);
	int bmx_wxsplitterwindow_splithorizontally(wxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition);
	int bmx_wxsplitterwindow_splitvertically(wxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition);
	void bmx_wxsplitterwindow_updatesize(wxSplitterWindow * splitter);
	wxWindow * bmx_wxsplitterwindow_getwindow1(wxSplitterWindow * splitter);
	wxWindow * bmx_wxsplitterwindow_getwindow2(wxSplitterWindow * splitter);
	int bmx_wxsplitterwindow_replacewindow(wxSplitterWindow * splitter, wxWindow * oldwin, wxWindow * newwin);
	int bmx_wxsplitterwindow_unsplit(wxSplitterWindow * splitter, wxWindow * rep);

	int bmx_wxsplitterevent_getsashposition(wxSplitterEvent & event);
	int bmx_wxsplitterevent_getx(wxSplitterEvent & event);
	int bmx_wxsplitterevent_gety(wxSplitterEvent & event);
	wxWindow * bmx_wxsplitterevent_getwindowbeingremoved(wxSplitterEvent & event);
	void bmx_wxsplitterevent_setsashposition(wxSplitterEvent & event, int pos);

	int bmx_wxsplitterwindow_geteventtype(int type);

	void bmx_wxsplitterwindow_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSplitterWindow : public wxSplitterWindow
{
public:
	MaxSplitterWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxSplitterWindow();
	~MaxSplitterWindow();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSplitterWindowXmlHandler : public wxSplitterWindowXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSplitterWindowXmlHandler)

public:
    MaxSplitterWindowXmlHandler();
    virtual wxObject *DoCreateResource();
};


