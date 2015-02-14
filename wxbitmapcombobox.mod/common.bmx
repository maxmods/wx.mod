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

Import wx.wx
Import wx.wxComboBox
Import BRL.Blitz


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk2-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk2-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxbitmapcombobox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, value:String, choices:String[], x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxbitmapcombobox_append:Int(handle:Byte Ptr, item:String, bitmap:Byte Ptr, clientData:Object)
	Function bmx_wxbitmapcombobox_getbitmapsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxbitmapcombobox_getitembitmap:Byte Ptr(handle:Byte Ptr, item:Int)
	Function bmx_wxbitmapcombobox_insert:Int(handle:Byte Ptr, pos:Int, item:String, bitmap:Byte Ptr, clientData:Object)
	Function bmx_wxbitmapcombobox_setitembitmap(handle:Byte Ptr, bitmap:Byte Ptr)

	Function bmx_wxbitmapcombobox_selectitem(handle:Byte Ptr, item:Int)
	Function bmx_wxbitmapcombobox_setselection(handle:Byte Ptr, item:Int)
	
	Function bmx_wxbitmapcombobox_getselection:Int(handle:Byte Ptr)
	Function bmx_wxbitmapcombobox_getcount:Int(handle:Byte Ptr)
	Function bmx_wxbitmapcombobox_isempty:Int(handle:Byte Ptr)
	Function bmx_wxbitmapcombobox_clear(handle:Byte Ptr)
	Function bmx_wxbitmapcombobox_deleteitem(handle:Byte Ptr, item:Int)
	Function bmx_wxbitmapcombobox_getstring:String(handle:Byte Ptr, item:Int)
	Function bmx_wxbitmapcombobox_getstrings:String[](handle:Byte Ptr)
	Function bmx_wxbitmapcombobox_getstringselection:String(handle:Byte Ptr)

	Function bmx_wxbitmapcombobox_addresourcehandler()
	
End Extern


