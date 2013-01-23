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

#ifndef _WX_MAX_FILETYPEINFO_H_
#define _WX_MAX_FILETYPEINFO_H_

#include "wxglue.h"
#include <wx/mimetype.h>

class MaxFileTypeInfo;

extern "C" {

#include <blitz.h>

	MaxFileTypeInfo * bmx_wxfiletypeinfo_create(BBString * mimeType);
	void bmx_wxfiletypeinfo_addextension(MaxFileTypeInfo * info, BBString * ext);
	void bmx_wxfiletypeinfo_setdescription(MaxFileTypeInfo * info, BBString * description);
	void bmx_wxfiletypeinfo_setopencommand(MaxFileTypeInfo * info, BBString * command);
	void bmx_wxfiletypeinfo_setprintcommand(MaxFileTypeInfo * info, BBString * command);
	void bmx_wxfiletypeinfo_setshortdesc(MaxFileTypeInfo * info, BBString * shortDesc);
	void bmx_wxfiletypeinfo_seticon(MaxFileTypeInfo * info, BBString * iconFile, int iconIndex);
	BBString *  bmx_wxfiletypeinfo_getmimetype(MaxFileTypeInfo * info);
	BBString * bmx_wxfiletypeinfo_getopencommand(MaxFileTypeInfo * info);
	BBString * bmx_wxfiletypeinfo_getprintcommand(MaxFileTypeInfo * info);
	BBString * bmx_wxfiletypeinfo_getshortdesc(MaxFileTypeInfo * info);
	BBString * bmx_wxfiletypeinfo_getdescription(MaxFileTypeInfo * info);
	BBArray * bmx_wxfiletypeinfo_getextensions(MaxFileTypeInfo * info);
	int bmx_wxfiletypeinfo_getextensionscount(MaxFileTypeInfo * info);
	BBString * bmx_wxfiletypeinfo_geticonfile(MaxFileTypeInfo * info);
	int bmx_wxfiletypeinfo_geticonindex(MaxFileTypeInfo * info);
	void bmx_wxfiletypeinfo_delete(MaxFileTypeInfo * info);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileTypeInfo
{
public:
	MaxFileTypeInfo();
	MaxFileTypeInfo(wxFileTypeInfo & fileTypeInfo);
	wxFileTypeInfo & FileTypeInfo();

private:
	wxFileTypeInfo fileTypeInfo;

};

#endif
