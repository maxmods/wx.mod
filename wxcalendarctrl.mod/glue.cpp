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

MaxCalendarCtrl::MaxCalendarCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, MaxDateTime * date, int x, int y,
		int w, int h, long style)
	: wxCalendarCtrl(parent, id, (date) ? date->DateTime() : wxDefaultDateTime, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxCalendarCtrl::MaxCalendarCtrl()
{}

MaxCalendarCtrl::~MaxCalendarCtrl() {
	wxunbind(this);
}

void MaxCalendarCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxCalendarCtrlXmlHandler, wxCalendarCtrlXmlHandler)

MaxCalendarCtrlXmlHandler::MaxCalendarCtrlXmlHandler()
	: wxCalendarCtrlXmlHandler()
{}


wxObject * MaxCalendarCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(calendar, MaxCalendarCtrl);

    calendar->Create(m_parentAsWindow,
                     GetID(),
                     wxDefaultDateTime,
                     /*TODO: take it from resource*/
                     GetPosition(), GetSize(),
                     GetStyle(),
                     GetName());

 	calendar->MaxBind(_wx_wxcalendarctrl_wxCalendarCtrl__xrcNew(calendar));

   SetupWindow(calendar);

    return calendar;

}

// *********************************************

BEGIN_EVENT_TABLE(MaxCalendarCtrl, wxCalendarCtrl)
END_EVENT_TABLE()

wxCalendarCtrl * bmx_wxcalendarctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, MaxDateTime * date, int x, int y, int w, int h, long style) {
	return new MaxCalendarCtrl(handle, parent, id, date, x, y, w, h, style);
}

void bmx_wxcalendarctrl_setdate(wxCalendarCtrl * ctrl, MaxDateTime * date) {
	ctrl->SetDate(date->DateTime());
}

MaxDateTime * bmx_wxcalendarctrl_getdate(wxCalendarCtrl * ctrl) {
	wxDateTime d(ctrl->GetDate());
	return new MaxDateTime(d);
}

void bmx_wxcalendarctrl_enablemonthchange(wxCalendarCtrl * ctrl, bool enable) {
	ctrl->EnableMonthChange(enable);
}

void bmx_wxcalendarctrl_enableholidaydisplay(wxCalendarCtrl * ctrl, bool display) {
	ctrl->EnableHolidayDisplay(display);
}

void bmx_wxcalendarctrl_setheadercolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG) {
	ctrl->SetHeaderColours(colFG->Colour(), colBG->Colour());
}

MaxColour * bmx_wxcalendarctrl_getheadercolourfg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHeaderColourFg());
	return new MaxColour(c);
}

MaxColour * bmx_wxcalendarctrl_getheadercolourbg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHeaderColourBg());
	return new MaxColour(c);
}

void bmx_wxcalendarctrl_sethighlightcolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG) {
	ctrl->SetHighlightColours(colFG->Colour(), colBG->Colour());
}

MaxColour * bmx_wxcalendarctrl_gethighlightcolourfg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHighlightColourFg());
	return new MaxColour(c);
}

MaxColour * bmx_wxcalendarctrl_gethighlightcolourbg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHighlightColourBg());
	return new MaxColour(c);
}

void bmx_wxcalendarctrl_setholidaycolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG) {
	ctrl->SetHolidayColours(colFG->Colour(), colBG->Colour());
}

MaxColour * bmx_wxcalendarctrl_getholidaycolourfg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHolidayColourFg());
	return new MaxColour(c);
}

MaxColour * bmx_wxcalendarctrl_getholidaycolourbg(wxCalendarCtrl * ctrl) {
	wxColour c(ctrl->GetHolidayColourBg());
	return new MaxColour(c);
}

wxCalendarDateAttr * bmx_wxcalendarctrl_getattr(wxCalendarCtrl * ctrl, int day) {
	return ctrl->GetAttr(static_cast<size_t>(day));
}

void bmx_wxcalendarctrl_setattr(wxCalendarCtrl * ctrl, int day, wxCalendarDateAttr * attr) {
	ctrl->SetAttr(static_cast<size_t>(day), attr);
}

void bmx_wxcalendarctrl_setholiday(wxCalendarCtrl * ctrl, int day) {
	ctrl->SetHoliday(static_cast<size_t>(day));
}

void bmx_wxcalendarctrl_resetattr(wxCalendarCtrl * ctrl, int day) {
	ctrl->ResetAttr(static_cast<size_t>(day));
}

MaxDateTime * bmx_wxcalendarctrl_hittest(wxCalendarCtrl * ctrl, int x, int y, wxCalendarHitTestResult * where, wxDateTime::WeekDay * wd) {
	wxDateTime t;
	*where = ctrl->HitTest(wxPoint(x, y), &t, wd);
	return new MaxDateTime(t);
}


