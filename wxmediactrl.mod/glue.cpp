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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxMediaCtrl::MaxMediaCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, wxString filename, int x, int y, int w, int h, long style, wxString backend)
	: wxMediaCtrl(parent, id, filename, wxPoint(x, y), wxSize(w, h), style, backend)
{
	wxbind(this, handle);
}

MaxMediaCtrl::MaxMediaCtrl()
{}

MaxMediaCtrl::~MaxMediaCtrl() {
	wxunbind(this);
}

void MaxMediaCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxMediaCtrl, wxMediaCtrl)
END_EVENT_TABLE()

wxMediaCtrl * bmx_wxmediactrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * filename, int x, int y, int w, int h, long style, BBString * backend) {
	return new MaxMediaCtrl(handle, parent, id, wxStringFromBBString(filename), x, y, w, h, style, wxStringFromBBString(backend));
}

void bmx_wxmediactrl_getbestsize(wxMediaCtrl * ctrl, int * w, int * h) {
	wxSize s(ctrl->GetBestSize());
	*w = s.GetWidth();
	*h = s.GetHeight();
}

double bmx_wxmediactrl_getplaybackrate(wxMediaCtrl * ctrl) {
	return ctrl->GetPlaybackRate();
}

double bmx_wxmediactrl_getvolume(wxMediaCtrl * ctrl) {
	return ctrl->GetVolume();
}

wxMediaState bmx_wxmediactrl_getstate(wxMediaCtrl * ctrl) {
	return ctrl->GetState();
}

void bmx_wxmediactrl_length(wxMediaCtrl * ctrl, BBInt64 * value) {
	*value = ctrl->Length();
}

int bmx_wxmediactrl_load(wxMediaCtrl * ctrl, BBString * filename) {
	return static_cast<int>(ctrl->Load(wxStringFromBBString(filename)));
}

int bmx_wxmediactrl_loaduri(wxMediaCtrl * ctrl, BBString * uri) {
	return static_cast<int>(ctrl->LoadURI(wxStringFromBBString(uri)));
}

int bmx_wxmediactrl_loaduriwithproxy(wxMediaCtrl * ctrl, BBString * uri, BBString * proxy) {
	return static_cast<int>(ctrl->LoadURIWithProxy(wxStringFromBBString(uri), wxStringFromBBString(proxy)));
}

int bmx_wxmediactrl_pause(wxMediaCtrl * ctrl) {
	return static_cast<int>(ctrl->Pause());
}

int bmx_wxmediactrl_play(wxMediaCtrl * ctrl) {
	return static_cast<int>(ctrl->Play());
}

void bmx_wxmediactrl_seek(wxMediaCtrl * ctrl, BBInt64 where, wxSeekMode mode, BBInt64 * value) {
	*value = ctrl->Seek(where, mode);
}

int bmx_wxmediactrl_setplaybackrate(wxMediaCtrl * ctrl, double rate) {
	return static_cast<int>(ctrl->SetPlaybackRate(rate));
}

int bmx_wxmediactrl_setvolume(wxMediaCtrl * ctrl, double volume) {
	return static_cast<int>(ctrl->SetVolume(volume));
}

int bmx_wxmediactrl_showplayercontrols(wxMediaCtrl * ctrl, wxMediaCtrlPlayerControls flags) {
	return static_cast<int>(ctrl->ShowPlayerControls(flags));
}

int bmx_wxmediactrl_stop(wxMediaCtrl * ctrl) {
	return static_cast<int>(ctrl->Stop());
}

void bmx_wxmediactrl_tell(wxMediaCtrl * ctrl, BBInt64 * value) {
	*value = ctrl->Tell();
}



int bmx_wxmediactrl_geteventtype(int type) {
	switch(type) {
		case 13000: return wxEVT_MEDIA_FINISHED;
		case 13001: return wxEVT_MEDIA_STOP;
		case 13002: return wxEVT_MEDIA_LOADED;
		case 13003: return wxEVT_MEDIA_STATECHANGED;
		case 13004: return wxEVT_MEDIA_PLAY;
		case 13005: return wxEVT_MEDIA_PAUSE;
	}
	
	return 0;
}
