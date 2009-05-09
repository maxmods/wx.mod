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



// *********************************************

wxTextDataObject * bmx_wxtextdataobject_create(BBString * text) {
	return new wxTextDataObject(wxStringFromBBString(text));
}

int bmx_wxtextdataobject_gettextlength(wxTextDataObject * obj) {
	return static_cast<int>(obj->GetTextLength());
}

BBString * bmx_wxtextdataobject_gettext(wxTextDataObject * obj) {
	return bbStringFromWxString(obj->GetText());
}

void bmx_wxtextdataobject_settext(wxTextDataObject * obj, BBString * text) {
	obj->SetText(wxStringFromBBString(text));
}

void bmx_wxtextdataobject_delete(wxTextDataObject * obj) {
	delete obj;
}


