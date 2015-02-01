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
#include "wx/sashwin.h"

class MaxSashWindow;

extern "C" {

#include <blitz.h>

	MaxSashWindow * bmx_wxsashwindow_create(BBObject * handle, wxWindow * parent, wxWindowID id, 
		int x, int y, int w, int h, long style);
	int bmx_wxsashwindow_getsashvisible(wxSashWindow * sash, wxSashEdgePosition edge);
	int bmx_wxsashwindow_getmaximumsizex(wxSashWindow * sash);
	int bmx_wxsashwindow_getmaximumsizey(wxSashWindow * sash);
	int bmx_wxsashwindow_getminimumsizex(wxSashWindow * sash);
	int bmx_wxsashwindow_getminimumsizey(wxSashWindow * sash);
	int bmx_wxsashwindow_setmaximumsizex(wxSashWindow * sash, int size);
	void bmx_wxsashwindow_setmaximumsizey(wxSashWindow * sash, int size);
	void bmx_wxsashwindow_setminimumsizex(wxSashWindow * sash, int size);
	void bmx_wxsashwindow_setminimumsizey(wxSashWindow * sash, int size);
	void bmx_wxsashwindow_setsashvisible(wxSashWindow * sash, wxSashEdgePosition edge, int visible);

	wxSashEdgePosition bmx_wxsashevent_getedge(wxSashEvent & event);
	void bmx_wxsashevent_getdragrect(wxSashEvent & event, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxsashevent_getdragrectrect(wxSashEvent & event);
	wxSashDragStatus bmx_wxsashevent_getdragstatus(wxSashEvent & event);

	int bmx_wxsashwindow_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSashWindow: public wxSashWindow
{
public:
	MaxSashWindow(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSashWindow();

private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};
