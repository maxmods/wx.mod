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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxPdfDocument::MaxPdfDocument(BBObject * handle, int orientation, const wxString& unit, wxPaperSize format)
	: maxHandle(handle), wxPdfDocument(orientation, unit, format)
{
}

MaxPdfDocument::~MaxPdfDocument() {
}

void MaxPdfDocument::Header() {
	_wx_wxpdfdocument_wxPdfDocument__Header(maxHandle);
}

void MaxPdfDocument::Footer() {
	_wx_wxpdfdocument_wxPdfDocument__Footer(maxHandle);
}

bool MaxPdfDocument::AcceptPageBreak() {
	return _wx_wxpdfdocument_wxPdfDocument__AcceptPageBreak(maxHandle);
}

bool MaxPdfDocument::AcceptPageBreak_default() {
	return wxPdfDocument::AcceptPageBreak();
}


// ---------------------------------------------------------------------------------------

MaxPdfLink::MaxPdfLink(const wxPdfLink & l)
	: pdfLink(l)
{
}

wxPdfLink & MaxPdfLink::Link() {
	return pdfLink;
}

// ---------------------------------------------------------------------------------------

MaxPdfColour::MaxPdfColour(const wxPdfColour & c)
	: colour(c)
{
}

wxPdfColour & MaxPdfColour::Colour() {
	return colour;
}

// ---------------------------------------------------------------------------------------

MaxPdfLineStyle::MaxPdfLineStyle(const wxPdfLineStyle & s)
	: style(s)
{
}

wxPdfLineStyle & MaxPdfLineStyle::Style() {
	return style;
}


// *********************************************

MaxPdfShape::MaxPdfShape(const wxPdfShape & s)
	: shape(s)
{
}

wxPdfShape & MaxPdfShape::Shape() {
	return shape;
}


// *********************************************

MaxPdfInfo::MaxPdfInfo(const wxPdfInfo & i)
	: info(i)
{
}

wxPdfInfo & MaxPdfInfo::Info() {
	return info;
}


// *********************************************

MaxPdfCoonsPatchMesh::MaxPdfCoonsPatchMesh(const wxPdfCoonsPatchMesh & m)
	: mesh(m)
{
}

wxPdfCoonsPatchMesh & MaxPdfCoonsPatchMesh::Mesh() {
	return mesh;
}


// *********************************************

MaxPdfFontDescription::MaxPdfFontDescription(const wxPdfFontDescription & d)
	: desc(d)
{
}

wxPdfFontDescription & MaxPdfFontDescription::Desc() {
	return desc;
}


// *********************************************


wxPdfArrayDouble bbDoubleArrayTowxPdfArrayDouble( BBArray *p ){
	int n=p->scales[0];
	double *s=(double*)BBARRAYDATA( p,p->dims );
	wxPdfArrayDouble arr;
	arr.Alloc(n);
	for( int i=0;i<n;++i ){
		arr.Add(s[i]);
	}
	return arr;
}



void bmx_wxpdfdocument_free(wxPdfDocument * doc) {
	delete doc;
}

wxPdfDocument * bmx_wxpdfdocument_create(BBObject * handle, int orientation, BBString * unit, wxPaperSize format) {
	return new MaxPdfDocument(handle, orientation, wxStringFromBBString(unit), format);
}

void bmx_wxpdfdocument_addpage(wxPdfDocument * doc, int orientation) {
	doc->AddPage(orientation);
}

void bmx_wxpdfdocument_setfont(wxPdfDocument * doc, BBString * family, BBString * style, double size) {
	doc->SetFont(wxStringFromBBString(family), wxStringFromBBString(style), size);
}

void bmx_wxpdfdocument_cell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int ln, int align, int fill, MaxPdfLink * link) {
	if (link) {
		doc->Cell(w, h, wxStringFromBBString(txt), border, ln, align, fill, link->Link());
	} else {
		doc->Cell(w, h, wxStringFromBBString(txt), border, ln, align, fill);
	}
}

void bmx_wxpdfdocument_saveasfile(wxPdfDocument * doc, BBString * name) {
	doc->SaveAsFile(wxStringFromBBString(name));
}

void bmx_wxpdfdocument_addspotcolour(wxPdfDocument * doc, BBString * name, double cyan, double magenta, double yellow, double black) {
	doc->AddSpotColour(wxStringFromBBString(name), cyan, magenta, yellow, black);
}

void bmx_wxpdfdocument_aliasnbpages(wxPdfDocument * doc, BBString * _alias) {
	doc->AliasNbPages(wxStringFromBBString(_alias));
}

void bmx_wxpdfdocument_arrow(wxPdfDocument * doc, double x1, double y1, double x2, double y2, double lineWidth, double height, double width) {
	doc->Arrow(x1, y1, x2, y2, lineWidth, height, width);
}

void bmx_wxpdfdocument_circle(wxPdfDocument * doc, double x0, double y0, double r, double astart, double afinish, int style, int nSeg) {
	doc->Circle(x0, y0, r, astart, afinish, style, nSeg);
}

void bmx_wxpdfdocument_curve(wxPdfDocument * doc, double x0, double y0, double x1, double y1, double x2, double y2, double x3, double y3, int style) {
	doc->Curve(x0, y0, x1, y1, x2, y2, x3, y3, style);
}

