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

#include "wxglue.h"
#include "../wxbitmap.mod/glue.h"

class MaxIcon;
class MaxIconBundle;

extern "C" {

#include <blitz.h>

	MaxIcon * bmx_wxicon_create();
	MaxIcon * bmx_wxicon_createfromfile(BBString * name, wxBitmapType type, int desiredWidth, int desiredHeight);
	void bmx_wxicon_copyfrombitmap(MaxIcon * icon, MaxBitmap * bitmap);
	void * bmx_wxicon_delete(MaxIcon * icon);
	MaxIcon * bmx_wxicon_null();
	bool bmx_wxicon_loadfile(MaxIcon * icon, BBString * name, wxBitmapType type);

	int bmx_wxicon_getdepth(MaxIcon * icon);
	int bmx_wxicon_getheight(MaxIcon * icon);
	int bmx_wxicon_getwidth(MaxIcon * icon);
	void bmx_wxicon_setdepth(MaxIcon * icon, int depth);
	void bmx_wxicon_setheight(MaxIcon * icon, int height);
	void bmx_wxicon_setwidth(MaxIcon * icon, int width);
	
	bool bmx_wxicon_isok(MaxIcon * icon);


	MaxIconBundle * bmx_iconbundle_create(BBString * filename, long ftype);
	MaxIconBundle * bmx_wxiconbundle_createwithicon(MaxIcon * icon);
	void bmx_wxiconbundle_addicon(MaxIconBundle * bundle, BBString * file, long ftype);
	void bmx_wxiconbundle_addiconicon(MaxIconBundle * bundle, MaxIcon * icon);
	MaxIcon * bmx_wxiconbundle_geticon(MaxIconBundle * bundle, int w, int h);
	void bmx_wxiconbundle_delete(MaxIconBundle * bundle);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxIcon
{
public:
	MaxIcon();
	MaxIcon(const wxIcon & icon);
	~MaxIcon();
	wxIcon & Icon();

private:
	wxIcon & icon;

};


class MaxIconBundle
{
public:
	MaxIconBundle(const wxIconBundle & b);
	wxIconBundle & Bundle();

private:
	wxIconBundle bundle;

};

