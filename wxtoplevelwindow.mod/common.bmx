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
Import wx.wxWindow
Import wx.wxIcon
Import wx.wxRegion
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

	Function bmx_wxtoplevelwindow_cansettransparent:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_enableclosebutton:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxtoplevelwindow_geticon:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_gettitle:String(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_isactive:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_isalwaysmaximized:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_iconize(handle:Byte Ptr, value:Int)
	Function bmx_wxtoplevelwindow_isfullscreen:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_isiconized:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_ismaximized:Int(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_maximize(handle:Byte Ptr, value:Int)
	Function bmx_wxtoplevelwindow_requestuserattention(handle:Byte Ptr, flags:Int)
	Function bmx_wxtoplevelwindow_setdefaultitem(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxtoplevelwindow_seticon(handle:Byte Ptr, icon:Byte Ptr)
	Function bmx_wxtoplevelwindow_setmaxsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxtoplevelwindow_setminsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxtoplevelwindow_setsizehints(handle:Byte Ptr, minW:Int, minH:Int, maxW:Int, maxH:Int)
	Function bmx_wxtoplevelwindow_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxtoplevelwindow_settransparent(handle:Byte Ptr, alpha:Int)
	Function bmx_wxtoplevelwindow_showfullscreen:Int(handle:Byte Ptr, show:Int, style:Int)
	Function bmx_wxtoplevelwindow_centreonscreen(handle:Byte Ptr, direction:Int)
	Function bmx_wxtoplevelwindow_centeronscreen(handle:Byte Ptr, direction:Int)

	Function bmx_wxtoplevelwindow_getdefaultitem:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxtoplevelwindow_seticons(handle:Byte Ptr, icons:Byte Ptr)
	Function bmx_wxtoplevelwindow_geticons:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoplevelwindow_setshape:Int(handle:Byte Ptr, region:Byte Ptr)
'?macos
'	Function bmx_wxtoplevelwindow_macgetwindowref:Byte Ptr(handle:Byte Ptr)
'?

	Function bmx_wxtoplevelwindow_geteventtype:Int(eventType:Int)
	
End Extern
