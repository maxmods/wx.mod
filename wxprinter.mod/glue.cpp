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


// *********************************************

wxPrinter * bmx_wxprinter_create(MaxPrintDialogData * data) {
	if (data) {
		return new wxPrinter(&data->Data());
	} else {
		return new wxPrinter();
	}
}

void bmx_wxprinter_delete(wxPrinter * printer) {
	delete printer;
}

void bmx_wxprinter_createabortwindow(wxPrinter * printer, wxWindow * parent, wxPrintout * printout) {
	printer->CreateAbortWindow(parent, printout);
}

int bmx_wxprinter_getabort(wxPrinter * printer) {
	return static_cast<int>(printer->GetAbort());
}

wxPrinterError bmx_wxprinter_getlasterror() {
	return wxPrinter::GetLastError();
}

int bmx_wxprinter_print(wxPrinter * printer, wxWindow * parent, wxPrintout * printout, int prompt) {
	return static_cast<int>(printer->Print(parent, printout, static_cast<bool>(prompt)));
}

MaxPrintDialogData * bmx_wxprinter_getprintdialogdata(wxPrinter * printer) {
	return new MaxPrintDialogData(printer->GetPrintDialogData());
}

MaxDC * bmx_wxprinter_printdialog(wxPrinter * printer, wxWindow * parent) {
	return new MaxDC(printer->PrintDialog(parent));
}

void bmx_wxprinter_setup(wxPrinter * printer, wxWindow * parent) {
	printer->Setup(parent);
}

void bmx_wxprinter_reporterror(wxPrinter * printer, wxWindow * parent, wxPrintout * printout, BBString * message) {
	printer->ReportError(parent, printout, wxStringFromBBString(message));
}
