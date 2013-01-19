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
#include "wx/filesys.h"
#include "../wxfilename.mod/glue.h"

extern "C" {

#include <blitz.h>

	wxFileSystem * bmx_wxfilesystem_create();
	void bmx_wxfilesystem_delete(wxFileSystem * fs);
	void bmx_wxfilesystem_addhandler(wxFileSystemHandler * handler);
	int bmx_wxfilesystem_hashandlerforpath(BBString * location);
	void bmx_wxfilesystem_changepathto(wxFileSystem * fs, BBString * location, int isDir);
	BBString * bmx_wxfilesystem_getpath(wxFileSystem * fs);
	BBString * bmx_wxfilesystem_filenametourl(MaxFileName * filename);
	BBString * bmx_wxfilesystem_findfileinpath(wxFileSystem * fs, BBString * path, BBString * file);
	BBString * bmx_wxfilesystem_findfirst(wxFileSystem * fs, BBString * wildcard, int flags);
	BBString * bmx_wxfilesystem_findnext(wxFileSystem * fs);
	MaxFileName * bmx_wxfilesystem_urltofilename(BBString * url);
	wxFSFile * bmx_wxfilesystem_openfile(wxFileSystem * fs, BBString * location, int flags);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

