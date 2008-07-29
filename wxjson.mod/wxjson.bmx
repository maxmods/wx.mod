' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wx.wxJSON
End Rem
Module wx.wxJSON

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2008 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
ModuleInfo "CC_OPTS: -D__WXMAC__"
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
		
		Return Self
	End Method
	
	Function CreateJSONValueBool:wxJSONValue(value:Int)
		Return New wxJSONValue.CreateBool(value)
	End Function

	Method CreateBool:wxJSONValue(value:Int)
		
		Return Self
	End Method

	Function CreateJSONValueDouble:wxJSONValue(value:Double)
		Return New wxJSONValue.CreateDouble(value)
	End Function

	Method CreateDouble:wxJSONValue(value:Double)
		
		Return Self
	End Method

	Function CreateJSONValueString:wxJSONValue(value:String)
		Return New wxJSONValue.CreateString(value)
	End Function

	Method CreateString:wxJSONValue(value:String)
		
		Return Self
	End Method

	Method AddComment:Int(comment:String, position:Int = wxJSONVALUE_COMMENT_DEFAULT)
	End Method

	Method AddComments:Int(comments:String[], position:Int = wxJSONVALUE_COMMENT_DEFAULT)
	End Method
	
	Method AppendString(value:String)
	End Method
	
	Method AppendDouble(value:Double)
	End Method
	
	Method AppendBool(value:Int)
	End Method
	
	Method AppendLong(value:Long)
	End Method
	
	Method AppendInt(value:Int)
	End Method
	
	Method Append(value:wxJSONValue)
	End Method
	
	Method AsBool:Int()
	End Method
	
	Method AsString:String()
	End Method
	
	Method AsDouble:Double()
	End Method
	
	Method AsInt:Int()
		Return bmx_wxjsonvalue_asint(wxObjectPtr)
	End Method
	
	Method AsLong:Long()
	End Method
	
	Method Cat:Int(text:String)
	End Method
	
	Method Clear()
	End Method

	Method ClearComments()
	End Method
	
	Method GetComment:String(index:Int = -1)
	End Method
	
	Method GetCommentArray:String[]()
	End Method
	
	Method GetCommentCount:Int()
	End Method
	
	Method GetCommentPos:Int()
	End Method
	
	Method GetInfo:String()
	End Method
	
	Method GetLineNo:Int()
	End Method
	
	Method GetMemberNames:String[]()
	End Method
	
	Method GetType:Int()
	End Method
	
	Method HasMember:Int(key:String)
	End Method
	
	Method HasMemberIndex:Int(index:Int)
	End Method
	
	Method IsArray:Int()
	End Method
	
	Method IsBool:Int()
	End Method
	
	Method IsDouble:Int()
	End Method
	
	Method IsEmpty:Int()
	End Method
	
	Method IsInt:Int()
	End Method
	
	Method IsLong:Int()
	End Method
	
	Method IsNull:Int()
	End Method
	
	Method IsObject:Int()
	End Method
	
	Method IsSameAs:Int(other:wxJSONValue)
	End Method
	
	Method IsString:Int()
	End Method
	
	Method Item:wxJSONValue(name:String)
		Return _create(bmx_wxjsonvalue_item(wxObjectPtr, name))
	End Method
	
	Method ItemAt:wxJSONValue(index:Int)
		Return _create(bmx_wxjsonvalue_itemat(wxObjectPtr, index))
	End Method
	
	Method SetInt(value:Int)
	End Method
	
	Method SetBool(value:Int)
	End Method
	
	Method SetDouble(value:Double)
	End Method
	
	Method SetLong(value:Long)
	End Method
	
	Method SetString(value:String)
		bmx_wxjsonvalue_setstring(wxObjectPtr, value)
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
		Return bmx_wxjsonwrite_writestring(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Write the JSONvalue object to a JSON text, to an output stream. 
	End Rem
	Method Write(value:wxJSONValue, stream:wxOutputStream)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxjsonwriter_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


