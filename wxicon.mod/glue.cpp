/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxIconBundle::MaxIconBundle(const wxIconBundle & b)
	: bundle(b)
{
}

wxIconBundle & MaxIconBundle::Bundle() {
	return bundle;
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
	bool ret = icon->Icon().LoadFile(wxStringFromBBString(name), type);
}

int bmx_wxicon_getdepth(MaxIcon * icon) {
	return icon->Icon().GetDepth();
}

int bmx_wxicon_getheight(MaxIcon * icon) {
	return icon->Icon().GetHeight();
}

int bmx_wxicon_getwidth(MaxIcon * icon) {
	return icon->Icon().GetWidth();
}

void bmx_wxicon_setdepth(MaxIcon * icon, int depth) {
	icon->Icon().SetDepth(depth);
}

void bmx_wxicon_setheight(MaxIcon * icon, int height) {
	icon->Icon().SetHeight(height);
}

void bmx_wxicon_setwidth(MaxIcon * icon, int width) {
	icon->Icon().SetWidth(width);
}

bool bmx_wxicon_isok(MaxIcon * icon) {
	return icon->Icon().IsOk();
}

// *********************************************

MaxIconBundle * bmx_iconbundle_create(BBString * filename, long ftype) {
	wxIconBundle b(wxStringFromBBString(filename), ftype);
	return new MaxIconBundle(b);
}

MaxIconBundle * bmx_wxiconbundle_createwithicon(MaxIcon * icon) {
	wxIconBundle b(icon->Icon());
	return new MaxIconBundle(b);
}

void bmx_wxiconbundle_addicon(MaxIconBundle * bundle, BBString * file, long ftype) {
	bundle->Bundle().AddIcon(wxStringFromBBString(file), ftype);
}

void bmx_wxiconbundle_addiconicon(MaxIconBundle * bundle, MaxIcon * icon) {
	bundle->Bundle().AddIcon(icon->Icon());
}

MaxIcon * bmx_wxiconbundle_geticon(MaxIconBundle * bundle, int w, int h) {
	return new MaxIcon(bundle->Bundle().GetIcon(wxSize(w, h)));
}

void bmx_wxiconbundle_delete(MaxIconBundle * bundle) {
	delete bundle;
}

