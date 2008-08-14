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

	Function bmx_wxcheckbox_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, label:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxcheckbox_getvalue:Int(handle:Byte Ptr)
	Function bmx_wxcheckbox_get3statevalue:Int(handle:Byte Ptr)
	Function bmx_wxcheckbox_is3rdstateallowedforuser:Int(handle:Byte Ptr)
	Function bmx_wxcheckbox_is3state:Int(handle:Byte Ptr)
	Function bmx_wxcheckbox_ischecked:Int(handle:Byte Ptr)
	Function bmx_wxcheckbox_setvalue(handle:Byte Ptr, state:Int)
	Function bmx_wxcheckbox_set3statevalue(handle:Byte Ptr, state:Int)	

	Function bmx_wxcheckbox_geteventtype:Int(evt:Int)
	
	Function bmx_wxcheckbox_addresourcehandler()

End Extern


Const wxCHK_2STATE:Int = $0000
Const wxCHK_3STATE:Int = $1000
Const wxCHK_ALLOW_3RD_STATE_FOR_USER:Int = $2000

Const wxCHK_UNCHECKED:Int = 0
Const wxCHK_CHECKED:Int = 1
Const wxCHK_UNDETERMINED:Int = 2

