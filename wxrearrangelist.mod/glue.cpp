/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxRearrangeList::MaxRearrangeList(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& items, const wxArrayInt& order, int x, int y, int w, int h, long style)
	: wxRearrangeList(parent, id, wxPoint(x, y), wxSize(w, h), order, items, style)
{
	wxbind(this, handle);
}

MaxRearrangeList::~MaxRearrangeList()
{
	wxunbind(this);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxRearrangeList, wxRearrangeList)
END_EVENT_TABLE()

wxRearrangeList * bmx_wxrearrangelist_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBArray * items, BBArray * order, int x, int y, int w, int h, long style) {
	return new MaxRearrangeList(handle, parent, id, bbStringArrayTowxArrayStr(items), bbIntArrayTowxArrayInt(order), x, y, w, h, style);
}

BBArray * bmx_wxrearrangelist_getcurrentorder(wxRearrangeList * list) {
	return wxArrayIntToBBIntArray(list->GetCurrentOrder());
}

int bmx_wxrearrangelist_canmovecurrentup(wxRearrangeList * list) {
	return static_cast<int>(list->CanMoveCurrentUp());
}

int bmx_wxrearrangelist_canmovecurrentdown(wxRearrangeList * list) {
	return static_cast<int>(list->CanMoveCurrentDown());
}

int bmx_wxrearrangelist_movecurrentup(wxRearrangeList * list) {
	return static_cast<int>(list->MoveCurrentUp());
}

int bmx_wxrearrangelist_movecurrentdown(wxRearrangeList * list) {
	return static_cast<int>(list->MoveCurrentDown());
}