void bmx_wxpdfdocument_ellipse(wxPdfDocument * doc, double x0, double y0, double rx, double ry, double angle, double astart, double afinish, int style, int nSeg) {
	doc->Ellipse(x0, y0, rx, ry, angle, astart, afinish, style, nSeg);
}

int bmx_wxpdfdocument_image(wxPdfDocument * doc, BBString * file, double x, double y, double w, double h, BBString * mimeType, MaxPdfLink * link, int maskImage) {
	if (link) {
		return static_cast<int>(doc->Image(wxStringFromBBString(file), x, y, w, h, wxStringFromBBString(mimeType), link->Link(), maskImage));
	} else {
		return static_cast<int>(doc->Image(wxStringFromBBString(file), x, y, w, h, wxStringFromBBString(mimeType), wxPdfLink(-1), maskImage));
	}
}

void bmx_wxpdfdocument_ln(wxPdfDocument * doc, double h) {
	doc->Ln(h);
}

void bmx_wxpdfdocument_sety(wxPdfDocument * doc, double y) {
	doc->SetY(y);
}

int bmx_wxpdfdocument_pageno(wxPdfDocument * doc) {
	return doc->PageNo();
}

void bmx_wxpdfdocument_setx(wxPdfDocument * doc, double x) {
	doc->SetX(x);
}

void bmx_wxpdfdocument_settitle(wxPdfDocument * doc, BBString * title) {
	doc->SetTitle(wxStringFromBBString(title));
}

void bmx_wxpdfdocument_setdrawcolour(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetDrawColour(colour->Colour());
}

void bmx_wxpdfdocument_setfillcolour(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetFillColour(colour->Colour());
}

void bmx_wxpdfdocument_settextcolour(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetTextColour(colour->Colour());
}

double bmx_wxpdfdocument_getstringwidth(wxPdfDocument * doc, BBString * text) {
	return doc->GetStringWidth(wxStringFromBBString(text));
}

void bmx_wxpdfdocument_setlinewidth(wxPdfDocument * doc, double width) {
	doc->SetLineWidth(width);
}

void bmx_wxpdfdocument_setauthor(wxPdfDocument * doc, BBString * author) {
	doc->SetAuthor(wxStringFromBBString(author));
}

void bmx_wxpdfdocument_settextcolourgrayscale(wxPdfDocument * doc, int grayscale) {
	doc->SetTextColour(static_cast<unsigned char>(grayscale));
}

int bmx_wxpdfdocument_multicell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int align, int fill, int maxline) {
	return doc->MultiCell(w, h, wxStringFromBBString(txt), border, align, fill, maxline);
}

int bmx_wxpdfdocument_acceptpagebreak(MaxPdfDocument * doc) {
	return static_cast<int>(doc->AcceptPageBreak_default());
}

int bmx_wxpdfdocument_addfont(wxPdfDocument * doc, BBString * family, BBString * style, BBString * file) {
	return static_cast<int>(doc->AddFont(wxStringFromBBString(family), wxStringFromBBString(style), wxStringFromBBString(file)));
}

int bmx_wxpdfdocument_addfontcjk(wxPdfDocument * doc, BBString * family) {
	return static_cast<int>(doc->AddFontCJK(wxStringFromBBString(family)));
}

int bmx_wxpdfdocument_addlink(wxPdfDocument * doc) {
	return doc->AddLink();
}

void bmx_wxpdfdocument_annotate(wxPdfDocument * doc, double x, double y, BBString * text) {
	doc->Annotate(x, y, wxStringFromBBString(text));
}

void bmx_wxpdfdocument_appendjavascript(wxPdfDocument * doc, BBString * javascript) {
	doc->AppendJavascript(wxStringFromBBString(javascript));
}

int bmx_wxpdfdocument_axialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double x2, double y2, double intexp) {
	return doc->AxialGradient(col1->Colour(), col2->Colour(), x1, y1, x2, y2, intexp);
}

int bmx_wxpdfdocument_begintemplate(wxPdfDocument * doc, double x, double y, double width, double height) {
	return doc->BeginTemplate(x, y, width, height);
}

void bmx_wxpdfdocument_bookmark(wxPdfDocument * doc, BBString * txt, int level, double y) {
	doc->Bookmark(wxStringFromBBString(txt), level, y);
}

void bmx_wxpdfdocument_setimagescale(wxPdfDocument * doc, double scale) {
	doc->SetImageScale(scale);
}

void bmx_wxpdfdocument_setkeywords(wxPdfDocument * doc, BBString * keywords) {
	doc->SetKeywords(wxStringFromBBString(keywords));
}

void bmx_wxpdfdocument_setleftmargin(wxPdfDocument * doc, double margin) {
	doc->SetLeftMargin(margin);
}

void bmx_wxpdfdocument_setlineheight(wxPdfDocument * doc, double height) {
	doc->SetLineHeight(height);
}

void bmx_wxpdfdocument_setlinestyle(wxPdfDocument * doc, MaxPdfLineStyle * style) {
	doc->SetLineStyle(style->Style());
}

double bmx_wxpdfdocument_gettopmargin(wxPdfDocument * doc) {
	doc->GetTopMargin();
}

