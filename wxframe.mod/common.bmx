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
Import wx.wxToolBar
Import wx.wxStatusBar
Import wx.wxMenuBar
Import wx.wxTopLevelWindow
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

	Function bmx_wxframe_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, title:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxframe_setmenubar(handle:Byte Ptr, menubar:Byte Ptr)
	Function bmx_wxframe_createstatusbar:Byte Ptr(handle:Byte Ptr, number:Int, style:Int, id:Int)
	Function bmx_wxframe_setstatustext(handle:Byte Ptr, text:String, number:Int)

	Function bmx_wxframe_getmenubar:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxframe_setstatusbar(handle:Byte Ptr, statusbar:Byte Ptr)
	Function bmx_wxframe_getstatusbar:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxframe_positionstatusbar(handle:Byte Ptr)

	Function bmx_wxframe_createtoolbar:Byte Ptr(handle:Byte Ptr, style:Int, id:Int)
	Function bmx_wxframe_gettoolbar:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxframe_settoolbar(handle:Byte Ptr, toolbar:Byte Ptr)
	Function bmx_wxframe_sendsizeevent(handle:Byte Ptr)
	
End Extern


Const wxFRAME_NO_TASKBAR:Int = $0002  ' No taskbar button (MSW only)
Const wxFRAME_TOOL_WINDOW:Int = $0004  ' No taskbar button, no system menu
Const wxFRAME_FLOAT_ON_PARENT:Int = $0008  ' Always above its parent
Const wxFRAME_SHAPED:Int = $0010  ' Create a window that is able To be shaped

Const wxFRAME_EX_CONTEXTHELP:Int = wxWS_EX_CONTEXTHELP

Rem
bbdoc: Create a window which is attachable To another top level window
End Rem
Const wxFRAME_DRAWER:Int = $0020

Rem
bbdoc: Draw the window in a metal theme on Mac 
End Rem
Const wxFRAME_EX_METAL:Int = $00000040
