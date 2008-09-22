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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxGraphicsPen::MaxGraphicsPen(wxGraphicsPen pen)
	: pen(pen)
{
}
	
wxGraphicsPen MaxGraphicsPen::Pen() {
	return pen;
}

MaxGraphicsBrush::MaxGraphicsBrush(wxGraphicsBrush brush)
	: brush(brush)
{
}
	
wxGraphicsBrush MaxGraphicsBrush::Brush() {
	return brush;
}

MaxGraphicsFont::MaxGraphicsFont(wxGraphicsFont font)
	: font(font)
{
}
	
wxGraphicsFont MaxGraphicsFont::Font() {
	return font;
}

MaxGraphicsPath::MaxGraphicsPath(wxGraphicsPath path)
	: path(path)
{
}
	
wxGraphicsPath MaxGraphicsPath::Path() {
	return path;
}

MaxGraphicsMatrix::MaxGraphicsMatrix(wxGraphicsMatrix matrix)
	: matrix(matrix)
{
}
	
wxGraphicsMatrix MaxGraphicsMatrix::Matrix() {
	return matrix;
}


// *********************************************

wxGraphicsContext * bmx_wxgraphicscontext_create(MaxWindowDC * dc) {
	return wxGraphicsContext::Create(*(wxWindowDC*)dc->GetDC());
}

wxGraphicsContext * bmx_wxgraphicscontext_createfromwindow(wxWindow * window) {
	return wxGraphicsContext::Create(window);
}

MaxGraphicsPen * bmx_wxgraphicscontext_createpen(wxGraphicsContext * context, MaxPen * pen) {
	return new MaxGraphicsPen(context->CreatePen(pen->Pen()));
}


MaxGraphicsBrush * bmx_wxgraphicscontext_createbrush(wxGraphicsContext * context, MaxBrush * brush) {
	return new MaxGraphicsBrush(context->CreateBrush(brush->Brush()));
}

MaxGraphicsBrush * bmx_wxgraphicscontext_createradialgradientbrush(wxGraphicsContext * context, double xo, double yo, double xc, double yc, double radius, MaxColour * oColour, MaxColour * cColour) {
	return new MaxGraphicsBrush(context->CreateRadialGradientBrush(xo, yo, xc, yc, radius, oColour->Colour(), cColour->Colour()));
}

MaxGraphicsBrush * bmx_wxgraphicscontext_createlineargradientbrush(wxGraphicsContext * context, double x1, double y1, double x2, double y2, MaxColour * c1, MaxColour * c2) {
	return new MaxGraphicsBrush(context->CreateLinearGradientBrush(x1, y1, x2, y2, c1->Colour(), c2->Colour()));
}

MaxGraphicsFont * bmx_wxgraphicscontext_createfont(wxGraphicsContext * context, MaxFont * font, MaxColour * col) {
	return new MaxGraphicsFont(context->CreateFont(font->Font(), col->Colour()));
}

MaxGraphicsMatrix * bmx_wxgraphicscontext_creatematrix(wxGraphicsContext * context, double a, double b, double c, double d, double tx, double ty) {
	return new MaxGraphicsMatrix(context->CreateMatrix(a, b, c, d, tx, ty));
}

MaxGraphicsPath * bmx_wxgraphicscontext_createpath(wxGraphicsContext * context) {
	return new MaxGraphicsPath(context->CreatePath());
}

void bmx_wxgraphicscontext_clip(wxGraphicsContext * context, double x, double y, double w, double h) {
	context->Clip(x, y, w, h);
}

void bmx_wxgraphicscontext_clipregion(wxGraphicsContext * context, MaxRegion * region) {
	context->Clip(region->Region());
}

void bmx_wxgraphicscontext_resetclip(wxGraphicsContext * context) {
	context->ResetClip();
}

void bmx_wxgraphicscontext_drawbitmap(wxGraphicsContext * context, MaxBitmap * bmp, double x, double y, double w, double h) {
	context->DrawBitmap(bmp->Bitmap(), x, y, w, h);
}

