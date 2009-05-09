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
Import wx.wxMenu
Import wx.wxCommand
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

	Function bmx_wxcommandprocessor_create:Byte Ptr(handle:Object, maxCommands:Int)
	Function bmx_wxcommandprocessor_canundo:Int(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_clearcommands(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_redo:Int(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_getmaxcommands:Int(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_geteditmenu:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_getredoaccelerator:String(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_getredomenulabel:String(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_getundoaccelerator:String(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_getundomenulabel:String(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_initialize(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_isdirty:Int(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_markassaved(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_seteditmenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxcommandprocessor_setmenustrings(handle:Byte Ptr)
	Function bmx_wxcommandprocessor_setredoaccelerator(handle:Byte Ptr, accel:String)
	Function bmx_wxcommandprocessor_setundoaccelerator(handle:Byte Ptr, accel:String)
	Function bmx_wxcommandprocessor_submit(handle:Byte Ptr, command:Byte Ptr, storeIt:Int)
	Function bmx_wxcommandprocessor_undo:Int(handle:Byte Ptr)

End Extern
