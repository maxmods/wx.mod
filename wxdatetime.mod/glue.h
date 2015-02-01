/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#ifndef _WX_MAX_DATETIME_H_
#define _WX_MAX_DATETIME_H_

#include "wxglue.h"
#include "wx/datetime.h"
#include "wx/dateevt.h"

class MaxDateTime;
class MaxDateSpan;
class MaxTimeSpan;

extern "C" {

#include <blitz.h>

	void bmx_wxdatetime_setcountry(wxDateTime::Country country);
	wxDateTime::Country bmx_wxdatetime_getcountry();
	int bmx_wxdatetime_iswesteuropeancountry(wxDateTime::Country country);
	int bmx_wxdatetime_getcurrentyear(wxDateTime::Calendar cal);
	int bmx_wxdatetime_convertyeartobc(int year);
	wxDateTime::Month bmx_wxdatetime_getcurrentmonth(wxDateTime::Calendar cal);
	int bmx_wxdatetime_isleapyear(int year, wxDateTime::Calendar cal);
	int bmx_wxdatetime_getcenturyforyear(int year);
	int bmx_wxdatetime_getnumberofdaysforyear(int year, wxDateTime::Calendar cal);
	int bmx_wxdatetime_getnumberofdays(wxDateTime::Month month, int year, wxDateTime::Calendar cal);
	BBString * bmx_wxdatetime_getmonthname(wxDateTime::Month month, wxDateTime::NameFlags flags);
	BBString * bmx_wxdatetime_getweekdayname(wxDateTime::WeekDay weekday, wxDateTime::NameFlags flags);
	BBString * bmx_wxdatetime_getamstring();
	BBString * bmx_wxdatetime_getpmstring();
	int bmx_wxdatetime_isdstapplicable(int year, wxDateTime::Country country);
	MaxDateTime * bmx_wxdatetime_getbegindst(int year, wxDateTime::Country country);
	MaxDateTime * bmx_wxdatetime_getenddst(int year, wxDateTime::Country country);
	MaxDateTime * bmx_wxdatetime_now();
	MaxDateTime * bmx_wxdatetime_unow();
	MaxDateTime * bmx_wxdatetime_today();

	MaxDateTime * bmx_wxdatetime_create();
	MaxDateTime * bmx_wxdatetime_createfromtimet(time_t time);
	MaxDateTime * bmx_wxdatetime_createfromjdn(double jdn);
	MaxDateTime * bmx_wxdatetime_createfromhms(int hour, int minute, int second, int millisec);
	MaxDateTime * bmx_wxdatetime_createfromdmy(int day, wxDateTime::Month month, int year, int hour, int minute, int second, int millisec);
	void bmx_wxdatetime_delete(MaxDateTime * dt);

	void bmx_wxdatetime_settocurrent(MaxDateTime * datetime);
	void bmx_wxdatetime_settimet(MaxDateTime * datetime, time_t timet);
	void bmx_wxdatetime_setjdn(MaxDateTime * datetime, double jdn);
	void bmx_wxdatetime_sethms(MaxDateTime * datetime, int hour, int minute, int second, int millisec);
	void bmx_wxdatetime_setdmy(MaxDateTime * datetime, int day, wxDateTime::Month month, int year, int hour, int minute, int second, int millisec);
	void bmx_wxdatetime_resettime(MaxDateTime * datetime);
	void bmx_wxdatetime_setyear(MaxDateTime * datetime, int year);
	void bmx_wxdatetime_setmonth(MaxDateTime * datetime, wxDateTime::Month month);
	void bmx_wxdatetime_setday(MaxDateTime * datetime, int day);
	void bmx_wxdatetime_sethour(MaxDateTime * datetime, int hour);
	void bmx_wxdatetime_setminute(MaxDateTime * datetime, int minute);
	void bmx_wxdatetime_setsecond(MaxDateTime * datetime, int second);
	void bmx_wxdatetime_setmillisecond(MaxDateTime * datetime, int millisec);
	int bmx_wxdatetime_isvalid(MaxDateTime * datetime);
	MaxDateTime * bmx_wxdatetime_getdateonly(MaxDateTime * datetime);
	time_t bmx_wxdatetime_getticks(MaxDateTime * datetime);
	int bmx_wxdatetime_getcentury(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getyear(MaxDateTime * datetime, wxDateTime::TZ tz);
	wxDateTime::Month bmx_wxdatetime_getmonth(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getday(MaxDateTime * datetime, wxDateTime::TZ tz);
	wxDateTime::WeekDay bmx_wxdatetime_getweekday(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_gethour(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getminute(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getsecond(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getmillisecond(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getdayofyear(MaxDateTime * datetime, wxDateTime::TZ tz);
	int bmx_wxdatetime_getweekofyear(MaxDateTime * datetime, wxDateTime::WeekFlags flags, wxDateTime::TZ tz);
	int bmx_wxdatetime_getweekofmonth(MaxDateTime * datetime, wxDateTime::WeekFlags flags, wxDateTime::TZ tz);
	int bmx_wxdatetime_isworkday(MaxDateTime * datetime, wxDateTime::Country country);
	void bmx_wxdatetime_setfromdos(MaxDateTime * datetime, unsigned long ddt);
	unsigned long bmx_wxdatetime_getasdos(MaxDateTime * datetime);
	int bmx_wxdatetime_isequalto(MaxDateTime * datetime, MaxDateTime * dt);
	int bmx_wxdatetime_isearlierthan(MaxDateTime * datetime, MaxDateTime * dt);
	int bmx_wxdatetime_islaterthan(MaxDateTime * datetime, MaxDateTime * dt);
	int bmx_wxdatetime_isstrictlybetween(MaxDateTime * datetime, MaxDateTime * t1, MaxDateTime * t2);
	int bmx_wxdatetime_isbetween(MaxDateTime * datetime, MaxDateTime * t1, MaxDateTime * t2);
	int bmx_wxdatetime_issamedate(MaxDateTime * datetime, MaxDateTime * dt);
	int bmx_wxdatetime_issametime(MaxDateTime * datetime, MaxDateTime * dt);


	int bmx_wxdatetime_isequalupto(MaxDateTime * datetime, MaxDateTime * dt, MaxTimeSpan * ts);
	MaxDateTime * bmx_wxdatetime_addts(MaxDateTime * datetime, MaxTimeSpan * diff);
	MaxDateTime * bmx_wxdatetime_subtractts(MaxDateTime * datetime, MaxTimeSpan *diff);
	MaxDateTime * bmx_wxdatetime_addds(MaxDateTime * datetime, MaxDateSpan * diff);
	MaxDateTime * bmx_wxdatetime_subtractds(MaxDateTime * datetime, MaxDateSpan * diff);
	BBString * bmx_wxdatetime_parserfc822date(MaxDateTime * datetime, BBString * date);
	BBString * bmx_wxdatetime_parseformat(MaxDateTime * datetime, BBString * date, BBString * format, MaxDateTime * dateDef);
	BBString * bmx_wxdatetime_parsedatetime(MaxDateTime * datetime, BBString * dt);
	BBString * bmx_wxdatetime_parsedate(MaxDateTime * datetime, BBString * date);
	BBString * bmx_wxdatetime_parsetime(MaxDateTime * datetime, BBString * time);
	BBString * bmx_wxdatetime_format(MaxDateTime * datetime, BBString * format, wxDateTime::TZ tz);
	BBString * bmx_wxdatetime_formatdate(MaxDateTime * datetime);
	BBString * bmx_wxdatetime_formattime(MaxDateTime * datetime);
	BBString * bmx_wxdatetime_formatisodate(MaxDateTime * datetime);
	BBString * bmx_wxdatetime_formatisotime(MaxDateTime * datetime);
	void bmx_wxdatetime_settoweekdayinsameweek(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::WeekFlags flags);
	MaxDateTime * bmx_wxdatetime_getweekdayinsameweek(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::WeekFlags flags);
	void bmx_wxdatetime_settonextweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekday);
	MaxDateTime * bmx_wxdatetime_getnextweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekday);
	void bmx_wxdatetime_settoprevweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay);
	MaxDateTime * bmx_wxdatetime_getprevweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay);
	int bmx_wxdatetime_settoweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, int n, wxDateTime::Month month, int year);
	MaxDateTime * bmx_wxdatetime_gettoweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, int n, wxDateTime::Month month, int year);
	int bmx_wxdatetime_settolastweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::Month month, int year);
	MaxDateTime * bmx_wxdatetime_getlastweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::Month month, int year);
	MaxDateTime * bmx_wxdatetime_settoweekofyear(int year, int numWeek, wxDateTime::WeekDay weekDay);
	void bmx_wxdatetime_settolastdayofmonth(MaxDateTime * datetime, wxDateTime::Month month, int year);
	MaxDateTime * bmx_wxdatetime_getlastmonthday(MaxDateTime * datetime, wxDateTime::Month month, int year);
	void bmx_wxdatetime_settoyearday(MaxDateTime * datetime, int yday);
	MaxDateTime * bmx_wxdatetime_getyearday(MaxDateTime * datetime, int yday);
	double bmx_wxdatetime_getjuliandaynumber(MaxDateTime * datetime);
	double bmx_wxdatetime_getjdn(MaxDateTime * datetime);
	double bmx_wxdatetime_getmodifiedjuliandaynumber(MaxDateTime * datetime);
	double bmx_wxdatetime_getmjd(MaxDateTime * datetime);
	double bmx_wxdatetime_getratadie(MaxDateTime * datetime);
	MaxDateTime * bmx_wxdatetime_fromtimezone(MaxDateTime * datetime, wxDateTime::TZ tz, int noDST);
	MaxDateTime * bmx_wxdatetime_totimezone(MaxDateTime * datetime, wxDateTime::TZ tz, int noDST);
	void bmx_wxdatetime_maketimezone(MaxDateTime * datetime, wxDateTime::TZ tz, int noDST);
	void bmx_wxdatetime_makefromtimezone(MaxDateTime * datetime, wxDateTime::TZ tz, int noDST);
	MaxDateTime * bmx_wxdatetime_toutc(MaxDateTime * datetime, int noDST);
	void bmx_wxdatetime_makeutc(MaxDateTime * datetime, int noDST);
	int bmx_wxdatetime_isdst(MaxDateTime * datetime, wxDateTime::Country country);

	MaxDateSpan * bmx_wxdatespan_create(int years, int months, int weeks, int days);
	void bmx_wxdatespan_delete(MaxDateSpan * span);
	MaxDateSpan * bmx_wxdatespan_add(MaxDateSpan * datespan, MaxDateSpan * other);
	MaxDateSpan * bmx_wxdatespan_day();
	MaxDateSpan * bmx_wxdatespan_days(int days);
	int bmx_wxdatespan_getdays(MaxDateSpan * datespan);
	int bmx_wxdatespan_getmonths(MaxDateSpan * datespan);
	int bmx_wxdatespan_gettotaldays(MaxDateSpan * datespan);
	int bmx_wxdatespan_getweeks(MaxDateSpan * datespan);
	int bmx_wxdatespan_getyears(MaxDateSpan * datespan);
	MaxDateSpan * bmx_wxdatespan_month();
	MaxDateSpan * bmx_wxdatespan_months(int mon);
	MaxDateSpan * bmx_wxdatespan_multiply(MaxDateSpan * datespan, int factor);
	MaxDateSpan * bmx_wxdatespan_negate(MaxDateSpan * datespan);
	void bmx_wxdatespan_setdays(MaxDateSpan * datespan, int n);
	void bmx_wxdatespan_setyears(MaxDateSpan * datespan, int n);
	void bmx_wxdatespan_setmonths(MaxDateSpan * datespan, int n);
	void bmx_wxdatespan_setweeks(MaxDateSpan * datespan, int n);
	MaxDateSpan * bmx_wxdatespan_subtract(MaxDateSpan * datespan, MaxDateSpan * other);
	MaxDateSpan * bmx_wxdatespan_week();
	MaxDateSpan * bmx_wxdatespan_weeks(int weeks);
	MaxDateSpan * bmx_wxdatespan_year();
	MaxDateSpan * bmx_wxdatespan_years(int years);
	int bmx_wxdatespan_equals(MaxDateSpan * datespan, MaxDateSpan * other);
	
	void bmx_wxtimespan_delete(MaxTimeSpan * span);
	MaxTimeSpan * bmx_wxtimespan_create(long hours, long minutes, long seconds, long msec);
	MaxTimeSpan * bmx_wxtimespan_abs(MaxTimeSpan * timespan);
	MaxTimeSpan * bmx_wxtimespan_add(MaxTimeSpan * timespan, MaxTimeSpan * diff);
	MaxTimeSpan * bmx_wxtimespan_days(long numDays);
	MaxTimeSpan * bmx_wxtimespan_day();
	BBString * bmx_wxtimespan_format(MaxTimeSpan * timespan, BBString * format);
	int bmx_wxtimespan_getdays(MaxTimeSpan * timespan);
	int bmx_wxtimespan_gethours(MaxTimeSpan * timespan);
	void bmx_wxtimespan_getmilliseconds(MaxTimeSpan * timespan, BBInt64 * value);
	int bmx_wxtimespan_getminutes(MaxTimeSpan * timespan);
	void bmx_wxtimespan_getseconds(MaxTimeSpan * timespan, BBInt64 * value);
	void bmx_wxtimespan_getvalue(MaxTimeSpan * timespan, BBInt64 * value);
	int bmx_wxtimespan_getweeks(MaxTimeSpan * timespan);
	MaxTimeSpan * bmx_wxtimespan_hours(long hours);
	MaxTimeSpan * bmx_wxtimespan_hour();
	int bmx_wxtimespan_isequalto(MaxTimeSpan * timespan, MaxTimeSpan * ts);
	int bmx_wxtimespan_islongerthan(MaxTimeSpan * timespan, MaxTimeSpan * ts);
	int bmx_wxtimespan_isnegative(MaxTimeSpan * timespan);
	int bmx_wxtimespan_isnull(MaxTimeSpan * timespan);
	int bmx_wxtimespan_ispositive(MaxTimeSpan * timespan);
	int bmx_wxtimespan_isshorterthan(MaxTimeSpan * timespan, MaxTimeSpan * ts);
	MaxTimeSpan * bmx_wxtimespan_minutes(long mins);
	MaxTimeSpan * bmx_wxtimespan_minute();
	MaxTimeSpan * bmx_wxtimespan_multiply(MaxTimeSpan * timespan, int n);
	MaxTimeSpan * bmx_wxtimespan_negate(MaxTimeSpan * timespan);
	MaxTimeSpan * bmx_wxtimespan_milliseconds(long ms);
	MaxTimeSpan * bmx_wxtimespan_millisecond();
	MaxTimeSpan * bmx_wxtimespan_seconds(long sec);
	MaxTimeSpan * bmx_wxtimespan_second();
	MaxTimeSpan * bmx_wxtimespan_subtract(MaxTimeSpan * timespan, MaxTimeSpan * diff);
	MaxTimeSpan * bmx_wxtimespan_weeks(long wks);
	MaxTimeSpan * bmx_wxtimespan_week();

	
	MaxDateTime * bmx_wxdateevent_getdate(wxDateEvent & event);
	void bmx_wxdateevent_setdate(wxDateEvent & event, MaxDateTime * date);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDateTime
{
public:
	MaxDateTime(const wxDateTime & d);
	wxDateTime & DateTime();

private:
	wxDateTime dateTime;

};

class MaxDateSpan
{
public:
	MaxDateSpan(const wxDateSpan & d);
	wxDateSpan & Span();

private:
	wxDateSpan dateSpan;

};

class MaxTimeSpan
{
public:
	MaxTimeSpan(const wxTimeSpan & t);
	wxTimeSpan & Span();

private:
	wxTimeSpan timeSpan;

};

/*class MaxTimeZone
{
public:
	MaxTimeZone(const wxDateTime::TimeZone & t);
	wxDateTime::TimeZone & TimeZone();

private:
	wxDateTime::TimeZone timeZone;

};*/


#endif // _WX_MAX_DATETIME_H_
