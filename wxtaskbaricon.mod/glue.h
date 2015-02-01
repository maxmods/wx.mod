/*
  Copyright (c) 2007-2015 Bruce A Henderson & Oliver Skawronek
 
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
#include "wx/taskbar.h"
#include "../wxicon.mod/glue.h"

class MaxTaskBarIcon;

extern "C" {

#include <blitz.h>

	wxMenu * CB_PREF(wx_wxtaskbaricon_wxTaskBarIcon__CreatePopupMenu)(BBObject * handle);

	MaxTaskBarIcon * bmx_wxtaskbaricon_create(BBObject * handle, int iconType);
	int bmx_wxtaskbaricon_isiconinstalled(wxTaskBarIcon * taskBarIcon);
	int bmx_wxtaskbaricon_isok(wxTaskBarIcon * taskBarIcon);
	int bmx_wxtaskbaricon_popupmenu(wxTaskBarIcon * taskBarIcon, wxMenu * menu);
	int bmx_wxtaskbaricon_removeicon(wxTaskBarIcon * taskBarIcon);
	int bmx_wxtaskbaricon_seticon(wxTaskBarIcon * taskBarIcon, MaxIcon * icon, BBString * tooltip);
	void bmx_wxtaskbaricon_free(wxTaskBarIcon * taskBarIcon);
	int bmx_wxtaskbaricon_isavailable();
	
	int bmx_wxtaskbariconevent_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxTaskBarIcon : public wxTaskBarIcon
{
public:
	MaxTaskBarIcon(BBObject * handle, int iconType);
	~MaxTaskBarIcon();

protected:
    wxMenu * CreatePopupMenu();

private:
	BBObject * maxHandle;


};

