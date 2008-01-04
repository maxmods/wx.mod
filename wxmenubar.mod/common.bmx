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
Import wx.wxWindow
Import wx.wxMenu
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

	Function bmx_wxmenubar_create:Byte Ptr(handle:Object, style:Int)
	Function bmx_wxmenubar_append:Int(handle:Byte Ptr, menu:Byte Ptr, title:String)
	Function bmx_wxmenubar_check(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenubar_enable(handle:Byte Ptr, id:Int, value:Int)
	Function bmx_wxmenubar_enabletop(handle:Byte Ptr, pos:Int, value:Int)
	Function bmx_wxmenubar_findmenu:Int(handle:Byte Ptr, title:String)
	Function bmx_wxmenubar_findmenuitem:Int(handle:Byte Ptr, menuString:String, itemString:String)
	Function bmx_wxmenubar_gethelpstring:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenubar_getlabel:String(handle:Byte Ptr, id:Int)
	Function bmx_wxmenubar_getlabeltop:String(handle:Byte Ptr, pos:Int)
	Function bmx_wxmenubar_getmenu:Byte Ptr(handle:Byte Ptr, index:Int)
	Function bmx_wxmenubar_getmenucount:Int(handle:Byte Ptr)
	Function bmx_wxmenubar_insert:Int(handle:Byte Ptr, pos:Int, menu:Byte Ptr, title:String)
	Function bmx_wxmenubar_ischecked:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxmenubar_isenabled:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxmenubar_refresh(handle:Byte Ptr)
	Function bmx_wxmenubar_remove:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxmenubar_replace:Byte Ptr(handle:Byte Ptr, pos:Int, menu:Byte Ptr, title:String)
	Function bmx_wxmenubar_sethelpstring(handle:Byte Ptr, id:Int, helpString:String)
	Function bmx_wxmenubar_setlabel(handle:Byte Ptr, id:Int, label:String)
	Function bmx_wxmenubar_setlabeltop(handle:Byte Ptr, pos:Int, label:String)
	Function bmx_wxmenubar_finditem:Byte Ptr(handle:Byte Ptr, id:Int)
	
End Extern


Const wxMB_DOCKABLE:Int = $0001

