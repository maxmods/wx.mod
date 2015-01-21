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

#include "wxglue.h"
#include "wx/xrc/xh_bttn.h"
#include "wx/xml/xml.h"

class MaxButton;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxbutton_wxButton__xrcNew)(wxButton * button);

	MaxButton * bmx_wxbutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style);
	BBString * bmx_wxbutton_getlabel(MaxButton * button);
	void bmx_wxbutton_getdefaultsize(MaxButton * button, int * width, int * height);
	void bmx_wxbutton_setdefault(MaxButton * button);
	void bmx_wxbutton_setlabel(MaxButton * button, BBString * label);
	
	int bmx_wxbutton_geteventtype(int type);

	void bmx_wxbutton_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxButton : public wxButton
{
public:
	MaxButton();
	MaxButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style);
	~MaxButton();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxButtonXmlHandler : public wxButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxButtonXmlHandler)

public:
    MaxButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};


