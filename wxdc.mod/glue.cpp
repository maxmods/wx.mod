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

MaxMirrorDC::MaxMirrorDC(wxDC * dc, bool mirror)
	: mirrorDC(*dc, mirror)
{
	MaxDC::init(&mirrorDC);
}


// *********************************************



MaxMirrorDC * bmx_wxmirrordc_create(MaxDC * dc, bool mirror) {
	return new MaxMirrorDC(dc->GetDC(), mirror);
}

void bmx_wxdc_clear(MaxDC * dc) {
	dc->GetDC()->Clear();
}

void bmx_wxdc_setbackground(MaxDC * dc, MaxBrush * brush) {
	dc->GetDC()->SetBackground(brush->Brush());
}

void bmx_wxdc_drawtext(MaxDC * dc, BBString * text, int x, int y) {
	dc->GetDC()->DrawText(wxStringFromBBString(text), x, y);
}

int bmx_wxdc_getcharheight(MaxDC * dc) {
	return dc->GetDC()->GetCharHeight();
}

void bmx_wxdc_setfont(MaxDC * dc, MaxFont * font) {
	dc->GetDC()->SetFont(font->Font());
}

void bmx_wxdc_settextbackground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextBackground(colour->Colour());
}

void bmx_wxdc_settextforeground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextForeground(colour->Colour());
}

void bmx_wxdc_gettextextent(MaxDC * dc, BBString * text, int * w, int * h) {
	wxSize s = dc->GetDC()->GetTextExtent(wxStringFromBBString(text));
	*w = s.x;
	*h = s.y;
}

void bmx_wxdc_setmapmode(MaxDC * dc, int mode) {
	dc->GetDC()->SetMapMode(mode);
}

void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen) {
	dc->GetDC()->SetPen(pen->Pen());
}

void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale) {
	dc->GetDC()->SetUserScale(xscale, yscale);
}

void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2) {
	dc->GetDC()->DrawLine(x1, y1, x2, y2);
}

void bmx_wxdc_setbackgroundmode(MaxDC * dc, int mode) {
	dc->GetDC()->SetBackgroundMode(mode);
}

void bmx_wxdc_setbrush(MaxDC * dc, MaxBrush * brush) {
	dc->GetDC()->SetBrush(brush->Brush());
}

void bmx_wxdc_setclippingregion(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->SetClippingRegion(x, y, w, h);
}

void bmx_wxdc_setdeviceorigin(MaxDC * dc, int x, int y) {
	dc->GetDC()->SetDeviceOrigin(x, y);
}

void bmx_wxdc_drawellipse(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->DrawEllipse(x, y, w, h);
}


// *********************************************

