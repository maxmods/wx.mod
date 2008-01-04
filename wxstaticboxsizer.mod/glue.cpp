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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxStaticBoxSizer::MaxStaticBoxSizer(BBObject * handle, int orient, wxWindow * parent, const wxString& label)
	: maxHandle(handle), wxStaticBoxSizer(orient, parent, label)
{
	wxbind(this, handle);
}

MaxStaticBoxSizer::MaxStaticBoxSizer(BBObject * handle, wxStaticBox * box, int orient)
	: maxHandle(handle), wxStaticBoxSizer(box, orient)
{
	wxbind(this, handle);
}

MaxStaticBoxSizer::~MaxStaticBoxSizer() {
	wxunbind(this);
}


// *********************************************

MaxStaticBoxSizer * bmx_wxstaticboxsizer_createsizer(BBObject * handle, int orient, wxWindow * parent, BBString * label) {
	return new MaxStaticBoxSizer(handle, orient, parent, wxStringFromBBString(label));
}

MaxStaticBoxSizer * bmx_wxstaticboxsizer_createsizerwithbox(BBObject * handle, wxStaticBox * box, int orient) {
	return new MaxStaticBoxSizer(handle, box, orient);
}

wxStaticBox * bmx_wxstaticboxsizer_getstaticbox(wxStaticBoxSizer * sizer) {
	return sizer->GetStaticBox();
}

