/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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


BEGIN_EVENT_TABLE(MaxFixWidthImportCtrl, wxFixWidthImportCtrl)
END_EVENT_TABLE()

MaxFixWidthImportCtrl::MaxFixWidthImportCtrl(BBObject * handle, wxWindow* parent, wxWindowID id, int x,
		int y, int w, int h, long style)
       : wxFixWidthImportCtrl(parent, id, wxPoint(x, y), wxSize(w,h), style)
{
	wxbind(this, handle);
}

MaxFixWidthImportCtrl::~MaxFixWidthImportCtrl() {
	wxunbind(this);
}

// *********************************************


wxFixWidthImportCtrl * bmx_wxfixwidthimportctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, 
		int x, int y, int w, int h, long style) {
	return new MaxFixWidthImportCtrl(handle, parent, id, x, y, w, h, style);
}

int bmx_wxfixwidthimportctrl_getvalcount(wxFixWidthImportCtrl * ctrl) {
	return ctrl->GetValCount();
}

BBArray * bmx_wxfixwidthimportctrl_getvalues(wxFixWidthImportCtrl * ctrl) {
	return wxArrayIntToBBIntArray(ctrl->GetValues());
}

void bmx_wxfixwidthimportctrl_setvalues(wxFixWidthImportCtrl * ctrl, BBArray * values) {
	ctrl->SetValues(bbIntArrayTowxArrayInt(values));
}
		
int bmx_wxfixwidthimportctrl_getlinescount(wxFixWidthImportCtrl * ctrl) {
	return ctrl->GetLinesCount();
}

int bmx_wxfixwidthimportctrl_getselectedlineno(wxFixWidthImportCtrl * ctrl) {
	return ctrl->GetSelectedLineNu();
}

BBString * bmx_wxfixwidthimportctrl_getselectedline(wxFixWidthImportCtrl * ctrl) {
	return bbStringFromWxString(ctrl->GetSelectedLine());
}

void bmx_wxfixwidthimportctrl_selectline(wxFixWidthImportCtrl * ctrl, int line) {
	ctrl->SelectLine(line);
}

BBString * bmx_wxfixwidthimportctrl_getline(wxFixWidthImportCtrl * ctrl, int line) {
	return bbStringFromWxString(ctrl->GetLine(line));
}

MaxColour * bmx_wxfixwidthimportctrl_getdelimcolor(wxFixWidthImportCtrl * ctrl) {
	wxColour c(ctrl->GetDelimColor());
	return new MaxColour(c);
}

MaxColour * bmx_wxfixwidthimportctrl_getselectcolor(wxFixWidthImportCtrl * ctrl) {
	wxColour c(ctrl->GetSelecColor());
	return new MaxColour(c);
}

void bmx_wxfixwidthimportctrl_setdelimcolor(wxFixWidthImportCtrl * ctrl, MaxColour * colour) {
	ctrl->SetDelimColor(colour->Colour().Red(), colour->Colour().Green(), colour->Colour().Blue());
}

void bmx_wxfixwidthimportctrl_setselectcolor(wxFixWidthImportCtrl * ctrl, MaxColour * colour) {
	ctrl->SetSelecColor(colour->Colour().Red(), colour->Colour().Green(), colour->Colour().Blue());
}

int bmx_wxfixwidthimportctrl_loadfile(wxFixWidthImportCtrl * ctrl, BBString * filename) {
	return ctrl->LoadFile(wxStringFromBBString(filename));
}

void bmx_wxfixwidthimportctrl_loadtext(wxFixWidthImportCtrl * ctrl, BBString * text) {
	ctrl->LoadText(wxStringFromBBString(text));
}

void bmx_wxfixwidthimportctrl_settabsize(wxFixWidthImportCtrl * ctrl, int tabSize) {
	ctrl->SetTabSize(tabSize);
}

int bmx_wxfixwidthimportctrl_gettabsize(wxFixWidthImportCtrl * ctrl) {
	return ctrl->GetTabSize();
}

void bmx_wxfixwidthimportctrl_converttabstospaces(wxFixWidthImportCtrl * ctrl) {
	ctrl->ConvertTabsToSpaces();
}

void bmx_wxfixwidthimportctrl_enabledelim(wxFixWidthImportCtrl * ctrl, bool enable) {
	ctrl->EnableDelim(enable);
}



int bmx_wxfixwidthimportctrl_geteventtype(int type) {
	switch(type) {
		case -343: return wxEVT_COMMAND_FIXW_UPDATED;
	}
	
	return 0;
}
