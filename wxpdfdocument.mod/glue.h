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
#include "wx/pdfdoc.h"
#include "wx/pdfbarcode.h"
#include "wx/pdfshape.h"
#include "wx/pdfinfo.h"
#include "wx/pdfcoonspatchmesh.h"
#include "wx/pdffontdescription.h"
#include "../wximage.mod/glue.h"

class MaxPdfDocument;
class MaxPdfLink;
class MaxPdfLineStyle;
class MaxPdfColour;
class MaxPdfShape;
class MaxPdfCoonsPatchMesh;
class MaxPdfInfo;
class MaxPdfFontDescription;

extern "C" {

#include <blitz.h>

	void _wx_wxpdfdocument_wxPdfDocument__Header(BBObject * handle);
	void _wx_wxpdfdocument_wxPdfDocument__Footer(BBObject * handle);
	bool _wx_wxpdfdocument_wxPdfDocument__AcceptPageBreak(BBObject * handle);

	void bmx_wxpdfdocument_free(wxPdfDocument * doc);

	wxPdfDocument * bmx_wxpdfdocument_create(BBObject * handle, int orientation, BBString * unit, wxPaperSize format);
	void bmx_wxpdfdocument_addpage(wxPdfDocument * doc, int orientation);
	void bmx_wxpdfdocument_setfont(wxPdfDocument * doc, BBString * family, BBString * style, double size);
	void bmx_wxpdfdocument_cell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int ln, int align, int fill, MaxPdfLink * link);
	void bmx_wxpdfdocument_saveasfile(wxPdfDocument * doc, BBString * name);

	void bmx_wxpdfdocument_addspotcolour(wxPdfDocument * doc, BBString * name, double cyan, double magenta, double yellow, double black);
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
	void bmx_wxpdfdocument_setdrawcolour(wxPdfDocument * doc, MaxColour * colour);
	void bmx_wxpdfdocument_setfillcolour(wxPdfDocument * doc, MaxColour * colour);
	void bmx_wxpdfdocument_settextcolour(wxPdfDocument * doc, MaxColour * colour);
	double bmx_wxpdfdocument_getstringwidth(wxPdfDocument * doc, BBString * text);
	void bmx_wxpdfdocument_setlinewidth(wxPdfDocument * doc, double width);
	void bmx_wxpdfdocument_setauthor(wxPdfDocument * doc, BBString * author);
	void bmx_wxpdfdocument_settextcolourgrayscale(wxPdfDocument * doc, int grayscale);
	int bmx_wxpdfdocument_multicell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int align, int fill, int maxline);

	bool bmx_wxpdfdocument_acceptpagebreak(MaxPdfDocument * doc);

	bool bmx_wxpdfdocument_addfont(wxPdfDocument * doc, BBString * family, BBString * style, BBString * file);
	bool bmx_wxpdfdocument_addfontcjk(wxPdfDocument * doc, BBString * family);
	int bmx_wxpdfdocument_addlink(wxPdfDocument * doc);
	void bmx_wxpdfdocument_annotate(wxPdfDocument * doc, double x, double y, BBString * text);
	void bmx_wxpdfdocument_appendjavascript(wxPdfDocument * doc, BBString * javascript);
	int bmx_wxpdfdocument_axialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double x2, double y2, double intexp);
	int bmx_wxpdfdocument_begintemplate(wxPdfDocument * doc, double x, double y, double width, double height);
	void bmx_wxpdfdocument_bookmark(wxPdfDocument * doc, BBString * txt, int level, double y);
	void bmx_wxpdfdocument_setimagescale(wxPdfDocument * doc, double scale);
	void bmx_wxpdfdocument_setkeywords(wxPdfDocument * doc, BBString * keywords);
	void bmx_wxpdfdocument_setleftmargin(wxPdfDocument * doc, double margin);
	void bmx_wxpdfdocument_setlineheight(wxPdfDocument * doc, double height);
	void bmx_wxpdfdocument_setlinestyle(wxPdfDocument * doc, MaxPdfLineStyle * style);
	double bmx_wxpdfdocument_gettopmargin(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getx(wxPdfDocument * doc);
	double bmx_wxpdfdocument_gety(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getbreakmargin(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getcellmargin(wxPdfDocument * doc);
	BBString * bmx_wxpdfdocument_getfontfamily(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getfontsize(wxPdfDocument * doc);
	BBString * bmx_wxpdfdocument_getfontstyle(wxPdfDocument * doc);
	bool bmx_wxpdfdocument_getfontsubsetting(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getimagescale(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getleftmargin(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getlineheight(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getlinewidth(wxPdfDocument * doc);

	void bmx_wxpdfdocument_writexml(wxPdfDocument * doc, BBString * txt);

	void bmx_wxpdfdocument_translate(wxPdfDocument * doc, double tx, double ty);
	void bmx_wxpdfdocument_translatex(wxPdfDocument * doc, double tx);
	void bmx_wxpdfdocument_translatey(wxPdfDocument * doc, double ty);
	void bmx_wxpdfdocument_unsetclipping(wxPdfDocument * doc);
	void bmx_wxpdfdocument_usetemplate(wxPdfDocument * doc, int templateId, double x, double y, double width, double height);
	void bmx_wxpdfdocument_write(wxPdfDocument * doc, double h, BBString * txt, MaxPdfLink * link);
	void bmx_wxpdfdocument_writecell(wxPdfDocument * doc, double h, BBString * txt, int border, int fill, MaxPdfLink * link);
	void bmx_wxpdfdocument_textfield(wxPdfDocument * doc, BBString * name, double width, double height, BBString * value, bool multiline);
	void bmx_wxpdfdocument_textfieldxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBString * value, bool multiline);
	void bmx_wxpdfdocument_stoptransform(wxPdfDocument * doc);
	void bmx_wxpdfdocument_text(wxPdfDocument * doc, double x, double y, BBString * txt);
	int bmx_wxpdfdocument_textbox(wxPdfDocument * doc, double w, double h, BBString * txt, int halign, int valign, int border, int fill);
	void bmx_wxpdfdocument_checkbox(wxPdfDocument * doc, BBString * name, double width, bool checked);
	void bmx_wxpdfdocument_checkboxxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, bool checked);
	void bmx_wxpdfdocument_combobox(wxPdfDocument * doc, BBString * name, double width, double height, BBArray * values);
	void bmx_wxpdfdocument_comboboxxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBArray * values);
	void bmx_wxpdfdocument_clippedcell(wxPdfDocument * doc, double w, double h, BBString * txt, int border, int ln, int align, int fill, MaxPdfLink * link);
	void bmx_wxpdfdocument_clippingellipse(wxPdfDocument * doc, double x, double y, double rx, double ry, bool outline);
	void bmx_wxpdfdocument_clippingpath(wxPdfDocument * doc);
	void bmx_wxpdfdocument_clippingpathshape(wxPdfDocument * doc, MaxPdfShape * shape, int style);
	void bmx_wxpdfdocument_clippingpolygon(wxPdfDocument * doc, BBArray * x, BBArray * y, bool outline);
	void bmx_wxpdfdocument_clippingrect(wxPdfDocument * doc, double x, double y, double w, double h, bool outline);
	void bmx_wxpdfdocument_clippingtext(wxPdfDocument * doc, double x, double y, BBString * txt, bool outline);
	void bmx_wxpdfdocument_closepath(wxPdfDocument * doc, int style);

	int bmx_wxpdfdocument_setalpha(wxPdfDocument * doc, double lineAlpha, double fillAlpha, wxPdfBlendMode blendMode);
	void bmx_wxpdfdocument_rect(wxPdfDocument * doc, double x, double y, double w, double h, int style);
	int bmx_wxpdfdocument_imagemask(wxPdfDocument * doc, BBString * file, BBString * mimeType);
	void bmx_wxpdfdocument_starttransform(wxPdfDocument * doc);

	void bmx_wxpdfdocument_settopmargin(wxPdfDocument * doc, double margin);
	void bmx_wxpdfdocument_setviewerpreferences(wxPdfDocument * doc, int preferences);
	void bmx_wxpdfdocument_setxy(wxPdfDocument * doc, double x, double y);
	bool bmx_wxpdfdocument_skew(wxPdfDocument * doc, double xAngle, double yAngle, double x, double y);
	bool bmx_wxpdfdocument_skewx(wxPdfDocument * doc, double xAngle, double x, double y);
	bool bmx_wxpdfdocument_skewy(wxPdfDocument * doc, double yAngle, double x, double y);
	void bmx_wxpdfdocument_starpolygon(wxPdfDocument * doc, double x0, double y0, double r,
			int nv, int nr, double angle, bool circle, int style, int circleStyle, MaxPdfLineStyle * circleLineStype, MaxPdfColour * circleFillColour);
	void bmx_wxpdfdocument_shape(wxPdfDocument * doc, MaxPdfShape * shape, int style);
	void bmx_wxpdfdocument_shapedtext(wxPdfDocument * doc, MaxPdfShape * shape, BBString * text, wxPdfShapedTextMode mode);
	bool bmx_wxpdfdocument_setlink(wxPdfDocument * doc, int link, double y, int page);
	double bmx_wxpdfdocument_getpageheight(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getpagewidth(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getrightmargin(wxPdfDocument * doc);
	double bmx_wxpdfdocument_getscalefactor(wxPdfDocument * doc);
	bool bmx_wxpdfdocument_getsourceinfo(wxPdfDocument * doc, MaxPdfInfo * info);
	int bmx_wxpdfdocument_coonspatchgradient(wxPdfDocument * doc, MaxPdfCoonsPatchMesh * mesh, double minCoord, double maxCoord);
	void bmx_wxpdfdocument_curveto(wxPdfDocument * doc, double x1, double y1, double x2, double y2, double x3, double y3);
	int bmx_wxpdfdocument_endtemplate(wxPdfDocument * doc);

	MaxPdfColour * bmx_wxpdfdocument_getdrawcolour(wxPdfDocument * doc);
	MaxPdfColour * bmx_wxpdfdocument_getfillcolour(wxPdfDocument * doc);
	MaxPdfFontDescription * bmx_wxpdfdocument_getfontdescription(wxPdfDocument * doc);
	MaxPdfLineStyle *  bmx_wxpdfdocument_getlinestyle(wxPdfDocument * doc);
	void bmx_wxpdfdocument_gettemplatebbox(wxPdfDocument * doc, int templateId, double * x, double * y, double * width, double * height);
	void bmx_wxpdfdocument_gettemplatessize(wxPdfDocument * doc, int templateId, double * width, double * height);
	MaxPdfColour * bmx_wxpdfdocument_gettextcolour(wxPdfDocument * doc);
	bool bmx_wxpdfdocument_imageimage(wxPdfDocument * doc, BBString * name, MaxImage * image, double x, double y, double w, double h, MaxPdfLink * link, int maskImage);
	bool bmx_wxpdfdocument_imagemaskimage(wxPdfDocument * doc, BBString * name, MaxImage * image);
	int bmx_wxpdfdocument_importpage(wxPdfDocument * doc, int page);
	bool bmx_wxpdfdocument_isinfooter(wxPdfDocument * doc);
	void bmx_wxpdfdocument_line(wxPdfDocument * doc, double x1, double y1, double x2, double y2);
	int bmx_wxpdfdocument_lineargradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, wxPdfLinearGradientType gradientType);
	int bmx_wxpdfdocument_linecount(wxPdfDocument * doc, double w, BBString * txt);
	void bmx_wxpdfdocument_lineto(wxPdfDocument * doc, double x, double y);
	void bmx_wxpdfdocument_link(wxPdfDocument * doc, double x, double y, double w, double h, MaxPdfLink * link);
	void bmx_wxpdfdocument_marker(wxPdfDocument * doc, double x, double y, wxPdfMarker markerType, double size);
	void bmx_wxpdfdocument_midaxialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double x2, double y2, double midpoint, double intexp);
	void bmx_wxpdfdocument_mirrorh(wxPdfDocument * doc, double x);
	void bmx_wxpdfdocument_mirrorv(wxPdfDocument * doc, double y);
	void bmx_wxpdfdocument_moveto(wxPdfDocument * doc, double x, double y);
	void bmx_wxpdfdocument_polygon(wxPdfDocument * doc, BBArray * x, BBArray * y, int style);
	void bmx_wxpdfdocument_pushbutton(wxPdfDocument * doc, BBString * name, double width, double height, BBString * caption, BBString * action);
	void bmx_wxpdfdocument_pushbuttonxy(wxPdfDocument * doc, BBString * name, double x, double y, double width, double height, BBString * caption, BBString * action);
	int bmx_wxpdfdocument_radialgradient(wxPdfDocument * doc, MaxPdfColour * col1, MaxPdfColour * col2, double x1, double y1, double r1, double x2, double y2, double r2, double intexp);
	void bmx_wxpdfdocument_radiobutton(wxPdfDocument * doc, BBString * group, BBString * name, double width);
	void bmx_wxpdfdocument_radiobuttonxy(wxPdfDocument * doc, BBString * group, BBString * name, double x, double y, double width);
	void bmx_wxpdfdocument_settextcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour);
	void bmx_wxpdfdocument_settextcolourrgb(wxPdfDocument * doc, int red, int green, int blue);
	void bmx_wxpdfdocument_settextcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black);
	void bmx_wxpdfdocument_settextcolourname(wxPdfDocument * doc, BBString * name, double tint);
	void bmx_wxpdfdocument_setdrawcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour);
	void bmx_wxpdfdocument_setdrawcolourrgb(wxPdfDocument * doc, int red, int green, int blue);
	void bmx_wxpdfdocument_setdrawcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black);
	void bmx_wxpdfdocument_setdrawcolourname(wxPdfDocument * doc, BBString * name, double tint);
	void bmx_wxpdfdocument_setfillcolourpdf(wxPdfDocument * doc, MaxPdfColour * pdfColour);
	void bmx_wxpdfdocument_setfillcolourrgb(wxPdfDocument * doc, int red, int green, int blue);
	void bmx_wxpdfdocument_setfillcolourcmyk(wxPdfDocument * doc, double cyan, double magenta, double yellow, double black);
	void bmx_wxpdfdocument_setfillcolourname(wxPdfDocument * doc, BBString * name, double tint);

	void bmx_wxpdfdocument_rotate(wxPdfDocument * doc, double angle, double x, double y);
	void bmx_wxpdfdocument_rotatedtext(wxPdfDocument * doc, double x, double y, BBString * txt, double angle);
	void bmx_wxpdfdocument_roundedrect(wxPdfDocument * doc, double x, double y, double w, double h, double r, int roundCorner, int style);
	bool bmx_wxpdfdocument_scale(wxPdfDocument * doc, double sx, double sy, double x, double y);
	bool bmx_wxpdfdocument_scalex(wxPdfDocument * doc, double sx, double x, double y);
	bool bmx_wxpdfdocument_scaley(wxPdfDocument * doc, double sy, double x, double y);
	bool bmx_wxpdfdocument_scalexy(wxPdfDocument * doc, double s, double x, double y);
	void bmx_wxpdfdocument_setdrawcolourgrayscale(wxPdfDocument * doc, int grayscale);
	void bmx_wxpdfdocument_setfillcolourgrayscale(wxPdfDocument * doc, int grayscale);
	int bmx_wxpdfdocument_setsourcefile(wxPdfDocument * doc, BBString * filename, BBString * password);

	void bmx_wxpdfdocument_setsubject(wxPdfDocument * doc, BBString * subject);
	void bmx_wxpdfdocument_settemplatebbox(wxPdfDocument * doc, int templateId, double x, double y, double width, double height);
	void bmx_wxpdfdocument_setmargins(wxPdfDocument * doc, double marginLeft, double marginTop, double marginRight);
	void bmx_wxpdfdocument_setprotection(wxPdfDocument * doc, int permissions, BBString * userPassword, BBString * ownerPassword, wxPdfEncryptionMethod encryptionMethod, int keyLength);
	void bmx_wxpdfdocument_setrightmargin(wxPdfDocument * doc, double margin);
	void bmx_wxpdfdocument_setfontsize(wxPdfDocument * doc, double size);
	void bmx_wxpdfdocument_setfontsubsetting(wxPdfDocument * doc, bool fontSubsetting);
	void bmx_wxpdfdocument_setformborderstyle(wxPdfDocument * doc, wxPdfBorderStyle borderStyle, double borderWidth);
	void bmx_wxpdfdocument_setformcolours(wxPdfDocument * doc, MaxPdfColour * borderColour, MaxPdfColour * backgroundColour, MaxPdfColour * textColour);
	void bmx_wxpdfdocument_setfillgradient(wxPdfDocument * doc, double x, double y, double w, double h, int gradient);
	void bmx_wxpdfdocument_setautopagebreak(wxPdfDocument * doc, bool autoPageBreak, double margin);
	void bmx_wxpdfdocument_setcellmargin(wxPdfDocument * doc, double margin);
	void bmx_wxpdfdocument_setcompression(wxPdfDocument * doc, bool compress);
	void bmx_wxpdfdocument_setcreator(wxPdfDocument * doc, BBString * creator);
	void bmx_wxpdfdocument_setdisplaymode(wxPdfDocument * doc, wxPdfZoom zoom, wxPdfLayout layout, double zoomFactor);
	void bmx_wxpdfdocument_setalphastate(wxPdfDocument * doc, int state);
	void bmx_wxpdfdocument_sector(wxPdfDocument * doc, double x0, double y0, double r, double astart, double afinish, int style, bool clockwise, double origin);
	void bmx_wxpdfdocument_regularpolygon(wxPdfDocument * doc, double x0, double y0, double r, int ns, double angle, bool circle, int style, int circleStyle, MaxPdfLineStyle * circleLineStyle, MaxPdfColour * circleFillColour);
	void bmx_wxpdfdocument_rotatedimage(wxPdfDocument * doc, BBString * file, double x, double y, double w, double h, double angle, BBString * imgType, MaxPdfLink * link, int maskImage);


	MaxPdfColour * bmx_wxpdfcolour_createforname(BBString * name);
	void bmx_wxpdfcolour_delete(MaxPdfColour * colour);
	MaxPdfColour * bmx_wxpdfcolour_create(int r, int g, int b);
	MaxPdfColour * bmx_wxpdfcolour_creategrayscalecolour(int grayscale);
	MaxPdfColour * bmx_wxpdfcolour_createfromcolour(MaxColour * colour);
	MaxPdfColour * bmx_wxpdfcolour_createcmykcolour(double cyan, double magenta, double yellow, double black);
	wxPdfColourType bmx_wxpdfcolour_getcolourtype(MaxPdfColour * colour);

	MaxPdfInfo * bmx_wxpdfinfo_create();
	BBString * bmx_wxpdfinfo_gettitle(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getauthor(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getsubject(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getkeywords(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getcreator(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getproducer(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getcreationdate(MaxPdfInfo * info);
	BBString * bmx_wxpdfinfo_getmoddate(MaxPdfInfo * info);
	void bmx_wxpdfinfo_delete(MaxPdfInfo * info);

	MaxPdfLink * bmx_wxpdflink_create(int linkRef);
	MaxPdfLink * bmx_wxpdflink_createurl(BBString * linkURL);
	void bmx_wxpdflink_delete(MaxPdfLink * link);

	MaxPdfLineStyle * bmx_wxpdflinestyle_create(double width, wxPdfLineCap cap, wxPdfLineJoin join, BBArray  * dash, double phase, MaxPdfColour * colour);
	void bmx_wxpdflinestyle_delete(MaxPdfLineStyle * style);


	wxPdfBarCodeCreator * bmx_wxpdfbarcodecreator_create(wxPdfDocument * document);
	void bmx_wxpdfbarcodecreator_free(wxPdfBarCodeCreator * creator);
	bool bmx_wxpdfbarcodecreator_ean13(wxPdfBarCodeCreator * creator, double x, double y, BBString * barcode, double w, double h);
	bool bmx_wxpdfbarcodecreator_upc_a(wxPdfBarCodeCreator * creator, double x, double y, BBString * barcode, double w, double h);
	bool bmx_wxpdfbarcodecreator_code39(wxPdfBarCodeCreator * creator, double x, double y, BBString * code, bool ext, bool cks, double w, double h, bool wide);
	bool bmx_wxpdfbarcodecreator_I25(wxPdfBarCodeCreator * creator, double x, double y, BBString * code, double basewidth, double height);
	bool bmx_wxpdfbarcodecreator_postnet(wxPdfBarCodeCreator * creator, double x, double y, BBString * zipcode);
	
	MaxPdfShape * bmx_wxpdfshape_create();
	void bmx_wxpdfshape_moveto(MaxPdfShape * shape, double x, double y);
	void bmx_wxpdfshape_lineto(MaxPdfShape * shape, double x, double y);
	void bmx_wxpdfshape_curveto(MaxPdfShape * shape, double x1, double y1, double x2, double y2, double x3, double y3);
	void bmx_wxpdfshape_closepath(MaxPdfShape * shape);
	int bmx_wxpdfshape_getsegmentcount(MaxPdfShape * shape);
	void bmx_wxpdfshape_delete(MaxPdfShape * shape);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPdfDocument : public wxPdfDocument
{
public:
	MaxPdfDocument(BBObject * handle, int orientation, const wxString& unit, wxPaperSize format);
	~MaxPdfDocument();

	void Header();
	void Footer();
	bool AcceptPageBreak();
	bool AcceptPageBreak_default();
	
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

class MaxPdfColour
{
public:
	MaxPdfColour(const wxPdfColour & c);
	wxPdfColour & Colour();

private:
	wxPdfColour colour;

};

class MaxPdfLineStyle
{
public:
	MaxPdfLineStyle(const wxPdfLineStyle & s);
	wxPdfLineStyle & Style();

private:
	wxPdfLineStyle style;

};

class MaxPdfShape
{
public:
	MaxPdfShape(const wxPdfShape & s);
	wxPdfShape & Shape();

private:
	wxPdfShape shape;

};

class MaxPdfInfo
{
public:
	MaxPdfInfo(const wxPdfInfo & i);
	wxPdfInfo & Info();

private:
	wxPdfInfo info;

};

class MaxPdfCoonsPatchMesh
{
public:
	MaxPdfCoonsPatchMesh(const wxPdfCoonsPatchMesh & m);
	wxPdfCoonsPatchMesh & Mesh();

private:
	wxPdfCoonsPatchMesh mesh;

};

class MaxPdfFontDescription
{
public:
	MaxPdfFontDescription(const wxPdfFontDescription & d);
	wxPdfFontDescription & Desc();

private:
	wxPdfFontDescription desc;

};



