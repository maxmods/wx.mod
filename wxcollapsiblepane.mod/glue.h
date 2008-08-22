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
#include "wx/collpane.h"
#include "wx/xrc/xh_collpane.h"


class MaxCollapsiblePane;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxcollapsiblepane_wxCollapsiblePane__xrcNew(wxCollapsiblePane * pane);

	MaxCollapsiblePane * bmx_wxcollapsiblepane_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style);
	bool bmx_wxcollapsiblepane_iscollapsed(wxCollapsiblePane * pane);
	bool bmx_wxcollapsiblepane_isexpanded(wxCollapsiblePane * pane);
	void bmx_wxcollapsiblepane_collapse(wxCollapsiblePane * pane, bool value);
	void bmx_wxcollapsiblepane_expand(wxCollapsiblePane * pane);
	wxWindow * bmx_wxcollapsiblepane_getpane(wxCollapsiblePane * pane);

	bool bmx_wxcollapsiblepaneevent_getcollapsed(wxCollapsiblePaneEvent & event);
	void bmx_wxcollapsiblepaneevent_setcollapsed(wxCollapsiblePaneEvent & event, bool value);

	int bmx_wxcollapsiblepane_geteventtype(int type);

	void bmx_wxcollapsiblepane_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCollapsiblePane : public wxCollapsiblePane
{
public:
	MaxCollapsiblePane(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style);
	MaxCollapsiblePane();
	~MaxCollapsiblePane();
	
	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCollapsiblePaneXmlHandler : public wxCollapsiblePaneXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxCollapsiblePaneXmlHandler)

public:
    MaxCollapsiblePaneXmlHandler();
    virtual wxObject *DoCreateResource();
	virtual bool CanHandle(wxXmlNode *node);
	
    bool m_isInside;
    wxCollapsiblePane *m_collpane;
};
