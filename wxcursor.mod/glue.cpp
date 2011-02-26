/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxCursor::MaxCursor()
	: cursor(wxNullCursor)
{
}

MaxCursor::MaxCursor(const wxCursor& c)
{
	cursor = wxCursor(c);
}

wxCursor & MaxCursor::Cursor() {
	return cursor;
}


// *********************************************

MaxCursor * bmx_wxcursor_stockcreate(int id) {
	wxCursor c(id);
	return new MaxCursor(c);
}

MaxCursor * bmx_wxcursor_createfromimage(MaxImage * image) {
	wxCursor c(image->Image());
	return new MaxCursor(c);
}

int bmx_wxcursor_isok(MaxCursor * cursor) {
	return static_cast<int>(cursor->Cursor().IsOk());
}

MaxCursor * bmx_wxstockgdi_cursor_cross() {
	wxCursor c(*wxCROSS_CURSOR);
	return new MaxCursor(c);
}

MaxCursor * bmx_wxstockgdi_cursor_hourglass() {
	wxCursor c(*wxHOURGLASS_CURSOR);
	return new MaxCursor(c);
}

MaxCursor * bmx_wxstockgdi_cursor_standard() {
	wxCursor c(*wxSTANDARD_CURSOR);
	return new MaxCursor(c);
}

void bmx_wxcursor_delete(MaxCursor * cursor) {
	delete cursor;
}


void bmx_wxsetcursor(MaxCursor * cursor) {
	if (cursor) {
		wxSetCursor(cursor->Cursor());
	} else {
		wxSetCursor(wxNullCursor);
	}
}
