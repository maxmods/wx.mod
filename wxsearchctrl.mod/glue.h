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
#include "wx/srchctrl.h"

class MaxSearchCtrl;

extern "C" {

#include <blitz.h>

	MaxSearchCtrl * bmx_wxsearchctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style);
	void bmx_wxsearchctrl_setmenu(wxSearchCtrl * search, wxMenu * menu);
	wxMenu * bmx_wxsearchctrl_getmenu(wxSearchCtrl * search);
	void bmx_wxsearchctrl_showsearchbutton(wxSearchCtrl * search, bool show);
	bool bmx_wxsearchctrl_issearchbuttonvisible(wxSearchCtrl * search);
	void  bmx_wxsearchctrl_showcancelbutton(wxSearchCtrl * search, bool show);
	bool bmx_wxsearchctrl_iscancelbuttonvisible(wxSearchCtrl * search);

	int bmx_wxsearchctrl_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSearchCtrl : public wxSearchCtrl
{
public:
	MaxSearchCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style);
	~MaxSearchCtrl();
	
private:
	DECLARE_EVENT_TABLE()
};
