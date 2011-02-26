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
#include "wx/fdrepdlg.h"


class MaxFindReplaceDialog;

extern "C" {

#include <blitz.h>

	MaxFindReplaceDialog * bmx_wxfindreplacedialog_create(BBObject * handle, wxWindow * parent, wxFindReplaceData * data, BBString * title, int style);

	wxFindReplaceData * bmx_wxfindreplacedata_create(BBObject * handle, wxUint32 flags);
	BBString * bmx_wxfindreplacedata_getfindstring(wxFindReplaceData * data);
	BBString * bmx_wxfindreplacedata_getreplacestring(wxFindReplaceData * data);
	int bmx_wxfindreplacedata_getflags(wxFindReplaceData * data);
	void bmx_wxfindreplacedata_setflags(wxFindReplaceData * data, int flags);
	void bmx_wxfindreplacedata_setfindstring(wxFindReplaceData * data, BBString * str);
	void bmx_wxfindreplacedata_setreplacestring(wxFindReplaceData * data, BBString * str);
	void bmx_wxfindreplacedata_free(wxFindReplaceData * data);

	int bmx_wxfinddialogevent_getflags(wxFindDialogEvent & event);
	BBString * bmx_wxfinddialogevent_getfindstring(wxFindDialogEvent & event);
	BBString * bmx_wxfinddialogevent_getreplacestring(wxFindDialogEvent & event);
	wxFindReplaceDialog * bmx_wxfinddialogevent_getdialog(wxFindDialogEvent & event);

	int bmx_wxfindreplacedialog_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFindReplaceDialog : public wxFindReplaceDialog
{
public:
	MaxFindReplaceDialog(BBObject * handle, wxWindow * parent, wxFindReplaceData* data, const wxString& title, int style);
	~MaxFindReplaceDialog();
};
