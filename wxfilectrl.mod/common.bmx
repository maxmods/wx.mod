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

	Function bmx_wxfilectrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, defaultDirectory:String, defaultFilename:String, wildcard:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxfilectrl_getdirectory:String(handle:Byte Ptr)
	Function bmx_wxfilectrl_getfilename:String(handle:Byte Ptr)
	Function bmx_wxfilectrl_getfilenames:String[](handle:Byte Ptr)
	Function bmx_wxfilectrl_getfilterindex:Int(handle:Byte Ptr)
	Function bmx_wxfilectrl_getpath:String(handle:Byte Ptr)
	Function bmx_wxfilectrl_getpaths:String[](handle:Byte Ptr)
	Function bmx_wxfilectrl_getwildcard:String(handle:Byte Ptr)
	Function bmx_wxfilectrl_setdirectory:Int(handle:Byte Ptr, directory:String)
	Function bmx_wxfilectrl_setfilename:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxfilectrl_setpath:Int(handle:Byte Ptr, path:String)
	Function bmx_wxfilectrl_setfilterindex(handle:Byte Ptr, index:Int)
	Function bmx_wxfilectrl_setwildcard(handle:Byte Ptr, wildcard:String)
	Function bmx_wxfilectrl_showhidden(handle:Byte Ptr, show:Int)
	
	Function bmx_wxfilectrlevent_getdirectory:String(handle:Byte Ptr)
	Function bmx_wxfilectrlevent_getfile:String(handle:Byte Ptr)
	Function bmx_wxfilectrlevent_getfiles:String[](handle:Byte Ptr)
	Function bmx_wxfilectrlevent_getfilterindex:Int(handle:Byte Ptr)
	Function bmx_wxfilectrlevent_setfiles(handle:Byte Ptr, files:String[])
	Function bmx_wxfilectrlevent_setdirectory(handle:Byte Ptr, directory:String)
	Function bmx_wxfilectrlevent_setfilterindex(handle:Byte Ptr, index:Int)

	Function bmx_wxfilectrl_geteventtype:Int(eventType:Int)
	Function bmx_wxfilectrl_addresourcehandler()

End Extern

Rem
bbdoc: Creates an file control suitable for opening files.
about: Cannot be combined with wxFC_SAVE.
End Rem
Const wxFC_OPEN:Int = $0001
Rem
bbdoc: Creates an file control suitable for saving files.
about: Cannot be combined with wxFC_OPEN.
End Rem
Const wxFC_SAVE:Int = $0002
Rem
bbdoc: For open control only, Allows selecting multiple files.
about: Cannot be combined with wxFC_SAVE
End Rem
Const wxFC_MULTIPLE:Int = $0004
Rem
bbdoc: Hides the "Show Hidden Files" checkbox (Generic only)
End Rem
Const wxFC_NOSHOWHIDDEN:Int = $0008
Rem
bbdoc: The default style: wxFC_OPEN
End Rem
Const wxFC_DEFAULT_STYLE:Int = wxFC_OPEN


Const wxEVT_FILECTRL_SELECTIONCHANGED:Int = -140
Const wxEVT_FILECTRL_FILEACTIVATED:Int = -141
Const wxEVT_FILECTRL_FOLDERCHANGED:Int = -142
Const wxEVT_FILECTRL_FILTERCHANGED:Int = -143
