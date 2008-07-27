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
#include "wx/treebook.h"

class MaxTreebook;

extern "C" {

#include <blitz.h>

	wxTreebook * bmx_wxtreebook_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	bool bmx_wxtreebook_addpage(wxTreebook * book, wxWindow * page, BBString * text, bool selected, int imageId);
	bool bmx_wxtreebook_addsubpage(wxTreebook * book, wxWindow * page, BBString * text, bool selected, int imageId);
	bool bmx_wxtreebook_insertpage(wxTreebook * book, int index, wxWindow * page, BBString * text, bool selected, int imageId);
	bool bmx_wxtreebook_insertsubpage(wxTreebook * book, int index, wxWindow * page, BBString * text, bool selected, int imageId);
	bool bmx_wxtreebook_collapsenode(wxTreebook * book, int pageId);
	bool bmx_wxtreebook_expandnode(wxTreebook * book, int pageId, bool expand);
	bool bmx_wxtreebook_isnodeexpanded(wxTreebook * book, int pos);
	int bmx_wxtreebook_getpageparent(wxTreebook * book, int pos);
	wxTreeCtrl * bmx_wxtreebook_gettreectrl(wxTreebook * book);

	int bmx_wxtreebook_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTreebook : public wxTreebook
{
public:
	MaxTreebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxTreebook();
};