void bmx_wxgraphicscontext_drawellipse(wxGraphicsContext * context, double x, double y, double w, double h) {
	context->DrawEllipse(x, y, w, h);
}

void bmx_wxgraphicscontext_drawicon(wxGraphicsContext * context, MaxIcon * icon, double x, double y, double w, double h) {
	context->DrawIcon(icon->Icon(), x, y, w, h);
}

void bmx_wxgraphicscontext_drawlines(wxGraphicsContext * context, BBArray * p, int fillStyle) {
	int n = p->scales[0] / 2;
	double *s=(double*)BBARRAYDATA( p,p->dims );
	
	wxPoint2DDouble points[n];
	for (int i = 0; i < n; i++) {
		points[i].m_x = s[i * 2];
		points[i].m_y = s[i * 2 + 1];
	}
	
	context->DrawLines(n, points, fillStyle);
}

void bmx_wxgraphicscontext_drawpath(wxGraphicsContext * context, MaxGraphicsPath * path, int fillStyle) {
	context->DrawPath(path->Path(), fillStyle);
}

void bmx_wxgraphicscontext_drawrectangle(wxGraphicsContext * context, double x, double y, double w, double h) {
	context->DrawRectangle(x, y, w, h);
}

void bmx_wxgraphicscontext_drawroundedrectangle(wxGraphicsContext * context, double x, double y, double w, double h, double radius) {
	context->DrawRoundedRectangle(x, y, w, h, radius);
}

void bmx_wxgraphicscontext_drawtext(wxGraphicsContext * context, BBString * text, double x, double y, double angle) {
	context->DrawText(wxStringFromBBString(text), x, y, angle * 0.0174533f);
}

void bmx_wxgraphicscontext_fillpath(wxGraphicsContext * context, MaxGraphicsPath * path, int fillStyle) {
	context->FillPath(path->Path(), fillStyle);
}

void bmx_wxgraphicscontext_strokepath(wxGraphicsContext * context, MaxGraphicsPath * path) {
	context->StrokePath(path->Path());
}

void * bmx_wxgraphicscontext_getnativecontext(wxGraphicsContext * context) {
	return context->GetNativeContext();
}

BBArray * bmx_wxgraphicscontext_getpartialtextextents(wxGraphicsContext * context, BBString * text) {
	wxArrayDouble widths;
	context->GetPartialTextExtents(wxStringFromBBString(text), widths);
	return wxArrayDoubleToBBDoubleArray(widths);
}

void bmx_wxgraphicscontext_gettextextent(wxGraphicsContext * context, BBString * text, double * width, double * height, double * descent, double * externalLeading) {
	context->GetTextExtent(wxStringFromBBString(text), width, height, descent, externalLeading);
}

void bmx_wxgraphicscontext_rotate(wxGraphicsContext * context, double angle) {
	context->Rotate(angle * 0.0174533f);
}

void bmx_wxgraphicscontext_scale(wxGraphicsContext * context, double xScale, double yScale) {
	context->Scale(xScale, yScale);
}

void bmx_wxgraphicscontext_translate(wxGraphicsContext * context, double dx, double dy) {
	context->Translate(dx, dy);
}

MaxGraphicsMatrix * bmx_wxgraphicscontext_gettransform(wxGraphicsContext * context) {
	return new MaxGraphicsMatrix(context->GetTransform());
}

void bmx_wxgraphicscontext_settransform(wxGraphicsContext * context, MaxGraphicsMatrix * matrix) {
	context->SetTransform(matrix->Matrix());
}

void bmx_wxgraphicscontext_concattransform(wxGraphicsContext * context, MaxGraphicsMatrix * matrix) {
	context->ConcatTransform(matrix->Matrix());
}

void bmx_wxgraphicscontext_setbrush(wxGraphicsContext * context, MaxBrush * brush) {
	context->SetBrush(brush->Brush());
}

void bmx_wxgraphicscontext_setbrushnative(wxGraphicsContext * context, MaxGraphicsBrush * brush) {
	context->SetBrush(brush->Brush());
}

void bmx_wxgraphicscontext_setfont(wxGraphicsContext * context, MaxFont * font, MaxColour * colour) {
	context->SetFont(font->Font(), colour->Colour());
}

