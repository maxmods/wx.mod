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

BEGIN_EVENT_TABLE(MaxMiniFrame, wxMiniFrame)
END_EVENT_TABLE()


MaxMiniFrame::MaxMiniFrame(void * handle, wxWindow* parent, wxWindowID id, const wxString& title, int x,
		int y, int w, int h, long style)
       : wxMiniFrame(parent, id, title, wxPoint(x, y), wxSize(w,h), style)
{
}

MaxStatusBar * MaxMiniFrame::OnCreateStatusBar(int number, long style, wxWindowID id, const wxString& name) {
	MaxStatusBar * statusbar = new MaxStatusBar(this, style, id, name);
	statusbar->SetFieldsCount(number);
	return statusbar;
}


// *********************************************


MaxMiniFrame * bmx_wxminiframe_create(void * maxHandle, wxWindow* parent, wxWindowID id, BBString * title, int x,
		int y, int w, int h, long style) {
		
	return new MaxMiniFrame(maxHandle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
}

