/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxHtmlHelpWindow::MaxHtmlHelpWindow(BBObject * handle, wxWindow * parent, int id, int x, int y,
		int w, int h, int style, int helpStyle)
	: wxHtmlHelpWindow(parent, id, wxPoint(x, y), wxSize(w, h), style, helpStyle)
{
	wxbind(this, handle);
}

MaxHtmlHelpWindow::~MaxHtmlHelpWindow() {
	wxunbind(this);
}


// *********************************************

wxHtmlHelpWindow * bmx_wxhtmlhelpwindow_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, int style, int helpStyle) {
	return new MaxHtmlHelpWindow(handle, parent, id, x, y, w, h, style, helpStyle);
}

bool bmx_wxhtmlhelpwindow_display(wxHtmlHelpWindow * window, BBString * x) {
	return window->Display(wxStringFromBBString(x));
}

bool bmx_wxhtmlhelpwindow_displaywithid(wxHtmlHelpWindow * window, int id) {
	return window->Display(id);
}

bool bmx_wxhtmlhelpwindow_displaycontents(wxHtmlHelpWindow * window) {
	return window->DisplayContents();
}

bool bmx_wxhtmlhelpwindow_displayindex(wxHtmlHelpWindow * window) {
	return window->DisplayIndex();
}

bool bmx_wxhtmlhelpwindow_keywordsearch(wxHtmlHelpWindow * window, BBString * keyword, wxHelpSearchMode mode) {
	return window->KeywordSearch(wxStringFromBBString(keyword), mode);
}

void bmx_wxhtmlhelpwindow_readcustomization(wxHtmlHelpWindow * window, wxConfigBase * config, BBString * path) {
	window->ReadCustomization(config, wxStringFromBBString(path));
}

void bmx_wxhtmlhelpwindow_refreshlists(wxHtmlHelpWindow * window) {
	window->RefreshLists();
}

void bmx_wxhtmlhelpwindow_useconfig(wxHtmlHelpWindow * window, wxConfigBase * config, BBString * rootpath) {
	window->UseConfig(config, wxStringFromBBString(rootpath));
}

void bmx_wxhtmlhelpwindow_writecustomization(wxHtmlHelpWindow * window, wxConfigBase * config, BBString * path) {
	window->WriteCustomization(config, wxStringFromBBString(path));
}


