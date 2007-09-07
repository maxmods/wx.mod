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

class MaxCheckListBox;

extern "C" {

#include <blitz.h>

	MaxCheckListBox * bmx_wxchecklistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style);
	void bmx_wxchecklistbox_check(MaxCheckListBox * listbox, int item, bool check);
	bool bmx_wxchecklistbox_ischecked(MaxCheckListBox * listbox, int item);
	int bmx_wxchecklistbox_append(MaxCheckListBox * listbox, BBString * item);
	

	int bmx_wxchecklistbox_geteventtype(int type);
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxCheckListBox : public wxCheckListBox
{
public:
	MaxCheckListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style);
	~MaxCheckListBox();
};


