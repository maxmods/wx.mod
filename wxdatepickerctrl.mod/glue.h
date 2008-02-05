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
#include "wx/datectrl.h"
#include "../wxdatetime.mod/glue.h"

class MaxDatePickerCtrl;

extern "C" {

#include <blitz.h>

	wxDatePickerCtrl * bmx_wxdatepickerctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, MaxDateTime * dt, int x, int y, int w, int h, long style);
	void bmx_wxdatepickerctrl_getrange(wxDatePickerCtrl * picker, MaxDateTime * dt1, MaxDateTime * dt2);
	MaxDateTime * bmx_wxdatepickerctrl_getvalue(wxDatePickerCtrl * picker);
//	void bmx_wxdatepickerctrl_setformat(wxDatePickerCtrl * picker, BBString * format);
	void bmx_wxdatepickerctrl_setrange(wxDatePickerCtrl * picker, MaxDateTime * dt1, MaxDateTime * dt2);
	void bmx_wxdatepickerctrl_setvalue(wxDatePickerCtrl * picker, MaxDateTime * dt);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDatePickerCtrl : public wxDatePickerCtrl
{
public:
	MaxDatePickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxDateTime& dt, int x, int y, int w, int h, long style);
	~MaxDatePickerCtrl();

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};
