/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

wxConfigBase * bmx_wxconfigbase_set(wxConfigBase * config) {
	if (config) {
		return wxConfigBase::Set(config);
	} else {
		return wxConfigBase::Set(NULL);
	}
}

wxConfigBase * bmx_wxconfigbase_get(int onDemand) {
	return wxConfigBase::Get(static_cast<bool>(onDemand));
}


void bmx_wxconfigbase_dontcreateondemand(wxConfigBase * config) {
	config->DontCreateOnDemand();
}

int bmx_wxconfigbase_deleteall(wxConfigBase * config) {
	return static_cast<int>(config->DeleteAll());
}

int bmx_wxconfigbase_deleteentry(wxConfigBase * config, BBString * key, int deleteGroupIfEmpty) {
	return static_cast<int>(config->DeleteEntry(wxStringFromBBString(key), static_cast<bool>(deleteGroupIfEmpty)));
}

int bmx_wxconfigbase_deletegroup(wxConfigBase * config, BBString * key) {
	return static_cast<int>(config->DeleteGroup(wxStringFromBBString(key)));
}

int bmx_wxconfigbase_exists(wxConfigBase * config, BBString * name) {
	return static_cast<int>(config->Exists(wxStringFromBBString(name)));
}

int bmx_wxconfigbase_flush(wxConfigBase * config, int currentOnly) {
	return static_cast<int>(config->Flush(static_cast<bool>(currentOnly)));
}

BBString * bmx_wxconfigbase_getappname(wxConfigBase * config) {
	return bbStringFromWxString(config->GetAppName());
}

wxConfigBase::EntryType bmx_wxconfigbase_getentrytype(wxConfigBase * config, BBString * name) {
	return config->GetEntryType(wxStringFromBBString(name));
}

BBString * bmx_wxconfigbase_getfirstgroup(wxConfigBase * config, long * index, int * cont) {
	wxString n;
	*cont = static_cast<int>(config->GetFirstGroup(n, *index));
	return bbStringFromWxString(n);
}

int bmx_wxconfigbase_getfirstentry(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return static_cast<int>(config->GetFirstEntry(n, *index));
}

BBString * bmx_wxconfigbase_getnextgroup(wxConfigBase * config, long * index, int * cont) {
	wxString n;
	*cont =  static_cast<int>(config->GetNextGroup(n, *index));
	return bbStringFromWxString(n);
}

int bmx_wxconfigbase_getnextentry(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return static_cast<int>(config->GetNextEntry(n, *index));
}

unsigned int bmx_wxconfigbase_getnumberofentries(wxConfigBase * config, int recursive) {
	return config->GetNumberOfEntries(static_cast<bool>(recursive));
}

unsigned int bmx_wxconfigbase_getnumberofgroups(wxConfigBase * config, int recursive) {
	return config->GetNumberOfGroups(static_cast<bool>(recursive));
}

BBString * bmx_wxconfigbase_getpath(wxConfigBase * config) {
	return bbStringFromWxString(config->GetPath());
}

BBString * bmx_wxconfigbase_getvendorname(wxConfigBase * config) {
	return bbStringFromWxString(config->GetVendorName());
}

int bmx_wxconfigbase_hasentry(wxConfigBase * config, BBString * name) {
	return static_cast<int>(config->HasEntry(wxStringFromBBString(name)));
}

int bmx_wxconfigbase_hasgroup(wxConfigBase * config, BBString * name) {
	return static_cast<int>(config->HasGroup(wxStringFromBBString(name)));
}

int bmx_wxconfigbase_isexpandingenvvars(wxConfigBase * config) {
	return static_cast<int>(config->IsExpandingEnvVars());
}

int bmx_wxconfigbase_isrecordingdefaults(wxConfigBase * config) {
	return static_cast<int>(config->IsRecordingDefaults());
}

BBString * bmx_wxconfigbase_readstring(wxConfigBase * config, BBString * key, BBString * defaultValue) {
	return bbStringFromWxString(config->Read(wxStringFromBBString(key), wxStringFromBBString(defaultValue)));
}

int bmx_wxconfigbase_readint(wxConfigBase * config, BBString * key, int defaultValue) {
	return config->Read(wxStringFromBBString(key), defaultValue);
}

int bmx_wxconfigbase_readbool(wxConfigBase * config, BBString * key, int defaultValue) {
	return static_cast<int>(config->Read(wxStringFromBBString(key), static_cast<bool>(defaultValue)));
}

double bmx_wxconfigbase_readdouble(wxConfigBase * config, BBString * key, double defaultValue) {
	return config->Read(wxStringFromBBString(key), defaultValue);
}

int bmx_wxconfigbase_renameentry(wxConfigBase * config, BBString * oldname, BBString * newname) {
	return static_cast<int>(config->RenameEntry(wxStringFromBBString(oldname), wxStringFromBBString(newname)));
}

int bmx_wxconfigbase_renamegroup(wxConfigBase * config, BBString * oldname, BBString * newname) {
	return static_cast<int>(config->RenameGroup(wxStringFromBBString(oldname), wxStringFromBBString(newname)));
}

void bmx_wxconfigbase_setexpandenvvars(wxConfigBase * config, int doIt) {
	config->SetExpandEnvVars(static_cast<bool>(doIt));
}

void bmx_wxconfigbase_setpath(wxConfigBase * config, BBString * path) {
	config->SetPath(wxStringFromBBString(path));
}

void bmx_wxconfigbase_setrecorddefaults(wxConfigBase * config, int doIt) {
	config->SetRecordDefaults(static_cast<bool>(doIt));
}

int bmx_wxconfigbase_writestring(wxConfigBase * config, BBString * key, BBString * value) {
	return static_cast<int>(config->Write(wxStringFromBBString(key), wxStringFromBBString(value)));
}

int bmx_wxconfigbase_writeint(wxConfigBase * config, BBString * key, int value) {
	return static_cast<int>(config->Write(wxStringFromBBString(key), value));
}

int bmx_wxconfigbase_writebool(wxConfigBase * config, BBString * key, int value) {
	return static_cast<int>(config->Write(wxStringFromBBString(key), static_cast<bool>(value)));
}

int bmx_wxconfigbase_writedouble(wxConfigBase * config, BBString * key, double value) {
	return static_cast<int>(config->Write(wxStringFromBBString(key), value));
}

void bmx_wxconfigbase_free(wxConfigBase * config) {
	delete config;
}
