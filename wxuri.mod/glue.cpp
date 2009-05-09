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



// *********************************************

wxURI * bmx_wxuri_create(BBString * uri) {
	if (uri != &bbEmptyString) {
		return new wxURI(wxStringFromBBString(uri));
	} else {
		return new wxURI();
	}
}

void bmx_wxuri_delete(wxURI * uri) {
	delete uri;
}

BBString * bmx_wxuri_builduri(wxURI * uri) {
	return bbStringFromWxString(uri->BuildURI());
}

BBString * bmx_wxuri_buildunescapeduri(wxURI * uri) {
	return bbStringFromWxString(uri->BuildUnescapedURI());
}

BBString * bmx_wxuri_getfragment(wxURI * uri) {
	return bbStringFromWxString(uri->GetFragment());
}

wxURIHostType bmx_wxuri_gethostyype(wxURI * uri) {
	return uri->GetHostType();
}

BBString * bmx_wxuri_getpassword(wxURI * uri) {
	return bbStringFromWxString(uri->GetPassword());
}

BBString * bmx_wxuri_getpath(wxURI * uri) {
	return bbStringFromWxString(uri->GetPath());
}

BBString * bmx_wxuri_getport(wxURI * uri) {
	return bbStringFromWxString(uri->GetPort());
}

BBString * bmx_wxuri_getquery(wxURI * uri) {
	return bbStringFromWxString(uri->GetQuery());
}

BBString * bmx_wxuri_getscheme(wxURI * uri) {
	return bbStringFromWxString(uri->GetScheme());
}

BBString * bmx_wxuri_getserver(wxURI * uri) {
	return bbStringFromWxString(uri->GetServer());
}

BBString * bmx_wxuri_getuser(wxURI * uri) {
	return bbStringFromWxString(uri->GetUser());
}

BBString * bmx_wxuri_getuserinfo(wxURI * uri) {
	return bbStringFromWxString(uri->GetUserInfo());
}

bool bmx_wxuri_hasfragment(wxURI * uri) {
	return uri->HasFragment();
}

bool bmx_wxuri_haspath(wxURI * uri) {
	return uri->HasPath();
}

bool bmx_wxuri_hasport(wxURI * uri) {
	return uri->HasPort();
}

bool bmx_wxuri_hasquery(wxURI * uri) {
	return uri->HasQuery();
}

bool bmx_wxuri_hasscheme(wxURI * uri) {
	return uri->HasScheme();
}

bool bmx_wxuri_hasserver(wxURI * uri) {
	return uri->HasServer();
}

bool bmx_wxuri_isreference(wxURI * uri) {
	return uri->IsReference();
}

bool bmx_wxuri_equals(wxURI * uri, wxURI * other) {
	return *uri == *other;
}

void bmx_wxuri_resolve(wxURI * uri, wxURI * base, int flags) {
	uri->Resolve(*base, flags);
}

BBString * bmx_wxuri_unescape(BBString * uri) {
	return bbStringFromWxString(wxURI::Unescape(wxStringFromBBString(uri)));
}


