' Copyright (c) 2007-2013 Bruce A Henderson
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
Import wx.wxBitmap
Import wx.wxDialog
Import wx.wxFrame
Import wx.wxPanel
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

	Function bmx_wxxmlresource_get:Byte Ptr()
	Function bmx_wxxmlresource_initallhandlers(handle:Byte Ptr)
	Function bmx_wxxmlresource_load:Int(handle:Byte Ptr, filemask:String)
	Function bmx_wxxmlresource_loadframe:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, name:String)
	Function bmx_wxxmlresource_xrcctrl:Byte Ptr(parent:Byte Ptr, id:String)
	Function bmx_wxxmlresource_wrcid:Int(name:String)
	Function bmx_wxxmlresource_loadobject:Byte Ptr(handle:Byte Ptr, win:Object, parent:Byte Ptr, name:String, classname:String)
	Function bmx_wxxmlresource_clearhandlers(handle:Byte Ptr)
	Function bmx_wxxmlresource_getflags:Int(handle:Byte Ptr)
	Function bmx_wxxmlresource_loaddialog:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, name:String)
	Function bmx_wxxmlresource_loadmenubar:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, name:String)
	Function bmx_wxxmlresource_loadpanel:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, name:String)
	Function bmx_wxxmlresource_loadtoolbar:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, name:String)
	Function bmx_wxxmlresource_unload:Int(handle:Byte Ptr, filename:String)

End Extern

Const wxXRC_USE_LOCALE:Int = 1
Const wxXRC_NO_SUBCLASSING:Int = 2
Const wxXRC_NO_RELOADING:Int = 4

