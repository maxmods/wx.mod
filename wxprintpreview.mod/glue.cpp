/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxPrintPreview::MaxPrintPreview(BBObject * handle, wxPrintout* printout, wxPrintout* printoutForPrinting, wxPrintData* data)
	: maxHandle(handle), wxPrintPreview(printout, printoutForPrinting, data)
{
	wxbind(this, handle);
}

MaxPrintPreview::~MaxPrintPreview() {
	wxunbind(this);	
}

bool MaxPrintPreview::PaintPage(wxPreviewCanvas *canvas, wxDC & dc) {
	_wx_wxprintpreview_wxPrintPreview__PaintPage(maxHandle, canvas, new MaxDC(dc));
}

bool MaxPrintPreview::PaintPage_default(wxPreviewCanvas *canvas, MaxDC * dc) {
	wxPrintPreview::PaintPage(canvas, *dc->GetDC());
}

// *********************************************

wxPrintPreview * bmx_wxprintpreview_create(BBObject * handle, wxPrintout * printout, wxPrintout * printoutForPrinting, MaxPrintData * data) {
	if (data) {
		if (printoutForPrinting) {
			return new MaxPrintPreview(handle, printout, printoutForPrinting, &data->Data());
		} else {
			return new MaxPrintPreview(handle, printout, NULL, &data->Data());
		}
	} else {
		if (printoutForPrinting) {
			return new MaxPrintPreview(handle, printout, printoutForPrinting, NULL);
		} else {
			return new MaxPrintPreview(handle, printout, NULL, NULL);
		}
	}
}

void bmx_wxprintpreview_free(wxPrintPreview * preview) {
	delete preview;
}

wxPreviewCanvas * bmx_wxprintpreview_getcanvas(wxPrintPreview * preview) {
    return preview->GetCanvas();
}

int bmx_wxprintpreview_getcurrentpage(wxPrintPreview * preview) {
    return preview->GetCurrentPage();
}

wxFrame * bmx_wxprintpreview_getframe(wxPrintPreview * preview) {
    return preview->GetFrame();
}

int bmx_wxprintpreview_getmaxpage(wxPrintPreview * preview) {
    return preview->GetMaxPage();
}

int bmx_wxprintpreview_getminpage(wxPrintPreview * preview) {
    return preview->GetMinPage();
}

wxPrintout * bmx_wxprintpreview_getprintout(wxPrintPreview * preview) {
    return preview->GetPrintout();
}

wxPrintout * bmx_wxprintpreview_getprintoutforprinting(wxPrintPreview * preview) {
    return preview->GetPrintoutForPrinting();
}

bool bmx_wxprintpreview_isok(wxPrintPreview * preview) {
    return preview->IsOk();
}

bool bmx_wxprintpreview_paintpage(wxPrintPreview * preview, wxPreviewCanvas * canvas, MaxDC * dc) {
    return preview->PaintPage(canvas, *dc->GetDC());
}

bool bmx_wxprintpreview_paintpage_default(MaxPrintPreview * preview, wxPreviewCanvas * canvas, MaxDC * dc) {
    return preview->PaintPage_default(canvas, dc);
}

bool bmx_wxprintpreview_print(wxPrintPreview * preview, bool prompt) {
    return preview->Print(prompt);
}

void bmx_wxprintpreview_setCanvas(wxPrintPreview * preview, wxPreviewCanvas * canvas) {
    preview->SetCanvas(canvas);
}

void bmx_wxprintpreview_setcurrentpage(wxPrintPreview * preview, int pageNum) {
    preview->SetCurrentPage(pageNum);
}

void bmx_wxprintpreview_setframe(wxPrintPreview * preview, wxFrame * frame) {
    preview->SetFrame(frame);
}

void bmx_wxprintpreview_setprintout(wxPrintPreview * preview, wxPrintout * printout) {
    preview->SetPrintout(printout);
}

void bmx_wxprintpreview_setzoom(wxPrintPreview * preview, int percent) {
    preview->SetZoom(percent);
}

