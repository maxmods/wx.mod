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


MaxFontEnumerator::MaxFontEnumerator(BBObject * handle)
	: maxHandle(handle)
{
}

MaxFontEnumerator::~MaxFontEnumerator() {
}


// *********************************************

MaxFontEnumerator * bmx_wxfontenumerator_create(BBObject * handle) {
	return new MaxFontEnumerator(handle);
}

void bmx_wxfontenumerator_delete(wxFontEnumerator * enumerator) {
	delete enumerator;
}

int bmx_wxfontenumerator_enumeratefacenames(wxFontEnumerator * enumerator, wxFontEncoding encoding, int fixedWidthOnly) {
	return static_cast<int>(enumerator->EnumerateFacenames(encoding, static_cast<bool>(fixedWidthOnly)));
}

int bmx_wxfontenumerator_enumerateencodings(wxFontEnumerator * enumerator, BBString * font) {
	return static_cast<int>(enumerator->EnumerateEncodings(wxStringFromBBString(font)));
}

BBArray * bmx_wxfontenumerator_getencodings(BBString * facename) {
	return wxArrayStringToBBStringArray(wxFontEnumerator::GetEncodings(wxStringFromBBString(facename)));
}

BBArray * bmx_wxfontenumerator_getfacenames(wxFontEncoding encoding, int fixedWidthOnly) {
	return wxArrayStringToBBStringArray(wxFontEnumerator::GetFacenames(encoding, static_cast<bool>(fixedWidthOnly)));
}

int bmx_wxfontenumerator_isvalidfacename(BBString * facename) {
	return static_cast<int>(wxFontEnumerator::IsValidFacename(wxStringFromBBString(facename)));
}



