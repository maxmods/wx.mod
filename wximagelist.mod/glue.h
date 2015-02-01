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

#ifndef _WX_MAX_IMAGELIST_H_
#define _WX_MAX_IMAGELIST_H_

#include "wxglue.h"
#include "wx/imaglist.h"
#include "../wxbitmap.mod/glue.h"
#include "../wxicon.mod/glue.h"

class MaxImageList;

extern "C" {

#include <blitz.h>

	MaxImageList * bmx_wximagelist_create(BBObject * maxHandle, int width, int height, int mask, int initialCount);
	int bmx_wximagelist_add(MaxImageList * list, MaxBitmap * bitmap, MaxBitmap * mask);
	void bmx_wximagelist_delete(wxImageList * list);
	int bmx_wximagelist_addwithcolourmask(wxImageList * list, MaxBitmap * bitmap, MaxColour * maskColour);
	int bmx_wximagelist_addicon(wxImageList * list, MaxIcon * icon);

	MaxBitmap * bmx_wximagelist_getbitmap(wxImageList * list, int index);
	MaxIcon * bmx_wximagelist_geticon(wxImageList * list, int index);
	int bmx_wximagelist_getimagecount(wxImageList * list);
	int bmx_wximagelist_getsize(wxImageList * list, int index, int * width, int * height);
	int bmx_wximagelist_remove(wxImageList * list, int index);
	int bmx_wximagelist_removeall(wxImageList * list);
	int bmx_wximagelist_replace(wxImageList * list, int index, MaxBitmap * bitmap, MaxBitmap * mask);
	int bmx_wximagelist_replaceicon(wxImageList * list, int index, MaxIcon * icon);

	int bmx_wximagelist_draw(wxImageList * list, int index, MaxDC * dc, int x, int y, int flags, int solidBackground);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxImageList : public wxImageList
{
public:
	MaxImageList(BBObject * handle, int width, int height, int mask, int initialCount);
	~MaxImageList();
	
private:
	BBObject * maxHandle;

};

#endif
