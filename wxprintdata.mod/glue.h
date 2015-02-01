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

#ifndef _WX_MAX_PRINTDATA_H_
#define _WX_MAX_PRINTDATA_H_

#include "wx/cmndata.h"
#include "wxglue.h"

class MaxPrintData;

extern "C" {

#include <blitz.h>

	MaxPrintData * bmx_wxprintdata_create();
	void bmx_wxprintdata_delete(MaxPrintData * data);

	int bmx_wxprintdata_getcollate(MaxPrintData * data);
	wxPrintBin bmx_wxprintdata_getbin(MaxPrintData * data);
	int bmx_wxprintdata_getcolour(MaxPrintData * data);
	wxDuplexMode bmx_wxprintdata_getduplex(MaxPrintData * data);
	int bmx_wxprintdata_getnocopies(MaxPrintData * data);
	int bmx_wxprintdata_getorientation(MaxPrintData * data);
	wxPaperSize bmx_wxprintdata_getpaperid(MaxPrintData * data);
	BBString * bmx_wxprintdata_getprintername(MaxPrintData * data);
	wxPrintQuality bmx_wxprintdata_getquality(MaxPrintData * data);
	int bmx_wxprintdata_getisok(MaxPrintData * data);
	void bmx_wxprintdata_setbin(MaxPrintData * data, wxPrintBin flag);
	void bmx_wxprintdata_setcollate(MaxPrintData * data, int flag);
	void bmx_wxprintdata_setcolour(MaxPrintData * data, int flag);
	void bmx_wxprintdata_setduplex(MaxPrintData * data, wxDuplexMode mode);
	void bmx_wxprintdata_setnocopies(MaxPrintData * data, int n);
	void bmx_wxprintdata_setorientation(MaxPrintData * data, int orientation);
	void bmx_wxprintdata_setpaperid(MaxPrintData * data, wxPaperSize paperId);
	void bmx_wxprintdata_setprintername(MaxPrintData * data, BBString * name);
	void bmx_wxprintdata_setquality(MaxPrintData * data, wxPrintQuality quality);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPrintData
{
public:
	MaxPrintData(const wxPrintData & d);
	MaxPrintData(wxPrintData * d);
	MaxPrintData();
	wxPrintData & Data();

private:
	wxPrintData data;
	wxPrintData * dataPtr;
};

#endif // _WX_MAX_PRINTDATA_H_
