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

MaxJSONValue::MaxJSONValue()
{
	value = new wxJSONValue;
	owner = true;
}

MaxJSONValue::MaxJSONValue(wxJSONValue & v)
{
	value = new wxJSONValue(v);
	owner = true;
}

MaxJSONValue::MaxJSONValue(wxJSONValue * v)
{
	value = v;
}

wxJSONValue & MaxJSONValue::Value() {
	return *value;
}

MaxJSONValue::~MaxJSONValue() {
	if (owner) {
		delete value;
	}
}


// *********************************************

MaxJSONValue * bmx_wxjsonvalue_create() {
	return new MaxJSONValue();
}

MaxJSONValue * bmx_wxjsonvalue_createint(int value) {
	wxJSONValue v(value);
	return new MaxJSONValue(v);
}

int bmx_wxjsonvalue_asint(MaxJSONValue * val) {
	return val->Value().AsInt();
}

MaxJSONValue * bmx_wxjsonvalue_item(MaxJSONValue * val, BBString * name) {
	return new MaxJSONValue(&val->Value()[wxStringFromBBString(name)]);
}

MaxJSONValue * bmx_wxjsonvalue_itemat(MaxJSONValue * val, int index) {
	return new MaxJSONValue(&val->Value()[index]);
}

void bmx_wxjsonvalue_setstring(MaxJSONValue * val, BBString * value) {
	val->Value() = wxStringFromBBString(value);
}

void bmx_wxjsonvalue_delete(MaxJSONValue * val) {
	delete val;
}

// *********************************************

wxJSONWriter * bmx_wxjsonwriter_create(int style, int indent, int step) {
	return new wxJSONWriter(style, indent, step);
}

BBString * bmx_wxjsonwrite_writestring(wxJSONWriter * writer, MaxJSONValue * value) {
	wxString s;
	writer->Write(value->Value(), s);
	return bbStringFromWxString(s);
}

void bmx_wxjsonwriter_delete(wxJSONWriter * writer) {
	delete writer;
}


