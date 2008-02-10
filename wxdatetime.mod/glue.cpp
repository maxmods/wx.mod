/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxDateTime::MaxDateTime(const wxDateTime& d)
	: dateTime(d)
{
}

wxDateTime & MaxDateTime::DateTime() {
	return dateTime;
}

MaxTimeSpan::MaxTimeSpan(const wxTimeSpan& t)
	: timeSpan(t)
{
}

wxTimeSpan & MaxTimeSpan::Span() {
	return timeSpan;
}

MaxDateSpan::MaxDateSpan(const wxDateSpan& d)
	: dateSpan(d)
{
}

wxDateSpan & MaxDateSpan::Span() {
	return dateSpan;
}


MaxTimeZone::MaxTimeZone(const wxDateTime::TimeZone& t)
	: timeZone(t)
{
}

wxDateTime::TimeZone & MaxTimeZone::TimeZone() {
	return timeZone;
}


// *********************************************

void bmx_wxdatetime_setcountry(wxDateTime::Country country) {
	wxDateTime::SetCountry(country);
}

wxDateTime::Country bmx_wxdatetime_getcountry() {
	return wxDateTime::GetCountry();
}

bool bmx_wxdatetime_iswesteuropeancountry(wxDateTime::Country country) {
	return wxDateTime::IsWestEuropeanCountry(country);
}

int bmx_wxdatetime_getcurrentyear(wxDateTime::Calendar cal) {
	return wxDateTime::GetCurrentYear(cal);
}

int bmx_wxdatetime_convertyeartobc(int year) {
	return wxDateTime::ConvertYearToBC(year);
}

wxDateTime::Month bmx_wxdatetime_getcurrentmonth(wxDateTime::Calendar cal) {
	return wxDateTime::GetCurrentMonth(cal);
}

bool bmx_wxdatetime_isleapyear(int year, wxDateTime::Calendar cal) {
	return wxDateTime::IsLeapYear(year, cal);
}

int bmx_wxdatetime_getcenturyforyear(int year) {
	return wxDateTime::GetCentury(year);
}

int bmx_wxdatetime_getnumberofdaysforyear(int year, wxDateTime::Calendar cal) {
	return wxDateTime::GetNumberOfDays(year, cal);
}

int bmx_wxdatetime_getnumberofdays(wxDateTime::Month month, int year, wxDateTime::Calendar cal) {
	return wxDateTime::GetNumberOfDays(month, year, cal);
}

BBString * bmx_wxdatetime_getmonthname(wxDateTime::Month month, wxDateTime::NameFlags flags) {
	return bbStringFromWxString(wxDateTime::GetMonthName(month, flags));
}

BBString * bmx_wxdatetime_getweekdayname(wxDateTime::WeekDay weekday, wxDateTime::NameFlags flags) {
	return bbStringFromWxString(wxDateTime::GetWeekDayName(weekday, flags));
}

BBString * bmx_wxdatetime_getamstring() {
	wxString s;
	wxDateTime::GetAmPmStrings(&s, NULL);
	return bbStringFromWxString(s);
}

BBString * bmx_wxdatetime_getpmstring() {
	wxString s;
	wxDateTime::GetAmPmStrings(NULL, &s);
	return bbStringFromWxString(s);
}

bool bmx_wxdatetime_isdstapplicable(int year, wxDateTime::Country country) {
	return wxDateTime::IsDSTApplicable(year, country);
}

