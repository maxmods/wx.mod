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
#include <wx/tglbtn.h>
#include "wx/xrc/xh_tglbtn.h"

class MaxToggleButton;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxtogglebutton_wxToggleButton__xrcNew(wxToggleButton * button);

	MaxToggleButton * bmx_wxtogglebutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style);
	bool bmx_wxtogglebutton_getvalue(wxToggleButton * button);
	void bmx_wxtogglebutton_setvalue(wxToggleButton * button, bool state);

	int bmx_wxtogglebutton_geteventtype(int type);
	
	void bmx_wxtogglebutton_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToggleButton : public wxToggleButton
{
public:
	MaxToggleButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style);
	MaxToggleButton();
	~MaxToggleButton();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToggleButtonXmlHandler : public wxToggleButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxToggleButtonXmlHandler)

public:
    MaxToggleButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};

