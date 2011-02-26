' Copyright (c) 2007-2011 Bruce A Henderson
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
Import wx.wxFrame
Import wx.wxTextCtrl
Import BRL.Blitz
Import BRL.Stream


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
	Function wxlogfind:Object(handle:Byte Ptr)

	Function bmx_wxlogerror(message:String)
	Function bmx_wxlogfatalerror(message:String)
	Function bmx_wxlogwarning(message:String)
	Function bmx_wxlogmessage(message:String)
	Function bmx_wxlogverbose(message:String)
	Function bmx_wxlogstatus(message:String, frame:Byte Ptr)
	Function bmx_wxsafeshowmessage(message:String)
	Function bmx_wxsyserrorcode:Int()
	Function bmx_wxsyserrormsg:String(code:Int)
	
	'Function bmx_wxlognull_create:Byte Ptr(handle:Object)
	Function bmx_wxlogtextctrl_create:Byte Ptr(handle:Object, textctrl:Byte Ptr)
	Function bmx_wxlog_delete(logger:Byte Ptr)
	
	Function bmx_wxlog_setactivetarget:Byte Ptr(logger:Byte Ptr)
	Function bmx_wxlog_settimestamp(format:String)

	Function bmx_wxlog_addtracemask(mask:String)
	Function bmx_wxlog_cleartracemasks()
	Function bmx_wxlog_dontcreateondemand()
	Function bmx_wxlog_flushactive()
	Function bmx_wxlog_gettracemasks:String[]()
	Function bmx_wxlog_getactivetarget:Byte Ptr()
	Function bmx_wxlog_getloglevel:Int()
	Function bmx_wxlog_getrepetitioncounting:Int()
	Function bmx_wxlog_gettimestamp:String()
	Function bmx_wxlog_gettracemask:Int()
	Function bmx_wxlog_getverbose:Int()
	Function bmx_wxlog_isallowedtracemask:Int(mask:String)
	Function bmx_wxlog_removetracemask(mask:String)
	Function bmx_wxlog_resume()
	Function bmx_wxlog_setloglevel(level:Int)
	Function bmx_wxlog_setrepetitioncounting(repetCounting:Int)
	Function bmx_wxlog_settracemask(mask:Int)
	Function bmx_wxlog_suspend()
	Function bmx_wxlog_setverbose(verbose:Int)

	Function bmx_wxlogbuffer_create:Byte Ptr(handle:Object)
	Function bmx_wxlogbuffer_flush(handle:Byte Ptr)
	Function bmx_wxlogbuffer_getbuffer:String(handle:Byte Ptr)

	Function bmx_wxlogstream_create:Byte Ptr(handle:Object)

End Extern


Const wxLOG_FatalError:Int = 0 ' program can't continue, abort immediately
Const wxLOG_Error:Int = 1      ' a serious error, user must be informed about it
Const wxLOG_Warning:Int = 2    ' user is normally informed about it but may be ignored
Const wxLOG_Message:Int = 3    ' normal message (i.e. normal output of a non GUI app)
Const wxLOG_Status:Int = 4     ' informational: might go to the status line of GUI app
Const wxLOG_Info:Int = 5       ' informational message (a.k.a. 'Verbose')
Const wxLOG_Debug:Int = 6      ' never shown to the user, disabled in release mode
Const wxLOG_Trace:Int = 7      ' trace messages are also only enabled in debug mode
Const wxLOG_Progress:Int = 8   ' used for progress indicator (not yet)
Const wxLOG_User:Int = 100     ' user defined levels start here
