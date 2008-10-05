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
#include "wx/fontpicker.h"
#include "wx/xrc/xh_fontpicker.h"


class MaxFontPickerCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxfontpickerctrl_wxFontPickerCtrl__xrcNew(wxFontPickerCtrl * picker);

	MaxFontPickerCtrl * bmx_wxfontpickerctrl_create(BBObject * handle, wxWindow * parent, int id,
		MaxFont * font, int x, int y, int w, int h, long style);
	MaxFont * bmx_wxfontpickerctrl_getselectedfont(wxFontPickerCtrl * picker);
	void bmx_wxfontpickerctrl_setselectedfont(wxFontPickerCtrl * picker, MaxFont * font);
	unsigned int bmx_wxfontpickerctrl_getmaxpointsize(wxFontPickerCtrl * picker);
	void bmx_wxfontpickerctrl_setmaxpointsize(wxFontPickerCtrl * picker, unsigned int value);

	MaxFont * bmx_wxfontpickerevent_getfont(wxFontPickerEvent & event);
	void bmx_wxfontpickerevent_setfont(wxFontPickerEvent & event, MaxFont * font);

	int bmx_wxfontpickerctrl_geteventtype(int type);
	
	void bmx_wxfontpickerctrl_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFontPickerCtrl : public wxFontPickerCtrl
{
public:
	MaxFontPickerCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxFont& font, int x, int y,
		int w, int h, long style);
	MaxFontPickerCtrl();
	~MaxFontPickerCtrl();

	void MaxBind(BBObject * handle);
	
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFontPickerCtrlXmlHandler : public wxFontPickerCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxFontPickerCtrlXmlHandler)

public:
    MaxFontPickerCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
