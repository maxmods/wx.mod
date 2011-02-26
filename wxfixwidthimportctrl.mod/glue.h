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

#include "wxglue.h"
#include "fiximp.h"

class MaxFixWidthImportCtrl;

extern "C" {

#include <blitz.h>

	wxFixWidthImportCtrl * bmx_wxfixwidthimportctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	int bmx_wxfixwidthimportctrl_getvalcount(wxFixWidthImportCtrl * ctrl);
	BBArray * bmx_wxfixwidthimportctrl_getvalues(wxFixWidthImportCtrl * ctrl);
	void bmx_wxfixwidthimportctrl_setvalues(wxFixWidthImportCtrl * ctrl, BBArray * values);
	int bmx_wxfixwidthimportctrl_getlinescount(wxFixWidthImportCtrl * ctrl);
	int bmx_wxfixwidthimportctrl_getselectedlineno(wxFixWidthImportCtrl * ctrl);
	BBString * bmx_wxfixwidthimportctrl_getselectedline(wxFixWidthImportCtrl * ctrl);
	void bmx_wxfixwidthimportctrl_selectline(wxFixWidthImportCtrl * ctrl, int line);
	BBString * bmx_wxfixwidthimportctrl_getline(wxFixWidthImportCtrl * ctrl, int line);
	MaxColour * bmx_wxfixwidthimportctrl_getdelimcolor(wxFixWidthImportCtrl * ctrl);
	MaxColour * bmx_wxfixwidthimportctrl_getselectcolor(wxFixWidthImportCtrl * ctrl);
	void bmx_wxfixwidthimportctrl_setdelimcolor(wxFixWidthImportCtrl * ctrl, MaxColour * colour);
	void bmx_wxfixwidthimportctrl_setselectcolor(wxFixWidthImportCtrl * ctrl, MaxColour * colour);
	int bmx_wxfixwidthimportctrl_loadfile(wxFixWidthImportCtrl * ctrl, BBString * filename);
	void bmx_wxfixwidthimportctrl_loadtext(wxFixWidthImportCtrl * ctrl, BBString * text);
	void bmx_wxfixwidthimportctrl_settabsize(wxFixWidthImportCtrl * ctrl, int tabSize);
	int bmx_wxfixwidthimportctrl_gettabsize(wxFixWidthImportCtrl * ctrl);
	void bmx_wxfixwidthimportctrl_converttabstospaces(wxFixWidthImportCtrl * ctrl);
	void bmx_wxfixwidthimportctrl_enabledelim(wxFixWidthImportCtrl * ctrl, int enable);



	int bmx_wxfixwidthimportctrl_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFixWidthImportCtrl : public wxFixWidthImportCtrl
{
public:
	MaxFixWidthImportCtrl(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxFixWidthImportCtrl();
		
private:
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

