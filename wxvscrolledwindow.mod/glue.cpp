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

MaxVScrolledWindow::MaxVScrolledWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxVScrolledWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxVScrolledWindow::~MaxVScrolledWindow() {
	wxunbind(this);
}

wxCoord MaxVScrolledWindow::OnGetLineHeight(size_t n) const {
	return _wx_wxvscrolledwindow_wxVScrolledWindow__OnGetLineHeight(this, n);
}

void MaxVScrolledWindow::OnGetLinesHint(size_t lineMin, size_t lineMax) const {
	_wx_wxvscrolledwindow_wxVScrolledWindow__OnGetLinesHint(this, lineMin, lineMax);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxVScrolledWindow, wxVScrolledWindow)
END_EVENT_TABLE()

MaxVScrolledWindow * bmx_wxvscrolledwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxVScrolledWindow(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxvscrolledwindow_getfirstvisibleline(wxVScrolledWindow * window) {
	return window->GetFirstVisibleLine();
}

int bmx_wxvscrolledwindow_getlastvisibleline(wxVScrolledWindow * window) {
	return window->GetLastVisibleLine();
}

int bmx_wxvscrolledwindow_getlinecount(wxVScrolledWindow * window) {
	return window->GetLineCount();
}

int bmx_wxvscrolledwindow_getvisiblebegin(wxVScrolledWindow * window) {
	return window->GetVisibleBegin();
}

int bmx_wxvscrolledwindow_getvisibleend(wxVScrolledWindow * window) {
	return window->GetVisibleEnd();
}

int bmx_wxvscrolledwindow_hittest(wxVScrolledWindow * window, int x, int y) {
	return window->HitTest(x, y);
}

bool bmx_wxvscrolledwindow_isvisible(wxVScrolledWindow * window, int line) {
	return window->IsVisible(line);
}

void bmx_wxvscrolledwindow_refreshline(wxVScrolledWindow * window, int line) {
	window->RefreshLine(line);
}

void bmx_wxvscrolledwindow_refreshlines(wxVScrolledWindow * window, int fromLine, int toLine) {
	window->RefreshLines(fromLine, toLine);
}

void bmx_wxvscrolledwindow_refreshall(wxVScrolledWindow * window) {
	window->RefreshAll();
}

bool bmx_wxvscrolledwindow_scrolllines(wxVScrolledWindow * window, int lines) {
	return window->ScrollLines(lines);
}

bool bmx_wxvscrolledwindow_scrollpages(wxVScrolledWindow * window, int pages) {
	return window->ScrollPages(pages);
}

bool bmx_wxvscrolledwindow_scrolltoline(wxVScrolledWindow * window, int line) {
	return window->ScrollToLine(line);
}

void bmx_wxvscrolledwindow_setlinecount(wxVScrolledWindow * window, int count) {
	window->SetLineCount(count);
}