void bmx_wxgraphicscontext_setfontnative(wxGraphicsContext * context, MaxGraphicsFont * font) {
	context->SetFont(font->Font());
}

void bmx_wxgraphicscontext_setpen(wxGraphicsContext * context, MaxPen * pen) {
	context->SetPen(pen->Pen());
}

void bmx_wxgraphicscontext_setpennative(wxGraphicsContext * context, MaxGraphicsPen * pen) {
	context->SetPen(pen->Pen());
}

void bmx_wxgraphicscontext_strokeline(wxGraphicsContext * context, double x1, double y1, double x2, double y2) {
	context->StrokeLine(x1, y1, x2, y2);
}

void bmx_wxgraphicscontext_strokelines(wxGraphicsContext * context, BBArray * p) {
	int n = p->scales[0] / 2;
	double *s=(double*)BBARRAYDATA( p,p->dims );
	
	wxPoint2DDouble points[n];
	for (int i = 0; i < n; i++) {
		points[i].m_x = s[i * 2];
		points[i].m_y = s[i * 2 + 1];
	}
	
	context->StrokeLines(n, points);
}


void bmx_wxgraphicscontext_strokedisconnectedlines(wxGraphicsContext * context, BBArray * sp, BBArray * ep) {
	int n = sp->scales[0] / 2;
	double *s=(double*)BBARRAYDATA( sp,sp->dims );
	double *e=(double*)BBARRAYDATA( ep,ep->dims );
	
	wxPoint2DDouble startPoints[n];
	wxPoint2DDouble endPoints[n];

	for (int i = 0; i < n; i++) {
		startPoints[i].m_x = s[i * 2];
		startPoints[i].m_y = s[i * 2 + 1];

		endPoints[i].m_x = e[i * 2];
		endPoints[i].m_y = e[i * 2 + 1];
	}
	
	context->StrokeLines(n, startPoints, endPoints);
}

// *********************************************


void bmx_wxgraphicsfont_delete(MaxGraphicsFont * font) {
	delete font;
}

void bmx_wxgraphicspen_delete(MaxGraphicsPen * pen) {
	delete pen;
}

void bmx_wxgraphicsbrush_delete(MaxGraphicsBrush * brush) {
	delete brush;
}

void bmx_wxgraphicspath_delete(MaxGraphicsPath * path) {
	delete path;
}

void bmx_wxgraphicsmatrix_delete(MaxGraphicsMatrix * matrix) {
	delete matrix;
}

void bmx_wxgraphicsmatrix_concat(MaxGraphicsMatrix * matrix, MaxGraphicsMatrix * t) {
	matrix->Matrix().Concat(t->Matrix());
}

void bmx_wxgraphicsmatrix_get(MaxGraphicsMatrix * matrix, double * a, double * b, double * c, double * d, double * tx, double * ty) {
	matrix->Matrix().Get(a, b, c, d, tx, ty);
}

void * bmx_wxgraphicsmatrix_getnativematrix(MaxGraphicsMatrix * matrix) {
	return matrix->Matrix().GetNativeMatrix();
}

void bmx_wxgraphicsmatrix_invert(MaxGraphicsMatrix * matrix) {
	matrix->Matrix().Invert();
}

bool bmx_wxgraphicsmatrix_isequal(MaxGraphicsMatrix * matrix, MaxGraphicsMatrix * t) {
	return matrix->Matrix().IsEqual(t->Matrix());
}

bool bmx_wxgraphicsmatrix_isidentity(MaxGraphicsMatrix * matrix) {
	return matrix->Matrix().IsIdentity();
}

void bmx_wxgraphicsmatrix_rotate(MaxGraphicsMatrix * matrix, double angle) {
	matrix->Matrix().Rotate(angle * 0.0174533f);
}

void bmx_wxgraphicsmatrix_scale(MaxGraphicsMatrix * matrix, double xScale, double yScale) {
	matrix->Matrix().Scale(xScale, yScale);
}

