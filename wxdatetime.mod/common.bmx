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

	Function bmx_wxdatetime_setcountry(country:Int)
	Function bmx_wxdatetime_getcountry:Int()
	Function bmx_wxdatetime_iswesteuropeancountry:Int(country:Int)
	Function bmx_wxdatetime_getcurrentyear:Int(cal:Int)
	Function bmx_wxdatetime_convertyeartobc:Int(year:Int)
	Function bmx_wxdatetime_getcurrentmonth:Int(cal:Int)
	Function bmx_wxdatetime_isleapyear:Int(year:Int, cal:Int)
	Function bmx_wxdatetime_getcenturyforyear:Int(year:Int)
	Function bmx_wxdatetime_getnumberofdaysforyear:Int(year:Int, cal:Int)
	Function bmx_wxdatetime_getnumberofdays:Int(Month:Int, year:Int, cal:Int)
	Function bmx_wxdatetime_getmonthname:String(Month:Int, flags:Int)
	Function bmx_wxdatetime_getweekdayname:String(WeekDay:Int, flags:Int)
	Function bmx_wxdatetime_getamstring:String()
	Function bmx_wxdatetime_getpmstring:String()
	Function bmx_wxdatetime_isdstapplicable:Int(year:Int, country:Int)
	Function bmx_wxdatetime_getbegindst:Byte Ptr(year:Int, country:Int)
	Function bmx_wxdatetime_getenddst:Byte Ptr(year:Int, country:Int)
	Function bmx_wxdatetime_now:Byte Ptr()
	Function bmx_wxdatetime_unow:Byte Ptr()
	Function bmx_wxdatetime_today:Byte Ptr()

	Function bmx_wxdatetime_delete(handle:Byte Ptr)
	Function bmx_wxdatetime_create:Byte Ptr()
	Function bmx_wxdatetime_createfromtimet:Byte Ptr(time:Int)
	Function bmx_wxdatetime_createfromjdn:Byte Ptr(jdn:Double)
	Function bmx_wxdatetime_createfromhms:Byte Ptr(hour:Int, minute:Int, Second:Int, millisec:Int)
	Function bmx_wxdatetime_createfromdmy:Byte Ptr(day:Int, Month:Int, year:Int, hour:Int, minute:Int, Second:Int, millisec:Int)

	Function bmx_wxdatetime_settocurrent(handle:Byte Ptr)
	Function bmx_wxdatetime_settimet(handle:Byte Ptr, timet:Int)
	Function bmx_wxdatetime_setjdn(handle:Byte Ptr, jdn:Double)
	Function bmx_wxdatetime_sethms(handle:Byte Ptr, hour:Int, minute:Int, Second:Int, millisec:Int)
	Function bmx_wxdatetime_setdmy(handle:Byte Ptr, day:Int, Month:Int, year:Int, hour:Int, minute:Int, Second:Int, millisec:Int)
	Function bmx_wxdatetime_resettime(handle:Byte Ptr)
	Function bmx_wxdatetime_setyear(handle:Byte Ptr, year:Int)
	Function bmx_wxdatetime_setmonth(handle:Byte Ptr, Month:Int)
	Function bmx_wxdatetime_setday(handle:Byte Ptr, day:Int)
	Function bmx_wxdatetime_sethour(handle:Byte Ptr, hour:Int)
	Function bmx_wxdatetime_setminute(handle:Byte Ptr, minute:Int)
	Function bmx_wxdatetime_setsecond(handle:Byte Ptr, Second:Int)
	Function bmx_wxdatetime_setmillisecond(handle:Byte Ptr, millisec:Int)
	Function bmx_wxdatetime_isvalid:Int(handle:Byte Ptr)
	Function bmx_wxdatetime_getdateonly:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdatetime_getticks:Int(handle:Byte Ptr)
	Function bmx_wxdatetime_getcentury:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getyear:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getmonth:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getday:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getweekday:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_gethour:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getminute:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getsecond:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getmillisecond:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getdayofyear:Int(handle:Byte Ptr, tz:Int)
	Function bmx_wxdatetime_getweekofyear:Int(handle:Byte Ptr, flags:Int, tz:Int)
	Function bmx_wxdatetime_getweekofmonth:Int(handle:Byte Ptr, flags:Int, tz:Int)
	Function bmx_wxdatetime_isworkday:Int(handle:Byte Ptr, country:Int)
	Function bmx_wxdatetime_setfromdos(handle:Byte Ptr, ddt:Int)
	Function bmx_wxdatetime_getasdos:Int(handle:Byte Ptr)
	Function bmx_wxdatetime_isequalto:Int(handle:Byte Ptr, datetime:Byte Ptr)
	Function bmx_wxdatetime_isearlierthan:Int(handle:Byte Ptr, datetime:Byte Ptr)
	Function bmx_wxdatetime_islaterthan:Int(handle:Byte Ptr, datetime:Byte Ptr)
	Function bmx_wxdatetime_isstrictlybetween:Int(handle:Byte Ptr, t1:Byte Ptr, t2:Byte Ptr)
	Function bmx_wxdatetime_isbetween:Int(handle:Byte Ptr, t1:Byte Ptr, t2:Byte Ptr)
	Function bmx_wxdatetime_issamedate:Int(handle:Byte Ptr, datetime:Byte Ptr)
	Function bmx_wxdatetime_issametime:Int(handle:Byte Ptr, datetime:Byte Ptr)

	Function bmx_wxdatetime_isequalupto:Int(handle:Byte Ptr, dt:Byte Ptr, ts:Byte Ptr)
	Function bmx_wxdatetime_addts:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxdatetime_subtractts:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxdatetime_addds:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxdatetime_subtractds:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxdatetime_parserfc822date:String(handle:Byte Ptr, date:String)
	Function bmx_wxdatetime_parseformat:String(handle:Byte Ptr, date:String, format:String, dateDef:Byte Ptr)
	Function bmx_wxdatetime_parsedatetime:String(handle:Byte Ptr, datetime:String)
	Function bmx_wxdatetime_parsedate:String(handle:Byte Ptr, date:String)
	Function bmx_wxdatetime_parsetime:String(handle:Byte Ptr, time:String)
	Function bmx_wxdatetime_format:String(handle:Byte Ptr, format:String, tz:Int)
	Function bmx_wxdatetime_formatdate:String(handle:Byte Ptr)
	Function bmx_wxdatetime_formattime:String(handle:Byte Ptr)
	Function bmx_wxdatetime_formatisodate:String(handle:Byte Ptr)
	Function bmx_wxdatetime_formatisotime:String(handle:Byte Ptr)
	Function bmx_wxdatetime_settoweekdayinsameweek(handle:Byte Ptr, WeekDay:Int, flags:Int)
	Function bmx_wxdatetime_getweekdayinsameweek:Byte Ptr(handle:Byte Ptr, WeekDay:Int, flags:Int)
	Function bmx_wxdatetime_settonextweekday(handle:Byte Ptr, WeekDay:Int)
	Function bmx_wxdatetime_getnextweekday:Byte Ptr(handle:Byte Ptr, WeekDay:Int)
	Function bmx_wxdatetime_settoprevweekday(handle:Byte Ptr, WeekDay:Int)
	Function bmx_wxdatetime_getprevweekday:Byte Ptr(handle:Byte Ptr, WeekDay:Int)
	Function bmx_wxdatetime_settoweekday:Int(handle:Byte Ptr, WeekDay:Int, n:Int, Month:Int, year:Int)
	Function bmx_wxdatetime_gettoweekday:Byte Ptr(handle:Byte Ptr, WeekDay:Int, n:Int, Month:Int, year:Int)
	Function bmx_wxdatetime_settolastweekday:Int(handle:Byte Ptr, WeekDay:Int, Month:Int, year:Int)
	Function bmx_wxdatetime_getlastweekday:Byte Ptr(handle:Byte Ptr, WeekDay:Int, Month:Int, year:Int)
	Function bmx_wxdatetime_settoweekofyear:Byte Ptr(year:Int, numWeek:Int, WeekDay:Int)
	Function bmx_wxdatetime_settolastdayofmonth(handle:Byte Ptr, Month:Int, year:Int)
	Function bmx_wxdatetime_getlastmonthday:Byte Ptr(handle:Byte Ptr, Month:Int, year:Int)
	Function bmx_wxdatetime_settoyearday(handle:Byte Ptr, yday:Int)
	Function bmx_wxdatetime_getyearday:Byte Ptr(handle:Byte Ptr, yday:Int)
	Function bmx_wxdatetime_getjuliandaynumber:Double(handle:Byte Ptr)
	Function bmx_wxdatetime_getjdn:Double(handle:Byte Ptr)
	Function bmx_wxdatetime_getmodifiedjuliandaynumber:Double(handle:Byte Ptr)
	Function bmx_wxdatetime_getmjd:Double(handle:Byte Ptr)
	Function bmx_wxdatetime_getratadie:Double(handle:Byte Ptr)
	Function bmx_wxdatetime_fromtimezone:Byte Ptr(handle:Byte Ptr, tz:Int, noDST:Int)
	Function bmx_wxdatetime_totimezone:Byte Ptr(handle:Byte Ptr, tz:Int, noDST:Int)
	Function bmx_wxdatetime_maketimezone(handle:Byte Ptr, tz:Int, noDST:Int)
	Function bmx_wxdatetime_makefromtimezone(handle:Byte Ptr, tz:Int, noDST:Int)
	Function bmx_wxdatetime_toutc:Byte Ptr(handle:Byte Ptr, noDST:Int)
	Function bmx_wxdatetime_makeutc(handle:Byte Ptr, noDST:Int)
	Function bmx_wxdatetime_isdst:Int(handle:Byte Ptr, country:Int)

	Function bmx_wxdatespan_create:Byte Ptr(years:Int, months:Int, weeks:Int, days:Int)
	Function bmx_wxdatespan_delete(handle:Byte Ptr)
	Function bmx_wxdatespan_add:Byte Ptr(handle:Byte Ptr, other:Byte Ptr)
	Function bmx_wxdatespan_day:Byte Ptr()
	Function bmx_wxdatespan_days:Byte Ptr(days:Int)
	Function bmx_wxdatespan_getdays:Int(handle:Byte Ptr)
	Function bmx_wxdatespan_getmonths:Int(handle:Byte Ptr)
	Function bmx_wxdatespan_gettotaldays:Int(handle:Byte Ptr)
	Function bmx_wxdatespan_getweeks:Int(handle:Byte Ptr)
	Function bmx_wxdatespan_getyears:Int(handle:Byte Ptr)
	Function bmx_wxdatespan_month:Byte Ptr()
	Function bmx_wxdatespan_months:Byte Ptr(mon:Int)
	Function bmx_wxdatespan_multiply:Byte Ptr(handle:Byte Ptr, factor:Int)
	Function bmx_wxdatespan_negate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdatespan_setdays(handle:Byte Ptr, n:Int)
	Function bmx_wxdatespan_setyears(handle:Byte Ptr, n:Int)
	Function bmx_wxdatespan_setmonths(handle:Byte Ptr, n:Int)
	Function bmx_wxdatespan_setweeks(handle:Byte Ptr, n:Int)
	Function bmx_wxdatespan_subtract:Byte Ptr(handle:Byte Ptr, other:Byte Ptr)
	Function bmx_wxdatespan_week:Byte Ptr()
	Function bmx_wxdatespan_weeks:Byte Ptr(weeks:Int)
	Function bmx_wxdatespan_year:Byte Ptr()
	Function bmx_wxdatespan_years:Byte Ptr(years:Int)
	Function bmx_wxdatespan_equals:Int(handle:Byte Ptr, other:Byte Ptr)

	Function bmx_wxtimespan_delete(handle:Byte Ptr)
	Function bmx_wxtimespan_create:Byte Ptr(hours:Int, minutes:Int, seconds:Int, msec:Int)
	Function bmx_wxtimespan_abs:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtimespan_add:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxtimespan_days:Byte Ptr(numDays:Int)
	Function bmx_wxtimespan_day:Byte Ptr()
	Function bmx_wxtimespan_format:String(handle:Byte Ptr, format:String)
	Function bmx_wxtimespan_getdays:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_gethours:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_getmilliseconds(handle:Byte Ptr, value:Long Ptr)
	Function bmx_wxtimespan_getminutes:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_getseconds(handle:Byte Ptr, value:Long Ptr)
	Function bmx_wxtimespan_getvalue(handle:Byte Ptr, value:Long Ptr)
	Function bmx_wxtimespan_getweeks:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_hours:Byte Ptr(hours:Int)
	Function bmx_wxtimespan_hour:Byte Ptr()
	Function bmx_wxtimespan_isequalto:Int(handle:Byte Ptr, ts:Byte Ptr)
	Function bmx_wxtimespan_islongerthan:Int(handle:Byte Ptr, ts:Byte Ptr)
	Function bmx_wxtimespan_isnegative:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_isnull:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_ispositive:Int(handle:Byte Ptr)
	Function bmx_wxtimespan_isshorterthan:Int(handle:Byte Ptr, ts:Byte Ptr)
	Function bmx_wxtimespan_minutes:Byte Ptr(mins:Int)
	Function bmx_wxtimespan_minute:Byte Ptr()
	Function bmx_wxtimespan_multiply:Byte Ptr(handle:Byte Ptr, n:Int)
	Function bmx_wxtimespan_negate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtimespan_milliseconds:Byte Ptr(ms:Int)
	Function bmx_wxtimespan_millisecond:Byte Ptr()
	Function bmx_wxtimespan_seconds:Byte Ptr(sec:Int)
	Function bmx_wxtimespan_second:Byte Ptr()
	Function bmx_wxtimespan_subtract:Byte Ptr(handle:Byte Ptr, diff:Byte Ptr)
	Function bmx_wxtimespan_weeks:Byte Ptr(wks:Int)
	Function bmx_wxtimespan_week:Byte Ptr()

	Function bmx_wxdateevent_getdate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxdateevent_setdate(handle:Byte Ptr, date:Byte Ptr)

End Extern


Const wxDefaultDateTimeFormat:String = "%c"
Const wxDefaultTimeSpanFormat:String = "%H:%M:%S"

