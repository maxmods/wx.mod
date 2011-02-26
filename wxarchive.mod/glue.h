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
#include "wx/archive.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	wxPathFormat bmx_wxarchiveentry_getinternalformat(wxArchiveEntry * entry);
	BBString * bmx_wxarchiveentry_getinternalname(wxArchiveEntry * entry);
	BBString * bmx_wxarchiveentry_getname(wxArchiveEntry * entry, wxPathFormat format);
	int bmx_wxarchiveentry_getoffset(wxArchiveEntry * entry);
	int bmx_wxarchiveentry_getsize(wxArchiveEntry * entry);
	int bmx_wxarchiveentry_isdir(wxArchiveEntry * entry);
	int bmx_wxarchiveentry_isreadonly(wxArchiveEntry * entry);
	
	int bmx_wxarchiveinputstream_closeentry(wxArchiveInputStream * stream);
	wxArchiveEntry * bmx_wxarchiveinputstream_getnextentry(wxArchiveInputStream * stream);
	int bmx_wxarchiveinputstream_openentry(wxArchiveInputStream * stream, wxArchiveEntry * entry);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

