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

#include "glue.h"


typedef std::map<wxLog*, BBObject*> LogPeerMap;

static LogPeerMap logPeerMap;

void wxlogbind( wxLog *obj, BBObject *peer ) {
	if( !obj || peer==&bbNullObject ) return;
	logPeerMap.insert( std::make_pair( obj,peer ) );
	BBRETAIN( peer );
}

BBObject *wxlogfind( wxLog *obj ){
	if( !obj ) return &bbNullObject;
	LogPeerMap::iterator it = logPeerMap.find( obj );
	if( it != logPeerMap.end() ) return it->second;
	return &bbNullObject;
}

void wxlogunbind(wxLog *obj) {
	BBObject * peer = wxlogfind(obj);
	if (peer != &bbNullObject) {
		logPeerMap.erase(obj);
		BBRELEASE(peer);
	}
}


// ---------------------------------------------------------------------------------------




// *********************************************


void bmx_wxlogerror(BBString * message) {
	wxLogError(_("%s"), wxStringFromBBString(message).c_str());
}

void bmx_wxlogfatalerror(BBString * message) {
	wxLogFatalError(_("%s"), wxStringFromBBString(message).c_str());
}

void bmx_wxlogwarning(BBString * message) {
	wxLogWarning(_("%s"), wxStringFromBBString(message).c_str());
}

void bmx_wxlogmessage(BBString * message) {
	wxLogMessage(_("%s"), wxStringFromBBString(message).c_str());
}

void bmx_wxlogverbose(BBString * message) {
	wxLogVerbose(_("%s"), wxStringFromBBString(message).c_str());
}

void bmx_wxlogstatus(BBString * message, wxFrame * frame) {
	if (frame) {
		wxLogStatus(frame, _("%s"), wxStringFromBBString(message).c_str());
	} else {
		wxLogStatus(_("%s"), wxStringFromBBString(message).c_str());
	}
}

void bmx_wxsafeshowmessage(BBString * message) {
	wxSafeShowMessage(_("%s"), wxStringFromBBString(message).c_str());
}

unsigned long bmx_wxsyserrorcode() {
	return wxSysErrorCode();
}

BBString * bmx_wxsyserrormsg(unsigned long code) {
	return bbStringFromWxString(wxString(wxSysErrorMsg(code)));
}

void bmx_wxlog_delete(wxLog * logger) {
	delete logger;
}

wxLog * bmx_wxlogtextctrl_create(BBObject * handle, wxTextCtrl * textctrl) {
	wxLogTextCtrl * logger = new wxLogTextCtrl(textctrl);
	wxlogbind(logger, handle);
	return logger;
}

wxLog * bmx_wxlog_setactivetarget(wxLog * log) {
	return wxLog::SetActiveTarget(log);
}

void bmx_wxlog_settimestamp(BBString * format) {
	if (!format) {
		wxLog::SetTimestamp(wxStringFromBBString(format).c_str());
	} else {
		wxLog::SetTimestamp(NULL);
	}
}
