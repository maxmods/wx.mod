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


MaxPreferencesPage::MaxPreferencesPage(BBObject * handle)
		: maxHandle(handle)
{
	BBRETAIN(handle);
}

MaxPreferencesPage::~MaxPreferencesPage() {
	BBRELEASE(maxHandle);
}

wxString MaxPreferencesPage::GetName() const {
	return wxStringFromBBString(wx_wxpreferencespage_wxPreferencesPage__OnGetName(maxHandle));
}

#ifdef wxHAS_PREF_EDITOR_ICONS
wxBitmap MaxPreferencesPage::GetLargeIcon() const {
	MaxBitmap * bitmap = wx_wxpreferencespage_wxPreferencesPage__OnGetLargeIcon(maxHandle);
	if (bitmap) {
		wxBitmap b(bitmap->Bitmap());
		return b;
	} else {
		return wxBitmap(); 
	}
}
#endif

wxWindow * MaxPreferencesPage::CreateWindow(wxWindow * parent) {
	return wx_wxpreferencespage_wxPreferencesPage__OnCreateWindow(maxHandle, parent);
}

// *********************************************

wxPreferencesPage * bmx_wxpreferencespage_create(BBObject * handle) {
	return new MaxPreferencesPage(handle);
}
