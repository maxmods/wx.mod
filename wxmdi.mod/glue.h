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
#include "wx/mdi.h"
#include "wx/xrc/xh_mdi.h"
#include "wx/xml/xml.h"


class MaxMDIParentFrame;
class MaxMDIChildFrame;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxmdi_wxMDIParentFrame__xrcNew(wxMDIParentFrame * frame);
	BBObject * _wx_wxmdi_wxMDIChildFrame__xrcNew(wxMDIChildFrame * frame);

	wxMDIParentFrame * bmx_wxmdiparentframe_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * title, int x, int y, int w, int h, long style);
	void bmx_wxmdiparentframe_activatenext(wxMDIParentFrame * frame);
	void bmx_wxmdiparentframe_activateprevious(wxMDIParentFrame * frame);
	void bmx_wxmdiparentframe_arrangeicons(wxMDIParentFrame * frame);
	void bmx_wxmdiparentframe_cascade(wxMDIParentFrame * frame);
	void bmx_wxmdiparentframe_getclientsize(wxMDIParentFrame * frame, int * width, int * height);
	wxMDIChildFrame * bmx_wxmdiparentframe_getactivechild(wxMDIParentFrame * frame);
	wxMDIClientWindowBase * bmx_wxmdiparentframe_getclientwindow(wxMDIParentFrame * frame);
#ifdef WIN32
	wxMenu * bmx_wxmdiparentframe_getwindowmenu(wxMDIParentFrame * frame);
	void bmx_wxmdiparentframe_setwindowmenu(wxMDIParentFrame * frame, wxMenu * menu);
#endif
	void bmx_wxmdiparentframe_tile(wxMDIParentFrame * frame, wxOrientation orient);

	wxMDIChildFrame * bmx_wxmdichildframe_create(BBObject * handle, wxMDIParentFrame * parent, wxWindowID id, BBString * title, int x, int y, int w, int h, long style);
	void bmx_wxmdichildframe_activate(wxMDIChildFrame * frame);
	void bmx_wxmdichildframe_maximize(wxMDIChildFrame * frame, int value);
	void bmx_wxmdichildframe_restore(wxMDIChildFrame * frame);

	void bmx_wxmdi_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMDIParentFrame : public wxMDIParentFrame
{
public:
	MaxMDIParentFrame(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y, int w, int h, long style);
	MaxMDIParentFrame();
	~MaxMDIParentFrame();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

class MaxMDIChildFrame : public wxMDIChildFrame
{
public:
	MaxMDIChildFrame(BBObject * handle, wxMDIParentFrame * parent, wxWindowID id, const wxString& title, int x, int y, int w, int h, long style);
	MaxMDIChildFrame();
	~MaxMDIChildFrame();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMdiXmlHandler : public wxMdiXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxMdiXmlHandler)

public:
    MaxMdiXmlHandler();
    virtual wxObject *DoCreateResource();
    wxWindow *CreateFrame();
};

