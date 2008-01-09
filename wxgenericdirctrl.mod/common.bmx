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
Import wx.wxControl
Import wx.wxTreeCtrl
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

	Function bmx_wxgenericdirctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, dir:String, x:Int, y:Int, w:Int, h:Int, style:Int, filter:String, defaultFilter:Int)
	Function bmx_wxgenericdirctrl_init(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_collapsetree(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_expandpath:Int(handle:Byte Ptr, path:String)
	Function bmx_wxgenericdirctrl_collapsepath:Int(handle:Byte Ptr, path:String)
	Function bmx_wxgenericdirctrl_getdefaultpath:String(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_getpath:String(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_getfilepath:String(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_getfilter:String(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_getfilterindex:Int(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_getrootid:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_gettreectrl:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_recreatetree(handle:Byte Ptr)
	Function bmx_wxgenericdirctrl_setdefaultpath(handle:Byte Ptr, path:String)
	Function bmx_wxgenericdirctrl_setfilter(handle:Byte Ptr, filter:String)
	Function bmx_wxgenericdirctrl_setfilterindex(handle:Byte Ptr, index:Int)
	Function bmx_wxgenericdirctrl_setpath(handle:Byte Ptr, path:String)
	Function bmx_wxgenericdirctrl_showhidden(handle:Byte Ptr, show:Int)

End Extern

Const wxDIRCTRL_DIR_ONLY:Int = $0010
Const wxDIRCTRL_SELECT_FIRST:Int = $0020
Const wxDIRCTRL_SHOW_FILTERS:Int = $0040
Const wxDIRCTRL_3D_INTERNAL:Int = $0080
Const wxDIRCTRL_EDIT_LABELS:Int = $0100

