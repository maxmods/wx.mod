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
#include "wx/pdfdoc.h"

class MaxPdfDocument;
class MaxPdfLink;

extern "C" {

#include <blitz.h>

	void _wx_wxpdfdocument_wxPdfDocument__Header(BBObject * handle);
	void _wx_wxpdfdocument_wxPdfDocument__Footer(BBObject * handle);

	void bmx_wxpdfdocument_free(wxPdfDocument * doc);

	wxPdfDocument * bmx_wxpdfdocument_create(BBObject * handle, int orientation, BBString * unit, wxPaperSize format);
	void bmx_wxpdfdocument_addpage(wxPdfDocument * doc, int orientation);
	void bmx_wxpdfdocument_setfont(wxPdfDocument * doc, BBString * family, BBString * style, double size);
	void bmx_wxpdfdocument_cell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int ln, int align, int fill, MaxPdfLink * link);
	void bmx_wxpdfdocument_saveasfile(wxPdfDocument * doc, BBString * name);

	void bmx_wxpdfdocument_addspotcolor(wxPdfDocument * doc, BBString * name, double cyan, double magenta, double yellow, double black);
	void bmx_wxpdfdocument_aliasnbpages(wxPdfDocument * doc, BBString * _alias);
	void bmx_wxpdfdocument_arrow(wxPdfDocument * doc, double x1, double y1, double x2, double y2, double lineWidth, double height, double width);
	void bmx_wxpdfdocument_circle(wxPdfDocument * doc, double x0, double y0, double r, double astart, double afinish, int style, int nSeg);
	void bmx_wxpdfdocument_curve(wxPdfDocument * doc, double x0, double y0, double x1, double y1, double x2, double y2, double x3, double y3, int style);
	void bmx_wxpdfdocument_ellipse(wxPdfDocument * doc, double x0, double y0, double rx, double ry, double angle, double astart, double afinish, int style, int nSeg);
	bool bmx_wxpdfdocument_image(wxPdfDocument * doc, BBString * file, double x, double y, double w, double h, BBString * mimeType, MaxPdfLink * link, int maskImage);
	void bmx_wxpdfdocument_ln(wxPdfDocument * doc, double h);
	void bmx_wxpdfdocument_sety(wxPdfDocument * doc, double y);
	int bmx_wxpdfdocument_pageno(wxPdfDocument * doc);

	void bmx_wxpdfdocument_setx(wxPdfDocument * doc, double x);
	void bmx_wxpdfdocument_settitle(wxPdfDocument * doc, BBString * title);
	void bmx_wxpdfdocument_setdrawcolor(wxPdfDocument * doc, MaxColour * colour);
	void bmx_wxpdfdocument_setfillcolor(wxPdfDocument * doc, MaxColour * colour);
	void bmx_wxpdfdocument_settextcolor(wxPdfDocument * doc, MaxColour * colour);
	double bmx_wxpdfdocument_getstringwidth(wxPdfDocument * doc, BBString * text);
	void bmx_wxpdfdocument_setlinewidth(wxPdfDocument * doc, double width);
	void bmx_wxpdfdocument_setauthor(wxPdfDocument * doc, BBString * author);
	void bmx_wxpdfdocument_settextcolorgrayscale(wxPdfDocument * doc, int grayscale);
	int bmx_wxpdfdocument_multicell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int align, int fill, int maxline);


}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPdfDocument : public wxPdfDocument
{
public:
	MaxPdfDocument(BBObject * handle, int orientation, const wxString& unit, wxPaperSize format);
	~MaxPdfDocument();

	void Header();
	void Footer();
	
private:
	BBObject * maxHandle;
	
};

class MaxPdfLink
{
public:
	MaxPdfLink(const wxPdfLink & l);
	wxPdfLink & Link();

private:
	wxPdfLink pdfLink;

};

