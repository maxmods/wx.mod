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
#include "wx/print.h"
#include "../wxpagesetupdialogdata.mod/glue.h"

class MaxPrintout;

extern "C" {

#include <blitz.h>

	MaxPrintout * bmx_wxprintout_create(BBObject * handle, BBString * title);
	void bmx_printout_delete(wxPrintout * printout);
	
	void CB_PREF(wx_wxprintout_wxPrintout__GetPageInfo)(BBObject * handle, int *minPage, int *maxPage, int *pageFrom, int *pageTo);
	int CB_PREF(wx_wxprintout_wxPrintout__HasPage)(BBObject * handle, int pageNum);

	int CB_PREF(wx_wxprintout_wxPrintout__OnBeginDocument)(BBObject * handle, int startPage, int endPage);
	void CB_PREF(wx_wxprintout_wxPrintout__OnEndDocument)(BBObject * handle);
	void CB_PREF(wx_wxprintout_wxPrintout__OnBeginPrinting)(BBObject * handle);
	void CB_PREF(wx_wxprintout_wxPrintout__OnEndPrinting)(BBObject * handle);
	void CB_PREF(wx_wxprintout_wxPrintout__OnPreparePrinting)(BBObject * handle);
	int CB_PREF(wx_wxprintout_wxPrintout__OnPrintPage)(BBObject * handle, int pageNum);

	MaxDC * bmx_wxprintout_getdc(wxPrintout * printout);
	void bmx_wxprintout_getpagesizemm(wxPrintout * printout, int * w, int * h);
	void bmx_wxprintout_getpagesizepixels(wxPrintout * printout, int * w, int * h);
	void bmx_wxprintout_getpaperrectpixels(wxPrintout * printout, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxprintout_getpaperrectpixelsrect(wxPrintout * printout);
	void bmx_wxprintout_getppiprinter(wxPrintout * printout, int * w, int * h);
	void bmx_wxprintout_getppiscreen(wxPrintout * printout, int * w, int * h);
	BBString * bmx_wxprintout_gettitle(wxPrintout * printout);
	int bmx_wxprintout_ispreview(wxPrintout * printout);
	void bmx_wxprintout_fitthissizetopaper(wxPrintout * printout, int w, int h);
	void bmx_wxprintout_fitthissizetopage(wxPrintout * printout, int w, int h);
	void bmx_wxprintout_fitthissizetopagemargins(wxPrintout * printout, int w, int h,  wxPageSetupDialogData * pageSetupData);
	void bmx_wxprintout_mapscreensizetopaper(wxPrintout * printout);
	void bmx_wxprintout_mapscreensizetopage(wxPrintout * printout);
	void bmx_wxprintout_mapscreensizetopagemargins(wxPrintout * printout, wxPageSetupDialogData * pageSetupData);
	void bmx_wxprintout_mapscreensizetodevice(wxPrintout * printout);
	void bmx_wxprintout_getlogicalpaperrect(wxPrintout * printout, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxprintout_getlogicalpaperrectrect(wxPrintout * printout);
	void bmx_wxprintout_getlogicalpagerect(wxPrintout * printout, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxprintout_getlogicalpagerectrect(wxPrintout * printout);
	void bmx_wxprintout_getlogicalpagemarginsrect(wxPrintout * printout, int * x, int * y, int * w, int * h, wxPageSetupDialogData * pageSetupData);
	MaxRect * bmx_wxprintout_getlogicalpagemarginsrectrect(wxPrintout * printout, wxPageSetupDialogData * pageSetupData);
	void bmx_wxprintout_setlogicalorigin(wxPrintout * printout, int x, int y);
	void bmx_wxprintout_offsetlogicalorigin(wxPrintout * printout, int xOff, int yOff);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPrintout : public wxPrintout
{
public:
	MaxPrintout(BBObject * handle, const wxString& title);

	void GetPageInfo(int *minPage, int *maxPage, int *pageFrom, int *pageTo);
	bool HasPage(int pageNum);
	
	bool OnBeginDocument(int startPage, int endPage);
	void OnEndDocument();
	void OnBeginPrinting();
	void OnEndPrinting();
	void OnPreparePrinting();
	bool OnPrintPage(int pageNum);
	
private:
	BBObject * maxHandle;
};