double bmx_wxpdfdocument_getx(wxPdfDocument * doc) {
	return doc->GetX();
}

double bmx_wxpdfdocument_gety(wxPdfDocument * doc) {
	return doc->GetY();
}

double bmx_wxpdfdocument_getbreakmargin(wxPdfDocument * doc) {
	return doc->GetBreakMargin();
}

double bmx_wxpdfdocument_getcellmargin(wxPdfDocument * doc) {
	return doc->GetCellMargin();
}

BBString * bmx_wxpdfdocument_getfontfamily(wxPdfDocument * doc) {
	return bbStringFromWxString(doc->GetFontFamily());
}

double bmx_wxpdfdocument_getfontsize(wxPdfDocument * doc) {
	return doc->GetFontSize();
}

BBString * bmx_wxpdfdocument_getfontstyle(wxPdfDocument * doc) {
	return bbStringFromWxString(doc->GetFontStyle());
}

int bmx_wxpdfdocument_getfontsubsetting(wxPdfDocument * doc) {
	return static_cast<int>(doc->GetFontSubsetting());
}

double bmx_wxpdfdocument_getimagescale(wxPdfDocument * doc) {
	return doc->GetImageScale();
}

double bmx_wxpdfdocument_getleftmargin(wxPdfDocument * doc) {
	return doc->GetLeftMargin();
}

double bmx_wxpdfdocument_getlineheight(wxPdfDocument * doc) {
	return doc->GetLineHeight();
}

double bmx_wxpdfdocument_getlinewidth(wxPdfDocument * doc) {
	return doc->GetLineWidth();
}

void bmx_wxpdfdocument_writexml(wxPdfDocument * doc, BBString * txt) {
	doc->WriteXml(wxStringFromBBString(txt));
}

void bmx_wxpdfdocument_translate(wxPdfDocument * doc, double tx, double ty) {
	doc->Translate(tx, ty);
}

void bmx_wxpdfdocument_translatex(wxPdfDocument * doc, double tx) {
	doc->TranslateX(tx);
}

void bmx_wxpdfdocument_translatey(wxPdfDocument * doc, double ty) {
	doc->TranslateY(ty);
}

void bmx_wxpdfdocument_unsetclipping(wxPdfDocument * doc) {
	doc->UnsetClipping();
}

void bmx_wxpdfdocument_usetemplate(wxPdfDocument * doc, int templateId, double x, double y, double width, double height) {
	doc->UseTemplate(templateId, x, y, width, height);
}

void bmx_wxpdfdocument_write(wxPdfDocument * doc, double h, BBString * txt, MaxPdfLink * link) {
	if (link) {
		doc->Write(h, wxStringFromBBString(txt), link->Link());
	} else {
		doc->Write(h, wxStringFromBBString(txt));
	}
}

void bmx_wxpdfdocument_writecell(wxPdfDocument * doc, double h, BBString * txt, int border, int fill, MaxPdfLink * link) {
	if (link) {
		doc->WriteCell(h, wxStringFromBBString(txt), border, fill, link->Link());
	} else {
		doc->WriteCell(h, wxStringFromBBString(txt), border, fill);
	}
}

void bmx_wxpdfdocument_textfield(wxPdfDocument * doc, BBString * name, double width, double height, BBString * value, int multiline) {
	doc->TextField(wxStringFromBBString(name), width, height, wxStringFromBBString(value), static_cast<bool>(multiline));
}

void bmx_wxpdfdocument_textfieldxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBString * value, int multiline) {
	doc->TextField(wxStringFromBBString(name), x, y, width, height, wxStringFromBBString(value), static_cast<bool>(multiline));
}

void bmx_wxpdfdocument_stoptransform(wxPdfDocument * doc) {
	doc->StopTransform();
}

void bmx_wxpdfdocument_text(wxPdfDocument * doc, double x, double y, BBString * txt) {
	doc->Text(x, y, wxStringFromBBString(txt));
}

int bmx_wxpdfdocument_textbox(wxPdfDocument * doc, double w, double h, BBString * txt, int halign, int valign, int border, int fill) {
	return doc->TextBox(w, h, wxStringFromBBString(txt), halign, valign, border, fill);
}

void bmx_wxpdfdocument_checkbox(wxPdfDocument * doc, BBString * name, double width, int checked) {
	doc->CheckBox(wxStringFromBBString(name), width, static_cast<bool>(checked));
}

void bmx_wxpdfdocument_checkboxxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, int checked) {
	doc->CheckBox(wxStringFromBBString(name), x, y, width, static_cast<bool>(checked));
}

void bmx_wxpdfdocument_combobox(wxPdfDocument * doc, BBString * name, double width, double height, BBArray * values) {
	doc->ComboBox(wxStringFromBBString(name), width, height, bbStringArrayTowxArrayStr(values));
}

void bmx_wxpdfdocument_comboboxxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBArray * values) {
	doc->ComboBox(wxStringFromBBString(name), x, y, width, height, bbStringArrayTowxArrayStr(values));
}

void bmx_wxpdfdocument_clippedcell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int ln, int align, int fill, MaxPdfLink * link) {
	if (link) {
		doc->ClippedCell(w, h, wxStringFromBBString(txt), border, ln, align, fill, link->Link());
	} else {
		doc->ClippedCell(w, h, wxStringFromBBString(txt), border, ln, align, fill);
	}
}

