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

Import "include/*.h"
Import "src/advancedmatrixobject.cpp"
Import "src/font75.cpp"
Import "src/font77.cpp"
Import "src/matrixobject.cpp"
Import "src/wxledfont.cpp"
Import "src/wxledpanel.cpp"


Import "glue.cpp"

Extern

	Function bmx_wxledpanel_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, pointW:Int, pointH:Int, ..
			fieldW:Int, fieldH:Int, padding:Int, x:Int, y:Int, style:Int)
	Function bmx_wxledpanel_clear(handle:Byte Ptr)
	Function bmx_wxledpanel_reset(handle:Byte Ptr)
	Function bmx_wxledpanel_getfieldsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxledpanel_getpointsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxledpanel_setledcolour(handle:Byte Ptr, colourID:Int)
	Function bmx_wxledpanel_getledcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxledpanel_setscrollspeed(handle:Byte Ptr, speed:Int)
	Function bmx_wxledpanel_getscrollspeed:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_setscrolldirection(handle:Byte Ptr, direction:Int)
	Function bmx_wxledpanel_getscrolldirection:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_showinverted(handle:Byte Ptr, invert:Int)
	Function bmx_wxledpanel_showinactiveleds(handle:Byte Ptr, showInactives:Int)
	Function bmx_wxledpanel_settextalign(handle:Byte Ptr, align:Int)
	Function bmx_wxledpanel_gettextalign:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_settext(handle:Byte Ptr, text:String, align:Int)
	Function bmx_wxledpanel_gettext:String(handle:Byte Ptr)
	Function bmx_wxledpanel_settextpaddingleft(handle:Byte Ptr, padLeft:Int)
	Function bmx_wxledpanel_settextpaddingright(handle:Byte Ptr, padRight:Int)
	Function bmx_wxledpanel_gettextpaddingleft:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_gettextpaddingright:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_setletterspace(handle:Byte Ptr, letterSpace:Int)
	Function bmx_wxledpanel_getletterspace:Int(handle:Byte Ptr)
	Function bmx_wxledpanel_setfonttypewide(handle:Byte Ptr)
	Function bmx_wxledpanel_setfonttypesmall(handle:Byte Ptr)
	Function bmx_wxledpanel_isfonttypesmall:Int(handle:Byte Ptr)

End Extern


Const wxLED_COLOUR_RED:Int = 1
Const wxLED_COLOUR_GREEN:Int = 2
Const wxLED_COLOUR_BLUE:Int = 3
Const wxLED_COLOUR_YELLOW:Int = 4
Const wxLED_COLOUR_MAGENTA:Int = 5
Const wxLED_COLOUR_CYAN:Int = 6
Const wxLED_COLOUR_GREY:Int = 7

Const wxLED_SCROLL_NONE:Int = 0
Const wxLED_SCROLL_UP:Int = 1
Const wxLED_SCROLL_DOWN:Int = 2
Const wxLED_SCROLL_LEFT:Int = 3
Const wxLED_SCROLL_RIGHT:Int = 4

Const wxLED_TEXTALIGN_LEFT:Int = 0
Const wxLED_TEXTALIGN_RIGHT:Int = 1
Const wxLED_TEXTALIGN_CENTER:Int = 2

Const wxLED_TEXTVALIGN_TOP:Int = 0
Const wxLED_TEXTVALIGN_BOTTOM:Int = 1
Const wxLED_TEXTVALIGN_CENTER:Int = 2

