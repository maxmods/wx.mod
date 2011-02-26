/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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
#include "wx/radiobut.h"
#include "wx/xrc/xh_radbt.h"


class MaxRadioButton;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxradiobutton_wxRadioButton__xrcNew(wxRadioButton * button);

	MaxRadioButton * bmx_wxradiobutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style);
	bool bmx_wxradiobutton_getvalue(wxRadioButton * button);
	void bmx_wxradiobutton_setvalue(wxRadioButton * button, bool value);

	int bmx_wxradiobutton_geteventtype(int type);

	void bmx_wxradiobutton_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRadioButton : public wxRadioButton
{
public:
	MaxRadioButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style);
	MaxRadioButton();
	~MaxRadioButton();

	void MaxBind(BBObject * handle);

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRadioButtonXmlHandler : public wxRadioButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxRadioButtonXmlHandler)

public:
    MaxRadioButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};
