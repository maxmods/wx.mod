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

MaxPrintData::MaxPrintData(const wxPrintData & d)
{
	data = d;
	dataPtr = 0;
}

MaxPrintData::MaxPrintData()
{
	data = wxPrintData();
	dataPtr = 0;
}

MaxPrintData::MaxPrintData(wxPrintData * d) {
	dataPtr = d;
}

wxPrintData & MaxPrintData::Data() {
	if (dataPtr) {
		return *dataPtr;
	} else {
		return data;
	}
}


// *********************************************


MaxPrintData * bmx_wxprintdata_create() {
	return new MaxPrintData();
}

void bmx_wxprintdata_delete(MaxPrintData * data) {
	delete data;
}

bool bmx_wxprintdata_getcollate(MaxPrintData * data) {
    return data->Data().GetCollate();
}

wxPrintBin bmx_wxprintdata_getbin(MaxPrintData * data) {
    return data->Data().GetBin();
}

bool bmx_wxprintdata_getcolour(MaxPrintData * data) {
    return data->Data().GetColour();
}

wxDuplexMode bmx_wxprintdata_getduplex(MaxPrintData * data) {
    return data->Data().GetDuplex();
}

int bmx_wxprintdata_getnocopies(MaxPrintData * data) {
    return data->Data().GetNoCopies();
}

int bmx_wxprintdata_getorientation(MaxPrintData * data) {
    return data->Data().GetOrientation();
}

wxPaperSize bmx_wxprintdata_getpaperid(MaxPrintData * data) {
    return data->Data().GetPaperId();
}

BBString * bmx_wxprintdata_getprintername(MaxPrintData * data) {
    return bbStringFromWxString(data->Data().GetPrinterName());
}

wxPrintQuality bmx_wxprintdata_getquality(MaxPrintData * data) {
    return data->Data().GetQuality();
}

bool bmx_wxprintdata_getisok(MaxPrintData * data) {
    return data->Data().IsOk();
}

void bmx_wxprintdata_setbin(MaxPrintData * data, wxPrintBin flag) {
    data->Data().SetBin(flag);
}

void bmx_wxprintdata_setcollate(MaxPrintData * data, bool flag) {
    data->Data().SetCollate(flag);
}

void bmx_wxprintdata_setcolour(MaxPrintData * data, bool flag) {
    data->Data().SetColour(flag);
}

void bmx_wxprintdata_setduplex(MaxPrintData * data, wxDuplexMode mode) {
    data->Data().SetDuplex(mode);
}

void bmx_wxprintdata_setnocopies(MaxPrintData * data, int n) {
    data->Data().SetNoCopies(n);
}

void bmx_wxprintdata_setorientation(MaxPrintData * data, int orientation) {
    data->Data().SetOrientation(orientation);
}

void bmx_wxprintdata_setpaperid(MaxPrintData * data, wxPaperSize paperId) {
    data->Data().SetPaperId(paperId);
}

void bmx_wxprintdata_setprintername(MaxPrintData * data, BBString * name) {
    data->Data().SetPrinterName(wxStringFromBBString(name));
}

void bmx_wxprintdata_setquality(MaxPrintData * data, wxPrintQuality quality) {
    data->Data().SetQuality(quality);
}


