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

#include "wxglue.h"
#include "wx/choicdlg.h"

class MaxSingleChoiceDialog;
class MaxMultiChoiceDialog;

extern "C" {

#include <blitz.h>

	BBString * bmx_wxgetsinglechoice(BBString * message, BBString * caption, BBArray * choices, wxWindow * parent,
		int x, int y, int centre, int width, int height);
	int bmx_wxgetsinglechoiceindex(BBString * message, BBString * caption, BBArray * choices, wxWindow * parent,
		int x, int y, int centre, int width, int height);

	MaxSingleChoiceDialog * bmx_wxsinglechoicedialog_create(BBObject * handle, wxWindow * parent,
			BBString * message, BBString * caption, BBArray * choices, long style, int x, int y);
	int bmx_wxsinglechoicedialog_getselection(wxSingleChoiceDialog * dialog);
	BBString * bmx_wxsinglechoicedialog_getstringselection(wxSingleChoiceDialog * dialog);
	void bmx_wxsinglechoicedialog_setselection(wxSingleChoiceDialog * dialog, int index);
	int bmx_wxsinglechoicedialog_showmodal(wxSingleChoiceDialog * dialog);

	MaxMultiChoiceDialog * bmx_wxmultichoicedialog_create(BBObject * handle, wxWindow * parent,
			BBString * message, BBString * caption, BBArray * choices, long style, int x, int y);
	BBArray * bmx_wxmultichoicedialog_getselections(wxMultiChoiceDialog * dialog);
	void bmx_wxmultichoicedialog_setselections(wxMultiChoiceDialog * dialog, BBArray * selections);
	int bmx_wxmultichoicedialog_showmodal(wxMultiChoiceDialog * dialog);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSingleChoiceDialog : public wxSingleChoiceDialog
{
public:
	MaxSingleChoiceDialog(BBObject * handle, wxWindow * parent, const wxString& message, 
		const wxString& caption, const wxArrayString& choices, long style, int x, int y);
	~MaxSingleChoiceDialog();
	
};

class MaxMultiChoiceDialog : public wxMultiChoiceDialog
{
public:
	MaxMultiChoiceDialog(BBObject * handle, wxWindow * parent, const wxString& message, 
		const wxString& caption, const wxArrayString& choices, long style, int x, int y);
	~MaxMultiChoiceDialog();
	
};
