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


wxSerialPort * bmx_wxserialport_create() {
	return new wxSerialPort();
}

int bmx_wxserialport_changelinestate(wxSerialPort * port, wxSerialLineState flags) {
	return port->ChangeLineState(flags);
}

int bmx_wxserialport_clrlinestate(wxSerialPort * port, wxSerialLineState flags) {
	return port->ClrLineState(flags);
}

int bmx_wxserialport_getlinestate(wxSerialPort * port) {
	return port->GetLineState();
}

int bmx_wxserialport_ioctl(wxSerialPort * port, int cmd, void * args) {
	return port->Ioctl(cmd, args);
}

int bmx_wxserialport_isopen(wxSerialPort * port) {
	return port->IsOpen();
}

int bmx_wxserialport_read(wxSerialPort * port, char * buffer, int size) {
	return port->Read(buffer, size);
}

int bmx_wxserialport_sendbreak(wxSerialPort * port, int duration) {
	return port->SendBreak(duration);
}

int bmx_wxserialport_setbaudrate(wxSerialPort * port, wxBaud baudRate) {
	return port->SetBaudRate(baudRate);
}

int bmx_wxserialport_setlinestate(wxSerialPort * port, wxSerialLineState flags) {
	return port->SetLineState(flags);
}

int bmx_wxserialport_write(wxSerialPort * port, char * buffer, int size) {
	return port->Write(buffer, size);
}

void bmx_wxserialport_free(wxSerialPort * port) {
	delete port;
}


// *********************************************

int bmx_wxiobase_close(wxIOBase * base) {
	return base->Close();
}

int bmx_wxiobase_open(wxIOBase * base, BBString * deviceName, void * dcs) {
	char * p = bbStringToCString( deviceName );
	int ret = base->Open(p, dcs);
	
	bbMemFree( p );
	return ret;
}

int bmx_wxiobase_putback(wxIOBase * base, int chr) {
	return base->PutBack(static_cast<char>(chr));
}

int bmx_wxiobase_readuntileos(wxIOBase * base, char * buffer, int * bytesRead, BBString * eos, long timeout, int quota) {
	char * p = bbStringToCString( eos );
	
	size_t size;
	int ret = base->ReadUntilEOS(buffer, &size, p, timeout, static_cast<char>(quota));
	*bytesRead = static_cast<int>(size);

	bbMemFree( p );
	return ret;
}

int bmx_wxiobase_readv(wxIOBase * base, char * buffer, int size, int * timeoutFlag, bool nice) {
	return base->Readv(buffer, size, timeoutFlag, nice);
}

int bmx_wxiobase_writev(wxIOBase * base, char * buffer, int size, int * timeoutFlag, bool nice) {
	return base->Writev(buffer, size, timeoutFlag, nice);
}

// *********************************************

wxSerialPort_DCS * bmx_wxserialportdcs_create() {
	return new wxSerialPort_DCS();
}

BBString * bmx_wxserialportdcs_getsettings(wxSerialPort_DCS * dcs) {
	return bbStringFromCString(dcs->GetSettings());
}

void bmx_wxserialportdcs_setbaud(wxSerialPort_DCS * dcs, wxBaud baud) {
	dcs->baud = baud;
}

void bmx_wxserialportdcs_setparity(wxSerialPort_DCS * dcs, wxParity 	parity) {
	dcs->parity = parity;
}

void bmx_wxserialportdcs_setwordlen(wxSerialPort_DCS * dcs, int wordLen) {
	dcs->wordlen = static_cast<unsigned char>(wordLen);
}

void bmx_wxserialportdcs_setstopbits(wxSerialPort_DCS * dcs, int stopBits) {
	dcs->stopbits = static_cast<unsigned char>(stopBits);
}

void bmx_wxserialportdcs_enablertscts(wxSerialPort_DCS * dcs, bool value) {
	dcs->rtscts = value;
}

void bmx_wxserialportdcs_enablexonxoff(wxSerialPort_DCS * dcs, bool value) {
	dcs->xonxoff = value;
}

void bmx_wxserialportdcs_delete(wxSerialPort_DCS * dcs) {
	delete dcs;
}


