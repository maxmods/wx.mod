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
Import wx.wxBitmap
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
	Function bmx_wxtoolbar_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxtoolbar_addcontrol:Int(handle:Byte Ptr, control:Byte Ptr)
	Function bmx_wxtoolbar_addseparator(handle:Byte Ptr)
	Function bmx_wxtoolbar_addtool(handle:Byte Ptr, id:Int, label:String, bitmap1:Byte Ptr, bitmap2:Byte Ptr, ..
			kind:Int, shortHelp:String, longHelp:String, clientData:Object)
	Function bmx_wxtoolbar_realize:Int(handle:Byte Ptr)
	Function bmx_wxtoolbar_settoolbitmapsize(handle:Byte Ptr, w:Int, h:Int)

	Function bmx_wxtoolbar_geteventtype:Int(evt:Int)
	
End Extern

Const wxEVT_COMMAND_TOOL_CLICKED:Int = wxEVT_COMMAND_MENU_SELECTED
Const wxEVT_COMMAND_TOOL_RCLICKED:Int = 16
Const wxEVT_COMMAND_TOOL_ENTER:Int = 17

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

