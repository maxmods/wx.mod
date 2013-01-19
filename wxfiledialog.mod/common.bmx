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
Import wx.wxDialog
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

	Function bmx_wxfileselector:String(message:String, defaultPath:String, defaultFilename:String, ..
		defaultExtension:String, wildcard:String, flags:Int,  parent:Byte Ptr, x:Int, y:Int)

	Function bmx_wxfiledialog_create:Byte Ptr(handle:Object, parent:Byte Ptr, message:String, defaultDir:String, defaultFile:String, ..
			wildcard:String, style:Int, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxfiledialog_getdirectory:String(handle:Byte Ptr)
	Function bmx_wxfiledialog_getfilename:String(handle:Byte Ptr)
	Function bmx_wxfiledialog_getfilenames:String[](handle:Byte Ptr)
	Function bmx_wxfiledialog_getfilterindex:Int(handle:Byte Ptr)
	Function bmx_wxfiledialog_getmessage:String(handle:Byte Ptr)
	Function bmx_wxfiledialog_getpath:String(handle:Byte Ptr)
	Function bmx_wxfiledialog_getpaths:String[](handle:Byte Ptr)
	Function bmx_wxfiledialog_getwildcard:String(handle:Byte Ptr)
	Function bmx_wxfiledialog_setdirectory(handle:Byte Ptr, directory:String)
	Function bmx_wxfiledialog_setfilename(handle:Byte Ptr, filename:String)
	Function bmx_wxfiledialog_setfilterindex(handle:Byte Ptr, index:Int)
	Function bmx_wxfiledialog_setmessage(handle:Byte Ptr, message:String)
	Function bmx_wxfiledialog_setpath(handle:Byte Ptr, path:String)
	Function bmx_wxfiledialog_setwildcard(handle:Byte Ptr, wildcard:String)
	Function bmx_wxfiledialog_showmodal:Int(handle:Byte Ptr)

End Extern

Const wxFD_OPEN:Int = $0001
Const wxFD_SAVE:Int = $0002
Const wxFD_OVERWRITE_PROMPT:Int = $0004
Const wxFD_FILE_MUST_EXIST:Int = $0010
Const wxFD_MULTIPLE:Int = $0020
Const wxFD_CHANGE_DIR:Int = $0080
Const wxFD_PREVIEW:Int = $0100

Const wxFD_DEFAULT_STYLE:Int = wxFD_OPEN