void bmx_wxpdfdocument_clippingellipse(wxPdfDocument * doc, double x, double y, double rx, double ry, int outline) {
	doc->ClippingEllipse(x, y, rx, ry, static_cast<bool>(outline));
}

void bmx_wxpdfdocument_clippingpath(wxPdfDocument * doc) {
	doc->ClippingPath();
}

void bmx_wxpdfdocument_clippingpathshape(wxPdfDocument * doc, MaxPdfShape * shape, int style) {
	doc->ClippingPath(shape->Shape(), style);
}

void bmx_wxpdfdocument_clippingpolygon(wxPdfDocument * doc, BBArray * x, BBArray * y, int outline) {
	doc->ClippingPolygon(bbDoubleArrayTowxPdfArrayDouble(x), bbDoubleArrayTowxPdfArrayDouble(y), static_cast<bool>(outline));
}

void bmx_wxpdfdocument_clippingrect(wxPdfDocument * doc, double x, double y, double w, double h, int outline) {
	doc->ClippingRect(x, y, w, h, static_cast<bool>(outline));
}

void bmx_wxpdfdocument_clippingtext(wxPdfDocument * doc, double x, double y, BBString * txt, int outline) {
	doc->ClippingText(x, y, wxStringFromBBString(txt), static_cast<bool>(outline));
}

void bmx_wxpdfdocument_closepath(wxPdfDocument * doc, int style) {
	doc->ClosePath(style);
}

int bmx_wxpdfdocument_setalpha(wxPdfDocument * doc, double lineAlpha, double fillAlpha, wxPdfBlendMode blendMode) {
	return doc->SetAlpha(lineAlpha, fillAlpha, blendMode);
}

void bmx_wxpdfdocument_rect(wxPdfDocument * doc, double x, double y, double w, double h, int style) {
	doc->Rect(x, y, w, h, style);
}

int bmx_wxpdfdocument_imagemask(wxPdfDocument * doc, BBString * file, BBString * mimeType) {
	return doc->ImageMask(wxStringFromBBString(file), wxStringFromBBString(mimeType));
}

void bmx_wxpdfdocument_starttransform(wxPdfDocument * doc) {
	doc->StartTransform();
}

void bmx_wxpdfdocument_settopmargin(wxPdfDocument * doc, double margin) {
	doc->SetTopMargin(margin);
}

void bmx_wxpdfdocument_setviewerpreferences(wxPdfDocument * doc, int preferences) {
	doc->SetViewerPreferences(preferences);
}

void bmx_wxpdfdocument_setxy(wxPdfDocument * doc, double x, double y) {
	doc->SetXY(x, y);
}

int bmx_wxpdfdocument_skew(wxPdfDocument * doc, double xAngle, double yAngle, double x, double y) {
	return static_cast<int>(doc->Skew(xAngle, yAngle, x, y));
}

int bmx_wxpdfdocument_skewx(wxPdfDocument * doc, double xAngle, double x, double y) {
	return static_cast<int>(doc->SkewX(xAngle, x, y));
}

int bmx_wxpdfdocument_skewy(wxPdfDocument * doc, double yAngle, double x, double y) {
	return static_cast<int>(doc->SkewY(yAngle, x, y));
}

void bmx_wxpdfdocument_starpolygon(wxPdfDocument * doc, double x0, double y0, double r,
		int nv, int nr, double angle, int circle, int style, int circleStyle, MaxPdfLineStyle * circleLineStype, MaxPdfColour * circleFillColour) {
	if (circleLineStype) {
		if (circleFillColour) {
			doc->StarPolygon(x0, y0, r, nv, nr, angle, static_cast<bool>(circle), style, circleStyle, circleLineStype->Style(), circleFillColour->Colour());
		} else {
			doc->StarPolygon(x0, y0, r, nv, nr, angle, static_cast<bool>(circle), style, circleStyle, circleLineStype->Style(), wxPdfColour());
		}
	} else {
		if (circleFillColour) {
			doc->StarPolygon(x0, y0, r, nv, nr, angle, static_cast<bool>(circle), style, circleStyle, wxPdfLineStyle(), circleFillColour->Colour());
		} else {
			doc->StarPolygon(x0, y0, r, nv, nr, angle, static_cast<bool>(circle), style, circleStyle, wxPdfLineStyle(), wxPdfColour());
		}
	}
}

void bmx_wxpdfdocument_shape(wxPdfDocument * doc, MaxPdfShape * shape, int style) {
	doc->Shape(shape->Shape(), style);
}

void bmx_wxpdfdocument_shapedtext(wxPdfDocument * doc, MaxPdfShape * shape, BBString * text, wxPdfShapedTextMode mode) {
	doc->ShapedText(shape->Shape(), wxStringFromBBString(text), mode);
}

int bmx_wxpdfdocument_setlink(wxPdfDocument * doc, int link, double y, int page) {
	return static_cast<int>(doc->SetLink(link, y, page));
}

double bmx_wxpdfdocument_getpageheight(wxPdfDocument * doc) {
	return doc->GetPageHeight();
}

double bmx_wxpdfdocument_getpagewidth(wxPdfDocument * doc) {
	return doc->GetPageWidth();
}

