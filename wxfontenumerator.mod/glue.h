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
#include "wx/fontenum.h"

class MaxFontEnumerator;

extern "C" {

#include <blitz.h>

	int _wx_wxfontenumerator_wxFontEnumerator__OnFacename(BBObject * handle, BBString * font);
	int _wx_wxfontenumerator_wxFontEnumerator__OnFontEncoding(BBObject * handle, BBString * font, BBString * encoding);

	MaxFontEnumerator * bmx_wxfontenumerator_create(BBObject * handle);
	void bmx_wxfontenumerator_delete(wxFontEnumerator * enumerator);
	int bmx_wxfontenumerator_enumeratefacenames(wxFontEnumerator * enumerator, wxFontEncoding encoding, int fixedWidthOnly);
	int bmx_wxfontenumerator_enumerateencodings(wxFontEnumerator * enumerator, BBString * font);
	BBArray * bmx_wxfontenumerator_getencodings(BBString * facename);
	BBArray * bmx_wxfontenumerator_getfacenames(wxFontEncoding encoding, int fixedWidthOnly);
	int bmx_wxfontenumerator_isvalidfacename(BBString * facename);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFontEnumerator : public wxFontEnumerator
{
public:
	MaxFontEnumerator(BBObject * handle);
	~MaxFontEnumerator();
	
protected:

	virtual bool OnFacename(const wxString& font) {
		return static_cast<bool>(_wx_wxfontenumerator_wxFontEnumerator__OnFacename(maxHandle, bbStringFromWxString(font)));
	}

	virtual bool OnFontEncoding(const wxString& font, const wxString& encoding) {
		return static_cast<bool>(_wx_wxfontenumerator_wxFontEnumerator__OnFontEncoding(maxHandle, bbStringFromWxString(font), 
			bbStringFromWxString(encoding)));
	}
	
private:
	BBObject * maxHandle;
};
