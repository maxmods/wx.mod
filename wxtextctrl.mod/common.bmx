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
Import wx.wxMouseEvent
Import wx.wxTextValidator
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

	Function bmx_wxtextctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, value:String, x:Int, y:Int, w:Int, h:Int, style:Int, validator:Byte Ptr)
	Function bmx_wxtextctrl_appendtext(handle:Byte Ptr, text:String)
	Function bmx_wxtextctrl_cancopy:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_cancut:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_canpaste:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_canredo:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_canundo:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_clear(handle:Byte Ptr)
	Function bmx_wxtextctrl_copy(handle:Byte Ptr)
	Function bmx_wxtextctrl_cut(handle:Byte Ptr)
	
	Function bmx_wxtextctrl_discardedits(handle:Byte Ptr)
	Function bmx_wxtextctrl_getdefaultstyle:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextctrl_getinsertionpoint:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_getlastposition:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_getlinelength:Int(handle:Byte Ptr, lineNo:Int)
	Function bmx_wxtextctrl_getlinetext:String(handle:Byte Ptr, lineNo:Int)
	Function bmx_wxtextctrl_getnumberoflines:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_getrange:String(handle:Byte Ptr, fromPos:Int, toPos:Int)
	Function bmx_wxtextctrl_getselection:Int(handle:Byte Ptr, fromPos:Int Ptr, toPos:Int Ptr)
	Function bmx_wxtextctrl_getstringselection:String(handle:Byte Ptr)
	Function bmx_wxtextctrl_getstyle:Byte Ptr(handle:Byte Ptr, position:Int)
	Function bmx_wxtextctrl_getvalue:String(handle:Byte Ptr)
	Function bmx_wxtextctrl_iseditable:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_isempty:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_ismodified:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_ismultiline:Int(handle:Byte Ptr)
	Function bmx_wxtextctrl_issingleline:Int(handle:Byte Ptr)

	Function bmx_wxtextctrl_loadfile:Int(handle:Byte Ptr, filename:String, ftype:Int)
	Function bmx_wxtextctrl_markdirty(handle:Byte Ptr)
	Function bmx_wxtextctrl_paste(handle:Byte Ptr)
	Function bmx_wxtextctrl_positiontoxy:Int(handle:Byte Ptr, pos:Int, x:Int Ptr, y:Int Ptr)
	Function bmx_wxtextctrl_redo(handle:Byte Ptr)
	Function bmx_wxtextctrl_remove(handle:Byte Ptr, fromPos:Int, toPos:Int)
	Function bmx_wxtextctrl_replace(handle:Byte Ptr, fromPos:Int, toPos:Int, value:String)
	Function bmx_wxtextctrl_savefile:Int(handle:Byte Ptr, filename:String, ftype:Int)
	Function bmx_wxtextctrl_setdefaultstyle:Int(handle:Byte Ptr, style:Byte Ptr)
	Function bmx_wxtextctrl_seteditable(handle:Byte Ptr, editable:Int)
	Function bmx_wxtextctrl_setinsertionpoint(handle:Byte Ptr, pos:Int)
	Function bmx_wxtextctrl_setinsertionpointend(handle:Byte Ptr)
	Function bmx_wxtextctrl_setmaxlength(handle:Byte Ptr, length:Int)
	Function bmx_wxtextctrl_setmodified(handle:Byte Ptr, modified:Int)
	Function bmx_wxtextctrl_setselection(handle:Byte Ptr, fromPos:Int, toPos:Int)
	Function bmx_wxtextctrl_setstyle(handle:Byte Ptr, fromPos:Int, toPos:Int, style:Byte Ptr)
	Function bmx_wxtextctrl_changevalue(handle:Byte Ptr, value:String)
	Function bmx_wxtextctrl_showposition(handle:Byte Ptr, pos:Int)
	Function bmx_wxtextctrl_undo(handle:Byte Ptr)
	Function bmx_wxtextctrl_writetext(handle:Byte Ptr, text:String)
	Function bmx_wxtextctrl_xytoposition:Int(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxtextctrl_setvalue(handle:Byte Ptr, value:String)

	Function bmx_wxtextctrl_hittest:Int(handle:Byte Ptr, x:Int, y:Int, col:Int Ptr, row:Int Ptr)

	Function bmx_wxtextattr_getalignment:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextattr_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextattr_getleftindent:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_getleftsubindent:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_getrightindent:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_gettabs:Int[](handle:Byte Ptr)
	Function bmx_wxtextattr_gettextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtextattr_hasalignment:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hasbackgroundcolour:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hasfont:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hasleftindent:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hasrightindent:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hastabs:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_hastextcolour:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_getflags:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_isdefault:Int(handle:Byte Ptr)
	Function bmx_wxtextattr_merge(handle:Byte Ptr, overlay:Byte Ptr)
	Function bmx_wxtextattr_setalignment(handle:Byte Ptr, alignment:Int)
	Function bmx_wxtextattr_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxtextattr_setflags(handle:Byte Ptr, flags:Int)
	Function bmx_wxtextattr_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxtextattr_setleftindent(handle:Byte Ptr, indent:Int, subIndent:Int)
	Function bmx_wxtextattr_setrightindent(handle:Byte Ptr, indent:Int)
	Function bmx_wxtextattr_settabs(handle:Byte Ptr, tabs:Int[])
	Function bmx_wxtextattr_settextcolour(handle:Byte Ptr, colour:Byte Ptr)

	Function bmx_wxtextattr_create:Byte Ptr(colText:Byte Ptr, colBack:Byte Ptr, font:Byte Ptr, alignment:Int)

	Function bmx_wxtextattr_delete(handle:Byte Ptr)
	
	Function bmx_wxtextctrl_geteventtype:Int(evt:Int)

	Function bmx_wxtexturlevent_getmouseevent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtexturlevent_geturlstart:Int(handle:Byte Ptr)
	Function bmx_wxtexturlevent_geturlend:Int(handle:Byte Ptr)

	Function bmx_wxtextctrl_emulatekeypress:Int(handle:Byte Ptr, event:Byte Ptr)

	Function bmx_wxtextctrl_addresourcehandler()

End Extern

' note : these are set as negative because they used to be positive but where then moved (in wxWidgets), where
' they are these days assigned a runtime number...
Const wxEVT_COMMAND_TEXT_URL:Int = -13
Const wxEVT_COMMAND_TEXT_MAXLEN:Int = -14


' wxTextCtrl style flags
Const wxTE_NO_VSCROLL:Int = $0002
Const wxTE_AUTO_SCROLL:Int = $0008

Const wxTE_READONLY:Int = $0010
Const wxTE_MULTILINE:Int = $0020
Const wxTE_PROCESS_TAB:Int = $0040

' alignment flags
Const wxTE_LEFT:Int = $0000                    ' 0x0000
Const wxTE_CENTER:Int = wxALIGN_CENTER_HORIZONTAL ' 0x0100
Const wxTE_RIGHT:Int = wxALIGN_RIGHT             ' 0x0200
Const wxTE_CENTRE:Int = wxTE_CENTER

' this style means To use RICHEDIT control And does something only under wxMSW
' And Win32 And is silently ignored under all other platforms
Const wxTE_RICH:Int = $0080

Const wxTE_PROCESS_ENTER:Int = $0400
Const wxTE_PASSWORD:Int = $0800

Const wxTE_AUTO_URL:Int = $1000

' by Default, the Windows text control doesn't show the selection when it
' doesn't have focus - use this style to force it to always show it
Const wxTE_NOHIDESEL:Int = $2000

' use wxHSCROLL To Not wrap text at all, wxTE_CHARWRAP To wrap it at any
' position And wxTE_WORDWRAP To wrap at words boundary
'
' If no wrapping style is given at all, the control wraps at word boundary
Const wxTE_DONTWRAP:Int = wxHSCROLL
Const wxTE_CHARWRAP:Int = $4000  ' wrap at any position
Const wxTE_WORDWRAP:Int = $0001  ' wrap only at words boundaries
Const wxTE_BESTWRAP:Int = $0000  ' this is the Default


Const wxTE_HT_UNKNOWN:Int = -2  ' this means HitTest() is simply Not implemented
Const wxTE_HT_BEFORE:Int = -1   ' either To the Left Or Upper
Const wxTE_HT_ON_TEXT:Int = 0   ' directly on
Const wxTE_HT_BELOW:Int = 1     ' below [the last line]
Const wxTE_HT_BEYOND:Int = 2    ' after [the End of line]

Const wxTEXT_ALIGNMENT_DEFAULT:Int = 0
Const wxTEXT_ALIGNMENT_LEFT:Int = 1
Const wxTEXT_ALIGNMENT_CENTRE:Int = 2
Const wxTEXT_ALIGNMENT_CENTER:Int = wxTEXT_ALIGNMENT_CENTRE
Const wxTEXT_ALIGNMENT_RIGHT:Int = 3
Const wxTEXT_ALIGNMENT_JUSTIFIED:Int = 4

Const wxTEXT_ATTR_TEXT_COLOUR:Int = $0001
Const wxTEXT_ATTR_BACKGROUND_COLOUR:Int = $0002
Const wxTEXT_ATTR_FONT_FACE:Int = $0004
Const wxTEXT_ATTR_FONT_SIZE:Int = $0008
Const wxTEXT_ATTR_FONT_WEIGHT:Int = $0010
Const wxTEXT_ATTR_FONT_ITALIC:Int = $0020
Const wxTEXT_ATTR_FONT_UNDERLINE:Int = $0040
Const wxTEXT_ATTR_FONT:Int = wxTEXT_ATTR_FONT_FACE | wxTEXT_ATTR_FONT_SIZE | wxTEXT_ATTR_FONT_WEIGHT | ..
		wxTEXT_ATTR_FONT_ITALIC | wxTEXT_ATTR_FONT_UNDERLINE
Const wxTEXT_ATTR_ALIGNMENT:Int = $0080
Const wxTEXT_ATTR_LEFT_INDENT:Int = $0100
Const wxTEXT_ATTR_RIGHT_INDENT:Int = $0200
Const wxTEXT_ATTR_TABS:Int = $0400

Const wxTEXT_TYPE_ANY:Int = 0

?macos
Rem
bbdoc: Set this To True if you want to use the 'classic' MLTE-based implementation instead of the HIView-based implementation in 10.3 and upwards.
about: The former has more features (backgrounds etc.), but may show redraw artefacts and other
problems depending on your usage; hence, the default is False.
End Rem
Const wxMAC_TEXTCONTROL_USE_MLTE:String = "mac.textcontrol-use-mlte"

Rem
bbdoc: Set this To True if you want editable text controls to have spell checking turned on by default.
about: You can change this setting individually on a control using MacCheckSpelling

End Rem
Const wxMAC_TEXTCONTROL_USE_SPELL_CHECKER:String = "mac.textcontrol-use-spell-checker"

?
