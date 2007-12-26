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

	Function bmx_wxprintdata_create:Byte Ptr()
	Function bmx_wxprintdata_delete(handle:Byte Ptr)

	Function bmx_wxprintdata_getcollate:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getbin:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getcolour:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getduplex:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getnocopies:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getorientation:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getpaperid:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getprintername:String(handle:Byte Ptr)
	Function bmx_wxprintdata_getquality:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_getisok:Int(handle:Byte Ptr)
	Function bmx_wxprintdata_setbin(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdata_setcollate(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdata_setcolour(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdata_setduplex(handle:Byte Ptr, mode:Int)
	Function bmx_wxprintdata_setnocopies(handle:Byte Ptr, n:Int)
	Function bmx_wxprintdata_setorientation(handle:Byte Ptr, orientation:Int)
	Function bmx_wxprintdata_setpaperid(handle:Byte Ptr, paperId:Int)
	Function bmx_wxprintdata_setprintername(handle:Byte Ptr, name:String)
	Function bmx_wxprintdata_setquality(handle:Byte Ptr, quality:Int)

End Extern

Rem
bbdoc: Use specific dimensions
end rem
Const wxPAPER_NONE:Int = 0
Rem
bbdoc: Letter, 8 1/2 by 11 inches
end rem
Const wxPAPER_LETTER:Int = 1
Rem
bbdoc: Legal, 8 1/2 by 14 inches
end rem
Const wxPAPER_LEGAL:Int = 2
Rem
bbdoc: A4 Sheet, 210 by 297 millimeters
end rem
Const wxPAPER_A4:Int = 3
Rem
bbdoc: C Sheet, 17 by 22 inches
end rem
Const wxPAPER_CSHEET:Int = 4
Rem
bbdoc: D Sheet, 22 by 34 inches
end rem
Const wxPAPER_DSHEET:Int = 5
Rem
bbdoc: E Sheet, 34 by 44 inches
end rem
Const wxPAPER_ESHEET:Int = 6
Rem
bbdoc: Letter Small, 8 1/2 by 11 inches
end rem
Const wxPAPER_LETTERSMALL:Int = 7
Rem
bbdoc: Tabloid, 11 by 17 inches
end rem
Const wxPAPER_TABLOID:Int = 8
Rem
bbdoc: Ledger, 17 by 11 inches
end rem
Const wxPAPER_LEDGER:Int = 9
Rem
bbdoc: Statement, 5 1/2 by 8 1/2 inches
end rem
Const wxPAPER_STATEMENT:Int = 10
Rem
bbdoc: Executive, 7 1/4 by 10 1/2 inches
end rem
Const wxPAPER_EXECUTIVE:Int = 11
Rem
bbdoc: A3 sheet, 297 by 420 millimeters
end rem
Const wxPAPER_A3:Int = 12
Rem
bbdoc: A4 small sheet, 210 by 297 millimeters
end rem
Const wxPAPER_A4SMALL:Int = 13
Rem
bbdoc: A5 sheet, 148 by 210 millimeters
end rem
Const wxPAPER_A5:Int = 14
Rem
bbdoc: B4 sheet, 250 by 354 millimeters
end rem
Const wxPAPER_B4:Int = 15
Rem
bbdoc: B5 sheet, 182-by-257-millimeter paper
end rem
Const wxPAPER_B5:Int = 16
Rem
bbdoc: Folio, 8-1/2-by-13-inch paper
end rem
Const wxPAPER_FOLIO:Int = 17
Rem
bbdoc: Quarto, 215-by-275-millimeter paper
end rem
Const wxPAPER_QUARTO:Int = 18
Rem
bbdoc: 10-by-14-inch sheet
end rem
Const wxPAPER_10X14:Int = 19
Rem
bbdoc: 11-by-17-inch sheet
end rem
Const wxPAPER_11X17:Int = 20
Rem
bbdoc: Note, 8 1/2 by 11 inches
end rem
Const wxPAPER_NOTE:Int = 21
Rem
bbdoc: #9 Envelope, 3 7/8 by 8 7/8 inches
end rem
Const wxPAPER_ENV_9:Int = 22
Rem
bbdoc: #10 Envelope, 4 1/8 by 9 1/2 inches
end rem
Const wxPAPER_ENV_10:Int = 23
Rem
bbdoc: #11 Envelope, 4 1/2 by 10 3/8 inches
end rem
Const wxPAPER_ENV_11:Int = 24
Rem
bbdoc: #12 Envelope, 4 3/4 by 11 inches
end rem
Const wxPAPER_ENV_12:Int = 25
Rem
bbdoc: #14 Envelope, 5 by 11 1/2 inches
end rem
Const wxPAPER_ENV_14:Int = 26
Rem
bbdoc: DL Envelope, 110 by 220 millimeters
end rem
Const wxPAPER_ENV_DL:Int = 27
Rem
bbdoc: C5 Envelope, 162 by 229 millimeters
end rem
Const wxPAPER_ENV_C5:Int = 28
Rem
bbdoc: C3 Envelope, 324 by 458 millimeters
end rem
Const wxPAPER_ENV_C3:Int = 29
Rem
bbdoc: C4 Envelope, 229 by 324 millimeters
end rem
Const wxPAPER_ENV_C4:Int = 30
Rem
bbdoc: C6 Envelope, 114 by 162 millimeters
end rem
Const wxPAPER_ENV_C6:Int = 31
Rem
bbdoc: C65 Envelope, 114 by 229 millimeters
end rem
Const wxPAPER_ENV_C65:Int = 32
Rem
bbdoc: B4 Envelope, 250 by 353 millimeters
end rem
Const wxPAPER_ENV_B4:Int = 33
Rem
bbdoc: B5 Envelope, 176 by 250 millimeters
end rem
Const wxPAPER_ENV_B5:Int = 34
Rem
bbdoc: B6 Envelope, 176 by 125 millimeters
end rem
Const wxPAPER_ENV_B6:Int = 35
Rem
bbdoc: Italy Envelope, 110 by 230 millimeters
end rem
Const wxPAPER_ENV_ITALY:Int = 36
Rem
bbdoc: Monarch Envelope, 3 7/8 by 7 1/2 inches
end rem
Const wxPAPER_ENV_MONARCH:Int = 37
Rem
bbdoc: 6 3/4 Envelope, 3 5/8 by 6 1/2 inches
end rem
Const wxPAPER_ENV_PERSONAL:Int = 38
Rem
bbdoc: US Std Fanfold, 14 7/8 by 11 inches
end rem
Const wxPAPER_FANFOLD_US:Int = 39
Rem
bbdoc: German Std Fanfold, 8 1/2 by 12 inches
end rem
Const wxPAPER_FANFOLD_STD_GERMAN:Int = 40
Rem
bbdoc: German Legal Fanfold, 8 1/2 by 13 inches
end rem
Const wxPAPER_FANFOLD_LGL_GERMAN:Int = 41

Const wxPRINTBIN_DEFAULT:Int = 0
Const wxPRINTBIN_ONLYONE:Int = 1
Const wxPRINTBIN_LOWER:Int = 2
Const wxPRINTBIN_MIDDLE:Int = 3
Const wxPRINTBIN_MANUAL:Int = 4
Const wxPRINTBIN_ENVELOPE:Int = 5
Const wxPRINTBIN_ENVMANUAL:Int = 6
Const wxPRINTBIN_AUTO:Int = 7
Const wxPRINTBIN_TRACTOR:Int = 8
Const wxPRINTBIN_SMALLFMT:Int = 9
Const wxPRINTBIN_LARGEFMT:Int = 10
Const wxPRINTBIN_LARGECAPACITY:Int = 11
Const wxPRINTBIN_CASSETTE:Int = 12
Const wxPRINTBIN_FORMSOURCE:Int = 13
Const wxPRINTBIN_USER:Int = 14

Const wxDUPLEX_SIMPLEX:Int = 0
Const wxDUPLEX_HORIZONTAL:Int = 1
Const wxDUPLEX_VERTICAL:Int = 2

Const wxPRINT_QUALITY_HIGH:Int = -1
Const wxPRINT_QUALITY_MEDIUM:Int = -2
Const wxPRINT_QUALITY_LOW:Int = -3
Const wxPRINT_QUALITY_DRAFT:Int = -4

