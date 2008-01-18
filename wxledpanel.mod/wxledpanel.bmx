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

Rem
bbdoc: wxLEDPanel
End Rem
Module wx.wxLEDPanel

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A panel with many LEDs and can be used as ticker or to show static text.
End Rem
Type wxLEDPanel Extends wxControl

	Rem
	bbdoc: Creates a new wxLEDPanel.
	End Rem
	Function CreateLEDPanel:wxLEDPanel(parent:wxWindow, id:Int, pointW:Int, pointH:Int, fieldW:Int, fieldH:Int, ..
			padding:Int = 0, x:Int = -1, y:Int = -1, style:Int = wxNO_BORDER)
		Return New wxLEDPanel.Create(parent, id, pointW, pointH, fieldW, fieldH, padding, x, y, style)
	End Function
				
	Rem
	bbdoc: Creates a new wxLEDPanel.
	End Rem
	Method Create:wxLEDPanel(parent:wxWindow, id:Int, pointW:Int, pointH:Int, fieldW:Int, fieldH:Int, ..
			padding:Int = 0, x:Int = -1, y:Int = -1, style:Int = wxNO_BORDER)
		wxObjectPtr = bmx_wxledpanel_create(Self, parent.wxObjectPtr, id, pointW, pointH, ..
			fieldW, fieldH, padding, x, y, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Clears the LED context
	End Rem
	Method Clear()
		bmx_wxledpanel_clear(wxObjectPtr)
	End Method

	Rem
	bbdoc: Resets the LED context.
	End Rem
	Method Reset()
		bmx_wxledpanel_reset(wxObjectPtr)
	End Method

	' 
	Rem
	bbdoc: Gets the current field size.
	End Rem
	Method GetFieldsize(w:Int Var, h:Int Var) 
		bmx_wxledpanel_getfieldsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the current point size.
	End Rem
	Method GetPointsize(w:Int Var, h:Int Var)
		bmx_wxledpanel_getpointsize(wxObjectPtr, Varptr w, Varptr h)
	End Method

	' Set the Colour of the LEDs
	Rem
	bbdoc: Sets the LED colour.
	about: Valid colours are : wxLED_COLOUR_RED, wxLED_COLOUR_GREEN, wxLED_COLOUR_BLUE, 
	wxLED_COLOUR_YELLOW, wxLED_COLOUR_MAGENTA, wxLED_COLOUR_CYAN and wxLED_COLOUR_GREY.
	End Rem
	Method SetLEDColour(colourID:Int)
		bmx_wxledpanel_setledcolour(wxObjectPtr, colourID)
	End Method
	
	Rem
	bbdoc: Returns the LED colour.
	End Rem
	Method GetLEDColour:wxColour()
		Return wxColour._create(bmx_wxledpanel_getledcolour(wxObjectPtr))
	End Method

	Rem
	bbdoc: Sets the panel scroll speed.
	End Rem
	Method SetScrollSpeed(speed:Int)
		bmx_wxledpanel_setscrollspeed(wxObjectPtr, speed)
	End Method
	
	Rem
	bbdoc: Gets the panel scroll speed.
	End Rem
	Method GetScrollSpeed:Int()
		Return bmx_wxledpanel_getscrollspeed(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the panel scroll direction.
	about: One of wxLED_SCROLL_NONE, wxLED_SCROLL_UP, wxLED_SCROLL_DOWN, 
	wxLED_SCROLL_LEFT or wxLED_SCROLL_RIGHT.
	End Rem
	Method SetScrollDirection(direction:Int)
		bmx_wxledpanel_setscrolldirection(wxObjectPtr, direction)
	End Method

	Rem
	bbdoc: Gets the scroll direction.
	End Rem
	Method GetScrollDirection:Int()
		Return bmx_wxledpanel_getscrolldirection(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the LED invertedness.
	about: If True, the panel colours will be inverted.
	End Rem
	Method ShowInverted(invert:Int = True)
		bmx_wxledpanel_showinverted(wxObjectPtr, invert)
	End Method

	Rem
	bbdoc: Enables or disables the visibility of inactive LEDs.
	End Rem
	Method ShowInactiveLEDs(showInactives:Int = True)
		bmx_wxledpanel_showinactiveleds(wxObjectPtr, showInactives)
	End Method

	Rem
	bbdoc: Sets the text alignment.
	about: Only appropriate for wxLED_SCROLL_NONE.
	End Rem
	Method SetTextAlign(align:Int)
		bmx_wxledpanel_settextalign(wxObjectPtr, align)
	End Method

	Rem
	bbdoc: Returns the current text alignment.
	End Rem
	Method GetTextAlign:Int()
		Return bmx_wxledpanel_gettextalign(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the panel text, and optionally sets alignment.
	End Rem
	Method SetText(text:String, align:Int = -1)
		bmx_wxledpanel_settext(wxObjectPtr, text, align)
	End Method

	Rem
	bbdoc: Gets the text.
	End Rem
	Method GetText:String()
		Return bmx_wxledpanel_gettext(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the left text padding.
	about: Only used when wxALIGN_LEFT or wxALIGN_RIGHT
	End Rem
	Method SetTextPaddingLeft(padLeft:Int)
		bmx_wxledpanel_settextpaddingleft(wxObjectPtr, padLeft)
	End Method

	Rem
	bbdoc: Sets the right text padding.
	about: Only used when wxALIGN_LEFT or wxALIGN_RIGHT
	End Rem
	Method SetTextPaddingRight(padRight:Int)
		bmx_wxledpanel_settextpaddingright(wxObjectPtr, padRight)
	End Method

	Rem
	bbdoc: Returns the left padding amount.
	End Rem
	Method GetTextPaddingLeft:Int()
		Return bmx_wxledpanel_gettextpaddingleft(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the right padding amount.
	End Rem
	Method GetTextPaddingRight:Int()
		Return bmx_wxledpanel_gettextpaddingright(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the spacing between letters.
	End Rem
	Method SetLetterSpace(letterSpace:Int)
		bmx_wxledpanel_setletterspace(wxObjectPtr, letterSpace)
	End Method

	Rem
	bbdoc: Returns the spacing amount between letters
	End Rem
	Method GetLetterSpace:Int()
		Return bmx_wxledpanel_getletterspace(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the font type to Wide.
	End Rem
	Method SetFontTypeWide()
		bmx_wxledpanel_setfonttypewide(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the font type to Small.
	End Rem
	Method SetFontTypeSmall()
		bmx_wxledpanel_setfonttypesmall(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if the font type is currently small.
	End Rem
	Method IsFontTypeSmall:Int()
		Return bmx_wxledpanel_isfonttypesmall(wxObjectPtr)
	End Method

End Type


