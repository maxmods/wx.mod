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
#include "wx/vscroll.h"

class MaxVScrolledWindow;

extern "C" {

#include <blitz.h>

	int _wx_wxvscrolledwindow_wxVScrolledWindow__OnGetLineHeight(const wxVScrolledWindow * window, int n);
	void _wx_wxvscrolledwindow_wxVScrolledWindow__OnGetLinesHint(const wxVScrolledWindow * window, int lineMin, int lineMax);

	MaxVScrolledWindow * bmx_wxvscrolledwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);

	int bmx_wxvscrolledwindow_getfirstvisibleline(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getlastvisibleline(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getlinecount(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getvisiblebegin(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_getvisibleend(wxVScrolledWindow * window);
	int bmx_wxvscrolledwindow_hittest(wxVScrolledWindow * window, int x, int y);
	bool bmx_wxvscrolledwindow_isvisible(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_refreshline(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_refreshlines(wxVScrolledWindow * window, int fromline, int toLine);
	void bmx_wxvscrolledwindow_refreshall(wxVScrolledWindow * window);
	bool bmx_wxvscrolledwindow_scrolllines(wxVScrolledWindow * window, int lines);
	bool bmx_wxvscrolledwindow_scrollpages(wxVScrolledWindow * window, int pages);
	bool bmx_wxvscrolledwindow_scrolltoline(wxVScrolledWindow * window, int line);
	void bmx_wxvscrolledwindow_setlinecount(wxVScrolledWindow * window, int count);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxVScrolledWindow : public wxVScrolledWindow
{
public:
	MaxVScrolledWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxVScrolledWindow();
	virtual wxCoord OnGetLineHeight(size_t n) const;
	virtual void OnGetLinesHint(size_t lineMin, size_t lineMax) const;
	
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

