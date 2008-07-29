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

MaxJSONValue * bmx_wxjsonvalue_createlong(BBInt64 value) {
	wxJSONValue v(value);
	return new MaxJSONValue(v);
}

MaxJSONValue * bmx_wxjsonvalue_createbool(bool value) {
	wxJSONValue v(value);
	return new MaxJSONValue(v);
}

MaxJSONValue * bmx_wxjsonvalue_createdouble(double value) {
	wxJSONValue v(value);
	return new MaxJSONValue(v);
}

MaxJSONValue * bmx_wxjsonvalue_createstring(BBString * value) {
	wxJSONValue v(wxStringFromBBString(value));
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

bool bmx_wxjsonvalue_cat(MaxJSONValue * val, BBString * text) {
	return val->Value().Cat(wxStringFromBBString(text));
}

void bmx_wxjsonvalue_clear(MaxJSONValue * val) {
	val->Value().Clear();
}

void bmx_wxjsonvalue_clearcomments(MaxJSONValue * val) {
	val->Value().ClearComments();
}

BBString * bmx_wxjsonvalue_getcomment(MaxJSONValue * val, int index) {
	return bbStringFromWxString(val->Value().GetComment(index));
}

BBArray * bmx_wxjsonvalue_getcommentarray(MaxJSONValue * val) {
	return wxArrayStringToBBStringArray(val->Value().GetCommentArray());
}

int bmx_wxjsonvalue_getcommentcount(MaxJSONValue * val) {
	return val->Value().GetCommentCount();
}

int bmx_wxjsonvalue_getcommentpos(MaxJSONValue * val) {
	return val->Value().GetCommentPos();
}

int bmx_wxjsonvalue_getlineno(MaxJSONValue * val) {
	return val->Value().GetLineNo();
}

BBArray * bmx_wxjsonvalue_getlmembernames(MaxJSONValue * val) {
	return wxArrayStringToBBStringArray(val->Value().GetMemberNames());
}

wxJSONType bmx_wxjsonvalue_gettype(MaxJSONValue * val) {
	return val->Value().GetType();
}

bool bmx_wxjsonvalue_hasmember(MaxJSONValue * val, BBString * key) {
	return val->Value().HasMember(wxStringFromBBString(key));
}

bool bmx_wxjsonvalue_hasmemberindex(MaxJSONValue * val, int index) {
	return val->Value().HasMember(index);
}

bool bmx_wxjsonvalue_isarray(MaxJSONValue * val) {
	return val->Value().IsArray();
}

bool bmx_wxjsonvalue_isbool(MaxJSONValue * val) {
	return val->Value().IsBool();
}

bool bmx_wxjsonvalue_isdouble(MaxJSONValue * val) {
	return val->Value().IsDouble();
}

bool bmx_wxjsonvalue_isint(MaxJSONValue * val) {
	return val->Value().IsInt() || val->Value().IsUInt();
}

bool bmx_wxjsonvalue_islong(MaxJSONValue * val) {
	return val->Value().IsInt64() || val->Value().IsUInt64();
}

bool bmx_wxjsonvalue_isnull(MaxJSONValue * val) {
	return val->Value().IsNull();
}

bool bmx_wxjsonvalue_isobject(MaxJSONValue * val) {
	return val->Value().IsObject();
}

bool bmx_wxjsonvalue_issameas(MaxJSONValue * val, MaxJSONValue * other) {
	return val->Value().IsSameAs(other->Value());
}

bool bmx_wxjsonvalue_isstring(MaxJSONValue * val) {
	return val->Value().IsString();
}

void bmx_wxjsonvalue_setint(MaxJSONValue * val, int value) {
	val->Value() = value;
}

void bmx_wxjsonvalue_setbool(MaxJSONValue * val, bool value) {
	val->Value() = value;
}

void bmx_wxjsonvalue_setdouble(MaxJSONValue * val, double value) {
	val->Value() = value;
}

void bmx_wxjsonvalue_setlong(MaxJSONValue * val, BBInt64 value) {
	val->Value() = value;
}

MaxJSONValue * bmx_wxjsonvalue_appendstring(MaxJSONValue * val, BBString * value) {
	return new MaxJSONValue(&val->Value().Append(wxStringFromBBString(value)));
}

MaxJSONValue * bmx_wxjsonvalue_appenddouble(MaxJSONValue * val, double value) {
	return new MaxJSONValue(&val->Value().Append(value));
}

MaxJSONValue * bmx_wxjsonvalue_appendbool(MaxJSONValue * val, bool value) {
	return new MaxJSONValue(&val->Value().Append(value));
}

MaxJSONValue * bmx_wxjsonvalue_appendlong(MaxJSONValue * val, BBInt64 value) {
	return new MaxJSONValue(&val->Value().Append(value));
}

MaxJSONValue * bmx_wxjsonvalue_appendint(MaxJSONValue * val, int value) {
	return new MaxJSONValue(&val->Value().Append(value));
}

MaxJSONValue * bmx_wxjsonvalue_append(MaxJSONValue * val, MaxJSONValue * value) {
	return new MaxJSONValue(&val->Value().Append(value->Value()));
}

bool bmx_wxjsonvalue_asbool(MaxJSONValue * val) {
	return val->Value().AsBool();
}

BBString * bmx_wxjsonvalue_asstring(MaxJSONValue * val) {
	return bbStringFromWxString(val->Value().AsString());
}

double bmx_wxjsonvalue_asdouble(MaxJSONValue * val) {
	return val->Value().AsDouble();
}

void bmx_wxjsonvalue_aslong(MaxJSONValue * val, BBInt64 * value) {
	*value = val->Value().AsInt64();
}

int bmx_wxjsonvalue_addcomment(MaxJSONValue * val, BBString *comment, int position) {
	return val->Value().AddComment(wxStringFromBBString(comment), position);
}

int bmx_wxjsonvalue_addcomments(MaxJSONValue * val, BBArray * comments, int position) {
	return val->Value().AddComment(bbStringArrayTowxArrayStr(comments), position);
}

bool bmx_wxjsonvalue_remove(MaxJSONValue * val, BBString * key) {
	return val->Value().Remove(wxStringFromBBString(key));
}

bool bmx_wxjsonvalue_removefrom(MaxJSONValue * val, int index) {
	return val->Value().Remove(index);
}

void bmx_wxjsonvalue_setlineno(MaxJSONValue * val, int num) {
	val->Value().SetLineNo(num);
}

int bmx_wxjsonvalue_size(MaxJSONValue * val) {
	return val->Value().Size();
}

void bmx_wxjsonvalue_settype(MaxJSONValue * val, wxJSONType type) {
	val->Value().SetType(type);
}


// *********************************************

wxJSONWriter * bmx_wxjsonwriter_create(int style, int indent, int step) {
	return new wxJSONWriter(style, indent, step);
}

BBString * bmx_wxjsonwriter_writestring(wxJSONWriter * writer, MaxJSONValue * value) {
	wxString s;
	writer->Write(value->Value(), s);
	return bbStringFromWxString(s);
}

void bmx_wxjsonwriter_delete(wxJSONWriter * writer) {
	delete writer;
}

void bmx_wxjsonwriter_write(wxJSONWriter * writer, MaxJSONValue * value, wxOutputStream * stream) {
	writer->Write(value->Value(), *stream);
}

// *********************************************

wxJSONReader * bmx_wxjsonreader_create(int flags, int maxErrors) {
	return new wxJSONReader(flags, maxErrors);
}

MaxJSONValue * bmx_wxjsonreader_parsestring(wxJSONReader * reader, BBString * doc) {
	MaxJSONValue * val = new MaxJSONValue();
	int res = reader->Parse(wxStringFromBBString(doc), &val->Value());
	return val;
}

MaxJSONValue * bmx_wxjsonreader_parse(wxJSONReader * reader, wxInputStream * doc) {
	MaxJSONValue * val = new MaxJSONValue();
	int res = reader->Parse(*doc, &val->Value());
	return val;
}

int bmx_wxjsonreader_geterrorcount(wxJSONReader * reader) {
	return reader->GetErrorCount();
}

int bmx_wxjsonreader_getwarningcount(wxJSONReader * reader) {
	return reader->GetWarningCount();
}

BBArray * bmx_wxjsonreader_geterrors(wxJSONReader * reader) {
	return wxArrayStringToBBStringArray(reader->GetErrors());
}

BBArray * bmx_wxjsonreader_getwarnings(wxJSONReader * reader) {
	return wxArrayStringToBBStringArray(reader->GetWarnings());
}


void bmx_wxjsonreader_delete(wxJSONReader * reader) {
	delete reader;
}


