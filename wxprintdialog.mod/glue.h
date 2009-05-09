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

#include "wxglue.h"
#include "wx/printdlg.h"
#include "../wxprintdata.mod/glue.h"

class MaxPrintDialogData;
class MaxPrintDialog;

extern "C" {

#include <blitz.h>

	wxPrintDialog * bmx_wxprintdialog_create(BBObject * handle, wxWindow * parent, MaxPrintDialogData * data);

	MaxPrintDialogData * bmx_wxprintdialog_getprintdialogdata(wxPrintDialog * dialog);
	MaxDC * bmx_wxprintdialog_getprintdc(wxPrintDialog * dialog);
	int bmx_wxprintdialog_showmodal(wxPrintDialog * dialog);

	MaxPrintDialogData * bmx_wxprintdialogdata_create(MaxPrintData * data);
	void bmx_wxprintdialogdata_delete(MaxPrintDialogData * data);

	void bmx_wxprintdialogdata_enablehelp(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_enablepagenumbers(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_enableprinttofile(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_enableselection(MaxPrintDialogData * data, bool flag);
	bool bmx_wxprintdialogdata_getallpages(MaxPrintDialogData * data);
	bool bmx_wxprintdialogdata_getcollate(MaxPrintDialogData * data);
	int bmx_wxprintdialogdata_getfrompage(MaxPrintDialogData * data);
	int bmx_wxprintdialogdata_getmaxpage(MaxPrintDialogData * data);
	int bmx_wxprintdialogdata_getminpage(MaxPrintDialogData * data);
	int bmx_wxprintdialogdata_getnocopies(MaxPrintDialogData * data);
	MaxPrintData * bmx_wxprintdialogdata_getprintdata(MaxPrintDialogData * data);
	bool bmx_wxprintdialogdata_getprinttofile(MaxPrintDialogData * data);
	bool bmx_wxprintdialogdata_getselection(MaxPrintDialogData * data);
	int bmx_wxprintdialogdata_gettopage(MaxPrintDialogData * data);
	bool bmx_wxprintdialogdata_isok(MaxPrintDialogData * data);
	void bmx_wxprintdialogdata_setcollate(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_setfrompage(MaxPrintDialogData * data, int page);
	void bmx_wxprintdialogdata_setmaxpage(MaxPrintDialogData * data, int page);
	void bmx_wxprintdialogdata_setminpage(MaxPrintDialogData * data, int page);
	void bmx_wxprintdialogdata_setnocopies(MaxPrintDialogData * data, int count);
	void bmx_wxprintdialogdata_setprintdata(MaxPrintDialogData * data, MaxPrintData * printdata);
	void bmx_wxprintdialogdata_setprinttofile(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_setselection(MaxPrintDialogData * data, bool flag);
	void bmx_wxprintdialogdata_settopage(MaxPrintDialogData * data, int page);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPrintDialog : public wxPrintDialog
{
public:
	MaxPrintDialog(BBObject * handle, wxWindow * parent, wxPrintDialogData* data);
	~ MaxPrintDialog();
};


class MaxPrintDialogData
{
public:
	MaxPrintDialogData(const wxPrintDialogData & d);
	MaxPrintDialogData();
	wxPrintDialogData & Data();

private:
	wxPrintDialogData data;

};
