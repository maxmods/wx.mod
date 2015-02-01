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

	Function bmx_wxfiletypeinfo_create:Byte Ptr(mimeType:String)
	Function bmx_wxfiletypeinfo_addextension(handle:Byte Ptr, ext:String)
	Function bmx_wxfiletypeinfo_setdescription(handle:Byte Ptr, description:String)
	Function bmx_wxfiletypeinfo_setopencommand(handle:Byte Ptr, command:String)
	Function bmx_wxfiletypeinfo_setprintcommand(handle:Byte Ptr, command:String)
	Function bmx_wxfiletypeinfo_setshortdesc(handle:Byte Ptr, shortDesc:String)
	Function bmx_wxfiletypeinfo_seticon(handle:Byte Ptr, iconFile:String, iconIndex:Int)
	Function bmx_wxfiletypeinfo_getmimetype:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getopencommand:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getprintcommand:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getshortdesc:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getdescription:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getextensions:String[](handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_getextensionscount:Int(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_geticonfile:String(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_geticonindex:Int(handle:Byte Ptr)
	Function bmx_wxfiletypeinfo_delete(handle:Byte Ptr)

End Extern
