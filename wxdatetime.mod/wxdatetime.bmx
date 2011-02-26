' Copyright (c) 2007-2011 Bruce A Henderson
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
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
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
	bbdoc: Sets the country to use by default.
	about: This setting influences the DST calculations, date formatting and other things.
	<p>
	The possible values for country parameter are enumerated in wxDateTime constants section.
	</p>
	End Rem
	Function SetCountry(country:Int)
		bmx_wxdatetime_setcountry(country)
	End Function
	
	Rem
	bbdoc: Returns the current default country.
	about: The default country is used for DST calculations, for example.
	End Rem
	Function GetCountry:Int()
		Return bmx_wxdatetime_getcountry()
	End Function
	
	Rem
	bbdoc: This function returns true if the specified (or default) country is one of Western European ones.
	about: It is used internally by wxDateTime to determine the DST convention and date and time formatting rules.
	End Rem
	Function IsWestEuropeanCountry:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_iswesteuropeancountry(country)
	End Function
	
	Rem
	bbdoc: Get the current year in given calendar (only Gregorian is currently supported).
	End Rem
	Function GetCurrentYear:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentyear(cal)
	End Function
	
	Rem
	bbdoc: Converts the year in absolute notation (i.e. a number which can be negative, positive or zero) to the year in BC/AD notation.
	about: For the positive years, nothing is done, but the year 0 is year 1 BC and so for other years there is a difference of 1.
	<p>
	This function should be used like this:
	<pre>
	Local dt:wxDateTime = new wxDateTime.Create...
	Local y:Int = dt.GetYear()
	If y > 0 Then
		Print "The year is " + wxDateTime.ConvertYearToBC(y) + "AD"
	Else
		Print "The year is " + wxDateTime.ConvertYearToBC(y) + "BC"
	End If
	</pre>
	</p>
	End Rem
	Function ConvertYearToBC:Int(year:Int)
		Return bmx_wxdatetime_convertyeartobc(year)
	End Function
	
	Rem
	bbdoc: Get the current month in given calendar (only Gregorian is currently supported).
	End Rem
	Function GetCurrentMonth:Int(cal:Int = Gregorian)
		Return bmx_wxdatetime_getcurrentmonth(cal)
	End Function
	
	Rem
	bbdoc: Returns true if the year is a leap one in the specified calendar.
	about: This functions supports Gregorian and Julian calendars.
	End Rem
	Function IsLeapYear:Int(year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_isleapyear(year, cal)
	End Function
	
	Rem
	bbdoc: Get the current century, i.e. first two digits of the year, in given calendar (only Gregorian is currently supported).
	End Rem
	Function GetCenturyForYear:Int(year:Int)
		Return bmx_wxdatetime_getcenturyforyear(year)
	End Function
	
	Rem
	bbdoc: Returns the number of days in the given year.
	about: The only supported value for cal parameter is currently Gregorian.
	End Rem
	Function GetNumberOfDaysForYear:Int(year:Int, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdaysforyear(year, cal)
	End Function
	
	Rem
	bbdoc: Returns the number of days in the given month of the year..
	about: The only supported value for cal parameter is currently Gregorian.
	End Rem
	Function GetNumberOfDays:Int(Month:Int, year:Int = Inv_Year, cal:Int = Gregorian)
		Return bmx_wxdatetime_getnumberofdays(Month, year, cal)
	End Function
	
	Rem
	bbdoc: Gets the full (default) or abbreviated (specify Name_Abbr name of the given month.
	End Rem
	Function GetMonthName:String(Month:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getmonthname(Month, flags)
	End Function
	
	Rem
	bbdoc: Gets the full (default) or abbreviated (specify Name_Abbr name of the given week day.
	End Rem
	Function GetWeekDayName:String(WeekDay:Int, flags:Int = Name_Full)
		Return bmx_wxdatetime_getweekdayname(WeekDay, flags)
	End Function
	
	Rem
	bbdoc: Returns the translations of the AM string used for time formatting for the current locale.
	End Rem
	Function GetAmString:String()
		Return bmx_wxdatetime_getamstring()
	End Function
	
	Rem
	bbdoc: Returns the translations of the PM string used for time formatting for the current locale.
	End Rem
	Function GetPmString:String()
		Return bmx_wxdatetime_getpmstring()
	End Function
	
	Rem
	bbdoc: Returns true if DST was used n the given year (the current one by default) in the given country.
	End Rem
	Function IsDSTApplicable:Int(year:Int = Inv_Year, country:Int = Country_Default)
		Return bmx_wxdatetime_isdstapplicable(year, country)
	End Function
	
	Rem
	bbdoc: Get the beginning of DST for the given country in the given year (current one by default).
	about: This function suffers from limitations described in DST overview.
	End Rem
	Function GetBeginDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getbegindst(year, country))
	End Function
	
	Rem
	bbdoc: Returns the end of DST for the given country in the given year (current one by default).
	End Rem
	Function GetEndDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
		Return _create(bmx_wxdatetime_getenddst(year, country))
	End Function
	
	Rem
	bbdoc: Returns the object corresponding to the current time.
	about: Example:
	<pre>
	Local now:wxDateTime = wxDateTime.Now()
	Print "Current time in Paris:  " +  now.Format("%c", wxDateTime.CET) 
	</pre>
	<p>
	Note that this function is accurate up to second: wxDateTime::UNow should be used for better precision
	(but it is less efficient and might not be available on all platforms).
	</p>
	End Rem
	Function Now:wxDateTime()
		Return _create(bmx_wxdatetime_now())
	End Function
	
	Rem
	bbdoc: Returns the object corresponding to the current time including the milliseconds if a function to get time with such precision is available on the current platform (supported under most Unices and Win32).
	End Rem
	Function UNow:wxDateTime()
		Return _create(bmx_wxdatetime_unow())
	End Function
	
	Rem
	bbdoc: Returns the object corresponding to the midnight of the current day (i.e. the same as Now(), but the time part is set to 0).
	End Rem
	Function Today:wxDateTime()
		Return _create(bmx_wxdatetime_today())
	End Function
	

	Rem
	bbdoc: Sets the date and time of to the current values.
	about: Same as assigning the result of Now() to this object.
	End Rem
	Method SetToCurrent:wxDateTime()
		bmx_wxdatetime_settocurrent(wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs the object from timet value holding the number of seconds since Jan 1, 1970.
	End Rem
	Method SetTimeT:wxDateTime(timet:Int)
		bmx_wxdatetime_settimet(wxObjectPtr, timet)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the date from the so-called Julian Day Number.
	about: By definition, the Julian Day Number, usually abbreviated as JDN, of a particular instant is the
	fractional number of days since 12 hours Universal Coordinated Time (Greenwich mean noon) on January 1
	of the year -4712 in the Julian proleptic calendar.
	End Rem
	Method SetJDN:wxDateTime(jdn:Double)
		bmx_wxdatetime_setjdn(wxObjectPtr, jdn)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the date to be equal to Today and the time from supplied parameters.
	End Rem
	Method SetHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_sethms(wxObjectPtr, hour, minute, Second, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the date and time from the parameters.
	End Rem
	Method SetDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
		bmx_wxdatetime_setdmy(wxObjectPtr, day, Month, year, hour, minute, Second, millisec)
		Return Self
	End Method

	Rem
	bbdoc: Reset time to midnight (00:00:00) without changing the date.
	End Rem
	Method ResetTime:wxDateTime()
		bmx_wxdatetime_resettime(wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the year without changing other date components.
	End Rem
	Method SetYear:wxDateTime(year:Int)
		bmx_wxdatetime_setyear(wxObjectPtr, year)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the month without changing other date components.
	End Rem
	Method SetMonth:wxDateTime(Month:Int)
		bmx_wxdatetime_setmonth(wxObjectPtr, Month)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the day without changing other date components.
	End Rem
	Method SetDay:wxDateTime(day:Int)
		bmx_wxdatetime_setday(wxObjectPtr, day)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the hour without changing other date components.
	End Rem
	Method SetHour:wxDateTime(hour:Int)
		bmx_wxdatetime_sethour(wxObjectPtr, hour)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the minute without changing other date components.
	End Rem
	Method SetMinute:wxDateTime(minute:Int)
		bmx_wxdatetime_setminute(wxObjectPtr, minute)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the second without changing other date components.
	End Rem
	Method SetSecond:wxDateTime(Second:Int)
		bmx_wxdatetime_setsecond(wxObjectPtr, Second)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the millisecond without changing other date components.
	End Rem
	Method SetMillisecond:wxDateTime(millisec:Int)
		bmx_wxdatetime_setmillisecond(wxObjectPtr, millisec)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if the object represents a valid time moment.
	End Rem
	Method IsValid:Int()
		Return bmx_wxdatetime_isvalid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the object having the same date component as this one but time of 00:00:00.
	End Rem
	Method GetDateOnly:wxDateTime()
		Return wxDateTime._create(bmx_wxdatetime_getdateonly(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the number of seconds since Jan 1, 1970.
	about: An assert failure will occur if the date is not in the range covered by time_t type.
	End Rem
	Method GetTicks:Int()
		Return bmx_wxdatetime_getticks(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the century of this date.
	End Rem
	Method GetCentury:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getcentury(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the year in the given timezone (local one by default).
	End Rem
	Method GetYear:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getyear(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the month in the given timezone (local one by default).
	End Rem
	Method GetMonth:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getmonth(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the day in the given timezone (local one by default).
	End Rem
	Method GetDay:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getday(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the week day in the given timezone (local one by default).
	End Rem
	Method GetWeekDay:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getweekday(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the hour in the given timezone (local one by default).
	End Rem
	Method GetHour:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_gethour(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the minute in the given timezone (local one by default).
	End Rem
	Method GetMinute:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getminute(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the seconds in the given timezone (local one by default).
	End Rem
	Method GetSecond:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getsecond(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the milliseconds in the given timezone (local one by default).
	End Rem
	Method GetMillisecond:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getmillisecond(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the day of the year (in 1...366 range) in the given timezone (local one by default).
	End Rem
	Method GetDayOfYear:Int(tz:Int = TZ_Local)
		Return bmx_wxdatetime_getdayofyear(wxObjectPtr, tz)
	End Method

	Rem
	bbdoc: Returns the number of the week of the year this date is in.
	about: The first week of the year is, according to international standards, the one containing Jan 4 or,
	equivalently, the first week which has Thursday in this year. Both of these definitions are the same as
	saying that the first week of the year must contain more than half of its days in this year. Accordingly,
	the week number will always be in 1...53 range (52 for non-leap years).
	<p>
	The method depends on the week start convention specified by the flags argument but its results for
	Sunday_First are not well-defined as the ISO definition quoted above applies to the weeks starting on Monday only.
	</p>
	End Rem
	Method GetWeekOfYear:Int(flags:Int = Monday_First, tz:Int = TZ_Local)
		Return bmx_wxdatetime_getweekofyear(wxObjectPtr, flags, tz)
	End Method

	Rem
	bbdoc: Returns the ordinal number of the week in the month (in 1...5 range).
	about: As GetWeekOfYear, this function supports both conventions for the week start. See the description of
	these week start conventions.
	End Rem
	Method GetWeekOfMonth:Int(flags:Int = Monday_First, tz:Int = TZ_Local)
		Return bmx_wxdatetime_getweekofmonth(wxObjectPtr, flags, tz)
	End Method

	Rem
	bbdoc: Returns true is this day is not a holiday in the given country.
	End Rem
	Method IsWorkDay:Int(country:Int = Country_Default)
		Return bmx_wxdatetime_isworkday(wxObjectPtr, country)
	End Method
	
'	Method IsGregorianDate:Int(country:Int = Gr_Standard)
'	End Method
	
	Rem
	bbdoc: Sets the date from the date and time in DOS format.
	End Rem
	Method SetFromDOS(ddt:Int)
		bmx_wxdatetime_setfromdos(wxObjectPtr, ddt)
	End Method
	
	Rem
	bbdoc: Returns the date and time in DOS format.
	End Rem
	Method GetAsDOS:Int()
		Return bmx_wxdatetime_getasdos(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the two dates are strictly identical.
	End Rem
	Method IsEqualTo:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isequalto(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if this date precedes the given one.
	End Rem
	Method IsEarlierThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_isearlierthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if this date is later than the given one.
	End Rem
	Method IsLaterThan:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_islaterthan(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if this date lies strictly between the two others,
	End Rem
	Method IsStrictlyBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isstrictlybetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if IsStrictlyBetween is true or if the date is equal to one of the limit values.
	End Rem
	Method IsBetween:Int(t1:wxDateTime, t2:wxDateTime)
		Return bmx_wxdatetime_isbetween(wxObjectPtr, t1.wxObjectPtr, t2.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the date is the same without comparing the time parts.
	End Rem
	Method IsSameDate:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issamedate(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the time is the same (although dates may differ).
	End Rem
	Method IsSameTime:Int(datetime:wxDateTime)
		Return bmx_wxdatetime_issametime(wxObjectPtr, datetime.wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the date is equal to another one up to the given time interval, i.e. if the absolute difference between the two dates is less than this interval.
	End Rem
	Method IsEqualUpTo:Int(dt:wxDateTime, ts:wxTimeSpan)
		Return bmx_wxdatetime_isequalupto(wxObjectPtr, dt.wxObjectPtr, ts.wxObjectPtr)
	End Method

	Rem
	bbdoc: Adds the given time span to this object.
	End Rem
	Method AddTS:wxDateTime(diff:wxTimeSpan)
		Return wxDateTime._create(bmx_wxdatetime_addts(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: Subtracts the given time span from this object.
	End Rem
	Method SubtractTS:wxDateTime(diff:wxTimeSpan)
		Return wxDateTime._create(bmx_wxdatetime_subtractts(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: Adds the given date span to this object.
	End Rem
	Method AddDS:wxDateTime(diff:wxDateSpan)
		Return wxDateTime._create(bmx_wxdatetime_addds(wxObjectPtr, diff.wxObjectPtr))
	End Method

	Rem
	bbdoc: Subtracts the given date span from this object.
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
	bbdoc: Does the same as the standard ANSI C strftime(3) function.
	about: Please see its description for the meaning of format parameter.
	<p>
	It also accepts a few wxWidgets-specific extensions: you can optionally specify the width of the field to follow
	using printf(3)-like syntax and the format specification %l can be used to get the number of milliseconds.
	</p>
	End Rem
	Method Format:String(format:String = wxDefaultDateTimeFormat, tz:Int = TZ_Local)
		Return bmx_wxdatetime_format(wxObjectPtr, format, tz)
	End Method
	
	Rem
	bbdoc: Identical to calling Format() with "%x" argument (which means 'preferred date representation for the current locale').
	End Rem
	Method FormatDate:String()
		Return bmx_wxdatetime_formatdate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Identical to calling Format() with "%X" argument (which means 'preferred time representation for the current locale').
	End Rem
	Method FormatTime:String()
		Return bmx_wxdatetime_formattime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the date representation in the ISO 8601 format (YYYY-MM-DD).
	End Rem
	Method FormatISODate:String()
		Return bmx_wxdatetime_formatisodate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the time representation in the ISO 8601 format (HH:MM:SS).
	End Rem
	Method FormatISOTime:String()
		Return bmx_wxdatetime_formatisotime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adjusts the date so that it will still lie in the same week as before, but its week day will be the given one.
	returns: The reference to the modified object itself.
	End Rem
	Method SetToWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
		bmx_wxdatetime_settoweekdayinsameweek(wxObjectPtr, WeekDay, flags)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToWeekDayInSameWeek was applied.
	End Rem
	Method GetWeekDayInSameWeek:wxDateTime(WeekDay:Int, flags:Int = Monday_First)
		Return wxDateTime._create(bmx_wxdatetime_getweekdayinsameweek(wxObjectPtr, WeekDay, flags))
	End Method
	
	Rem
	bbdoc: Sets the date so that it will be the first weekday following the current date.
	returns: The reference to the modified object itself.
	End Rem
	Method SetToNextWeekDay:wxDateTime(WeekDay:Int)
		bmx_wxdatetime_settonextweekday(wxObjectPtr, WeekDay)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToNextWeekDay was applied.
	End Rem
	Method GetNextWeekDay:wxDateTime(WeekDay:Int)
		Return wxDateTime._create(bmx_wxdatetime_getnextweekday(wxObjectPtr, WeekDay))
	End Method
	
	Rem
	bbdoc: Sets the date so that it will be the last weekday before the current date.
	returns: the reference to the modified object itself.
	End Rem
	Method SetToPrevWeekDay:wxDateTime(WeekDay:Int)
		bmx_wxdatetime_settoprevweekday(wxObjectPtr, WeekDay)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToPrevWeekDay was applied.
	End Rem
	Method GetPrevWeekDay:wxDateTime(WeekDay:Int)
		Return wxDateTime._create(bmx_wxdatetime_getprevweekday(wxObjectPtr, WeekDay))
	End Method
	
	Rem
	bbdoc: Sets the date to the n-th weekday in the given month of the given year (the current month and year are used by default).
	returns: True if the date was modified successfully, False otherwise meaning that the specified date doesn't exist.
	about: The parameter @n may be either positive (counting from the beginning of the month) or negative (counting
	from the end of it).
	<p>
	For example, SetToWeekDay(2, wxDateTime::Wed) will set the date to the second Wednesday in the current month and
	SetToWeekDay(-1, wxDateTime::Sun) -- to the last Sunday in it.
	</p>
	End Rem
	Method SetToWeekDay:Int(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return bmx_wxdatetime_settoweekday(wxObjectPtr, WeekDay, n, Month, year)
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToWeekDay was applied.
	End Rem
	Method GetToWeekDay:wxDateTime(WeekDay:Int, n:Int = 1, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_gettoweekday(wxObjectPtr, WeekDay, n, Month, year))
	End Method
	
	Rem
	bbdoc: The effect of calling this function is the same as of calling SetToWeekDay(-1, weekday, month, year).
	about: The date will be set to the last weekday in the given month and year (the current ones by default).
	<p>
	Always returns true.
	</p>
	End Rem
	Method SetToLastWeekDay:Int(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return bmx_wxdatetime_settolastweekday(wxObjectPtr, WeekDay, Month, year)
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToLastWeekDay was applied.
	End Rem
	Method GetLastWeekDay:wxDateTime(WeekDay:Int, Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_getlastweekday(wxObjectPtr, WeekDay, Month, year))
	End Method
	
	Rem
	bbdoc: Set the date to the given weekday in the week number numWeek of the given year.
	about: The number should be in range 1...53.
	<p>
	Note that the returned date may be in a different year than the one passed to this function because both the week 1
	and week 52 or 53 (for leap years) contain days from different years. See GetWeekOfYear for the explanation of
	how the year weeks are counted.
	</p>
	End Rem
	Function SetToWeekOfYear:wxDateTime(year:Int, numWeek:Int, WeekDay:Int = Mon)
		Return wxDateTime._create(bmx_wxdatetime_settoweekofyear(year, numWeek, WeekDay))
	End Function
	
	Rem
	bbdoc: Sets the date to the last day in the specified month (the current one by default).
	returns: The reference to the modified object itself.
	End Rem
	Method SetToLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
		bmx_wxdatetime_settolastdayofmonth(wxObjectPtr, Month, year)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToLastMonthDay was applied.
	End Rem
	Method GetLastMonthDay:wxDateTime(Month:Int = Inv_Month, year:Int = Inv_Year)
		Return wxDateTime._create(bmx_wxdatetime_getlastmonthday(wxObjectPtr, Month, year))
	End Method
	
	Rem
	bbdoc: Sets the date to the day number yday in the same year (i.e., unlike the other functions, this one does not use the current year).
	returns: The reference to the modified object itself.
	about: The day number should be in the range 1...366 for the leap years and 1...365 for the other ones.
	End Rem
	Method SetToYearDay:wxDateTime(yday:Int)
		bmx_wxdatetime_settoyearday(wxObjectPtr, yday)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the copy of this object to which SetToYearDay was applied.
	End Rem
	Method GetYearDay:wxDateTime(yday:Int)
		Return wxDateTime._create(bmx_wxdatetime_getyearday(wxObjectPtr, yday))
	End Method
	
	Rem
	bbdoc: Returns the JDN corresponding to this date.
	about: Beware of rounding errors!
	End Rem
	Method GetJulianDayNumber:Double()
		Return bmx_wxdatetime_getjuliandaynumber(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Synonym for GetJulianDayNumber.
	End Rem
	Method GetJDN:Double()
		Return bmx_wxdatetime_getjdn(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the Modified Julian Day Number (MJD) which is, by definition, equal to JDN - 2400000.5.
	about: The MJDs are simpler to work with as the integral MJDs correspond to midnights of the dates
	in the Gregorian calendar and not th noons like JDN. The MJD 0 is Nov 17, 1858.
	End Rem
	Method GetModifiedJulianDayNumber:Double()
		Return bmx_wxdatetime_getmodifiedjuliandaynumber(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Synonym for GetModifiedJulianDayNumber.
	End Rem
	Method GetMJD:Double()
		Return bmx_wxdatetime_getmjd(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the Rata Die number of this date.
	about: By definition, the Rata Die number is a date specified as the number of days relative to a
	base date of December 31 of the year 0. Thus January 1 of the year 1 is Rata Die day 1.
	End Rem
	Method GetRataDie:Double()
		Return bmx_wxdatetime_getratadie(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Transform the date from the given time zone to the local one.
	returns: The date in the local time zone.
	about: If noDST is true, no DST adjustments will be made.
	End Rem
	Method FromTimezone:wxDateTime(tz:Int, noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_fromtimezone(wxObjectPtr, tz, noDST))
	End Method
	
	Rem
	bbdoc: Transform the date to the given time zone.
	returns: The date in the new time zone.
	about: If noDST is true, no DST adjustments will be made.
	End Rem
	Method ToTimezone:wxDateTime(tz:Int, noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_totimezone(wxObjectPtr, tz, noDST))
	End Method
	
	Rem
	bbdoc: Modifies the object in place to represent the date in another time zone.
	about: If noDST is true, no DST adjustments will be made.
	End Rem
	Method MakeTimezone:wxDateTime(tz:Int, noDST:Int = False)
		bmx_wxdatetime_maketimezone(wxObjectPtr, tz, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: Same as FromTimezone but modifies the object in place.
	End Rem
	Method MakeFromTimezone:wxDateTime(tz:Int, noDST:Int = False)
		bmx_wxdatetime_makefromtimezone(wxObjectPtr, tz, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: This is the same as calling ToTimezone with the argument GMT0.
	End Rem
	Method ToUTC:wxDateTime(noDST:Int = False)
		Return wxDateTime._create(bmx_wxdatetime_toutc(wxObjectPtr, noDST))
	End Method
	
	Rem
	bbdoc: This is the same as calling MakeTimezone with the argument GMT0.
	End Rem
	Method MakeUTC:wxDateTime(noDST:Int = False)
		bmx_wxdatetime_makeutc(wxObjectPtr, noDST)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if the DST is applied for this date in the given country.
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

	Function _create:wxTimeSpan(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxTimeSpan = New wxTimeSpan
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateTimeSpan:wxTimeSpan(hours:Int = 0, minutes:Int = 0, seconds:Int = 0, msec:Int = 0)
		Return New wxTimeSpan.Create(hours, minutes, seconds, msec)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxTimeSpan(hours:Int = 0, minutes:Int = 0, seconds:Int = 0, msec:Int = 0)
		wxObjectPtr = bmx_wxtimespan_create(hours, minutes, seconds, msec)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the absolute value of the timespan: does not modify the object.
	End Rem
	Method Absolute:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_abs(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the sum of two timespans.
	End Rem
	Method Add:wxTimeSpan(diff:wxTimeSpan)
		Return wxTimeSpan._create(bmx_wxtimespan_add(wxObjectPtr, diff.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the timespan for the given number of days.
	End Rem
	Function Days:wxTimeSpan(numDays:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_days(numDays))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one day.
	End Rem
	Function Day:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_day())
	End Function
	
	Rem
	bbdoc: Returns the string containing the formatted representation of the time span.
	about: The following format specifiers are allowed after %:
	<table width="90%" align="center">
	<tr><th>Specifier</th><th>Description</th></tr>
	<tr><td>H</td><td> number of Hours </td></tr>
	<tr><td>M</td><td> number of Minutes </td></tr>
	<tr><td>S</td><td> number of Seconds </td></tr>
	<tr><td>l</td><td> number of milliseconds </td></tr>
	<tr><td>D</td><td> number of Days </td></tr>
	<tr><td>E</td><td> number of wEeks </td></tr>
	<tr><td>%</td><td> the percent character </td></tr>
	</table>
	<p>
	Note that, for example, the number of hours in the description above is not well defined: it can be
	either the total number of hours (for example, for a time span of 50 hours this would be 50) or just
	the hour part of the time span, which would be 2 in this case as 50 hours is equal to 2 days and 2 hours.
	</p>
	<p>
	wxTimeSpan resolves this ambiguity in the following way: if there had been, indeed, the %D format
	specified preceding the %H, then it is interpreted as 2. Otherwise, it is 50.
	</p>
	<p>
	The same applies to all other format specifiers: if they follow a specifier of larger unit, only the
	rest part is taken, otherwise the full value is used.
	</p>
	End Rem
	Method Format:String(_format:String = wxDefaultTimeSpanFormat)
		Return bmx_wxtimespan_format(wxObjectPtr, _format)
	End Method
	
	Rem
	bbdoc: Returns the difference in number of days.
	End Rem
	Method GetDays:Int()
		Return bmx_wxtimespan_getdays(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the difference in number of hours.
	End Rem
	Method GetHours:Int()
		Return bmx_wxtimespan_gethours(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the difference in number of milliseconds.
	End Rem
	Method GetMilliseconds:Long()
		Local value:Long
		bmx_wxtimespan_getmilliseconds(wxObjectPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: Returns the difference in number of minutes.
	End Rem
	Method GetMinutes:Int()
		Return bmx_wxtimespan_getminutes(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the difference in number of seconds.
	End Rem
	Method GetSeconds:Long()
		Local value:Long
		bmx_wxtimespan_getseconds(wxObjectPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: Returns the internal representation of timespan.
	End Rem
	Method GetValue:Long()
		Local value:Long
		bmx_wxtimespan_getvalue(wxObjectPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: Returns the difference in number of weeks.
	End Rem
	Method GetWeeks:Int()
		Return bmx_wxtimespan_getweeks(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the timespan for the given number of hours.
	End Rem
	Function Hours:wxTimeSpan(hours:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_hours(hours))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one hour.
	End Rem
	Function Hour:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_hour())
	End Function
	
	Rem
	bbdoc: Returns true if two timespans are equal.
	End Rem
	Method IsEqualTo:Int(ts:wxTimeSpan)
		Return bmx_wxtimespan_isequalto(wxObjectPtr, ts.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Compares two timespans: works with the absolute values, i.e. -2 hours is longer than 1 hour.
	about: Also, it will return false if the timespans are equal in absolute value.
	End Rem
	Method IsLongerThan:Int(ts:wxTimeSpan)
		Return bmx_wxtimespan_islongerthan(wxObjectPtr, ts.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the timespan is negative.
	End Rem
	Method IsNegative:Int()
		Return bmx_wxtimespan_isnegative(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the timespan is empty.
	End Rem
	Method IsNull:Int()
		Return bmx_wxtimespan_isnull(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the timespan is positive.
	End Rem
	Method IsPositive:Int()
		Return bmx_wxtimespan_ispositive(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Compares two timespans: works with the absolute values, i.e. 1 hour is shorter than -2 hours.
	about: Also, it will return false if the timespans are equal in absolute value.
	End Rem
	Method IsShorterThan:Int(ts:wxTimeSpan)
		Return bmx_wxtimespan_isshorterthan(wxObjectPtr, ts.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the timespan for the given number of minutes.
	End Rem
	Function Minutes:wxTimeSpan(mins:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_minutes(mins))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one minute.
	End Rem
	Function Minute:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_minute())
	End Function
	
	Rem
	bbdoc: Multiplies timespan by a scalar.
	End Rem
	Method Multiply:wxTimeSpan(n:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_multiply(wxObjectPtr, n))
	End Method
	
	Rem
	bbdoc: Returns timespan with inverted sign.
	End Rem
	Method Negate:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_negate(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the timespan for the given number of milliseconds.
	End Rem
	Function Milliseconds:wxTimeSpan(ms:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_milliseconds(ms))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one millisecond.
	End Rem
	Function Millisecond:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_millisecond())
	End Function
	
	Rem
	bbdoc: Returns the timespan for the given number of seconds.
	End Rem
	Function Seconds:wxTimeSpan(sec:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_seconds(sec))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one second.
	End Rem
	Function Second:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_second())
	End Function
	
	Rem
	bbdoc: Returns the difference of two timespans.
	End Rem
	Method Subtract:wxTimeSpan(diff:wxTimeSpan)
		Return wxTimeSpan._create(bmx_wxtimespan_subtract(wxObjectPtr, diff.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the timespan for the given number of weeks.
	End Rem
	Function Weeks:wxTimeSpan(wks:Int)
		Return wxTimeSpan._create(bmx_wxtimespan_weeks(wks))
	End Function
	
	Rem
	bbdoc: Returns the timespan for one week.
	End Rem
	Function Week:wxTimeSpan()
		Return wxTimeSpan._create(bmx_wxtimespan_week())
	End Function

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
	
	Rem
	bbdoc: Returns the sum of two date spans.
	End Rem
	Method Add:wxDateSpan(other:wxDateSpan)
		Return wxDateSpan._create(bmx_wxdatespan_add(wxObjectPtr, other.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns a date span object corresponding to one day.
	End Rem
	Function Day:wxDateSpan()
		Return wxDateSpan._create(bmx_wxdatespan_day())
	End Function
	
	Rem
	bbdoc: Returns a date span object corresponding to the given number of days.
	End Rem
	Function Days:wxDateSpan(days:Int)
		Return wxDateSpan._create(bmx_wxdatespan_days(days))
	End Function
	
	Rem
	bbdoc: Returns the number of days (only, that it not counting the weeks component!) in this date span.
	End Rem
	Method GetDays:Int()
		Return bmx_wxdatespan_getdays(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of the months (not counting the years) in this date span.
	End Rem
	Method GetMonths:Int()
		Return bmx_wxdatespan_getmonths(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the combined number of days in this date span, counting both weeks and days.
	about: It still doesn't take neither months nor years into the account.
	End Rem
	Method GetTotalDays:Int()
		Return bmx_wxdatespan_gettotaldays(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of weeks in this date span.
	End Rem
	Method GetWeeks:Int()
		Return bmx_wxdatespan_getweeks(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of years in this date span.
	End Rem
	Method GetYears:Int()
		Return bmx_wxdatespan_getyears(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a date span object corresponding to one month.
	End Rem
	Function Month:wxDateSpan()
		Return wxDateSpan._create(bmx_wxdatespan_month())
	End Function
	
	Rem
	bbdoc: Returns a date span object corresponding to the given number of months.
	End Rem
	Function Months:wxDateSpan(mon:Int)
		Return wxDateSpan._create(bmx_wxdatespan_months(mon))
	End Function
	
	Rem
	bbdoc: Returns the product of the date span by the specified @factor.
	about: The product is computed by multiplying each of the components by the factor.
	End Rem
	Method Multiply:wxDateSpan(factor:Int)
		Return wxDateSpan._create(bmx_wxdatespan_multiply(wxObjectPtr, factor))
	End Method
	
	Rem
	bbdoc: Returns the date span with the opposite sign.
	End Rem
	Method Negate:wxDateSpan()
		Return wxDateSpan._create(bmx_wxdatespan_negate(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the number of days (without modifying any other components) in this date span.
	End Rem
	Method SetDays:wxDateSpan(n:Int)
		bmx_wxdatespan_setdays(wxObjectPtr, n)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the number of years (without modifying any other components) in this date span.
	End Rem
	Method SetYears:wxDateSpan(n:Int)
		bmx_wxdatespan_setyears(wxObjectPtr, n)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the number of months (without modifying any other components) in this date span.
	End Rem
	Method SetMonths:wxDateSpan(n:Int)
		bmx_wxdatespan_setmonths(wxObjectPtr, n)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the number of weeks (without modifying any other components) in this date span.
	End Rem
	Method SetWeeks:wxDateSpan(n:Int)
		bmx_wxdatespan_setweeks(wxObjectPtr, n)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the difference of two date spans.
	End Rem
	Method Subtract:wxDateSpan(other:wxDateSpan)
		Return wxDateSpan._create(bmx_wxdatespan_subtract(wxObjectPtr, other.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns a date span object corresponding to one week.
	End Rem
	Function Week:wxDateSpan()
		Return wxDateSpan._create(bmx_wxdatespan_week())
	End Function
	
	Rem
	bbdoc: Returns a date span object corresponding to the given number of weeks.
	End Rem
	Function Weeks:wxDateSpan(weeks:Int)
		Return wxDateSpan._create(bmx_wxdatespan_weeks(weeks))
	End Function
	
	Rem
	bbdoc: Returns a date span object corresponding to one year.
	End Rem
	Function Year:wxDateSpan()
		Return wxDateSpan._create(bmx_wxdatespan_year())
	End Function
	
	Rem
	bbdoc: Returns a date span object corresponding to the given number of years.
	End Rem
	Function Years:wxDateSpan(years:Int)
		Return wxDateSpan._create(bmx_wxdatespan_years(years))
	End Function
	
	Rem
	bbdoc: Returns true if this date span is equal to the other one.
	about: Two date spans are considered equal if and only if they have the same number of years
	and months and the same total number of days (counting both days and weeks).
	End Rem
	Method Equals:Int(other:wxDateSpan)
		Return bmx_wxdatespan_equals(wxObjectPtr, other.wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxdatespan_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

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