double bmx_wxpdfdocument_getrightmargin(wxPdfDocument * doc) {
	return doc->GetRightMargin();
}

double bmx_wxpdfdocument_getscalefactor(wxPdfDocument * doc) {
	return doc->GetScaleFactor();
}

int bmx_wxpdfdocument_getsourceinfo(wxPdfDocument * doc, MaxPdfInfo * info) {
	return static_cast<int>(doc->GetSourceInfo(info->Info()));
}

int bmx_wxpdfdocument_coonspatchgradient(wxPdfDocument * doc, MaxPdfCoonsPatchMesh * mesh, double minCoord, double maxCoord) {
	return doc->CoonsPatchGradient(mesh->Mesh(), minCoord, maxCoord);
}

void bmx_wxpdfdocument_curveto(wxPdfDocument * doc, double x1, double y1, double x2, double y2, double x3, double y3) {
	doc->CurveTo(x1, y1, x2, y2, x3, y3);
}

int bmx_wxpdfdocument_endtemplate(wxPdfDocument * doc) {
	return doc->EndTemplate();
}

MaxPdfColour * bmx_wxpdfdocument_getdrawcolour(wxPdfDocument * doc) {
	return new MaxPdfColour(doc->GetDrawColour());
}


MaxPdfColour * bmx_wxpdfdocument_getfillcolour(wxPdfDocument * doc) {
	return new MaxPdfColour(doc->GetFillColour());
}

MaxPdfFontDescription * bmx_wxpdfdocument_getfontdescription(wxPdfDocument * doc) {
	return new MaxPdfFontDescription(doc->GetFontDescription());
}

MaxPdfLineStyle *  bmx_wxpdfdocument_getlinestyle(wxPdfDocument * doc) {
	return new MaxPdfLineStyle(doc->GetLineStyle());
}

void bmx_wxpdfdocument_gettemplatebbox(wxPdfDocument * doc, int templateId, double * x, double * y, double * width, double * height) {
	doc->GetTemplateBBox(templateId, *x, *y, *width, *height);
}

void bmx_wxpdfdocument_gettemplatessize(wxPdfDocument * doc, int templateId, double * width, double * height) {
	doc->GetTemplateSize(templateId, *width, *height);
}

MaxPdfColour * bmx_wxpdfdocument_gettextcolour(wxPdfDocument * doc) {
	return new MaxPdfColour(doc->GetTextColour());
}

int bmx_wxpdfdocument_imageimage(wxPdfDocument * doc, BBString * name, MaxImage * image, double x, double y, double w, double h, MaxPdfLink * link, int maskImage) {
	if (link) {
		return static_cast<int>(doc->Image(wxStringFromBBString(name), image->Image(), x, y, w, h, link->Link(), maskImage));
	} else {
		return static_cast<int>(doc->Image(wxStringFromBBString(name), image->Image(), x, y, w, h, wxPdfLink(-1), maskImage));
	}
}

int bmx_wxpdfdocument_imagemaskimage(wxPdfDocument * doc, BBString * name, MaxImage * image) {
	return static_cast<int>(doc->ImageMask(wxStringFromBBString(name), image->Image()));
}

int bmx_wxpdfdocument_importpage(wxPdfDocument * doc, int page) {
	return doc->ImportPage(page);
}

int bmx_wxpdfdocument_isinfooter(wxPdfDocument * doc) {
	return static_cast<int>(doc->IsInFooter());
}

void bmx_wxpdfdocument_line(wxPdfDocument * doc, double x1, double y1, double x2, double y2) {
	doc->Line(x1, y1, x2, y2);
}

int bmx_wxpdfdocument_lineargradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, wxPdfLinearGradientType gradientType) {
	return doc->LinearGradient(col1->Colour(), col2->Colour(), gradientType);
}

int bmx_wxpdfdocument_linecount(wxPdfDocument * doc, double w, BBString * txt) {
	return doc->LineCount(w, wxStringFromBBString(txt));
}

void bmx_wxpdfdocument_lineto(wxPdfDocument * doc, double x, double y) {
	doc->LineTo(x, y);
}

void bmx_wxpdfdocument_link(wxPdfDocument * doc, double x, double y, double w, double h, MaxPdfLink * link) {
	doc->Link(x, y, w, h, link->Link());
}

void bmx_wxpdfdocument_marker(wxPdfDocument * doc, double x, double y, wxPdfMarker markerType, double size) {
	doc->Marker(x, y, markerType, size);
}

void bmx_wxpdfdocument_midaxialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double x2, double y2, double midpoint, double intexp) {
	doc->MidAxialGradient(col1->Colour(), col2->Colour(), x1, y1, x2, y2, midpoint, intexp);
}

void bmx_wxpdfdocument_mirrorh(wxPdfDocument * doc, double x) {
	doc->MirrorH(x);
}

void bmx_wxpdfdocument_mirrorv(wxPdfDocument * doc, double y) {
	doc->MirrorV(y);
}

void bmx_wxpdfdocument_moveto(wxPdfDocument * doc, double x, double y) {
	doc->MoveTo(x, y);
}

void bmx_wxpdfdocument_polygon(wxPdfDocument * doc, BBArray * x, BBArray * y, int style) {
	doc->Polygon(bbDoubleArrayTowxPdfArrayDouble(x), bbDoubleArrayTowxPdfArrayDouble(y), style);
}

