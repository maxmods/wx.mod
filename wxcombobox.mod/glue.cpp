/*
  Copyright (c) 2007 Bruce A Henderson
 
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


MaxComboBox::MaxComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxComboBox(parent, id, value, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxComboBox::~MaxComboBox() {
	wxunbind(this);
}

// *********************************************

MaxComboBox * bmx_wxcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxComboBox(maxHandle, parent, id, wxStringFromBBString(value), bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

bool bmx_wxcombobox_cancopy(MaxComboBox * combo) {
	return combo->CanCopy();
}

bool bmx_wxcombobox_cancut(MaxComboBox * combo) {
	return combo->CanCut();
}

bool bmx_wxcombobox_canpaste(MaxComboBox * combo) {
	return combo->CanPaste();
}

bool bmx_wxcombobox_canredo(MaxComboBox * combo) {
	return combo->CanRedo();
}

bool bmx_wxcombobox_canundo(MaxComboBox * combo) {
	return combo->CanUndo();
}

void bmx_wxcombobox_copy(MaxComboBox * combo) {
	combo->Copy();
}

void bmx_wxcombobox_cut(MaxComboBox * combo) {
	combo->Cut();
}

int bmx_wxcombobox_getcurrentselection(MaxComboBox * combo) {
	return combo->GetCurrentSelection();
}

long bmx_wxcombobox_getinsertionpoint(MaxComboBox * combo) {
	return combo->GetInsertionPoint();
}

wxTextPos bmx_wxcombobox_getlastposition(MaxComboBox * combo) {
	return combo->GetLastPosition();
}

void bmx_wxcombobox_gettextselection(MaxComboBox * combo, long * fromPos, long * toPos) {
#ifndef __APPLE__
	combo->GetSelection(fromPos, toPos);
#endif
}

BBString * bmx_wxcombobox_getvalue(MaxComboBox * combo) {
	return bbStringFromWxString(combo->GetValue());
}

void bmx_wxcombobox_paste(MaxComboBox * combo) {
	combo->Paste();
}

void bmx_wxcombobox_redo(MaxComboBox * combo) {
	combo->Redo();
}

void bmx_wxcombobox_replace(MaxComboBox * combo, long fromPos, long toPos, BBString * text) {
	combo->Replace(fromPos, toPos, wxStringFromBBString(text));
}

void bmx_wxcombobox_remove(MaxComboBox * combo, long fromPos, long toPos) {
	combo->Remove(fromPos, toPos);
}

void bmx_wxcombobox_setinsertionpoint(MaxComboBox * combo, long pos) {
	combo->SetInsertionPoint(pos);
}

void bmx_wxcombobox_setinsertionpointend(MaxComboBox * combo) {
	combo->SetInsertionPointEnd();
}

void bmx_wxcombobox_settextselection(MaxComboBox * combo, long fromPos, long toPos) {
	combo->SetSelection(fromPos, toPos);
}

void bmx_wxcombobox_setvalue(MaxComboBox * combo, BBString * text) {
	combo->SetValue(wxStringFromBBString(text));
}

void bmx_wxcombobox_undo(MaxComboBox * combo) {
	combo->Undo();
}


int bmx_wxcombobox_geteventtype(int type) {
	switch(type) {
		case 15: return wxEVT_COMMAND_COMBOBOX_SELECTED;
	}
	
	return 0;
}

