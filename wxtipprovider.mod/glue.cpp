/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxTipProvider::MaxTipProvider(BBObject * handle, int currentTip)
	: maxHandle(handle), wxTipProvider(currentTip)
{
	BBRETAIN(handle);
}

MaxTipProvider::~MaxTipProvider() {
	BBRELEASE(maxHandle);
}

wxString MaxTipProvider::GetTip() {
	return wxStringFromBBString(_wx_wxtipprovider_wxTipProvider__GetTip(maxHandle));
}

wxString MaxTipProvider::PreProcessTip(const wxString & tip) {
	return wxStringFromBBString(_wx_wxtipprovider_wxTipProvider__PreProcessTip(maxHandle, bbStringFromWxString(tip)));
}


// *********************************************

wxTipProvider * bmx_wxtipprovider_create(BBObject * handle, int currentTip) {
	return new MaxTipProvider(handle, currentTip);
}

int bmx_wxtipprovider_getcurrenttip(wxTipProvider * tip) {
	return tip->GetCurrentTip();
}

void bmx_wxtipprovider_free(wxTipProvider * tip) {
	delete tip;
}

wxTipProvider * bmx_wxcreatefiletipprovider(BBString * filename, int currentTip) {
	return wxCreateFileTipProvider(wxStringFromBBString(filename), currentTip);
}

bool bmx_wxshowtip(wxWindow * parent, wxTipProvider * tip, bool showAtStartup) {
	return wxShowTip(parent, tip, showAtStartup);
}


