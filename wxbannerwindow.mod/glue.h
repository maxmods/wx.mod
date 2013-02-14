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

#ifndef _WX_MAX_BANNERWINDOW_H_
#define _WX_MAX_BANNERWINDOW_H_

#include "wxglue.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/bannerwindow.h"
#include "wx/xrc/xh_bannerwindow.h"
#include "wx/xml/xml.h"

class MaxBannerWindow;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxbannerwindow_wxBannerWindow__xrcNew(wxBannerWindow * banner);

	MaxBannerWindow * bmx_wxbannerwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int dir, int x, int y,
		int w, int h, long style);
	void bmx_wxbannerwindow_setbitmap(wxBannerWindow * banner, MaxBitmap * bitmap);
	void bmx_wxbannerwindow_settext(wxBannerWindow * banner, BBString * title, BBString * message);
	void bmx_wxbannerwindow_setgradient(wxBannerWindow * banner, MaxColour * colStart, MaxColour * colEnd);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBannerWindow : public wxBannerWindow
{
public:
	MaxBannerWindow();
	MaxBannerWindow(BBObject * handle, wxWindow * parent, wxWindowID id, wxDirection dir, int x, int y,
		int w, int h, long style);
	~MaxBannerWindow();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBannerWindowXmlHandler : public wxBannerWindowXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxBannerWindowXmlHandler)

public:
    MaxBannerWindowXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
