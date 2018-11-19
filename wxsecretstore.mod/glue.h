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

#include "wxglue.h"
#include "wx/secretstore.h"
	
class MaxSecretStore;
class MaxSecretValue;

extern "C" {

#include <blitz.h>

	MaxSecretStore * bmx_wxsecretstore_default();
	void bmx_wxsecretstore_free(MaxSecretStore * store);

	int bmx_wxsecretstore_isok(MaxSecretStore * store);
	int bmx_wxsecretstore_save(MaxSecretStore * store, BBString * service, BBString * username, MaxSecretValue * password);
	int bmx_wxsecretstore_load(MaxSecretStore * store, BBString * service, BBString ** username, MaxSecretValue * password);
	int bmx_wxsecretstore_remove(MaxSecretStore * store, BBString * service);

	MaxSecretValue * bmx_wxsecretvalue_create(BBString * secret);
	MaxSecretValue * bmx_wxsecretvalue_createempty();
	MaxSecretValue * bmx_wxsecretvalue_createwithdata(int size, void * data);
	void bmx_wxsecretvalue_free(MaxSecretValue * value);

	int bmx_wxsecretvalue_isok(MaxSecretValue * value);
	int bmx_wxsecretvalue_getsize(MaxSecretValue * value);
	const void * bmx_wxsecretvalue_getdata(MaxSecretValue * value);
	int bmx_wxsecretvalue_isequal(MaxSecretValue * value, MaxSecretValue * other);
	void bmx_wxsecretvalue_wipe(int size, void * data);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSecretStore
{
public:
	MaxSecretStore();
	wxSecretStore & SecretStore();

private:
	wxSecretStore secretStore;

};

class MaxSecretValue
{
public:
	MaxSecretValue();
	MaxSecretValue(wxSecretValue & secretValue);
	wxSecretValue & SecretValue();

private:
	wxSecretValue secretValue;

};
