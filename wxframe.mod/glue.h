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
#include "../wxstatusbar.mod/glue.h"
#include "../wxtoolbar.mod/glue.h"
#include "../wxmenubar.mod/glue.h"
#include "wx/xrc/xh_frame.h"
#include "wx/xml/xml.h"

class MaxFrame;


extern "C" {

#include <blitz.h>

	int _wx_wxtoplevelwindow_wxTopLevelWindow__myShouldPreventAppExit(void * window);
	BBObject * _wx_wxframe_wxFrame__xrcNew(wxFrame * frame);

	MaxFrame * bmx_wxframe_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, BBString * title,
		int x, int y, int w, int h, long style);
	void bmx_wxframe_setmenubar(wxFrame * frame, MaxMenuBar * menubar);
	MaxStatusBar * bmx_wxframe_createstatusbar(wxFrame * frame, int number, long style, wxWindowID id);
	void bmx_wxframe_setstatustext(wxFrame * frame, BBString * text, int number);
	wxMenuBar * bmx_wxframe_getmenubar(wxFrame * frame);
	void bmx_wxframe_setstatusbar(wxFrame * frame, wxStatusBar * statusbar);
	wxStatusBar * bmx_wxframe_getstatusbar(wxFrame * frame);
	void bmx_wxframe_positionstatusbar(MaxFrame * frame);

	wxToolBar * bmx_wxframe_createtoolbar(wxFrame * frame, long style, wxWindowID id);
	wxToolBar * bmx_wxframe_gettoolbar(wxFrame * frame);
	void bmx_wxframe_settoolbar(wxFrame * frame, wxToolBar * toolbar);
	void bmx_wxframe_sendsizeevent(wxFrame * frame);
	void bmx_wxframe_processcommand(wxFrame * frame, int id);
	void bmx_wxframe_setstatusbarpane(wxFrame * frame, int n);

	void bmx_wxframe_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxFrame : public wxFrame
{
public:
	MaxFrame();
	MaxFrame(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& title, int x,
		int y, int w, int h, long style);
	~MaxFrame();
		
	virtual MaxStatusBar * OnCreateStatusBar(int number, long style, wxWindowID id, const wxString& name);
	virtual MaxToolBar * OnCreateToolBar(long style, wxWindowID id, const wxString& name);

	virtual bool ShouldPreventAppExit() const {
		return static_cast<bool>(_wx_wxtoplevelwindow_wxTopLevelWindow__myShouldPreventAppExit(wxfind(const_cast<wxObject *>((wxObject*)this))));
	}
	
	virtual void PositionStatusBar() {
		wxFrame::PositionStatusBar();
	}
	
	void MaxBind(BBObject * handle);
	
private:
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFrameXmlHandler : public wxFrameXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxFrameXmlHandler)

public:
    MaxFrameXmlHandler();
    virtual wxObject *DoCreateResource();
};


