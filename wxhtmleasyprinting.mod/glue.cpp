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



// *********************************************

wxHtmlEasyPrinting * bmx_wxhtmleasyprinting_create(BBString * name, wxWindow * parent) {
	return new wxHtmlEasyPrinting(wxStringFromBBString(name), parent);
}

bool bmx_wxhtmleasyprinting_previewfile(wxHtmlEasyPrinting * easy, BBString * htmlFile) {
	return easy->PreviewFile(wxStringFromBBString(htmlFile));
}

bool bmx_wxhtmleasyprinting_previewtext(wxHtmlEasyPrinting * easy, BBString * htmlText, BBString * basePath) {
	return easy->PreviewText(wxStringFromBBString(htmlText), wxStringFromBBString(basePath));
}

bool bmx_wxhtmleasyprinting_printfile(wxHtmlEasyPrinting * easy, BBString * htmlFile) {
	return easy->PrintFile(wxStringFromBBString(htmlFile));
}

bool bmx_wxhtmleasyprinting_printtext(wxHtmlEasyPrinting * easy, BBString * htmlText, BBString * basePath) {
	return easy->PrintText(wxStringFromBBString(htmlText), wxStringFromBBString(basePath));
}

void bmx_wxhtmleasyprinting_pagesetup(wxHtmlEasyPrinting * easy) {
	easy->PageSetup();
}

void bmx_wxhtmleasyprinting_setfonts(wxHtmlEasyPrinting * easy, BBString * normalFace, BBString * fixedFace, BBArray * sizes) {
	//easy->Set
}

void bmx_wxhtmleasyprinting_setheader(wxHtmlEasyPrinting * easy, BBString * header, int page) {
	easy->SetHeader(wxStringFromBBString(header), page);
}

void bmx_wxhtmleasyprinting_setfooter(wxHtmlEasyPrinting * easy, BBString * footer, int page) {
	easy->SetFooter(wxStringFromBBString(footer), page);
}

MaxPrintData * bmx_wxhtmleasyprinting_getprintdata(wxHtmlEasyPrinting * easy) {
	return new MaxPrintData(easy->GetPrintData());
}

MaxPageSetupDialogData * bmx_wxhtmleasyprinting_getpagesetupdata(wxHtmlEasyPrinting * easy) {
	return new MaxPageSetupDialogData(*easy->GetPageSetupData());
}

void bmx_wxhtmleasyprinting_setparentwindow(wxHtmlEasyPrinting * easy, wxWindow * parent) {
	easy->SetParentWindow(parent);
}


