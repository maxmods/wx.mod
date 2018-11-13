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



// *********************************************

wxAppProgressIndicator * bmx_wxappprogressindicator_create(wxWindow * parent, int maxValue) {
	return new wxAppProgressIndicator(parent, maxValue);
}

void bmx_wxappprogressindicator_free(wxAppProgressIndicator * progress) {
	delete progress;
}

int bmx_wxappprogressindicator_isavailable(wxAppProgressIndicator * progress) {
	return static_cast<int>(progress->IsAvailable());
}

void bmx_wxappprogressindicator_setvalue(wxAppProgressIndicator * progress, int value) {
	progress->SetValue(value);
}

void bmx_wxappprogressindicator_setrange(wxAppProgressIndicator * progress, int value) {
	progress->SetRange(value);
}

void bmx_wxappprogressindicator_pulse(wxAppProgressIndicator * progress) {
	progress->Pulse();
}


