' Copyright (c) 2007-2018 Bruce A Henderson
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



' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk3-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk3-unicode-release-static/*.h"
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
Import "../lib/raspberrypi/wx/include/gtk3-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxstandardpaths_get:Byte Ptr()
	Function bmx_wxstandardpaths_getconfigdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getdatadir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getdocumentsdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getexecutablepath:String(handle:Byte Ptr)
?linux
	Function bmx_wxstandardpaths_getinstallprefix:String(handle:Byte Ptr)
?
	Function bmx_wxstandardpaths_getlocaldatadir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getpluginsdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getresourcesdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_gettempdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getuserconfigdir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getuserdatadir:String(handle:Byte Ptr)
	Function bmx_wxstandardpaths_getuserlocaldatadir:String(handle:Byte Ptr)
?linux
	Function bmx_wxstandardpaths_setinstallprefix(handle:Byte Ptr, prefix:String)
?


	Function bmx_wxstandardpaths_getappdocumentsdir:String(handle:Byte Ptr)
?win32
	Function bmx_wxstandardpaths_dontignoreappsubdir(handle:Byte Ptr)
	Function bmx_wxstandardpaths_ignoreappbuidsubdirs(handle:Byte Ptr)
	Function bmx_wxstandardpaths_ignoreappsubdir(handle:Byte Ptr, subdirPattern:String)
	Function bmx_wxstandardpaths_mswgetshelldir:String(csidl:Int)
?
	Function bmx_wxstandardpaths_getuserdir:String(handle:Byte Ptr, dir:int)

End Extern

Const Dir_Cache:Int = 0
Rem
bbdoc: Directory containing user documents.
End Rem
Const Dir_Documents:Int = 1
Rem
bbdoc: Directory containing files on the users desktop.
End Rem
Const Dir_Desktop:Int = 2
Rem
bbdoc: Directory for downloaded files.
End Rem
Const Dir_Downloads:Int = 3
Rem
bbdoc: Directory containing music files.
End Rem
Const Dir_Music:Int = 4
Rem
bbdoc: Directory containing picture files.
End Rem
Const Dir_Pictures:Int = 5
Rem
bbdoc: Directory containing video files.
End Rem
Const Dir_Videos:Int = 6

