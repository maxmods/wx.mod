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

	Function bmx_wxplatforminfo_checkosversion:Int(major:Int, minor:Int)
	Function bmx_wxplatforminfo_checktoolkitversion:Int(major:Int, minor:Int)
	Function bmx_wxplatforminfo_getarch:Int(arch:String)
	Function bmx_wxplatforminfo_getarchname:String()
	Function bmx_wxplatforminfo_getarchitecture:Int()
	Function bmx_wxplatforminfo_getendianness:Int()
	Function bmx_wxplatforminfo_getendiannessname:String()
	Function bmx_wxplatforminfo_getosmajorversion:Int()
	Function bmx_wxplatforminfo_getosminorversion:Int()
	Function bmx_wxplatforminfo_getoperatingsystemfamilyname:String()
	Function bmx_wxplatforminfo_getoperatingsytemid:Int()
	Function bmx_wxplatforminfo_getoperatingsystemidname:String()
	Function bmx_wxplatforminfo_getportid:Int()
	Function bmx_wxplatforminfo_getportidname:String()
	Function bmx_wxplatforminfo_getportidshortname:String()
	Function bmx_wxplatforminfo_gettoolkitmajorversion:Int()
	Function bmx_wxplatforminfo_gettoolkitminorversion:Int()

End Extern


Const wxOS_UNKNOWN:Int = 0                 ' returned on error
Const wxOS_MAC_OS:Int = 1 Shl 0     ' Apple Mac OS 8/9/X with Mac paths 
Const wxOS_MAC_OSX_DARWIN:Int = 1 Shl 1     ' Apple Mac OS X with Unix paths 
Const wxOS_MAC:Int = wxOS_MAC_OS|wxOS_MAC_OSX_DARWIN 
Const wxOS_WINDOWS_9X:Int = 1 Shl 2     ' Windows 9x family (95/98/ME) 
Const wxOS_WINDOWS_NT:Int = 1 Shl 3     ' Windows NT family (NT/2000/XP) 
Const wxOS_WINDOWS_MICRO:Int = 1 Shl 4     ' MicroWindows 
Const wxOS_WINDOWS_CE:Int = 1 Shl 5     ' Windows CE (Window Mobile) 
Const wxOS_WINDOWS:Int = wxOS_WINDOWS_9X | wxOS_WINDOWS_NT | wxOS_WINDOWS_MICRO | wxOS_WINDOWS_CE
Const wxOS_UNIX_LINUX:Int = 1 Shl 6       ' Linux 
Const wxOS_UNIX_FREEBSD:Int = 1 Shl 7       ' FreeBSD 
Const wxOS_UNIX_OPENBSD:Int = 1 Shl 8       ' OpenBSD 
Const wxOS_UNIX_NETBSD:Int = 1 Shl 9       ' NetBSD 
Const wxOS_UNIX_SOLARIS:Int = 1 Shl 10      ' SunOS 
Const wxOS_UNIX_AIX:Int = 1 Shl 11      ' AIX 
Const wxOS_UNIX_HPUX:Int = 1 Shl 12      ' HP/UX 
Const wxOS_UNIX:Int = wxOS_UNIX_LINUX | wxOS_UNIX_FREEBSD | wxOS_UNIX_OPENBSD | wxOS_UNIX_NETBSD | wxOS_UNIX_SOLARIS | wxOS_UNIX_AIX | wxOS_UNIX_HPUX
Const wxOS_DOS:Int = 1 Shl 15      ' Microsoft DOS 
Const wxOS_OS2:Int = 1 Shl 16       ' OS/2

Const wxPORT_UNKNOWN:Int = 0            ' returned on error
Const wxPORT_BASE:Int = 1 Shl 0       ' wxBase, no native toolkit used 
Const wxPORT_MSW:Int = 1 Shl 1       ' wxMSW, native toolkit is Windows API 
Const wxPORT_MOTIF:Int = 1 Shl 2       ' wxMotif, using [Open]Motif Or Lesstif 
Const wxPORT_GTK:Int = 1 Shl 3       ' wxGTK, using GTK+ 1.x, 2.x, GPE Or Maemo 
Const wxPORT_MGL:Int = 1 Shl 4       ' wxMGL, using wxUniversal 
Const wxPORT_X11:Int = 1 Shl 5       ' wxX11, using wxUniversal 
Const wxPORT_OS2:Int = 1 Shl 6       ' wxOS2, using OS/2 Presentation Manager 
Const wxPORT_MAC:Int = 1 Shl 7       ' wxMac, using Carbon Or Classic Mac API 
Const wxPORT_COCOA:Int = 1 Shl 8       ' wxCocoa, using Cocoa NextStep/Mac API 
Const wxPORT_WINCE:Int = 1 Shl 9       ' wxWinCE, toolkit is WinCE SDK API 
Const wxPORT_PALMOS:Int = 1 Shl 10     ' wxPalmOS, toolkit is PalmOS API 
Const wxPORT_DFB:Int = 1 Shl 11       ' wxDFB, using wxUniversal 

Const wxARCH_INVALID:Int = -1        ' returned on error
Const wxARCH_32:Int = 0                  ' 32 bit 
Const wxARCH_64:Int = 1

Const wxENDIAN_INVALID:Int = -1      ' returned on error
Const wxENDIAN_BIG:Int = 0               ' 4321 
Const wxENDIAN_LITTLE:Int = 1            ' 1234 
Const wxENDIAN_PDP:Int = 2               ' 3412 

