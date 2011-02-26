/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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
#include "wx/splash.h"
#include "../wxbitmap.mod/glue.h"

class MaxSplashScreen;

extern "C" {

#include <blitz.h>

	MaxSplashScreen * bmx_wxsplashscreen_create(BBObject * maxHandle, MaxBitmap * bitmap, long splashStyle, 
		int milliseconds, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);

	long bmx_wxsplashscreen_getsplashstyle(wxSplashScreen * splash);
	wxWindow * bmx_wxsplashscreen_getsplashwindow(wxSplashScreen * splash);
	int bmx_wxsplashscreen_gettimeout(wxSplashScreen * splash);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxSplashScreen : public wxSplashScreen
{
public:
	MaxSplashScreen(BBObject * handle, const wxBitmap& bitmap, long splashStyle, int milliseconds, 
		wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSplashScreen();
};

