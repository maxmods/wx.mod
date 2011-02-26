/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxRegion::MaxRegion(const wxRegion & r)
	: region(r)
{
}

wxRegion & MaxRegion::Region() {
	return region;
}


// *********************************************

MaxRegion * bmx_wxregion_create(int x, int y, int w, int h) {
	wxRegion r(x, y, w, h);
	return new MaxRegion(r);
}

MaxRegion * bmx_wxregion_createwithrect(MaxRect * rect) {
	wxRegion r(rect->Rect());
	return new MaxRegion(r);
}

MaxRegion * bmx_wxregion_createwithpoints(BBArray * points, int fillStyle) {
	wxRegion r;
	return new MaxRegion(r);
}

MaxRegion * bmx_wxregion_createwithbitmap(MaxBitmap * bmp, MaxColour * colour, int tolerance) {
	wxRegion r;
	if (colour) {
		r = wxRegion(bmp->Bitmap(), colour->Colour(), tolerance);
	} else {
		r = wxRegion(bmp->Bitmap());
	}
	return new MaxRegion(r);
}

void bmx_wxregion_clear(MaxRegion * region) {
	region->Region().Clear();
}

wxRegionContain bmx_wxregion_contains(MaxRegion * region, int x, int y) {
	return region->Region().Contains(x, y);
}

wxRegionContain bmx_wxregion_containsrect(MaxRegion * region, MaxRect * rect) {
	return region->Region().Contains(rect->Rect());
}

MaxBitmap * bmx_wxregion_converttobitmap(MaxRegion * region) {
	return new MaxBitmap(region->Region().ConvertToBitmap());
}

void bmx_wxregion_getbox(MaxRegion * region, int * x, int * y, int * w, int * h) {
	region->Region().GetBox(*x, *y, *w, *h);
}

MaxRect * bmx_wxregion_getboxrect(MaxRegion * region) {
	return new MaxRect(region->Region().GetBox());
}

bool bmx_wxregion_intersect(MaxRegion * region, int x, int y, int w, int h) {
	return region->Region().Intersect(x, y, w, h);
}

bool bmx_wxregion_intersectrect(MaxRegion * region, MaxRect * rect) {
	return region->Region().Intersect(rect->Rect());
}

bool bmx_wxregion_intersectregion(MaxRegion * region, MaxRegion * r) {
	return region->Region().Intersect(r->Region());
}

bool bmx_wxregion_isempty(MaxRegion * region) {
	return region->Region().IsEmpty();
}

bool bmx_wxregion_isequal(MaxRegion * region, MaxRegion * r) {
	return region->Region().IsEqual(r->Region());
}

bool bmx_wxregion_subtract(MaxRegion * region, int x, int y, int w, int h) {
	return region->Region().Subtract(wxRect(x, y, w, h));
}

bool bmx_wxregion_subtractrect(MaxRegion * region, MaxRect * rect) {
	return region->Region().Subtract(rect->Rect());
}

bool bmx_wxregion_subtractregion(MaxRegion * region, MaxRegion * r) {
	return region->Region().Subtract(r->Region());
}

bool bmx_wxregion_offset(MaxRegion * region, int x, int y) {
	return region->Region().Offset(x, y);
}

bool bmx_wxregion_union(MaxRegion * region, int x, int y, int w, int h) {
	return region->Region().Union(x, y, w, h);
}

bool bmx_wxregion_unionrect(MaxRegion * region, MaxRect * rect) {
	return region->Region().Union(rect->Rect());
}

bool bmx_wxregion_unionregion(MaxRegion * region, MaxRegion * r) {
	return region->Region().Union(r->Region());
}

bool bmx_wxregion_unionbitmap(MaxRegion * region, MaxBitmap * bmp) {
	return region->Region().Union(bmp->Bitmap());
}

bool bmx_wxregion_xor(MaxRegion * region, int x, int y, int w, int h) {
	return region->Region().Xor(x, y, w, h);
}

bool bmx_wxregion_xorrect(MaxRegion * region, MaxRect * rect) {
	return region->Region().Xor(rect->Rect());
}

bool bmx_wxregion_xorregion(MaxRegion * region, MaxRegion * r) {
	return region->Region().Xor(r->Region());
}

void bmx_wxregion_delete(MaxRegion * region) {
	delete region;
}


