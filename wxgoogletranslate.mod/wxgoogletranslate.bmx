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
bbdoc: wxGoogleTranslate
End Rem
Module wx.wxGoogleTranslate

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: Provides access to the online Google Translation service.
End Rem
Type wxGoogleTranslate

	Rem
	bbdoc: Returns the list of all suported languages.
	End Rem
	Function GetLanguages:String[]()
		Return bmx_wxgoogletranslate_getlanguages()
	End Function
	
	Rem
	bbdoc: Returns a language code by language name.
	returns: Language code on success or empty string on error.
	End Rem
	Function GetLanguageCode:String(languageName:String)
		Return bmx_wxgoogletranslate_getlanguagecode(languageName)
	End Function
	
	Rem
	bbdoc: Translates given text with Google Translate service.
	returns: True on success, otherwise False.
	End Rem
	Function Translate:Int(source:String, result:String Var, sourceLanguageCode:String, resultLanguageCode:String, translationDetails:String Var, errorCode:Int Var)
		Local str:String[] = New String[2]
		
		Local res:Int = bmx_wxgoogletranslate_translate(source, sourceLanguageCode, resultLanguageCode, str, Varptr errorCode)
		
		result = str[0]
		translationDetails = str[1]
		
		Return res
	End Function

End Type



