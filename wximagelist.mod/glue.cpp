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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxImageList::MaxImageList(BBObject * handle, int width, int height, bool mask, int initialCount)
	: maxHandle(handle), wxImageList(width, height, mask, initialCount)
{
	wxbind(this, handle);
}

MaxImageList::~MaxImageList() {
	wxunbind(this);
}


// *********************************************


MaxImageList * bmx_wximagelist_create(BBObject * maxHandle, int width, int height, bool mask, int initialCount) {
	return new MaxImageList(maxHandle, width, height, mask, initialCount);
}

int bmx_wximagelist_add(MaxImageList * list, MaxBitmap * bitmap, MaxBitmap * mask) {
	if (mask) {
		return list->Add(bitmap->Bitmap(), mask->Bitmap());
	} else {
		return list->Add(bitmap->Bitmap());
	}
}

void bmx_wximagelist_delete(wxImageList * list) {
	// we might not own the list... but if we do, it should be in the peer bindings map!
	if (wxfind(list) != &bbNullObject) {
		delete list;
	}
}
