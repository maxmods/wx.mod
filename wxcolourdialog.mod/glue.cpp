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

#include "glue.h"
#include "wx/colordlg.h"

// ---------------------------------------------------------------------------------------

MaxColourDialog::MaxColourDialog(BBObject * handle, wxWindow * parent, wxColourData * data)
	: wxColourDialog(parent, data)
{
	wxbind(this, handle);
}

MaxColourDialog::~MaxColourDialog() {
	wxunbind(this);
}



MaxColourData::MaxColourData()
{
}

MaxColourData::MaxColourData(const wxColourData& c)
{
	data = c;
}

wxColourData & MaxColourData::Data() {
	return data;
}


// *********************************************


MaxColour * bmx_wxgetcolourfromuser(wxWindow * parent, MaxColour * init, BBString * caption) {
	if (init) {
		wxColour c(wxGetColourFromUser(parent, init->Colour(), wxStringFromBBString(caption)));
		return new MaxColour(c);
	} else {
		wxColour c(wxGetColourFromUser(parent, wxNullColour, wxStringFromBBString(caption)));
		return new MaxColour(c);
	}
}

MaxColourDialog * bmx_wxcolourdialog_create(BBObject * handle, wxWindow * parent, MaxColourData * data) {
	if (data) {
		return new MaxColourDialog(handle, parent, &data->Data());
	} else {
		return new MaxColourDialog(handle, parent, NULL);
	}
}

MaxColourData * bmx_wxcolourdialog_getcolourdata(wxColourDialog * dialog) {
	return new MaxColourData(dialog->GetColourData());
}

int bmx_wxcolourdialog_showmodal(wxColourDialog * dialog) {
	return dialog->ShowModal();
}


MaxColourData * bmx_wxcolourdata_create() {
	return new MaxColourData();
}

int bmx_wxcolourdata_getchoosefull(MaxColourData * data) {
	return static_cast<int>(data->Data().GetChooseFull());
}

MaxColour * bmx_wxcolourdata_getcolour(MaxColourData * data) {
	wxColour c(data->Data().GetColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxcolourdata_getcustomcolour(MaxColourData * data, int i) {
	wxColour c(data->Data().GetCustomColour(i));
	return new MaxColour(c);
}

void bmx_wxcolourdata_setchoosefull(MaxColourData * data, int flag) {
	data->Data().SetChooseFull(static_cast<bool>(flag));
}

void bmx_wxcolourdata_setcolour(MaxColourData * data, MaxColour * colour) {
	data->Data().SetColour(colour->Colour());
}

void bmx_wxcolourdata_setcustomcolour(MaxColourData * data, int i, MaxColour * colour) {
	data->Data().SetCustomColour(i, colour->Colour());
}

void bmx_wxcolourdata_delete(MaxColourData * data) {
	delete data;
}

