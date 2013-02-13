/*
  Copyright (c) 2007-2013 Bruce A Henderson & Oliver Skawronek
 
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


MaxTaskBarIcon::MaxTaskBarIcon(BBObject * handle, int iconType)
	: maxHandle(handle), wxTaskBarIcon((wxTaskBarIconType)iconType)
{
	wxbind(this, handle);
}

MaxTaskBarIcon::~MaxTaskBarIcon() {
	wxunbind(this);
}

wxMenu * MaxTaskBarIcon::CreatePopupMenu() {
	return _wx_wxtaskbaricon_wxTaskBarIcon__CreatePopupMenu(maxHandle);
}

// *********************************************


MaxTaskBarIcon * bmx_wxtaskbaricon_create(BBObject * handle, int iconType) {
	return new MaxTaskBarIcon(handle, iconType);
}

bool bmx_wxtaskbaricon_isiconinstalled(wxTaskBarIcon * taskBarIcon) {
	return taskBarIcon->IsIconInstalled();
}

bool bmx_wxtaskbaricon_isok(wxTaskBarIcon * taskBarIcon) {
	return taskBarIcon->IsOk();
}

bool bmx_wxtaskbaricon_removeicon(wxTaskBarIcon * taskBarIcon) {
	return taskBarIcon->RemoveIcon();
}

bool bmx_wxtaskbaricon_seticon(wxTaskBarIcon * taskBarIcon, MaxIcon * icon, BBString * tooltip) {
	return taskBarIcon->SetIcon(icon->Icon(), wxStringFromBBString(tooltip));
}

void bmx_wxtaskbaricon_free(wxTaskBarIcon * taskBarIcon) {
	delete taskBarIcon;
}

bool bmx_wxtaskbaricon_isavailable() {
	return wxTaskBarIcon::IsAvailable();
}

int bmx_wxtaskbariconevent_geteventtype(int type) {
	switch(type) {
		case 1550: return wxEVT_TASKBAR_MOVE;
		case 1551: return wxEVT_TASKBAR_LEFT_DOWN;
		case 1552: return wxEVT_TASKBAR_LEFT_UP;
		case 1553: return wxEVT_TASKBAR_RIGHT_DOWN;
		case 1554: return wxEVT_TASKBAR_RIGHT_UP;
		case 1555: return wxEVT_TASKBAR_LEFT_DCLICK;
		case 1556: return wxEVT_TASKBAR_RIGHT_DCLICK;
	}
	
	return 0;
}

