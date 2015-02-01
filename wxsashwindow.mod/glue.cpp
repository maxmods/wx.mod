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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxSashWindow::MaxSashWindow(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSashWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSashWindow::~MaxSashWindow() {
	wxunbind(this);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxSashWindow, wxSashWindow)
END_EVENT_TABLE()

MaxSashWindow * bmx_wxsashwindow_create(BBObject * handle, wxWindow * parent, wxWindowID id, 
		int x, int y, int w, int h, long style) {
	return new MaxSashWindow(handle, parent, id, x, y, w, h, style);
}

int bmx_wxsashwindow_getsashvisible(wxSashWindow * sash, wxSashEdgePosition edge) {
	return static_cast<int>(sash->GetSashVisible(edge));
}

int bmx_wxsashwindow_getmaximumsizex(wxSashWindow * sash) {
	return sash->GetMaximumSizeX();
}

int bmx_wxsashwindow_getmaximumsizey(wxSashWindow * sash) {
	return sash->GetMaximumSizeY();
}

int bmx_wxsashwindow_getminimumsizex(wxSashWindow * sash) {
	return sash->GetMinimumSizeX();
}

int bmx_wxsashwindow_getminimumsizey(wxSashWindow * sash) {
	return sash->GetMinimumSizeY();
}

int bmx_wxsashwindow_setmaximumsizex(wxSashWindow * sash, int size) {
	sash->SetMaximumSizeX(size);
}

void bmx_wxsashwindow_setmaximumsizey(wxSashWindow * sash, int size) {
	sash->SetMaximumSizeY(size);
}

void bmx_wxsashwindow_setminimumsizex(wxSashWindow * sash, int size) {
	sash->SetMinimumSizeX(size);
}

void bmx_wxsashwindow_setminimumsizey(wxSashWindow * sash, int size) {
	sash->SetMinimumSizeY(size);
}

void bmx_wxsashwindow_setsashvisible(wxSashWindow * sash, wxSashEdgePosition edge, int visible) {
	sash->SetSashVisible(edge, static_cast<bool>(visible));
}


wxSashEdgePosition bmx_wxsashevent_getedge(wxSashEvent & event) {
	return event.GetEdge();
}

void bmx_wxsashevent_getdragrect(wxSashEvent & event, int * x, int * y, int * w, int * h) {
	wxRect r = event.GetDragRect();
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

MaxRect * bmx_wxsashevent_getdragrectrect(wxSashEvent & event) {
	return new MaxRect(event.GetDragRect());	
}

wxSashDragStatus bmx_wxsashevent_getdragstatus(wxSashEvent & event) {
	return event.GetDragStatus();
}


int bmx_wxsashwindow_geteventtype(int type) {

	switch(type) {
		case 11200: return wxEVT_SASH_DRAGGED;
	}
	return 0;

}


