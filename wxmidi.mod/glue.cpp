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

// ---------------------------------------------------------------------------------------



// *********************************************


wxMidiSystem * bmx_wxmidisystem_getinstance() {
	return wxMidiSystem::GetInstance();
}

wxMidiTimestamp bmx_wxmidisystem_gettime(wxMidiSystem * sys) {
	return sys->GetTime();
}

BBString * bmx_wxmidisystem_geterrortext(wxMidiSystem * sys, wxMidiError errnum) {
	return bbStringFromWxString(sys->GetErrorText(errnum));
}

BBString * bmx_wxmidisystem_gethosterrortext(wxMidiSystem * sys) {
	return bbStringFromWxString(sys->GetHostErrorText());
}

int bmx_wxmidisystem_countdevices(wxMidiSystem * sys) {
	return sys->CountDevices();
}

wxMidiInDevice * bmx_wxmidiindevice_create(wxMidiDeviceID device) {
	return new wxMidiInDevice(device);
}

wxMidiError bmx_wxmidiindevice_open(wxMidiInDevice * in) {
	return in->Open();
}

void bmx_wxmidiindevice_flush(wxMidiInDevice * in) {
	in->Flush();
}

wxMidiError bmx_wxmidiindevice_poll(wxMidiInDevice * in) {
	return in->Poll();
}

wxMidiMessage * bmx_wxmidiindevice_read(wxMidiInDevice * in, wxMidiError * error) {
	return in->Read(error);
}

wxMidiError bmx_wxmidiindevice_setfilter(wxMidiInDevice * in, long filters) {
	return in->SetFilter(filters);
}

wxMidiError bmx_wxmidiindevice_setchannelmask(wxMidiInDevice * in, long mask) {
	return in->SetChannelMask(mask);
}

wxMidiError bmx_wxmidiindevice_startlistening(wxMidiInDevice * in, wxWindow * window, unsigned long pollingRate) {
	return in->StartListening(window, pollingRate);
}

wxMidiError bmx_wxmidiindevice_stoplistening(wxMidiInDevice * in) {
	return in->StopListening();
}

wxMidiOutDevice * bmx_wxmidioutdevice_create(wxMidiDeviceID device) {
	return new wxMidiOutDevice(device);
}

wxMidiError bmx_wxmidioutdevice_abort(wxMidiOutDevice * out) {
	return out->Abort();
}

wxMidiError bmx_wxmidioutdevice_allsoundsoff(wxMidiOutDevice * out) {
	return out->AllSoundsOff();
}

wxMidiError bmx_wxmidioutdevice_noteon(wxMidiOutDevice * out, int channel, int note, int velocity) {
	return out->NoteOn(channel, note, velocity);
}

wxMidiError bmx_wxmidioutdevice_noteoff(wxMidiOutDevice * out, int channel, int note, int velocity) {
	return out->NoteOff(channel, note, velocity);
}

wxMidiError bmx_wxmidioutdevice_open(wxMidiOutDevice * out, long latency) {
	return out->Open(latency);
}

wxMidiError bmx_wxmidioutdevice_programchange(wxMidiOutDevice * out, int channel, int instrument) {
	return out->ProgramChange(channel, instrument);
}

wxMidiError bmx_wxmidioutdevice_writeshort(wxMidiOutDevice * out, wxMidiShortMessage * msg) {
	return out->Write(msg);
}

wxMidiError bmx_wxmidioutdevice_writesysex(wxMidiOutDevice * out, wxMidiSysExMessage * msg) {
	out->Write(msg);
}

wxMidiError bmx_wxmidioutdevice_writebytes(wxMidiOutDevice * out, wxByte * bytes, wxMidiTimestamp when) {
	out->Write(bytes, when);
}


void bmx_wxmidimessage_free(wxMidiMessage * msg) {
	delete msg;
}

void bmx_wxmidimessage_settimestamp(wxMidiMessage * msg, long timestamp) {
	msg->SetTimestamp(timestamp);
}

wxMidiTimestamp bmx_wxmidimessage_gettimestamp(wxMidiMessage * msg) {
	return msg->GetTimestamp();
}

wxMidiMsgType bmx_wxmidimessage_gettype(wxMidiMessage * msg) {
	return msg->GetType();
}

int bmx_wxmidimessage_getstatus(wxMidiMessage * msg) {
	return static_cast<int>(msg->GetStatus());
}

