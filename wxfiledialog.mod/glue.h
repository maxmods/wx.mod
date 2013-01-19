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

class MaxFileDialog;

extern "C" {

#include <blitz.h>

	BBString * bmx_wxfileselector(BBString * message, BBString * defaultPath, BBString * defaultFilename, 
		BBString * defaultExtension, BBString * wildcard, int flags, wxWindow * parent, int x, int y);

	MaxFileDialog * bmx_wxfiledialog_create(BBObject * handle, wxWindow * parent, BBString * message, BBString * defaultDir, BBString * defaultFile,
			BBString * wildcard, long style, int x, int y, int w, int h);
	BBString * bmx_wxfiledialog_getdirectory(wxFileDialog * file);
	BBString * bmx_wxfiledialog_getfilename(wxFileDialog * file);
	BBArray * bmx_wxfiledialog_getfilenames(wxFileDialog * file);
	int bmx_wxfiledialog_getfilterindex(wxFileDialog * file);
	BBString * bmx_wxfiledialog_getmessage(wxFileDialog * file);
	BBString * bmx_wxfiledialog_getpath(wxFileDialog * file);
	BBArray * bmx_wxfiledialog_getpaths(wxFileDialog * file);
	BBString * bmx_wxfiledialog_getwildcard(wxFileDialog * file);
	void bmx_wxfiledialog_setdirectory(wxFileDialog * file, BBString * directory);
	void bmx_wxfiledialog_setfilename(wxFileDialog * file, BBString * filename);
	void bmx_wxfiledialog_setfilterindex(wxFileDialog * file, int index);
	void bmx_wxfiledialog_setmessage(wxFileDialog * file, BBString * message);
	void bmx_wxfiledialog_setpath(wxFileDialog * file, BBString * path);
	void bmx_wxfiledialog_setwildcard(wxFileDialog * file, BBString * wildcard);
	int bmx_wxfiledialog_showmodal(wxFileDialog * file);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileDialog : public wxFileDialog
{
public:
	MaxFileDialog(BBObject * handle, wxWindow * parent, const wxString& message, const wxString& defaultDir,
		const wxString& defaultFile, const wxString& wildcard, long style, int x, int y, int w, int h);
	~ MaxFileDialog();
};

