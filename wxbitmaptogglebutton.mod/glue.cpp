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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxBitmapToggleButton::MaxBitmapToggleButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxBitmap & bitmap, int x, int y,
		int w, int h, long style)
	: wxBitmapToggleButton(parent, id, bitmap, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxBitmapToggleButton::MaxBitmapToggleButton()
{}

MaxBitmapToggleButton::~MaxBitmapToggleButton() {
	wxunbind(this);
}

void MaxBitmapToggleButton::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}



// *********************************************

BEGIN_EVENT_TABLE(MaxBitmapToggleButton, wxBitmapToggleButton)
END_EVENT_TABLE()

wxBitmapToggleButton * bmx_wxbitmaptogglebutton_create(BBObject * handle, wxWindow * parent, wxWindowID id, MaxBitmap * bitmap,
		int x, int y, int w, int h, long style) {
	return new MaxBitmapToggleButton(handle, parent, id, bitmap->Bitmap(), x, y, w, h, style);
}

int bmx_wxbitmaptogglebutton_getvalue(wxBitmapToggleButton * button) {
	return static_cast<int>(button->GetValue());
}

void bmx_wxbitmaptogglebutton_setvalue(wxBitmapToggleButton * button, int value) {
	button->SetValue(static_cast<bool>(value));
}

void bmx_wxbitmaptogglebutton_setbitmap(wxBitmapToggleButton * button, MaxBitmap * bitmap) {
#ifndef __WXMAC__
	button->SetLabel(bitmap->Bitmap());
#endif
}




