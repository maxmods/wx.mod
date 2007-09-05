/*
  Copyright (c) 2007 Bruce A Henderson
 
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

class MaxSplitterWindow;

extern "C" {

#include <blitz.h>

	MaxSplitterWindow * bmx_wxsplitterwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	int bmx_wxsplitterwindow_getminimumpanesize(MaxSplitterWindow * splitter);
	double bmx_wxsplitterwindow_getsashgravity(MaxSplitterWindow * splitter);
	int bmx_wxsplitterwindow_getsashposition(MaxSplitterWindow * splitter);
	int bmx_wxsplitterwindow_getsplitmode(MaxSplitterWindow * splitter);
	void bmx_wxsplitterwindow_initialize(MaxSplitterWindow * splitter, wxWindow * window);
	bool bmx_wxsplitterwindow_issplit(MaxSplitterWindow * splitter);
	void bmx_wxsplitterwindow_setsashgravity(MaxSplitterWindow * splitter, double gravity);
	void bmx_wxsplitterwindow_setsashposition(MaxSplitterWindow * splitter, int position, bool redraw);
	void bmx_wxsplitterwindow_setsashsize(MaxSplitterWindow * splitter, int size);
	void bmx_wxsplitterwindow_setminimumpanesize(MaxSplitterWindow * splitter, int paneSize);
	void bmx_wxsplitterwindow_setsplitmode(MaxSplitterWindow * splitter, int mode);
	bool bmx_wxsplitterwindow_splithorizontally(MaxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition);
	bool bmx_wxsplitterwindow_splitvertically(MaxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition);
	void bmx_wxsplitterwindow_updatesize(MaxSplitterWindow * splitter);
	wxWindow * bmx_wxsplitterwindow_getwindow1(MaxSplitterWindow * splitter);
	wxWindow * bmx_wxsplitterwindow_getwindow2(MaxSplitterWindow * splitter);
	bool bmx_wxsplitterwindow_replacewindow(MaxSplitterWindow * splitter, wxWindow * oldwin, wxWindow * newwin);
	bool bmx_wxsplitterwindow_unsplit(MaxSplitterWindow * splitter, wxWindow * rep);

	int bmx_wxsplitterevent_getsashposition(wxSplitterEvent & event);
	int bmx_wxsplitterevent_getx(wxSplitterEvent & event);
	int bmx_wxsplitterevent_gety(wxSplitterEvent & event);
	wxWindow * bmx_wxsplitterevent_getwindowbeingremoved(wxSplitterEvent & event);
	void bmx_wxsplitterevent_setsashposition(wxSplitterEvent & event, int pos);

	int bmx_wxsplitterwindow_geteventtype(int type);
	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSplitterWindow : public wxSplitterWindow
{
public:
	MaxSplitterWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSplitterWindow();
	
private:
	BBObject * maxHandle;

};

