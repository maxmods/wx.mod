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

MaxPrintout::MaxPrintout(BBObject * handle, const wxString& title)
	: maxHandle(handle), wxPrintout(title)
{
}

bool MaxPrintout::OnBeginDocument(int startPage, int endPage) {

	bool check = CB_PREF(wx_wxprintout_wxPrintout__OnBeginDocument)(maxHandle, startPage, endPage);
	if (!wxPrintout::OnBeginDocument(startPage, endPage)) {
		return false;
	}
	return check;
}

void MaxPrintout::OnEndDocument() {

	CB_PREF(wx_wxprintout_wxPrintout__OnEndDocument)(maxHandle);
	wxPrintout::OnEndDocument();

}

void MaxPrintout::OnBeginPrinting() {

	CB_PREF(wx_wxprintout_wxPrintout__OnBeginPrinting)(maxHandle);

}

void MaxPrintout::OnEndPrinting() {

	CB_PREF(wx_wxprintout_wxPrintout__OnEndPrinting)(maxHandle);

}

void MaxPrintout::OnPreparePrinting() {

	CB_PREF(wx_wxprintout_wxPrintout__OnPreparePrinting)(maxHandle);

}

bool MaxPrintout::OnPrintPage(int pageNum) {

	return CB_PREF(wx_wxprintout_wxPrintout__OnPrintPage)(maxHandle, pageNum);

}

void MaxPrintout::GetPageInfo(int *minPage, int *maxPage, int *pageFrom, int *pageTo) {

	CB_PREF(wx_wxprintout_wxPrintout__GetPageInfo)(maxHandle, minPage, maxPage, pageFrom, pageTo);

}

bool MaxPrintout::HasPage(int pageNum) {

	return CB_PREF(wx_wxprintout_wxPrintout__HasPage)(maxHandle, pageNum);

}



// *********************************************

MaxPrintout * bmx_wxprintout_create(BBObject * handle, BBString * title) {
	return new MaxPrintout(handle, wxStringFromBBString(title));
}

void bmx_printout_delete(wxPrintout * printout){
	delete printout;
}


MaxDC * bmx_wxprintout_getdc(wxPrintout * printout) {
    return new MaxDC(*printout->GetDC());
}

void bmx_wxprintout_getpagesizemm(wxPrintout * printout, int * w, int * h) {
    printout->GetPageSizeMM(w, h);
}

void bmx_wxprintout_getpagesizepixels(wxPrintout * printout, int * w, int * h) {
    printout->GetPageSizePixels(w, h);
}

void bmx_wxprintout_getpaperrectpixels(wxPrintout * printout, int * x, int * y, int * w, int * h) {
    wxRect r(printout->GetPaperRectPixels());
    *x = r.x;
    *y = r.y;
    *w = r.width;
    *h = r.height;
}

MaxRect * bmx_wxprintout_getpaperrectpixelsrect(wxPrintout * printout) {
    return new MaxRect(printout->GetPaperRectPixels());
}

void bmx_wxprintout_getppiprinter(wxPrintout * printout, int * w, int * h) {
    printout->GetPPIPrinter(w, h);
}

void bmx_wxprintout_getppiscreen(wxPrintout * printout, int * w, int * h) {
    printout->GetPPIScreen(w, h);
}

BBString * bmx_wxprintout_gettitle(wxPrintout * printout) {
    return bbStringFromWxString(printout->GetTitle());
}

int bmx_wxprintout_ispreview(wxPrintout * printout) {
    return static_cast<int>(printout->IsPreview());
}

void bmx_wxprintout_fitthissizetopaper(wxPrintout * printout, int w, int h) {
    printout->FitThisSizeToPaper(wxSize(w, h));
}

void bmx_wxprintout_fitthissizetopage(wxPrintout * printout, int w, int h) {
    printout->FitThisSizeToPage(wxSize(w, h));
}

void bmx_wxprintout_fitthissizetopagemargins(wxPrintout * printout, int w, int h, wxPageSetupDialogData * pageSetupData) {
    printout->FitThisSizeToPageMargins(wxSize(w, h), *pageSetupData);
}

void bmx_wxprintout_mapscreensizetopaper(wxPrintout * printout) {
    printout->MapScreenSizeToPaper();
}

void bmx_wxprintout_mapscreensizetopage(wxPrintout * printout) {
    printout->MapScreenSizeToPage();
}

void bmx_wxprintout_mapscreensizetopagemargins(wxPrintout * printout, wxPageSetupDialogData * pageSetupData) {
    printout->MapScreenSizeToPageMargins(*pageSetupData);
}

void bmx_wxprintout_mapscreensizetodevice(wxPrintout * printout) {
    printout->MapScreenSizeToDevice();
}

void bmx_wxprintout_getlogicalpaperrect(wxPrintout * printout, int * x, int * y, int * w, int * h) {
    wxRect r(printout->GetLogicalPaperRect());
    *x = r.x;
    *y = r.y;
    *w = r.width;
    *h = r.height;
}

MaxRect * bmx_wxprintout_getlogicalpaperrectrect(wxPrintout * printout) {
    return new MaxRect(printout->GetLogicalPaperRect());
}

void bmx_wxprintout_getlogicalpagerect(wxPrintout * printout, int * x, int * y, int * w, int * h) {
    wxRect r(printout->GetLogicalPageRect());
    *x = r.x;
    *y = r.y;
    *w = r.width;
    *h = r.height;
}

MaxRect * bmx_wxprintout_getlogicalpagerectrect(wxPrintout * printout) {
    return new MaxRect(printout->GetLogicalPageRect());
}

void bmx_wxprintout_getlogicalpagemarginsrect(wxPrintout * printout, int * x, int * y, int * w, int * h, wxPageSetupDialogData * pageSetupData) {
    wxRect r(printout->GetLogicalPageMarginsRect(*pageSetupData));
    *x = r.x;
    *y = r.y;
    *w = r.width;
    *h = r.height;
}

MaxRect * bmx_wxprintout_getlogicalpagemarginsrectrect(wxPrintout * printout, wxPageSetupDialogData * pageSetupData) {
    return new MaxRect(printout->GetLogicalPageMarginsRect(*pageSetupData));
}

void bmx_wxprintout_setlogicalorigin(wxPrintout * printout, int x, int y) {
    printout->SetLogicalOrigin(x, y);
}

void bmx_wxprintout_offsetlogicalorigin(wxPrintout * printout, int xOff, int yOff) {
    printout->OffsetLogicalOrigin(xOff, yOff);
}


