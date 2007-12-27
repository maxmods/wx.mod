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

	MaxPageSetupDialogData * bmx_wxpagesetupdialogdata_create(MaxPrintData * data);
	void bmx_wxpagesetupdialogdata_delete(MaxPageSetupDialogData * setup);

	void bmx_wxpagesetupdialogdata_enablehelp(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enablemargins(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enableorientation(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enablepaper(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_enableprinter(MaxPageSetupDialogData * setup, bool flag);
	bool bmx_wxpagesetupdialogdata_getdefaultminmargins(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablemargins(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenableorientation(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablepaper(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenableprinter(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getenablehelp(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_getdefaultinfo(MaxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_getmargintopleft(MaxPageSetupDialogData * setup, int * leftMargin, int * topMargin);
	void bmx_wxpagesetupdialogdata_getmarginbottomright(MaxPageSetupDialogData * setup, int * rightMargin, int * bottomMargin);
	void bmx_wxpagesetupdialogdata_getminmargintopleft(MaxPageSetupDialogData * setup, int * leftMin, int * topMin);
	void bmx_wxpagesetupdialogdata_getminmarginbottomright(MaxPageSetupDialogData * setup, int * rightMin, int * bottomMin);
	wxPaperSize bmx_wxpagesetupdialogdata_getpaperid(MaxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_getpapersize(MaxPageSetupDialogData * setup, int * w, int * h);
	MaxPrintData * bmx_wxpagesetupdialogdata_getprintdata(MaxPageSetupDialogData * setup);
	bool bmx_wxpagesetupdialogdata_isok(MaxPageSetupDialogData * setup);
	void bmx_wxpagesetupdialogdata_setdefaultinfo(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_setdefaultminmargins(MaxPageSetupDialogData * setup, bool flag);
	void bmx_wxpagesetupdialogdata_setmargintopleft(MaxPageSetupDialogData * setup, int leftMargin, int topMargin);
	void bmx_wxpagesetupdialogdata_setmarginbottomright(MaxPageSetupDialogData * setup, int rightMargin, int bottomMargin);
	void bmx_wxpagesetupdialogdata_setminmargintopleft(MaxPageSetupDialogData * setup, int leftMin, int topMin);
	void bmx_wxpagesetupdialogdata_setminmarginbottomright(MaxPageSetupDialogData * setup, int rightMin, int bottomMin);
	void bmx_wxpagesetupdialogdata_setpaperid(MaxPageSetupDialogData * setup, wxPaperSize id);
	void bmx_wxpagesetupdialogdata_setpapersize(MaxPageSetupDialogData * setup, int w, int h);
	void bmx_wxpagesetupdialogdata_setprintdata(MaxPageSetupDialogData * setup, MaxPrintData * data);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPageSetupDialogData
{
public:
	MaxPageSetupDialogData(const wxPageSetupDialogData & d);
	~ MaxPageSetupDialogData();
	wxPageSetupDialogData & Data();
	
private:
	wxPageSetupDialogData data;
};

#endif // _WX_MAX_PAGESETUPDIALOGDATA_H_
