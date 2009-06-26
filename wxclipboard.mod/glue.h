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

#include "wxglue.h"
#include "wx/clipbrd.h"


extern "C" {

#include <blitz.h>

	wxClipboard * bmx_wxclipboard_get();
	void bmx_wxclipboard_clear(wxClipboard * clip);
	void bmx_wxclipboard_close(wxClipboard * clip);
	int bmx_wxclipboard_flush(wxClipboard * clip);
	int bmx_wxclipboard_open(wxClipboard * clip);
	int bmx_wxclipboard_adddata(wxClipboard * clip, wxDataObject * data);
	int bmx_wxclipboard_getdata(wxClipboard * clip, wxDataObject * data);
	int bmx_wxclipboard_setdata(wxClipboard * clip, wxDataObject * data);
	int bmx_wxclipboard_isopened(wxClipboard * clip);

#ifdef __WXGTK__
	void bmx_wxclipboard_useprimaryselection(wxClipboard * clip, int primary);
#endif

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

