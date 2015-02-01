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

Import "gdi.bmx"



Rem
bbdoc: A font is an object which determines the appearance of text.
about: Fonts are used for drawing text to a device context, and setting the appearance of a window's text.
<p>
You can retrieve the current system font settings with wxSystemSettings.
</p>
End Rem
Type wxFont Extends wxGDIObject

	Function _create:wxFont(wxObjectPtr:Byte Ptr)
		Local this:wxFont = New wxFont
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Default Constructor.
	End Rem
	Function CreateFont:wxFont()
		Return New wxFont.Create()
	End Function
	
	Rem
	bbdoc: Creates a font object with the specified attributes.
	End Rem
	Function CreateFontWithAttributes:wxFont(pointSize:Int, family:Int, style:Int, weight:Int, ..
			underline:Int = False, faceName:String = "", encoding:Int = wxFONTENCODING_DEFAULT)
		Return New wxFont.CreateWithAttribs(pointSize, family, style, weight, underline, faceName, encoding)
	End Function
	
	Rem
	bbdoc: Default Constructor.
	End Rem
	Method Create:wxFont()
		wxObjectPtr = bmx_wxfont_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Creates a font object with the specified attributes.
	End Rem
	Method CreateWithAttribs:wxFont(pointSize:Int, family:Int, style:Int, weight:Int, ..
			underline:Int = False, faceName:String = "", encoding:Int = wxFONTENCODING_DEFAULT)
		wxObjectPtr = bmx_wxfont_createattr(pointSize, family, style, weight, underline, faceName, encoding)
		Return Self
	End Method
	
	Rem
	bbdoc: Copies the font, returning a new wxFont object.
	End Rem
	Method Copy:wxFont()
		Return _create(bmx_wxfont_copy(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns true if the font is a fixed width (or monospaced) font, false if it is a proportional one or font is invalid.
	End Rem
	Method IsFixedWidth:Int()
		Return bmx_wxfont_isfixedwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current application's default encoding.
	End Rem
	Function GetDefaultEncoding:Int()
		Return bmx_wxfont_getdefaultencoding()
	End Function
	
	Rem
	bbdoc: Returns the font encoding.
	End Rem
	Method GetEncoding:Int()
		Return bmx_wxfont_getencoding(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the typeface name associated with the font, or the empty string if there is no typeface information.
	End Rem
	Method GetFaceName:String()
		Return bmx_wxfont_getfacename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the font family.
	about: See wxFont::SetFamily for a list of valid family identifiers.
	End Rem
	Method GetFamily:Int()
		Return bmx_wxfont_getfamily(wxObjectPtr)
	End Method

	Rem
	bbdoc: Gets the family value as a human-readable string.
	End Rem
	Method GetFamilyString:String()
		Return bmx_wxfont_getfamilystring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the platform-dependent string completely describing this font.
	about: Returned string is always non-empty. Note that the returned string is not meant to be shown or
	edited by the user: a typical use of this function is for serializing in string-form a wxFont object.
	End Rem
	Method GetNativeFontInfoDesc:String()
		Return bmx_wxfont_getnativefontinfodesc(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a user-friendly string for this font object.
	about: Returned string is always non-empty. Some examples of the formats of returned strings
	(which are platform-dependent) are in SetNativeFontInfoUserDesc.
	End Rem
	Method GetNativeFontInfoUserDesc:String()
		Return bmx_wxfont_getnativefontinfouserdesc(wxObjectPtr)
	End Method

	Rem
	bbdoc: Gets the pixel size.
	End Rem
	Method GetPixelSize(w:Int Var, h:Int Var)
		bmx_wxfont_getpixelsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the point size.
	End Rem
	Method GetPointSize:Int()
		Return bmx_wxfont_getpointsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the font is stricken-through, false otherwise.
	End Rem
	Method GetStrikethrough:Int()
		Return bmx_wxfont_getstrikethrough(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the font style.
	about: See #wxFont for a list of valid styles.
	End Rem
	Method GetStyle:Int()
		Return bmx_wxfont_getstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the style as a human-readable string.
	End Rem
	Method GetStyleString:String()
		Return bmx_wxfont_getstylestring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the font is underlined, false otherwise.
	End Rem
	Method GetUnderlined:Int()
		Return bmx_wxfont_getunderlined(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the font weight.
	about: See #wxFont for a list of valid weight identifiers.
	End Rem
	Method GetWeight:Int()
		Return bmx_wxfont_getweight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the weight as a human-readable string.
	End Rem
	Method GetWeightString:String()
		Return bmx_wxfont_getweightstring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this object is a valid font, false otherwise.
	End Rem
	Method IsOk:Int()
		Return bmx_wxfont_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default font encoding.
	End Rem
	Function SetDefaultEncoding(encoding:Int)
		bmx_wxfont_setdefaultencoding(encoding)
	End Function
	
	Rem
	bbdoc: Set the font encoding.
	End Rem
	Method SetEncoding(encoding:Int)
		bmx_wxfont_setencoding(wxObjectPtr, encoding)
	End Method
	
	Rem
	bbdoc: Sets the facename for the font.
	returns True if the given face name exists; False otherwise.
	about: To avoid portability problems, don't rely on a specific face, but specify the font family
	instead or as well. A suitable font will be found on the end-user's system. If both the family and
	the facename are specified, wxWidgets will first search for the specific face, and then for a font
	belonging to the same family.
	End Rem
	Method SetFaceName:Int(name:String)
		Return bmx_wxfont_setfacename(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the font family.
	about: @family can be one of :
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxFONTFAMILY_DEFAULT</td><td>Chooses a default font. </td></tr>
	<tr><td>wxFONTFAMILY_DECORATIVE</td><td>A decorative font. </td></tr>
	<tr><td>wxFONTFAMILY_ROMAN</td><td>A formal, serif font. </td></tr>
	<tr><td>wxFONTFAMILY_SCRIPT</td><td>A handwriting font. </td></tr>
	<tr><td>wxFONTFAMILY_SWISS</td><td>A sans-serif font. </td></tr>
	<tr><td>wxFONTFAMILY_MODERN</td><td>A fixed pitch font. </td></tr>
	<tr><td>wxFONTFAMILY_TELETYPE</td><td>A teletype font. </td></tr>
	</table>
	End Rem
	Method SetFamily(family:Int)
		bmx_wxfont_setfamily(wxObjectPtr, family)
	End Method
	
	Rem
	bbdoc: Creates the font corresponding to the given native font description string and returns true if the creation was successful.
	about: Which must have been previously returned by GetNativeFontInfoDesc. If the string is invalid, font
	is unchanged. This function is typically used for de-serializing a wxFont object previously saved in
	a string-form.
	End Rem
	Method SetNativeFontInfo:Int(info:String)
		Return bmx_wxfont_setnativefontinfo(wxObjectPtr, info)
	End Method
	
	Rem
	bbdoc: Creates the font corresponding to the given native font description string and returns true if the creation was successful.
	about: Unlike SetNativeFontInfo, this function accepts strings which are user-friendly.
	Examples of accepted string formats are:
	<table width="90%" align="center">
	<tr><th>Generic Syntax</th><th>Example</th></tr>
	<tr><td>on wxGTK2: <tt>[FACE-NAME] [bold] [oblique|italic] [POINTSIZE]</tt></td><td>Monospace bold 10</td></tr>
	<tr><td>on wxMSW: <tt>[light|bold] [italic] [FACE-NAME] [POINTSIZE] [ENCODING]</tt></td><td>Tahoma 10 WINDOWS-1252</td></tr>
	<tr><td>On wxMAC : n/a</td><td>n/a</td></tr>
	</table>
	For more detailed information about the allowed syntaxes you can look at the documentation of the
	native API used for font-rendering.
	End Rem
	Method SetNativeFontInfoUserDesc:Int(info:String)
		Return bmx_wxfont_setnativefontinfouserdesc(wxObjectPtr, info)
	End Method
	
	Rem
	bbdoc: Sets the pixel size.
	about: The height parameter of the pixel size must be positive while the width parameter may also
	be zero (to indicate that you're not interested in the width of the characters: a suitable width
	will be chosen for best rendering).
	<p>
	This feature (specifying the font pixel size) is directly supported only under wxMSW and wxGTK
	currently; under other platforms a font with the closest size to the given one is found using
	binary search (this may be slower).
	</p>
	End Rem
	Method SetPixelSize(w:Int, h:Int)
		bmx_wxfont_setpixelsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Sets the point size.
	End Rem
	Method SetPointSize(size:Int)
		bmx_wxfont_setpointsize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets strike-through attribute of the font.
	about: Currently stricken-through fonts are only supported in wxMSW and wxGTK.
	End Rem
	Method SetStrikethrough(strikethrough:Int)
		bmx_wxfont_setstrikethrough(wxObjectPtr, strikethrough)
	End Method

	Rem
	bbdoc: Sets the font style.
	about: @style one of, wxFONTSTYLE_NORMAL, wxFONTSTYLE_SLANT or wxFONTSTYLE_ITALIC.
	End Rem
	Method SetStyle(style:Int)
		bmx_wxfont_setstyle(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Sets underlining.
	End Rem
	Method SetUnderlined(underlined:Int)
		bmx_wxfont_setunderlined(wxObjectPtr, underlined)
	End Method
	
	Rem
	bbdoc: Sets the font weight.
	about: @weight, one of :
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxFONTWEIGHT_NORMAL</td><td>Normal font. </td></tr>
	<tr><td>wxFONTWEIGHT_LIGHT</td><td>Light font. </td></tr>
	<tr><td>wxFONTWEIGHT_BOLD</td><td>Bold font. </td></tr>
	</table>
	End Rem
	Method SetWeight(weight:Int)
		bmx_wxfont_setweight(wxObjectPtr, weight)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxfont_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method


End Type

Rem
bbdoc: Null font
End Rem
Global wxNullFont:wxFont = wxFont._create(bmx_wxfont_null())

Rem
bbdoc: wxFontMapper manages user-definable correspondence between logical font names and the fonts present on the machine.
about: The default implementations of all functions will ask the user if they are not capable of
finding the answer themselves and store the answer in a config file (configurable via SetConfigXXX
functions). This behaviour may be disabled by giving the value of false to "interactive" parameter.
<p>
However, the functions will always consult the config file to allow the user-defined values override
the default logic and there is no way to disable this - which shouldn't be ever needed because if
"interactive" was never true, the config file is never created anyhow.
</p>
<p>
In case everything else fails (i.e. there is no record in config file and "interactive" is false or
user denied to choose any replacement), the class queries wxEncodingConverter for "equivalent"
encodings (e.g. iso8859-2 and cp1250) and tries them.
</p>
End Rem
Type wxFontMapper

	Rem
	bbdoc: Returns the n-th supported encoding.
	about: Together with GetSupportedEncodingsCount() this method may be used to get all supported encodings.
	End Rem
	Function GetEncoding:Int(n:Int)
		Return bmx_wxfontmapper_getencoding(n)
	End Function
	
	Rem
	bbdoc: Return user-readable string describing the given encoding.
	End Rem
	Function GetEncodingDescription:String(encoding:Int)
		Return bmx_wxfontmapper_getencodingdescription(encoding)
	End Function

	Rem
	bbdoc: Return internal string identifier for the encoding (see also GetEncodingDescription())
	End Rem
	Function GetEncodingName:String(encoding:Int)
		Return bmx_wxfontmapper_getencodingname(encoding)
	End Function
	
	Rem
	bbdoc: Returns the number of the font encodings supported by this class.
	about: Together with GetEncoding this method may be used to get all supported encodings.
	End Rem
	Function GetSupportedEncodingsCount:Int()
		Return bmx_wxfontmapper_getsupportedencodingcount()
	End Function
	
End Type



Const wxFONTENCODING_SYSTEM:Int = -1     ' system Default
Const wxFONTENCODING_DEFAULT:Int = 0         ' current Default encoding

' ISO8859 standard defines a number of single-Byte charsets
Const wxFONTENCODING_ISO8859_1:Int = 1       ' West European (Latin1)
Const wxFONTENCODING_ISO8859_2:Int = 2       ' Central And East European (Latin2)
Const wxFONTENCODING_ISO8859_3:Int = 3       ' Esperanto (Latin3)
Const wxFONTENCODING_ISO8859_4:Int = 4       ' Baltic (old) (Latin4)
Const wxFONTENCODING_ISO8859_5:Int = 5       ' Cyrillic
Const wxFONTENCODING_ISO8859_6:Int = 6       ' Arabic
Const wxFONTENCODING_ISO8859_7:Int = 7       ' Greek
Const wxFONTENCODING_ISO8859_8:Int = 8       ' Hebrew
Const wxFONTENCODING_ISO8859_9:Int = 9       ' Turkish (Latin5)
Const wxFONTENCODING_ISO8859_10:Int = 10      ' Variation of Latin4 (Latin6)
Const wxFONTENCODING_ISO8859_11:Int = 11      ' Thai
Const wxFONTENCODING_ISO8859_12:Int = 12      ' doesn't exist currently:int =  but put it
                            ' here anyhow To make all ISO8859
                            ' consecutive numbers
Const wxFONTENCODING_ISO8859_13:Int = 13      ' Baltic (Latin7)
Const wxFONTENCODING_ISO8859_14:Int = 14      ' Latin8
Const wxFONTENCODING_ISO8859_15:Int = 15      ' Latin9 (a.k.a. Latin0:int =  includes euro)
Const wxFONTENCODING_ISO8859_MAX:Int = 16

' Cyrillic charset soup (see http:'czyborra.com/charsets/cyrillic.html)
Const wxFONTENCODING_KOI8:Int = 17            ' KOI8 Russian
Const wxFONTENCODING_KOI8_U:Int = 18          ' KOI8 Ukrainian
Const wxFONTENCODING_ALTERNATIVE:Int = 19     ' same as MS-DOS CP866
Const wxFONTENCODING_BULGARIAN:Int = 20       ' used under Linux in Bulgaria

' what would we do without Microsoft? They have their own encodings
' For DOS
Const wxFONTENCODING_CP437:Int = 21           ' original MS-DOS codepage
Const wxFONTENCODING_CP850:Int = 22           ' CP437 merged with Latin1
Const wxFONTENCODING_CP852:Int = 23           ' CP437 merged with Latin2
Const wxFONTENCODING_CP855:Int = 24           ' another cyrillic encoding
Const wxFONTENCODING_CP866:Int = 25           ' And another one
' And For Windows
Const wxFONTENCODING_CP874:Int = 26           ' WinThai
Const wxFONTENCODING_CP932:Int = 27           ' Japanese (shift-JIS)
Const wxFONTENCODING_CP936:Int = 28           ' Chinese simplified (GB)
Const wxFONTENCODING_CP949:Int = 29           ' Korean (Hangul charset)
Const wxFONTENCODING_CP950:Int = 30           ' Chinese (traditional - Big5)
Const wxFONTENCODING_CP1250:Int = 31          ' WinLatin2
Const wxFONTENCODING_CP1251:Int = 32          ' WinCyrillic
Const wxFONTENCODING_CP1252:Int = 33          ' WinLatin1
Const wxFONTENCODING_CP1253:Int = 34          ' WinGreek (8859-7)
Const wxFONTENCODING_CP1254:Int = 35          ' WinTurkish
Const wxFONTENCODING_CP1255:Int = 36          ' WinHebrew
Const wxFONTENCODING_CP1256:Int = 37          ' WinArabic
Const wxFONTENCODING_CP1257:Int = 38          ' WinBaltic (same as Latin 7)
Const wxFONTENCODING_CP12_MAX:Int = 39

Const wxFONTENCODING_UTF7:Int = 40            ' UTF-7 Unicode encoding
Const wxFONTENCODING_UTF8:Int = 41            ' UTF-8 Unicode encoding
Const wxFONTENCODING_EUC_JP:Int = 42          ' Extended Unix Codepage For Japanese
Const wxFONTENCODING_UTF16BE:Int = 43         ' UTF-16 Big Endian Unicode encoding
Const wxFONTENCODING_UTF16LE:Int = 44         ' UTF-16 Little Endian Unicode encoding
Const wxFONTENCODING_UTF32BE:Int = 45         ' UTF-32 Big Endian Unicode encoding
Const wxFONTENCODING_UTF32LE:Int = 46         ' UTF-32 Little Endian Unicode encoding

Const wxFONTENCODING_MACROMAN:Int = 47        ' the standard mac encodings
Const wxFONTENCODING_MACJAPANESE:Int = 48
Const wxFONTENCODING_MACCHINESETRAD:Int = 49
Const wxFONTENCODING_MACKOREAN:Int = 50
Const wxFONTENCODING_MACARABIC:Int = 51
Const wxFONTENCODING_MACHEBREW:Int = 52
Const wxFONTENCODING_MACGREEK:Int = 53
Const wxFONTENCODING_MACCYRILLIC:Int = 54
Const wxFONTENCODING_MACDEVANAGARI:Int = 55
Const wxFONTENCODING_MACGURMUKHI:Int = 56
Const wxFONTENCODING_MACGUJARATI:Int = 57
Const wxFONTENCODING_MACORIYA:Int = 58
Const wxFONTENCODING_MACBENGALI:Int = 59
Const wxFONTENCODING_MACTAMIL:Int = 60
Const wxFONTENCODING_MACTELUGU:Int = 61
Const wxFONTENCODING_MACKANNADA:Int = 62
Const wxFONTENCODING_MACMALAJALAM:Int = 63
Const wxFONTENCODING_MACSINHALESE:Int = 64
Const wxFONTENCODING_MACBURMESE:Int = 65
Const wxFONTENCODING_MACKHMER:Int = 66
Const wxFONTENCODING_MACTHAI:Int = 67
Const wxFONTENCODING_MACLAOTIAN:Int = 68
Const wxFONTENCODING_MACGEORGIAN:Int = 69
Const wxFONTENCODING_MACARMENIAN:Int = 70
Const wxFONTENCODING_MACCHINESESIMP:Int = 71
Const wxFONTENCODING_MACTIBETAN:Int = 72
Const wxFONTENCODING_MACMONGOLIAN:Int = 73
Const wxFONTENCODING_MACETHIOPIC:Int = 74
Const wxFONTENCODING_MACCENTRALEUR:Int = 75
Const wxFONTENCODING_MACVIATNAMESE:Int = 76
Const wxFONTENCODING_MACARABICEXT:Int = 77
Const wxFONTENCODING_MACSYMBOL:Int = 78
Const wxFONTENCODING_MACDINGBATS:Int = 79
Const wxFONTENCODING_MACTURKISH:Int = 80
Const wxFONTENCODING_MACCROATIAN:Int = 81
Const wxFONTENCODING_MACICELANDIC:Int = 82
Const wxFONTENCODING_MACROMANIAN:Int = 83
Const wxFONTENCODING_MACCELTIC:Int = 84
Const wxFONTENCODING_MACGAELIC:Int = 85
Const wxFONTENCODING_MACKEYBOARD:Int = 86

Const wxFONTENCODING_MAX:Int = 87             ' highest enumerated encoding value

Const wxFONTENCODING_MACMIN:Int = wxFONTENCODING_MACROMAN
Const wxFONTENCODING_MACMAX:Int = wxFONTENCODING_MACKEYBOARD

' aliases For endian-dependent UTF encodings
?ppc
Const wxFONTENCODING_UTF16:Int = wxFONTENCODING_UTF16BE   ' native UTF-16
Const wxFONTENCODING_UTF32:Int = wxFONTENCODING_UTF32BE   ' native UTF-32
?
?Not ppc
Const wxFONTENCODING_UTF16:Int = wxFONTENCODING_UTF16LE   ' native UTF-16
Const wxFONTENCODING_UTF32:Int = wxFONTENCODING_UTF32LE   ' native UTF-32
?

' alias For the native Unicode encoding on this platform
' (this is used by wxEncodingConverter And wxUTFFile only For now)
'#If SIZEOF_WCHAR_T == 2
Const wxFONTENCODING_UNICODE:Int = wxFONTENCODING_UTF16 
'#Else ' SIZEOF_WCHAR_T == 4
'Const wxFONTENCODING_UNICODE = wxFONTENCODING_UTF32:int = 
'#EndIf

' alternative names For Far Eastern encodings
' Chinese
Const wxFONTENCODING_GB2312:Int = wxFONTENCODING_CP936 ' Simplified Chinese
Const wxFONTENCODING_BIG5:Int = wxFONTENCODING_CP950    ' Traditional Chinese

' Japanese (see http:'zsigri.tripod.com/fontboard/cjk/jis.html)
Const wxFONTENCODING_SHIFT_JIS:Int = wxFONTENCODING_CP932 ' Shift JIS


