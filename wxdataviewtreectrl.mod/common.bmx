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
Import wx.wxDataViewCtrl
Import wx.wxImageList
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

	Function bmx_wxdataviewtreectrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxdataviewtreectrl_appendcontainer:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, icon:Int, expanded:Int, data:Object)
	Function bmx_wxdataviewtreectrl_appenditem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, icon:Int, data:Object)
	Function bmx_wxdataviewtreectrl_deleteallitems(handle:Byte Ptr)
	Function bmx_wxdataviewtreectrl_deletechildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_deleteitem(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getchildcount:Int(handle:Byte Ptr, parent:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getimagelist:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getitemexpandedicon:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getitemicon:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getitemtext:String(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_getnthchild:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, pos:Int)
	Function bmx_wxdataviewtreectrl_insertcontainer:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, previous:Byte Ptr, text:String, icon:Int, expanded:Int, data:Object)
	Function bmx_wxdataviewtreectrl_insertitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, previous:Byte Ptr, text:String, icon:Int, data:Object)
	Function bmx_wxdataviewtreectrl_iscontainer:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxdataviewtreectrl_prependcontainer:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, icon:Int, expanded:Int, data:Object)
	Function bmx_wxdataviewtreectrl_prependitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, icon:Int, data:Object)
	Function bmx_wxdataviewtreectrl_setimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxdataviewtreectrl_setitemexpandedicon(handle:Byte Ptr, item:Byte Ptr, icon:Byte Ptr)
	Function bmx_wxdataviewtreectrl_setitemicon(handle:Byte Ptr, item:Byte Ptr, icon:Byte Ptr)
	Function bmx_wxdataviewtreectrl_setitemtext(handle:Byte Ptr, item:Byte Ptr, text:String)
	Function bmx_wxdataviewtreectrl_setitemdata(handle:Byte Ptr, item:Byte Ptr, data:Object)
	Function bmx_wxdataviewtreectrl_getitemdata:Object(handle:Byte Ptr, item:Byte Ptr)

End Extern
