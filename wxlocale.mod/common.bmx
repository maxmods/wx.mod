' Copyright (c) 2007 Bruce A Henderson
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

Import "glue.cpp"

Extern

	Function bmx_wxlocale_create:Byte Ptr(language:Int, flags:Int)

	Function bmx_wxlocale_wxgettranslation:String(str:String, domain:String)
	Function bmx_wxlocale_wxgettranslationp:String(str:String, strPlural:String, n:Int, domain:String)

	Function bmx_wxlocale_addlanguage(info:Byte Ptr)
	Function bmx_wxlocale_findlanguageinfo:Byte Ptr(locale:String)

	Function bmx_wxlocale_addcatalog:Int(handle:Byte Ptr, domain:String)
	Function bmx_wxlocale_addcataloglang:Int(handle:Byte Ptr, domain:String, language:Int, msgIdCharSet:String)
	Function bmx_wxlocale_addcataloglookuppathprefix(prefix:String)
	Function bmx_wxlocale_getcanonicalname:String(handle:Byte Ptr)
	Function bmx_wxlocale_getlanguage:Int(handle:Byte Ptr)
	Function bmx_wxlocale_getlanguageinfo:Byte Ptr(lang:Int)
	Function bmx_wxlocale_getlanguagename:String(lang:Int)
	Function bmx_wxlocale_getlocale:String(handle:Byte Ptr)
	Function bmx_wxlocale_getname:String(handle:Byte Ptr)
	Function bmx_wxlocale_getstring:String(handle:Byte Ptr, str:String, domain:String)
	Function bmx_wxlocale_getstringp:String(handle:Byte Ptr, str:String, strPlural:String, n:Int, domain:String)
	Function bmx_wxlocale_getheadervalue:String(handle:Byte Ptr, header:String, domain:String)
	Function bmx_wxlocale_getsysname:String(handle:Byte Ptr)
	Function bmx_wxlocale_getsystemencoding:Int()
	Function bmx_wxlocale_getsystemencodingname:String()
	Function bmx_wxlocale_getsystemlanguage:Int()
	Function bmx_wxlocale_init:Int(handle:Byte Ptr, language:Int, flags:Int)
	Function bmx_wxlocale_isavailable:Int(lang:Int)
	Function bmx_wxlocale_isloaded:Int(handle:Byte Ptr, domain:String)
	Function bmx_wxlocale_isok:Int(handle:Byte Ptr)

	Function bmx_wxlocale_delete(handle:Byte Ptr)

	Function bmx_wxlanguageinfo_create:Byte Ptr()
	Function bmx_wxlanguageinfo_setlanguage(handle:Byte Ptr, language:Int)
	Function bmx_wxlanguageinfo_getlanguage:Int(handle:Byte Ptr)
	Function bmx_wxlanguageinfo_setcanonicalname(handle:Byte Ptr, name:String)
	Function bmx_wxlanguageinfo_getcanonicalname:String(handle:Byte Ptr)
?win32
	Function bmx_wxlanguageinfo_setwinlang(handle:Byte Ptr, lang:Int)
	Function bmx_wxlanguageinfo_getwinlang:Int(handle:Byte Ptr)
	Function bmx_wxlanguageinfo_setwinsublang(handle:Byte Ptr, lang:Int)
	Function bmx_wxlanguageinfo_getwinsublang:Int(handle:Byte Ptr)
?
	Function bmx_wxlanguageinfo_setdescription(handle:Byte Ptr, desc:String)
	Function bmx_wxlanguageinfo_getdescription:String(handle:Byte Ptr)
	Function bmx_wxlanguageinfo_delete(handle:Byte Ptr)

End Extern

Const wxLOCALE_LOAD_DEFAULT:Int  = $0001      ' Load wxwin.mo?
Const wxLOCALE_CONV_ENCODING:Int = $0002      ' convert encoding on the fly?

Const wxLOCALE_CAT_NUMBER:Int = 0
' date/time
Const wxLOCALE_CAT_DATE:Int = 1
' monetary value
Const wxLOCALE_CAT_MONEY:Int = 2
Const wxLOCALE_CAT_MAX:Int = 3

