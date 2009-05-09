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

class MaxBrush;

extern "C" {

#include <blitz.h>

	MaxBrush * bmx_wxstockgdi_brush_black();
	MaxBrush * bmx_wxstockgdi_brush_blue();
	MaxBrush * bmx_wxstockgdi_brush_cyan();
	MaxBrush * bmx_wxstockgdi_brush_green();
	MaxBrush * bmx_wxstockgdi_brush_grey();
	MaxBrush * bmx_wxstockgdi_brush_lightgrey();
	MaxBrush * bmx_wxstockgdi_brush_mediumgrey();
	MaxBrush * bmx_wxstockgdi_brush_red();
	MaxBrush * bmx_wxstockgdi_brush_transparent();
	MaxBrush * bmx_wxstockgdi_brush_white();

	MaxBrush * bmx_wxbrush_create(BBString * name, int style);
	void bmx_wxbrush_delete(MaxBrush * brush);
	
	MaxBrush * bmx_wxbrush_createfromcolour(MaxColour * colour, int style);
	MaxColour * bmx_wxbrush_getcolour(MaxBrush * brush);
	MaxBitmap * bmx_wxbrush_getstipple(MaxBrush * brush);
	int bmx_wxbrush_getstyle(MaxBrush * brush);
	bool bmx_wxbrush_ishatch(MaxBrush * brush);
	bool bmx_wxbrush_isok(MaxBrush * brush);
	void bmx_wxbrush_setcolour(MaxBrush * brush, BBString * colour);
	void bmx_wxbrush_setfromcolour(MaxBrush * brush, MaxColour * colour);
	void bmx_wxbrush_setfromrgb(MaxBrush * brush, int red, int green, int blue);
	void bmx_wxbrush_setstipple(MaxBrush * brush, MaxBitmap * bitmap);
	void bmx_wxbrush_setstyle(MaxBrush * brush, int style);

	MaxBrush * bmx_wxbrush_null();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBrush
{
public:
	MaxBrush();
	MaxBrush(wxBrush & brush = wxNullBrush);
	wxBrush & Brush();

private:
	wxBrush brush;

};


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

