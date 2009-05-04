/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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
#include "../wxicon.mod/glue.h"
#include "../wxbrush.mod/glue.h"
#include "../wxpen.mod/glue.h"
#include "../wxregion.mod/glue.h"

class MaxMirrorDC;
class MaxClientDC;

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
	void bmx_wxdc_setmapmode(MaxDC * dc, wxMappingMode mode);
	void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen);
	void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale);
	void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2);

	MaxMirrorDC * bmx_wxmirrordc_create(MaxDC * dc, bool mirror);

	void bmx_wxdc_setbackgroundmode(MaxDC * dc, int mode);
	void bmx_wxdc_setbrush(MaxDC * dc, MaxBrush * brush);
	void bmx_wxdc_setclippingregion(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_setclippingregionregion(MaxDC * dc, MaxRegion * region);
	void bmx_wxdc_setdeviceorigin(MaxDC * dc, int x, int y);
	void bmx_wxdc_drawellipse(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_drawellipserect(MaxDC * dc, MaxRect * rect);
	void bmx_wxdc_drawrectangle(MaxDC * dc, int x, int y, int w, int h);
	void bmx_wxdc_drawrectanglerect(MaxDC * dc, MaxRect * rect);
	void bmx_wxdc_drawroundedrectangle(MaxDC * dc, int x, int y, int w, int h, double radius);
	void bmx_wxdc_drawroundedrectanglerect(MaxDC * dc, MaxRect * rect, double radius);

	void wx_wxdc_calcboundingbox(MaxDC * dc, int x, int y);
	//void wx_wxdc_computescaleandorigin(MaxDC * dc);
	void wx_wxdc_crosshair(MaxDC * dc, int x, int y);
	void wx_wxdc_destroyclippingregion(MaxDC * dc);
	int wx_wxdc_devicetologicalx(MaxDC * dc, int x);
	int wx_wxdc_devicetologicalxrel(MaxDC * dc, int x);
	int wx_wxdc_devicetologicaly(MaxDC * dc, int y);
	int wx_wxdc_devicetologicalyrel(MaxDC * dc, int y);
	void wx_wxdc_drawarc(MaxDC * dc, int x1, int y1, int x2, int y2, int xc, int yc);
	void wx_wxdc_drawbitmap(MaxDC * dc, MaxBitmap * bitmap, int x, int y, bool transparent);
	void wx_wxdc_drawcheckmark(MaxDC * dc, int x, int y, int w, int h);
	void wx_wxdc_drawcheckmarkrect(MaxDC * dc, MaxRect * rect);
	void wx_wxdc_drawcircle(MaxDC * dc, int x, int y, int radius);

	void bmx_wxdc_drawellipticarc(MaxDC * dc, int x, int y, int width, int height, double _start, double _end);
	void bmx_wxdc_drawicon(MaxDC * dc, MaxIcon * icon, int x, int y);
	void bmx_wxdc_drawlabel(MaxDC * dc, BBString * text, int x, int y, int w, int h, MaxBitmap * image, int alignment, int indexAccel);
	void bmx_wxdc_drawlabelrect(MaxDC * dc, BBString * text, MaxRect * rect, MaxBitmap * image, int alignment, int indexAccel);
	void bmx_wxdc_drawlines(MaxDC * dc, BBArray * points, int xOffset, int yOffset);
	void bmx_wxdc_drawpolygon(MaxDC * dc, BBArray * points, int xOffset, int yOffset, wxPolygonFillMode fillStyle);
	void bmx_wxdc_drawpoint(MaxDC * dc, int x, int y);
	void bmx_wxdc_drawrotatedtext(MaxDC * dc, BBString * text, int x, int y, double angle);
	void bmx_wxdc_drawspline(MaxDC * dc, BBArray * points);
	void bmx_wxdc_enddoc(MaxDC * dc);
	void bmx_wxdc_endpage(MaxDC * dc);
	bool bmx_wxdc_floodfill(MaxDC * dc, int x, int y, MaxColour * colour, wxFloodFillStyle style);
	MaxBrush * bmx_wxdc_getbackground(MaxDC * dc);
	int bmx_wxdc_getbackgroundmode(MaxDC * dc);
	MaxBrush * bmx_wxdc_getbrush(MaxDC * dc);
	int bmx_wxdc_getcharwidth(MaxDC * dc);
	void bmx_wxdc_getclippingbox(MaxDC * dc, int * x, int * y, int * w, int * h);
	MaxFont * bmx_wxdc_getfont(MaxDC * dc);
	int bmx_wxdc_getlayoutdirection(MaxDC * dc);
	int bmx_wxdc_getlogicalfunction(MaxDC * dc);
	wxMappingMode bmx_wxdc_getmapmode(MaxDC * dc);

	void bmx_wxdc_getmultilinetextextent(MaxDC * dc, BBString * text, int * width, int * height, int * heightline);
	BBArray * bmx_wxdc_getpartialtextextents(MaxDC * dc, BBString * text);
	MaxPen * bmx_wxdc_getpen(MaxDC * dc);
	MaxColour * bmx_wxdc_getpixel(MaxDC * dc, int x, int y);
	void bmx_wxdc_getppi(MaxDC * dc, int * w, int * h);
	void bmx_wxdc_getsize(MaxDC * dc, int * w, int * h);
	void bmx_wxdc_getsizemm(MaxDC * dc, int * w, int * h);
	MaxColour * bmx_wxdc_gettextbackground(MaxDC * dc);
	MaxColour * bmx_wxdc_gettextforeground(MaxDC * dc);
	void bmx_wxdc_getuserscale(MaxDC * dc, double * x, double * y);
	void bmx_wxdc_gradientfillconcentric(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour);
	void bmx_wxdc_gradientfillconcentriccentre(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour, int centreX, int centreY);
	void bmx_wxdc_gradientfilllinear(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour, wxDirection direction);
	void bmx_wxdc_gradientfillconcentricrect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour);
	void bmx_wxdc_gradientfillconcentriccentrerect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour, int centreX, int centreY);
	void bmx_wxdc_gradientfilllinearrect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour, wxDirection direction);
	int bmx_wxdc_logicaltodevicex(MaxDC * dc, int x);
	int bmx_wxdc_logicaltodevicexrel(MaxDC * dc, int x);
	int bmx_wxdc_logicaltodevicey(MaxDC * dc, int y);
	int bmx_wxdc_logicaltodeviceyrel(MaxDC * dc, int y);
	int bmx_wxdc_maxx(MaxDC * dc);
	int bmx_wxdc_maxy(MaxDC * dc);
	int bmx_wxdc_minx(MaxDC * dc);
	int bmx_wxdc_miny(MaxDC * dc);
	bool bmx_wxdc_isok(MaxDC * dc);
	void bmx_wxdc_resetboundingbox(MaxDC * dc);
	void bmx_wxdc_setaxisorientation(MaxDC * dc, bool leftRight, bool topBottom);
	void bmx_wxdc_setlayoutdirection(MaxDC * dc, wxLayoutDirection dir);
	void bmx_wxdc_setlogicalfunction(MaxDC * dc, wxRasterOperationMode func);
	void bmx_wxdc_setpalette(MaxDC * dc, MaxPalette * palette);
	void bmx_wxdc_startdoc(MaxDC * dc, BBString * message);
	void bmx_wxdc_startpage(MaxDC * dc);
	
	void bmx_wxdc_delete(MaxDC * dc);
	void bmx_wxdc_free(MaxDC * dc);

	MaxClientDC * bmx_wxclientdc_create(wxWindow * window);
	void bmx_wxclientdc_delete(MaxClientDC * dc);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMirrorDC : public MaxDC
{
public:
	MaxMirrorDC(wxDC * dc, bool mirror);
private:
	wxMirrorDC mirrorDC;
};

class MaxClientDC : public MaxDC
{
public:
	MaxClientDC(wxWindow * window);
private:
	wxClientDC clientDC;
};
