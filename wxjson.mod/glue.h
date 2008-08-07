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

#ifndef _WX_MAX_JSON_H_
#define _WX_MAX_JSON_H_

#include "wxglue.h"
#include "wx/jsonreader.h"
#include "wx/jsonwriter.h"

class MaxJSONValue;

extern "C" {

#include <blitz.h>

	MaxJSONValue * bmx_wxjsonvalue_create();
	MaxJSONValue * bmx_wxjsonvalue_createint(int value);
	MaxJSONValue * bmx_wxjsonvalue_createlong(BBInt64 value);
	MaxJSONValue * bmx_wxjsonvalue_createbool(bool value);
	MaxJSONValue * bmx_wxjsonvalue_createdouble(double value);
	MaxJSONValue * bmx_wxjsonvalue_createstring(BBString * value);
	int bmx_wxjsonvalue_asint(MaxJSONValue * val);
	MaxJSONValue * bmx_wxjsonvalue_item(MaxJSONValue * val, BBString * name);
	MaxJSONValue * bmx_wxjsonvalue_itemat(MaxJSONValue * val, int index);
	void bmx_wxjsonvalue_setstring(MaxJSONValue * val, BBString * value);
	void bmx_wxjsonvalue_delete(MaxJSONValue * val);
	bool bmx_wxjsonvalue_cat(MaxJSONValue * val, BBString * text);
	void bmx_wxjsonvalue_clear(MaxJSONValue * val);
	void bmx_wxjsonvalue_clearcomments(MaxJSONValue * val);
	BBString * bmx_wxjsonvalue_getcomment(MaxJSONValue * val, int index);
	BBArray * bmx_wxjsonvalue_getcommentarray(MaxJSONValue * val);
	int bmx_wxjsonvalue_getcommentcount(MaxJSONValue * val);
	int bmx_wxjsonvalue_getcommentpos(MaxJSONValue * val);
	int bmx_wxjsonvalue_getlineno(MaxJSONValue * val);
	BBArray * bmx_wxjsonvalue_getlmembernames(MaxJSONValue * val);
	wxJSONType bmx_wxjsonvalue_gettype(MaxJSONValue * val);
	bool bmx_wxjsonvalue_hasmember(MaxJSONValue * val, BBString * key);
	bool bmx_wxjsonvalue_hasmemberindex(MaxJSONValue * val, int index);
	bool bmx_wxjsonvalue_isarray(MaxJSONValue * val);
	bool bmx_wxjsonvalue_isbool(MaxJSONValue * val);
	bool bmx_wxjsonvalue_isdouble(MaxJSONValue * val);
	bool bmx_wxjsonvalue_isint(MaxJSONValue * val);
	bool bmx_wxjsonvalue_islong(MaxJSONValue * val);
	bool bmx_wxjsonvalue_isnull(MaxJSONValue * val);
	bool bmx_wxjsonvalue_isobject(MaxJSONValue * val);
	bool bmx_wxjsonvalue_issameas(MaxJSONValue * val, MaxJSONValue * other);
	bool bmx_wxjsonvalue_isstring(MaxJSONValue * val);

	void bmx_wxjsonvalue_setint(MaxJSONValue * val, int value);
	void bmx_wxjsonvalue_setbool(MaxJSONValue * val, bool value);
	void bmx_wxjsonvalue_setdouble(MaxJSONValue * val, double value);
	void bmx_wxjsonvalue_setlong(MaxJSONValue * val, BBInt64 value);
	MaxJSONValue * bmx_wxjsonvalue_appendstring(MaxJSONValue * val, BBString * value);
	MaxJSONValue * bmx_wxjsonvalue_appenddouble(MaxJSONValue * val, double value);
	MaxJSONValue * bmx_wxjsonvalue_appendbool(MaxJSONValue * val, bool value);
	MaxJSONValue * bmx_wxjsonvalue_appendlong(MaxJSONValue * val, BBInt64 value);
	MaxJSONValue * bmx_wxjsonvalue_appendint(MaxJSONValue * val, int value);
	MaxJSONValue * bmx_wxjsonvalue_append(MaxJSONValue * val, MaxJSONValue * value);
	bool bmx_wxjsonvalue_asbool(MaxJSONValue * val);
	BBString * bmx_wxjsonvalue_asstring(MaxJSONValue * val);
	double bmx_wxjsonvalue_asdouble(MaxJSONValue * val);
	void bmx_wxjsonvalue_aslong(MaxJSONValue * val, BBInt64 * value);

	int bmx_wxjsonvalue_addcomment(MaxJSONValue * val, BBString *comment, int position);
	int bmx_wxjsonvalue_addcomments(MaxJSONValue * val, BBArray * comments, int position);
	bool bmx_wxjsonvalue_remove(MaxJSONValue * val, BBString * key);
	bool bmx_wxjsonvalue_removefrom(MaxJSONValue * val, int index);
	void bmx_wxjsonvalue_setlineno(MaxJSONValue * val, int num);
	int bmx_wxjsonvalue_size(MaxJSONValue * val);
	void bmx_wxjsonvalue_settype(MaxJSONValue * val, wxJSONType type);
	
	wxJSONWriter * bmx_wxjsonwriter_create(int style, int indent, int step);
	BBString * bmx_wxjsonwriter_writestring(wxJSONWriter * writer, MaxJSONValue * value);
	void bmx_wxjsonwriter_delete(wxJSONWriter * writer);
	void bmx_wxjsonwriter_write(wxJSONWriter * writer, MaxJSONValue * value, wxOutputStream * stream);

	wxJSONReader * bmx_wxjsonreader_create(int flags, int maxErrors);
	MaxJSONValue * bmx_wxjsonreader_parsestring(wxJSONReader * reader, BBString * doc);
	MaxJSONValue * bmx_wxjsonreader_parse(wxJSONReader * reader, wxInputStream * doc);
	int bmx_wxjsonreader_geterrorcount(wxJSONReader * reader);
	int bmx_wxjsonreader_getwarningcount(wxJSONReader * reader);
	BBArray * bmx_wxjsonreader_geterrors(wxJSONReader * reader);
	BBArray * bmx_wxjsonreader_getwarnings(wxJSONReader * reader);

	void bmx_wxjsonreader_delete(wxJSONReader * reader);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxJSONValue
{
public:
	MaxJSONValue();
	MaxJSONValue(wxJSONValue & value);
	MaxJSONValue(wxJSONValue * value);
	~MaxJSONValue();
	wxJSONValue & Value();

private:
	wxJSONValue * value;
	wxJSONValue localValue;
};


#endif // _WX_MAX_JSON_H_
