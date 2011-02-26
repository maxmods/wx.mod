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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxPrintDialog::MaxPrintDialog(BBObject * handle, wxWindow * parent, wxPrintDialogData* data)
	: wxPrintDialog(parent, data)
{
	wxbind(this, handle);
}

MaxPrintDialog::~MaxPrintDialog() {
	wxunbind(this);
}

MaxPrintDialogData::MaxPrintDialogData(const wxPrintDialogData & d)
{
	data = d;
}

MaxPrintDialogData::MaxPrintDialogData()
{
	data = wxPrintDialogData();
}

wxPrintDialogData & MaxPrintDialogData::Data() {
	return data;
}

// *********************************************

wxPrintDialog * bmx_wxprintdialog_create(BBObject * handle, wxWindow * parent, MaxPrintDialogData * data) {
	if (data) {
		return new MaxPrintDialog(handle, parent, &data->Data());
	} else {
		return new MaxPrintDialog(handle, parent, NULL);
	}
}

MaxPrintDialogData * bmx_wxprintdialog_getprintdialogdata(wxPrintDialog * dialog) {
	return new MaxPrintDialogData(dialog->GetPrintDialogData());
}

MaxDC * bmx_wxprintdialog_getprintdc(wxPrintDialog * dialog) {
	return new MaxDC(dialog->GetPrintDC());
}

int bmx_wxprintdialog_showmodal(wxPrintDialog * dialog) {
	return dialog->ShowModal();
}

// *********************************************

MaxPrintDialogData * bmx_wxprintdialogdata_create(MaxPrintData * data) {
	if (data) {
		wxPrintDialogData d(data->Data());
		return new MaxPrintDialogData(d);
	} else {
		return new MaxPrintDialogData();
	}
}

void bmx_wxprintdialogdata_delete(MaxPrintDialogData * data) {
	delete data;
}

void bmx_wxprintdialogdata_enablehelp(MaxPrintDialogData * data, bool flag) {
    data->Data().EnableHelp(flag);
}

void bmx_wxprintdialogdata_enablepagenumbers(MaxPrintDialogData * data, bool flag) {
    data->Data().EnablePageNumbers(flag);
}

void bmx_wxprintdialogdata_enableprinttofile(MaxPrintDialogData * data, bool flag) {
    data->Data().EnablePrintToFile(flag);
}

void bmx_wxprintdialogdata_enableselection(MaxPrintDialogData * data, bool flag) {
    data->Data().EnableSelection(flag);
}

bool bmx_wxprintdialogdata_getallpages(MaxPrintDialogData * data) {
    return data->Data().GetAllPages();
}

bool bmx_wxprintdialogdata_getcollate(MaxPrintDialogData * data) {
    return data->Data().GetCollate();
}

int bmx_wxprintdialogdata_getfrompage(MaxPrintDialogData * data) {
    return data->Data().GetFromPage();
}

int bmx_wxprintdialogdata_getmaxpage(MaxPrintDialogData * data) {
    return data->Data().GetMaxPage();
}

int bmx_wxprintdialogdata_getminpage(MaxPrintDialogData * data) {
    return data->Data().GetMinPage();
}

int bmx_wxprintdialogdata_getnocopies(MaxPrintDialogData * data) {
    return data->Data().GetNoCopies();
}

MaxPrintData * bmx_wxprintdialogdata_getprintdata(MaxPrintDialogData * data) {
    return new MaxPrintData(data->Data().GetPrintData());
}

bool bmx_wxprintdialogdata_getprinttofile(MaxPrintDialogData * data) {
    return data->Data().GetPrintToFile();
}

bool bmx_wxprintdialogdata_getselection(MaxPrintDialogData * data) {
    return data->Data().GetSelection();
}

int bmx_wxprintdialogdata_gettopage(MaxPrintDialogData * data) {
    return data->Data().GetToPage();
}

bool bmx_wxprintdialogdata_isok(MaxPrintDialogData * data) {
    return data->Data().IsOk();
}

void bmx_wxprintdialogdata_setcollate(MaxPrintDialogData * data, bool flag) {
    data->Data().SetCollate(flag);
}

void bmx_wxprintdialogdata_setfrompage(MaxPrintDialogData * data, int page) {
    data->Data().SetFromPage(page);
}

void bmx_wxprintdialogdata_setmaxpage(MaxPrintDialogData * data, int page) {
    data->Data().SetMaxPage(page);
}

void bmx_wxprintdialogdata_setminpage(MaxPrintDialogData * data, int page) {
    data->Data().SetMinPage(page);
}

void bmx_wxprintdialogdata_setnocopies(MaxPrintDialogData * data, int count) {
    data->Data().SetNoCopies(count);
}

void bmx_wxprintdialogdata_setprintdata(MaxPrintDialogData * data, MaxPrintData * printdata) {
    data->Data().SetPrintData(printdata->Data());
}

void bmx_wxprintdialogdata_setprinttofile(MaxPrintDialogData * data, bool flag) {
    data->Data().SetPrintToFile(flag);
}

void bmx_wxprintdialogdata_setselection(MaxPrintDialogData * data, bool flag) {
    data->Data().SetSelection(flag);
}

void bmx_wxprintdialogdata_settopage(MaxPrintDialogData * data, int page) {
    data->Data().SetToPage(page);
}


