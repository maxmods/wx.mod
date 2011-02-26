/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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
#include "wx/print.h"
#include "../wxprintdata.mod/glue.h"

class MaxPrintPreview;

extern "C" {

#include <blitz.h>

	bool _wx_wxprintpreview_wxPrintPreview__PaintPage(BBObject * maxHandle, wxPreviewCanvas * canvas, MaxDC * dc);

	wxPrintPreview * bmx_wxprintpreview_create(BBObject * handle, wxPrintout * printout, wxPrintout * printoutForPrinting, MaxPrintData * data);
	void bmx_wxprintpreview_free(wxPrintPreview * preview);
	wxPreviewCanvas * bmx_wxprintpreview_getcanvas(wxPrintPreview * preview);
	int bmx_wxprintpreview_getcurrentpage(wxPrintPreview * preview);
	wxFrame * bmx_wxprintpreview_getframe(wxPrintPreview * preview);
	int bmx_wxprintpreview_getmaxpage(wxPrintPreview * preview);
	int bmx_wxprintpreview_getminpage(wxPrintPreview * preview);
	wxPrintout * bmx_wxprintpreview_getprintout(wxPrintPreview * preview);
	wxPrintout * bmx_wxprintpreview_getprintoutforprinting(wxPrintPreview * preview);
	bool bmx_wxprintpreview_isok(wxPrintPreview * preview);
	bool bmx_wxprintpreview_paintpage(wxPrintPreview * preview, wxPreviewCanvas * canvas, MaxDC * dc);
	bool bmx_wxprintpreview_paintpage_default(MaxPrintPreview * preview, wxPreviewCanvas * canvas, MaxDC * dc);
	bool bmx_wxprintpreview_print(wxPrintPreview * preview, bool prompt);
	void bmx_wxprintpreview_setCanvas(wxPrintPreview * preview, wxPreviewCanvas * canvas);
	void bmx_wxprintpreview_setcurrentpage(wxPrintPreview * preview, int pageNum);
	void bmx_wxprintpreview_setframe(wxPrintPreview * preview, wxFrame * frame);
	void bmx_wxprintpreview_setprintout(wxPrintPreview * preview, wxPrintout * printout);
	void bmx_wxprintpreview_setzoom(wxPrintPreview * preview, int percent);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPrintPreview : public wxPrintPreview
{
public:
	MaxPrintPreview(BBObject * handle, wxPrintout* printout, wxPrintout* printoutForPrinting, wxPrintData* data);
	~MaxPrintPreview();

	bool PaintPage(wxPreviewCanvas *canvas, wxDC & dc);
	bool PaintPage_default(wxPreviewCanvas *canvas, MaxDC * dc);

private:
	BBObject * maxHandle;
};

