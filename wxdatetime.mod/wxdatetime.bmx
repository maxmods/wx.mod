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
	End Function
	
	Method Create:wxDateTime()
	End Method
	
	Method CreateFromTimeT:wxDateTime(timet:Int)
	End Method
	
	Method CreateFromJDN:wxDateTime(jdn:Double)
	End Method
	
	Method CreateFromHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
	End Method
	
	Method CreateFromDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
	End Method
	
	Function SetCountry(country:Int)
	End Function
	
	Function GetCountry:Int()
	End Function
	
	Function IsWestEuropeanCountry:Int(country:Int = Country_Default)
	End Function
	
	Function GetCurrentYear(cal:Int = Gregorian)
	End Function
	
	Function ConvertYearToBC(year:Int)
	End Function
	
	Function GetCurrentMonth:Int(cal:Int = Gregorian)
	End Function
	
	Function IsLeapYear:Int(year:Int = Inv_Year, cal:Int = Gregorian)
	End Function
	
	Function GetCenturyForYear:Int(year:Int)
	End Function
	
	Function GetNumberOfDaysForYear:Int(year:Int, cal:Int = Gregorian)
	End Function
	
	Function GetNumberOfDays:Int(Month:Int, year:Int = Inv_Year, cal:Int = Gregorian)
	End Function
	
	Function GetMonthName:String(Month:Int, flags:Int = Name_Full)
	End Function
	
	Function GetWeekDayName:String(WeekDay:Int, flags:Int = Name_Full)
	End Function
	
	Function GetAmString:String()
	End Function
	
	Function GetPmString:String()
	End Function
	
	Function IsDSTApplicable:Int(year:Int = Inv_Year, country:Int = Country_Default)
	End Function
	
	Function GetBeginDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
	End Function
	
	Function GetEndDST:wxDateTime(year:Int = Inv_Year, country:Int = Country_Default)
	End Function
	
	Function Now:wxDateTime()
	End Function
	
	Function UNow:wxDateTime()
	End Function
	
	Function Today:wxDateTime()
	End Function
	

	Method SetToCurrent:wxDateTime()
	End Method
	
	Method SetTimeT:wxDateTime(timet:Int)
	End Method
	
	Method SetJDN:wxDateTime(jdn:Double)
	End Method
	
	Method SetHMS:wxDateTime(hour:Int, minute:Int = 0, Second:Int = 0, millisec:Int = 0)
	End Method
	
	Method SetDMY:wxDateTime(day:Int, Month:Int = Inv_Month, year:Int = Inv_Year, hour:Int = 0, ..
			minute:Int = 0, Second:Int = 0, millisec:Int = 0)
	End Method

	Method ResetTime:wxDateTime()
	End Method
	
	Method SetYear:wxDateTime(year:Int)
	End Method
	
	Method SetMonth:wxDateTime(Month:Int)
	End Method
	
	Method SetDay:wxDateTime(day:Int)
	End Method
	
	Method SetHour:wxDateTime(hour:Int)
	End Method
	
	Method SetMinute:wxDateTime(minute:Int)
	End Method
	
	Method SetSecond:wxDateTime(Second:Int)
	End Method
	
	Method SetMillisecond:wxDateTime(millisec:Int)
	End Method
	
	Method IsValid:Int()
	End Method
	
	Method GetDateOnly:wxDateTime()
	End Method
	
	Method GetTicks:Int()
	End Method
	
	Method GetCentury:Int(tz:TimeZone = Null)
	End Method

	Method GetYear:Int(tz:TimeZone = Null)
	End Method

	Method GetMonth:Int(tz:TimeZone = Null)
	End Method

	Method GetDay:Int(tz:TimeZone = Null)
	End Method

	Method GetWeekDay:Int(tz:TimeZone = Null)
	End Method

	Method GetHour:Int(tz:TimeZone = Null)
	End Method

	Method GetMinute:Int(tz:TimeZone = Null)
	End Method

	Method GetSecond:Int(tz:TimeZone = Null)
	End Method

	Method GetMillisecond:Int(tz:TimeZone = Null)
	End Method

	Method GetDayOfYear:Int(tz:TimeZone = Null)
	End Method

	Method GetWeekOfYear:Int(flags:Int = Monday_First, tz:TimeZone = Null)
	End Method

	Method GetWeekOfMonth:Int(flags:Int = Monday_First, tz:TimeZone = Null)
	End Method

	Method IsWorkDay:Int(country:Int = Country_Default)
	End Method
	
'	Method IsGregorianDate:Int(country:Int = Gr_Standard)
'	End Method
	
	Method SetFromDOS(ddt:Int)
	End Method
	
	Method GetAsDOS:Int()
	End Method
	
	Method IsEqualTo:Int(datetime:wxDateTime)
	End Method

	Method IsEarlierThan:Int(datetime:wxDateTime)
	End Method

	Method IsLaterThan:Int(datetime:wxDateTime)
	End Method

	Method IsStrictlyBetween:Int(t1:wxDateTime, t2:wxDateTime)
	End Method

	Method IsBetween:Int(t1:wxDateTime, t2:wxDateTime)
	End Method

	Method IsSameDate:Int(datetime:wxDateTime)
	End Method

	Method IsSameTime:Int(datetime:wxDateTime)
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


