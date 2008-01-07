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


void bmx_wxconfigbase_dontcreateondemand(wxConfigBase * config) {
	config->DontCreateOnDemand();
}

bool bmx_wxconfigbase_deleteall(wxConfigBase * config) {
	return config->DeleteAll();
}

bool bmx_wxconfigbase_deleteentry(wxConfigBase * config, BBString * key, bool deleteGroupIfEmpty) {
	return config->DeleteEntry(wxStringFromBBString(key), deleteGroupIfEmpty);
}

bool bmx_wxconfigbase_deletegroup(wxConfigBase * config, BBString * key) {
	return config->DeleteGroup(wxStringFromBBString(key));
}

bool bmx_wxconfigbase_exists(wxConfigBase * config, BBString * name) {
	return config->Exists(wxStringFromBBString(name));
}

bool bmx_wxconfigbase_flush(wxConfigBase * config, bool currentOnly) {
	return config->Flush(currentOnly);
}

BBString * bmx_wxconfigbase_getappname(wxConfigBase * config) {
	return bbStringFromWxString(config->GetAppName());
}

wxConfigBase::EntryType bmx_wxconfigbase_getentrytype(wxConfigBase * config, BBString * name) {
	return config->GetEntryType(wxStringFromBBString(name));
}

bool bmx_wxconfigbase_getfirstgroup(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return config->GetFirstGroup(n, *index);
}

bool bmx_wxconfigbase_getfirstentry(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return config->GetFirstEntry(n, *index);
}

bool bmx_wxconfigbase_getnextgroup(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return config->GetNextGroup(n, *index);
}

bool bmx_wxconfigbase_getnextentry(wxConfigBase * config, BBString * name, long * index) {
	wxString n(wxStringFromBBString(name));
	return config->GetNextEntry(n, *index);
}

uint bmx_wxconfigbase_getnumberofentries(wxConfigBase * config, bool recursive) {
	return config->GetNumberOfEntries(recursive);
}

uint bmx_wxconfigbase_getnumberofgroups(wxConfigBase * config, bool recursive) {
	return config->GetNumberOfGroups(recursive);
}

BBString * bmx_wxconfigbase_getpath(wxConfigBase * config) {
	return bbStringFromWxString(config->GetPath());
}

BBString * bmx_wxconfigbase_getvendorname(wxConfigBase * config) {
	return bbStringFromWxString(config->GetVendorName());
}

bool bmx_wxconfigbase_hasentry(wxConfigBase * config, BBString * name) {
	return config->HasEntry(wxStringFromBBString(name));
}

bool bmx_wxconfigbase_hasgroup(wxConfigBase * config, BBString * name) {
	return config->HasGroup(wxStringFromBBString(name));
}

bool bmx_wxconfigbase_isexpandingenvvars(wxConfigBase * config) {
	return config->IsExpandingEnvVars();
}

bool bmx_wxconfigbase_isrecordingdefaults(wxConfigBase * config) {
	return config->IsRecordingDefaults();
}

BBString * bmx_wxconfigbase_readstring(wxConfigBase * config, BBString * key, BBString * defaultValue) {
	return bbStringFromWxString(config->Read(wxStringFromBBString(key), wxStringFromBBString(defaultValue)));
}

int bmx_wxconfigbase_readint(wxConfigBase * config, BBString * key, int defaultValue) {
	return config->Read(wxStringFromBBString(key), defaultValue);
}

bool bmx_wxconfigbase_readbool(wxConfigBase * config, BBString * key, bool defaultValue) {
	return config->Read(wxStringFromBBString(key), defaultValue);
}

double bmx_wxconfigbase_readdouble(wxConfigBase * config, BBString * key, double defaultValue) {
	return config->Read(wxStringFromBBString(key), defaultValue);
}

bool bmx_wxconfigbase_renameentry(wxConfigBase * config, BBString * oldname, BBString * newname) {
	return config-> RenameEntry(wxStringFromBBString(oldname), wxStringFromBBString(newname));
}

bool bmx_wxconfigbase_renamegroup(wxConfigBase * config, BBString * oldname, BBString * newname) {
	return config->RenameGroup(wxStringFromBBString(oldname), wxStringFromBBString(newname));
}

void bmx_wxconfigbase_setexpandenvvars(wxConfigBase * config, bool doIt) {
	config->SetExpandEnvVars(doIt);
}

void bmx_wxconfigbase_setpath(wxConfigBase * config, BBString * path) {
	config->SetPath(wxStringFromBBString(path));
}

void bmx_wxconfigbase_setrecorddefaults(wxConfigBase * config, bool doIt) {
	config->SetRecordDefaults(doIt);
}

bool bmx_wxconfigbase_writestring(wxConfigBase * config, BBString * key, BBString * value) {
	return config->Write(wxStringFromBBString(key), wxStringFromBBString(value));
}

bool bmx_wxconfigbase_writeint(wxConfigBase * config, BBString * key, int value) {
	return config->Write(wxStringFromBBString(key), value);
}

bool bmx_wxconfigbase_writebool(wxConfigBase * config, BBString * key, bool value) {
	return config->Write(wxStringFromBBString(key), value);
}

bool bmx_wxconfigbase_writedouble(wxConfigBase * config, BBString * key, double value) {
	return config->Write(wxStringFromBBString(key), value);
}

