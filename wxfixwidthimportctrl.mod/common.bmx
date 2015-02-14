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
Import wx.wxControl
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

Import "include/*.h"
Import "src/fiximp.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxfixwidthimportctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxfixwidthimportctrl_getvalcount:Int(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_getvalues:Int[](handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_setvalues(handle:Byte Ptr, values:Int[])
	Function bmx_wxfixwidthimportctrl_getlinescount:Int(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_getselectedlineno:Int(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_getselectedline:String(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_selectline(handle:Byte Ptr, line:Int)
	Function bmx_wxfixwidthimportctrl_getline:String(handle:Byte Ptr, line:Int)
	Function bmx_wxfixwidthimportctrl_getdelimcolor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_getselectcolor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_setdelimcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_setselectcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_loadfile:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxfixwidthimportctrl_loadtext(handle:Byte Ptr, text:String)
	Function bmx_wxfixwidthimportctrl_settabsize(handle:Byte Ptr, tabSize:Int)
	Function bmx_wxfixwidthimportctrl_gettabsize:Int(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_converttabstospaces(handle:Byte Ptr)
	Function bmx_wxfixwidthimportctrl_enabledelim(handle:Byte Ptr, enable:Int)

	Function bmx_wxfixwidthimportctrl_geteventtype:Int(eventType:Int)
	
End Extern

Const wxEVT_COMMAND_FIXW_UPDATED:Int = -343
