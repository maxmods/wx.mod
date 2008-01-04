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

MaxIcon::MaxIcon()
	: icon(wxNullIcon)
{
}

MaxIcon::MaxIcon(const wxIcon & ic)
	: icon(wxNullIcon)
{
	icon = wxIcon(ic); // we need to make a copy of it !
}

wxIcon & MaxIcon::Icon() {
	return icon;
}

MaxIcon::~MaxIcon() {
}



// *********************************************

MaxIcon * bmx_wxicon_createfromfile(BBString * name, wxBitmapType type, int desiredWidth, int desiredHeight) {
	wxIcon i(wxStringFromBBString(name), type, desiredWidth, desiredHeight);
	return new MaxIcon(i);
}

MaxIcon * bmx_wxicon_create() {
	return new MaxIcon();
}

void * bmx_wxicon_delete(MaxIcon * icon) {
	delete icon;
}

void bmx_wxicon_copyfrombitmap(MaxIcon * icon, MaxBitmap * bitmap) {
	icon->Icon().CopyFromBitmap(bitmap->Bitmap());
}

MaxIcon * bmx_wxicon_null() {
	wxIcon i(wxNullIcon);
	return new MaxIcon(i);
}

bool bmx_wxicon_loadfile(MaxIcon * icon, BBString * name, wxBitmapType type) {
	return icon->Icon().LoadFile(wxStringFromBBString(name), type);
}