MaxDateTime * bmx_wxdatetime_getbegindst(int year, wxDateTime::Country country) {
	wxDateTime d(wxDateTime::GetBeginDST(year, country));
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_getenddst(int year, wxDateTime::Country country) {
	wxDateTime d(wxDateTime::GetEndDST(year, country));
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_now() {
	wxDateTime d(wxDateTime::Now());
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_unow() {
	wxDateTime d(wxDateTime::UNow());
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_today() {
	wxDateTime d(wxDateTime::Today());
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_create() {
	wxDateTime d;
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_createfromtimet(time_t time) {
	wxDateTime d(time);
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_createfromjdn(double jdn) {
	wxDateTime d(jdn);
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_createfromhms(int hour, int minute, int second, int millisec) {
	wxDateTime d(static_cast<unsigned short>(hour), static_cast<unsigned short>(minute), static_cast<unsigned short>(second), static_cast<unsigned short>(millisec));
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxdatetime_createfromdmy(int day, wxDateTime::Month month, int year, int hour, int minute, int second, int millisec) {
	wxDateTime d(static_cast<unsigned short>(day), month, static_cast<unsigned short>(year) , static_cast<unsigned short>(hour), static_cast<unsigned short>(minute), static_cast<unsigned short>(second), static_cast<unsigned short>(millisec));
	return new MaxDateTime(d);
}

void bmx_wxdatetime_delete(MaxDateTime * dt) {
	delete dt;
}



void bmx_wxdatetime_settocurrent(MaxDateTime * datetime) {
	datetime->DateTime().SetToCurrent();
}

void bmx_wxdatetime_settimet(MaxDateTime * datetime, time_t timet) {
	datetime->DateTime().Set(timet);
}

void bmx_wxdatetime_setjdn(MaxDateTime * datetime, double jdn) {
	datetime->DateTime().Set(jdn);
}

void bmx_wxdatetime_sethms(MaxDateTime * datetime, int hour, int minute, int second, int millisec) {
	datetime->DateTime().Set(
		static_cast<wxDateTime::wxDateTime_t>(hour),
		static_cast<wxDateTime::wxDateTime_t>(minute),
		static_cast<wxDateTime::wxDateTime_t>(second),
		static_cast<wxDateTime::wxDateTime_t>(millisec) );
}

void bmx_wxdatetime_setdmy(MaxDateTime * datetime, int day, wxDateTime::Month month,
		int year, int hour, int minute, int second, int millisec) {
	datetime->DateTime().Set(
		static_cast<wxDateTime::wxDateTime_t>(day),
		month,
		year,
		static_cast<wxDateTime::wxDateTime_t>(hour),
		static_cast<wxDateTime::wxDateTime_t>(minute),
		static_cast<wxDateTime::wxDateTime_t>(second),
		static_cast<wxDateTime::wxDateTime_t>(millisec) );
}

void bmx_wxdatetime_resettime(MaxDateTime * datetime) {
	datetime->DateTime().ResetTime();
}

void bmx_wxdatetime_setyear(MaxDateTime * datetime, int year) {
	datetime->DateTime().SetYear(year);
}

void bmx_wxdatetime_setmonth(MaxDateTime * datetime, wxDateTime::Month month) {
	datetime->DateTime().SetMonth(month);
}

void bmx_wxdatetime_setday(MaxDateTime * datetime, int day) {
	datetime->DateTime().SetDay(static_cast<wxDateTime::wxDateTime_t>(day));
}

void bmx_wxdatetime_sethour(MaxDateTime * datetime, int hour) {
	datetime->DateTime().SetHour(static_cast<wxDateTime::wxDateTime_t>(hour));
}

void bmx_wxdatetime_setminute(MaxDateTime * datetime, int minute) {
	datetime->DateTime().SetMinute(static_cast<wxDateTime::wxDateTime_t>(minute));
}

void bmx_wxdatetime_setsecond(MaxDateTime * datetime, int second) {
	datetime->DateTime().SetSecond(static_cast<wxDateTime::wxDateTime_t>(second));
}

void bmx_wxdatetime_setmillisecond(MaxDateTime * datetime, int millisec) {
	datetime->DateTime().SetMillisecond(static_cast<wxDateTime::wxDateTime_t>(millisec));
}

bool bmx_wxdatetime_isvalid(MaxDateTime * datetime) {
	return datetime->DateTime().IsValid();
}

MaxDateTime * bmx_wxdatetime_getdateonly(MaxDateTime * datetime) {
	return new MaxDateTime(datetime->DateTime().GetDateOnly());
}

time_t bmx_wxdatetime_getticks(MaxDateTime * datetime) {
	return datetime->DateTime().GetTicks();
}

int bmx_wxdatetime_getcentury(MaxDateTime * datetime, MaxTimeZone * tz) {
	return datetime->DateTime().GetCentury((tz)?tz->TimeZone():wxDateTime::Local);
}

int bmx_wxdatetime_getyear(MaxDateTime * datetime, MaxTimeZone * tz) {
	return datetime->DateTime().GetYear((tz)?tz->TimeZone():wxDateTime::Local);
}

wxDateTime::Month bmx_wxdatetime_getmonth(MaxDateTime * datetime, MaxTimeZone * tz) {
	return datetime->DateTime().GetMonth((tz)?tz->TimeZone():wxDateTime::Local);
}

int bmx_wxdatetime_getday(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetDay((tz)?tz->TimeZone():wxDateTime::Local));
}

wxDateTime::WeekDay bmx_wxdatetime_getweekday(MaxDateTime * datetime, MaxTimeZone * tz) {
	return datetime->DateTime().GetWeekDay((tz)?tz->TimeZone():wxDateTime::Local);
}

int bmx_wxdatetime_gethour(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetHour((tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getminute(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetMinute((tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getsecond(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetSecond((tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getmillisecond(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetMillisecond((tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getdayofyear(MaxDateTime * datetime, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetDayOfYear((tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getweekofyear(MaxDateTime * datetime, wxDateTime::WeekFlags flags, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetWeekOfYear(flags, (tz)?tz->TimeZone():wxDateTime::Local));
}

int bmx_wxdatetime_getweekofmonth(MaxDateTime * datetime, wxDateTime::WeekFlags flags, MaxTimeZone * tz) {
	return static_cast<int>(datetime->DateTime().GetWeekOfMonth(flags, (tz)?tz->TimeZone():wxDateTime::Local));
}

bool bmx_wxdatetime_isworkday(MaxDateTime * datetime, wxDateTime::Country country) {
	return datetime->DateTime().IsWorkDay(country);
}

void bmx_wxdatetime_setfromdos(MaxDateTime * datetime, unsigned long ddt) {
	datetime->DateTime().SetFromDOS(ddt);
}

unsigned long bmx_wxdatetime_getasdos(MaxDateTime * datetime) {
	return datetime->DateTime().GetAsDOS();
}

bool bmx_wxdatetime_isequalto(MaxDateTime * datetime, MaxDateTime * dt) {
	return datetime->DateTime().IsEqualTo(dt->DateTime());
}

bool bmx_wxdatetime_isearlierthan(MaxDateTime * datetime, MaxDateTime * dt) {
	return datetime->DateTime().IsEarlierThan(dt->DateTime());
}

bool bmx_wxdatetime_islaterthan(MaxDateTime * datetime, MaxDateTime * dt) {
	return datetime->DateTime().IsLaterThan(dt->DateTime());
}

bool bmx_wxdatetime_isstrictlybetween(MaxDateTime * datetime, MaxDateTime * t1, MaxDateTime * t2) {
	return datetime->DateTime().IsStrictlyBetween(t1->DateTime(), t2->DateTime());
}

bool bmx_wxdatetime_isbetween(MaxDateTime * datetime, MaxDateTime * t1, MaxDateTime * t2) {
	return datetime->DateTime().IsBetween(t1->DateTime(), t2->DateTime());
}

bool bmx_wxdatetime_issamedate(MaxDateTime * datetime, MaxDateTime * dt) {
	return datetime->DateTime().IsSameDate(dt->DateTime());
}

bool bmx_wxdatetime_issametime(MaxDateTime * datetime, MaxDateTime * dt) {
	return datetime->DateTime().IsSameTime(dt->DateTime());
}


bool bmx_wxdatetime_isequalupto(MaxDateTime * datetime, MaxDateTime * dt, MaxTimeSpan * ts) {
	return datetime->DateTime().IsEqualUpTo(dt->DateTime(), ts->Span());
}

MaxDateTime * bmx_wxdatetime_addts(MaxDateTime * datetime, MaxTimeSpan * diff) {
	return new MaxDateTime(datetime->DateTime().Add(diff->Span()));
}

MaxDateTime * bmx_wxdatetime_subtractts(MaxDateTime * datetime, MaxTimeSpan *diff) {
	return new MaxDateTime(datetime->DateTime().Subtract(diff->Span()));
}

MaxDateTime * bmx_wxdatetime_addds(MaxDateTime * datetime, MaxDateSpan * diff) {
	return new MaxDateTime(datetime->DateTime().Add(diff->Span()));
}

MaxDateTime * bmx_wxdatetime_subtractds(MaxDateTime * datetime, MaxDateSpan * diff) {
	return new MaxDateTime(datetime->DateTime().Subtract(diff->Span()));
}

BBString * bmx_wxdatetime_parserfc822date(MaxDateTime * datetime, BBString * date) {
	return bbStringFromWxString(wxString(datetime->DateTime().ParseRfc822Date(wxStringFromBBString(date).c_str())));
}

BBString * bmx_wxdatetime_parseformat(MaxDateTime * datetime, BBString * date, BBString * format, MaxDateTime * dateDef) {
	const wxChar * c = wxDefaultDateTimeFormat;
	if (format!=&bbEmptyString) {
		c = wxStringFromBBString(format).c_str(); 
	}

	if (dateDef) {
		return bbStringFromWxString(wxString(datetime->DateTime().ParseFormat(wxStringFromBBString(date).c_str(), c, dateDef->DateTime())));
	} else {
		return bbStringFromWxString(wxString(datetime->DateTime().ParseFormat(wxStringFromBBString(date).c_str(), c)));
	}
}

BBString * bmx_wxdatetime_parsedatetime(MaxDateTime * datetime, BBString * dt) {
	return bbStringFromWxString(wxString(datetime->DateTime().ParseDateTime(wxStringFromBBString(dt).c_str())));
}

BBString * bmx_wxdatetime_parsedate(MaxDateTime * datetime, BBString * date) {
	return bbStringFromWxString(wxString(datetime->DateTime().ParseDate(wxStringFromBBString(date).c_str())));
}

BBString * bmx_wxdatetime_parsetime(MaxDateTime * datetime, BBString * time) {
	return bbStringFromWxString(wxString(datetime->DateTime().ParseTime(wxStringFromBBString(time).c_str())));
}

BBString * bmx_wxdatetime_format(MaxDateTime * datetime, BBString * format, MaxTimeZone * tz) {
	if (tz) {
		return bbStringFromWxString(datetime->DateTime().Format(wxStringFromBBString(format).c_str(), tz->TimeZone()));
	} else {
		return bbStringFromWxString(datetime->DateTime().Format(wxStringFromBBString(format).c_str()));
	}
}

BBString * bmx_wxdatetime_formatdate(MaxDateTime * datetime) {
	return bbStringFromWxString(datetime->DateTime().FormatDate());
}

BBString * bmx_wxdatetime_formattime(MaxDateTime * datetime) {
	return bbStringFromWxString(datetime->DateTime().FormatTime());
}

BBString * bmx_wxdatetime_formatisodate(MaxDateTime * datetime) {
	return bbStringFromWxString(datetime->DateTime().FormatISODate());
}

BBString * bmx_wxdatetime_formatisotime(MaxDateTime * datetime) {
	return bbStringFromWxString(datetime->DateTime().FormatISOTime());
}

void bmx_wxdatetime_settoweekdayinsameweek(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::WeekFlags flags) {
	datetime->DateTime().SetToWeekDayInSameWeek(weekDay, flags);
}

MaxDateTime * bmx_wxdatetime_getweekdayinsameweek(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::WeekFlags flags) {
	return new MaxDateTime(datetime->DateTime().GetWeekDayInSameWeek(weekDay, flags));
}

void bmx_wxdatetime_settonextweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekday) {
	datetime->DateTime().SetToNextWeekDay(weekday);
}

MaxDateTime * bmx_wxdatetime_getnextweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekday) {
	return new MaxDateTime(datetime->DateTime().GetNextWeekDay(weekday));
}

void bmx_wxdatetime_settoprevweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay) {
	datetime->DateTime().SetToPrevWeekDay(weekDay);
}

MaxDateTime * bmx_wxdatetime_getprevweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay) {
	return new MaxDateTime(datetime->DateTime().GetPrevWeekDay(weekDay));
}

bool bmx_wxdatetime_settoweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, int n, wxDateTime::Month month, int year) {
	return datetime->DateTime().SetToWeekDay(weekDay, n, month, year);
}

MaxDateTime * bmx_wxdatetime_gettoweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, int n, wxDateTime::Month month, int year) {
	return new MaxDateTime(datetime->DateTime().GetWeekDay(weekDay, n, month, year));
}

bool bmx_wxdatetime_settolastweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::Month month, int year) {
	return datetime->DateTime().SetToLastWeekDay(weekDay, month, year);
}

MaxDateTime * bmx_wxdatetime_getlastweekday(MaxDateTime * datetime, wxDateTime::WeekDay weekDay, wxDateTime::Month month, int year) {
	return new MaxDateTime(datetime->DateTime().GetLastWeekDay(weekDay, month, year));
}

MaxDateTime * bmx_wxdatetime_settoweekofyear(int year, int numWeek, wxDateTime::WeekDay weekDay) {
	return new MaxDateTime(wxDateTime::SetToWeekOfYear(year, static_cast<wxDateTime::wxDateTime_t>(numWeek), weekDay));
}

void bmx_wxdatetime_settolastdayofmonth(MaxDateTime * datetime, wxDateTime::Month month, int year) {
	datetime->DateTime().SetToLastMonthDay(month, year);
}

MaxDateTime * bmx_wxdatetime_getlastmonthday(MaxDateTime * datetime, wxDateTime::Month month, int year) {
	return new MaxDateTime(datetime->DateTime().GetLastMonthDay(month, year));
}

void bmx_wxdatetime_settoyearday(MaxDateTime * datetime, int yday) {
	datetime->DateTime().SetToYearDay(static_cast<wxDateTime::wxDateTime_t>(yday));
}

MaxDateTime * bmx_wxdatetime_getyearday(MaxDateTime * datetime, int yday) {
	return new MaxDateTime(datetime->DateTime().GetYearDay(static_cast<wxDateTime::wxDateTime_t>(yday)));
}

double bmx_wxdatetime_getjuliandaynumber(MaxDateTime * datetime) {
	return datetime->DateTime().GetJulianDayNumber();
}

double bmx_wxdatetime_getjdn(MaxDateTime * datetime) {
	return datetime->DateTime().GetJDN();
}

double bmx_wxdatetime_getmodifiedjuliandaynumber(MaxDateTime * datetime) {
	return datetime->DateTime().GetModifiedJulianDayNumber();
}

double bmx_wxdatetime_getmjd(MaxDateTime * datetime) {
	return datetime->DateTime().GetMJD();
}

double bmx_wxdatetime_getratadie(MaxDateTime * datetime) {
	return datetime->DateTime().GetRataDie();
}

MaxDateTime * bmx_wxdatetime_fromtimezone(MaxDateTime * datetime, MaxTimeZone * tz, bool noDST) {
	return new MaxDateTime(datetime->DateTime().FromTimezone(tz->TimeZone(), noDST));
}

MaxDateTime * bmx_wxdatetime_totimezone(MaxDateTime * datetime, MaxTimeZone * tz, bool noDST) {
	return new MaxDateTime(datetime->DateTime().ToTimezone(tz->TimeZone(), noDST));
}

void bmx_wxdatetime_maketimezone(MaxDateTime * datetime, MaxTimeZone * tz, bool noDST) {
	datetime->DateTime().MakeTimezone(tz->TimeZone(), noDST);
}

void bmx_wxdatetime_makefromtimezone(MaxDateTime * datetime, MaxTimeZone * tz, bool noDST) {
	datetime->DateTime().MakeFromTimezone(tz->TimeZone(), noDST);
}

MaxDateTime * bmx_wxdatetime_toutc(MaxDateTime * datetime, bool noDST) {
	return new MaxDateTime(datetime->DateTime().ToUTC(noDST));
}

void bmx_wxdatetime_makeutc(MaxDateTime * datetime, bool noDST) {
	datetime->DateTime().MakeUTC(noDST);
}

bool bmx_wxdatetime_isdst(MaxDateTime * datetime, wxDateTime::Country country) {
	return datetime->DateTime().IsDST(country);
}

// *********************************************

MaxDateSpan * bmx_wxdatespan_create(int years, int months, int weeks, int days) {
	wxDateSpan s(years, months, weeks, days);
	return new MaxDateSpan(s);
}

void bmx_wxdatespan_delete(MaxDateSpan * span) {
	delete span;
}

// *********************************************

void bmx_wxtimespan_delete(MaxTimeSpan * span) {
	delete span;
}

// *********************************************

MaxDateTime * bmx_wxdateevent_getdate(wxDateEvent & event) {
	return new MaxDateTime(event.GetDate());
}

void bmx_wxdateevent_setdate(wxDateEvent & event, MaxDateTime * date) {
	event.SetDate(date->DateTime());
}