void bmx_wxpdfdocument_pushbutton(wxPdfDocument * doc, BBString * name, double width, double height, BBString * caption, BBString * action) {
	doc->PushButton(wxStringFromBBString(name), width, height, wxStringFromBBString(caption), wxStringFromBBString(action));
}

void bmx_wxpdfdocument_pushbuttonxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBString * caption, BBString * action) {
	doc->PushButton(wxStringFromBBString(name), x, y, width, height, wxStringFromBBString(caption), wxStringFromBBString(action));
}

int bmx_wxpdfdocument_radialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double r1, double x2, double y2, double r2, double intexp) {
	return doc->RadialGradient(col1->Colour(), col2->Colour(), x1, y1, r1, x2, y2, r2, intexp);
}

void bmx_wxpdfdocument_radiobutton(wxPdfDocument * doc, BBString * group, BBString * name, double width) {
	doc->RadioButton(wxStringFromBBString(group), wxStringFromBBString(name), width);
}

void bmx_wxpdfdocument_radiobuttonxy(wxPdfDocument * doc, BBString * group, BBString * name, double x, double y, double width) {
	doc->RadioButton(wxStringFromBBString(group), wxStringFromBBString(name), x, y, width);
}

void bmx_wxpdfdocument_settextcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour) {
	doc->SetTextColour(pdfColour->Colour());
}

void bmx_wxpdfdocument_settextcolourrgb(wxPdfDocument * doc, int red, int green, int blue) {
	doc->SetTextColour(static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wxpdfdocument_settextcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black) {
	doc->SetTextColour(cyan, magenta, yellow, black);
}

void bmx_wxpdfdocument_settextcolourname(wxPdfDocument * doc, BBString * name, double tint) {
	doc->SetTextColour(wxStringFromBBString(name), tint);
}

void bmx_wxpdfdocument_setdrawcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour) {
	doc->SetDrawColour(pdfColour->Colour());
}

void bmx_wxpdfdocument_setdrawcolourrgb(wxPdfDocument * doc, int red, int green, int blue) {
	doc->SetDrawColour(static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wxpdfdocument_setdrawcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black) {
	doc->SetDrawColour(cyan, magenta, yellow, black);
}

void bmx_wxpdfdocument_setdrawcolourname(wxPdfDocument * doc, BBString * name, double tint) {
	doc->SetDrawColour(wxStringFromBBString(name), tint);
}

void bmx_wxpdfdocument_setfillcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour) {
	doc->SetFillColour(pdfColour->Colour());
}

