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

#ifndef _WX_MAX_BITMAPBUTTON_H_
#define _WX_MAX_BITMAPBUTTON_H_

#include "wxglue.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/xrc/xh_bmpbt.h"
#include "wx/xml/xml.h"

class MaxBitmapButton;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxbitmapbutton_wxBitmapButton__xrcNew(wxBitmapButton * button);

	MaxBitmapButton * bmx_wxbitmapbutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, MaxBitmap * bitmap, int x, int y,
		int w, int h, long style);

	void bmx_wxbitmapbutton_setbitmaplabel(wxBitmapButton * button, MaxBitmap * bitmap);
	
	MaxBitmap * bmx_wxbitmapbutton_getbitmapdisabled(wxBitmapButton * button);
	MaxBitmap * bmx_wxbitmapbutton_getbitmapfocus(wxBitmapButton * button);
	MaxBitmap * bmx_wxbitmapbutton_getbitmaphover(wxBitmapButton * button);
	MaxBitmap * bmx_wxbitmapbutton_getbitmaplabel(wxBitmapButton * button);
	MaxBitmap * bmx_wxbitmapbutton_getbitmapselected(wxBitmapButton * button);
	void bmx_wxbitmapbutton_setbitmapdisabled(wxBitmapButton * button, MaxBitmap * bitmap);
	void bmx_wxbitmapbutton_setbitmapfocus(wxBitmapButton * button, MaxBitmap * bitmap);
	void bmx_wxbitmapbutton_setbitmaphover(wxBitmapButton * button, MaxBitmap * bitmap);
	void bmx_wxbitmapbutton_setbitmapselected(wxBitmapButton * button, MaxBitmap * bitmap);

	void bmx_wxbitmapbutton_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBitmapButton : public wxBitmapButton
{
public:
	MaxBitmapButton();
	MaxBitmapButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxBitmap& bitmap, int x, int y,
		int w, int h, long style);
	~MaxBitmapButton();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBitmapButtonXmlHandler : public wxBitmapButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxBitmapButtonXmlHandler)

public:
    MaxBitmapButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
