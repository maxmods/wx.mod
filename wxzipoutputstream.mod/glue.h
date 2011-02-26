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

#include "wxglue.h"
#include "wx/zipstrm.h"
#include "../wxdatetime.mod/glue.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	wxZipOutputStream * bmx_wxzipoutputstream_create(wxOutputStream * s, int level);
	bool bmx_wxzipoutputstream_close(wxZipOutputStream * s);
	bool bmx_wxzipoutputstream_closeentry(wxZipOutputStream * s);
	int bmx_wxzipoutputstream_getlevel(wxZipOutputStream * s);
	void bmx_wxzipoutputstream_setlevel(wxZipOutputStream * s, int level);
	bool bmx_wxzipoutputstream_putnextdirentry(wxZipOutputStream * s, BBString * name, MaxDateTime * dt);
	bool bmx_wxzipoutputstream_putnextentry(wxZipOutputStream * s, BBString * name, MaxDateTime * dt);
	void bmx_wxzipoutputstream_setcomment(wxZipOutputStream * s, BBString * comment);
	void bmx_wxzipoutputstream_delete(wxZipOutputStream * s);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

