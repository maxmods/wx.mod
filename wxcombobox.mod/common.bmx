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
Import wx.wxTextCtrl
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

	Function bmx_wxcombobox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, value:String, choices:String[], x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxcombobox_cancopy:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_cancut:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_canpaste:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_canredo:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_canundo:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_copy(handle:Byte Ptr)
	Function bmx_wxcombobox_cut(handle:Byte Ptr)
	Function bmx_wxcombobox_getcurrentselection:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_getinsertionpoint:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_getlastposition:Int(handle:Byte Ptr)
	Function bmx_wxcombobox_gettextselection(handle:Byte Ptr, fromPos:Int Ptr, toPos:Int Ptr)
	Function bmx_wxcombobox_getvalue:String(handle:Byte Ptr)
	Function bmx_wxcombobox_paste(handle:Byte Ptr)
	Function bmx_wxcombobox_redo(handle:Byte Ptr)
	Function bmx_wxcombobox_replace(handle:Byte Ptr, fromPos:Int, toPos:Int, text:String)
	Function bmx_wxcombobox_remove(handle:Byte Ptr, fromPos:Int, toPos:Int)
	Function bmx_wxcombobox_setinsertionpoint(handle:Byte Ptr, pos:Int)
	Function bmx_wxcombobox_setinsertionpointend(handle:Byte Ptr)
	Function bmx_wxcombobox_settextselection(handle:Byte Ptr, fromPos:Int, toPos:Int)
	Function bmx_wxcombobox_setvalue(handle:Byte Ptr, text:String)
	Function bmx_wxcombobox_undo(handle:Byte Ptr)
	
	Function bmx_wxcombobox_geteventtype:Int(evt:Int)
	
	Function bmx_wxcombobox_addresourcehandler()
	
End Extern


Const wxEVT_COMMAND_COMBOBOX_SELECTED:Int = 15


Const wxCB_SIMPLE:Int = $0004
Const wxCB_SORT:Int = $0008
Const wxCB_READONLY:Int = $0010
Const wxCB_DROPDOWN:Int = $0020
