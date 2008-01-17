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

	Function bmx_wxprocess_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int)
	Function bmx_wxprocess_createwithflags:Byte Ptr(handle:Object, flags:Int)
	Function bmx_wxprocess_closeoutput(handle:Byte Ptr)
	Function bmx_wxprocess_detach(handle:Byte Ptr)
	Function bmx_wxprocess_geterrorstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_getintputstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_getoutputstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_iserroravailable:Int(handle:Byte Ptr)
	Function bmx_wxprocess_isinputavailable:Int(handle:Byte Ptr)
	Function bmx_wxprocess_isinputopened:Int(handle:Byte Ptr)
	Function bmx_wxprocess_kill:Int(pid:Int, signal:Int, flags:Int)
	Function bmx_wxprocess_exists:Int(pid:Int)
	Function bmx_wxprocess_open:Byte Ptr(cmd:String, flags:Int)
	Function bmx_wxprocess_getpid:Int(handle:Byte Ptr)
	Function bmx_wxprocess_redirect(handle:Byte Ptr)
	Function bmx_wxprocess_free(handle:Byte Ptr)

End Extern


Const wxSIGNONE:Int = 0
Const wxSIGHUP:Int = 1
Const wxSIGINT:Int = 2
Const wxSIGQUIT:Int = 3
Const wxSIGILL:Int = 4
Const wxSIGTRAP:Int = 5
Const wxSIGABRT:Int = 6
Const wxSIGEMT:Int = 7
Const wxSIGFPE:Int = 8
Const wxSIGKILL:Int = 9
Const wxSIGBUS:Int = 10
Const wxSIGSEGV:Int = 11
Const wxSIGSYS:Int = 12
Const wxSIGPIPE:Int = 13
Const wxSIGALRM:Int = 14
Const wxSIGTERM:Int = 15

Const wxKILL_OK:Int = 0
Const wxKILL_BAD_SIGNAL:Int = 1
Const wxKILL_ACCESS_DENIED:Int = 2
Const wxKILL_NO_PROCESS:Int = 3
Const wxKILL_ERROR:Int = 4

Const wxKILL_NOCHILDREN:Int = 0
Const wxKILL_CHILDREN:Int = 1

Const wxSHUTDOWN_POWEROFF:Int = 0
Const wxSHUTDOWN_REBOOT:Int = 0

Const wxPROCESS_DEFAULT:Int = 0
Const wxPROCESS_REDIRECT:Int = 1

Const wxEXEC_ASYNC:Int = 0
Const wxEXEC_SYNC:Int = 1
Const wxEXEC_NOHIDE:Int = 2
Const wxEXEC_MAKE_GROUP_LEADER:Int = 4
Const wxEXEC_NODISABLE:Int = 8