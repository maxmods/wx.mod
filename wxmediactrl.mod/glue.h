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

#include "wxglue.h"
#include "wx/mediactrl.h"

class MaxMediaCtrl;

extern "C" {

#include <blitz.h>

	wxMediaCtrl * bmx_wxmediactrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * filename, int x, int y, int w, int h, long style, BBString * backend);
	void bmx_wxmediactrl_getbestsize(wxMediaCtrl * ctrl, int * w, int * h);
	double bmx_wxmediactrl_getplaybackrate(wxMediaCtrl * ctrl);
	double bmx_wxmediactrl_getvolume(wxMediaCtrl * ctrl);
	wxMediaState bmx_wxmediactrl_getstate(wxMediaCtrl * ctrl);
	void bmx_wxmediactrl_length(wxMediaCtrl * ctrl, BBInt64 * value);
	int bmx_wxmediactrl_load(wxMediaCtrl * ctrl, BBString * filename);
	int bmx_wxmediactrl_loaduri(wxMediaCtrl * ctrl, BBString * uri);
	int bmx_wxmediactrl_loaduriwithproxy(wxMediaCtrl * ctrl, BBString * uri, BBString * proxy);
	int bmx_wxmediactrl_pause(wxMediaCtrl * ctrl);
	int bmx_wxmediactrl_play(wxMediaCtrl * ctrl);
	void bmx_wxmediactrl_seek(wxMediaCtrl * ctrl, BBInt64 where, wxSeekMode mode, BBInt64 * value);
	int bmx_wxmediactrl_setplaybackrate(wxMediaCtrl * ctrl, double rate);
	int bmx_wxmediactrl_setvolume(wxMediaCtrl * ctrl, double volume);
	int bmx_wxmediactrl_showplayercontrols(wxMediaCtrl * ctrl, wxMediaCtrlPlayerControls flags);
	int bmx_wxmediactrl_stop(wxMediaCtrl * ctrl);
	void bmx_wxmediactrl_tell(wxMediaCtrl * ctrl, BBInt64 * value);


	int bmx_wxmediactrl_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMediaCtrl : public wxMediaCtrl
{
public:
	MaxMediaCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, wxString filename, int x, int y, int w, int h, long style, wxString backend);
	MaxMediaCtrl();
	~ MaxMediaCtrl();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

