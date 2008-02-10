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
	
	Rem
	bbdoc: 
	End Rem
	Function CreateDateTime:wxDateTime()
		Return New wxDateTime.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxDateTime()
		wxObjectPtr = bmx_wxdatetime_create()
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateFromTimeT:wxDateTime(timet:Int)
		wxObjectPtr = bmx_wxdatetime_createfromtimet(timet)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateFromJDN:wxDateTime(jdn:Double)
		wxObjectPtr = bmx_wxdatetime_createfromjdn(jdn)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateFromHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		wxObjectPtr = bmx_wxdatetime_createfromhms(hour, minute, Second, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateFromDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		wxObjectPtr = bmx_wxdatetime_createfromdmy(day, Month, year, hour, minute, Second, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function SetCountry(country:Int)
		bmx_wxdatetime_setcountry(country)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetCountry:Int()
		Return bmx_wxdatetime_getcountry()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function IsWestEuropeanCountry:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_iswesteuropeancountry(country)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetCurrentYear:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentyear(cal)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function ConvertYearToBC:Int(year:Int)
		Return bmx_wxdatetime_convertyeartobc(year)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetCurrentMonth:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentmonth(cal)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function IsLeapYear:Int(year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_isleapyear(year, cal)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetCenturyForYear:Int(year:Int)
		Return bmx_wxdatetime_getcenturyforyear(year)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetNumberOfDaysForYear:Int(year:Int, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdaysforyear(year, cal)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetNumberOfDays:Int(Month:Int, year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdays(Month, year, cal)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetMonthName:String(Month:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getmonthname(Month, flags)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetWeekDayName:String(WeekDay:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getweekdayname(WeekDay, flags)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetAmString:String()
		Return bmx_wxdatetime_getamstring()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetPmString:String()
		Return bmx_wxdatetime_getpmstring()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function IsDSTApplicable:Int(year:Int = Inv_Year, country:Int = Country_Default)
		Return bmx_wxdatetime_isdstapplicable(year, country)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetBeginDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getbegindst(year, country))
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function GetEndDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getenddst(year, country))
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function Now:wxDateTime()
		Return _create(bmx_wxdatetime_now())
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function UNow:wxDateTime()
		Return _create(bmx_wxdatetime_unow())
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function Today:wxDateTime()
		Return _create(bmx_wxdatetime_today())
	End Function
	

	Rem
	bbdoc: 
	End Rem
	Method SetToCurrent:wxDateTime()
		bmx_wxdatetime_settocurrent(wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTimeT:wxDateTime(timet:Int)
		bmx_wxdatetime_settimet(wxObjectPtr, timet)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetJDN:wxDateTime(jdn:Double)
		bmx_wxdatetime_setjdn(wxObjectPtr, jdn)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_sethms(wxObjectPtr, hour, minute, Second, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_setdmy(wxObjectPtr, day, Month, year, hour, minute, Second, millisec)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ResetTime:wxDateTime()
		bmx_wxdatetime_resettime(wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetYear:wxDateTime(year:Int)
		bmx_wxdatetime_setyear(wxObjectPtr, year)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMonth:wxDateTime(Month:Int)
		bmx_wxdatetime_setmonth(wxObjectPtr, Month)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDay:wxDateTime(day:Int)
		bmx_wxdatetime_setday(wxObjectPtr, day)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetHour:wxDateTime(hour:Int)
		bmx_wxdatetime_sethour(wxObjectPtr, hour)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinute:wxDateTime(minute:Int)
		bmx_wxdatetime_setminute(wxObjectPtr, minute)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSecond:wxDateTime(Second:Int)
		bmx_wxdatetime_setsecond(wxObjectPtr, Second)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMillisecond:wxDateTime(millisec:Int)
		bmx_wxdatetime_setmillisecond(wxObjectPtr, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsValid:Int()
		Return bmx_wxdatetime_isvalid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDateOnly:wxDateTime()
		Return wxDateTime._create(bmx_wxdatetime_getdateonly(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTicks:Int()
		Return bmx_wxdatetime_getticks(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCentury:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getcentury(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getcentury(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetYear:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getyear(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getyear(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetMonth:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getmonth(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getmonth(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDay:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getday(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getday(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetWeekDay:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekday(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekday(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetHour:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_gethour(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_gethour(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetMinute:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getminute(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getminute(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetSecond:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getsecond(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getsecond(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetMillisecond:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getmillisecond(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getmillisecond(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDayOfYear:Int(tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getdayofyear(wxObjectPtr, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getdayofyear(wxObjectPtr, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetWeekOfYear:Int(flags:Int = Monday_First, tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekofyear(wxObjectPtr, flags, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekofyear(wxObjectPtr, flags, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetWeekOfMonth:Int(flags:Int = Monday_First, tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_getweekofmonth(wxObjectPtr, flags, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_getweekofmonth(wxObjectPtr, flags, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsWorkDay:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_isworkday(wxObjectPtr, country)
	End Method
	
'	Method IsGregorianDate:Int(country:Int = Gr_Standard)
'	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFromDOS(ddt:Int)
		bmx_wxdatetime_setfromdos(wxObjectPtr, ddt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAsDOS:Int()
		Return bmx_wxdatetime_getasdos(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsEqualTo:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isequalto(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsEarlierThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isearlierthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsLaterThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_islaterthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsStrictlyBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isstrictlybetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isbetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsSameDate:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issamedate(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsSameTime:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issametime(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsEqualUpTo:Int(dt:wxDateTime, ts:wxTimeSpan)
		Return bmx_wxdatetime_isequalupto(wxObjectPtr, dt.wxObjectPtr, ts.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddTS:wxDateTime(diff:wxTimeSpan)
		Return wxDateTime._create(bmx_wxdatetime_addts(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SubtractTS:wxDateTime(diff:wxTimeSpan)
		Return wxDateTime._create(bmx_wxdatetime_subtractts(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddDS:wxDateTime(diff:wxDateSpan)
		Return wxDateTime._create(bmx_wxdatetime_addds(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SubtractDS:wxDateTime(diff:wxDateSpan)
		Return wxDateTime._create(bmx_wxdatetime_subtractds(wxObjectPtr, diff.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ParseRfc822Date:String(date:String)
		Return bmx_wxdatetime_parserfc822date(wxObjectPtr, date)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ParseFormat:String(date:String, format:String = wxDefaultDateTimeFormat, dateDef:wxDateTime = Null)
		If dateDef Then
			Return bmx_wxdatetime_parseformat(wxObjectPtr, date, format, dateDef.wxObjectPtr)
		Else
			Return bmx_wxdatetime_parseformat(wxObjectPtr, date, format, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ParseDateTime:String(datetime:String)
		Return bmx_wxdatetime_parsedatetime(wxObjectPtr, datetime)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ParseDate:String(date:String)
		Return bmx_wxdatetime_parsedate(wxObjectPtr, date)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ParseTime:String(time:String)
		Return bmx_wxdatetime_parsetime(wxObjectPtr, time)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Format:String(format:String = wxDefaultDateTimeFormat, tz:TimeZone = Null)
		If tz Then
			Return bmx_wxdatetime_format(wxObjectPtr, format, tz.wxObjectPtr)
		Else
			Return bmx_wxdatetime_format(wxObjectPtr, format, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FormatDate:String()
		Return bmx_wxdatetime_formatdate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FormatTime:String()
		Return bmx_wxdatetime_formattime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FormatISODate:String()
		Return bmx_wxdatetime_formatisodate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FormatISOTime:String()
		Return bmx_wxdatetime_formatisotime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
		bmx_wxdatetime_settoweekdayinsameweek(wxObjectPtr, WeekDay, flags)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
		Return wxDateTime._create(bmx_wxdatetime_getweekdayinsameweek(wxObjectPtr, WeekDay, flags))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToNextWeekDay:wxDateTime(WeekDay:Int)
		bmx_wxdatetime_settonextweekday(wxObjectPtr, WeekDay)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextWeekDay:wxDateTime(WeekDay:Int)
		Return wxDateTime._create(bmx_wxdatetime_getnextweekday(wxObjectPtr, WeekDay))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToPrevWeekDay:wxDateTime(WeekDay:Int)
		bmx_wxdatetime_settoprevweekday(wxObjectPtr, WeekDay)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPrevWeekDay:wxDateTime(WeekDay:Int)
		Return wxDateTime._create(bmx_wxdatetime_getprevweekday(wxObjectPtr, WeekDay))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToWeekDay:Int(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return bmx_wxdatetime_settoweekday(wxObjectPtr, WeekDay, n, Month, year)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetToWeekDay:wxDateTime(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_gettoweekday(wxObjectPtr, WeekDay, n, Month, year))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToLastWeekDay:Int(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return bmx_wxdatetime_settolastweekday(wxObjectPtr, WeekDay, Month, year)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLastWeekDay:wxDateTime(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_getlastweekday(wxObjectPtr, WeekDay, Month, year))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function SetToWeekOfYear:wxDateTime(year:Int, numWeek:Int, WeekDay:Int = Mon)
		Return wxDateTime._create(bmx_wxdatetime_settoweekofyear(year, numWeek, WeekDay))
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method SetToLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
		bmx_wxdatetime_settolastdayofmonth(wxObjectPtr, Month, year)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_getlastmonthday(wxObjectPtr, Month, year))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToYearDay:wxDateTime(yday:Int)
		bmx_wxdatetime_settoyearday(wxObjectPtr, yday)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetYearDay:wxDateTime(yday:Int)
		Return wxDateTime._create(bmx_wxdatetime_getyearday(wxObjectPtr, yday))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetJulianDayNumber:Double()
		Return bmx_wxdatetime_getjuliandaynumber(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetJDN:Double()
		Return bmx_wxdatetime_getjdn(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetModifiedJulianDayNumber:Double()
		Return bmx_wxdatetime_getmodifiedjuliandaynumber(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMJD:Double()
		Return bmx_wxdatetime_getmjd(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRataDie:Double()
		Return bmx_wxdatetime_getratadie(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FromTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_fromtimezone(wxObjectPtr, tz.wxObjectPtr, noDST))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_totimezone(wxObjectPtr, tz.wxObjectPtr, noDST))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
		bmx_wxdatetime_maketimezone(wxObjectPtr, tz.wxObjectPtr, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeFromTimezone:wxDateTime(tz:TimeZone, noDST:Int = False)
		bmx_wxdatetime_makefromtimezone(wxObjectPtr, tz.wxObjectPtr, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToUTC:wxDateTime(noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_toutc(wxObjectPtr, noDST))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeUTC:wxDateTime(noDST:Int = False)
		bmx_wxdatetime_makeutc(wxObjectPtr, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsDST:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_isdst(wxObjectPtr, country)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxdatetime_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Represents a time interval.
End Rem
Type wxTimeSpan

	Field wxObjectPtr:Byte Ptr

	Method Delete()
		If wxObjectPtr Then
			bmx_wxtimespan_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: This type is a "logical time span"
about: It is useful for implementing program logic for such things as "add one month to the
date" which, in general, doesn't mean to add 60*60*24*31 seconds to it, but to take the same
date the next month (to understand that this is indeed different consider adding one month
to Feb, 15 -- we want to get Mar, 15, of course).
<p>
When adding a month to the date, all lesser components (days, hours, ...) won't be changed
unless the resulting date would be invalid: for example, Jan 31 + 1 month will be Feb 28,
not (non-existing) Feb 31.
</p>
<p>
Because of this feature, adding and subtracting back again the same wxDateSpan will not, in
general give back the original date: Feb 28 - 1 month will be Jan 28, not Jan 31!
</p>
<p>
wxDateSpan objects can be either positive or negative. They may be multiplied by scalars
which multiply all deltas by the scalar: i.e. 2*(1 month and 1 day) is 2 months and 2 days.
They can be added together and with wxDateTime or wxTimeSpan, but the type of result is
different for each case.
</p>
<p>
Beware about weeks: if you specify both weeks and days, the total number of days added will
be 7*weeks + days! See also GetTotalDays() function.
</p>
<p>
Equality operators are defined for wxDateSpans. Two datespans are equal if and only if they
both give the same target date when added to every source date. Thus wxDateSpan::Months(1)
is not equal to wxDateSpan::Days(30), because they don't give the same date when added to 1
Feb. But wxDateSpan::Days(14) is equal to wxDateSpan::Weeks(2)
</p>
<p>
Finally, notice that for adding hours, minutes and so on you don't need this type at all:
wxTimeSpan will do the job because there are no subtleties associated with those (we don't
support leap seconds).
</p>
End Rem
Type wxDateSpan

	Field wxObjectPtr:Byte Ptr

	Function _create:wxDateSpan(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDateSpan = New wxDateSpan
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateDateSpan:wxDateSpan(years:Int = 0, months:Int = 0, weeks:Int = 0, days:Int = 0)
		Return New wxDateSpan.Create(years, months, weeks, days)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxDateSpan(years:Int = 0, months:Int = 0, weeks:Int = 0, days:Int = 0)
		wxObjectPtr = bmx_wxdatespan_create(years, months, weeks, days)
		Return Self
	End Method
	
	
	
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxdatespan_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

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