void bmx_wxgraphicsmatrix_translate(MaxGraphicsMatrix * matrix, double dx, double dy) {
	matrix->Matrix().Translate(dx, dy);
}

void bmx_wxgraphicsmatrix_set(MaxGraphicsMatrix * matrix, double a, double b, double c, double d, double tx, double ty) {
	matrix->Matrix().Set(a, b, c, d, tx, ty);
}

void bmx_wxgraphicsmatrix_transformpoint(MaxGraphicsMatrix * matrix, double * x, double * y) {
	matrix->Matrix().TransformPoint(x, y);
}

void bmx_wxgraphicsmatrix_transformdistance(MaxGraphicsMatrix * matrix, double * dx, double * dy) {
	matrix->Matrix().TransformDistance(dx, dy);
}

// *********************************************


void bmx_wxgraphicspath_movetopoint(MaxGraphicsPath * path, double x, double y) {
	path->Path().MoveToPoint(x, y);
}

void bmx_wxgraphicspath_addarc(MaxGraphicsPath * path, double x, double y, double r, double startAngle, double endAngle, bool clockwise) {
	path->Path().AddArc(x, y, r, startAngle * 0.0174533f, endAngle * 0.0174533f, clockwise);
}

void bmx_wxgraphicspath_addarctopoint(MaxGraphicsPath * path, double x1, double y1, double x2, double y2, double radius) {
	path->Path().AddArcToPoint(x1, y1, x2, y2, radius);
}

void bmx_wxgraphicspath_addcircle(MaxGraphicsPath * path, double x, double y, double radius) {
	path->Path().AddCircle(x, y, radius);
}

void bmx_wxgraphicspath_addcurvetopoint(MaxGraphicsPath * path, double cx1, double cy1, double cx2, double cy2, double x, double y) {
	path->Path().AddCurveToPoint(cx1, cy1, cx2, cy2, x, y);
}

void bmx_wxgraphicspath_addellipse(MaxGraphicsPath * path, double x, double y, double w, double h) {
	path->Path().AddEllipse(x, y, w, h);
}

void bmx_wxgraphicspath_addlinetopoint(MaxGraphicsPath * path, double x, double y) {
	path->Path().AddLineToPoint(x, y);
}

void bmx_wxgraphicspath_addpath(MaxGraphicsPath * path, MaxGraphicsPath * p) {
	path->Path().AddPath(p->Path());
}

void bmx_wxgraphicspath_addquadcurvetopoint(MaxGraphicsPath * path, double cx, double cy, double x, double y) {
	path->Path().AddQuadCurveToPoint(cx, cy, x, y);
}

void bmx_wxgraphicspath_addrectangle(MaxGraphicsPath * path, double x, double y, double w, double h) {
	path->Path().AddRectangle(x, y, w, h);
}

void bmx_wxgraphicspath_addroundedrectangle(MaxGraphicsPath * path, double x, double y, double w, double h, double radius) {
	path->Path().AddRoundedRectangle(x, y, w, h, radius);
}

void bmx_wxgraphicspath_closesubpath(MaxGraphicsPath * path) {
	path->Path().CloseSubpath();
}

bool bmx_wxgraphicspath_contains(MaxGraphicsPath * path, double x, double y, int fillStyle) {
	return path->Path().Contains(x, y, fillStyle);
}

void bmx_wxgraphicspath_getbox(MaxGraphicsPath * path, double * x, double * y, double * w, double * h) {
	path->Path().GetBox(x, y, w, h);
}

void bmx_wxgraphicspath_getcurrentpoint(MaxGraphicsPath * path, double * x, double * y) {
	path->Path().GetCurrentPoint(x, y);
}

void bmx_wxgraphicspath_transform(MaxGraphicsPath * path, MaxGraphicsMatrix * matrix) {
	path->Path().Transform(matrix->Matrix());
}

void * bmx_wxgraphicspath_getnativepath(MaxGraphicsPath * path) {
	return path->Path().GetNativePath();
}

void bmx_wxgraphicspath_ungetnativepath(MaxGraphicsPath * path, void * nativePath) {
	path->Path().UnGetNativePath(nativePath);
}

