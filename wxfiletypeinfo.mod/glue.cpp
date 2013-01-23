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

MaxFileTypeInfo::MaxFileTypeInfo()
	: fileTypeInfo()
{
}

MaxFileTypeInfo::MaxFileTypeInfo(wxFileTypeInfo & fti)
	: fileTypeInfo(fti)
{
}

wxFileTypeInfo & MaxFileTypeInfo::FileTypeInfo() {
	return fileTypeInfo;
}


// *********************************************

MaxFileTypeInfo * bmx_wxfiletypeinfo_create(BBString * mimeType) {
	wxFileTypeInfo f(wxStringFromBBString(mimeType));
	return new MaxFileTypeInfo(f);
}

void bmx_wxfiletypeinfo_addextension(MaxFileTypeInfo * info, BBString * ext) {
	info->FileTypeInfo().AddExtension(wxStringFromBBString(ext));
}

void bmx_wxfiletypeinfo_setdescription(MaxFileTypeInfo * info, BBString * description) {
	info->FileTypeInfo().SetDescription(wxStringFromBBString(description));
}

void bmx_wxfiletypeinfo_setopencommand(MaxFileTypeInfo * info, BBString * command) {
	info->FileTypeInfo().SetOpenCommand(wxStringFromBBString(command));
}

void bmx_wxfiletypeinfo_setprintcommand(MaxFileTypeInfo * info, BBString * command) {
	info->FileTypeInfo().SetPrintCommand(wxStringFromBBString(command));
}

void bmx_wxfiletypeinfo_setshortdesc(MaxFileTypeInfo * info, BBString * shortDesc) {
	info->FileTypeInfo().SetShortDesc(wxStringFromBBString(shortDesc));
}

void bmx_wxfiletypeinfo_seticon(MaxFileTypeInfo * info, BBString * iconFile, int iconIndex) {
	info->FileTypeInfo().SetIcon(wxStringFromBBString(iconFile), iconIndex);
}

BBString *  bmx_wxfiletypeinfo_getmimetype(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetMimeType());
}

BBString * bmx_wxfiletypeinfo_getopencommand(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetOpenCommand());
}

BBString * bmx_wxfiletypeinfo_getprintcommand(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetPrintCommand());
}

BBString * bmx_wxfiletypeinfo_getshortdesc(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetShortDesc());
}

BBString * bmx_wxfiletypeinfo_getdescription(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetDescription());
}

BBArray * bmx_wxfiletypeinfo_getextensions(MaxFileTypeInfo * info) {
	return wxArrayStringToBBStringArray(info->FileTypeInfo().GetExtensions());
}

int bmx_wxfiletypeinfo_getextensionscount(MaxFileTypeInfo * info) {
	return static_cast<int>(info->FileTypeInfo().GetExtensionsCount());
}

BBString * bmx_wxfiletypeinfo_geticonfile(MaxFileTypeInfo * info) {
	return bbStringFromWxString(info->FileTypeInfo().GetIconFile());
}

int bmx_wxfiletypeinfo_geticonindex(MaxFileTypeInfo * info) {
	return info->FileTypeInfo().GetIconIndex();
}

void bmx_wxfiletypeinfo_delete(MaxFileTypeInfo * info) {
	delete info;
}


