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

	Function bmx_wxnotebook_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxnotebook_addpage:Int(handle:Byte Ptr, page:Byte Ptr, text:String, selected:Int, imageId:Int)
	Function bmx_wxnotebook_insertpage:Int(handle:Byte Ptr, index:Int, page:Byte Ptr, text:String, selected:Int, imageId:Int)
	Function bmx_wxnotebook_advanceselection(handle:Byte Ptr, forward:Int)
	
	Function bmx_wxnotebook_assignimagelist(handle:Byte Ptr, imagelist:Byte Ptr)
	Function bmx_wxnotebook_setimagelist(handle:Byte Ptr, imagelist:Byte Ptr)
	
	Function bmx_wxnotebookevent_getoldselection:Int(evt:Byte Ptr)
	Function bmx_wxnotebookevent_getselection:Int(evt:Byte Ptr)
	Function bmx_wxnotebookevent_setoldselection(evt:Byte Ptr, page:Int)
	Function bmx_wxnotebookevent_setselection(evt:Byte Ptr, page:Int)
	
	Function bmx_wxnotebook_geteventtype:Int(evt:Int)
End Extern


Const wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED:Int = 802
Const wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING:Int = 803
