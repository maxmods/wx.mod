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

#ifndef _WX_MAX_ANIMATIONCTRL_H_
#define _WX_MAX_ANIMATIONCTRL_H_

#include "wxglue.h"
#include "../wxanimation.mod/glue.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/animate.h"
#include "wx/xrc/xh_animatctrl.h"
#include "wx/xml/xml.h"

class MaxAnimationCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxanimationctrl_wxAnimationCtrl__xrcNew(wxAnimationCtrl * anim);

	MaxAnimationCtrl * bmx_wxanimationctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, MaxAnimation * anim, int x, int y,
		int w, int h, long style);
	MaxAnimation * bmx_wxanimationctrl_getanimation(wxAnimationCtrl * anim);
	MaxBitmap * bmx_wxanimationctrl_getinactivebitmap(wxAnimationCtrl * anim);
	int bmx_wxanimationctrl_isplaying(wxAnimationCtrl * anim);
	int bmx_wxanimationctrl_loadfile(wxAnimationCtrl * anim, BBString * file, int animType);
	int bmx_wxanimationctrl_load(wxAnimationCtrl * anim, MaxInputStream * stream, int animType);
	int bmx_wxanimationctrl_play(wxAnimationCtrl * anim);
	void bmx_wxanimationctrl_setanimation(wxAnimationCtrl * anim, MaxAnimation * anim);
	void bmx_wxanimationctrl_setinactivebitmap(wxAnimationCtrl * anim, MaxBitmap * bitmap);
	void bmx_wxanimationctrl_stop(wxAnimationCtrl * anim);

	void bmx_wxanimationctrl_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxAnimationCtrl : public wxAnimationCtrl
{
public:
	MaxAnimationCtrl();
	MaxAnimationCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, MaxAnimation * anim, int x, int y,
		int w, int h, long style);
	~MaxAnimationCtrl();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxAnimationCtrlXmlHandler : public wxAnimationCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxAnimationCtrlXmlHandler)

public:
    MaxAnimationCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
