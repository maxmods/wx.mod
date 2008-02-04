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



// *********************************************

bool bmx_wxtoplevelwindow_cansettransparent(wxTopLevelWindow * window) {
	return window->CanSetTransparent();
}

bool bmx_wxtoplevelwindow_enableclosebutton(wxTopLevelWindow * window, bool value) {
	return window->EnableCloseButton(value);
}

MaxIcon * bmx_wxtoplevelwindow_geticon(wxTopLevelWindow * window) {
	wxIcon i(window->GetIcon());
	return new MaxIcon(i);
}

BBString * bmx_wxtoplevelwindow_gettitle(wxTopLevelWindow * window) {
	return bbStringFromWxString(window->GetTitle());
}

bool bmx_wxtoplevelwindow_isactive(wxTopLevelWindow * window) {
	return window->IsActive();
}

bool bmx_wxtoplevelwindow_isalwaysmaximized(wxTopLevelWindow * window) {
	return window->IsAlwaysMaximized();
}

void bmx_wxtoplevelwindow_iconize(wxTopLevelWindow * window, bool value) {
	window->Iconize(value);
}

bool bmx_wxtoplevelwindow_isfullscreen(wxTopLevelWindow * window) {
	return window->IsFullScreen();
}

bool bmx_wxtoplevelwindow_isiconized(wxTopLevelWindow * window) {
	return window->IsIconized();
}

bool bmx_wxtoplevelwindow_ismaximized(wxTopLevelWindow * window) {
	return window->IsMaximized();
}

void bmx_wxtoplevelwindow_maximize(wxTopLevelWindow * window, bool value) {
	window->Maximize(value);
}

void bmx_wxtoplevelwindow_requestuserattention(wxTopLevelWindow * window, int flags) {
	window->RequestUserAttention(flags);
}

void bmx_wxtoplevelwindow_setdefaultitem(wxTopLevelWindow * window, wxWindow * item) {
	window->SetDefaultItem(item);
}

void bmx_wxtoplevelwindow_seticon(wxTopLevelWindow * window, MaxIcon * icon) {
	window->SetIcon(icon->Icon());
}

void bmx_wxtoplevelwindow_setmaxsize(wxTopLevelWindow * window, int w, int h) {
	window->SetMaxSize(wxSize(w, h));
}

void bmx_wxtoplevelwindow_setminsize(wxTopLevelWindow * window, int w, int h) {
	window->SetMinSize(wxSize(w, h));
}

void bmx_wxtoplevelwindow_setsizehints(wxTopLevelWindow * window, int minW, int minH, int maxW, int maxH) {
	window->SetSizeHints(minW, minH, maxW, maxH);
}

void bmx_wxtoplevelwindow_settitle(wxTopLevelWindow * window, BBString * title) {
	window->SetTitle(wxStringFromBBString(title));
}

void bmx_wxtoplevelwindow_settransparent(wxTopLevelWindow * window, int alpha) {
	window->SetTransparent(alpha);
}

bool bmx_wxtoplevelwindow_showfullscreen(wxTopLevelWindow * window, bool show, long style) {
	return window->ShowFullScreen(show, style);
}

void bmx_wxtoplevelwindow_centreonscreen(wxTopLevelWindow * window, int direction) {
	window->CentreOnScreen(direction);
}

wxWindow * bmx_wxtoplevelwindow_getdefaultitem(wxTopLevelWindow * window) {
	return window->GetDefaultItem();
}

void bmx_wxtoplevelwindow_seticons(wxTopLevelWindow * window, MaxIconBundle * icons) {
	window->SetIcons(icons->Bundle());
}

MaxIconBundle * bmx_wxtoplevelwindow_geticons(wxTopLevelWindow * window) {
	return new MaxIconBundle(window->GetIcons());
}

bool bmx_wxtoplevelwindow_setshape(wxTopLevelWindow * window, MaxRegion * region) {
	return window->SetShape(region->Region());
}

