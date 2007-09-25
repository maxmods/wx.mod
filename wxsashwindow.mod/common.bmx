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
Import wx.wxWindow
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

	Function bmx_wxsashwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxsashwindow_getsashvisible:Int(handle:Byte Ptr, edge:Int)
	Function bmx_wxsashwindow_getmaximumsizex:Int(handle:Byte Ptr)
	Function bmx_wxsashwindow_getmaximumsizey:Int(handle:Byte Ptr)
	Function bmx_wxsashwindow_getminimumsizex:Int(handle:Byte Ptr)
	Function bmx_wxsashwindow_getminimumsizey:Int(handle:Byte Ptr)
	Function bmx_wxsashwindow_setmaximumsizex(handle:Byte Ptr, size:Int)
	Function bmx_wxsashwindow_setmaximumsizey(handle:Byte Ptr, size:Int)
	Function bmx_wxsashwindow_setminimumsizex(handle:Byte Ptr, size:Int)
	Function bmx_wxsashwindow_setminimumsizey(handle:Byte Ptr, size:Int)
	Function bmx_wxsashwindow_setsashvisible(handle:Byte Ptr, edge:Int, visible:Int)

	Function bmx_wxsashevent_getedge:Int(handle:Byte Ptr)
	Function bmx_wxsashevent_getdragrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxsashevent_getdragstatus:Int(handle:Byte Ptr)

	Function bmx_wxsashwindow_geteventtype:Int(evt:Int)
End Extern

Const wxEVT_SASH_DRAGGED:Int = 11200

Const wxSASH_TOP:Int = 0
Const wxSASH_RIGHT:Int = 1
Const wxSASH_BOTTOM:Int = 2
Const wxSASH_LEFT:Int = 3
Const wxSASH_NONE:Int = 100

Const wxSW_NOBORDER:Int = $0000
Const wxSW_BORDER:Int = $0020
Const wxSW_3DSASH:Int = $0040
Const wxSW_3DBORDER:Int = $0080
Const wxSW_3D:Int = wxSW_3DSASH | wxSW_3DBORDER

Const wxSASH_STATUS_OK:Int = 0
Const wxSASH_STATUS_OUT_OF_RANGE:Int = 1
