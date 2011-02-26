/*
  Copyright (c) 2009-2011 Bruce A Henderson
 
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

MaxGradientButton::MaxGradientButton(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style)
	: wxGradientButton(parent, id, wxStringFromBBString(label), wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxGradientButton::MaxGradientButton()
{}

MaxGradientButton::~MaxGradientButton() {
	wxunbind(this);
}

void MaxGradientButton::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxGradientButton, wxGradientButton)
END_EVENT_TABLE()

wxGradientButton * bmx_wxgradientbutton_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y, int w, int h, long style) {
	return new MaxGradientButton(handle, parent, id, label, x, y, w, h, style);
}

BBString * bmx_wxgradientbutton_getlabel(wxGradientButton * button) {
	return bbStringFromWxString(button->GetLabel());
}

void bmx_wxgradientbutton_setlabel(wxGradientButton * button, BBString * value) {
	button->SetLabel(wxStringFromBBString(value));
}

MaxColour * bmx_wxgradientbutton_getgradienttopstartcolour(wxGradientButton * button) {
	wxColour c(button->GetGradientTopStartColour());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setgradienttopstartcolour(wxGradientButton * button, MaxColour * value) {
	button->SetGradientTopStartColour(value->Colour());
}

MaxColour * bmx_wxgradientbutton_getgradienttopendcolour(wxGradientButton * button) {
	wxColour c(button->GetGradientTopEndColour());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setgradienttopendcolour(wxGradientButton * button, MaxColour * value) {
	button->SetGradientTopEndColour(value->Colour());
}

MaxColour * bmx_wxgradientbutton_getgradientbottomstartcolour(wxGradientButton * button) {
	wxColour c(button->GetGradientBottomStartColour());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setgradientbottomstartcolour(wxGradientButton * button, MaxColour * value) {
	button->SetGradientBottomStartColour(value->Colour());
}

MaxColour * bmx_wxgradientbutton_getgradientbottomendcolour(wxGradientButton * button) {
	wxColour c(button->GetGradientBottomEndColour());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setgradientbottomendcolour(wxGradientButton * button, MaxColour * value) {
	button->SetGradientBottomEndColour(value->Colour());
}

MaxColour * bmx_wxgradientbutton_getpressedcolourtop(wxGradientButton * button) {
	wxColour c(button->GetPressedColourTop());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setpressedcolourtop(wxGradientButton * button, MaxColour * value) {
	button->SetPressedColourTop(value->Colour());
}

MaxColour * bmx_wxgradientbutton_getpressedcolourbottom(wxGradientButton * button) {
	wxColour c(button->GetPressedColourBottom());
	return new MaxColour(c);
}

void bmx_wxgradientbutton_setpressedcolourbottom(wxGradientButton * button, MaxColour * value) {
	button->SetPressedColourBottom(value->Colour());
}


