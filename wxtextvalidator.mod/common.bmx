' Copyright (c) 2007-2013 Bruce A Henderson
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
Import wx.wxValidator
Import wx.wxWindow
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

Import "glue.cpp"

Extern

	Function bmx_wxtextvalidator_create:Byte Ptr(style:Int)
	Function bmx_wxtextvalidator_getwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextvalidator_setwindow(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxtextvalidator_getexcludes:String[](handle:Byte Ptr)
	Function bmx_wxtextvalidator_getincludes:String[](handle:Byte Ptr)
	Function bmx_wxtextvalidator_getstyle:Int(handle:Byte Ptr)
	Function bmx_wxtextvalidator_setexcludes(handle:Byte Ptr, list:String[])
	Function bmx_wxtextvalidator_setincludes(handle:Byte Ptr, list:String[])
	Function bmx_wxtextvalidator_setstyle(handle:Byte Ptr, style:Int)

End Extern

Rem
bbdoc: No filtering takes place.
End Rem
Const wxFILTER_NONE:Int = $000

Rem
bbdoc: Empty strings are filtered out.
about: If this style is not specified then empty strings are accepted only if they pass the other checks (if you use more than one wxTextValidatorStyle).
End Rem
Const wxFILTER_EMPTY:Int = $001

Rem
bbdoc: Non-ASCII characters are filtered out.
End Rem
Const wxFILTER_ASCII:Int = $002

Rem
bbdoc: Non-alpha characters are filtered out.
about: Uses the wxWidgets wrapper for the standard CRT function isalpha (which is locale-dependent) on all characters of the string.
End Rem
Const wxFILTER_ALPHA:Int = $004

Rem
bbdoc: Non-alphanumeric characters are filtered out.
about: Uses the wxWidgets wrapper for the standard CRT function isalnum (which is locale-dependent) on all characters of the string.
End Rem
Const wxFILTER_ALPHANUMERIC:Int = $008

Rem
bbdoc: Non-numeric characters are filtered out.
about: Uses the wxWidgets wrapper for the standard CRT function isdigit (which is locale-dependent) on all characters of the string.
End Rem
Const wxFILTER_DIGITS:Int = $010

Rem
bbdoc: Non-numeric characters are filtered out.
about: Works like wxFILTER_DIGITS but allows also decimal points, minus/plus signs and the 'e' or 'E' character to input exponents. Note that this is not the same behaviour of wxString::IsNumber().
End Rem
Const wxFILTER_NUMERIC:Int = $020

Rem
bbdoc: Use an include list.
about: The validator checks if the user input is on the list, complaining if not. See wxTextValidator::SetIncludes().
End Rem
Const wxFILTER_INCLUDE_LIST:Int = $040

Rem
bbdoc: Use an include list.
about: The validator checks if each input character is in the list (one character per list element), complaining if not. See wxTextValidator::SetCharIncludes().
End Rem
Const wxFILTER_INCLUDE_CHAR_LIST:Int = $080

Rem
bbdoc: Use an exclude list.
about: The validator checks if the user input is on the list, complaining if it is. See wxTextValidator::SetExcludes().
End Rem
Const wxFILTER_EXCLUDE_LIST:Int = $100

Rem
bbdoc: Use an exclude list.
about: The validator checks if each input character is in the list (one character per list element), complaining if it is. See wxTextValidator::SetCharExcludes().
End Rem
Const wxFILTER_EXCLUDE_CHAR_LIST:Int = $200

