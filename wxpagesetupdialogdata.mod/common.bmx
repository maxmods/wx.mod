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

Import wx.wx
Import wx.wxPrintData
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

	Function bmx_wxpagesetupdialogdata_create:Byte Ptr(printData:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_delete(handle:Byte Ptr)

	Function bmx_wxpagesetupdialogdata_enablehelp(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_enablemargins(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_enableorientation(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_enablepaper(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_enableprinter(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_getdefaultminmargins:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getenablemargins:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getenableorientation:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getenablepaper:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getenableprinter:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getenablehelp:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getdefaultinfo:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getmargintopleft(handle:Byte Ptr, leftMargin:Int Ptr, topMargin:Int Ptr)
	Function bmx_wxpagesetupdialogdata_getmarginbottomright(handle:Byte Ptr, rightMargin:Int Ptr, bottomMargin:Int Ptr)
	Function bmx_wxpagesetupdialogdata_getminmargintopleft(handle:Byte Ptr, leftMin:Int Ptr, topMin:Int Ptr)
	Function bmx_wxpagesetupdialogdata_getminmarginbottomright(handle:Byte Ptr, rightMin:Int Ptr, bottomMin:Int Ptr)
	Function bmx_wxpagesetupdialogdata_getpaperid:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_getpapersize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxpagesetupdialogdata_getprintdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_isok:Int(handle:Byte Ptr)
	Function bmx_wxpagesetupdialogdata_setdefaultinfo(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_setdefaultminmargins(handle:Byte Ptr, flag:Int)
	Function bmx_wxpagesetupdialogdata_setmargintopleft(handle:Byte Ptr, leftMargin:Int, topMargin:Int)
	Function bmx_wxpagesetupdialogdata_setmarginbottomright(handle:Byte Ptr, rightMargin:Int, bottomMargin:Int)
	Function bmx_wxpagesetupdialogdata_setminmargintopleft(handle:Byte Ptr, leftMin:Int, topMin:Int)
	Function bmx_wxpagesetupdialogdata_setminmarginbottomright(handle:Byte Ptr, rightMin:Int, bottomMin:Int)
	Function bmx_wxpagesetupdialogdata_setpaperid(handle:Byte Ptr, id:Int)
	Function bmx_wxpagesetupdialogdata_setpapersize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxpagesetupdialogdata_setprintdata(handle:Byte Ptr, printData:Byte Ptr)

End Extern
