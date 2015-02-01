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

MaxHtmlHelpController::MaxHtmlHelpController(BBObject * handle, int style, wxWindow * parent)
	: wxHtmlHelpController(style, parent)
{
	wxbind(this, handle);
}

MaxHtmlHelpController::~MaxHtmlHelpController() {
	wxunbind(this);
}



// *********************************************

wxHtmlHelpController * bmx_wxhtmlhelpcontroller_create(BBObject * handle, int style, wxWindow * parentWindow) {
	return new MaxHtmlHelpController(handle, style, parentWindow);
}

int bmx_wxhtmlhelpcontroller_addbook(wxHtmlHelpController * cont, BBString * bookUrl, int showWaitMsg) {
	return static_cast<int>(cont->AddBook(wxStringFromBBString(bookUrl), static_cast<bool>(showWaitMsg)));
}

int bmx_wxhtmlhelpcontroller_addbookfile(wxHtmlHelpController * cont, MaxFileName * file, int showWaitMsg) {
	return static_cast<int>(cont->AddBook(file->Filename(), static_cast<bool>(showWaitMsg)));
}

void bmx_wxhtmlhelpcontroller_display(wxHtmlHelpController * cont, BBString * x) {
	cont->Display(wxStringFromBBString(x));
}

void bmx_wxhtmlhelpcontroller_displayid(wxHtmlHelpController * cont, int id) {
	cont->Display(id);
}

void bmx_wxhtmlhelpcontroller_displaycontents(wxHtmlHelpController * cont) {
	cont->DisplayContents();
}

void bmx_wxhtmlhelpcontroller_displayindex(wxHtmlHelpController * cont) {
	cont->DisplayIndex();
}

int bmx_wxhtmlhelpcontroller_keywordsearch(wxHtmlHelpController * cont, BBString * keyword, wxHelpSearchMode mode) {
	return static_cast<int>(cont->KeywordSearch(wxStringFromBBString(keyword), mode));
}

void bmx_wxhtmlhelpcontroller_readcustomization(wxHtmlHelpController * cont, wxConfigBase * config, BBString * path) {
	cont->ReadCustomization(config, wxStringFromBBString(path));
}

void bmx_wxhtmlhelpcontroller_settempdir(wxHtmlHelpController * cont, BBString * path) {
	cont->SetTempDir(wxStringFromBBString(path));
}

void bmx_wxhtmlhelpcontroller_settitleformat(wxHtmlHelpController * cont, BBString * format) {
	cont->SetTitleFormat(wxStringFromBBString(format));
}

void bmx_wxhtmlhelpcontroller_useconfig(wxHtmlHelpController * cont, wxConfigBase * config, BBString * rootpath) {
	cont->UseConfig(config, wxStringFromBBString(rootpath));
}

void bmx_wxhtmlhelpcontroller_writecustomization(wxHtmlHelpController * cont, wxConfigBase * config, BBString * path) {
	cont->WriteCustomization(config, wxStringFromBBString(path));
}

void bmx_wxhtmlhelpcontroller_sethelpwindow(wxHtmlHelpController * cont, wxHtmlHelpWindow * helpWindow) {
	cont->SetHelpWindow(helpWindow);
}


