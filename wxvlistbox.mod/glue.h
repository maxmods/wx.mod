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

#include "wxglue.h"
#include "wx/vlbox.h"

class MaxVListBox;

extern "C" {

#include <blitz.h>

	wxVListBox * bmx_wxvlistbox_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	void bmx_wxvlistbox_clear(wxVListBox * listbox);
	int bmx_wxvlistbox_deselectall(wxVListBox * listbox);
	int bmx_wxvlistbox_getfirstselected(wxVListBox * listbox, unsigned long * cookie);
	int bmx_wxvlistbox_getitemcount(wxVListBox * listbox);
	void bmx_wxvlistbox_getmargins(wxVListBox * listbox, int * x, int * y);
	void bmx_wxvlistbox_getitemrect(wxVListBox * listbox, int item, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxvlistbox_getitemrectrect(wxVListBox * listbox, int item);
	int bmx_wxvlistbox_getnextselected(wxVListBox * listbox, unsigned long * cookie);
	int bmx_wxvlistbox_getselectedcount(wxVListBox * listbox);
	int bmx_wxvlistbox_getselection(wxVListBox * listbox);
	MaxColour * bmx_wxvlistbox_getselectionbackground(wxVListBox * listbox);
	int bmx_wxvlistbox_hasmultipleselection(wxVListBox * listbox);
	int bmx_wxvlistbox_iscurrent(wxVListBox * listbox, int item);
	int bmx_wxvlistbox_isselected(wxVListBox * listbox, int item);
	int bmx_wxvlistbox_selectitem(wxVListBox * listbox, int item);
	int bmx_wxvlistbox_selectall(wxVListBox * listbox);
	int bmx_wxvlistbox_selectrange(wxVListBox * listbox, int rangeFrom, int rangeTo);
	void bmx_wxvlistbox_setitemcount(wxVListBox * listbox, int count);
	void bmx_wxvlistbox_setselection(wxVListBox * listbox, int selection);
	void bmx_wxvlistbox_setselectionbackground(wxVListBox * listbox, MaxColour * col);
	void bmx_wxvlistbox_toggle(wxVListBox * listbox, int item);
	void bmx_wxvlistbox_setmargins(wxVListBox * listbox, int x, int y);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxVListBox : public wxVListBox
{
public:
	MaxVListBox(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxVListBox();
	
	virtual void OnDrawItem(wxDC &dc, const wxRect &rect, size_t n) const;
	virtual wxCoord OnMeasureItem (size_t n) const;
	
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};
