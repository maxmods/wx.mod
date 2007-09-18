/*
  Copyright (c) 2007 Bruce A Henderson
 
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

#ifndef _WX_MAX_BITMAP_H_
#define _WX_MAX_BITMAP_H_

#include "wxglue.h"
#include "wx/bitmap.h"
#include "../wximage.mod/glue.h"
#include "../wxpalette.mod/glue.h"

class MaxBitmap;

extern "C" {

#include <blitz.h>

	MaxBitmap * bmx_wxbitmap_create(bool makeNull);
	void bmx_wxbitmap_delete(MaxBitmap * bitmap);
	MaxBitmap * bmx_wxbitmap_createfromimage(MaxImage * image, int depth);
	MaxBitmap * bmx_wxbitmap_createempty(int width, int height, int depth);
	MaxBitmap * bmx_wxbitmap_createfromfile(BBString * name, wxBitmapType flag);

	bool bmx_wxbitmap_loadfile(MaxBitmap * bitmap, BBString * name, wxBitmapType type);
	MaxImage * bmx_wxbitmap_converttoimage(MaxBitmap * bitmap);
	int bmx_wxbitmap_getdepth(MaxBitmap * bitmap);
	int bmx_wxbitmap_getheight(MaxBitmap * bitmap);
	int bmx_wxbitmap_getwidth(MaxBitmap * bitmap);
	void bmx_wxbitmap_setdepth(MaxBitmap * bitmap, int depth);
	void bmx_wxbitmap_setheight(MaxBitmap * bitmap, int height);
	void bmx_wxbitmap_setwidth(MaxBitmap * bitmap, int width);
	
	MaxPalette * bmx_wxbitmap_getpalette(MaxBitmap * bitmap);
	void bmx_wxbitmap_setpalette(MaxBitmap * bitmap, MaxPalette * palette);

	MaxBitmap * bmx_wxbitmap_getsubbitmap(MaxBitmap * bitmap, int x, int y, int w, int h);
	wxMask * bmx_wxbitmap_getmask(MaxBitmap * bitmap);
	void bmx_wxbitmap_setmask(MaxBitmap * bitmap, wxMask * mask);

	wxMask * bmx_wxmask_create(MaxBitmap * bitmap, MaxColour * colour);
	void bmx_wxmask_delete(wxMask * mask);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBitmap
{
public:
	MaxBitmap(const wxBitmap & b = wxNullBitmap);
	wxBitmap & Bitmap();

private:
	wxBitmap bitmap;

};

#endif // _WX_MAX_BITMAP_H_
