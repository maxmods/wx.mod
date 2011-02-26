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

MaxSingleChoiceDialog::MaxSingleChoiceDialog(BBObject * handle, wxWindow * parent,
		const wxString& message, const wxString& caption, const wxArrayString& choices, long style, int x, int y)
	: wxSingleChoiceDialog(parent, message, caption, choices, NULL, style, wxPoint(x, y))
{
	wxbind(this, handle);
}

MaxSingleChoiceDialog::~MaxSingleChoiceDialog() {
	wxunbind(this);
}


MaxMultiChoiceDialog::MaxMultiChoiceDialog(BBObject * handle, wxWindow * parent,
		const wxString& message, const wxString& caption, const wxArrayString& choices, long style, int x, int y)
	: wxMultiChoiceDialog(parent, message, caption, choices, style, wxPoint(x, y))
{
	wxbind(this, handle);
}

MaxMultiChoiceDialog::~MaxMultiChoiceDialog() {
	wxunbind(this);
}

// *********************************************


BBString * bmx_wxgetsinglechoice(BBString * message, BBString * caption, BBArray * choices, wxWindow * parent,
		int x, int y, int centre, int width, int height) {

	if (parent) {
		return bbStringFromWxString(wxGetSingleChoice(wxStringFromBBString(message), wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), 
			parent, x, y, static_cast<bool>(centre), width, height));
	} else {
		return bbStringFromWxString(wxGetSingleChoice(wxStringFromBBString(message), wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), 
			NULL, x, y, static_cast<bool>(centre), width, height));
	}

}

int bmx_wxgetsinglechoiceindex(BBString * message, BBString * caption, BBArray * choices, wxWindow * parent,
		int x, int y, int centre, int width, int height) {

	if (parent) {
		return wxGetSingleChoiceIndex(wxStringFromBBString(message), wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), 
			parent, x, y, static_cast<bool>(centre), width, height);
	} else {
		return wxGetSingleChoiceIndex(wxStringFromBBString(message), wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), 
			NULL, x, y, static_cast<bool>(centre), width, height);
	}

}

MaxSingleChoiceDialog * bmx_wxsinglechoicedialog_create(BBObject * handle, wxWindow * parent,
		BBString * message, BBString * caption, BBArray * choices, long style, int x, int y) {

	return new MaxSingleChoiceDialog(handle, parent, wxStringFromBBString(message), 
		wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), style, x, y);
}

int bmx_wxsinglechoicedialog_getselection(wxSingleChoiceDialog * dialog) {
	return dialog->GetSelection();
}

BBString * bmx_wxsinglechoicedialog_getstringselection(wxSingleChoiceDialog * dialog) {
	return bbStringFromWxString(dialog->GetStringSelection());
}

void bmx_wxsinglechoicedialog_setselection(wxSingleChoiceDialog * dialog, int index) {
	dialog->SetSelection(index);
}

int bmx_wxsinglechoicedialog_showmodal(wxSingleChoiceDialog * dialog) {
	return dialog->ShowModal();
}


MaxMultiChoiceDialog * bmx_wxmultichoicedialog_create(BBObject * handle, wxWindow * parent,
		BBString * message, BBString * caption, BBArray * choices, long style, int x, int y) {

	return new MaxMultiChoiceDialog(handle, parent, wxStringFromBBString(message), 
		wxStringFromBBString(caption), bbStringArrayTowxArrayStr(choices), style, x, y);
}

BBArray * bmx_wxmultichoicedialog_getselections(wxMultiChoiceDialog * dialog) {
	return wxArrayIntToBBIntArray(dialog->GetSelections());
}

void bmx_wxmultichoicedialog_setselections(wxMultiChoiceDialog * dialog, BBArray * selections) {
	dialog->SetSelections(bbIntArrayTowxArrayInt(selections));
}

int bmx_wxmultichoicedialog_showmodal(wxMultiChoiceDialog * dialog) {
	return dialog->ShowModal();
}


