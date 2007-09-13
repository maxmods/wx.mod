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

MaxBitmapComboBox::MaxBitmapComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxBitmapComboBox(parent, id, value, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxBitmapComboBox::~MaxBitmapComboBox() {
	wxunbind(this);
}


// *********************************************

MaxBitmapComboBox * bmx_wxbitmapcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxBitmapComboBox(maxHandle, parent, id, wxStringFromBBString(value), bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

int bmx_wxbitmapcombobox_append(wxBitmapComboBox * combobox, BBString * item, MaxBitmap * bitmap, void * clientData) {
	if (bitmap) {
		return combobox->Append(wxStringFromBBString(item), bitmap->Bitmap(), clientData);
	} else {
		return combobox->Append(wxStringFromBBString(item), wxNullBitmap, clientData);
	}
}

void bmx_wxbitmapcombobox_getbitmapsize(wxBitmapComboBox * combobox, int * w, int * h) {
	wxSize s = combobox->GetBitmapSize();
	*w = s.x;
	*h = s.y;
}

MaxBitmap * bmx_wxbitmapcombobox_getitembitmap(wxBitmapComboBox * combobox, unsigned int item) {
	wxBitmap b(combobox->GetItemBitmap(item));
	return new MaxBitmap(b);
}

int bmx_wxbitmapcombobox_insert(wxBitmapComboBox * combobox, unsigned int pos, BBString * item, MaxBitmap * bitmap, void * clientData) {
	if (bitmap) {
		return combobox->Insert(wxStringFromBBString(item), bitmap->Bitmap(), pos, clientData);
	} else {
		return combobox->Insert(wxStringFromBBString(item), wxNullBitmap, pos, clientData);
	}
}

void bmx_wxbitmapcombobox_setitembitmap(wxBitmapComboBox * combobox, unsigned int item, MaxBitmap * bitmap) {
	combobox->SetItemBitmap(item, bitmap->Bitmap());
}

