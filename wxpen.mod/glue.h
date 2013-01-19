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

#include "wxglue.h"
#include "../wxbitmap.mod/glue.h"

class MaxPen;

extern "C" {

#include <blitz.h>

	MaxPen * bmx_wxpen_create(BBString * name, int width, int style);
	MaxPen * bmx_wxpen_createfromcolour(MaxColour * colour, int width, int style);
	void bmx_wxpen_delete(MaxPen * pen);
	MaxPen * bmx_wxpen_null();

	MaxPen * bmx_wxstockgdi_pen_blackdashed();
	MaxPen * bmx_wxstockgdi_pen_black();
	MaxPen * bmx_wxstockgdi_pen_cyan();
	MaxPen * bmx_wxstockgdi_pen_green();
	MaxPen * bmx_wxstockgdi_pen_grey();
	MaxPen * bmx_wxstockgdi_pen_lightgrey();
	MaxPen * bmx_wxstockgdi_pen_mediumgrey();
	MaxPen * bmx_wxstockgdi_pen_red();
	MaxPen * bmx_wxstockgdi_pen_transparent();
	MaxPen * bmx_wxstockgdi_pen_white();

	wxPenCap bmx_wxpen_getcap(MaxPen * pen);
	MaxColour * bmx_wxpen_getcolour(MaxPen * pen);
	wxPenJoin bmx_wxpen_getjoin(MaxPen * pen);
	MaxBitmap * bmx_wxpen_getstipple(MaxPen * pen);
	int bmx_wxpen_getstyle(MaxPen * pen);
	int bmx_wxpen_getwidth(MaxPen * pen);
	bool bmx_wxpen_isok(MaxPen * pen);
	void bmx_wxpen_setcap(MaxPen * pen, wxPenCap style);
	void bmx_wxpen_setcolour(MaxPen * pen, BBString * name);
	void bmx_wxpen_setfromcolour(MaxPen * pen, MaxColour * colour);
	void bmx_wxpen_setfromrgb(MaxPen * pen, int red, int green, int blue);
	void bmx_wxpen_setjoin(MaxPen * pen, wxPenJoin style);
	void bmx_wxpen_setstipple(MaxPen * pen, MaxBitmap * stipple);
	void bmx_wxpen_setstyle(MaxPen * pen, int style);
	void bmx_wxpen_setwidth(MaxPen * pen, int width);
	wxDash * bmx_wxpen_getdashes(MaxPen * pen, int * count);
	void bmx_wxpen_setdashes(MaxPen * pen, wxDash * dashes, int count);

	wxDash * bmx_wxdashes_create(BBArray * dashes);
	BBArray * bmx_wxdashes_populate(wxDash * dashes, int count);
	void bmx_wxdashes_delete(wxDash * dashes);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPen
{
public:
	MaxPen();
	MaxPen(wxPen & pen = wxNullPen);
	wxPen & Pen();

private:
	wxPen pen;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

