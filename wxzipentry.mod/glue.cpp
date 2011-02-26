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



// *********************************************


BBString * bmx_wxzipentry_getcomment(wxZipEntry * entry) {
	return bbStringFromWxString(entry->GetComment());
}

int bmx_wxzipentry_getcompressedsize(wxZipEntry * entry) {
	return static_cast<int>(entry->GetCompressedSize());
}

unsigned int bmx_wxzipentry_getcrc(wxZipEntry * entry) {
	return entry->GetCrc();
}

MaxDateTime * bmx_wxzipentry_getdatetime(wxZipEntry * entry) {
	return new MaxDateTime(entry->GetDateTime());
}

const char * bmx_wxzipentry_getextra(wxZipEntry * entry) {
	return entry->GetExtra();
}

int bmx_wxzipentry_getextralen(wxZipEntry * entry) {
	return static_cast<int>(entry->GetExtraLen());
}

unsigned int bmx_wxzipentry_getexternalattributes(wxZipEntry * entry) {
	return entry->GetExternalAttributes();
}

int bmx_wxzipentry_getflags(wxZipEntry * entry) {
	return entry->GetFlags();
}

wxPathFormat bmx_wxzipentry_getinternalformat(wxZipEntry * entry) {
	return entry->GetInternalFormat();
}

BBString * bmx_wxzipentry_getinternalname(wxZipEntry * entry) {
	return bbStringFromWxString(entry->GetInternalName());
}

const char * bmx_wxzipentry_getlocalextra(wxZipEntry * entry) {
	return entry->GetLocalExtra();
}

int bmx_wxzipentry_getlocalextralen(wxZipEntry * entry) {
	return static_cast<int>(entry->GetLocalExtraLen());
}

int bmx_wxzipentry_getmethod(wxZipEntry * entry) {
	return entry->GetMethod();
}

int bmx_wxzipentry_getmode(wxZipEntry * entry) {
	return entry->GetMode();
}

BBString * bmx_wxzipentry_getname(wxZipEntry * entry, wxPathFormat format) {
	return bbStringFromWxString(entry->GetName(format));
}

bool bmx_wxzipentry_ismadebyunix(wxZipEntry * entry) {
	return entry->IsMadeByUnix();
}

bool bmx_wxzipentry_istext(wxZipEntry * entry) {
	return entry->IsText();
}

void bmx_wxzipentry_setname(wxZipEntry * entry, BBString * name, wxPathFormat format) {
	entry->SetName(wxStringFromBBString(name), format);
}

int bmx_wxzipentry_getoffset(wxZipEntry * entry) {
	return static_cast<int>(entry->GetOffset());
}

int bmx_wxzipentry_getsize(wxZipEntry * entry) {
	return static_cast<int>(entry->GetSize());
}

int bmx_wxzipentry_getsystemmadeby(wxZipEntry * entry) {
	return entry->GetSystemMadeBy();
}

void bmx_wxzipentry_setcomment(wxZipEntry * entry, BBString * comment) {
	entry->SetComment(wxStringFromBBString(comment));
}

void bmx_wxzipentry_setextra(wxZipEntry * entry, const char * extra, int length) {
	entry->SetExtra(extra, static_cast<size_t>(length));
}

void bmx_wxzipentry_setexternalattributes(wxZipEntry * entry, unsigned int attr) {
	entry->SetExternalAttributes(attr);
}

void bmx_wxzipentry_setistext(wxZipEntry * entry, bool text) {
	entry->SetIsText(text);
}

void bmx_wxzipentry_setlocalextra(wxZipEntry * entry, const char * extra, int length) {
	entry->SetLocalExtra(extra, static_cast<size_t>(length));
}

void bmx_wxzipentry_setmethod(wxZipEntry * entry, int meth) {
	entry->SetMethod(meth);
}

void bmx_wxzipentry_setmode(wxZipEntry * entry, int mode) {
	entry->SetMode(mode);
}

void bmx_wxzipentry_setsize(wxZipEntry * entry, int size) {
	entry->SetSize(static_cast<off_t>(size));
}

void bmx_wxzipentry_setsystemmadeby(wxZipEntry * entry, int system) {
	entry->SetSystemMadeBy(system);
}

bool bmx_wxzipentry_isdir(wxZipEntry * entry) {
	return entry->IsDir();
}

void bmx_wxzipentry_setisdir(wxZipEntry * entry, bool dir) {
	entry->SetIsDir(dir);
}

bool bmx_wxzipentry_isreadonly(wxZipEntry * entry) {
	return entry->IsReadOnly();
}

void bmx_wxzipentry_setisreadonly(wxZipEntry * entry, bool readOnly) {
	entry->SetIsReadOnly(readOnly);
}


