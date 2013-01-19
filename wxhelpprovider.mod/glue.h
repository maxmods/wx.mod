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
#include "wx/cshelp.h"

extern "C" {

#include <blitz.h>

	void bmx_wxhelpprovider_free(wxHelpProvider * provider);
	wxHelpProvider * bmx_wxhelpprovider_set(wxHelpProvider * helpProvider);
	wxHelpProvider * bmx_wxhelpprovider_get();
	void bmx_wxhelpprovider_addhelp(wxHelpProvider * provider, wxWindow * window, BBString * text);
	void bmx_wxhelpprovider_addhelpid(wxHelpProvider * provider, wxWindowID windowId, BBString * text);
	BBString * bmx_wxhelpprovider_gethelp(wxHelpProvider * provider, wxWindow * window);
	void bmx_wxhelpprovider_removehelp(wxHelpProvider * provider, wxWindow * window);
	bool bmx_wxhelpprovider_showhelp(wxHelpProvider * provider, wxWindow * window);
	bool bmx_wxhelpprovider_showhelpatpoint(wxHelpProvider * provider, wxWindow * window, int x, int y, wxHelpEvent::Origin origin);

	wxSimpleHelpProvider * bmx_wxsimplehelpprovider_create();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

