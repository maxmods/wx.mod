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

Module wx.wxLocale

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
bbdoc: This function returns the translation of string str in the current locale.
about: If the string is not found in any of the loaded message catalogs (see internationalization
overview), the original string is returned. If domain is specified then only that domain/catalog is
searched for a matching string. As this function is used very often, an alternative (and also
common in Unix world) syntax is provided: the _() function is defined to do the same thing as
wxGetTranslation.
End Rem
Function wxGetTranslation:String(str:String, domain:String = Null)
	str = str.Replace("~~", "~~~~")
	str = str.Replace("~t", "~~t")
	str = str.Replace("~n", "~~n")
	str = str.Replace("~r", "~~r")
	str = str.Replace("~q", "~~q")
	Return bmx_wxlocale_wxgettranslation(str, domain)
End Function

Rem
bbdoc: Performs the same function as wxGetTranslation.
End Rem
Function _:String(str:String, domain:String = Null)
	str = str.Replace("~~", "~~~~")
	str = str.Replace("~t", "~~t")
	str = str.Replace("~n", "~~n")
	str = str.Replace("~r", "~~r")
	str = str.Replace("~q", "~~q")
	Return bmx_wxlocale_wxgettranslation(str, domain)
End Function

Rem
bbdoc: This function is used when retrieving translation of string which has different singular and plural form in English or different plural forms in some other language.
about: It takes two extra arguments: @str parameter must contain the singular form of the
string to be converted and is used as the key for the search in the catalog. The @strPlural
parameter is the plural form (in English). The parameter n is used to determine the plural form.
If no message catalog is found @str is returned if 'n = 1', otherwise @strPlural.
End Rem
Function wxGetTranslationN:String(str:String, strPlural:String, n:Int, domain:String = Null)
	str = str.Replace("~~", "~~~~")
	str = str.Replace("~t", "~~t")
	str = str.Replace("~n", "~~n")
	str = str.Replace("~r", "~~r")
	str = str.Replace("~q", "~~q")
	Return bmx_wxlocale_wxgettranslationp(str, strPlural, n, domain)
End Function

Rem
bbdoc: Performs the same function as wxGetTranslationN.
End Rem
Function _N:String(str:String, strPlural:String, n:Int, domain:String = Null)
	str = str.Replace("~~", "~~~~")
	str = str.Replace("~t", "~~t")
	str = str.Replace("~n", "~~n")
	str = str.Replace("~r", "~~r")
	str = str.Replace("~q", "~~q")
	Return bmx_wxlocale_wxgettranslationp(str, strPlural, n, domain)
End Function

