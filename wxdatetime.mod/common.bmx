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
	Function bmx_wxdatetime_getcentury:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getyear:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getmonth:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getday:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getweekday:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_gethour:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getminute:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getsecond:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getmillisecond:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getdayofyear:Int(handle:Byte Ptr, tz:Byte Ptr)
	Function bmx_wxdatetime_getweekofyear:Int(handle:Byte Ptr, flags:Int, tz:Byte Ptr)
	Function bmx_wxdatetime_getweekofmonth:Int(handle:Byte Ptr, flags:Int, tz:Byte Ptr)
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


End Extern


Const wxDefaultDateTimeFormat:String = "%c"
Const wxDefaultTimeSpanFormat:String = "%H:%M:%S"

