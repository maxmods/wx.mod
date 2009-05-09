' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxCalendarCtrl
End Rem
Module wx.wxCalendarCtrl

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: The calendar control allows the user to pick a date.
about: For this, it displays a window containing several parts: a control at the top to pick the
month and the year (either or both of them may be disabled), and a month area below them which
shows all the days in the month. The user can move the current selection using the keyboard and
select the date (generating EVT_CALENDAR event) by pressing <Return> or double clicking it.
<p>
It has advanced possibilities for the customization of its display. All global settings (such as
colours and fonts used) can, of course, be changed. But also, the display style for each day in
the month can be set independently using wxCalendarDateAttr class.
</p>
<p>
An item without custom attributes is drawn with the default colours and font and without border,
but setting custom attributes with SetAttr allows to modify its appearance. Just create a custom
attribute object and set it for the day you want to be displayed specially (note that the control
will take ownership of the pointer, i.e. it will delete it itself). A day may be marked as being
a holiday, even if it is not recognized as one by wxDateTime using SetHoliday method.
</p>
<p>
As the attributes are specified for each day, they may change when the month is changed, so you
will often want to update them in wxEVT_CALENDAR_MONTH event handler.
</p>
End Rem
Type wxCalendarCtrl Extends wxControl

	Function _create:wxCalendarCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCalendarCtrl = New wxCalendarCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxCalendarCtrl(wxObjectPtr:Byte Ptr)
		Return wxCalendarCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Creates a new wxCalendarCtrl.
	End Rem
	Function CreateCalendarCtrl:wxCalendarCtrl(parent:wxWindow, id:Int, date:wxDateTime = Null, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxCAL_SHOW_HOLIDAYS)
		Return New wxCalendarCtrl.Create(parent, id, date, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxCalendarCtrl.
	End Rem
	Method Create:wxCalendarCtrl(parent:wxWindow, id:Int, date:wxDateTime = Null, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxCAL_SHOW_HOLIDAYS)
			
		If date Then
			wxObjectPtr = bmx_wxcalendarctrl_create(Self, parent.wxObjectPtr, id, date.wxObjectPtr, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxcalendarctrl_create(Self, parent.wxObjectPtr, id, Null, x, y, w, h, style)
		End If
		
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Sets the current date.
	End Rem
	Method SetDate(date:wxDateTime)
		bmx_wxcalendarctrl_setdate(wxObjectPtr, date.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the currently selected date.
	End Rem
	Method GetDate:wxDateTime()
		Return wxDateTime._create(bmx_wxcalendarctrl_getdate(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: This method should be used instead of changing wxCAL_NO_MONTH_CHANGE style bit.
	about: It allows or disallows the user to change the month interactively. Note that if the month can not be
	changed, the year can not be changed either.
	End Rem
	Method EnableMonthChange(enable:Int = True)
		bmx_wxcalendarctrl_enablemonthchange(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: This function should be used instead of changing wxCAL_SHOW_HOLIDAYS style bit directly.
	about: It enables or disables the special highlighting of the holidays.
	End Rem
	Method EnableHolidayDisplay(display:Int = True)
		bmx_wxcalendarctrl_enableholidaydisplay(wxObjectPtr, display)
	End Method
	
	Rem
	bbdoc: Set the colours used for painting the weekdays at the top of the control.
	End Rem
	Method SetHeaderColours(colFG:wxColour, colBG:wxColour)
		bmx_wxcalendarctrl_setheadercolours(wxObjectPtr, colFG.wxObjectPtr, colBG.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the foreground colour of the header part of the calendar window.
	End Rem
	Method GetHeaderColourFg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_getheadercolourfg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the background colour of the header part of the calendar window.
	End Rem
	Method GetHeaderColourBg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_getheadercolourbg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set the colours to be used for highlighting the currently selected date.
	End Rem
	Method SetHighlightColours(colFG:wxColour, colBG:wxColour)
		bmx_wxcalendarctrl_sethighlightcolours(wxObjectPtr, colFG.wxObjectPtr, colBG.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the foreground highlight colour.
	End Rem
	Method GetHighlightColourFg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_gethighlightcolourfg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the background highlight colour.
	End Rem
	Method GetHighlightColourBg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_gethighlightcolourbg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the colours to be used for the holidays highlighting (only used if the window style includes wxCAL_SHOW_HOLIDAYS flag).
	End Rem
	Method SetHolidayColours(colFG:wxColour, colBG:wxColour)
		bmx_wxcalendarctrl_setholidaycolours(wxObjectPtr, colFG.wxObjectPtr, colBG.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the foreground colour currently used for holiday highlighting.
	End Rem
	Method GetHolidayColourFg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_getholidaycolourfg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Return the background colour currently used for holiday highlighting.
	End Rem
	Method GetHolidayColourBg:wxColour()
		Return wxColour._create(bmx_wxcalendarctrl_getholidaycolourbg(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the attribute for the given date (should be in the range 1...31).
	about: The returned object may be Null.
	End Rem
	Method GetAttr:wxCalendarDateAttr(day:Int)
		Return wxCalendarDateAttr._create(bmx_wxcalendarctrl_getattr(wxObjectPtr, day))
	End Method
	
	Rem
	bbdoc: Associates the attribute with the specified date (in the range 1...31).
	about: If the object is Null, the items attribute is cleared.
	End Rem
	Method SetAttr(day:Int, attr:wxCalendarDateAttr)
		If attr Then
			bmx_wxcalendarctrl_setattr(wxObjectPtr, day, attr.wxObjectPtr)
		Else
			bmx_wxcalendarctrl_setattr(wxObjectPtr, day, Null)
		End If
	End Method
	
	Rem
	bbdoc: Marks the specified day as being a holiday in the current month.
	End Rem
	Method SetHoliday(day:Int)
		bmx_wxcalendarctrl_setholiday(wxObjectPtr, day)
	End Method
	
	Rem
	bbdoc: Clears any attributes associated with the given day (in the range 1...31).
	End Rem
	Method ResetAttr(day:Int)
		bmx_wxcalendarctrl_resetattr(wxObjectPtr, day)
	End Method
	
	Rem
	bbdoc: Returns one of wxCAL_HITTEST_XXX constants and fills either date or wd pointer with the corresponding value
	depending on the hit test code.
	End Rem
	Method HitTest:wxDateTime(x:Int, y:Int, where:Int Var, wd:Int Var)
		Return wxDateTime._create(bmx_wxcalendarctrl_hittest(wxObjectPtr, x, y, Varptr where, Varptr wd))
	End Method
	
End Type

Rem
bbdoc: wxCalendarDateAttr is a custom attributes for a calendar date.
about: The objects of this type are used with wxCalendarCtrl.
End Rem
Type wxCalendarDateAttr

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxCalendarDateAttr(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCalendarDateAttr = New wxCalendarDateAttr
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Creates a new wxCalendarDateAttr.
	End Rem
	Function CreateCalendarDateAttr:wxCalendarDateAttr(colText:wxColour, colBack:wxColour = Null, colBorder:wxColour = Null, ..
			font:wxFont = Null, border:Int = wxCAL_BORDER_NONE)
		Return New wxCalendarDateAttr.Create(colText, colBack, colBorder, font, border)
	End Function
	
	Rem
	bbdoc: Creates a new wxCalendarDateAttr.
	End Rem
	Method Create:wxCalendarDateAttr(colText:wxColour, colBack:wxColour = Null, colBorder:wxColour = Null, ..
			font:wxFont = Null, border:Int = wxCAL_BORDER_NONE)
		
		If colBack Then
			If colBorder Then
				If font Then
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, colBack.wxObjectPtr, colBorder.wxObjectPtr, font.wxObjectPtr, border)
				Else
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, colBack.wxObjectPtr, colBorder.wxObjectPtr, Null, border)
				End If
			Else
				If font Then
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, colBack.wxObjectPtr, Null, font.wxObjectPtr, border)
				Else
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, colBack.wxObjectPtr, Null, Null, border)
				End If
			End If
		Else
			If colBorder Then
				If font Then
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, Null, colBorder.wxObjectPtr, font.wxObjectPtr, border)
				Else
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, Null, colBorder.wxObjectPtr, Null, border)
				End If
			Else
				If font Then
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, Null, Null, font.wxObjectPtr, border)
				Else
					wxObjectPtr = bmx_wxcalendardateattr_create(colText.wxObjectPtr, Null, Null, Null, border)
				End If
			End If
		End If
		
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the text (foreground) colour to use.
	End Rem
	Method SetTextColour(colour:wxColour)
		bmx_wxcalendardateattr_settextcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the text background colour to use.
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxcalendardateattr_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the border colour to use.
	End Rem
	Method SetBorderColour(colour:wxColour)
		bmx_wxcalendardateattr_setbordercolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font to use.
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxcalendardateattr_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the border kind.
	End Rem
	Method SetBorder(border:Int)
		bmx_wxcalendardateattr_setborder(wxObjectPtr, border)
	End Method
	
	Rem
	bbdoc: Display the date with this attribute as a holiday.
	End Rem
	Method SetHoliday(holiday:Int)
		bmx_wxcalendardateattr_setholidy(wxObjectPtr, holiday)
	End Method
	
	Rem
	bbdoc: Returns true if this item has a non-default text foreground colour.
	End Rem
	Method HasTextColour:Int()
		Return bmx_wxcalendardateattr_hastextcolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this attribute specifies a non-default text background colour.
	End Rem
	Method HasBackgroundColour:Int()
		Return bmx_wxcalendardateattr_hasbackgroundcolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this attribute specifies a non-default border colour.
	End Rem
	Method HasBorderColour:Int()
		Return bmx_wxcalendardateattr_hasbordercolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this attribute specifies a non-default font.
	End Rem
	Method HasFont:Int()
		Return bmx_wxcalendardateattr_hasfont(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this attribute specifies a non-default (i.e. any) border.
	End Rem
	Method HasBorder:Int()
		Return bmx_wxcalendardateattr_hasborder(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this attribute specifies that this item should be displayed as a holiday.
	End Rem
	Method IsHoliday:Int()
		Return bmx_wxcalendardateattr_isholiday(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the text colour to use for the item with this attribute.
	End Rem
	Method GetTextColour:wxColour()
		Return wxColour._create(bmx_wxcalendardateattr_gettextcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the background colour to use for the item with this attribute.
	End Rem
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxcalendardateattr_getbackgroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the border colour to use for the item with this attribute.
	End Rem
	Method GetBorderColour:wxColour()
		Return wxColour._create(bmx_wxcalendardateattr_getbordercolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the font to use for the item with this attribute.
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxcalendardateattr_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the border to use for the item with this attribute.
	End Rem
	Method GetBorder:Int()
		Return bmx_wxcalendardateattr_getborder(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: The wxCalendarEvent type is used together with wxCalendarCtrl.
End Rem
Type wxCalendarEvent Extends wxDateEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxCalendarEvent = New wxCalendarEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetWeekDay:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetWeekDay(day:Int)
	End Method

End Type


Type TCalendarCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_CALENDAR_SEL_CHANGED, ..
					wxEVT_CALENDAR_DAY_CHANGED, ..
					wxEVT_CALENDAR_MONTH_CHANGED, ..
					wxEVT_CALENDAR_YEAR_CHANGED, ..
					wxEVT_CALENDAR_DOUBLECLICKED, ..
					wxEVT_CALENDAR_WEEKDAY_CLICKED

				Return wxCalendarEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_CALENDAR_SEL_CHANGED, ..
					wxEVT_CALENDAR_DAY_CHANGED, ..
					wxEVT_CALENDAR_MONTH_CHANGED, ..
					wxEVT_CALENDAR_YEAR_CHANGED, ..
					wxEVT_CALENDAR_DOUBLECLICKED, ..
					wxEVT_CALENDAR_WEEKDAY_CLICKED
				Return bmx_wxcalendarctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TCalendarCtrlEventFactory

Type TCalendarCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxcalendarctrl_addresourcehandler()
	End Method
		
End Type

New TCalendarCtrlResourceFactory
