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
#include "wx/hyperlink.h"
#include "wx/xrc/xh_hyperlink.h"
#include "wx/xml/xml.h"

class MaxHyperlinkCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxhyperlinkctrl_wxHyperlinkCtrl__xrcNew(wxHyperlinkCtrl * hlink);

	MaxHyperlinkCtrl * bmx_wxhyperlinkctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id,
		BBString * label, BBString * url, int x, int y, int w, int h, long style);

	MaxColour * bmx_wxhyperlinkctrl_gethovercolour(wxHyperlinkCtrl * hlink);
	MaxColour * bmx_wxhyperlinkctrl_getnormalcolour(wxHyperlinkCtrl * hlink);
	MaxColour * bmx_wxhyperlinkctrl_getvisitedcolour(wxHyperlinkCtrl * hlink);
	void bmx_wxhyperlinkctrl_sethovercolour(wxHyperlinkCtrl * hlink, MaxColour * colour);
	void bmx_wxhyperlinkctrl_setvisitedcolour(wxHyperlinkCtrl * hlink, MaxColour * colour);
	void bmx_wxhyperlinkctrl_setnormalcolour(wxHyperlinkCtrl * hlink, MaxColour * colour);
	bool bmx_wxhyperlinkctrl_getvisited(wxHyperlinkCtrl * hlink);
	void bmx_wxhyperlinkctrl_setvisited(wxHyperlinkCtrl * hlink, bool visited);
	BBString * bmx_wxhyperlinkctrl_geturl(wxHyperlinkCtrl * hlink);
	void bmx_wxhyperlinkctrl_seturl(wxHyperlinkCtrl * hlink, BBString * url);

	BBString * bmx_wxhyperlinkevent_geturl(wxHyperlinkEvent & event);
	void bmx_wxhyperlinkevent_seturl(wxHyperlinkEvent & event, BBString * url);

	int bmx_wxhyperlinkctrl_geteventtype(int type);

	void bmx_wxhyperlinkctrl_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxHyperlinkCtrl : public wxHyperlinkCtrl
{
public:
	MaxHyperlinkCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label,
		const wxString& url, int x, int y, int w, int h, long style);
	MaxHyperlinkCtrl();
	~MaxHyperlinkCtrl();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxHyperlinkCtrlXmlHandler : public wxHyperlinkCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxHyperlinkCtrlXmlHandler)

public:
    MaxHyperlinkCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
