/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

#ifndef _WX_MAX_COMMANDLINKBUTTON_H_
#define _WX_MAX_COMMANDLINKBUTTON_H_

#include "wxglue.h"
#include "wx/commandlinkbutton.h"
#include "wx/xrc/xh_cmdlinkbn.h"
#include "wx/xml/xml.h"

class MaxCommandLinkButton;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxcommandlinkbutton_wxCommandLinkButton__xrcNew)(wxCommandLinkButton * button);

	MaxCommandLinkButton * bmx_wxcommandlinkbutton_create(BBObject * handle, wxWindow * parent, int id, BBString * mainLabel, BBString * note, int x, int y, int w, int h, int style);
	void bmx_wxcommandlinkbutton_setlabel(wxCommandLinkButton * button, BBString * label);
	BBString * bmx_wxcommandlinkbutton_getlabel(wxCommandLinkButton * button);
	void bmx_wxcommandlinkbutton_setmainlabel(wxCommandLinkButton * button, BBString * mainLabel);
	void bmx_wxcommandlinkbutton_setnote(wxCommandLinkButton * button, BBString * note);
	BBString * bmx_wxcommandlinkbutton_getmainlabel(wxCommandLinkButton * button);
	BBString * bmx_wxcommandlinkbutton_getnote(wxCommandLinkButton * button);

	void bmx_wxcommandlinkbutton_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCommandLinkButton : public wxCommandLinkButton
{
public:
	MaxCommandLinkButton();
	MaxCommandLinkButton(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * mainLabel, BBString * note, int x, int y,
		int w, int h, long style);
	~MaxCommandLinkButton();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCommandLinkButtonXmlHandler : public wxCommandLinkButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxCommandLinkButtonXmlHandler)

public:
    MaxCommandLinkButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
