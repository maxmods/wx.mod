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

#include "wxglue.h"
#include "wx/zipstrm.h"
#include "../wxdatetime.mod/glue.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	BBString * bmx_wxzipentry_getcomment(wxZipEntry * entry);
	int bmx_wxzipentry_getcompressedsize(wxZipEntry * entry);
	unsigned int bmx_wxzipentry_getcrc(wxZipEntry * entry);
	MaxDateTime * bmx_wxzipentry_getdatetime(wxZipEntry * entry);
	const char * bmx_wxzipentry_getextra(wxZipEntry * entry);
	int bmx_wxzipentry_getextralen(wxZipEntry * entry);
	unsigned int bmx_wxzipentry_getexternalattributes(wxZipEntry * entry);
	int bmx_wxzipentry_getflags(wxZipEntry * entry);
	wxPathFormat bmx_wxzipentry_getinternalformat(wxZipEntry * entry);
	BBString * bmx_wxzipentry_getinternalname(wxZipEntry * entry);
	const char * bmx_wxzipentry_getlocalextra(wxZipEntry * entry);
	int bmx_wxzipentry_getlocalextralen(wxZipEntry * entry);
	int bmx_wxzipentry_getmethod(wxZipEntry * entry);
	int bmx_wxzipentry_getmode(wxZipEntry * entry);
	BBString * bmx_wxzipentry_getname(wxZipEntry * entry, wxPathFormat format);
	bool bmx_wxzipentry_ismadebyunix(wxZipEntry * entry);
	bool bmx_wxzipentry_istext(wxZipEntry * entry);
	void bmx_wxzipentry_setname(wxZipEntry * entry, BBString * name, wxPathFormat format);
	int bmx_wxzipentry_getoffset(wxZipEntry * entry);
	int bmx_wxzipentry_getsize(wxZipEntry * entry);
	int bmx_wxzipentry_getsystemmadeby(wxZipEntry * entry);
	void bmx_wxzipentry_setcomment(wxZipEntry * entry, BBString * comment);
	void bmx_wxzipentry_setextra(wxZipEntry * entry, const char * extra, int length);
	void bmx_wxzipentry_setexternalattributes(wxZipEntry * entry, unsigned int attr);
	void bmx_wxzipentry_setistext(wxZipEntry * entry, bool text);
	void bmx_wxzipentry_setlocalextra(wxZipEntry * entry, const char * extra, int length);
	void bmx_wxzipentry_setmethod(wxZipEntry * entry, int meth);
	void bmx_wxzipentry_setmode(wxZipEntry * entry, int mode);
	void bmx_wxzipentry_setsize(wxZipEntry * entry, int size);
	void bmx_wxzipentry_setsystemmadeby(wxZipEntry * entry, int system);
	bool bmx_wxzipentry_isdir(wxZipEntry * entry);
	void bmx_wxzipentry_setisdir(wxZipEntry * entry, bool dir);
	bool bmx_wxzipentry_isreadonly(wxZipEntry * entry);
	void bmx_wxzipentry_setisreadonly(wxZipEntry * entry, bool readOnly);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

