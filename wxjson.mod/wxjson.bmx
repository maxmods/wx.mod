' Copyright (c) 2007-2015 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxJSON
End Rem
Module wx.wxJSON

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2008-2015 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: The JSON value type implementation. 
about: This class holds a JSON value which may be of the following type:
<ul>
<li>wxJSONTYPE_EMPTY: an empty (invalid) JSON value</li>
<li>wxJSONTYPE_NULL: a NULL value</li>
<li>wxJSONTYPE_INT: an integer value</li>
<li>wxJSONTYPE_UINT: an unsigned integer</li>
<li>wxJSONTYPE_DOUBLE: a double precision number</li>
<li>wxJSONTYPE_BOOL: a boolean</li>
<li>wxJSONTYPE_STRING: a String object</li>
<li>wxJSONTYPE_ARRAY: an array of wxJSONValue objects</li>
<li>wxJSONTYPE_OBJECT: a hashmap of key/value pairs where key is a string and value is a wxJSONValue object</li>
</ul>
<p>
To know more about the internal representation of JSON values see wxJSON internals.
</p>
<p>
Starting from version 0.5 the wxJSON library supports 64-bits integers on platforms that have native support
for very large integers. Note that the integer type is still stored as a generic wxJSONTYPE_(U)INT constant
regardless the size of the value but the JSON value class defines functions in order to let the user know
if an integer value fits in a 32-bit integer or it is so large that it needs a 64-bits integer storage.
To know more about 64-bits integer support see 64-bits and 32-bits integers 
</p>
End Rem
Type wxJSONValue

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxJSONValue(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxJSONValue = New wxJSONValue
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValue:wxJSONValue()
		Return New wxJSONValue.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxJSONValue()
		wxObjectPtr = bmx_wxjsonvalue_create()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValueInt:wxJSONValue(value:Int)
		Return New wxJSONValue.CreateInt(value)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateInt:wxJSONValue(value:Int)
		wxObjectPtr = bmx_wxjsonvalue_createint(value)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValueLong:wxJSONValue(value:Long)
		Return New wxJSONValue.CreateLong(value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateLong:wxJSONValue(value:Long)
		wxObjectPtr = bmx_wxjsonvalue_createlong(value)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValueBool:wxJSONValue(value:Int)
		Return New wxJSONValue.CreateBool(value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateBool:wxJSONValue(value:Int)
		wxObjectPtr = bmx_wxjsonvalue_createbool(value)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValueDouble:wxJSONValue(value:Double)
		Return New wxJSONValue.CreateDouble(value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateDouble:wxJSONValue(value:Double)
		wxObjectPtr = bmx_wxjsonvalue_createdouble(value)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateJSONValueString:wxJSONValue(value:String)
		Return New wxJSONValue.CreateString(value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateString:wxJSONValue(value:String)
		wxObjectPtr = bmx_wxjsonvalue_createstring(value)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddComment:Int(comment:String, position:Int = wxJSONVALUE_COMMENT_DEFAULT)
		Return bmx_wxjsonvalue_addcomment(wxObjectPtr, comment, position)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddComments:Int(comments:String[], position:Int = wxJSONVALUE_COMMENT_DEFAULT)
		Return bmx_wxjsonvalue_addcomments(wxObjectPtr, comments, position)
	End Method
	
	Rem
	bbdoc: Appends the specified String value in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method AppendString:wxJSONValue(value:String)
		Return _create(bmx_wxjsonvalue_appendstring(wxObjectPtr, value))
	End Method
	
	Rem
	bbdoc: Appends the specified Double value in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method AppendDouble:wxJSONValue(value:Double)
		Return _create(bmx_wxjsonvalue_appenddouble(wxObjectPtr, value))
	End Method
	
	Rem
	bbdoc: Appends the specified Bool value in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method AppendBool:wxJSONValue(value:Int)
		Return _create(bmx_wxjsonvalue_appendbool(wxObjectPtr, value))
	End Method
	
	Rem
	bbdoc: Appends the specified Long value in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method AppendLong:wxJSONValue(value:Long)
		Return _create(bmx_wxjsonvalue_appendlong(wxObjectPtr, value))
	End Method
	
	Rem
	bbdoc: Appends the specified Int value in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method AppendInt:wxJSONValue(value:Int)
		Return _create(bmx_wxjsonvalue_appendint(wxObjectPtr, value))
	End Method
	
	Rem
	bbdoc: Appends the specified wxJSONValue object in the array.
	returns: 	A reference to the appended object.
	about: The method appends the value specified in the parameter to the array contained in this object.
	If this object does not contain an array type, the actual content is deleted and a new array is created.
	End Rem
	Method Append:wxJSONValue(value:wxJSONValue)
		Return _create(bmx_wxjsonvalue_append(wxObjectPtr, value.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the stored value as a boolean.
	about: If the type of the stored value is not a boolean the method just returns an undefined result.
	End Rem
	Method AsBool:Int()
		Return bmx_wxjsonvalue_asbool(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the stored value as a string.
	about: If the type of the stored value is a String type the method returns the string. 
	If the stored value is of a numeric type (int, unsigned int or double) the function returns the string
	representation of the numeric value. If the stored value is a boolean, the function returns the literal
	string true or false. If the value is a NULL value the null literal string is returned.
	<p>
	If the value is of type wxJSONTYPE_EMPTY, the literal string <empty> is returned. Note that this is NOT a
	valid JSON text. If the value is an array or map, an empty string is returned.
	</p>
	End Rem
	Method AsString:String()
		Return bmx_wxjsonvalue_asstring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the stored value as a double.
	about: If the type of the stored value is not a double, an int or an unsigned int the method returns an undefined result.
	End Rem
	Method AsDouble:Double()
		Return bmx_wxjsonvalue_asdouble(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the stored value as an integer.
	about: The method returns the integer value stored in this JSON-value object. If the type of the stored value
	is not an integer, an unsigned int or a bool the method returns an undefined value.
	End Rem
	Method AsInt:Int()
		Return bmx_wxjsonvalue_asint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the numeric value as a 64-bit integer.
	End Rem
	Method AsLong:Long()
		Local value:Long
		bmx_wxjsonvalue_aslong(wxObjectPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: Concatenate a string to this string object.
	about: The method concatenates @text to the string contained in this object and returns TRUE if the operation is succesful.
	If the value stored in this value is not a string object the function does nothing and returns FALSE.
	End Rem
	Method Cat:Int(text:String)
		Return bmx_wxjsonvalue_cat(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Clear the object value.
	about: This method causes the object to be empty.
	End Rem
	Method Clear()
		bmx_wxjsonvalue_clear(wxObjectPtr)
	End Method

	Rem
	bbdoc: Clear all comment strings.
	End Rem
	Method ClearComments()
		bmx_wxjsonvalue_clearcomments(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a comment string.
	about: The method returns the comment string at @index. If @index is out of range, an empty string is returned.
	If @index is equal to -1, then the method returns a string that contains all comment's strings stored in the array.
	End Rem
	Method GetComment:String(index:Int = -1)
		Return bmx_wxjsonvalue_getcomment(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Get the comment string's array.
	End Rem
	Method GetCommentArray:String[]()
		Return bmx_wxjsonvalue_getcommentarray(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the number of comment strings.
	End Rem
	Method GetCommentCount:Int()
		Return bmx_wxjsonvalue_getcommentcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the comment position.
	End Rem
	Method GetCommentPos:Int()
		Return bmx_wxjsonvalue_getcommentpos(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the line number of this JSON value object.
	about: The line number of a JSON value object is set to -1 when the object is constructed.
	The line number is set by the parser class, wxJSONReader, when a JSON text is read from a stream
	or a string. It is used when reading a comment line: comment lines that apear on the same line
	as a value are considered inline comments of the value.
	End Rem
	Method GetLineNo:Int()
		Return bmx_wxjsonvalue_getlineno(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of keys.
	about: If the stored value is a key/value map, the function returns an array of strings
	containing the key of all elements. Note that the returned array may be empty if the map has
	ZERO elements. An empty string array is also returned if the stored value is not a key/value map.
	End Rem
	Method GetMemberNames:String[]()
		Return bmx_wxjsonvalue_getlmembernames(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the type of the value stored in the object.
	End Rem
	Method GetType:Int()
		Return bmx_wxjsonvalue_gettype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the object contains an element at the specified key.
	about: If the stored value is not a key/map map, the function returns FALSE.
	End Rem
	Method HasMember:Int(key:String)
		Return bmx_wxjsonvalue_hasmember(wxObjectPtr, key)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the object contains an element at the specified index.
	about: If the stoerd value is not an array or a map, the function returns FALSE.
	End Rem
	Method HasMemberIndex:Int(index:Int)
		Return bmx_wxjsonvalue_hasmemberindex(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value stored is an array type.
	End Rem
	Method IsArray:Int()
		Return bmx_wxjsonvalue_isarray(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value stored is a boolean.
	End Rem
	Method IsBool:Int()
		Return bmx_wxjsonvalue_isbool(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value stored is a double.
	End Rem
	Method IsDouble:Int()
		Return bmx_wxjsonvalue_isdouble(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value stored is integer.
	End Rem
	Method IsInt:Int()
		Return bmx_wxjsonvalue_isint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the stored value is a 64-bits integer.
	End Rem
	Method IsLong:Int()
		Return bmx_wxjsonvalue_islong(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value is wxJSONTYPE_NULL.
	End Rem
	Method IsNull:Int()
		Return bmx_wxjsonvalue_isnull(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of this value is a key/value map.
	End Rem
	Method IsObject:Int()
		Return bmx_wxjsonvalue_isobject(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if this object looks like other.
	about: The comment strings array are not compared: JSON value objects are the same if they contains the
	same values, regardless the comment's strings.
	<p>
	Note that the method does not return the element that cause the comparison to return FALSE.
	There is not a good structure to tell this information. 
	</p>
	<p>
	Note that if the two JSON value objects share the same referenced data, the function immediatly
	returns TRUE without doing a deep comparison which is, sure, useless.
	</p>
	End Rem
	Method IsSameAs:Int(other:wxJSONValue)
		Return bmx_wxjsonvalue_issameas(wxObjectPtr, other.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns TRUE if the type of the value stored is a String object.
	End Rem
	Method IsString:Int()
		Return bmx_wxjsonvalue_isstring(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the item at the specified key.
	about: Returns a reference to the object at the specified key. If the element does not exist,
	the array is enlarged to index + 1 elements and a reference to the last element will be returned.
	New elements will contain NULL values. If this object does not contain an array,
	the old value is replaced by an array object which will be enlarged to the needed dimension.
	End Rem
	Method Item:wxJSONValue(name:String)
		Return _create(bmx_wxjsonvalue_item(wxObjectPtr, name))
	End Method
	
	Rem
	bbdoc: Returns the item at the specified index.
	about: Returns a reference to the object at the specified index. If the element does not exist,
	the array is enlarged to index + 1 elements and a reference to the last element will be returned.
	New elements will contain NULL values. If this object does not contain an array,
	the old value is replaced by an array object which will be enlarged to the needed dimension.
	End Rem
	Method ItemAt:wxJSONValue(index:Int)
		Return _create(bmx_wxjsonvalue_itemat(wxObjectPtr, index))
	End Method
	
	Rem
	bbdoc: Removes the item at the specified key.
	End Rem
	Method Remove:Int(key:String)
		Return bmx_wxjsonvalue_remove(wxObjectPtr, key)
	End Method
	
	Rem
	bbdoc: Removes the item at the specified index.
	End Rem
	Method RemoveFrom:Int(index:Int)
		Return bmx_wxjsonvalue_removefrom(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Assign the specified Int value to this object replacing the old value.
	End Rem
	Method SetInt(value:Int)
		bmx_wxjsonvalue_setint(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Assign the specified bool value to this object replacing the old value.
	End Rem
	Method SetBool(value:Int)
		bmx_wxjsonvalue_setbool(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Assign the specified Double value to this object replacing the old value.
	End Rem
	Method SetDouble(value:Double)
		bmx_wxjsonvalue_setdouble(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Assign the specified Long value to this object replacing the old value.
	End Rem
	Method SetLong(value:Long)
		bmx_wxjsonvalue_setlong(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Assign the specified String value to this object replacing the old value.
	End Rem
	Method SetString(value:String)
		bmx_wxjsonvalue_setstring(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Set the line number of this JSON value object.
	End Rem
	Method SetLineNo(num:Int)
		bmx_wxjsonvalue_setlineno(wxObjectPtr, num)
	End Method
	
	Rem
	bbdoc: Set the type of the stored value.
	about: The method sets the type of the stored value as specified in the provided argument. If the actual
	type is equal to type, nothing happens and this JSON value object retains the original type and value.
	If the type differs, however, the original type and value are lost.
	<p>
	The method just sets the type of the object and not the value itself.
	</p>
	End Rem
	Method SetType(_type:Int)
		bmx_wxjsonvalue_settype(wxObjectPtr, _type)
	End Method
	
	Rem
	bbdoc: Returns the size of the array or map stored in this value.
	about: Note that both the array and the key/value map may have a size of ZERO elements. If the stored
	value is not an array nor a key/value hashmap, the function returns -1.
	End Rem
	Method Size:Int()
		Return bmx_wxjsonvalue_size(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxjsonvalue_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: The JSON document writer.
about: This type is a JSON document writer and it is used to write a wxJSONValue object to an output stream
or to a string. Create() accepts some parameters which can be used to change the style of the output.
The default output is in human-readable format.
<p>
Here is an example on how to use this type:
<pre>
' construct the JSON value object and add values to it
Local root:wxJSONValue = new wxJSONValue.Create()
root.Item("key1").SetString("some value")
...

' now we want a string that contains the text data
' we use the default settings to obtain human-readable text
Local jsw:wxJSONWriter = new wxJSONWriter.Create()
Local s:String = jsw.WriteString( root )
</pre>
</p>
End Rem
Type wxJSONWriter

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Construct the JSON writer object with the specified parameters.
	about: Note that if @style is FALSE the indentation is totally suppressed and the values of the other
	two parameters are simply ignored.
	End Rem
	Function CreateJSONWriter:wxJSONWriter(style:Int = wxJSONWRITER_STYLED, indent:Int = 0, _step:Int = 3)
		Return New wxJSONWriter.Create(style, indent, _step)
	End Function
	
	Rem
	bbdoc: Construct the JSON writer object with the specified parameters.
	about: Note that if @style is FALSE the indentation is totally suppressed and the values of the other
	two parameters are simply ignored.
	End Rem
	Method Create:wxJSONWriter(style:Int = wxJSONWRITER_STYLED, indent:Int = 0, _step:Int = 3)
		wxObjectPtr = bmx_wxjsonwriter_create(style, indent, _step)
		Return Self
	End Method
	
	Rem
	bbdoc: Write the JSONvalue object to a JSON text, to a String.
	End Rem
	Method WriteString:String(value:wxJSONValue)
		Return bmx_wxjsonwriter_writestring(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Write the JSONvalue object to a JSON text, to an output stream. 
	End Rem
	Method Write(value:wxJSONValue, stream:wxOutputStream)
		bmx_wxjsonwriter_write(wxObjectPtr, value.wxObjectPtr, stream.wxStreamPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxjsonwriter_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: The JSON parser.
about: This type is a JSON parser which reads a JSON formatted text and stores values in the wxJSONValue structure.
Create() accepts two parameters: the style flag, which controls how much error-tolerant should the parser
be and an integer which is the maximum number of errors and warnings that have to be reported.
<p>
If the document does not contain an open/close JSON character the function returns an empty value object.
This is the case of a document that is empty or
contains only whitespaces or comments. If the document contains a starting object/array character immediatly
followed by a closing object/array character (i.e.: {} ) then the function returns an empty array or object
JSON value (note the little distinction: empty value is not the same as empty array or empty object ). For
an empty object or array, the wxJSONValue::IsEmpty() function returns FALSE and the wxJSONValue::Size() returns ZERO.
</p>
<p>
In order to avoid confusion, you have to think about empty JSON values as invalid JSON values. Empty arrays
and empty objects are valid JSON values.
</p>
End Rem
Type wxJSONReader

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Construct a JSON parser object with the given parameters.
	End Rem
	Function CreateJSONReader:wxJSONReader(flags:Int = wxJSONREADER_TOLERANT, maxErrors:Int = 30)
		Return New wxJSONReader.Create(flags, maxErrors)
	End Function

	Rem
	bbdoc: Construct a JSON parser object with the given parameters.
	End Rem
	Method Create:wxJSONReader(flags:Int = wxJSONREADER_TOLERANT, maxErrors:Int = 30)
		wxObjectPtr = bmx_wxjsonreader_create(flags, maxErrors)
		Return Self
	End Method
	
	Rem
	bbdoc: Parse the JSON document.
	End Rem
	Method ParseString:wxJSONValue(doc:String)
		Return wxJSONValue._create(bmx_wxjsonreader_parsestring(wxObjectPtr, doc))
	End Method
	
	Rem
	bbdoc: Parse the JSON document.
	End Rem
	Method Parse:wxJSONValue(doc:wxInputStream)
		Return wxJSONValue._create(bmx_wxjsonreader_parse(wxObjectPtr, doc.wxStreamPtr))
	End Method
	
	Rem
	bbdoc: Returns the size of the error message's array.
	End Rem
	Method GetErrorCount:Int()
		Return bmx_wxjsonreader_geterrorcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the size of the warning message's array.
	End Rem
	Method GetWarningCount:Int()
		Return bmx_wxjsonreader_getwarningcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the error messages array.
	End Rem
	Method GetErrors:String[]()
		Return bmx_wxjsonreader_geterrors(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the warning messages array.
	End Rem
	Method GetWarnings:String[]()
		Return bmx_wxjsonreader_getwarnings(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxjsonreader_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

