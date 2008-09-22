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
#include "../wxpen.mod/glue.h"
#include "../wxbrush.mod/glue.h"
#include "../wxicon.mod/glue.h"
#include "../wxregion.mod/glue.h"

class MaxGraphicsPen;
class MaxGraphicsBrush;
class MaxGraphicsFont;
class MaxGraphicsMatrix;
class MaxGraphicsPath;

extern "C" {

#include <blitz.h>

	wxGraphicsContext * bmx_wxgraphicscontext_create(MaxWindowDC * dc);
	wxGraphicsContext * bmx_wxgraphicscontext_createfromwindow(wxWindow * window);
	MaxGraphicsPen * bmx_wxgraphicscontext_createpen(wxGraphicsContext * context, MaxPen * pen);
	MaxGraphicsBrush * bmx_wxgraphicscontext_createbrush(wxGraphicsContext * context, MaxBrush * brush);
	MaxGraphicsBrush * bmx_wxgraphicscontext_createradialgradientbrush(wxGraphicsContext * context, double xo, double yo, double xc, double yc, double radius, MaxColour * oColour, MaxColour * cColour);
	MaxGraphicsBrush * bmx_wxgraphicscontext_createlineargradientbrush(wxGraphicsContext * context, double x1, double y1, double x2, double y2, MaxColour * c1, MaxColour * c2);
	MaxGraphicsFont * bmx_wxgraphicscontext_createfont(wxGraphicsContext * context, MaxFont * font, MaxColour * col);
	MaxGraphicsMatrix * bmx_wxgraphicscontext_creatematrix(wxGraphicsContext * context, double a, double b, double c, double d, double tx, double ty);
	MaxGraphicsPath * bmx_wxgraphicscontext_createpath(wxGraphicsContext * context);
	void bmx_wxgraphicscontext_clip(wxGraphicsContext * context, double x, double y, double w, double h);
	void bmx_wxgraphicscontext_clipregion(wxGraphicsContext * context, MaxRegion * region);
	void bmx_wxgraphicscontext_resetclip(wxGraphicsContext * context);
	void bmx_wxgraphicscontext_drawbitmap(wxGraphicsContext * context, MaxBitmap * bmp, double x, double y, double w, double h);
	void bmx_wxgraphicscontext_drawellipse(wxGraphicsContext * context, double x, double y, double w, double h);
	void bmx_wxgraphicscontext_drawicon(wxGraphicsContext * context, MaxIcon * icon, double x, double y, double w, double h);
	void bmx_wxgraphicscontext_drawlines(wxGraphicsContext * context, BBArray * points, int fillStyle);
	void bmx_wxgraphicscontext_drawpath(wxGraphicsContext * context, MaxGraphicsPath * path, int fillStyle);
	void bmx_wxgraphicscontext_drawrectangle(wxGraphicsContext * context, double x, double y, double w, double h);
	void bmx_wxgraphicscontext_drawroundedrectangle(wxGraphicsContext * context, double x, double y, double w, double h, double radius);
	void bmx_wxgraphicscontext_drawtext(wxGraphicsContext * context, BBString * text, double x, double y, double angle);
	void bmx_wxgraphicscontext_fillpath(wxGraphicsContext * context, MaxGraphicsPath * path, int fillStyle);
	void bmx_wxgraphicscontext_strokepath(wxGraphicsContext * context, MaxGraphicsPath * path);
	void * bmx_wxgraphicscontext_getnativecontext(wxGraphicsContext * context);
	BBArray * bmx_wxgraphicscontext_getpartialtextextents(wxGraphicsContext * context, BBString * text);
	void bmx_wxgraphicscontext_gettextextent(wxGraphicsContext * context, BBString * text, double * width, double * height, double * descent, double * externalLeading);
	void bmx_wxgraphicscontext_rotate(wxGraphicsContext * context, double angle);
	void bmx_wxgraphicscontext_scale(wxGraphicsContext * context, double xScale, double yScale);
	void bmx_wxgraphicscontext_translate(wxGraphicsContext * context, double dx, double dy);
	MaxGraphicsMatrix * bmx_wxgraphicscontext_gettransform(wxGraphicsContext * context);
	void bmx_wxgraphicscontext_settransform(wxGraphicsContext * context, MaxGraphicsMatrix * matrix);
	void bmx_wxgraphicscontext_concattransform(wxGraphicsContext * context, MaxGraphicsMatrix * matrix);
	void bmx_wxgraphicscontext_setbrush(wxGraphicsContext * context, MaxBrush * brush);
	void bmx_wxgraphicscontext_setbrushnative(wxGraphicsContext * context, MaxGraphicsBrush * brush);
	void bmx_wxgraphicscontext_setfont(wxGraphicsContext * context, MaxFont * font, MaxColour * colour);
	void bmx_wxgraphicscontext_setfontnative(wxGraphicsContext * context, MaxGraphicsFont * font);
	void bmx_wxgraphicscontext_setpen(wxGraphicsContext * context, MaxPen * pen);
	void bmx_wxgraphicscontext_setpennative(wxGraphicsContext * context, MaxGraphicsPen * pen);
	void bmx_wxgraphicscontext_strokeline(wxGraphicsContext * context, double x1, double y1, double x2, double y2);
	void bmx_wxgraphicscontext_strokelines(wxGraphicsContext * context, BBArray * points);
	void bmx_wxgraphicscontext_strokedisconnectedlines(wxGraphicsContext * context, BBArray * startPoints, BBArray * endPoints);
	
	void bmx_wxgraphicsfont_delete(MaxGraphicsFont * font);
	void bmx_wxgraphicspen_delete(MaxGraphicsPen * pen);
	void bmx_wxgraphicsbrush_delete(MaxGraphicsBrush * brush);
	void bmx_wxgraphicspath_delete(MaxGraphicsPath * path);
	void bmx_wxgraphicsmatrix_delete(MaxGraphicsMatrix * matrix);

	void bmx_wxgraphicsmatrix_concat(MaxGraphicsMatrix * matrix, MaxGraphicsMatrix * t);
	void bmx_wxgraphicsmatrix_get(MaxGraphicsMatrix * matrix, double * a, double * b, double * c, double * d, double * tx, double * ty);
	void * bmx_wxgraphicsmatrix_getnativematrix(MaxGraphicsMatrix * matrix);
	void bmx_wxgraphicsmatrix_invert(MaxGraphicsMatrix * matrix);
	bool bmx_wxgraphicsmatrix_isequal(MaxGraphicsMatrix * matrix, MaxGraphicsMatrix * t);
	bool bmx_wxgraphicsmatrix_isidentity(MaxGraphicsMatrix * matrix);
	void bmx_wxgraphicsmatrix_rotate(MaxGraphicsMatrix * matrix, double angle);
	void bmx_wxgraphicsmatrix_scale(MaxGraphicsMatrix * matrix, double xScale, double yScale);
	void bmx_wxgraphicsmatrix_translate(MaxGraphicsMatrix * matrix, double dx, double dy);
	void bmx_wxgraphicsmatrix_set(MaxGraphicsMatrix * matrix, double a, double b, double c, double d, double tx, double ty);
	void bmx_wxgraphicsmatrix_transformpoint(MaxGraphicsMatrix * matrix, double * x, double * y);
	void bmx_wxgraphicsmatrix_transformdistance(MaxGraphicsMatrix * matrix, double * dx, double * dy);
	
	void bmx_wxgraphicspath_movetopoint(MaxGraphicsPath * path, double x, double y);
	void bmx_wxgraphicspath_addarc(MaxGraphicsPath * path, double x, double y, double r, double startAngle, double endAngle, bool clockwise);
	void bmx_wxgraphicspath_addarctopoint(MaxGraphicsPath * path, double x1, double y1, double x2, double y2, double radius);
	void bmx_wxgraphicspath_addcircle(MaxGraphicsPath * path, double x, double y, double radius);
	void bmx_wxgraphicspath_addcurvetopoint(MaxGraphicsPath * path, double cx1, double cy1, double cx2, double cy2, double x, double y);
	void bmx_wxgraphicspath_addellipse(MaxGraphicsPath * path, double x, double y, double w, double h);
	void bmx_wxgraphicspath_addlinetopoint(MaxGraphicsPath * path, double x, double y);
	void bmx_wxgraphicspath_addpath(MaxGraphicsPath * path, MaxGraphicsPath * p);
	void bmx_wxgraphicspath_addquadcurvetopoint(MaxGraphicsPath * path, double cx, double cy, double x, double y);
	void bmx_wxgraphicspath_addrectangle(MaxGraphicsPath * path, double x, double y, double w, double h);
	void bmx_wxgraphicspath_addroundedrectangle(MaxGraphicsPath * path, double x, double y, double w, double h, double radius);
	void bmx_wxgraphicspath_closesubpath(MaxGraphicsPath * path);
	bool bmx_wxgraphicspath_contains(MaxGraphicsPath * path, double x, double y, int fillStyle);
	void bmx_wxgraphicspath_getbox(MaxGraphicsPath * path, double * x, double * y, double * w, double * h);
	void bmx_wxgraphicspath_getcurrentpoint(MaxGraphicsPath * path, double * x, double * y);
	void bmx_wxgraphicspath_transform(MaxGraphicsPath * path, MaxGraphicsMatrix * matrix);
	void * bmx_wxgraphicspath_getnativepath(MaxGraphicsPath * path);
	void bmx_wxgraphicspath_ungetnativepath(MaxGraphicsPath * path, void * nativePath);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGraphicsPen
{
public:
	MaxGraphicsPen(wxGraphicsPen pen);
	
	wxGraphicsPen Pen();
	
private:
	wxGraphicsPen pen;
};

class MaxGraphicsBrush
{
public:
	MaxGraphicsBrush(wxGraphicsBrush brush);
	
	wxGraphicsBrush Brush();
	
private:
	wxGraphicsBrush brush;
};

class MaxGraphicsFont
{
public:
	MaxGraphicsFont(wxGraphicsFont font);
	
	wxGraphicsFont Font();
	
private:
	wxGraphicsFont font;
};

class MaxGraphicsPath
{
public:
	MaxGraphicsPath(wxGraphicsPath path);
	
	wxGraphicsPath Path();
	
private:
	wxGraphicsPath path;
};

class MaxGraphicsMatrix
{
public:
	MaxGraphicsMatrix(wxGraphicsMatrix matrix);
	
	wxGraphicsMatrix Matrix();
	
private:
	wxGraphicsMatrix matrix;
};
