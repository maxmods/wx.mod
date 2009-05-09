/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxBufferedDC::MaxBufferedDC()
	: bufferedDC()
{
	MaxDC::init(&bufferedDC);
}

MaxBufferedDC::MaxBufferedDC(wxDC * dc, int w, int h, int style)
	: bufferedDC(dc, wxSize(w, h), style)
{
	MaxDC::init(&bufferedDC);
}

MaxBufferedDC::MaxBufferedDC(wxDC * dc, wxBitmap& buffer, int style)
	: bufferedDC(dc, buffer, style)
{
	MaxDC::init(&bufferedDC);
}

wxBufferedDC * MaxBufferedDC::BufferedDC() {
	return &bufferedDC;
}


// *********************************************

MaxBufferedDC * bmx_wxbuffereddc_create() {
	return new MaxBufferedDC();
}

MaxBufferedDC * bmx_wxbuffereddc_createwitharea(MaxDC * dc, int w, int h, int style) {
	MaxBufferedDC * m;
	
	if (dc) {
		m = new MaxBufferedDC(dc->GetDC(), w, h, style);
	} else {
		m = new MaxBufferedDC(0, w, h, style);
	}
	
	return m;
}

MaxBufferedDC * bmx_wxbuffereddc_createwithbitmap(MaxDC * dc, MaxBitmap * buffer, int style) {
	MaxBufferedDC * m;
	
	if (dc) {
		if (buffer) {
			m = new MaxBufferedDC(dc->GetDC(), buffer->Bitmap(), style);
		} else {
			m = new MaxBufferedDC(dc->GetDC(), wxNullBitmap, style);
		}
	} else {
		if (buffer) {
			m = new MaxBufferedDC(0, buffer->Bitmap(), style);
		} else {
			m = new MaxBufferedDC(0, wxNullBitmap, style);
		}
	}
	
	return m;
}

void bmx_wxbuffereddc_initwitharea(MaxBufferedDC * buf, MaxDC * dc, int w, int h, int style) {
	buf->BufferedDC()->Init(dc->GetDC(), wxSize(w, h), style);
}

void bmx_wxbuffereddc_initwithbitmap(MaxBufferedDC * buf, MaxDC * dc, MaxBitmap * buffer, int style) {
	buf->BufferedDC()->Init(dc->GetDC(), buffer->Bitmap(), style);
}

void bmx_wxbuffereddc_delete(MaxBufferedDC * buf) {
	delete buf;
}


