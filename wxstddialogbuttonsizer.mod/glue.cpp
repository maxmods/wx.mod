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

MaxStdDialogButtonSizer::MaxStdDialogButtonSizer(BBObject * handle)
	: maxHandle(handle), wxStdDialogButtonSizer()
{
	wxbind(this, handle);
}

MaxStdDialogButtonSizer::~MaxStdDialogButtonSizer() {
	wxunbind(this);
}


// *********************************************

wxStdDialogButtonSizer * bmx_wxstddialogbuttonsizer_create(BBObject * handle) {
	return new MaxStdDialogButtonSizer(handle);
}

void bmx_wxstddialogbuttonsizer_addbutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->AddButton(button);
}

void bmx_wxstddialogbuttonsizer_realize(wxStdDialogButtonSizer * sizer) {
	sizer->Realize();
}

void bmx_wxstddialogbuttonsizer_setaffirmativebutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetAffirmativeButton(button);
}

void bmx_wxstddialogbuttonsizer_setcancelbutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetCancelButton(button);
}

void bmx_wxstddialogbuttonsizer_setnegativebutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetNegativeButton(button);
}

