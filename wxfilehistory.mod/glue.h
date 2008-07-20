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
#include "wx/docview.h"

class MaxFileHistory;

extern "C" {

#include <blitz.h>

	BBArray * _wx_wxfilehistory_wxFileHistory__makeMenus(int size);
	void _wx_wxfilehistory_wxFileHistory__addMenu(BBArray * menus, int index, wxMenu * menu);

	wxFileHistory * bmx_wxfilehistory_create(BBObject * handle, int maxFiles, wxWindowID idBase);
	void bmx_wxfilehistory_addfiletohistory(wxFileHistory * hist, BBString * filename);
	void bmx_wxfilehistory_addfilestomenu(wxFileHistory * hist, wxMenu * menu);
	wxWindowID bmx_wxfilehistory_getbaseid(wxFileHistory * hist);
	int bmx_wxfilehistory_getcount(wxFileHistory * hist);
	BBString * bmx_wxfilehistory_gethistoryfile(wxFileHistory * hist, int index);
	int bmx_wxfilehistory_getmaxfiles(wxFileHistory * hist);
	void bmx_wxfilehistory_load(wxFileHistory * hist, wxConfigBase * config);
	void bmx_wxfilehistory_removefilefromhistory(wxFileHistory * hist, int index);
	void bmx_wxfilehistory_removemenu(wxFileHistory * hist, wxMenu * menu);
	void bmx_wxfilehistory_save(wxFileHistory * hist, wxConfigBase * config);
	void bmx_wxfilehistory_setbaseid(wxFileHistory * hist, wxWindowID id);
	void bmx_wxfilehistory_usemenu(wxFileHistory * hist, wxMenu * menu);
	BBArray * bmx_wxfilehistory_getmenus(wxFileHistory * hist);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFileHistory : public wxFileHistory
{
public:
	MaxFileHistory(BBObject * handle, size_t maxFiles, wxWindowID idBase);
	~MaxFileHistory();

};