wxMidiShortMessage * bmx_wxmidishortmessage_create(int status, int data1, int data2) {
	return new wxMidiShortMessage(static_cast<wxByte>(status), static_cast<wxByte>(data1), static_cast<wxByte>(data2));
}

int bmx_wxmidishortmessage_getdata1(wxMidiShortMessage * msg) {
	return static_cast<int>(msg->GetData1());
}

int bmx_wxmidishortmessage_getdata2(wxMidiShortMessage * msg) {
	return static_cast<int>(msg->GetData2());
}

wxMidiSysExMessage * bmx_wxmidisysexmessage_create(wxByte * msg, wxMidiTimestamp timestamp) {
	return new wxMidiSysExMessage(msg, timestamp);
}

wxMidiError bmx_wxmidisysexmessage_error(wxMidiSysExMessage * msg) {
	return msg->Error();
}

BBArray * bmx_wxmidisysexmessage_getmessage(wxMidiSysExMessage * msg) {
	int n= msg->Length();
	wxByte * message = msg->GetMessage();
	BBArray *p=bbArrayNew1D( "b",n );
	char *s=(char*)BBARRAYDATA( p,p->dims );
	for( int i=0;i<n;++i ){
		s[i]=message[i];
	}
	return p;
}

void bmx_wxmididevice_free(wxMidiDevice * device) {
	delete device;
}

wxMidiError bmx_wxmididevice_close(wxMidiDevice * device) {
	return device->Close();
}

BBString * bmx_wxmididevice_devicename(wxMidiDevice * device) {
	return bbStringFromWxString(device->DeviceName());
}

BBString *bmx_wxmididevice_interfaceused(wxMidiDevice * device) {
	return bbStringFromWxString(device->InterfaceUsed());
}

bool bmx_wxmididevice_isinputport(wxMidiDevice * device) {
	return device->IsInputPort();
}

bool bmx_wxmididevice_isoutputport(wxMidiDevice * device) {
	return device->IsOutputPort();
}

bool bmx_wxmididevice_hashosterror(wxMidiDevice * device) {
	return device->HasHostError();
}


int bmx_wxmidi_geteventtype(int type) {
	switch(type) {
		case -650: return wxEVT_MIDI_INPUT;
	}
	
	return 0;
}

BBString * bmx_wxmidi_version() {
	return bbStringFromWxString(wxMIDI_VERSION);
}

wxMidiDatabaseGM * bmx_wxmididatabasegm_getinstance() {
	return wxMidiDatabaseGM::GetInstance();
}

void bmx_wxmididatabasegm_populatewithinstruments(wxMidiDatabaseGM * gm, wxControlWithItems * ctrl, int section, int nInstr) {
	gm->PopulateWithInstruments(ctrl, section, nInstr);
}

void bmx_wxmididatabasegm_populatewithpercusioninstr(wxMidiDatabaseGM * gm, wxControlWithItems * ctrl, int iSel) {
	gm->PopulateWithPercusionInstr(ctrl, iSel);
}

int bmx_wxmididatabasegm_populatewithsections(wxMidiDatabaseGM * gm, wxControlWithItems * ctrl, int nSelInstr) {
	return gm->PopulateWithSections(ctrl, nSelInstr);
}

void bmx_wxmididatabasegm_populatewithallinstruments(wxMidiDatabaseGM * gm, wxControlWithItems * ctrl, int nInstr) {
	gm->PopulateWithAllInstruments(ctrl, nInstr);
}

int bmx_wxmididatabasegm_getnumsections(wxMidiDatabaseGM * gm) {
	return gm->GetNumSections();
}

int bmx_wxmididatabasegm_getnuminstrumentsinsection(wxMidiDatabaseGM * gm, int sect) {
	return gm->GetNumInstrumentsInSection(sect);
}

int bmx_wxmididatabasegm_getinstrfromsection(wxMidiDatabaseGM * gm, int sect, int i) {
	return gm->GetInstrFromSection(sect, i);
}

BBString * bmx_wxmididatabasegm_getinstrumentname(wxMidiDatabaseGM * gm, int nInstr) {
	return bbStringFromWxString(gm->GetInstrumentName(nInstr));
}

BBString * bmx_wxmididatabasegm_getsectionname(wxMidiDatabaseGM * gm, int sect) {
	return bbStringFromWxString(gm->GetSectionName(sect));
}


