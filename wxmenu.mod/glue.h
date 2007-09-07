/*
  Copyright (c) 2007 Bruce A Henderson
 
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

class MaxMenu;

extern "C" {

#include <blitz.h>

	MaxMenu * bmx_wxmenu_create(BBObject * maxHandle, BBString * title, long style);
	void bmx_wxmenu_append(wxMenu * menu, int id, BBString * item, BBString * helpString, int kind);
	void bmx_wxmenu_appendMenu(wxMenu * menu, int id, BBString * item, MaxMenu * subMenu, BBString * helpString);
	void bmx_wxmenu_appendseparator(wxMenu * menu);
	void bmx_wxmenu_appendcheckitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	void bmx_wxmenu_appendradioitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	void bmx_wxmenu_break(wxMenu * menu);
	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxMenu : public wxMenu
{
public:
	MaxMenu(BBObject * handle, const wxString& title, long style);
	~MaxMenu();
};

