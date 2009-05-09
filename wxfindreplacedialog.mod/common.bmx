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
Import wx.wxDialog
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

	Function bmx_wxfindreplacedialog_create:Byte Ptr(handle:Object, parent:Byte Ptr, data:Byte Ptr, title:String, style:Int)

	Function bmx_wxfindreplacedata_create:Byte Ptr(handle:Object, flags:Int)
	Function bmx_wxfindreplacedata_getfindstring:String(handle:Byte Ptr)
	Function bmx_wxfindreplacedata_getreplacestring:String(handle:Byte Ptr)
	Function bmx_wxfindreplacedata_getflags:Int(handle:Byte Ptr)
	Function bmx_wxfindreplacedata_setflags(handle:Byte Ptr, flags:Int)
	Function bmx_wxfindreplacedata_setfindstring(handle:Byte Ptr, s:String)
	Function bmx_wxfindreplacedata_setreplacestring(handle:Byte Ptr, s:String)
	Function bmx_wxfindreplacedata_free(handle:Byte Ptr)

	Function bmx_wxfinddialogevent_getflags:Int(handle:Byte Ptr)
	Function bmx_wxfinddialogevent_getfindstring:String(handle:Byte Ptr)
	Function bmx_wxfinddialogevent_getreplacestring:String(handle:Byte Ptr)
	Function bmx_wxfinddialogevent_getdialog:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxfindreplacedialog_geteventtype:Int(evt:Int)

End Extern

Const wxEVT_COMMAND_FIND:Int = 510
Const wxEVT_COMMAND_FIND_NEXT:Int = 511
Const wxEVT_COMMAND_FIND_REPLACE:Int = 512
Const wxEVT_COMMAND_FIND_REPLACE_ALL:Int = 513
Const wxEVT_COMMAND_FIND_CLOSE:Int = 514


Const wxFR_DOWN:Int = 1
Const wxFR_WHOLEWORD:Int = 2
Const wxFR_MATCHCASE:Int = 4

Const wxFR_REPLACEDIALOG:Int = 1
Const wxFR_NOUPDOWN:Int = 2
Const wxFR_NOMATCHCASE:Int = 4
Const wxFR_NOWHOLEWORD:Int = 8


