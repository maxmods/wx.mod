/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

MaxArtProvider::MaxArtProvider(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxArtProvider::~MaxArtProvider() {
	wxunbind(this);
}

wxBitmap MaxArtProvider::CreateBitmap(const wxArtID& id, const wxArtClient& client, const wxSize& size) {

	MaxBitmap * bitmap = CB_PREF(wx_wxartprovider_wxArtProvider__CreateBitmap)(maxHandle, bbStringFromWxString(id),
		bbStringFromWxString(client), size.x, size.y);
		
	if (bitmap) {
		return bitmap->Bitmap();
	} else {
		return wxNullBitmap;
	}
}


// *********************************************

MaxArtProvider * bmx_wxartprovider_create(BBObject * handle) {
	return new MaxArtProvider(handle);
}

MaxBitmap * bmx_wxartprovider_getbitmap(BBString * id, BBString * client, int w, int h) {
	wxBitmap b(wxArtProvider::GetBitmap(wxStringFromBBString(id), wxStringFromBBString(client), wxSize(w, h)));
	return new MaxBitmap(b);
}

MaxIcon * bmx_wxartprovider_geticon(BBString * id, BBString * client, int w, int h) {
	wxIcon i(wxArtProvider::GetIcon(wxStringFromBBString(id), wxStringFromBBString(client), wxSize(w, h)));
	return new MaxIcon(i);
}

void bmx_wxartprovider_getsizehint(BBString * client, int platformDefault, int * width, int * height) {
	wxSize s = wxArtProvider::GetSizeHint(wxStringFromBBString(client), static_cast<bool>(platformDefault));
	*width = s.x;
	*height = s.y;
}

int bmx_wxartprovider_deleteprovider(wxArtProvider * provider) {
	return static_cast<int>(wxArtProvider::Delete(provider));
}

void bmx_wxartprovider_insert(wxArtProvider * provider) {
	wxArtProvider::Insert(provider);
}

int bmx_wxartprovider_pop() {
	return static_cast<int>(wxArtProvider::Pop());
}

void bmx_wxartprovider_push(wxArtProvider * provider) {
	wxArtProvider::Push(provider);
}

int bmx_wxartprovider_remove(wxArtProvider * provider) {
	return static_cast<int>(wxArtProvider::Remove(provider));
}