wxCalendarDateAttr * bmx_wxcalendardateattr_create(MaxColour * colText, MaxColour * colBack, MaxColour * colBorder, MaxFont * font, wxCalendarDateBorder border) {
	if (colBack) {
		if (colBorder) {
			if (font) {
				return new wxCalendarDateAttr(colText->Colour(), colBack->Colour(), colBorder->Colour(), font->Font(), border);
			} else {
				return new wxCalendarDateAttr(colText->Colour(), colBack->Colour(), colBorder->Colour(), wxNullFont, border);
			}
		} else {
			if (font) {
				return new wxCalendarDateAttr(colText->Colour(), colBack->Colour(), wxNullColour, font->Font(), border);
			} else {
				return new wxCalendarDateAttr(colText->Colour(), colBack->Colour(), wxNullColour, wxNullFont, border);
			}
		}
	} else {
		if (colBorder) {
			if (font) {
				return new wxCalendarDateAttr(colText->Colour(), wxNullColour, colBorder->Colour(), font->Font(), border);
			} else {
				return new wxCalendarDateAttr(colText->Colour(), wxNullColour, colBorder->Colour(), wxNullFont, border);
			}
		} else {
			if (font) {
				return new wxCalendarDateAttr(colText->Colour(), wxNullColour, wxNullColour, font->Font(), border);
			} else {
				return new wxCalendarDateAttr(colText->Colour(), wxNullColour, wxNullColour, wxNullFont, border);
			}
		}
	}
}

void bmx_wxcalendardateattr_settextcolour(wxCalendarDateAttr * attr, MaxColour * colour) {
	attr->SetTextColour(colour->Colour());
}

void bmx_wxcalendardateattr_setbackgroundcolour(wxCalendarDateAttr * attr, MaxColour * colour) {
	attr->SetBackgroundColour(colour->Colour());
}

void bmx_wxcalendardateattr_setbordercolour(wxCalendarDateAttr * attr, MaxColour * colour) {
	attr->SetBorderColour(colour->Colour());
}

void bmx_wxcalendardateattr_setfont(wxCalendarDateAttr * attr, MaxFont * font) {
	attr->SetFont(font->Font());
}

void bmx_wxcalendardateattr_setborder(wxCalendarDateAttr * attr, wxCalendarDateBorder border) {
	attr->SetBorder(border);
}

void bmx_wxcalendardateattr_setholidy(wxCalendarDateAttr * attr, bool holiday) {
	attr->SetHoliday(holiday);
}

bool bmx_wxcalendardateattr_hastextcolour(wxCalendarDateAttr * attr) {
	return attr->HasTextColour();
}

bool bmx_wxcalendardateattr_hasbackgroundcolour(wxCalendarDateAttr * attr) {
	return attr->HasBackgroundColour();
}

bool bmx_wxcalendardateattr_hasbordercolour(wxCalendarDateAttr * attr) {
	return attr->HasBorderColour();
}

bool bmx_wxcalendardateattr_hasfont(wxCalendarDateAttr * attr) {
	return attr->HasFont();
}

bool bmx_wxcalendardateattr_hasborder(wxCalendarDateAttr * attr) {
	return attr->HasBorder();
}

bool bmx_wxcalendardateattr_isholiday(wxCalendarDateAttr * attr) {
	return attr->IsHoliday();
}

MaxColour * bmx_wxcalendardateattr_gettextcolour(wxCalendarDateAttr * attr) {
	wxColour c(attr->GetTextColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxcalendardateattr_getbackgroundcolour(wxCalendarDateAttr * attr) {
	wxColour c(attr->GetBackgroundColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxcalendardateattr_getbordercolour(wxCalendarDateAttr * attr) {
	wxColour c(attr->GetBorderColour());
	return new MaxColour(c);
}

MaxFont * bmx_wxcalendardateattr_getfont(wxCalendarDateAttr * attr) {
	wxFont f(attr->GetFont());
	return new MaxFont(f);
}

wxCalendarDateBorder bmx_wxcalendardateattr_getborder(wxCalendarDateAttr * attr) {
	return attr->GetBorder();
}


int bmx_wxcalendarctrl_geteventtype(int type) {
	switch(type) {
		case 950: return wxEVT_CALENDAR_SEL_CHANGED;
		case 951: return wxEVT_CALENDAR_DAY_CHANGED;
		case 952: return wxEVT_CALENDAR_MONTH_CHANGED;
		case 953: return wxEVT_CALENDAR_YEAR_CHANGED;
		case 954: return wxEVT_CALENDAR_DOUBLECLICKED;
		case 955: return wxEVT_CALENDAR_WEEKDAY_CLICKED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxcalendarctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxCalendarCtrlXmlHandler);
}
