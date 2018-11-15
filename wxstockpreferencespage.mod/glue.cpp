/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxStockPreferencesPage::MaxStockPreferencesPage(BBObject * handle, wxStockPreferencesPage::Kind kind)
		: wxStockPreferencesPage(kind), maxHandle(handle)
{
	BBRETAIN(handle);
}

MaxStockPreferencesPage::~MaxStockPreferencesPage() {
	BBRELEASE(maxHandle);
}

wxWindow * MaxStockPreferencesPage::CreateWindow(wxWindow * parent) {
	return wx_wxstockpreferencespage_wxStockPreferencesPage__OnCreateWindow(maxHandle, parent);
}


// *********************************************

wxStockPreferencesPage * bmx_wxstockpreferencespage_create(BBObject * handle, int kind) {
	return new MaxStockPreferencesPage(handle, static_cast<wxStockPreferencesPage::Kind>(kind));
}

int bmx_wxstockpreferencespage_getkind(wxStockPreferencesPage  * page) {
	return static_cast<int>(page->GetKind());
}

BBString * bmx_wxstockpreferencespage_getname(wxStockPreferencesPage  * page) {
	return bbStringFromWxString(page->GetName());
}

MaxBitmap * bmx_wxstockpreferencespage_getlargeicon(wxStockPreferencesPage  * page) {
	wxBitmap b(page->GetLargeIcon());
	return new MaxBitmap(b);
}


