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

#include "wxglue.h"
#include "wx/dialog.h"
#include "../wxicon.mod/glue.h"
#include "wx/xrc/xh_dlg.h"
#include "wx/xml/xml.h"

class MaxDialog;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxdialog_wxDialog__xrcNew)(wxDialog * dialog);

	MaxDialog * bmx_wxdialog_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * title, int x, int y,
		int w, int h, long style);
	void bmx_wxdialog_free(wxDialog * dialog);

	void bmx_wxdialog_centre(wxDialog * dialog, int direction);
	int bmx_wxdialog_show(wxDialog * dialog, int show);
	int bmx_wxdialog_showmodal(wxDialog * dialog);


	wxSizer * bmx_wxdialog_createbuttonsizer(wxDialog * dialog, int flags);
	wxSizer * bmx_wxdialog_createseparatedbuttonsizer(wxDialog * dialog, int flags);
	wxStdDialogButtonSizer * bmx_wxdialog_createstddialogbuttonsizer(wxDialog * dialog, int flags);
	void bmx_wxdialog_endmodal(wxDialog * dialog, int retCode);
	int bmx_wxdialog_getaffirmativeid(wxDialog * dialog);
	int bmx_wxdialog_getescapeid(wxDialog * dialog);
	int bmx_wxdialog_getreturncode(wxDialog * dialog);
	void bmx_wxdialog_iconize(wxDialog * dialog, int value);
	int bmx_wxdialog_isiconized(wxDialog * dialog);
	int bmx_wxdialog_ismodal(wxDialog * dialog);
	void bmx_wxdialog_setaffirmativeid(wxDialog * dialog, int id);
	void bmx_wxdialog_setescapeid(wxDialog * dialog, int id);
	void bmx_wxdialog_seticon(wxDialog * dialog, MaxIcon * icon);
	void bmx_wxdialog_setreturncode(wxDialog * dialog, int retCode);

	void bmx_wxdialog_seticons(wxDialog * dialog, MaxIconBundle * icons);

	void bmx_wxdialog_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDialog : public wxDialog
{
public:
	MaxDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style);
	MaxDialog();
	~MaxDialog();

	void MaxBind(BBObject * handle);

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDialogXmlHandler : public wxDialogXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxDialogXmlHandler)

public:
    MaxDialogXmlHandler();
    virtual wxObject *DoCreateResource();
};

