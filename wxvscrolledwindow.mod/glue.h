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
#include "wx/vscroll.h"

class MaxVScrolledWindow;

extern "C" {

#include <blitz.h>

	int CB_PREF(wx_wxvscrolledwindow_wxVScrolledWindow__OnGetRowHeight)(const wxVScrolledWindow * window, int n);
	void CB_PREF(wx_wxvscrolledwindow_wxVScrolledWindow__OnGetRowsHeightHint)(const wxVScrolledWindow * window, int lineMin, int lineMax);

	MaxVScrolledWindow * bmx_wxvscrolledwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);

	int bmx_wxvscrolledwindow_getvisiblerowsbegin(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getvisiblerowsend(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getrowcount(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getvisiblebegin(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getvisibleend(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_hittest(wxVScrolledWindow * window, int x, int y);
	int bmx_wxvscrolledwindow_isvisible(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_refreshrow(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_refreshrows(wxVScrolledWindow * window, int fromline, int toLine);
	void bmx_wxvscrolledwindow_refreshall(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_scrollrows(wxVScrolledWindow * window, int lines);
	int bmx_wxvscrolledwindow_scrollrowpages(wxVScrolledWindow * window, int pages);
	int bmx_wxvscrolledwindow_scrolltorow(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_setrowcount(wxVScrolledWindow * window, int count);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxVScrolledWindow : public wxVScrolledWindow
{
public:
	MaxVScrolledWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxVScrolledWindow();
	virtual wxCoord OnGetRowHeight(size_t n) const;
	virtual void OnGetRowsHeightHint(size_t lineMin, size_t lineMax) const;
	
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

