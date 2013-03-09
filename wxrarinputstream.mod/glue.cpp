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



// *********************************************

wxRarInputStream * bmx_wxrarinputstream_create(BBString * filename) {
	return new wxRarInputStream(wxStringFromBBString(filename));
}

int bmx_wxrarinputstream_opennextfile(wxRarInputStream * stream) {
	return static_cast<int>(stream->OpenNextFile());
}

int bmx_wxrarinputstream_extractfile(wxRarInputStream * stream, BBString * destPath, BBString * destName) {
	char *p = bbStringToCString( destPath );
	char *n;
	bool ret;
	
	if (destName != &bbEmptyString) {
		n = bbStringToCString( destName );
	}
	
	if (n) {
		ret = stream->ExtractFile(p, n);
	} else {
		ret = stream->ExtractFile(p, NULL);
	}
	
	bbMemFree(p);
	if (n) bbMemFree(n);
	
	return static_cast<int>(ret);
}

wxRarFileInfo * bmx_wxrarinputstream_getfileinfo(wxRarInputStream * stream) {
	wxRarFileInfo * info = new wxRarFileInfo;
	stream->GetFileInfo(*info);
	return info;
}

void bmx_wxrarinputstream_close(wxRarInputStream * stream) {
	delete stream;
}

// *********************************************

void bmx_wxrarfileinfo_delete(wxRarFileInfo * info) {
	delete info;
}

BBString * bmx_wxrarfileinfo_getname(wxRarFileInfo * info) {
	return bbStringFromWxString(info->szName);
}

BBString * bmx_wxrarfileinfo_getcomment(wxRarFileInfo * info) {
	return bbStringFromCString(info->szComment);
}

wxUint32 bmx_wxrarfileinfo_getuncompressedsize(wxRarFileInfo * info) {
	return info->dwUncompressedSize;
}

wxUint32 bmx_wxrarfileinfo_getcompressedsize(wxRarFileInfo * info) {
	return info->dwCompressedSize;
}

wxUint32 bmx_wxrarfileinfo_getfiletime(wxRarFileInfo * info) {
	return info->dwTime;
}


