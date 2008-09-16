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

#include "wxglue.h"
#include "wx/propdlg.h"
#include "wx/generic/propdlg.h"
#include "wx/xrc/xh_propdlg.h"

#include "wx/bookctrl.h"
#include "wx/imaglist.h"


class MaxPropertySheetDialog;

extern "C" {

#include <blitz.h>

	wxBookCtrlBase * _wx_wxpropertysheetdialog_wxPropertySheetDialog__CreateBookCtrl(BBObject * handle);
	void _wx_wxpropertysheetdialog_wxPropertySheetDialog__AddBookCtrl(BBObject * handle, wxSizer * sizer);
	BBObject * _wx_wxpropertysheetdialog_wxPropertySheetDialog__xrcNew(wxPropertySheetDialog * dialog);

	wxPropertySheetDialog * bmx_wxpropertysheetdialog_create(BBObject * handle, wxWindow * parent,
		wxWindowID id, BBString * title, int x, int y, int w, int h, long style);
	void bmx_wxpropertysheetdialog_addbookctrl(MaxPropertySheetDialog * dialog, wxSizer * sizer);
	wxBookCtrlBase * bmx_wxpropertysheetdialog_createbookctrl(MaxPropertySheetDialog * dialog);
	void bmx_wxpropertysheetdialog_createbuttons(wxPropertySheetDialog * dialog, int flags);
	wxBookCtrlBase * bmx_wxpropertysheetdialog_getbookctrl(wxPropertySheetDialog * dialog);
	wxSizer * bmx_wxpropertysheetdialog_getinnersizer(wxPropertySheetDialog * dialog);
	int bmx_wxpropertysheetdialog_getsheetstyle(wxPropertySheetDialog * dialog);
	void bmx_wxpropertysheetdialog_layoutdialog(wxPropertySheetDialog * dialog, int centreFlags);
	void bmx_wxpropertysheetdialog_setbookctrl(wxPropertySheetDialog * dialog, wxBookCtrlBase * bookCtrl);

	void bmx_wxpropertysheetdialog_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPropertySheetDialog : public wxPropertySheetDialog
{
public:
	MaxPropertySheetDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style);
	MaxPropertySheetDialog();
	~MaxPropertySheetDialog();
	void AddBookCtrl(wxSizer* sizer);
	wxBookCtrlBase* CreateBookCtrl();
	void AddBookCtrl_default(wxSizer* sizer);
	wxBookCtrlBase* CreateBookCtrl_default();
	
	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPropertySheetDialogXmlHandler : public wxPropertySheetDialogXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxPropertySheetDialogXmlHandler)

public:
    MaxPropertySheetDialogXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    bool m_isInside;
    wxPropertySheetDialog *m_dialog;

};
