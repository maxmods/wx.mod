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

#ifndef _WX_MAX_FILECTRL_H_
#define _WX_MAX_FILECTRL_H_

#include "wxglue.h"
#include "wx/filectrl.h"
#include "wx/xrc/xh_filectrl.h"
#include "wx/xml/xml.h"

class MaxFileCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxfilectrl_wxFileCtrl__xrcNew(wxFileCtrl * control);

	MaxFileCtrl * bmx_wxfilectrl_create(BBObject * handle, wxWindow * parent, int id, BBString * defaultDirectory, BBString * defaultFilename, BBString * wildcard, int x, int y, int w, int h, int style);
	BBString * bmx_wxfilectrl_getdirectory(wxFileCtrl * control);
	BBString * bmx_wxfilectrl_getfilename(wxFileCtrl * control);
	BBArray * bmx_wxfilectrl_getfilenames(wxFileCtrl * control);
	int bmx_wxfilectrl_getfilterindex(wxFileCtrl * control);
	BBString * bmx_wxfilectrl_getpath(wxFileCtrl * control);
	BBArray * bmx_wxfilectrl_getpaths(wxFileCtrl * control);
	BBString * bmx_wxfilectrl_getwildcard(wxFileCtrl * control);
	int bmx_wxfilectrl_setdirectory(wxFileCtrl * control, BBString * directory);
	int bmx_wxfilectrl_setfilename(wxFileCtrl * control, BBString * filename);
	int bmx_wxfilectrl_setpath(wxFileCtrl * control, BBString * path);
	void bmx_wxfilectrl_setfilterindex(wxFileCtrl * control, int index);
	void bmx_wxfilectrl_setwildcard(wxFileCtrl * control, BBString * wildcard);
	void bmx_wxfilectrl_showhidden(wxFileCtrl * control, int show);
	
	BBString * bmx_wxfilectrlevent_getdirectory(wxFileCtrlEvent * event);
	BBString * bmx_wxfilectrlevent_getfile(wxFileCtrlEvent * event);
	BBArray * bmx_wxfilectrlevent_getfiles(wxFileCtrlEvent * event);
	int bmx_wxfilectrlevent_getfilterindex(wxFileCtrlEvent * event);
	void bmx_wxfilectrlevent_setfiles(wxFileCtrlEvent * event, BBArray * files);
	void bmx_wxfilectrlevent_setdirectory(wxFileCtrlEvent * event, BBString * directory);
	void bmx_wxfilectrlevent_setfilterindex(wxFileCtrlEvent * event, int index);

	int bmx_wxfilectrl_geteventtype(int eventType);
	void bmx_wxfilectrl_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileCtrl : public wxFileCtrl
{
public:
	MaxFileCtrl();
	MaxFileCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * defaultDirectory, BBString * defaultFilename, BBString * wildcard, int x, int y,
		int w, int h, long style);
	~MaxFileCtrl();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileCtrlXmlHandler : public wxFileCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxFileCtrlXmlHandler)

public:
    MaxFileCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
