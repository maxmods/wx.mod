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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxSplitterWindow::MaxSplitterWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: wxSplitterWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSplitterWindow::~MaxSplitterWindow() {
	wxunbind(this);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxSplitterWindow, wxSplitterWindow)
END_EVENT_TABLE()

MaxSplitterWindow * bmx_wxsplitterwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {
	
	return new MaxSplitterWindow(maxHandle, parent, id, x, y, w, h, style);
}
	
int bmx_wxsplitterwindow_getminimumpanesize(wxSplitterWindow * splitter) {
	return splitter->GetMinimumPaneSize();
}

double bmx_wxsplitterwindow_getsashgravity(wxSplitterWindow * splitter) {
	return splitter->GetSashGravity();
}

int bmx_wxsplitterwindow_getsashposition(wxSplitterWindow * splitter) {
	return splitter->GetSashPosition();
}

int bmx_wxsplitterwindow_getsplitmode(wxSplitterWindow * splitter) {
	return splitter->GetSplitMode();
}

void bmx_wxsplitterwindow_initialize(wxSplitterWindow * splitter, wxWindow * window) {
	splitter->Initialize(window);
}

bool bmx_wxsplitterwindow_issplit(wxSplitterWindow * splitter) {
	return splitter->IsSplit();
}

void bmx_wxsplitterwindow_setsashgravity(wxSplitterWindow * splitter, double gravity) {
	splitter->SetSashGravity(gravity);
}

void bmx_wxsplitterwindow_setsashposition(wxSplitterWindow * splitter, int position, bool redraw) {
	splitter->SetSashPosition(position, redraw);
}

void bmx_wxsplitterwindow_setsashsize(wxSplitterWindow * splitter, int size) {
	splitter->SetSashSize(size);
}

void bmx_wxsplitterwindow_setminimumpanesize(wxSplitterWindow * splitter, int paneSize) {
	splitter->SetMinimumPaneSize(paneSize);
}

void bmx_wxsplitterwindow_setsplitmode(wxSplitterWindow * splitter, int mode) {
	splitter->SetSplitMode(mode);
}

bool bmx_wxsplitterwindow_splithorizontally(wxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition) {
	return splitter->SplitHorizontally(window1, window2, sashPosition);
}

bool bmx_wxsplitterwindow_splitvertically(wxSplitterWindow * splitter, wxWindow * window1, wxWindow * window2, int sashPosition) {
	return splitter->SplitVertically(window1, window2, sashPosition);
}

void bmx_wxsplitterwindow_updatesize(wxSplitterWindow * splitter) {
	splitter->UpdateSize();
}

wxWindow * bmx_wxsplitterwindow_getwindow1(wxSplitterWindow * splitter) {
	return splitter->GetWindow1();
}

wxWindow * bmx_wxsplitterwindow_getwindow2(wxSplitterWindow * splitter) {
	return splitter->GetWindow2();
}

bool bmx_wxsplitterwindow_replacewindow(wxSplitterWindow * splitter, wxWindow * oldwin, wxWindow * newwin) {
	return splitter->ReplaceWindow(oldwin, newwin);
}

bool bmx_wxsplitterwindow_unsplit(wxSplitterWindow * splitter, wxWindow * rep) {
	if (rep) {
		return splitter->Unsplit(rep);
	} else {
		return splitter->Unsplit();
	}
}


int bmx_wxsplitterevent_getsashposition(wxSplitterEvent & event) {
	return event.GetSashPosition();
}

int bmx_wxsplitterevent_getx(wxSplitterEvent & event) {
	return event.GetX();
}

int bmx_wxsplitterevent_gety(wxSplitterEvent & event) {
	return event.GetY();
}

wxWindow * bmx_wxsplitterevent_getwindowbeingremoved(wxSplitterEvent & event) {
	return event.GetWindowBeingRemoved();
}

void bmx_wxsplitterevent_setsashposition(wxSplitterEvent & event, int pos) {
	event.SetSashPosition(pos);
}



int bmx_wxsplitterwindow_geteventtype(int type) {
	switch(type) {
		case 850: return wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED;
		case 851: return wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING;
		case 852: return wxEVT_COMMAND_SPLITTER_DOUBLECLICKED;
		case 853: return wxEVT_COMMAND_SPLITTER_UNSPLIT;
	}
	
	return 0;
}
