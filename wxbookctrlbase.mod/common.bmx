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
Import wx.wxImageList
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

	Function bmx_wxbookctrlbase_addpage:Int(handle:Byte Ptr, page:Byte Ptr, text:String, selected:Int, imageId:Int)
	Function bmx_wxbookctrlbase_insertpage:Int(handle:Byte Ptr, index:Int, page:Byte Ptr, text:String, selected:Int, imageId:Int)
	Function bmx_wxbookctrlbase_advanceselection(handle:Byte Ptr, forward:Int)
	
	Function bmx_wxbookctrlbase_assignimagelist(handle:Byte Ptr, imagelist:Byte Ptr)
	Function bmx_wxbookctrlbase_setimagelist(handle:Byte Ptr, imagelist:Byte Ptr)

	Function bmx_wxbookctrlbase_deleteallpages:Int(handle:Byte Ptr)
	Function bmx_wxbookctrlbase_deletepage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_getcurrentpage:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxbookctrlbase_getpage:Byte Ptr(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_getpagecount:Int(handle:Byte Ptr)
	Function bmx_wxbookctrlbase_getpageimage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_getpagetext:String(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_getselection:Int(handle:Byte Ptr)
	Function bmx_wxbookctrlbase_hittest:Int(handle:Byte Ptr, x:Int, y:Int, flags:Int Ptr)
	Function bmx_wxbookctrlbase_removepage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_setpagesize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxbookctrlbase_setpageimage:Int(handle:Byte Ptr, page:Int, image:Int)
	Function bmx_wxbookctrlbase_setpagetext:Int(handle:Byte Ptr, page:Int, text:String)
	Function bmx_wxbookctrlbase_setselection:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxbookctrlbase_changeselection:Int(handle:Byte Ptr, page:Int)

	Function bmx_wxbookctrlevent_getoldselection:Int(evt:Byte Ptr)
	Function bmx_wxbookctrlevent_getselection:Int(evt:Byte Ptr)
	Function bmx_wxbookctrlevent_setoldselection(evt:Byte Ptr, page:Int)
	Function bmx_wxbookctrlevent_setselection(evt:Byte Ptr, page:Int)
	
	Function bmx_wxbookctrlbase_geteventtype:Int(evt:Int)

End Extern

Const wxBK_HITTEST_NOWHERE:Int = 1
Const wxBK_HITTEST_ONICON:Int = 2
Const wxBK_HITTEST_ONLABEL:Int = 4
Const wxBK_HITTEST_ONITEM:Int = wxBK_HITTEST_ONICON | wxBK_HITTEST_ONLABEL
Const wxBK_HITTEST_ONPAGE:Int = 8

Const wxBK_DEFAULT:Int = $0000
Const wxBK_TOP:Int = $0010
Const wxBK_BOTTOM:Int = $0020
Const wxBK_LEFT:Int = $0040
Const wxBK_RIGHT:Int = $0080
Const wxBK_ALIGN_MASK:Int = wxBK_TOP | wxBK_BOTTOM | wxBK_LEFT | wxBK_RIGHT
