/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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
#include <wx/aboutdlg.h>

extern "C" {

#include <blitz.h>
	
	wxAboutDialogInfo * bmx_wxaboutdialoginfo_create();
	void bmx_wxaboutdialoginfo_delete(wxAboutDialogInfo * info);
	void bmx_wxaboutbox(wxAboutDialogInfo * info);

	void bmx_wxaboutdialoginfo_addartist(wxAboutDialogInfo * info, BBString * name);
	void bmx_wxaboutdialoginfo_adddeveloper(wxAboutDialogInfo * info, BBString * name);
	void bmx_wxaboutdialoginfo_adddocwriter(wxAboutDialogInfo * info, BBString * name);
	void bmx_wxaboutdialoginfo_addtranslator(wxAboutDialogInfo * info, BBString * name);
	void bmx_wxaboutdialoginfo_setcopyright(wxAboutDialogInfo * info, BBString * copyright);
	void bmx_wxaboutdialoginfo_setdescription(wxAboutDialogInfo * info, BBString * desc);
	void bmx_wxaboutdialoginfo_setname(wxAboutDialogInfo * info, BBString * name);
	void bmx_wxaboutdialoginfo_setversion(wxAboutDialogInfo * info, BBString * version);
	void bmx_wxaboutdialoginfo_setwebsite(wxAboutDialogInfo * info, BBString * url, BBString * desc);

}


