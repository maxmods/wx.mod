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
#include "wxMozillaLikeAboutBoxDialog.h"
#include "../wxicon.mod/glue.h"

extern "C" {

#include <blitz.h>

	wxMozillaLikeAboutBoxDialog * bmx_wxmozillalikeaboutdialog_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * caption, int x, int y, int w, int h, long style);
	BBString * bmx_wxmozillalikeaboutdialog_getappname(wxMozillaLikeAboutBoxDialog * handle);
	void bmx_wxmozillalikeaboutdialog_setappname(wxMozillaLikeAboutBoxDialog * handle, BBString * value);
	BBString * bmx_wxmozillalikeaboutdialog_getversion(wxMozillaLikeAboutBoxDialog * handle);
	void bmx_wxmozillalikeaboutdialog_setversion(wxMozillaLikeAboutBoxDialog * handle, BBString * value);
	BBString * bmx_wxmozillalikeaboutdialog_getcopyright(wxMozillaLikeAboutBoxDialog * handle);
	void bmx_wxmozillalikeaboutdialog_setcopyright(wxMozillaLikeAboutBoxDialog * handle, BBString * value);
	BBString * bmx_wxmozillalikeaboutdialog_getcustombuildinfo(wxMozillaLikeAboutBoxDialog * handle);
	void bmx_wxmozillalikeaboutdialog_setcustombuildinfo(wxMozillaLikeAboutBoxDialog * handle, BBString * value);
	MaxBitmap * bmx_wxmozillalikeaboutdialog_getbitmapresource(wxMozillaLikeAboutBoxDialog * handle, BBString * name);
	MaxIcon * bmx_wxmozillalikeaboutdialog_geticonresource(wxMozillaLikeAboutBoxDialog * handle, BBString * name);
	BBString * bmx_wxmozillalikeaboutdialog_getbuildinfo(wxMozillaLikeAboutBoxDialog::wxBuildInfoFormat format);
	void bmx_wxmozillalikeaboutdialog_setheaderbitmap(wxMozillaLikeAboutBoxDialog * handle, MaxBitmap * value);
	void bmx_wxmozillalikeaboutdialog_applyinfo(wxMozillaLikeAboutBoxDialog * handle);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

