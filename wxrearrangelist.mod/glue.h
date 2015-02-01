/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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
#include <wx/rearrangectrl.h>

class MaxRearrangeList;

extern "C" {

#include <blitz.h>

	wxRearrangeList * bmx_wxrearrangelist_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBArray * items, BBArray * order, int x, int y, int w, int h, long style);
	BBArray * bmx_wxrearrangelist_getcurrentorder(wxRearrangeList * list);
	int bmx_wxrearrangelist_canmovecurrentup(wxRearrangeList * list);
	int bmx_wxrearrangelist_canmovecurrentdown(wxRearrangeList * list);
	int bmx_wxrearrangelist_movecurrentup(wxRearrangeList * list);
	int bmx_wxrearrangelist_movecurrentdown(wxRearrangeList * list);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRearrangeList : public wxRearrangeList
{
public:
	MaxRearrangeList(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& items, const wxArrayInt& order, int x, int y, int w, int h, long style);
	~MaxRearrangeList();

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};
