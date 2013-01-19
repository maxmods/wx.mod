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

	Function bmx_wxprogressdialog_create:Byte Ptr(handle:Object, title:String, message:String, maximum:Int, parent:Byte Ptr, style:Int)
	Function bmx_wxprogressdialog_resume(handle:Byte Ptr)
	Function bmx_wxprogressdialog_updateprogress:Int(handle:Byte Ptr, value:Int, newMessage:String, skip:Int Ptr)
	Function bmx_wxprogressdialog_pulse:Int(handle:Byte Ptr, newMessage:String, skip:Int Ptr)

End Extern

Const wxPD_CAN_ABORT:Int = $0001
Const wxPD_APP_MODAL:Int = $0002
Const wxPD_AUTO_HIDE:Int = $0004
Const wxPD_ELAPSED_TIME:Int = $0008
Const wxPD_ESTIMATED_TIME:Int = $0010
Const wxPD_SMOOTH:Int = $0020
Const wxPD_REMAINING_TIME:Int = $0040
Const wxPD_CAN_SKIP:Int = $0080
