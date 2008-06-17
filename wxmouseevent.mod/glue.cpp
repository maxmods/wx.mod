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

bool bmx_wxmouseevent_altdown(wxMouseEvent & event) {
	return event.AltDown();
}

bool bmx_wxmouseevent_button(wxMouseEvent & event, int but) {
	return event.Button(but);
}

bool bmx_wxmouseevent_buttondclick(wxMouseEvent & event, int but) {
	return event.ButtonDClick(but);
}

bool bmx_wxmouseevent_buttondown(wxMouseEvent & event, int but) {
	return event.ButtonDown(but);
}

bool bmx_wxmouseevent_buttonup(wxMouseEvent & event, int but) {
	return event.ButtonUp(but);
}

bool bmx_wxmouseevent_cmddown(wxMouseEvent & event) {
	return event.CmdDown();
}

bool bmx_wxmouseevent_controldown(wxMouseEvent & event) {
	return event.ControlDown();
}

bool bmx_wxmouseevent_dragging(wxMouseEvent & event) {
	return event.Dragging();
}

bool bmx_wxmouseevent_entering(wxMouseEvent & event) {
	return event.Entering();
}

int bmx_wxmouseevent_getbutton(wxMouseEvent & event) {
	return event.GetButton();
}

void bmx_wxmouseevent_getposition(wxMouseEvent & event, long * x, long * y) {
	event.GetPosition(x, y);
}

int bmx_wxmouseevent_getlinesperaction(wxMouseEvent & event) {
	return event.GetLinesPerAction();
}

int bmx_wxmouseevent_getwheelrotation(wxMouseEvent & event) {
	return event.GetWheelRotation();
}

int bmx_wxmouseevent_getwheeldelta(wxMouseEvent & event) {
	return event.GetWheelDelta();
}

int bmx_wxmouseevent_getx(wxMouseEvent & event) {
	return event.GetX();
}

int bmx_wxmouseevent_gety(wxMouseEvent & event) {
	return event.GetY();
}

bool bmx_wxmouseevent_isbutton(wxMouseEvent & event) {
	return event.IsButton();
}

bool bmx_wxmouseevent_ispagescroll(wxMouseEvent & event) {
	return event.IsPageScroll();
}

bool bmx_wxmouseevent_leaving(wxMouseEvent & event) {
	return event.Leaving();
}

bool bmx_wxmouseevent_leftdclick(wxMouseEvent & event) {
	return event.LeftDClick();
}

bool bmx_wxmouseevent_leftdown(wxMouseEvent & event) {
	return event.LeftDown();
}

bool bmx_wxmouseevent_leftisdown(wxMouseEvent & event) {
	return event.LeftIsDown();
}

bool bmx_wxmouseevent_leftup(wxMouseEvent & event) {
	return event.LeftUp();
}

bool bmx_wxmouseevent_metadown(wxMouseEvent & event) {
	return event.MetaDown();
}

bool bmx_wxmouseevent_middledclick(wxMouseEvent & event) {
	return event.MiddleDClick();
}

bool bmx_wxmouseevent_middledown(wxMouseEvent & event) {
	return event.MiddleDown();
}

bool bmx_wxmouseevent_middleisdown(wxMouseEvent & event) {
	return event.MiddleIsDown();
}

bool bmx_wxmouseevent_middleup(wxMouseEvent & event) {
	return event.MiddleUp();
}

bool bmx_wxmouseevent_moving(wxMouseEvent & event) {
	return event.Moving();
}

bool bmx_wxmouseevent_rightdclick(wxMouseEvent & event) {
	return event.RightDClick();
}

bool bmx_wxmouseevent_rightdown(wxMouseEvent & event) {
	return event.RightDown();
}

bool bmx_wxmouseevent_rightisdown(wxMouseEvent & event) {
	return event.RightIsDown();
}

bool bmx_wxmouseevent_rightup(wxMouseEvent & event) {
	return event.RightUp();
}

bool bmx_wxmouseevent_shiftdown(wxMouseEvent & event) {
	return event.ShiftDown();
}

void bmx_wxmouseevent_getlogicalposition(wxMouseEvent & event, MaxDC * dc, int * x, int * y) {
	wxPoint p(event.GetLogicalPosition(*dc->GetDC()));
	*x = p.x;
	*y = p.y;
}


// *********************************************


