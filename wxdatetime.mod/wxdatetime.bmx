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
bbdoc: wxDateTime
End Rem
Module wx.wxDateTime

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
bbdoc: The wxDateTime type represents an absolute moment in the time.
End Rem
Type wxDateTime

	Const TZ_Local:Int = 0
	
	' zones from GMT (= Greenwhich Mean Time): they're guaranteed to be
	' consequent numbers, so writing something like `GMT0 + offset' is
	' safe If Abs(offset) <= 12
	
	' underscore stands For minus
	Const GMT_12:Int = 1
	Const GMT_11:Int = 2
	Const GMT_10:Int = 3
	Const GMT_9:Int = 4
	Const GMT_8:Int = 5
	Const GMT_7:Int = 6
	Const GMT_6:Int = 7
	Const GMT_5:Int = 8
	Const GMT_4:Int = 9
	Const GMT_3:Int = 10
	Const GMT_2:Int = 11
	Const GMT_1:Int = 12
	Const GMT0:Int = 13
	Const GMT1:Int = 14
	Const GMT2:Int = 15
	Const GMT3:Int = 16
	Const GMT4:Int = 17
	Const GMT5:Int = 18
	Const GMT6:Int = 19
	Const GMT7:Int = 20
	Const GMT8:Int = 21
	Const GMT9:Int = 22
	Const GMT10:Int = 23
	Const GMT11:Int = 24
	Const GMT12:Int = 25
	Const GMT13:Int = 26
	' Note that GMT12 And GMT_12 are Not the same: there is a difference
	' of exactly one day between them
	
	' some symbolic names For TZ
	
	' Europe
	Const WET:Int = GMT0                         ' Western Europe Time
	Const WEST:Int = GMT1                        ' Western Europe Summer Time
	Const CET:Int = GMT1                         ' Central Europe Time
	Const CEST:Int = GMT2                        ' Central Europe Summer Time
	Const EET:Int = GMT2                         ' Eastern Europe Time
	Const EEST:Int = GMT3                        ' Eastern Europe Summer Time
	Const MSK:Int = GMT3                         ' Moscow Time
	Const MSD:Int = GMT4                         ' Moscow Summer Time
	
	' US And Canada
	Const AST:Int = GMT_4                        ' Atlantic Standard Time
	Const ADT:Int = GMT_3                        ' Atlantic Daylight Time
	Const EST:Int = GMT_5                        ' Eastern Standard Time
	Const EDT:Int = GMT_4                        ' Eastern Daylight Saving Time
	Const CST:Int = GMT_6                        ' Central Standard Time
	Const CDT:Int = GMT_5                        ' Central Daylight Saving Time
	Const MST:Int = GMT_7                        ' Mountain Standard Time
	Const MDT:Int = GMT_6                        ' Mountain Daylight Saving Time
	Const PST:Int = GMT_8                        ' Pacific Standard Time
	Const PDT:Int = GMT_7                        ' Pacific Daylight Saving Time
	Const HST:Int = GMT_10                       ' Hawaiian Standard Time
	Const AKST:Int = GMT_9                       ' Alaska Standard Time
	Const AKDT:Int = GMT_8                       ' Alaska Daylight Saving Time
	
	' Australia
	Const A_WST:Int = GMT8                       ' Western Standard Time
	Const A_CST:Int = GMT13 + 1                  ' Central Standard Time (+9.5)
	Const A_EST:Int = GMT10                      ' Eastern Standard Time
	Const A_ESST:Int = GMT11                     ' Eastern Summer Time
	
	' New Zealand
	Const NZST:Int = GMT12                       ' Standard Time
	Const NZDT:Int = GMT13                       ' Daylight Saving Time
	
	' TODO add more symbolic timezone names here
	
	' Universal Coordinated Time = the New And politically correct name
	' For GMT
	Const UTC:Int = GMT0
	
	' invalid value for the year
	Const Inv_Year:Int = -32768
	
	' Calendar
	Const Gregorian:Int = 0  ' current calendar
	Const Julian:Int = 1
	
	' Country
	Const Country_Unknown:Int = 0 ' no special information For this country
	Const Country_Default:Int = 1  ' set the Default country with SetCountry() Method
	                  ' Or use the Default country with any other
	
	' Western European countries: we assume that they all follow the same
	' DST rules (True Or False?)
	Const Country_WesternEurope_Start:Int = 2
	Const Country_EEC:Int = Country_WesternEurope_Start
	Const France:Int = 3
	Const Germany:Int = 4
	Const UK:Int = 5
	Const Country_WesternEurope_End:Int = UK
	
	Const Russia:Int = 6
	Const USA:Int = 7
	
	Const Jan:Int = 0
	Const Feb:Int = 1
	Const Mar:Int = 2
	Const Apr:Int = 3
	Const May:Int = 4
	Const Jun:Int = 5
	Const Jul:Int = 6
	Const Aug:Int = 7
	Const Sep:Int = 8
	Const Oct:Int = 9
	Const Nov:Int = 10
	Const Dec:Int = 11
	Const Inv_Month:Int = 12
	
	Const Sun:Int = 0
	Const Mon:Int = 1
	Const Tue:Int = 2
	Const Wed:Int = 3
	Const Thu:Int = 4
	Const Fri:Int = 5
	Const Sat:Int = 6
	Const Inv_WeekDay:Int = 7
	
	
	Const Name_Full:Int = $01       ' Return full name
	Const Name_Abbr:Int = $02
	
	
	Const Default_First:Int = 0   ' Sunday_First For US, Monday_First For the rest
	Const Monday_First:Int = 1    ' week starts with a Monday
	Const Sunday_First:Int = 2     ' week starts with a Sunday

	Field wxObjectPtr:Byte Ptr

	Function _create:wxDateTime(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDateTime = New wxDateTime
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function CreateDateTime:wxDateTime()
		Return New wxDateTime.Create()
	End Function
	
	Method Create:wxDateTime()
		wxObjectPtr = bmx_wxdatetime_create()
		Return Self
	End Method
	
	Method CreateFromTimeT:wxDateTime(timet:Int)
		wxObjectPtr = bmx_wxdatetime_createfromtimet(timet)
		Return Self
	End Method
	
	Method CreateFromJDN:wxDateTime(jdn:Double)
		wxObjectPtr = bmx_wxdatetime_createfromjdn(jdn)
		Return Self
	End Method
	
	Method CreateFromHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		wxObjectPtr = bmx_wxdatetime_createfromhms(hour, minute, Second, millisec)
		Return Self
	End Method
	
	Method CreateFromDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		wxObjectPtr = bmx_wxdatetime_createfromdmy(day, Month, year, hour, minute, Second, millisec)
		Return Self
	End Method
	
	Function SetCountry(country:Int)
		bmx_wxdatetime_setcountry(country)
	End Function
	
	Function GetCountry:Int()
		Return bmx_wxdatetime_getcountry()
	End Function
	
	Function IsWestEuropeanCountry:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_iswesteuropeancountry(country)
	End Function
	
	Function GetCurrentYear:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentyear(cal)
	End Function
	
	Function ConvertYearToBC:Int(year:Int)
		Return bmx_wxdatetime_convertyeartobc(year)
	End Function
	
	Function GetCurrentMonth:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentmonth(cal)
	End Function
	
	Function IsLeapYear:Int(year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_isleapyear(year, cal)
	End Function
	
	Function GetCenturyForYear:Int(year:Int)
		Return bmx_wxdatetime_getcenturyforyear(year)
	End Function
	
	Function GetNumberOfDaysForYear:Int(year:Int, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdaysforyear(year, cal)
	End Function
	
	Function GetNumberOfDays:Int(Month:Int, year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdays(Month, year, cal)
	End Function
	
	Function GetMonthName:String(Month:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getmonthname(Month, flags)
	End Function
	
	Function GetWeekDayName:String(WeekDay:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getweekdayname(WeekDay, flags)
	End Function
	
	Function GetAmString:String()
		Return bmx_wxdatetime_getamstring()
	End Function
	
	Function GetPmString:String()
		Return bmx_wxdatetime_getpmstring()
	End Function
	
	Function IsDSTApplicable:Int(year:Int = Inv_Year, country:Int = Country_Default)
		Return bmx_wxdatetime_isdstapplicable(year, country)
	End Function
	
	Function GetBeginDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getbegindst(year, country))
	End Function
	
	Function GetEndDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getenddst(year, country))
	End Function
	
	Function Now:wxDateTime()
		Return _create(bmx_wxdatetime_now())
	End Function
	
	Function UNow:wxDateTime()
		Return _create(bmx_wxdatetime_unow())
	End Function
	
	Function Today:wxDateTime()
		Return _create(bmx_wxdatetime_today())
	End Function
	

	Method SetToCurrent:wxDateTime()
		bmx_wxdatetime_settocurrent(wxObjectPtr)
		Return Self
	End Method
	
	Method SetTimeT:wxDateTime(timet:Int)
		bmx_wxdatetime_settimet(wxObjectPtr, timet)
		Return Self
	End Method
	
	Method SetJDN:wxDateTime(jdn:Double)
		bmx_wxdatetime_setjdn(wxObjectPtr, jdn)
		Return Self
	End Method
	
	Method SetHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_sethms(wxObjectPtr, hour, minute, Second, millisec)
		Return Self
	End Method
	
	Method SetDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_setdmy(wxObjectPtr, day, Month, year, hour, minute, Second, millisec)
		Return Self
	End Method

	Method ResetTime:wxDateTime()
		bmx_wxdatetime_resettime(wxObjectPtr)
		Return Self
	End Method
	
	Method SetYear:wxDateTime(year:Int)
		bmx_wxdatetime_setyear(wxObjectPtr, year)
		Return Self
	End Method
	
	Method SetMonth:wxDateTime(Month:Int)
		bmx_wxdatetime_setmonth(wxObjectPtr, Month)
		Return Self
	End Method
	
	Method SetDay:wxDateTime(day:Int)
		bmx_wxdatetime_setday(wxObjectPtr, day)
		Return Self
	End Method
	
	Method SetHour:wxDateTime(hour:Int)
		bmx_wxdatetime_sethour(wxObjectPtr, hour)
		Return Self
	End Method
	
	Method SetMinute:wxDateTime(minute:Int)
		bmx_wxdatetime_setminute(wxObjectPtr, minute)
		Return Self
	End Method
	
	Method SetSecond:wxDateTime(Second:Int)
		bmx_wxdatetime_setsecond(wxObjectPtr, Second)
		Return Self
	End Method
	
	Method SetMillisecond:wxDateTime(millisec:Int)
		bmx_wxdatetime_setmillisecond(wxObjectPtr, millisec)
		Return Self
	End Method
	
	Method IsValid:Int()
		Return bmx_wxdatetime_isvalid(wxObjectPtr)
	End Method
	
	Method GetDateOnly:wxDateTime()
		Return wxDateTime._create(bmx_wxdatetime_getdateonly(wxObjectPtr))
	End Method
	
	Method GetTicks:Int()
		Return bmx_wxdatetime_getticks(wxObjectPtr)
	End Method
	
	Method GetCentury:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getcentury(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getcentury(wxObjectPtr, Null)
		End If
	End Method

	Method GetYear:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getyear(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getyear(wxObjectPtr, Null)
		End If
	End Method

	Method GetMonth:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getmonth(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getmonth(wxObjectPtr, Null)
		End If
	End Method

	Method GetDay:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getday(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getday(wxObjectPtr, Null)
		End If
	End Method

	Method GetWeekDay:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekday(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekday(wxObjectPtr, Null)
		End If
	End Method

	Method GetHour:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_gethour(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_gethour(wxObjectPtr, Null)
		End If
	End Method

	Method GetMinute:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getminute(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getminute(wxObjectPtr, Null)
		End If
	End Method

	Method GetSecond:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getsecond(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getsecond(wxObjectPtr, Null)
		End If
	End Method

	Method GetMillisecond:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getmillisecond(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getmillisecond(wxObjectPtr, Null)
		End If
	End Method

	Method GetDayOfYear:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getdayofyear(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getdayofyear(wxObjectPtr, Null)
		End If
	End Method

	Method GetWeekOfYear:Int(flags:Int = Monday_First, tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekofyear(wxObjectPtr, flags, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekofyear(wxObjectPtr, flags, Null)
		End If
	End Method

	Method GetWeekOfMonth:Int(flags:Int = Monday_First, tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekofmonth(wxObjectPtr, flags, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekofmonth(wxObjectPtr, flags, Null)
		End If
	End Method

	Method IsWorkDay:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_isworkday(wxObjectPtr, country)
	End Method
	
'	Method IsGregorianDate:Int(country:Int = Gr_Standard)
'	End Method
	
	Method SetFromDOS(ddt:Int)
		bmx_wxdatetime_setfromdos(wxObjectPtr, ddt)
	End Method
	
	Method GetAsDOS:Int()
		Return bmx_wxdatetime_getasdos(wxObjectPtr)
	End Method
	
	Method IsEqualTo:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isequalto(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Method IsEarlierThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isearlierthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Method IsLaterThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_islaterthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Method IsStrictlyBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isstrictlybetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Method IsBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isbetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Method IsSameDate:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issamedate(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Method IsSameTime:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issametime(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Method IsEqualUpTo:Int(dt:wxDateTime, ts:wxTimeSpan)
	End Method

	Method AddTS:wxDateTime(diff:wxTimeSpan)
	End Method

	Method SubtractTS:wxDateTime(diff:wxTimeSpan)
	End Method

	Method AddDS:wxDateTime(diff:wxDateSpan)
	End Method

	Method SubtractDS:wxDateTime(diff:wxDateSpan)
	End Method
	
	Method ParseRfc822Date:String(date:String)
	End Method
	
	Method ParseFormat:String(date:String, format:String = wxDefaultDateTimeFormat, dateDef:wxDateTime = Null)
	End Method
	
	Method ParseDateTime:String(datetime:String)
	End Method
	
	Method ParseDate:String(date:String)
	End Method
	
	Method ParseTime:String(time:String)
	End Method
	
	Method Format:String(format:String = wxDefaultDateTimeFormat, tz:TimeZone = Null)
	End Method
	
	Method FormatDate:String()
	End Method
	
	Method FormatTime:String()
	End Method
	
	Method FormatISODate:String()
	End Method
	
	Method FormatISOTime:String()
	End Method
	
	Method SetToWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
	
		Return Self
	End Method
	
	Method GetWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
	End Method
	
	Method SetToNextWeekDay:wxDateTime(WeekDay:Int)
	
		Return Self
	End Method
	
	Method GetNextWeekDay:wxDateTime(WeekDay:Int)
	End Method
	
	Method SetToPrevWeekDay:wxDateTime(WeekDay:Int)
	
		Return Self
	End Method
	
	Method GetPrevWeekDay:wxDateTime(WeekDay:Int)
	End Method
	
	Method SetToWeekDay:Int(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
	End Method
	
	Method GetToWeekDay:wxDateTime(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
	End Method
	
	Method SetToLastWeekDay:Int(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
	End Method
	
	Method GetLastWeekDay:wxDateTime(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
	End Method
	
	Function SetToWeekOfYear:wxDateTime(year:Int, numWeek:Int, WeekDay:Int = Mon)
	End Function
	
	Method SetToLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
	
		Return Self
	End Method
	
	Method GetLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
	End Method
	
	Method SetToYearDay:wxDateTime(yday:Int)
	
		Return Self
	End Method
	
	Method GetYearDay:wxDateTime(yday:Int)
	End Method
	
	Method GetJulianDayNumber:Double()
	End Method
	
	Method GetJDN:Double()
	End Method
	
	Method GetModifiedJulianDayNumber:Double()
	End Method
	
	Method GetMJD:Double()
	End Method
	
	Method GetRataDie:Double()
	End Method
	
	Method FromTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
	End Method
	
	Method ToTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
	End Method
	
	Method MakeTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)

		Return Self
	End Method
	
	Method MakeFromTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)

		Return Self
	End Method
	
	Method ToUTC:wxDateTime(noDST:Int = False)
	End Method
	
	Method MakeUTC:wxDateTime(noDST:Int = False)
	
		Return Self
	End Method
	
	Method IsDST:Int(country:Int = Country_Default)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxdatetime_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Type wxTimeSpan

	Field wxObjectPtr:Byte Ptr

End Type

Type wxDateSpan

	Field wxObjectPtr:Byte Ptr

End Type

Type TimeZone

	Field wxObjectPtr:Byte Ptr



End Type


Rem
bbdoc: This event type holds information about a date change and is used together with wxDatePickerCtrl.
about: It also serves as a base type for wxCalendarEvent.
End Rem
Type wxDateEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxDateEvent = New wxDateEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the date.
	End Rem
	Method GetDate:wxDateTime()
		Return wxDateTime._create(bmx_wxdateevent_getdate(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Sets the date carried by the event, normally only used by the library internally.
	End Rem
	Method SetDate(date:wxDateTime)
		bmx_wxdateevent_setdate(wxEventPtr, date.wxObjectPtr)
	End Method

End Type

