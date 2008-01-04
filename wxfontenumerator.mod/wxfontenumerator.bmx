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
bbdoc: wxFontEnumerator
End Rem
Module wx.wxFontEnumerator

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
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
bbdoc: wxFontEnumerator enumerates either all available fonts on the system or only the ones with given attributes - either only fixed-width (suited for use in programs such as terminal emulators and the like) or the fonts available in the given encoding.
about: To do this, you just have to call one of EnumerateXXX() methods - either EnumerateFacenames or
EnumerateEncodings and the corresponding callback (OnFacename or OnFontEncoding) will be called repeatedly
until either all fonts satisfying the specified criteria are exhausted or the callback returns false.
End Rem
Type wxFontEnumerator

	Field wxFontEnumeratorPtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Function CreateFontEnumerator:wxFontEnumerator()
		Return New wxFontEnumerator.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxFontEnumerator()
		wxFontEnumeratorPtr = bmx_wxfontenumerator_create(Self)
		Return Self
	End Method
	
	Rem
	bbdoc: Call OnFacename for each font which supports given encoding (only if it is not wxFONTENCODING_SYSTEM) and is of fixed width (if fixedWidthOnly is true).
	about: Calling this method with default arguments will result in enumerating all fonts available on
	the system.
	End Rem
	Method EnumerateFacenames:Int(encoding:Int = wxFONTENCODING_SYSTEM, fixedWidthOnly:Int = False)
		Return bmx_wxfontenumerator_enumeratefacenames(wxFontEnumeratorPtr, encoding, fixedWidthOnly)
	End Method
	
	Rem
	bbdoc: Call OnFontEncoding for each encoding supported by the given font - or for each encoding supported by at least some font if font is not specified.
	End Rem
	Method EnumerateEncodings:Int(font:String = "")
		Return bmx_wxfontenumerator_enumerateencodings(wxFontEnumeratorPtr, font)
	End Method
	
	Rem
	bbdoc: Return array of strings containing all encodings found by EnumerateEncodings.
	End Rem
	Function GetEncodings:String[](facename:String)
		Return bmx_wxfontenumerator_getencodings(facename)
	End Function
	
	Rem
	bbdoc: Return array of strings containing all facenames found by EnumerateFacenames.
	End Rem
	Function GetFacenames:String[](encoding:Int = wxFONTENCODING_SYSTEM, fixedWidthOnly:Int = False)
		Return bmx_wxfontenumerator_getfacenames(encoding, fixedWidthOnly)
	End Function
	
	Rem
	bbdoc: Returns true if the given string is valid face name, i.e. it's the face name of an installed font and it can safely be used with wxFont::SetFaceName.
	End Rem
	Function IsValidFacename:Int(facename:String)
		Return bmx_wxfontenumerator_isvalidfacename(facename)
	End Function

	Rem
	bbdoc: Called by EnumerateFacenames for each match.
	about: Return true to continue enumeration or false to stop it.
	End Rem
	Method OnFacename:Int(font:String)
		Return True
	End Method
	
	Rem
	bbdoc: Called by EnumerateEncodings for each match.
	about: Return true to continue enumeration or false to stop it.
	End Rem
	Method OnFontEncoding:Int(font:String, encoding:String)
		Return True
	End Method

	Function _OnFacename:Int(obj:Object, font:String)
		Return wxFontEnumerator(obj).OnFacename(font)
	End Function

	Function _OnFontEncoding:Int(obj:Object, font:String, encoding:String)
		Return wxFontEnumerator(obj).OnFontEncoding(font, encoding)
	End Function
	
	Method Delete()
		If wxFontEnumeratorPtr Then
			bmx_wxfontenumerator_delete(wxFontEnumeratorPtr)
			wxFontEnumeratorPtr = Null
		End If
	End Method
	
End Type

