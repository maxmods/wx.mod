/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

MaxPageSetupDialogData::MaxPageSetupDialogData(const wxPageSetupDialogData & d)
{
	data = d;
	dataPtr = 0;
}

MaxPageSetupDialogData::MaxPageSetupDialogData(wxPageSetupDialogData * d)
{
	dataPtr = d;
}

MaxPageSetupDialogData::~ MaxPageSetupDialogData()
{
}

wxPageSetupDialogData & MaxPageSetupDialogData::Data() {
	if (dataPtr) {
		return *dataPtr;
	} else {
		return data;
	}
}

// *********************************************


MaxPageSetupDialogData * bmx_wxpagesetupdialogdata_create(MaxPrintData * data) {
	if(data) {
		wxPageSetupDialogData d(data->Data());
		return new MaxPageSetupDialogData(d);
	} else {
		wxPageSetupDialogData d;
		return new MaxPageSetupDialogData(d);
	}
}

void bmx_wxpagesetupdialogdata_delete(MaxPageSetupDialogData * setup) {
	delete setup;
}

void bmx_wxpagesetupdialogdata_enablehelp(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().EnableHelp(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_enablemargins(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().EnableMargins(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_enableorientation(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().EnableOrientation(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_enablepaper(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().EnablePaper(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_enableprinter(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().EnablePrinter(static_cast<bool>(flag));
}

int bmx_wxpagesetupdialogdata_getdefaultminmargins(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetDefaultMinMargins());
}

int bmx_wxpagesetupdialogdata_getenablemargins(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetEnableMargins());
}

int bmx_wxpagesetupdialogdata_getenableorientation(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetEnableOrientation());
}

int bmx_wxpagesetupdialogdata_getenablepaper(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetEnablePaper());
}

int bmx_wxpagesetupdialogdata_getenableprinter(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetEnablePrinter());
}

int bmx_wxpagesetupdialogdata_getenablehelp(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetEnableHelp());
}

int bmx_wxpagesetupdialogdata_getdefaultinfo(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().GetDefaultInfo());
}

void bmx_wxpagesetupdialogdata_getmargintopleft(MaxPageSetupDialogData * setup, int * leftMargin, int * topMargin) {
    wxPoint p = setup->Data().GetMarginTopLeft();
    *leftMargin = p.x;
    *topMargin = p.y;
}

void bmx_wxpagesetupdialogdata_getmarginbottomright(MaxPageSetupDialogData * setup, int * rightMargin, int * bottomMargin) {
    wxPoint p = setup->Data().GetMarginBottomRight();
    *rightMargin = p.x;
    *bottomMargin = p.y;
}

void bmx_wxpagesetupdialogdata_getminmargintopleft(MaxPageSetupDialogData * setup, int * leftMin, int * topMin) {
    wxPoint p = setup->Data().GetMinMarginTopLeft();
    *leftMin = p.x;
    *topMin = p.y;
}

void bmx_wxpagesetupdialogdata_getminmarginbottomright(MaxPageSetupDialogData * setup, int * rightMin, int * bottomMin) {
    wxPoint p = setup->Data().GetMinMarginBottomRight();
    *rightMin = p.x;
    *bottomMin = p.y;
}

wxPaperSize bmx_wxpagesetupdialogdata_getpaperid(MaxPageSetupDialogData * setup) {
    return setup->Data().GetPaperId();
}

void bmx_wxpagesetupdialogdata_getpapersize(MaxPageSetupDialogData * setup, int * w, int * h) {
    wxSize s = setup->Data().GetPaperSize();
    *w = s.x;
    *h = s.y;
}

MaxPrintData * bmx_wxpagesetupdialogdata_getprintdata(MaxPageSetupDialogData * setup) {
    return new MaxPrintData(setup->Data().GetPrintData());
}

int bmx_wxpagesetupdialogdata_isok(MaxPageSetupDialogData * setup) {
    return static_cast<int>(setup->Data().IsOk());
}

void bmx_wxpagesetupdialogdata_setdefaultinfo(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().SetDefaultInfo(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_setdefaultminmargins(MaxPageSetupDialogData * setup, int flag) {
    setup->Data().SetDefaultMinMargins(static_cast<bool>(flag));
}

void bmx_wxpagesetupdialogdata_setmargintopleft(MaxPageSetupDialogData * setup, int leftMargin, int topMargin) {
    setup->Data().SetMarginTopLeft(wxPoint(leftMargin, topMargin));
}

void bmx_wxpagesetupdialogdata_setmarginbottomright(MaxPageSetupDialogData * setup, int rightMargin, int bottomMargin) {
    setup->Data().SetMarginBottomRight(wxPoint(rightMargin, bottomMargin));
}

void bmx_wxpagesetupdialogdata_setminmargintopleft(MaxPageSetupDialogData * setup, int leftMin, int topMin) {
    setup->Data().SetMinMarginTopLeft(wxPoint(leftMin, topMin));
}

void bmx_wxpagesetupdialogdata_setminmarginbottomright(MaxPageSetupDialogData * setup, int rightMin, int bottomMin) {
    setup->Data().SetMinMarginBottomRight(wxPoint(rightMin, bottomMin));
}

void bmx_wxpagesetupdialogdata_setpaperid(MaxPageSetupDialogData * setup, wxPaperSize id) {
    setup->Data().SetPaperId(id);
}

void bmx_wxpagesetupdialogdata_setpapersize(MaxPageSetupDialogData * setup, int w, int h) {
    setup->Data().SetPaperSize(wxSize(w, h));
}

void bmx_wxpagesetupdialogdata_setprintdata(MaxPageSetupDialogData * setup, MaxPrintData * data) {
    setup->Data().SetPrintData(data->Data());
}

