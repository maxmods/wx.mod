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



// *********************************************


wxPathFormat bmx_wxarchiveentry_getinternalformat(wxArchiveEntry * entry) {
	return entry->GetInternalFormat();
}

BBString * bmx_wxarchiveentry_getinternalname(wxArchiveEntry * entry) {
	return bbStringFromWxString(entry->GetInternalName());
}

BBString * bmx_wxarchiveentry_getname(wxArchiveEntry * entry, wxPathFormat format) {
	return bbStringFromWxString(entry->GetName(format));
}

int bmx_wxarchiveentry_getoffset(wxArchiveEntry * entry) {
	return static_cast<int>(entry->GetOffset());
}

int bmx_wxarchiveentry_getsize(wxArchiveEntry * entry) {
	return static_cast<int>(entry->GetSize());
}

int bmx_wxarchiveentry_isdir(wxArchiveEntry * entry) {
	return static_cast<int>(entry->IsDir());
}

int bmx_wxarchiveentry_isreadonly(wxArchiveEntry * entry) {
	return static_cast<int>(entry->IsReadOnly());
}

// **************************

int bmx_wxarchiveinputstream_closeentry(wxArchiveInputStream * stream) {
	return static_cast<int>(stream->CloseEntry());
}

wxArchiveEntry * bmx_wxarchiveinputstream_getnextentry(wxArchiveInputStream * stream) {
	return stream->GetNextEntry();
}

int bmx_wxarchiveinputstream_openentry(wxArchiveInputStream * stream, wxArchiveEntry * entry) {
	return static_cast<int>(stream->OpenEntry(*entry));
}


