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

#include "wxglue.h"
#include "wx/dcmirror.h"
#include "../wxbitmap.mod/glue.h"
#include "../wxbrush.mod/glue.h"

class MaxMirrorDC;

extern "C" {

#include <blitz.h>

	void bmx_wxdc_clear(MaxDC * dc);	
	void bmx_wxdc_setbackground(MaxDC * dc, MaxBrush * brush);
	void bmx_wxdc_drawtext(MaxDC * dc, BBString * text, int x, int y);
	int bmx_wxdc_getcharheight(MaxDC * dc);
	void bmx_wxdc_setfont(MaxDC * dc, MaxFont * font);
	void bmx_wxdc_settextbackground(MaxDC * dc, MaxColour * colour);
	void bmx_wxdc_settextforeground(MaxDC * dc, MaxColour * colour);
	void bmx_wxdc_gettextextent(MaxDC * dc, BBString * text, int * w, int * h);
	void bmx_wxdc_setmapmode(MaxDC * dc, int mode);
	void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen);
	void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale);
	void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2);

	MaxMirrorDC * bmx_wxmirrordc_create(MaxDC * dc, bool mirror);

	void bmx_wxdc_setbackgroundmode(MaxDC * dc, int mode);
	void bmx_wxdc_setbrush(MaxDC * dc, MaxBrush * brush);
	void bmx_wxdc_setclippingregion(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_setdeviceorigin(MaxDC * dc, int x, int y);
	void bmx_wxdc_drawellipse(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_drawrectangle(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_drawroundedrectangle(MaxDC * dc, int x, int y, int w, int h, double radius);

	void wx_wxdc_calcboundingbox(MaxDC * dc, int x, int y);
	void wx_wxdc_computescaleandorigin(MaxDC * dc);
	void wx_wxdc_crosshair(MaxDC * dc, int x, int y);
	void wx_wxdc_destroyclippingregion(MaxDC * dc);
	int wx_wxdc_devicetologicalx(MaxDC * dc, int x);
	int wx_wxdc_devicetologicalxrel(MaxDC * dc, int x);
	int wx_wxdc_devicetologicaly(MaxDC * dc, int y);
	int wx_wxdc_devicetologicalyrel(MaxDC * dc, int y);
	void wx_wxdc_drawarc(MaxDC * dc, int x1, int y1, int x2, int y2, int xc, int yc);
	void wx_wxdc_drawbitmap(MaxDC * dc, MaxBitmap * bitmap, int x, int y, bool transparent);
	void wx_wxdc_drawcheckmark(MaxDC * dc, int x, int y, int w, int h);
	void wx_wxdc_drawcircle(MaxDC * dc, int x, int y, int radius);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMirrorDC : public MaxDC
{
public:
	MaxMirrorDC(wxDC * dc, bool mirror);
private:
	wxMirrorDC mirrorDC;
};

