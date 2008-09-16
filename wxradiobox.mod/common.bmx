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

Import wx.wx
Import wx.wxControlWithItems
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

	Function bmx_wxradiobox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, label:String, x:Int, y:Int, ..
		w:Int, h:Int, choices:String[], majorDimension:Int, style:Int)
	Function bmx_wxradiobox_enable:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxradiobox_enableitem:Int(handle:Byte Ptr, item:Int, value:Int)
	Function bmx_wxradiobox_findstring:Int(handle:Byte Ptr, text:String, caseSensitive:Int)
	Function bmx_wxradiobox_getcolumncount:Int(handle:Byte Ptr)
	Function bmx_wxradiobox_getitemhelptext:String(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_getitemfrompoint:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxradiobox_getlabel:String(handle:Byte Ptr)
	Function bmx_wxradiobox_getitemlabel:String(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_getrowcount:Int(handle:Byte Ptr)
	Function bmx_wxradiobox_getselection:Int(handle:Byte Ptr)
	Function bmx_wxradiobox_getstringselection:String(handle:Byte Ptr)
	Function bmx_wxradiobox_getstring:String(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_isitemenabled:Int(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_isitemshown:Int(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_setitemhelptext(handle:Byte Ptr, item:Int, helpText:String)
	Function bmx_wxradiobox_setlabel(handle:Byte Ptr, label:String)
	Function bmx_wxradiobox_setitemlabel(handle:Byte Ptr, item:Int, label:String)
	Function bmx_wxradiobox_setselection(handle:Byte Ptr, item:Int)
	Function bmx_wxradiobox_setstringselection(handle:Byte Ptr, text:String)
	Function bmx_wxradiobox_setitemtooltip(handle:Byte Ptr, item:Int, text:String)
	Function bmx_wxradiobox_show:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxradiobox_showItem:Int(handle:Byte Ptr, item:Int, value:Int)
	Function bmx_wxradiobox_getitemtooltip:Byte Ptr(handle:Byte Ptr, item:Int)

	Function bmx_wxradiobox_geteventtype:Int(evt:Int)
	
	Function bmx_wxradiobox_addresourcehandler()
	
End Extern

Const wxEVT_COMMAND_RADIOBOX_SELECTED:Int = 11

Const wxRA_LEFTTORIGHT:Int = $0001
Const wxRA_TOPTOBOTTOM:Int = $0002

'  New, more intuitive names To specify majorDim argument */
Const wxRA_SPECIFY_COLS:Int = wxHORIZONTAL
Const wxRA_SPECIFY_ROWS:Int = wxVERTICAL

'  Old names For compatibility */
Const wxRA_HORIZONTAL:Int = wxHORIZONTAL
Const wxRA_VERTICAL:Int = wxVERTICAL


