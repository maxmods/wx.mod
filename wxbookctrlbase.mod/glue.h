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
#include "wx/bookctrl.h"
#include "wx/imaglist.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	int bmx_wxbookctrlbase_addpage(wxBookCtrlBase * book, wxWindow * page, BBString * text, int selected, int imageId);
	int bmx_wxbookctrlbase_insertpage(wxBookCtrlBase * book, int index, wxWindow * page, BBString * text, int selected, int imageId);
	void bmx_wxbookctrlbase_advanceselection(wxBookCtrlBase * book, int forward);

	void bmx_wxbookctrlbase_assignimagelist(wxBookCtrlBase * book, wxImageList * list);
	void bmx_wxbookctrlbase_setimagelist(wxBookCtrlBase * book, wxImageList * list);

	int bmx_wxbookctrlbase_deleteallpages(wxBookCtrlBase * book);
	int bmx_wxbookctrlbase_deletepage(wxBookCtrlBase * book, int page);
	wxWindow *  bmx_wxbookctrlbase_getcurrentpage(wxBookCtrlBase * book);
	wxWindow * bmx_wxbookctrlbase_getpage(wxBookCtrlBase * book, int page);
	int bmx_wxbookctrlbase_getpagecount(wxBookCtrlBase * book);
	int bmx_wxbookctrlbase_getpageimage(wxBookCtrlBase * book, int page);
	BBString * bmx_wxbookctrlbase_getpagetext(wxBookCtrlBase * book, int page);
	int bmx_wxbookctrlbase_getselection(wxBookCtrlBase * book);
	int bmx_wxbookctrlbase_hittest(wxBookCtrlBase * book, int x, int y, long * flags);
	int bmx_wxbookctrlbase_removepage(wxBookCtrlBase * book, int page);
	void bmx_wxbookctrlbase_setpagesize(wxBookCtrlBase * book, int width, int height);
	int bmx_wxbookctrlbase_setpageimage(wxBookCtrlBase * book, int page, int image);
	int bmx_wxbookctrlbase_setpagetext(wxBookCtrlBase * book, int page, BBString * text);
	int bmx_wxbookctrlbase_setselection(wxBookCtrlBase * book, int page);
	int bmx_wxbookctrlbase_changeselection(wxBookCtrlBase * book, int page);

	int bmx_wxbookctrlevent_getoldselection(wxNotebookEvent & event);
	int bmx_wxbookctrlevent_getselection(wxNotebookEvent & event);
	void bmx_wxbookctrlevent_setoldselection(wxNotebookEvent & event, int page);
	void bmx_wxbookctrlevent_setselection(wxNotebookEvent & event, int page);

	int bmx_wxbookctrlbase_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

