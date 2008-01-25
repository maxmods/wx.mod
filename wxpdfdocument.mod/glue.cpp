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

MaxPdfLink::MaxPdfLink(const wxPdfLink & l)
	: pdfLink(l)
{
}

wxPdfLink & MaxPdfLink::Link() {
	return pdfLink;
}


// *********************************************

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

void bmx_wxpdfdocument_addspotcolor(wxPdfDocument * doc, BBString * name, double cyan, double magenta, double yellow, double black) {
	doc->AddSpotColor(wxStringFromBBString(name), cyan, magenta, yellow, black);
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

bool bmx_wxpdfdocument_image(wxPdfDocument * doc, BBString * file, double x, double y, double w, double h, BBString * mimeType, MaxPdfLink * link, int maskImage) {
	if (link) {
		return doc->Image(wxStringFromBBString(file), x, y, w, h, wxStringFromBBString(mimeType), link->Link(), maskImage);
	} else {
		return doc->Image(wxStringFromBBString(file), x, y, w, h, wxStringFromBBString(mimeType), wxPdfLink(-1), maskImage);
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

void bmx_wxpdfdocument_setdrawcolor(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetDrawColor(colour->Colour());
}

void bmx_wxpdfdocument_setfillcolor(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetFillColor(colour->Colour());
}

void bmx_wxpdfdocument_settextcolor(wxPdfDocument * doc, MaxColour * colour) {
	doc->SetTextColor(colour->Colour());
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

void bmx_wxpdfdocument_settextcolorgrayscale(wxPdfDocument * doc, int grayscale) {
	doc->SetTextColor(static_cast<unsigned char>(grayscale));
}

int bmx_wxpdfdocument_multicell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int align, int fill, int maxline) {
	return doc->MultiCell(w, h, wxStringFromBBString(txt), border, align, fill, maxline);
}



