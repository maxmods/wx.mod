/*
  Copyright (c) 2007 Bruce A Henderson
 
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
#include "wx/timer.h"

class MaxTimer;

extern "C" {

#include <blitz.h>

	void _wx_wxtimer_wxTimer__notify(BBObject * handle);

	MaxTimer * bmx_wxtimer_create(BBObject * maxHandle, wxEvtHandler * owner, int id);
	int bmx_wxtimer_getinterval(MaxTimer * timer);
	bool bmx_wxtimer_isoneshot(MaxTimer * timer);
	bool bmx_wxtimer_isrunning(MaxTimer * timer);
	void bmx_wxtimer_setowner(MaxTimer * timer, wxEvtHandler * owner, int id);
	bool bmx_wxtimer_start(MaxTimer * timer, int milli, bool oneshot);
	void bmx_wxtimer_stop(MaxTimer * timer);

	int bmx_wxtimerevent_getinterval(wxTimerEvent & event);

	int bmx_wxtimer_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTimer : public wxTimer
{
public:
	MaxTimer(BBObject * handle);
	~MaxTimer();
	void Notify();
	
private:
	BBObject * maxHandle;

};

