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
Import wx.wxControl
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
	Function bmx_wxhyperlinkctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, label:String, url:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxhyperlinkctrl_gethovercolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhyperlinkctrl_getnormalcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhyperlinkctrl_getvisitedcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxhyperlinkctrl_sethovercolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxhyperlinkctrl_setvisitedcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxhyperlinkctrl_setnormalcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxhyperlinkctrl_getvisited:Int(handle:Byte Ptr)
	Function bmx_wxhyperlinkctrl_setvisited(handle:Byte Ptr, visited:Int)
	Function bmx_wxhyperlinkctrl_geturl:String(handle:Byte Ptr)
	Function bmx_wxhyperlinkctrl_seturl(handle:Byte Ptr, url:String)

	Function bmx_wxhyperlinkevent_geturl:String(handle:Byte Ptr)
	Function bmx_wxhyperlinkevent_seturl(handle:Byte Ptr, url:String)

	Function bmx_wxhyperlinkctrl_geteventtype:Int(evt:Int)

	Function bmx_wxhyperlinkctrl_addresourcehandler()
End Extern


Const wxEVT_COMMAND_HYPERLINK:Int = 3700

Const wxHL_CONTEXTMENU:Int = $0001
Const wxHL_ALIGN_LEFT:Int = $0002
Const wxHL_ALIGN_RIGHT:Int = $0004
Const wxHL_ALIGN_CENTRE:Int = $0008
Const wxHL_DEFAULT_STYLE:Int = wxHL_CONTEXTMENU | wxNO_BORDER | wxHL_ALIGN_CENTRE


