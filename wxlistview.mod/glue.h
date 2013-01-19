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
#include "../wxlistctrl.mod/glue.h"

class MaxListView;

extern "C" {

#include <blitz.h>

	MaxListView * bmx_wxlistview_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, long style);
	void bmx_wxlistview_clearcolumnimage(wxListView * list, int col);
	void bmx_wxlistview_focus(wxListView * list, long index);
	long bmx_wxlistview_getfirstselected(wxListView * list);
	long bmx_wxlistview_getfocuseditem(wxListView * list);
	long bmx_wxlistview_getnextselected(wxListView * list, long item);
	bool bmx_wxlistview_isselected(wxListView * list, long index);
	void bmx_wxlistview_selectitem(wxListView * list, long item, bool on);
	void bmx_wxlistview_setcolumnimage(wxListView * list, int col, int image);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxListView : public wxListView
{
public:
	MaxListView(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxListView();

	virtual wxString OnGetItemText(long item, long column) const;
	virtual int OnGetItemColumnImage(long item, long column) const;
	virtual wxListItemAttr *OnGetItemAttr(long item) const;
	virtual int OnGetItemImage(long item) const;
	
private:
	BBObject * maxHandle;
	DECLARE_EVENT_TABLE()
};
