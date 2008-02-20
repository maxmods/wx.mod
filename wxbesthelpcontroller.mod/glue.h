/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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
#include "wx/msw/helpbest.h"
#include "wx/html/helpctrl.h"
#include "../wxfilename.mod/glue.h"

class MaxBestHelpController;

extern "C" {

#include <blitz.h>

	wxBestHelpController * bmx_wxbesthelpcontroller_create(BBObject * handle, wxWindow * parentWindow, int size);
	void bmx_wxbesthelpcontroller_displaycontents(wxBestHelpController * cont);
	bool bmx_wxbesthelpcontroller_keywordsearch(wxBestHelpController * cont, BBString * keyword, wxHelpSearchMode mode);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBestHelpController : public wxBestHelpController
{
public:
	MaxBestHelpController(BBObject * handle, wxWindow * parent, int size);
	~MaxBestHelpController();
	
};
