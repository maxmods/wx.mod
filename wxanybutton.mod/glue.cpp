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

// ---------------------------------------------------------------------------------------



// *********************************************

MaxBitmap * bmx_wxanybutton_getbitmap(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmap());
}

MaxBitmap * bmx_wxanybutton_getbitmapcurrent(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmapCurrent());
}

MaxBitmap * bmx_wxanybutton_getbitmapdisabled(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmapDisabled());
}

MaxBitmap * bmx_wxanybutton_getbitmapfocus(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmapFocus());
}

MaxBitmap * bmx_wxanybutton_getbitmaplabel(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmapLabel());
}

MaxBitmap * bmx_wxanybutton_getbitmappressed(wxAnyButton * button) {
	return new MaxBitmap(button->GetBitmapPressed());
}

void bmx_wxanybutton_setbitmap(wxAnyButton * button, MaxBitmap * bitmap, int dir) {
	button->SetBitmap(bitmap->Bitmap(), (wxDirection)dir);
}

void bmx_wxanybutton_setbitmapcurrent(wxAnyButton * button, MaxBitmap * bitmap) {
	button->SetBitmapCurrent(bitmap->Bitmap());
}

void bmx_wxanybutton_setbitmapdisabled(wxAnyButton * button, MaxBitmap * bitmap) {
	button->SetBitmapDisabled(bitmap->Bitmap());
}

void bmx_wxanybutton_setbitmapfocus(wxAnyButton * button, MaxBitmap * bitmap) {
	button->SetBitmapFocus(bitmap->Bitmap());
}

void bmx_wxanybutton_setbitmaplabel(wxAnyButton * button, MaxBitmap * bitmap) {
	button->SetBitmapLabel(bitmap->Bitmap());
}

void bmx_wxanybutton_setbitmappressed(wxAnyButton * button, MaxBitmap * bitmap) {
	button->SetBitmapPressed(bitmap->Bitmap());
}

void bmx_wxanybutton_getbitmapmargins(wxAnyButton * button, int * x, int * y) {
	wxSize s(button->GetBitmapMargins());
	*x = s.x;
	*y = s.y;
}

void bmx_wxanybutton_setbitmapposition(wxAnyButton * button, int dir) {
	button->SetBitmapPosition((wxDirection)dir);
}

void bmx_wxanybutton_setbitmapmargins(wxAnyButton * button, int x, int y) {
	button->SetBitmapMargins(x, y);
}


