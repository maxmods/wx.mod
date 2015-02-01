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

#include "glue.h"

// ---------------------------------------------------------------------------------------



// *********************************************

BBArray * bmx_wxgoogletranslate_getlanguages() {
	wxArrayString names;
	wxGoogleTranslate::GetLanguages(names);
	
	return wxArrayStringToBBStringArray(names);
}

BBString * bmx_wxgoogletranslate_getlanguagecode(BBString * languageName) {
	return bbStringFromWxString(wxGoogleTranslate::GetLanguageCode(wxStringFromBBString(languageName)));
}

int bmx_wxgoogletranslate_translate(BBString * source, BBString * sourceLanguageCode, BBString * resultLanguageCode, BBArray * str, int * errorCode) {
	
	wxString result;
	wxString details;


	int res = wxGoogleTranslate::Translate(wxStringFromBBString(source), result, wxStringFromBBString(sourceLanguageCode),
			wxStringFromBBString(resultLanguageCode), details, *errorCode);
	
	BBString **s=(BBString**)BBARRAYDATA( str, str->dims );

	s[0] = bbStringFromWxString( result );
	s[1] = bbStringFromWxString( details );

	BBRETAIN( s[0] );
	BBRETAIN( s[1] );

	return res;
}


