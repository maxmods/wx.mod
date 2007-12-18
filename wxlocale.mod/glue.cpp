/*
  Copyright (c) 2007 Bruce A Henderson
 
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

MaxLanguageInfo::MaxLanguageInfo()
{
	//colour = wxColour();
}

MaxLanguageInfo::MaxLanguageInfo(const wxLanguageInfo & i)
	: info(i)
{
}

wxLanguageInfo & MaxLanguageInfo::Info() {
	return info;
}


// *********************************************

wxLocale * bmx_wxlocale_create(int language, int flags) {
	if (language != -1) {
		return new wxLocale(language, flags);
	} else {
		return new wxLocale();
	}
}

BBString * bmx_wxlocale_wxgettranslation(BBString *str, BBString *domain) {
    if( domain != &bbEmptyString ) {
        return bbStringFromWxString(wxString(wxGetTranslation(wxStringFromBBString(str).c_str(), wxStringFromBBString(domain).c_str())));
    } else {
        return bbStringFromWxString(wxString(wxGetTranslation(wxStringFromBBString(str).c_str())));
    }
}

BBString * bmx_wxlocale_wxgettranslationp(BBString *str, BBString *strPlural, int n, BBString *domain) {
    if( domain != &bbEmptyString ) {
        return bbStringFromWxString(wxString(wxGetTranslation(wxStringFromBBString(str).c_str(), 
            wxStringFromBBString(strPlural).c_str(), n, wxStringFromBBString(domain).c_str())));
    } else {
        return bbStringFromWxString(wxString(wxGetTranslation(wxStringFromBBString(str).c_str(),
            wxStringFromBBString(strPlural).c_str(), n)));
    }
}

void bmx_wxlocale_addlanguage(MaxLanguageInfo * info) {
	wxLocale::AddLanguage(info->Info());
}

MaxLanguageInfo * bmx_wxlocale_findlanguageinfo(BBString * locale) {
	const wxLanguageInfo * info = wxLocale::FindLanguageInfo(wxStringFromBBString(locale));
	if (info) {
		return new MaxLanguageInfo(*info);
	} else {
		return NULL;
	}
}

bool bmx_wxlocale_addcatalog(wxLocale * locale, BBString * domain) {
    return locale->AddCatalog(wxStringFromBBString(domain).c_str());
}

bool bmx_wxlocale_addcataloglang(wxLocale * locale, BBString *domain, wxLanguage language, BBString *msgIdCharSet) {
    return locale->AddCatalog(wxStringFromBBString(domain).c_str(), language, 
        wxStringFromBBString(msgIdCharSet).c_str());
}

void bmx_wxlocale_addcataloglookuppathprefix(BBString *prefix) {
    wxLocale::AddCatalogLookupPathPrefix(wxStringFromBBString(prefix));
}

BBString * bmx_wxlocale_getcanonicalname(wxLocale * locale) {
    return bbStringFromWxString(locale->GetCanonicalName());
}

int bmx_wxlocale_getlanguage(wxLocale * locale) {
    return locale->GetLanguage();
}

MaxLanguageInfo * bmx_wxlocale_getlanguageinfo(int lang) {
	const wxLanguageInfo * info = wxLocale::GetLanguageInfo(lang);
	if (info) {
	    return new MaxLanguageInfo(*info);
	} else {
		return NULL;
	}
}

BBString * bmx_wxlocale_getlanguagename(int lang) {
    return bbStringFromWxString(wxLocale::GetLanguageName(lang));
}

BBString * bmx_wxlocale_getlocale(wxLocale * locale) {
    return bbStringFromWxString(wxString(locale->GetLocale()));
}

BBString * bmx_wxlocale_getname(wxLocale * locale) {
    return bbStringFromWxString(locale->GetName());
}

BBString * bmx_wxlocale_getstring(wxLocale * locale, BBString * str, BBString * domain) {
    if( domain != &bbEmptyString ) {
        return bbStringFromWxString(wxString(locale->GetString(wxStringFromBBString(str).c_str(), wxStringFromBBString(domain).c_str())));
    } else {
        return bbStringFromWxString(wxString(locale->GetString(wxStringFromBBString(str).c_str())));
    }
}

BBString * bmx_wxlocale_getstringp(wxLocale * locale, BBString * str, BBString * strPlural, int n, BBString * domain) {
    if( domain != &bbEmptyString ) {
        return bbStringFromWxString(wxString(locale->GetString(wxStringFromBBString(str).c_str(), 
            wxStringFromBBString(strPlural).c_str(), n, wxStringFromBBString(domain).c_str())));
    } else {
        return bbStringFromWxString(wxString(locale->GetString(wxStringFromBBString(str).c_str(),
            wxStringFromBBString(strPlural).c_str(), n)));
    }
}

BBString * bmx_wxlocale_getheadervalue(wxLocale * locale, BBString *header, BBString * domain) {
    if( domain != &bbEmptyString ) {
        return bbStringFromWxString(locale->GetHeaderValue(wxStringFromBBString(header).c_str(), 
            wxStringFromBBString(domain).c_str()));
    } else {
        return bbStringFromWxString(locale->GetHeaderValue(wxStringFromBBString(header).c_str()));
    }
}

BBString * bmx_wxlocale_getsysname(wxLocale * locale) {
    return bbStringFromWxString(locale->GetSysName());
}

wxFontEncoding bmx_wxlocale_getsystemencoding() {
    return wxLocale::GetSystemEncoding();
}

BBString * bmx_wxlocale_getsystemencodingname() {
    return bbStringFromWxString(wxLocale::GetSystemEncodingName());
}

int bmx_wxlocale_getsystemlanguage() {
    return wxLocale::GetSystemLanguage();
}

bool bmx_wxlocale_init(wxLocale * locale, int language, int flags) {
    return locale->Init(language, flags);
}

bool bmx_wxlocale_isavailable(int lang) {
    return wxLocale::IsAvailable(lang);
}

bool bmx_wxlocale_isloaded(wxLocale * locale, BBString *domain) {
    return locale->IsLoaded(wxStringFromBBString(domain).c_str());
}

bool bmx_wxlocale_isok(wxLocale * locale) {
    return locale->IsOk();
}

void bmx_wxlocale_delete(wxLocale * locale) {
	delete locale;
}

// *********************************************

MaxLanguageInfo * bmx_wxlanguageinfo_create() {
    return new MaxLanguageInfo();
}

void bmx_wxlanguageinfo_setlanguage(MaxLanguageInfo * info, int language) {
    info->Info().Language = language;
}

int bmx_wxlanguageinfo_getlanguage(MaxLanguageInfo * info) {
    return info->Info().Language;
}

void bmx_wxlanguageinfo_setcanonicalname(MaxLanguageInfo * info, BBString * name) {
    info->Info().CanonicalName = wxStringFromBBString(name);
}

BBString * bmx_wxlanguageinfo_getcanonicalname(MaxLanguageInfo * info) {
    return bbStringFromWxString(info->Info().CanonicalName);
}

#ifdef WIN32
void bmx_wxlanguageinfo_setwinlang(MaxLanguageInfo * info, wxUint32 lang) {
    info->Info().WinLang = lang;
}

wxUint32 bmx_wxlanguageinfo_getwinlang(MaxLanguageInfo * info) {
    return info->Info().WinLang;
}

void bmx_wxlanguageinfo_setwinsublang(MaxLanguageInfo * info, wxUint32 lang) {
    info->Info().WinSublang = lang;
}

wxUint32 bmx_wxlanguageinfo_getwinsublang(MaxLanguageInfo * info) {
    return info->Info().WinSublang;
}

#endif

void bmx_wxlanguageinfo_setdescription(MaxLanguageInfo * info, BBString * desc) {
    info->Info().Description = wxStringFromBBString(desc);
}

BBString * bmx_wxlanguageinfo_getdescription(MaxLanguageInfo * info) {
    return bbStringFromWxString(info->Info().Description);
}

void bmx_wxlanguageinfo_delete(MaxLanguageInfo * info) {
    delete info;
}