Rem
bbdoc: Encapsulates all language-dependent settings and is a generalization of the C locale concept.
about: This type manages message catalogs which contain the translations of the strings used to the current language.
End Rem
Type wxLocale

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Function CreateLocale:wxLocale(language:Int = -1, flags:Int = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING)	
		Return New wxLocale.Create(language, flags)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxLocale(language:Int = -1, flags:Int = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING)
		wxObjectPtr = bmx_wxlocale_create(language, flags)
		Return Self
	End Method
	
	Rem
	bbdoc: Add a catalog for use with the current locale
	about: It is searched for in standard places (current directory first, then the system one),
	but you may also prepend additional directories to the search path with
	AddCatalogLookupPathPrefix().
	<p>
	All loaded catalogs will be used for message lookup by GetString() for the current locale.
	</p>
	End Rem
	Method AddCatalog:Int(domain:String)
		Return bmx_wxlocale_addcatalog(wxObjectPtr, domain)
	End Method
	
	Rem
	bbdoc: Add a catalog for use with the current locale
	about: It is searched for in standard places (current directory first, then the system one),
	but you may also prepend additional directories to the search path with
	AddCatalogLookupPathPrefix().
	<p>
	All loaded catalogs will be used for message lookup by GetString() for the current locale.
	</p>
	<p>
	@language specifies the language of "msgid" strings in source code (i.e. arguments to GetString,
	wxGetTranslation and the _() macro). It is used if AddCatalog cannot find any catalog for
	current language: if the language is same as source code language, then strings from source
	code are used instead.
	</p>
	<p>
	@msgIdCharset lets you specify the charset used for msgids in sources in case they use 8-bit
	characters (e.g. German or French strings). This argument has no effect in Unicode build,
	because literals in sources are Unicode strings; you have to use compiler-specific method of
	setting the right charset when compiling with Unicode.
	</p>
	End Rem
	Method AddCatalogLang:Int(domain:String, language:Int, msgIdCharSet:String)
		Return bmx_wxlocale_addcataloglang(wxObjectPtr, domain, language, msgIdCharSet)
	End Method
	
	Rem
	bbdoc: Add a prefix to the catalog lookup path: the message catalog files will be looked up under prefix/<lang>/LC_MESSAGES, prefix/<lang> and prefix (in this order).
	about: This only applies to subsequent invocations of AddCatalog().
	End Rem
	Function AddCatalogLookupPathPrefix(prefix:String)
		bmx_wxlocale_addcataloglookuppathprefix(prefix)
	End Function
	
	Rem
	bbdoc: Adds custom, user-defined language to the database of known languages.
	about: The language field of wxLanguageInfo should be greater than wxLANGUAGE_USER_DEFINED.
	End Rem
	Function AddLanguage(info:wxLanguageInfo)
		bmx_wxlocale_addlanguage(info.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: This function may be used to find the language description structure for the given locale, specified either as a two letter ISO language code (for example, "pt"), a language code followed by the country code ("pt_BR") or a full, human readable, language description ("Portuguese-Brazil").
	returns: The information for the given language or Null if this language is unknown.
	End Rem
	Function FindLanguageInfo:wxLanguageInfo(locale:String)
		Return wxLanguageInfo._create(bmx_wxlocale_findlanguageinfo(locale))
	End Function
	
	Rem
	bbdoc: Returns the canonical form of current locale name.
	about: Canonical form is the one that is used on UNIX systems: it is a two- or five-letter
	string in xx or xx_YY format, where xx is ISO 639 code of language and YY is ISO 3166 code of
	the country. Examples are "en", "en_GB", "en_US" or "fr_FR".
	<p>
	This form is internally used when looking up message catalogs.
	</p>
	End Rem
	Method GetCanonicalName:String()
		Return bmx_wxlocale_getcanonicalname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the language constant of current language.
	End Rem
	Method GetLanguage:Int()
		Return bmx_wxlocale_getlanguage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a wxLanguageInfo object containing information about the given language or Null if this language is unknown.
	about: See AddLanguage for the wxLanguageInfo description.
	<p>
	As with Init, wxLANGUAGE_DEFAULT has the special meaning if passed as an argument to this
	method and in this case the result of GetSystemLanguage() is used.
	</p>
	End Rem
	Function GetLanguageInfo:wxLanguageInfo(lang:Int)
		Return wxLanguageInfo._create(bmx_wxlocale_getlanguageinfo(lang))
	End Function
	
	Rem
	bbdoc: Returns English name of the given language or empty string if this language is unknown.
	about: See GetLanguageInfo for a remark about special meaning of wxLANGUAGE_DEFAULT.
	End Rem
	Function GetLanguageName:String(lang:Int)
		Return bmx_wxlocale_getlanguagename(lang)
	End Function
	
	Rem
	bbdoc: Returns the locale name as passed to the constructor or Init().
	about: This is the full, human-readable name, e.g. "English" or "French".
	End Rem
	Method GetLocale:String()
		Return bmx_wxlocale_getlocale(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current short name for the locale (as given to the constructor or the Init() method).
	End Rem
	Method GetName:String()
		Return bmx_wxlocale_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Retrieves the translation for a string in all loaded domains unless the @domain parameter is specified (and then only this catalog/domain is searched).
	returns: The original string if translation is not available (in this case an error message is
	generated the first time a string is not found; use wxLogNull to suppress it).
	End Rem
	Method GetString:String(str:String, domain:String = Null)
		str = str.Replace("~~", "~~~~")
		str = str.Replace("~t", "~~t")
		str = str.Replace("~n", "~~n")
		str = str.Replace("~r", "~~r")
		str = str.Replace("~q", "~~q")
		Return bmx_wxlocale_getstring(wxObjectPtr, str, domain)
	End Method
	
	Rem
	bbdoc: Retrieves a translation of a string that has different singular and plural form in English or different plural forms in some other language.
	about: It takes two extra arguments: @str parameter must contain the singular form of the string
	to be converted. It is also used as the key for the search in the catalog. The @strPlural
	parameter is the plural form (in English). The parameter @n is used to determine the plural form.
	If no message catalog is found szOrigString is returned if 'n = 1', otherwise @strPlural. See
	GNU gettext manual for additional information on plural forms handling.
	End Rem
	Method GetStringN:String(str:String, strPlural:String, n:Int, domain:String = Null)
		str = str.Replace("~~", "~~~~")
		str = str.Replace("~t", "~~t")
		str = str.Replace("~n", "~~n")
		str = str.Replace("~r", "~~r")
		str = str.Replace("~q", "~~q")
		Return bmx_wxlocale_getstringp(wxObjectPtr, str, strPlural, n, domain)
	End Method
	
	Rem
	bbdoc: Returns the header value for @header.
	about: The search for @header is case sensitive. If a @domain is passed, this domain is
	searched. Else all domains will be searched until a header has been found. The return value
	is the value of the header if found. Else this will be empty.
	End Rem
	Method GetHeaderValue:String(header:String, domain:String = Null)
		Return bmx_wxlocale_getheadervalue(wxObjectPtr, header, domain)
	End Method
	
	Rem
	bbdoc: Returns current platform-specific locale name as passed to setlocale().
	End Rem
	Method GetSysName:String()
		Return bmx_wxlocale_getsysname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Tries to detect the user's default font encoding.
	returns: The font-encoding value or wxFONTENCODING_SYSTEM if it couldn't be determined.
	End Rem
	Function GetSystemEncoding:Int()
		Return bmx_wxlocale_getsystemencoding()
	End Function
	
	Rem
	bbdoc: Tries to detect the name of the user's default font encoding.
	returns: A user-readable string value or an empty string if it couldn't be determined.
	about: This string isn't particularly useful for the application as its form is
	platform-dependent and so you should probably use GetSystemEncoding instead.
	End Rem
	Function GetSystemEncodingName:String()
		Return bmx_wxlocale_getsystemencodingname()
	End Function
	
	Rem
	bbdoc: Tries to detect the user's default language setting.
	about: Returns the language value or wxLANGUAGE_UNKNOWN if the language-guessing algorithm failed.
	End Rem
	Function GetSystemLanguage:Int()
		Return bmx_wxlocale_getsystemlanguage()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Init:Int(language:Int = wxLANGUAGE_DEFAULT, flags:Int = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING)
		Return bmx_wxlocale_init(wxObjectPtr, language, flags)
	End Method
	
	Rem
	bbdoc: Check whether the operating system and/or C run time environment supports this locale.
	about: For example in Windows 2000 and Windows XP, support for many locales is not installed
	by default. Returns true if the locale is supported.
	<p>
	The argument @lang is the wxLanguage identifier. To obtain this for a given a two letter ISO
	language code, use FindLanguageInfo to obtain its wxLanguageInfo structure. See AddLanguage
	for the wxLanguageInfo description.
	</p>
	End Rem
	Function IsAvailable:Int(lang:Int)
		Return bmx_wxlocale_isavailable(lang)
	End Function
	
	Rem
	bbdoc: Check if the given catalog is loaded, and returns true if it is.
	about: According to GNU gettext tradition, each catalog normally corresponds to 'domain'
	which is more or less the application name.
	End Rem
	Method IsLoaded:Int(domain:String)
		Return bmx_wxlocale_isloaded(wxObjectPtr, domain)
	End Method
	
	Rem
	bbdoc: Returns true if the locale could be set successfully.
	End Rem
	Method IsOk:Int()
		Return bmx_wxlocale_isok(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxlocale_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Details of a Language.
End Rem
Type wxLanguageInfo

	Field wxObjectPtr:Byte Ptr

	Function _create:wxLanguageInfo(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxLanguageInfo = New wxLanguageInfo
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateLanguageInfo:wxLanguageInfo()
		Return New wxLanguageInfo.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxLanguageInfo()
		wxObjectPtr = bmx_wxlanguageinfo_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the language Id
	End Rem
	Method SetLanguage(language:Int)
		bmx_wxlanguageinfo_setlanguage(wxObjectPtr, language)
	End Method

	Rem
	bbdoc: Gets the language id
	End Rem
	Method GetLanguage:Int()
		Return bmx_wxlanguageinfo_getlanguage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the Canonical name, e.g. fr_FR
	End Rem
	Method SetCanonicalName(name:String)
		bmx_wxlanguageinfo_setcanonicalname(wxObjectPtr, name)
	End Method

	Rem
	bbdoc: Gets the Canonical name, e.g. fr_FR
	End Rem
	Method GetCanonicalName:String()
		Return bmx_wxlanguageinfo_getcanonicalname(wxObjectPtr)
	End Method
	
?win32
	Rem
	bbdoc: Sets the Win32 language identifier - LANG_xxxx
	End Rem
	Method SetWinLang(lang:Int)
		bmx_wxlanguageinfo_setwinlang(wxObjectPtr, lang)
	End Method

	Rem
	bbdoc: Gets the Win32 language identifier - LANG_xxxx
	End Rem
	Method GetWinLang:Int()
		Return bmx_wxlanguageinfo_getwinlang(wxObjectPtr)
	End Method
		
	Rem
	bbdoc: Sets the Win32 language identifier - SUBLANG_xxxx
	End Rem
	Method SetWinSublang(lang:Int)
		bmx_wxlanguageinfo_setwinsublang(wxObjectPtr, lang)
	End Method
	
	Rem
	bbdoc: Gets the Win32 language identifier - SUBLANG_xxxx
	End Rem
	Method GetWinSubLang:Int()
		Return bmx_wxlanguageinfo_getwinsublang(wxObjectPtr)
	End Method
?

	Rem
	bbdoc: Sets the human-readable name of the language
	End Rem
	Method SetDescription(desc:String)
		bmx_wxlanguageinfo_setdescription(wxObjectPtr, desc)
	End Method

	Rem
	bbdoc: Gets the human-readable name of the language
	End Rem
	Method GetDescription:String()
		Return bmx_wxlanguageinfo_getdescription(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxlanguageinfo_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

