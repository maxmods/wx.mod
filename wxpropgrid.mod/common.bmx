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
Import wx.wxPanel
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

Import "src/include/*.h"

Import "src/advprops.cpp"
Import "src/editors.cpp"
Import "src/extras.cpp"
Import "src/manager.cpp"
Import "src/odcombo.cpp"
Import "src/propgrid.cpp"
Import "src/props.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxpropertygrid_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxpropertygrid_append:Byte Ptr(handle:Byte Ptr, property:Byte Ptr)
	Function bmx_wxpropertygrid_getgrid:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcaptionbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcaptionforegroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcellbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcelldisabledtextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getcelltextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getlinecolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpropertygrid_getmargincolour:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxstringproperty_create:Byte Ptr(label:String, name:String, value:String)
	
	Function bmx_wxpropertycategory_create:Byte Ptr(label:String, name:String)

	Function bmx_wxfontproperty_create:Byte Ptr(label:String, name:String, font:Byte Ptr)

	Function bmx_wxpropertycontainermethods_setpropertyhelpstringid(handle:Byte Ptr, id:Byte Ptr, helpString:String)
	Function bmx_wxpropertycontainermethods_setpropertyhelpstring(handle:Byte Ptr, name:String, helpString:String)

	Function bmx_wxsystemcolourproperty_create:Byte Ptr(label:String, name:String, value:Byte Ptr)

	Function bmx_wxcolourpropertyvalue_delete(handle:Byte Ptr)
	
	Function bmx_wxpgid_delete(handle:Byte Ptr)
	
End Extern

Const wxPG_LABEL:String = Null

Const wxPG_AUTO_SORT:Int = $00000010

Const wxPG_HIDE_CATEGORIES:Int = $00000020
Const wxPG_ALPHABETIC_MODE:Int = wxPG_HIDE_CATEGORIES | wxPG_AUTO_SORT
Const wxPG_BOLD_MODIFIED:Int = $00000040
Const wxPG_SPLITTER_AUTO_CENTER:Int = $00000080
Const wxPG_TOOLTIPS:Int = $00000100
Const wxPG_HIDE_MARGIN:Int = $00000200
Const wxPG_STATIC_SPLITTER:Int = $00000400
Const wxPG_STATIC_LAYOUT:Int = wxPG_HIDE_MARGIN | wxPG_STATIC_SPLITTER
Const wxPG_LIMITED_EDITING:Int = $00000800
Const wxPG_TOOLBAR:Int = $00001000
Const wxPG_DESCRIPTION:Int = $00002000
Const wxPG_COMPACTOR:Int = $00004000

Const wxPG_EX_INIT_NOCAT:Int = $00001000
Const wxPG_EX_NO_FLAT_TOOLBAR:Int = $00002000
Const wxPG_EX_MODE_BUTTONS:Int = $00008000
Const wxPG_EX_HELP_AS_TOOLTIPS:Int = $00010000
Const wxPG_EX_GREY_LABEL_WHEN_DISABLED:Int = $00040000
Const wxPG_EX_NATIVE_DOUBLE_BUFFERING:Int = $00080000
Const wxPG_EX_PROCESS_EVENTS_IMMEDIATELY:Int = $00100000
Const wxPG_EX_AUTO_UNSPECIFIED_VALUES:Int = $00200000

Const wxPG_DEFAULT_STYLE:Int = 0
Const wxPGMAN_DEFAULT_STYLE:Int = 0
Const wxPG_KEEP_STRUCTURE:Int = $00000010
Const wxPG_RECURSE:Int = $00000020
Const wxPG_RECURSE_STARTS:Int = $00000040
Const wxPG_FORCE:Int = $00000080

Const wxPG_LOW:Int = 1
Const wxPG_HIGH:Int = 2

Const wxPG_FULL_VALUE:Int = $00000001
Const wxPG_REPORT_ERROR:Int = $00000002
Const wxPG_PROPERTY_SPECIFIC:Int = $00000004
Const wxPG_EDITABLE_VALUE:Int = $00000008

