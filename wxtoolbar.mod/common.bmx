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
Import wx.wxControl
Import wx.wxBitmap
Import wx.wxMenu
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

	Function bmx_wxtoolbar_injectSelf(handle:Byte Ptr, obj:Object)

	Function bmx_wxtoolbar_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxtoolbar_addcontrol(handle:Byte Ptr, control:Byte Ptr, label:String)
	Function bmx_wxtoolbar_addseparator:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoolbar_addstretchablespace:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoolbar_addtool:Byte Ptr(handle:Byte Ptr, id:Int, label:String, bitmap1:Byte Ptr, bitmap2:Byte Ptr, ..
			kind:Int, shortHelp:String, longHelp:String, clientData:Object)
	Function bmx_wxtoolbar_realize:Int(handle:Byte Ptr)
	Function bmx_wxtoolbar_settoolbitmapsize(handle:Byte Ptr, w:Int, h:Int)

	Function bmx_wxtoolbar_cleartools(handle:Byte Ptr)
	Function bmx_wxtoolbar_deletetool:Int(handle:Byte Ptr, toolId:Int)
	Function bmx_wxtoolbar_deletetoolbypos:Int(handle:Byte Ptr, pos:Int)
	Function bmx_wxtoolbar_enabletool(handle:Byte Ptr, toolId:Int, enable:Int)
	Function bmx_wxtoolbar_gettoolscount:Int(handle:Byte Ptr)
	Function bmx_wxtoolbar_gettoolsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxtoolbar_gettoolbitmapsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxtoolbar_getmargins(handle:Byte Ptr, leftRight:Int Ptr, topBottom:Int Ptr)
	Function bmx_wxtoolbar_gettoolenabled:Int(handle:Byte Ptr, toolId:Int)
	Function bmx_wxtoolbar_gettoollonghelp:String(handle:Byte Ptr, toolId:Int)
	Function bmx_wxtoolbar_gettoolpacking:Int(handle:Byte Ptr)
	Function bmx_wxtoolbar_gettoolpos:Int(handle:Byte Ptr, toolId:Int)
	Function bmx_wxtoolbar_gettoolseparation:Int(handle:Byte Ptr)
	Function bmx_wxtoolbar_gettoolshorthelp:String(handle:Byte Ptr, toolId:Int)
	Function bmx_wxtoolbar_gettoolstate:Int(handle:Byte Ptr, toolId:Int)

	Function bmx_wxtoolbar_addchecktool:Byte Ptr(handle:Byte Ptr, id:Int, label:String, bitmap1:Byte Ptr, bitmap2:Byte Ptr, ..
			shortHelp:String, longHelp:String, clientData:Object)
	Function bmx_wxtoolbar_addradiotool:Byte Ptr(handle:Byte Ptr, id:Int, label:String, bitmap1:Byte Ptr, bitmap2:Byte Ptr, ..
			shortHelp:String, longHelp:String, clientData:Object)
	Function bmx_wxtoolbar_inserttool:Byte Ptr(handle:Byte Ptr, pos:Int, id:Int, label:String, bitmap1:Byte Ptr, ..
			bitmap2:Byte Ptr, kind:Int, clientData:Object, shortHelp:String, longHelp:String)
	Function bmx_wxtoolbar_setmargins(handle:Byte Ptr, leftRight:Int, topBottom:Int)
	Function bmx_wxtoolbar_settoolclientdata(handle:Byte Ptr, id:Int, clientData:Object)
	Function bmx_wxtoolbar_settooldisabledbitmap(handle:Byte Ptr, id:Int, bitmap:Byte Ptr)
	Function bmx_wxtoolbar_settoollonghelp(handle:Byte Ptr, id:Int, helpString:String)
	Function bmx_wxtoolbar_settoolpacking(handle:Byte Ptr, packing:Int)
	Function bmx_wxtoolbar_settoolshorthelp(handle:Byte Ptr, id:Int, helpString:String)
	Function bmx_wxtoolbar_settoolnormalbitmap(handle:Byte Ptr, id:Int, bitmap:Byte Ptr)
	Function bmx_wxtoolbar_settoolseparation(handle:Byte Ptr, separation:Int)
	Function bmx_wxtoolbar_toggletool(handle:Byte Ptr, id:Int, toggle:Int)
	Function bmx_wxtoolbar_removetool:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxtoolbar_gettoolclientdata:Object(handle:Byte Ptr, id:Int)
	Function bmx_wxtoolbar_findbyid:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxtoolbar_findcontrol:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxtoolbar_findtoolforposition:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxtoolbar_insertcontrol:Byte Ptr(handle:Byte Ptr, pos:Int, control:Byte Ptr)
	Function bmx_wxtoolbar_insertseparator:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxtoolbar_insertstretchablespace:Byte Ptr(handle:Byte Ptr, pos:Int)
	Function bmx_wxtoolbar_setdropdownmenu:Int(handle:Byte Ptr, id:Int, menu:Byte Ptr)
	
	Function bmx_wxtoolbartoolbase_isbutton:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_iscontrol:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_isseparator:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getstyle:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getkind:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_isenabled:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_istoggled:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_canbetoggled:Int(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getnormalbitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getdisabledbitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getbitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getlabel:String(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getshorthelp:String(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getlonghelp:String(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getclientdata:Object(handle:Byte Ptr)

	Function bmx_wxtoolbartoolbase_enable:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxtoolbartoolbase_toggle(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_settoggle:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxtoolbartoolbase_setshorthelp:Int(handle:Byte Ptr, help:String)
	Function bmx_wxtoolbartoolbase_setlonghelp:Int(handle:Byte Ptr, help:String)
	Function bmx_wxtoolbartoolbase_setnormalbitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxtoolbartoolbase_setdisabledbitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxtoolbartoolbase_setlabel(handle:Byte Ptr, label:String)
	Function bmx_wxtoolbartoolbase_setclientdata(handle:Byte Ptr, data:Object)
	Function bmx_wxtoolbartoolbase_detach(handle:Byte Ptr)
	Function bmx_wxtoolbartoolbase_attach(handle:Byte Ptr, toolbar:Byte Ptr)
	Function bmx_wxtoolbartoolbase_setdropdownmenu(handle:Byte Ptr, menu:Byte Ptr)
	Function bmx_wxtoolbartoolbase_getdropdownmenu:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxtoolbar_geteventtype:Int(evt:Int)
	
	Function bmx_wxtoolbar_addresourcehandler()
	
End Extern

Const wxEVT_COMMAND_TOOL_CLICKED:Int = wxEVT_COMMAND_MENU_SELECTED
Const wxEVT_COMMAND_TOOL_RCLICKED:Int = 16
Const wxEVT_COMMAND_TOOL_ENTER:Int = 17
Const wxEVT_COMMAND_TOOL_DROPDOWN_CLICKED:Int = -18

Const wxTB_HORIZONTAL:Int = wxHORIZONTAL    ' == $0004
Const wxTB_TOP:Int = wxTB_HORIZONTAL

' lay out the toolbar vertically
Const wxTB_VERTICAL:Int = wxVERTICAL      ' == $0008
Const wxTB_LEFT:Int = wxTB_VERTICAL

' show 3D buttons (wxToolBarSimple only)
Const wxTB_3DBUTTONS:Int = $0010

' "flat" buttons (Win32/GTK only)
Const wxTB_FLAT:Int = $0020

' dockable toolbar (GTK only)
Const wxTB_DOCKABLE:Int = $0040

' don't show the icons (they're shown by default)
Const wxTB_NOICONS:Int = $0080

' show the text (Not shown by Default)
Const wxTB_TEXT:Int = $0100

' don't show the divider between toolbar and the window (Win32 only)
Const wxTB_NODIVIDER:Int = $0200

' no automatic alignment (Win32 only, useless)
Const wxTB_NOALIGN:Int = $0400

' show the text And the icons alongside, Not vertically stacked (Win32/GTK)
Const wxTB_HORZ_LAYOUT:Int = $0800
Const wxTB_HORZ_TEXT:Int = wxTB_HORZ_LAYOUT | wxTB_TEXT

' don't show the toolbar short help tooltips
Const wxTB_NO_TOOLTIPS:Int = $1000

' lay out toolbar at the bottom of the window
Const wxTB_BOTTOM:Int = $2000

' lay out toolbar at the Right edge of the window
Const wxTB_RIGHT:Int = $4000