' the thounsands separator
Const wxLOCALE_THOUSANDS_SEP:Int = 0

' the character used as decimal point
Const wxLOCALE_DECIMAL_POINT:Int = 1

Rem
bbdoc: User's default language as obtained from the operating system
end rem
Const wxLANGUAGE_DEFAULT:Int = 0
Rem
bbdoc: Unknown language - if wxLocale::GetSystemLanguage fails
end rem
Const wxLANGUAGE_UNKNOWN:Int = 1
Const wxLANGUAGE_ABKHAZIAN:Int = 2
Const wxLANGUAGE_AFAR:Int = 3
Const wxLANGUAGE_AFRIKAANS:Int = 4
Const wxLANGUAGE_ALBANIAN:Int = 5
Const wxLANGUAGE_AMHARIC:Int = 6
Const wxLANGUAGE_ARABIC:Int = 7
Const wxLANGUAGE_ARABIC_ALGERIA:Int = 8
Const wxLANGUAGE_ARABIC_BAHRAIN:Int = 9
Const wxLANGUAGE_ARABIC_EGYPT:Int = 10
Const wxLANGUAGE_ARABIC_IRAQ:Int = 11
Const wxLANGUAGE_ARABIC_JORDAN:Int = 12
Const wxLANGUAGE_ARABIC_KUWAIT:Int = 13
Const wxLANGUAGE_ARABIC_LEBANON:Int = 14
Const wxLANGUAGE_ARABIC_LIBYA:Int = 15
Const wxLANGUAGE_ARABIC_MOROCCO:Int = 16
Const wxLANGUAGE_ARABIC_OMAN:Int = 17
Const wxLANGUAGE_ARABIC_QATAR:Int = 18
Const wxLANGUAGE_ARABIC_SAUDI_ARABIA:Int = 19
Const wxLANGUAGE_ARABIC_SUDAN:Int = 20
Const wxLANGUAGE_ARABIC_SYRIA:Int = 21
Const wxLANGUAGE_ARABIC_TUNISIA:Int = 22
Const wxLANGUAGE_ARABIC_UAE:Int = 23
Const wxLANGUAGE_ARABIC_YEMEN:Int = 24
Const wxLANGUAGE_ARMENIAN:Int = 25
Const wxLANGUAGE_ASSAMESE:Int = 26
Const wxLANGUAGE_AYMARA:Int = 27
Const wxLANGUAGE_AZERI:Int = 28
Const wxLANGUAGE_AZERI_CYRILLIC:Int = 29
Const wxLANGUAGE_AZERI_LATIN:Int = 30
Const wxLANGUAGE_BASHKIR:Int = 31
Const wxLANGUAGE_BASQUE:Int = 32
Const wxLANGUAGE_BELARUSIAN:Int = 33
Const wxLANGUAGE_BENGALI:Int = 34
Const wxLANGUAGE_BHUTANI:Int = 35
Const wxLANGUAGE_BIHARI:Int = 36
Const wxLANGUAGE_BISLAMA:Int = 37
Const wxLANGUAGE_BRETON:Int = 38
Const wxLANGUAGE_BULGARIAN:Int = 39
Const wxLANGUAGE_BURMESE:Int = 40
Const wxLANGUAGE_CAMBODIAN:Int = 41
Const wxLANGUAGE_CATALAN:Int = 42
Const wxLANGUAGE_CHINESE:Int = 43
Const wxLANGUAGE_CHINESE_SIMPLIFIED:Int = 44
Const wxLANGUAGE_CHINESE_TRADITIONAL:Int = 45
Const wxLANGUAGE_CHINESE_HONGKONG:Int = 46
Const wxLANGUAGE_CHINESE_MACAU:Int = 47
Const wxLANGUAGE_CHINESE_SINGAPORE:Int = 48
Const wxLANGUAGE_CHINESE_TAIWAN:Int = 49
Const wxLANGUAGE_CORSICAN:Int = 50
Const wxLANGUAGE_CROATIAN:Int = 51
Const wxLANGUAGE_CZECH:Int = 52
Const wxLANGUAGE_DANISH:Int = 53
Const wxLANGUAGE_DUTCH:Int = 54
Const wxLANGUAGE_DUTCH_BELGIAN:Int = 55
Const wxLANGUAGE_ENGLISH:Int = 56
Const wxLANGUAGE_ENGLISH_UK:Int = 57
Const wxLANGUAGE_ENGLISH_US:Int = 58
Const wxLANGUAGE_ENGLISH_AUSTRALIA:Int = 59
Const wxLANGUAGE_ENGLISH_BELIZE:Int = 60
Const wxLANGUAGE_ENGLISH_BOTSWANA:Int = 61
Const wxLANGUAGE_ENGLISH_CANADA:Int = 62
Const wxLANGUAGE_ENGLISH_CARIBBEAN:Int = 63
Const wxLANGUAGE_ENGLISH_DENMARK:Int = 64
Const wxLANGUAGE_ENGLISH_EIRE:Int = 65
Const wxLANGUAGE_ENGLISH_JAMAICA:Int = 66
Const wxLANGUAGE_ENGLISH_NEW_ZEALAND:Int = 67
Const wxLANGUAGE_ENGLISH_PHILIPPINES:Int = 68
Const wxLANGUAGE_ENGLISH_SOUTH_AFRICA:Int = 69
Const wxLANGUAGE_ENGLISH_TRINIDAD:Int = 70
Const wxLANGUAGE_ENGLISH_ZIMBABWE:Int = 71
Const wxLANGUAGE_ESPERANTO:Int = 72
Const wxLANGUAGE_ESTONIAN:Int = 73
Const wxLANGUAGE_FAEROESE:Int = 74
Const wxLANGUAGE_FARSI:Int = 75
Const wxLANGUAGE_FIJI:Int = 76
Const wxLANGUAGE_FINNISH:Int = 77
Const wxLANGUAGE_FRENCH:Int = 78
Const wxLANGUAGE_FRENCH_BELGIAN:Int = 79
Const wxLANGUAGE_FRENCH_CANADIAN:Int = 80
Const wxLANGUAGE_FRENCH_LUXEMBOURG:Int = 81
Const wxLANGUAGE_FRENCH_MONACO:Int = 82
Const wxLANGUAGE_FRENCH_SWISS:Int = 83
Const wxLANGUAGE_FRISIAN:Int = 84
Const wxLANGUAGE_GALICIAN:Int = 85
Const wxLANGUAGE_GEORGIAN:Int = 86
Const wxLANGUAGE_GERMAN:Int = 87
Const wxLANGUAGE_GERMAN_AUSTRIAN:Int = 88
Const wxLANGUAGE_GERMAN_BELGIUM:Int = 89
Const wxLANGUAGE_GERMAN_LIECHTENSTEIN:Int = 90
Const wxLANGUAGE_GERMAN_LUXEMBOURG:Int = 91
Const wxLANGUAGE_GERMAN_SWISS:Int = 92
Const wxLANGUAGE_GREEK:Int = 93
Const wxLANGUAGE_GREENLANDIC:Int = 94
Const wxLANGUAGE_GUARANI:Int = 95
Const wxLANGUAGE_GUJARATI:Int = 96
Const wxLANGUAGE_HAUSA:Int = 97
Const wxLANGUAGE_HEBREW:Int = 98
Const wxLANGUAGE_HINDI:Int = 99
Const wxLANGUAGE_HUNGARIAN:Int = 100
Const wxLANGUAGE_ICELANDIC:Int = 101
Const wxLANGUAGE_INDONESIAN:Int = 102
Const wxLANGUAGE_INTERLINGUA:Int = 103
Const wxLANGUAGE_INTERLINGUE:Int = 104
Const wxLANGUAGE_INUKTITUT:Int = 105
Const wxLANGUAGE_INUPIAK:Int = 106
Const wxLANGUAGE_IRISH:Int = 107
Const wxLANGUAGE_ITALIAN:Int = 108
Const wxLANGUAGE_ITALIAN_SWISS:Int = 109
Const wxLANGUAGE_JAPANESE:Int = 110
Const wxLANGUAGE_JAVANESE:Int = 111
Const wxLANGUAGE_KANNADA:Int = 112
Const wxLANGUAGE_KASHMIRI:Int = 113
Const wxLANGUAGE_KASHMIRI_INDIA:Int = 114
Const wxLANGUAGE_KAZAKH:Int = 115
Const wxLANGUAGE_KERNEWEK:Int = 116
Const wxLANGUAGE_KINYARWANDA:Int = 117
Const wxLANGUAGE_KIRGHIZ:Int = 118
Const wxLANGUAGE_KIRUNDI:Int = 119
Const wxLANGUAGE_KONKANI:Int = 120
Const wxLANGUAGE_KOREAN:Int = 121
Const wxLANGUAGE_KURDISH:Int = 122
Const wxLANGUAGE_LAOTHIAN:Int = 123
Const wxLANGUAGE_LATIN:Int = 124
Const wxLANGUAGE_LATVIAN:Int = 125
Const wxLANGUAGE_LINGALA:Int = 126
Const wxLANGUAGE_LITHUANIAN:Int = 127
Const wxLANGUAGE_MACEDONIAN:Int = 128
Const wxLANGUAGE_MALAGASY:Int = 129
Const wxLANGUAGE_MALAY:Int = 130
Const wxLANGUAGE_MALAYALAM:Int = 131
Const wxLANGUAGE_MALAY_BRUNEI_DARUSSALAM:Int = 132
Const wxLANGUAGE_MALAY_MALAYSIA:Int = 133
Const wxLANGUAGE_MALTESE:Int = 134
Const wxLANGUAGE_MANIPURI:Int = 135
Const wxLANGUAGE_MAORI:Int = 136
Const wxLANGUAGE_MARATHI:Int = 137
Const wxLANGUAGE_MOLDAVIAN:Int = 138
Const wxLANGUAGE_MONGOLIAN:Int = 139
Const wxLANGUAGE_NAURU:Int = 140
Const wxLANGUAGE_NEPALI:Int = 141
Const wxLANGUAGE_NEPALI_INDIA:Int = 142
Const wxLANGUAGE_NORWEGIAN_BOKMAL:Int = 143
Const wxLANGUAGE_NORWEGIAN_NYNORSK:Int = 144
Const wxLANGUAGE_OCCITAN:Int = 145
Const wxLANGUAGE_ORIYA:Int = 146
Const wxLANGUAGE_OROMO:Int = 147
Const wxLANGUAGE_PASHTO:Int = 148
Const wxLANGUAGE_POLISH:Int = 149
Const wxLANGUAGE_PORTUGUESE:Int = 150
Const wxLANGUAGE_PORTUGUESE_BRAZILIAN:Int = 151
Const wxLANGUAGE_PUNJABI:Int = 152
Const wxLANGUAGE_QUECHUA:Int = 153
Const wxLANGUAGE_RHAETO_ROMANCE:Int = 154
Const wxLANGUAGE_ROMANIAN:Int = 155
Const wxLANGUAGE_RUSSIAN:Int = 156
Const wxLANGUAGE_RUSSIAN_UKRAINE:Int = 157
Const wxLANGUAGE_SAMOAN:Int = 158
Const wxLANGUAGE_SANGHO:Int = 159
Const wxLANGUAGE_SANSKRIT:Int = 160
Const wxLANGUAGE_SCOTS_GAELIC:Int = 161
Const wxLANGUAGE_SERBIAN:Int = 162
Const wxLANGUAGE_SERBIAN_CYRILLIC:Int = 163
Const wxLANGUAGE_SERBIAN_LATIN:Int = 164
Const wxLANGUAGE_SERBO_CROATIAN:Int = 165
Const wxLANGUAGE_SESOTHO:Int = 166
Const wxLANGUAGE_SETSWANA:Int = 167
Const wxLANGUAGE_SHONA:Int = 168
Const wxLANGUAGE_SINDHI:Int = 169
Const wxLANGUAGE_SINHALESE:Int = 170
Const wxLANGUAGE_SISWATI:Int = 171
Const wxLANGUAGE_SLOVAK:Int = 172
Const wxLANGUAGE_SLOVENIAN:Int = 173
Const wxLANGUAGE_SOMALI:Int = 174
Const wxLANGUAGE_SPANISH:Int = 175
Const wxLANGUAGE_SPANISH_ARGENTINA:Int = 176
Const wxLANGUAGE_SPANISH_BOLIVIA:Int = 177
Const wxLANGUAGE_SPANISH_CHILE:Int = 178
Const wxLANGUAGE_SPANISH_COLOMBIA:Int = 179
Const wxLANGUAGE_SPANISH_COSTA_RICA:Int = 180
Const wxLANGUAGE_SPANISH_DOMINICAN_REPUBLIC:Int = 181
Const wxLANGUAGE_SPANISH_ECUADOR:Int = 182
Const wxLANGUAGE_SPANISH_EL_SALVADOR:Int = 183
Const wxLANGUAGE_SPANISH_GUATEMALA:Int = 184
Const wxLANGUAGE_SPANISH_HONDURAS:Int = 185
Const wxLANGUAGE_SPANISH_MEXICAN:Int = 186
Const wxLANGUAGE_SPANISH_MODERN:Int = 187
Const wxLANGUAGE_SPANISH_NICARAGUA:Int = 188
Const wxLANGUAGE_SPANISH_PANAMA:Int = 189
Const wxLANGUAGE_SPANISH_PARAGUAY:Int = 190
Const wxLANGUAGE_SPANISH_PERU:Int = 191
Const wxLANGUAGE_SPANISH_PUERTO_RICO:Int = 192
Const wxLANGUAGE_SPANISH_URUGUAY:Int = 193
Const wxLANGUAGE_SPANISH_US:Int = 194
Const wxLANGUAGE_SPANISH_VENEZUELA:Int = 195
Const wxLANGUAGE_SUNDANESE:Int = 196
Const wxLANGUAGE_SWAHILI:Int = 197
Const wxLANGUAGE_SWEDISH:Int = 198
Const wxLANGUAGE_SWEDISH_FINLAND:Int = 199
Const wxLANGUAGE_TAGALOG:Int = 200
Const wxLANGUAGE_TAJIK:Int = 201
Const wxLANGUAGE_TAMIL:Int = 202
Const wxLANGUAGE_TATAR:Int = 203
Const wxLANGUAGE_TELUGU:Int = 204
Const wxLANGUAGE_THAI:Int = 205
Const wxLANGUAGE_TIBETAN:Int = 206
Const wxLANGUAGE_TIGRINYA:Int = 207
Const wxLANGUAGE_TONGA:Int = 208
Const wxLANGUAGE_TSONGA:Int = 209
Const wxLANGUAGE_TURKISH:Int = 210
Const wxLANGUAGE_TURKMEN:Int = 211
Const wxLANGUAGE_TWI:Int = 212
Const wxLANGUAGE_UIGHUR:Int = 213
Const wxLANGUAGE_UKRAINIAN:Int = 214
Const wxLANGUAGE_URDU:Int = 215
Const wxLANGUAGE_URDU_INDIA:Int = 216
Const wxLANGUAGE_URDU_PAKISTAN:Int = 217
Const wxLANGUAGE_UZBEK:Int = 218
Const wxLANGUAGE_UZBEK_CYRILLIC:Int = 219
Const wxLANGUAGE_UZBEK_LATIN:Int = 220
Const wxLANGUAGE_VIETNAMESE:Int = 221
Const wxLANGUAGE_VOLAPUK:Int = 222
Const wxLANGUAGE_WELSH:Int = 223
Const wxLANGUAGE_WOLOF:Int = 224
Const wxLANGUAGE_XHOSA:Int = 225
Const wxLANGUAGE_YIDDISH:Int = 226
Const wxLANGUAGE_YORUBA:Int = 227
Const wxLANGUAGE_ZHUANG:Int = 228
Const wxLANGUAGE_ZULU:Int = 229

Rem
about: For custom, user-defined languages
end rem
Const wxLANGUAGE_USER_DEFINED:Int = 230

