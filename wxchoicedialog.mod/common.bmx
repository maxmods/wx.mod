' Copyright (c) 2007 Bruce A Henderson
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

	Function bmx_wxgetsinglechoice:String(message:String, caption:String, choices:String[], ..
		parent:Byte Ptr, x:Int, y:Int, centre:Int, width:Int, height:Int)
	Function bmx_wxgetsinglechoiceindex:Int(message:String, caption:String, choices:String[], ..
		parent:Byte Ptr, x:Int, y:Int, centre:Int, width:Int, height:Int)

	Function bmx_wxsinglechoicedialog_create:Byte Ptr(handle:Object, parent:Byte Ptr, message:String, caption:String, choices:String[], style:Int, x:Int, y:Int)
	Function bmx_wxsinglechoicedialog_getselection:Int(handle:Byte Ptr)
	Function bmx_wxsinglechoicedialog_getstringselection:String(handle:Byte Ptr)
	Function bmx_wxsinglechoicedialog_setselection(handle:Byte Ptr, index:Int)
	Function bmx_wxsinglechoicedialog_showmodal:Int(handle:Byte Ptr)

	Function bmx_wxmultichoicedialog_create:Byte Ptr(handle:Object, parent:Byte Ptr, message:String, caption:String, choices:String[], style:Int, x:Int, y:Int)
	Function bmx_wxmultichoicedialog_getselections:Int[](handle:Byte Ptr)
	Function bmx_wxmultichoicedialog_setselections(handle:Byte Ptr, selections:Int[])
	Function bmx_wxmultichoicedialog_showmodal:Int(handle:Byte Ptr)

End Extern


Const wxCHOICEDLG_STYLE:Int = wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER | wxOK | wxCANCEL | wxCENTRE

