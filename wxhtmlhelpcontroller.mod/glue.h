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
#include "wx/html/helpctrl.h"
#include "../wxfilename.mod/glue.h"

class MaxHtmlHelpController;

extern "C" {

#include <blitz.h>

	wxHtmlHelpController * bmx_wxhtmlhelpcontroller_create(BBObject * handle, int style, wxWindow * parentWindow);
	bool bmx_wxhtmlhelpcontroller_addbook(wxHtmlHelpController * cont, BBString * bookUrl, bool showWaitMsg);
	bool bmx_wxhtmlhelpcontroller_addbookfile(wxHtmlHelpController * cont, MaxFileName * file, bool showWaitMsg);
	void bmx_wxhtmlhelpcontroller_display(wxHtmlHelpController * cont, BBString * x);
	void bmx_wxhtmlhelpcontroller_displayid(wxHtmlHelpController * cont, int id);
	void bmx_wxhtmlhelpcontroller_displaycontents(wxHtmlHelpController * cont);
	void bmx_wxhtmlhelpcontroller_displayindex(wxHtmlHelpController * cont);
	bool bmx_wxhtmlhelpcontroller_keywordsearch(wxHtmlHelpController * cont, BBString * keyword, wxHelpSearchMode mode);
	void bmx_wxhtmlhelpcontroller_readcustomization(wxHtmlHelpController * cont, wxConfigBase * config, BBString * path);
	void bmx_wxhtmlhelpcontroller_settempdir(wxHtmlHelpController * cont, BBString * path);
	void bmx_wxhtmlhelpcontroller_settitleformat(wxHtmlHelpController * cont, BBString * format);
	void bmx_wxhtmlhelpcontroller_useconfig(wxHtmlHelpController * cont, wxConfigBase * config, BBString * rootpath);
	void bmx_wxhtmlhelpcontroller_writecustomization(wxHtmlHelpController * cont, wxConfigBase * config, BBString * path);
	void bmx_wxhtmlhelpcontroller_sethelpwindow(wxHtmlHelpController * cont, wxHtmlHelpWindow * helpWindow);


	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxHtmlHelpController : public wxHtmlHelpController
{
public:
	MaxHtmlHelpController(BBObject * handle, int style, wxWindow * parent);
	~MaxHtmlHelpController();
	
};
