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
#include "wx/artprov.h"
#include "../wxicon.mod/glue.h"

class MaxArtProvider;

extern "C" {

#include <blitz.h>

	MaxBitmap * _wx_wxartprovider_wxArtProvider__CreateBitmap(BBObject * handle, BBString * id, BBString * client, int w, int h);

	MaxArtProvider * bmx_wxartprovider_create(BBObject * handle);
	MaxBitmap * bmx_wxartprovider_getbitmap(BBString * id, BBString * client, int w, int h);
	MaxIcon * bmx_wxartprovider_geticon(BBString * id, BBString * client, int w, int h);
	void bmx_wxartprovider_getsizehint(BBString * client, int platformDefault, int * width, int * height);

	int bmx_wxartprovider_deleteprovider(wxArtProvider * provider);
	void bmx_wxartprovider_insert(wxArtProvider * provider);
	int bmx_wxartprovider_pop();
	void bmx_wxartprovider_push(wxArtProvider * provider);
	int bmx_wxartprovider_remove(wxArtProvider * provider);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxArtProvider : public wxArtProvider
{
public:
	MaxArtProvider(BBObject * handle);
	wxBitmap CreateBitmap(const wxArtID& id, const wxArtClient& client, const wxSize& size);
	~MaxArtProvider();

private:
	BBObject * maxHandle;
};
