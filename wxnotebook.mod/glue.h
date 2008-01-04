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
#include <wx/notebook.h>
#include "wx/imaglist.h"

class MaxNotebook;

extern "C" {

#include <blitz.h>

	MaxNotebook * bmx_wxnotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	bool bmx_wxnotebook_addpage(wxNotebook * notebook, wxWindow * page, BBString * text, bool selected, int imageId);
	bool bmx_wxnotebook_insertpage(wxNotebook * notebook, int index, wxWindow * page, BBString * text, bool selected, int imageId);
	void bmx_wxnotebook_advanceselection(wxNotebook * notebook, bool forward);

	void bmx_wxnotebook_assignimagelist(wxNotebook * notebook, wxImageList * list);
	void bmx_wxnotebook_setimagelist(wxNotebook * notebook, wxImageList * list);

	bool bmx_wxnotebook_deleteallpages(wxNotebook * notebook);
	bool bmx_wxnotebook_deletepage(wxNotebook * notebook, int page);
	wxWindow *  bmx_wxnotebook_getcurrentpage(wxNotebook * notebook);
	wxWindow * bmx_wxnotebook_getpage(wxNotebook * notebook, int page);
	int bmx_wxnotebook_getpagecount(wxNotebook * notebook);
	int bmx_wxnotebook_getpageimage(wxNotebook * notebook, int page);
	BBString * bmx_wxnotebook_getpagetext(wxNotebook * notebook, int page);
	int bmx_wxnotebook_getrowcount(wxNotebook * notebook);
	int bmx_wxnotebook_getselection(wxNotebook * notebook);
	MaxColour * bmx_wxnotebook_getthemebackgroundcolour(wxNotebook * notebook);
	int bmx_wxnotebook_hittest(wxNotebook * notebook, int x, int y, long * flags);
	bool bmx_wxnotebook_removepage(wxNotebook * notebook, int page);
	void bmx_wxnotebook_setpadding(wxNotebook * notebook, int width, int height);
	void bmx_wxnotebook_setpagesize(wxNotebook * notebook, int width, int height);
	bool bmx_wxnotebook_setpageimage(wxNotebook * notebook, int page, int image);
	bool bmx_wxnotebook_setpagetext(wxNotebook * notebook, int page, BBString * text);
	int bmx_wxnotebook_setselection(wxNotebook * notebook, int page);
	int bmx_wxnotebook_changeselection(wxNotebook * notebook, int page);

	int bmx_wxnotebookevent_getoldselection(wxNotebookEvent & event);
	int bmx_wxnotebookevent_getselection(wxNotebookEvent & event);
	void bmx_wxnotebookevent_setoldselection(wxNotebookEvent & event, int page);
	void bmx_wxnotebookevent_setselection(wxNotebookEvent & event, int page);

	int bmx_wxnotebook_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxNotebook : public wxNotebook
{
public:
	MaxNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxNotebook();
};

