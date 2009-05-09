/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxProcess::MaxProcess(BBObject * handle, wxEvtHandler * parent, int id)
	: maxHandle(handle), wxProcess(parent, id)
{
	wxbind(this, handle);
}

MaxProcess::MaxProcess(BBObject * handle, int flags)
	: maxHandle(handle), wxProcess(flags)
{
	wxbind(this, handle);
}

MaxProcess::~MaxProcess() {
	wxunbind(this);
}

void MaxProcess::OnTerminate(int pid, int status) {
	_wx_wxprocess_wxProcess__OnTerminate(maxHandle, pid, status);
}

void MaxProcess::OnTerminate_default(int pid, int status) {
	wxProcess::OnTerminate(pid, status);
}


// *********************************************


wxProcess * bmx_wxprocess_create(BBObject * handle, wxEvtHandler * parent, int id) {
	return new MaxProcess(handle, parent, id);
}

wxProcess * bmx_wxprocess_createwithflags(BBObject * handle, int flags) {
	return new MaxProcess(handle, flags);
}

void bmx_wxprocess_closeoutput(wxProcess * process) {
	process->CloseOutput();
}

void bmx_wxprocess_detach(wxProcess * process) {
	process->Detach();
}

wxInputStream * bmx_wxprocess_geterrorstream(wxProcess * process) {
	return process->GetErrorStream();
}

wxInputStream * bmx_wxprocess_getintputstream(wxProcess * process) {
	return process->GetInputStream();
}

wxOutputStream * bmx_wxprocess_getoutputstream(wxProcess * process) {
	return process->GetOutputStream();
}

bool bmx_wxprocess_iserroravailable(wxProcess * process) {
	return process->IsErrorAvailable();
}

bool bmx_wxprocess_isinputavailable(wxProcess * process) {
	return process->IsInputAvailable();
}

bool bmx_wxprocess_isinputopened(wxProcess * process) {
	return process->IsInputOpened();
}

wxKillError bmx_wxprocess_kill(int pid, wxSignal signal, int flags) {
	return wxProcess::Kill(pid, signal, flags);
}

bool bmx_wxprocess_exists(int pid) {
	return wxProcess::Exists(pid);
}

wxProcess * bmx_wxprocess_open(BBString * cmd, int flags) {
	return wxProcess::Open(wxStringFromBBString(cmd), flags); 
}

int bmx_wxprocess_getpid(wxProcess * process) {
	return process->GetPid();
}

void bmx_wxprocess_redirect(wxProcess * process) {
	process->Redirect();
}

void bmx_wxprocess_free(wxProcess * process) {
	delete process;
}

void bmx_wxprocess_onterminate(MaxProcess * process, int pid, int status) {
	process->OnTerminate_default(pid, status);
}

// *********************************************

bool bmx_wxshell(BBString * command) {
	if (command == &bbEmptyString) {
		return wxShell();
	} else {
		return wxShell(wxStringFromBBString(command));
	}
}

#ifdef __APPLE__
OSStatus SendAppleEventToSystemProcess(AEEventID EventToSend)
{
    AEAddressDesc targetDesc;
    static const ProcessSerialNumber kPSNOfSystemProcess = { 0, kSystemProcess };
    AppleEvent eventReply = {typeNull, NULL};
    AppleEvent appleEventToSend = {typeNull, NULL};

    OSStatus error = noErr;

    error = AECreateDesc(typeProcessSerialNumber, &kPSNOfSystemProcess,
                                            sizeof(kPSNOfSystemProcess), &targetDesc);

    if (error != noErr)
    {
        return(error);
    }

    error = AECreateAppleEvent(kCoreEventClass, EventToSend, &targetDesc,
                   kAutoGenerateReturnID, kAnyTransactionID, &appleEventToSend);

    AEDisposeDesc(&targetDesc);
    if (error != noErr)
    {
        return(error);
    }

    error = AESend(&appleEventToSend, &eventReply, kAENoReply,
                  kAENormalPriority, kAEDefaultTimeout, NULL, NULL);

    AEDisposeDesc(&appleEventToSend);
    if (error != noErr)
    {
        return(error);
    }

    AEDisposeDesc(&eventReply);

    return(error);
}
#endif

bool bmx_wxshutdown(wxShutdownFlags flags) {
#ifndef __APPLE__
	return wxShutdown(flags);
#else
	OSStatus error = noErr;

	if (flags == wxSHUTDOWN_REBOOT) {
		error = SendAppleEventToSystemProcess(kAERestart);
	} else {
		error = SendAppleEventToSystemProcess(kAEShutDown);
	}
	return (error == noErr);
#endif
}

unsigned long bmx_wxgetprocessid() {
	return wxGetProcessId();
}

void bmx_wxexit() {
	wxExit();
}

int bmx_wxkill(long pid, wxSignal signal, wxKillError * rc, int flags) {
	return wxKill(pid, signal, rc, flags);
}

long bmx_wxexecute(BBString * command, int sync, wxProcess * callback) {
	if (callback) {
		return wxExecute(wxStringFromBBString(command), sync, callback);
	} else {
		return wxExecute(wxStringFromBBString(command), sync);
	}
}



int bmx_wxprocess_geteventtype(int type) {
	switch(type) {
		case -440: return wxEVT_END_PROCESS;
	}
	
	return 0;
}

int bmx_wxprocessevent_getpid(wxProcessEvent & event) {
	return event.GetPid();
}

int bmx_wxprocessevent_getexitcode(wxProcessEvent & event) {
	return event.GetExitCode();
}
