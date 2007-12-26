/*
  Copyright (c) 2007 Bruce A Henderson
 
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

#ifndef _WX_MAX_PAGESETUPDIALOGDATA_H_
#define _WX_MAX_PAGESETUPDIALOGDATA_H_

#include "wxglue.h"
#include "../wxprintdata.mod/glue.h"

class MaxPageSetupDialogData;

extern "C" {

#include <blitz.h>

	wxPageSetupDialogData * bmx_wxpagesetupdialogdata_create(BBObject * handle, MaxPrintData * data);

	void bmx_wxpagesetupdialogdata_enablehelp(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enablemargins(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enableorientation(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enablepaper(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enableprinter(wxPageSetupDialogData * setup, bool flag);
	bool bmx_wxpagesetupdialogdata_getdefaultminmargins(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablemargins(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenableorientation(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablepaper(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenableprinter(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablehelp(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getdefaultinfo(wxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_getmargintopleft(wxPageSetupDialogData * setup, int * leftMargin, int * topMargin);
	void bmx_wxpagesetupdialogdata_getmarginbottomright(wxPageSetupDialogData * setup, int * rightMargin, int * bottomMargin);
	void bmx_wxpagesetupdialogdata_getminmargintopleft(wxPageSetupDialogData * setup, int * leftMin, int * topMin);
	void bmx_wxpagesetupdialogdata_getminmarginbottomright(wxPageSetupDialogData * setup, int * rightMin, int * bottomMin);
	wxPaperSize bmx_wxpagesetupdialogdata_getpaperid(wxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_getpapersize(wxPageSetupDialogData * setup, int * w, int * h);
	MaxPrintData * bmx_wxpagesetupdialogdata_getprintdata(wxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_isok(wxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_setdefaultinfo(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_setdefaultminmargins(wxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_setmargintopleft(wxPageSetupDialogData * setup, int leftMargin, int topMargin);
	void bmx_wxpagesetupdialogdata_setmarginbottomright(wxPageSetupDialogData * setup, int rightMargin, int bottomMargin);
	void bmx_wxpagesetupdialogdata_setminmargintopleft(wxPageSetupDialogData * setup, int leftMin, int topMin);
	void bmx_wxpagesetupdialogdata_setminmarginbottomright(wxPageSetupDialogData * setup, int rightMin, int bottomMin);
	void bmx_wxpagesetupdialogdata_setpaperid(wxPageSetupDialogData * setup, wxPaperSize id);
	void bmx_wxpagesetupdialogdata_setpapersize(wxPageSetupDialogData * setup, int w, int h);
	void bmx_wxpagesetupdialogdata_setprintdata(wxPageSetupDialogData * setup, MaxPrintData * data);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPageSetupDialogData : public wxPageSetupDialogData
{
public:
	MaxPageSetupDialogData(BBObject * handle);
	MaxPageSetupDialogData(BBObject * handle, wxPrintData & data);
	~ MaxPageSetupDialogData();
};

#endif // _WX_MAX_PAGESETUPDIALOGDATA_H_
