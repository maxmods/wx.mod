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

Import wx.wx
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "include/*.h"

Import "glue.cpp"

Import "src/jsonreader.cpp"
Import "src/jsonval.cpp"
Import "src/jsonwriter.cpp"


Extern

	Function bmx_wxjsonvalue_create:Byte Ptr()
	Function bmx_wxjsonvalue_createint:Byte Ptr(value:Int)
	Function bmx_wxjsonvalue_asint:Int(handle:Byte Ptr)
	Function bmx_wxjsonvalue_item:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_wxjsonvalue_itemat:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wxjsonvalue_setstring(handle:Byte Ptr, value:String)
	Function bmx_wxjsonvalue_delete(handle:Byte Ptr)

	Function bmx_wxjsonwriter_create:Byte Ptr(style:Int, indent:Int, _step:Int)
	Function bmx_wxjsonwrite_writestring:String(handle:Byte Ptr, value:Byte Ptr)
	Function bmx_wxjsonwriter_delete(handle:Byte Ptr)

End Extern



Const wxJSONTYPE_INVALID:Int = 0    ' the object is not uninitialized        
Const wxJSONTYPE_NULL:Int = 1       ' the object contains a NULL value         
Const wxJSONTYPE_INT:Int = 2        ' the object contains an integer           
Const wxJSONTYPE_UINT:Int = 3       ' the object contains an unsigned integer  
Const wxJSONTYPE_DOUBLE:Int = 4     ' the object contains a double             
Const wxJSONTYPE_STRING:Int = 5     ' the object contains a wxString object    
Const wxJSONTYPE_CSTRING:Int = 5    ' the object contains a static C-string    
Const wxJSONTYPE_BOOL:Int = 7       ' the object contains a boolean            
Const wxJSONTYPE_ARRAY:Int = 8      ' the object contains an array of values   
Const wxJSONTYPE_OBJECT:Int = 9     ' the object contains a map of keys/values 
Const wxJSONTYPE_LONG:Int = 10      ' the object contains a 32-bit integer     
Const wxJSONTYPE_INT64:Int = 11     ' the object contains a 64-bit integer     
Const wxJSONTYPE_ULONG:Int = 12     ' the object contains an unsigned 32-bit integer  
Const wxJSONTYPE_UINT64:Int = 13    ' the object contains an unsigned 64-bit integer  
Const wxJSONTYPE_SHORT:Int = 14     ' the object contains a 16-bit integer            
Const wxJSONTYPE_USHORT:Int = 15    ' the object contains a 16-bit unsigned integer   

Const wxJSONVALUE_COMMENT_DEFAULT:Int = 0
Const wxJSONVALUE_COMMENT_BEFORE:Int = 1
Const wxJSONVALUE_COMMENT_AFTER:Int = 2
Const wxJSONVALUE_COMMENT_INLINE:Int = 3

Const wxJSONWRITER_NONE:Int = $00000000
Const wxJSONWRITER_STYLED:Int = $00000001
Const wxJSONWRITER_WRITE_COMMENTS:Int = $00000002
Const wxJSONWRITER_COMMENTS_BEFORE:Int = $00000004
Const wxJSONWRITER_COMMENTS_AFTER:Int = $00000008
Const wxJSONWRITER_SPLIT_STRING:Int = $00000010
Const wxJSONWRITER_NO_LINEFEEDS:Int = $00000020

