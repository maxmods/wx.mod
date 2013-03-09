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

#ifndef _WX_MAX_REGION_H_
#define _WX_MAX_REGION_H_

#include "wxglue.h"
#include "wx/region.h"
#include "../wxbitmap.mod/glue.h"

class MaxRegion;

extern "C" {

#include <blitz.h>

	MaxRegion * bmx_wxregion_create(int x, int y, int w, int h);
	MaxRegion * bmx_wxregion_createwithrect(MaxRect * rect);
	MaxRegion * bmx_wxregion_createwithpoints(BBArray * points, int fillStyle);
	MaxRegion * bmx_wxregion_createwithbitmap(MaxBitmap * bmp, MaxColour * colour, int tolerance);
	void bmx_wxregion_clear(MaxRegion * region);
	wxRegionContain bmx_wxregion_contains(MaxRegion * region, int x, int y);
	wxRegionContain bmx_wxregion_containsrect(MaxRegion * region, MaxRect * rect);
	MaxBitmap * bmx_wxregion_converttobitmap(MaxRegion * region);
	void bmx_wxregion_getbox(MaxRegion * region, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxregion_getboxrect(MaxRegion * region);
	int bmx_wxregion_intersect(MaxRegion * region, int x, int y, int w, int h);
	int bmx_wxregion_intersectrect(MaxRegion * region, MaxRect * rect);
	int bmx_wxregion_intersectregion(MaxRegion * region, MaxRegion * r);
	int bmx_wxregion_isempty(MaxRegion * region);
	int bmx_wxregion_isequal(MaxRegion * region, MaxRegion * r);
	int bmx_wxregion_subtract(MaxRegion * region, int x, int y, int w, int h);
	int bmx_wxregion_subtractrect(MaxRegion * region, MaxRect * rect);
	int bmx_wxregion_subtractregion(MaxRegion * region, MaxRegion * r);
	int bmx_wxregion_offset(MaxRegion * region, int x, int y);
	int bmx_wxregion_union(MaxRegion * region, int x, int y, int w, int h);
	int bmx_wxregion_unionrect(MaxRegion * region, MaxRect * rect);
	int bmx_wxregion_unionregion(MaxRegion * region, MaxRegion * r);
	int bmx_wxregion_unionbitmap(MaxRegion * region, MaxBitmap * bmp);
	int bmx_wxregion_xor(MaxRegion * region, int x, int y, int w, int h);
	int bmx_wxregion_xorrect(MaxRegion * region, MaxRect * rect);
	int bmx_wxregion_xorregion(MaxRegion * region, MaxRegion * r);
	void bmx_wxregion_delete(MaxRegion * region);


}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRegion
{
public:
	MaxRegion(const wxRegion & r);
	wxRegion & Region();

private:
	wxRegion region;

};


#endif // _WX_MAX_REGION_H_
