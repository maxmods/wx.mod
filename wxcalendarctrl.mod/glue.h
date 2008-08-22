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

#include "wxglue.h"
#include "wx/calctrl.h"
#include "../wxdatetime.mod/glue.h"
#include "wx/xrc/xh_cald.h"


class MaxCalendarCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxcalendarctrl_wxCalendarCtrl__xrcNew(wxCalendarCtrl * ctrl);

	wxCalendarCtrl * bmx_wxcalendarctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, MaxDateTime * date, int x, int y, int w, int h, long style);
	void bmx_wxcalendarctrl_setdate(wxCalendarCtrl * ctrl, MaxDateTime * date);
	MaxDateTime * bmx_wxcalendarctrl_getdate(wxCalendarCtrl * ctrl);
	void bmx_wxcalendarctrl_enableyearchange(wxCalendarCtrl * ctrl, bool enable);
	void bmx_wxcalendarctrl_enablemonthchange(wxCalendarCtrl * ctrl, bool enable);
	void bmx_wxcalendarctrl_enableholidaydisplay(wxCalendarCtrl * ctrl, bool display);
	void bmx_wxcalendarctrl_setheadercolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG);
	MaxColour * bmx_wxcalendarctrl_getheadercolourfg(wxCalendarCtrl * ctrl);
	MaxColour * bmx_wxcalendarctrl_getheadercolourbg(wxCalendarCtrl * ctrl);
	void bmx_wxcalendarctrl_sethighlightcolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG);
	MaxColour * bmx_wxcalendarctrl_gethighlightcolourfg(wxCalendarCtrl * ctrl);
	MaxColour * bmx_wxcalendarctrl_gethighlightcolourbg(wxCalendarCtrl * ctrl);
	void bmx_wxcalendarctrl_setholidaycolours(wxCalendarCtrl * ctrl, MaxColour * colFG, MaxColour * colBG);
	MaxColour * bmx_wxcalendarctrl_getholidaycolourfg(wxCalendarCtrl * ctrl);
	MaxColour * bmx_wxcalendarctrl_getholidaycolourbg(wxCalendarCtrl * ctrl);
	wxCalendarDateAttr * bmx_wxcalendarctrl_getattr(wxCalendarCtrl * ctrl, int day);
	void bmx_wxcalendarctrl_setattr(wxCalendarCtrl * ctrl, int day, wxCalendarDateAttr * attr);
	void bmx_wxcalendarctrl_setholiday(wxCalendarCtrl * ctrl, int day);
	void bmx_wxcalendarctrl_resetattr(wxCalendarCtrl * ctrl, int day);
	MaxDateTime * bmx_wxcalendarctrl_hittest(wxCalendarCtrl * ctrl, int x, int y, wxCalendarHitTestResult * where, wxDateTime::WeekDay * wd);
	
	wxCalendarDateAttr * bmx_wxcalendardateattr_create(MaxColour * colText, MaxColour * colBack, MaxColour * colBorder, MaxFont * font, wxCalendarDateBorder border);
	void bmx_wxcalendardateattr_settextcolour(wxCalendarDateAttr * attr, MaxColour * colour);
	void bmx_wxcalendardateattr_setbackgroundcolour(wxCalendarDateAttr * attr, MaxColour * colour);
	void bmx_wxcalendardateattr_setbordercolour(wxCalendarDateAttr * attr, MaxColour * colour);
	void bmx_wxcalendardateattr_setfont(wxCalendarDateAttr * attr, MaxFont * font);
	void bmx_wxcalendardateattr_setborder(wxCalendarDateAttr * attr, wxCalendarDateBorder border);
	void bmx_wxcalendardateattr_setholidy(wxCalendarDateAttr * attr, bool holiday);
	bool bmx_wxcalendardateattr_hastextcolour(wxCalendarDateAttr * attr);
	bool bmx_wxcalendardateattr_hasbackgroundcolour(wxCalendarDateAttr * attr);
	bool bmx_wxcalendardateattr_hasbordercolour(wxCalendarDateAttr * attr);
	bool bmx_wxcalendardateattr_hasfont(wxCalendarDateAttr * attr);
	bool bmx_wxcalendardateattr_hasborder(wxCalendarDateAttr * attr);
	bool bmx_wxcalendardateattr_isholiday(wxCalendarDateAttr * attr);
	MaxColour * bmx_wxcalendardateattr_gettextcolour(wxCalendarDateAttr * attr);
	MaxColour * bmx_wxcalendardateattr_getbackgroundcolour(wxCalendarDateAttr * attr);
	MaxColour * bmx_wxcalendardateattr_getbordercolour(wxCalendarDateAttr * attr);
	MaxFont * bmx_wxcalendardateattr_getfont(wxCalendarDateAttr * attr);
	wxCalendarDateBorder bmx_wxcalendardateattr_getborder(wxCalendarDateAttr * attr);

	int bmx_wxcalendarctrl_geteventtype(int type);

	void bmx_wxcalendarctrl_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCalendarCtrl : public wxCalendarCtrl
{
public:
	MaxCalendarCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, MaxDateTime * date, int x, int y,
		int w, int h, long style);
	MaxCalendarCtrl();
	~MaxCalendarCtrl();

	void MaxBind(BBObject * handle);
private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCalendarCtrlXmlHandler : public wxCalendarCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxCalendarCtrlXmlHandler)

public:
    MaxCalendarCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
