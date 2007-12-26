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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxPageSetupDialogData::MaxPageSetupDialogData(BBObject * handle)
{
	wxbind(this, handle);
}

MaxPageSetupDialogData::MaxPageSetupDialogData(BBObject * handle, wxPrintData & data)
	: wxPageSetupDialogData(data)
{
	wxbind(this, handle);
}

MaxPageSetupDialogData::~ MaxPageSetupDialogData()
{
	wxunbind(this);
}

// *********************************************


wxPageSetupDialogData * bmx_wxpagesetupdialogdata_create(BBObject * handle, MaxPrintData * data) {
	if(data) {
		return new MaxPageSetupDialogData(handle, data->Data());
	} else {
		return new MaxPageSetupDialogData(handle);
	}
}

void bmx_wxpagesetupdialogdata_enablehelp(wxPageSetupDialogData * setup, bool flag) {
    setup->EnableHelp(flag);
}

void bmx_wxpagesetupdialogdata_enablemargins(wxPageSetupDialogData * setup, bool flag) {
    setup->EnableMargins(flag);
}

void bmx_wxpagesetupdialogdata_enableorientation(wxPageSetupDialogData * setup, bool flag) {
    setup->EnableOrientation(flag);
}

void bmx_wxpagesetupdialogdata_enablepaper(wxPageSetupDialogData * setup, bool flag) {
    setup->EnablePaper(flag);
}

void bmx_wxpagesetupdialogdata_enableprinter(wxPageSetupDialogData * setup, bool flag) {
    setup->EnablePrinter(flag);
}

bool bmx_wxpagesetupdialogdata_getdefaultminmargins(wxPageSetupDialogData * setup) {
    return setup->GetDefaultMinMargins();
}

bool bmx_wxpagesetupdialogdata_getenablemargins(wxPageSetupDialogData * setup) {
    return setup->GetEnableMargins();
}

bool bmx_wxpagesetupdialogdata_getenableorientation(wxPageSetupDialogData * setup) {
    return setup->GetEnableOrientation();
}

bool bmx_wxpagesetupdialogdata_getenablepaper(wxPageSetupDialogData * setup) {
    return setup->GetEnablePaper();
}

bool bmx_wxpagesetupdialogdata_getenableprinter(wxPageSetupDialogData * setup) {
    return setup->GetEnablePrinter();
}

bool bmx_wxpagesetupdialogdata_getenablehelp(wxPageSetupDialogData * setup) {
    return setup->GetEnableHelp();
}

bool bmx_wxpagesetupdialogdata_getdefaultinfo(wxPageSetupDialogData * setup) {
    return setup->GetDefaultInfo();
}

void bmx_wxpagesetupdialogdata_getmargintopleft(wxPageSetupDialogData * setup, int * leftMargin, int * topMargin) {
    wxPoint p = setup->GetMarginTopLeft();
    *leftMargin = p.x;
    *topMargin = p.y;
}

void bmx_wxpagesetupdialogdata_getmarginbottomright(wxPageSetupDialogData * setup, int * rightMargin, int * bottomMargin) {
    wxPoint p = setup->GetMarginBottomRight();
    *rightMargin = p.x;
    *bottomMargin = p.y;
}

void bmx_wxpagesetupdialogdata_getminmargintopleft(wxPageSetupDialogData * setup, int * leftMin, int * topMin) {
    wxPoint p = setup->GetMinMarginTopLeft();
    *leftMin = p.x;
    *topMin = p.y;
}

void bmx_wxpagesetupdialogdata_getminmarginbottomright(wxPageSetupDialogData * setup, int * rightMin, int * bottomMin) {
    wxPoint p = setup->GetMinMarginBottomRight();
    *rightMin = p.x;
    *bottomMin = p.y;
}

wxPaperSize bmx_wxpagesetupdialogdata_getpaperid(wxPageSetupDialogData * setup) {
    return setup->GetPaperId();
}

void bmx_wxpagesetupdialogdata_getpapersize(wxPageSetupDialogData * setup, int * w, int * h) {
    wxSize s = setup->GetPaperSize();
    *w = s.x;
    *h = s.y;
}

MaxPrintData * bmx_wxpagesetupdialogdata_getprintdata(wxPageSetupDialogData * setup) {
    return new MaxPrintData(setup->GetPrintData());
}

bool bmx_wxpagesetupdialogdata_isok(wxPageSetupDialogData * setup) {
    return setup->IsOk();
}

void bmx_wxpagesetupdialogdata_setdefaultinfo(wxPageSetupDialogData * setup, bool flag) {
    setup->SetDefaultInfo(flag);
}

void bmx_wxpagesetupdialogdata_setdefaultminmargins(wxPageSetupDialogData * setup, bool flag) {
    setup->SetDefaultMinMargins(flag);
}

void bmx_wxpagesetupdialogdata_setmargintopleft(wxPageSetupDialogData * setup, int leftMargin, int topMargin) {
    setup->SetMarginTopLeft(wxPoint(leftMargin, topMargin));
}

void bmx_wxpagesetupdialogdata_setmarginbottomright(wxPageSetupDialogData * setup, int rightMargin, int bottomMargin) {
    setup->SetMarginBottomRight(wxPoint(rightMargin, bottomMargin));
}

void bmx_wxpagesetupdialogdata_setminmargintopleft(wxPageSetupDialogData * setup, int leftMin, int topMin) {
    setup->SetMinMarginTopLeft(wxPoint(leftMin, topMin));
}

void bmx_wxpagesetupdialogdata_setminmarginbottomright(wxPageSetupDialogData * setup, int rightMin, int bottomMin) {
    setup->SetMinMarginBottomRight(wxPoint(rightMin, bottomMin));
}

void bmx_wxpagesetupdialogdata_setpaperid(wxPageSetupDialogData * setup, wxPaperSize id) {
    setup->SetPaperId(id);
}

void bmx_wxpagesetupdialogdata_setpapersize(wxPageSetupDialogData * setup, int w, int h) {
    setup->SetPaperSize(wxSize(w, h));
}

void bmx_wxpagesetupdialogdata_setprintdata(wxPageSetupDialogData * setup, MaxPrintData * data) {
    setup->SetPrintData(data->Data());
}

