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

MaxTextValidator::MaxTextValidator()
{
}

MaxTextValidator::MaxTextValidator(const wxTextValidator & v)
{
	validator.Copy(v);
}

wxTextValidator & MaxTextValidator::Validator() {
	return validator;
}


// *********************************************

MaxTextValidator * bmx_wxtextvalidator_create(long style) {
	wxTextValidator v(style);
	return new MaxTextValidator(v);
}

wxWindow * bmx_wxtextvalidator_getwindow(MaxTextValidator * validator) {
	return validator->Validator().GetWindow();
}

void bmx_wxtextvalidator_setwindow(MaxTextValidator * validator, wxWindow * window) {
	validator->Validator().SetWindow(window);
}

BBArray * bmx_wxtextvalidator_getexcludes(MaxTextValidator * validator) {
	return wxArrayStringToBBStringArray(validator->Validator().GetExcludes());
}

BBArray *bmx_wxtextvalidator_getincludes(MaxTextValidator * validator) {
	return wxArrayStringToBBStringArray(validator->Validator().GetIncludes());
}

long bmx_wxtextvalidator_getstyle(MaxTextValidator * validator) {
	return validator->Validator().GetStyle();
}

void bmx_wxtextvalidator_setexcludes(MaxTextValidator * validator, BBArray * list) {
	validator->Validator().SetExcludes(bbStringArrayTowxArrayStr(list));
}

void bmx_wxtextvalidator_setincludes(MaxTextValidator * validator, BBArray * list) {
	validator->Validator().SetIncludes(bbStringArrayTowxArrayStr(list));
}

void bmx_wxtextvalidator_setstyle(MaxTextValidator * validator, long style) {
	validator->Validator().SetStyle(style);
}

void bmx_wxtextvalidator_delete(MaxTextValidator * validator) {
	delete validator;
}


