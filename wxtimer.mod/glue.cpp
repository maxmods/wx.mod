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

MaxTimer::MaxTimer(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxTimer::MaxTimer(BBObject * handle, wxEvtHandler * owner, int id)
	: maxHandle(handle), wxTimer(owner, id)
{
	wxbind(this, handle);
}

MaxTimer::~MaxTimer() {
	wxunbind(this);
}

void MaxTimer::Notify() {
	if (m_owner == this) {
		// call our own Notify()
		_wx_wxtimer_wxTimer__notify(maxHandle);
	} else {
		// pass the event to the current owner!
		wxTimerEvent event(m_idTimer, m_milli);
		event.SetEventObject(this);
		(void)m_owner->ProcessEvent(event);
	}
}


// *********************************************

MaxTimer * bmx_wxtimer_create(BBObject * maxHandle, wxEvtHandler * owner, int id) {
	MaxTimer * timer;
	if (owner) {
		timer = new MaxTimer(maxHandle, owner, id);
	} else {
		timer = new MaxTimer(maxHandle);
	}
	return timer;
}

void bmx_wxtimer_free(wxTimer * timer) {
	delete timer;
}

int bmx_wxtimerevent_getinterval(wxTimerEvent & event) {
	return event.GetInterval();
}

int bmx_wxtimer_getinterval(wxTimer * timer) {
	return timer->GetInterval();
}

bool bmx_wxtimer_isoneshot(wxTimer * timer) {
	return timer->IsOneShot();
}

bool bmx_wxtimer_isrunning(wxTimer * timer) {
	return timer->IsRunning();
}

void bmx_wxtimer_setowner(wxTimer * timer, wxEvtHandler * owner, int id) {
	if (owner) {
		timer->SetOwner(owner, id);
	}
}

bool bmx_wxtimer_start(wxTimer * timer, int milli, bool oneshot) {
	return timer->Start(milli, oneshot);
}

void bmx_wxtimer_stop(wxTimer * timer) {
	timer->Stop();
}


int bmx_wxtimer_geteventtype(int type) {
	switch(type) {
		case 80: return wxEVT_TIMER;
	}
	
	return 0;
}

