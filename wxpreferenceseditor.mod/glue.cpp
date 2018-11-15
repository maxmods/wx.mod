/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxPreferencesEditor::MaxPreferencesEditor(BBObject * handle, const wxString & title)
		: maxHandle(handle)
{
	BBRETAIN(handle);
}

MaxPreferencesEditor::~MaxPreferencesEditor() {
	BBRELEASE(maxHandle);
}

// *********************************************

wxPreferencesEditor * bmx_wxpreferenceseditor_create(BBObject * handle, BBString * title) {
	return new MaxPreferencesEditor(handle, wxStringFromBBString(title));
}

void bmx_wxpreferenceseditor_addpage(wxPreferencesEditor * editor, wxPreferencesPage * page) {
	editor->AddPage(page);
}

void bmx_wxpreferenceseditor_dismiss(wxPreferencesEditor * editor) {
	editor->Dismiss();
}

void bmx_wxpreferenceseditor_show(wxPreferencesEditor * editor, wxWindow * parent) {
	editor->Show(parent);
}

int bmx_wxpreferenceseditor_shouldapplychangesimmediately() {
	return static_cast<int>(wxPreferencesEditor::ShouldApplyChangesImmediately());	
}


