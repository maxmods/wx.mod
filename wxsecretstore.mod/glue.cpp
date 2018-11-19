/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxSecretStore::MaxSecretStore()
	: secretStore(wxSecretStore::GetDefault())
{
}

wxSecretStore & MaxSecretStore::SecretStore() {
	return secretStore;
}

// ---------------------------------------------------------------------------------------

MaxSecretValue::MaxSecretValue()
	: secretValue()
{
	secretValue = wxSecretValue();
}

MaxSecretValue::MaxSecretValue(wxSecretValue & v)
{
	secretValue = wxSecretValue(v);
}

wxSecretValue & MaxSecretValue::SecretValue() {
	return secretValue;
}


// *********************************************

MaxSecretStore * bmx_wxsecretstore_default() {
	return new MaxSecretStore();
}

void bmx_wxsecretstore_free(MaxSecretStore * store) {
	delete store;
}

int bmx_wxsecretstore_isok(MaxSecretStore * store) {
	return static_cast<int>(store->SecretStore().IsOk());
}

int bmx_wxsecretstore_save(MaxSecretStore * store, BBString * service, BBString * username, MaxSecretValue * password) {
	return static_cast<int>(store->SecretStore().Save(wxStringFromBBString(service), wxStringFromBBString(username), password->SecretValue()));
}

int bmx_wxsecretstore_load(MaxSecretStore * store, BBString * service, BBString ** username, MaxSecretValue * password) {
	wxString u(wxStringFromBBString(*username));
	bool res = store->SecretStore().Load(wxStringFromBBString(service), u, password->SecretValue());
	*username = bbStringFromWxString(u);
	return static_cast<int>(res);
}

int bmx_wxsecretstore_remove(MaxSecretStore * store, BBString * service) {
	return static_cast<int>(store->SecretStore().Delete(wxStringFromBBString(service)));
}

// *********************************************

MaxSecretValue * bmx_wxsecretvalue_create(BBString * secret) {
	wxSecretValue v(wxStringFromBBString(secret));
	return new MaxSecretValue(v);
}

MaxSecretValue * bmx_wxsecretvalue_createempty() {
	return new MaxSecretValue();
}

MaxSecretValue * bmx_wxsecretvalue_createwithdata(int size, void * data) {
	wxSecretValue v(static_cast<size_t>(size), data);
	return new MaxSecretValue(v);
}

void bmx_wxsecretvalue_free(MaxSecretValue * value) {
	delete value;
}

int bmx_wxsecretvalue_isok(MaxSecretValue * value) {
	return static_cast<int>(value->SecretValue().IsOk());
}

int bmx_wxsecretvalue_getsize(MaxSecretValue * value) {
	return static_cast<int>(value->SecretValue().GetSize());
}

const void * bmx_wxsecretvalue_getdata(MaxSecretValue * value) {
	return value->SecretValue().GetData();
}

int bmx_wxsecretvalue_isequal(MaxSecretValue * value, MaxSecretValue * other) {
	return static_cast<int>(value->SecretValue() == other->SecretValue());
}

void bmx_wxsecretvalue_wipe(int size, void * data) {
	wxSecretValue::Wipe(static_cast<size_t>(size), data);
}

