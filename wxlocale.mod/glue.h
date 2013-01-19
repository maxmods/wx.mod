/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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
#include "wx/intl.h"

class MaxLanguageInfo;

extern "C" {

#include <blitz.h>

	wxLocale * bmx_wxlocale_create(int language, int flags);

	BBString * bmx_wxlocale_wxgettranslation(BBString *str, BBString *domain);
	BBString * bmx_wxlocale_wxgettranslationp(BBString *str, BBString *strPlural, int n, BBString *domain);

	void bmx_wxlocale_addlanguage(MaxLanguageInfo * info);
	MaxLanguageInfo * bmx_wxlocale_findlanguageinfo(BBString * locale);

	bool bmx_wxlocale_addcatalog(wxLocale * locale, BBString * domain);
	bool bmx_wxlocale_addcataloglang(wxLocale * locale, BBString *domain, wxLanguage language, BBString *msgIdCharSet);
	void bmx_wxlocale_addcataloglookuppathprefix(BBString *prefix);
	BBString * bmx_wxlocale_getcanonicalname(wxLocale * locale);
	int bmx_wxlocale_getlanguage(wxLocale * locale);
	MaxLanguageInfo * bmx_wxlocale_getlanguageinfo(int lang);
	BBString * bmx_wxlocale_getlanguagename(int lang);
	BBString * bmx_wxlocale_getlocale(wxLocale * locale);
	BBString * bmx_wxlocale_getname(wxLocale * locale);
	BBString * bmx_wxlocale_getstring(wxLocale * locale, BBString * str, BBString * domain);
	BBString * bmx_wxlocale_getstringp(wxLocale * locale, BBString * str, BBString * strPlural, int n, BBString * domain);
	BBString * bmx_wxlocale_getheadervalue(wxLocale * locale, BBString *header, BBString * domain);
	BBString * bmx_wxlocale_getsysname(wxLocale * locale);
	wxFontEncoding bmx_wxlocale_getsystemencoding();
	BBString * bmx_wxlocale_getsystemencodingname();
	int bmx_wxlocale_getsystemlanguage();
	bool bmx_wxlocale_init(wxLocale * locale, int language, int flags);
	bool bmx_wxlocale_isavailable(int lang);
	bool bmx_wxlocale_isloaded(wxLocale * locale, BBString *domain);
	bool bmx_wxlocale_isok(wxLocale * locale);

	void bmx_wxlocale_delete(wxLocale * locale);

	MaxLanguageInfo * bmx_wxlanguageinfo_create();
	void bmx_wxlanguageinfo_setlanguage(MaxLanguageInfo * info, int language);
	int bmx_wxlanguageinfo_getlanguage(MaxLanguageInfo * info);
	void bmx_wxlanguageinfo_setcanonicalname(MaxLanguageInfo * info, BBString * name);
	BBString * bmx_wxlanguageinfo_getcanonicalname(MaxLanguageInfo * info);
#ifdef WIN32
	void bmx_wxlanguageinfo_setwinlang(MaxLanguageInfo * info, wxUint32 lang);
	wxUint32 bmx_wxlanguageinfo_getwinlang(MaxLanguageInfo * info);
	void bmx_wxlanguageinfo_setwinsublang(MaxLanguageInfo * info, wxUint32 lang);
	wxUint32 bmx_wxlanguageinfo_getwinsublang(MaxLanguageInfo * info);
#endif
	void bmx_wxlanguageinfo_setdescription(MaxLanguageInfo * info, BBString * desc);
	BBString * bmx_wxlanguageinfo_getdescription(MaxLanguageInfo * info);
	void bmx_wxlanguageinfo_delete(MaxLanguageInfo * info);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxLanguageInfo
{
public:
	MaxLanguageInfo();
	MaxLanguageInfo(const wxLanguageInfo & i);
	wxLanguageInfo & Info();

private:
	wxLanguageInfo info;

};

