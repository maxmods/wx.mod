' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxTextValidator
End Rem
Module wx.wxTextValidator

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: wxTextValidator validates text controls, providing a variety of filtering behaviours.
about: 
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxFILTER_NONE </td><td>No filtering takes place.</td></tr>
<tr><td>wxFILTER_ASCII </td><td>Non-ASCII characters are filtered out.</td></tr>
<tr><td>wxFILTER_ALPHA </td><td>Non-alpha characters are filtered out.</td></tr>
<tr><td>wxFILTER_ALPHANUMERIC </td><td>Non-alphanumeric characters are filtered out. </td></tr>
<tr><td>wxFILTER_NUMERIC </td><td>Non-numeric characters are filtered out.</td></tr>
<tr><td>wxFILTER_INCLUDE_LIST </td><td>Use an include list. The validator checks if the user input is on the list,
complaining if not. See wxTextValidator::SetIncludes.</td></tr>
<tr><td>wxFILTER_EXCLUDE_LIST </td><td>Use an exclude list. The validator checks if the user input is on the list,
complaining if it is. See wxTextValidator::SetExcludes. </td></tr>
<tr><td>wxFILTER_INCLUDE_CHAR_LIST </td><td>Use an include list. The validator checks if each input character is in
the list (one character per list element), complaining if not. See wxTextValidator::SetIncludes.</td></tr>
<tr><td>wxFILTER_EXCLUDE_CHAR_LIST </td><td>Use an include list. The validator checks if each input character is in
the list (one character per list element), complaining if it is. See wxTextValidator::SetExcludes.</td></tr>
</table>
</p>
End Rem
Type wxTextValidator Extends wxValidator

	Rem
	bbdoc: Creates a new text validator.
	End Rem
	Function CreateTextValidator:wxTextValidator(style:Int = wxFILTER_NONE)
		Return New wxTextValidator.Create(style)
	End Function
	
	Rem
	bbdoc: Creates a new text validator.
	End Rem
	Method Create:wxTextValidator(style:Int = wxFILTER_NONE)
		owner = True
		wxObjectPtr = bmx_wxtextvalidator_create(style)
		Return Self
	End Method

	Rem
	bbdoc: Returns the window associated with the validator.
	End Rem
	Method GetWindow:wxWindow()
		Return wxWindow._find(bmx_wxtextvalidator_getwindow(wxObjectPtr))
	End Method

	Rem
	bbdoc: Associates a window with the validator.
	about: Note, to set the validator on a window, you need to call window.SetValidator()
	End Rem
	Method SetWindow(window:wxWindow)
		bmx_wxtextvalidator_setwindow(wxObjectPtr, window.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns a reference to the exclude list (the list of invalid values).
	End Rem
	Method GetExcludes:String[]()
		Return bmx_wxtextvalidator_getexcludes(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a reference to the include list (the list of valid values).
	End Rem
	Method GetIncludes:String[]()
		Return bmx_wxtextvalidator_getincludes(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the validator style.
	End Rem
	Method GetStyle:Int()
		Return bmx_wxtextvalidator_getstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the exclude list (invalid values for the user input).
	End Rem
	Method SetExcludes(list:String[])
		bmx_wxtextvalidator_setexcludes(wxObjectPtr, list)
	End Method
	
	Rem
	bbdoc: Sets the include list (valid values for the user input).
	End Rem
	Method SetIncludes(list:String[])
		bmx_wxtextvalidator_setincludes(wxObjectPtr, list)
	End Method
	
	Rem
	bbdoc: Sets the validator style.
	End Rem
	Method SetStyle(style:Int)
		bmx_wxtextvalidator_setstyle(wxObjectPtr, style)
	End Method
	
End Type