void bmx_wxpdfdocument_setfillcolourrgb(wxPdfDocument * doc, int red, int green, int blue) {
	doc->SetFillColour(static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wxpdfdocument_setfillcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black) {
	doc->SetFillColour(cyan, magenta, yellow, black);
}

void bmx_wxpdfdocument_setfillcolourname(wxPdfDocument * doc, BBString * name, double tint) {
	doc->SetFillColour(wxStringFromBBString(name), tint);
}

void bmx_wxpdfdocument_rotate(wxPdfDocument * doc, double angle, double x, double y) {
	doc->Rotate(angle, x, y);
}

void bmx_wxpdfdocument_rotatedtext(wxPdfDocument * doc, double x, double y, BBString * txt, double angle) {
	doc->RotatedText(x, y, wxStringFromBBString(txt), angle);
}

void bmx_wxpdfdocument_roundedrect(wxPdfDocument * doc, double x, double y, double w, double h, double r, int roundCorner, int style) {
	doc->RoundedRect(x, y, w, h, r, roundCorner, style);
}

int bmx_wxpdfdocument_scale(wxPdfDocument * doc, double sx, double sy, double x, double y) {
	return static_cast<int>(doc->Scale(sx, sy, x, y));
}

int bmx_wxpdfdocument_scalex(wxPdfDocument * doc, double sx, double x, double y) {
	return static_cast<int>(doc->ScaleX(sx, x, y));
}

int bmx_wxpdfdocument_scaley(wxPdfDocument * doc, double sy, double x, double y) {
	return static_cast<int>(doc->ScaleY(sy, x, y));
}

int bmx_wxpdfdocument_scalexy(wxPdfDocument * doc, double s, double x, double y) {
	return static_cast<int>(doc->ScaleXY(s, x, y));
}

void bmx_wxpdfdocument_setdrawcolourgrayscale(wxPdfDocument * doc, int grayscale) {
	doc->SetDrawColour(static_cast<unsigned char>(grayscale));
}

void bmx_wxpdfdocument_setfillcolourgrayscale(wxPdfDocument * doc, int grayscale) {
	doc->SetFillColour(static_cast<unsigned char>(grayscale));
}

int bmx_wxpdfdocument_setsourcefile(wxPdfDocument * doc, BBString * filename, BBString * password) {
	return doc->SetSourceFile(wxStringFromBBString(filename), wxStringFromBBString(password));
}

void bmx_wxpdfdocument_setsubject(wxPdfDocument * doc, BBString * subject) {
	doc->SetSubject(wxStringFromBBString(subject));
}

void bmx_wxpdfdocument_settemplatebbox(wxPdfDocument * doc, int templateId, double x, double y, double width, double height) {
	doc->SetTemplateBBox(templateId, x, y, width, height);
}

void bmx_wxpdfdocument_setmargins(wxPdfDocument * doc, double marginLeft, double marginTop, double marginRight) {
	doc->SetMargins(marginLeft, marginTop, marginRight);
}

void bmx_wxpdfdocument_setprotection(wxPdfDocument * doc, int permissions, BBString * userPassword, BBString * ownerPassword, wxPdfEncryptionMethod encryptionMethod, int keyLength) {
	doc->SetProtection(permissions, wxStringFromBBString(userPassword), wxStringFromBBString(ownerPassword), encryptionMethod, keyLength);
}

void bmx_wxpdfdocument_setrightmargin(wxPdfDocument * doc, double margin) {
	doc->SetRightMargin(margin);
}

void bmx_wxpdfdocument_setfontsize(wxPdfDocument * doc, double size) {
	doc->SetFontSize(size);
}

void bmx_wxpdfdocument_setfontsubsetting(wxPdfDocument * doc, int fontSubsetting) {
	doc->SetFontSubsetting(static_cast<bool>(fontSubsetting));
}

void bmx_wxpdfdocument_setformborderstyle(wxPdfDocument * doc, wxPdfBorderStyle borderStyle, double borderWidth) {
	doc->SetFormBorderStyle(borderStyle, borderWidth);
}

void bmx_wxpdfdocument_setformcolours(wxPdfDocument * doc, MaxPdfColour * borderColour, MaxPdfColour * backgroundColour, MaxPdfColour * textColour) {
	doc->SetFormColours((borderColour)?borderColour->Colour():wxPdfColour(), (backgroundColour)?backgroundColour->Colour():wxPdfColour(250), (textColour)?textColour->Colour():wxPdfColour());
}

void bmx_wxpdfdocument_setfillgradient(wxPdfDocument * doc, double x, double y, double w, double h, int gradient) {
	doc->SetFillGradient(x, y, w, h, gradient);
}

void bmx_wxpdfdocument_setautopagebreak(wxPdfDocument * doc, int autoPageBreak, double margin) {
	doc->SetAutoPageBreak(static_cast<bool>(autoPageBreak), margin);
}

void bmx_wxpdfdocument_setcellmargin(wxPdfDocument * doc, double margin) {
	doc->SetCellMargin(margin);
}

void bmx_wxpdfdocument_setcompression(wxPdfDocument * doc, int compress) {
	doc->SetCompression(static_cast<bool>(compress));
}

void bmx_wxpdfdocument_setcreator(wxPdfDocument * doc, BBString * creator) {
	doc->SetCreator(wxStringFromBBString(creator));
}

void bmx_wxpdfdocument_setdisplaymode(wxPdfDocument * doc, wxPdfZoom zoom, wxPdfLayout layout, double zoomFactor) {
	doc->SetDisplayMode(zoom, layout, zoomFactor);
}

void bmx_wxpdfdocument_setalphastate(wxPdfDocument * doc, int state) {
	doc->SetAlphaState(state);
}

void bmx_wxpdfdocument_sector(wxPdfDocument * doc, double x0, double y0, double r, double astart, double afinish, int style, int clockwise, double origin) {
	doc->Sector(x0, y0, r, astart, afinish, style, static_cast<bool>(clockwise), origin);
}

void bmx_wxpdfdocument_regularpolygon(wxPdfDocument * doc, double x0, double y0, double r, int ns, double angle, int circle, int style, int circleStyle, MaxPdfLineStyle * circleLineStyle, MaxPdfColour * circleFillColour) {
	doc->RegularPolygon(x0, y0, r, ns, angle, static_cast<bool>(circle), style, circleStyle, (circleLineStyle)?circleLineStyle->Style():wxPdfLineStyle(), (circleFillColour)?circleFillColour->Colour():wxPdfColour());
}

void bmx_wxpdfdocument_rotatedimage(wxPdfDocument * doc, BBString * file, double x, double y, double w, double h, double angle, BBString * imgType, MaxPdfLink * link, int maskImage) {
	doc->RotatedImage(wxStringFromBBString(file), x, y, w, h, angle, wxStringFromBBString(imgType), (link)?link->Link():wxPdfLink(-1), maskImage);
}


// *********************************************

MaxPdfColour * bmx_wxpdfcolour_createforname(BBString * name) {
	wxPdfColour c(wxStringFromBBString(name));
	return new MaxPdfColour(c);
}

void bmx_wxpdfcolour_delete(MaxPdfColour * colour) {
	delete colour;
}

MaxPdfColour * bmx_wxpdfcolour_create(int r, int g, int b) {
	wxPdfColour c(static_cast<unsigned char>(r), static_cast<unsigned char>(g), static_cast<unsigned char>(b));
	return new MaxPdfColour(c);
}

MaxPdfColour * bmx_wxpdfcolour_creategrayscalecolour(int grayscale) {
	wxPdfColour c(static_cast<unsigned char>(grayscale));
	return new MaxPdfColour(c);
}

MaxPdfColour * bmx_wxpdfcolour_createfromcolour(MaxColour * colour) {
	wxPdfColour c(colour->Colour());
	return new MaxPdfColour(c);
}

MaxPdfColour * bmx_wxpdfcolour_createcmykcolour(double cyan, double magenta, double yellow, double black) {
	wxPdfColour c(cyan, magenta, yellow, black);
	return new MaxPdfColour(c);
}

wxPdfColourType bmx_wxpdfcolour_getcolourtype(MaxPdfColour * colour) {
	return colour->Colour().GetColourType();
}

// *********************************************

MaxPdfInfo * bmx_wxpdfinfo_create() {
	wxPdfInfo i;
	return new MaxPdfInfo(i);
}

BBString * bmx_wxpdfinfo_gettitle(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetTitle());
}

