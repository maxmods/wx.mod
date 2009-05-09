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

#include "wxglue.h"
#include "wx/stdpaths.h"

//class MaxStandardPaths;

extern "C" {

#include <blitz.h>

	wxStandardPathsBase * bmx_wxstandardpaths_get();
	BBString * bmx_wxstandardpaths_getconfigdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getdatadir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getdocumentsdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getexecutablepath(wxStandardPaths * sp);
#ifdef __WXGTK__
	BBString * bmx_wxstandardpaths_getinstallprefix(wxStandardPaths * sp);
#endif
	BBString * bmx_wxstandardpaths_getlocaldatadir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getpluginsdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getresourcesdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_gettempdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getuserconfigdir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getuserdatadir(wxStandardPaths * sp);
	BBString * bmx_wxstandardpaths_getuserlocaldatadir(wxStandardPaths * sp);
#ifdef __WXGTK__
	void bmx_wxstandardpaths_setinstallprefix(wxStandardPaths * sp, BBString * prefix);
#endif

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


