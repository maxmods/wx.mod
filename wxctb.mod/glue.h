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

#include "wxglue.h"
#include "wx/ctb-0.13/serport.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	wxSerialPort * bmx_wxserialport_create();
	int bmx_wxserialport_changelinestate(wxSerialPort * port, wxSerialLineState flags);
	int bmx_wxserialport_clrlinestate(wxSerialPort * port, wxSerialLineState flags);
	int bmx_wxserialport_getlinestate(wxSerialPort * port);
	int bmx_wxserialport_ioctl(wxSerialPort * port, int cmd, void * args);
	int bmx_wxserialport_isopen(wxSerialPort * port);
	int bmx_wxserialport_read(wxSerialPort * port, char * buffer, int size);
	int bmx_wxserialport_sendbreak(wxSerialPort * port, int duration);
	int bmx_wxserialport_setbaudrate(wxSerialPort * port, wxBaud baudRate);
	int bmx_wxserialport_setlinestate(wxSerialPort * port, wxSerialLineState flags);
	int bmx_wxserialport_write(wxSerialPort * port, char * buffer, int size);
	void bmx_wxserialport_free(wxSerialPort * port);

	int bmx_wxiobase_close(wxIOBase * base);
	int bmx_wxiobase_open(wxIOBase * base, BBString * deviceName, void * dcs);
	int bmx_wxiobase_putback(wxIOBase * base, int chr);
	int bmx_wxiobase_readuntileos(wxIOBase * base, char * buffer, int * bytesRead, BBString * eos, long timeout, int quota);
	int bmx_wxiobase_readv(wxIOBase * base, char * buffer, int size, int * timeoutFlag, bool nice);
	int bmx_wxiobase_writev(wxIOBase * base, char * buffer, int size, int * timeoutFlag, bool nice);

	wxSerialPort_DCS * bmx_wxserialportdcs_create();
	BBString * bmx_wxserialportdcs_getsettings(wxSerialPort_DCS * dcs);
	void bmx_wxserialportdcs_setbaud(wxSerialPort_DCS * dcs, wxBaud baud);
	void bmx_wxserialportdcs_setparity(wxSerialPort_DCS * dcs, wxParity 	parity);
	void bmx_wxserialportdcs_setwordlen(wxSerialPort_DCS * dcs, int wordLen);
	void bmx_wxserialportdcs_setstopbits(wxSerialPort_DCS * dcs, int stopBits);
	void bmx_wxserialportdcs_enablertscts(wxSerialPort_DCS * dcs, bool value);
	void bmx_wxserialportdcs_enablexonxoff(wxSerialPort_DCS * dcs, bool value);
	void bmx_wxserialportdcs_delete(wxSerialPort_DCS * dcs);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

