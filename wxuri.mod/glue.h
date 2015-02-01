/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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
#include "wx/uri.h"

extern "C" {

#include <blitz.h>

	wxURI * bmx_wxuri_create(BBString * uri);
	void bmx_wxuri_delete(wxURI * uri);
	BBString * bmx_wxuri_builduri(wxURI * uri);
	BBString * bmx_wxuri_buildunescapeduri(wxURI * uri);
	BBString * bmx_wxuri_getfragment(wxURI * uri);
	wxURIHostType bmx_wxuri_gethostyype(wxURI * uri);
	BBString * bmx_wxuri_getpassword(wxURI * uri);
	BBString * bmx_wxuri_getpath(wxURI * uri);
	BBString * bmx_wxuri_getport(wxURI * uri);
	BBString * bmx_wxuri_getquery(wxURI * uri);
	BBString * bmx_wxuri_getscheme(wxURI * uri);
	BBString * bmx_wxuri_getserver(wxURI * uri);
	BBString * bmx_wxuri_getuser(wxURI * uri);
	BBString * bmx_wxuri_getuserinfo(wxURI * uri);
	int bmx_wxuri_hasfragment(wxURI * uri);
	int bmx_wxuri_haspath(wxURI * uri);
	int bmx_wxuri_hasport(wxURI * uri);
	int bmx_wxuri_hasquery(wxURI * uri);
	int bmx_wxuri_hasscheme(wxURI * uri);
	int bmx_wxuri_hasserver(wxURI * uri);
	int bmx_wxuri_isreference(wxURI * uri);
	int bmx_wxuri_equals(wxURI * uri, wxURI * other);
	void bmx_wxuri_resolve(wxURI * uri, wxURI * base, int flags);
	BBString * bmx_wxuri_unescape(BBString * uri);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

