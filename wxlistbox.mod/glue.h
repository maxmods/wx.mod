/*
  Copyright (c) 2007 Bruce A Henderson
 
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

class MaxListBox;

extern "C" {

#include <blitz.h>

	MaxListBox * bmx_wxlistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style);
	void bmx_wxlistbox_insertitems(MaxListBox * listbox, BBArray * items, int pos);
	BBArray * bmx_wxlistbox_getselections(MaxListBox * listbox);
	
	bool bmx_wxlistbox_isselected(MaxListBox * listbox, int item);
	void bmx_wxlistbox_deselect(MaxListBox * listbox, int item);
	int bmx_wxlistbox_hittest(MaxListBox * listbox, int x, int y);
	void bmx_wxlistbox_setfirstitem(MaxListBox * listbox, int item);
	void bmx_wxlistbox_setfirstitemstr(MaxListBox * listbox, BBString * item);

	int bmx_wxlistbox_geteventtype(int type);
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxListBox : public wxListBox
{
public:
	MaxListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style);
	~MaxListBox();

private:
	BBObject * maxHandle;

};


