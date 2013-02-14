/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

MaxSimplebook::MaxSimplebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSimplebook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSimplebook::MaxSimplebook()
{}

MaxSimplebook::~MaxSimplebook() {
	wxunbind(this);
}

void MaxSimplebook::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}


// *********************************************


MaxSimplebook * bmx_wxsimplebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSimplebook(maxHandle, parent, id, x, y, w, h, style);
}

void bmx_wxsimplebook_seteffects(wxSimplebook * simple, int showEffect, int hideEffect) {
	simple->SetEffects((wxShowEffect)showEffect, (wxShowEffect)hideEffect);
}

void bmx_wxsimplebook_seteffect(wxSimplebook * simple, int effect) {
	simple->SetEffect((wxShowEffect)effect);
}

void bmx_wxsimplebook_seteffectstimeouts(wxSimplebook * simple, int showTimeout, int hideTimeout) {
	simple->SetEffectsTimeouts(showTimeout, hideTimeout);
}

void bmx_wxsimplebook_seteffecttimeout(wxSimplebook * simple, int timeout) {
	simple->SetEffectTimeout(timeout);
}

void bmx_wxsimplebook_shownewpage(wxSimplebook * simple, wxWindow * page) {
	simple->ShowNewPage(page);
}

// *********************************************