BBString * bmx_wxpdfinfo_getauthor(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetAuthor());
}

BBString * bmx_wxpdfinfo_getsubject(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetSubject());
}

BBString * bmx_wxpdfinfo_getkeywords(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetKeywords());
}

BBString * bmx_wxpdfinfo_getcreator(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetCreator());
}

BBString * bmx_wxpdfinfo_getproducer(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetProducer());
}

BBString * bmx_wxpdfinfo_getcreationdate(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetCreationDate());
}

BBString * bmx_wxpdfinfo_getmoddate(MaxPdfInfo * info) {
	return bbStringFromWxString(info->Info().GetModDate());
}

void bmx_wxpdfinfo_delete(MaxPdfInfo * info) {
	delete info;
}

// *********************************************

MaxPdfLink * bmx_wxpdflink_create(int linkRef) {
	wxPdfLink p(linkRef);
	return new MaxPdfLink(p);
}

MaxPdfLink * bmx_wxpdflink_createurl(BBString * linkURL) {
	wxPdfLink p(wxStringFromBBString(linkURL));
	return new MaxPdfLink(p);
}

void bmx_wxpdflink_delete(MaxPdfLink * link) {
	delete link;
}


// *********************************************

MaxPdfLineStyle * bmx_wxpdflinestyle_create(double width, wxPdfLineCap cap, wxPdfLineJoin join, BBArray * dash, double phase, MaxPdfColour * colour) {
	if (colour) {
		wxPdfLineStyle s(width, cap, join, bbDoubleArrayTowxPdfArrayDouble(dash), phase, colour->Colour());
		return new MaxPdfLineStyle(s);
	} else {
		wxPdfLineStyle s(width, cap, join, bbDoubleArrayTowxPdfArrayDouble(dash), phase);
		return new MaxPdfLineStyle(s);
	}	
}

void bmx_wxpdflinestyle_delete(MaxPdfLineStyle * style) {
	delete style;
}

// *********************************************

wxPdfBarCodeCreator * bmx_wxpdfbarcodecreator_create(wxPdfDocument * document) {
	return new wxPdfBarCodeCreator(*document);
}

void bmx_wxpdfbarcodecreator_free(wxPdfBarCodeCreator * creator) {
	delete creator;
}

int bmx_wxpdfbarcodecreator_ean13(wxPdfBarCodeCreator * creator, double x, double y, BBString * barcode, double w, double h) {
	return static_cast<int>(creator->EAN13(x, y, wxStringFromBBString(barcode), h, w));
}

int bmx_wxpdfbarcodecreator_upc_a(wxPdfBarCodeCreator * creator, double x, double y, BBString * barcode, double w, double h) {
	return static_cast<int>(creator->UPC_A(x, y, wxStringFromBBString(barcode), h, w));
}

int bmx_wxpdfbarcodecreator_code39(wxPdfBarCodeCreator * creator, double x, double y, BBString * code, int ext, int cks, double w, double h, int wide) {
	return static_cast<int>(creator->Code39(x, y, wxStringFromBBString(code), static_cast<bool>(ext), static_cast<bool>(cks), w, h, static_cast<bool>(wide)));
}

int bmx_wxpdfbarcodecreator_I25(wxPdfBarCodeCreator * creator, double x, double y, BBString * code, double basewidth, double height) {
	return static_cast<int>(creator->I25(x, y, wxStringFromBBString(code), basewidth, height));
}

int bmx_wxpdfbarcodecreator_postnet(wxPdfBarCodeCreator * creator, double x, double y, BBString * zipcode) {
	return static_cast<int>(creator->PostNet(x, y, wxStringFromBBString(zipcode)));
}

// *********************************************

MaxPdfShape * bmx_wxpdfshape_create() {
	wxPdfShape s;
	return new MaxPdfShape(s);
}

void bmx_wxpdfshape_moveto(MaxPdfShape * shape, double x, double y) {
	shape->Shape().MoveTo(x, y);
}

void bmx_wxpdfshape_lineto(MaxPdfShape * shape, double x, double y) {
	shape->Shape().LineTo(x, y);
}

void bmx_wxpdfshape_curveto(MaxPdfShape * shape, double x1, double y1, double x2, double y2, double x3, double y3) {
	shape->Shape().CurveTo(x1, y1, x2, y2, x3, y3);
}

void bmx_wxpdfshape_closepath(MaxPdfShape * shape) {
	shape->Shape().ClosePath();
}

int bmx_wxpdfshape_getsegmentcount(MaxPdfShape * shape) {
	return shape->Shape().GetSegmentCount();
}

void bmx_wxpdfshape_delete(MaxPdfShape * shape) {
	delete shape;
}

