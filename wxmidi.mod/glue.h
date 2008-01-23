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

#include "wxglue.h"
#include "wxMidi.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	wxMidiSystem * bmx_wxmidisystem_getinstance();
	wxMidiTimestamp bmx_wxmidisystem_gettime(wxMidiSystem * sys);
	BBString * bmx_wxmidisystem_geterrortext(wxMidiSystem * sys, wxMidiError errnum);
	BBString * bmx_wxmidisystem_gethosterrortext(wxMidiSystem * sys);
	int bmx_wxmidisystem_countdevices(wxMidiSystem * sys);

	wxMidiError bmx_wxmidiindevice_open(wxMidiInDevice * in);
	void bmx_wxmidiindevice_flush(wxMidiInDevice * in);
	wxMidiError bmx_wxmidiindevice_poll(wxMidiInDevice * in);
	wxMidiMessage * bmx_wxmidiindevice_read(wxMidiInDevice * in, wxMidiError * error);
	wxMidiError bmx_wxmidiindevice_setfilter(wxMidiInDevice * in, long filters);
	wxMidiError bmx_wxmidiindevice_setchannelmask(wxMidiInDevice * in, long mask);
	wxMidiError bmx_wxmidiindevice_startlistening(wxMidiInDevice * in, wxWindow * window, unsigned long pollingRate);
	wxMidiError bmx_wxmidiindevice_stoplistening(wxMidiInDevice * in);

	wxMidiError bmx_wxmidioutdevice_abort(wxMidiOutDevice * out);
	wxMidiError bmx_wxmidioutdevice_allsoundsoff(wxMidiOutDevice * out);
	wxMidiError bmx_wxmidioutdevice_noteon(wxMidiOutDevice * out, int channel, int note, int velocity);
	wxMidiError bmx_wxmidioutdevice_noteoff(wxMidiOutDevice * out, int channel, int note, int velocity);
	wxMidiError bmx_wxmidioutdevice_open(wxMidiOutDevice * out, long latency);
	wxMidiError bmx_wxmidioutdevice_programchange(wxMidiOutDevice * out, int channel, int instrument);
	wxMidiError bmx_wxmidioutdevice_writeshort(wxMidiOutDevice * out, wxMidiShortMessage * msg);
	wxMidiError bmx_wxmidioutdevice_writesysex(wxMidiOutDevice * out, wxMidiSysExMessage * msg);
	wxMidiError bmx_wxmidioutdevice_writebytes(wxMidiOutDevice * out, wxByte * bytes, wxMidiTimestamp when);

	void bmx_wxmidimessage_free(wxMidiMessage * msg);
	void bmx_wxmidimessage_settimestamp(wxMidiMessage * msg, long timestamp);
	wxMidiTimestamp bmx_wxmidimessage_gettimestamp(wxMidiMessage * msg);
	wxMidiMsgType bmx_wxmidimessage_gettype(wxMidiMessage * msg);
	int bmx_wxmidimessage_getstatus(wxMidiMessage * msg);

	int bmx_wxmidishortmessage_getdata1(wxMidiShortMessage * msg);
	int bmx_wxmidishortmessage_getdata2(wxMidiShortMessage * msg);

	wxMidiError bmx_wxmidisysexmessage_error(wxMidiSysExMessage * msg);
	BBArray * bmx_wxmidisysexmessage_getmessage(wxMidiSysExMessage * msg);

	wxMidiError bmx_wxmididevice_close(wxMidiDevice * device);
	BBString * bmx_wxmididevice_devicename(wxMidiDevice * device);
	BBString *bmx_wxmididevice_interfaceused(wxMidiDevice * device);
	bool bmx_wxmididevice_isinputport(wxMidiDevice * device);
	bool bmx_wxmididevice_isoutputport(wxMidiDevice * device);
	bool bmx_wxmididevice_hashosterror(wxMidiDevice * device);

	int bmx_wxmidi_geteventtype(int type);

	BBString * bmx_wxmidi_version();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

