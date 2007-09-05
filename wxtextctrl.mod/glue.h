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
#include <wx/textctrl.h>

class MaxTextCtrl;

extern "C" {

#include <blitz.h>


	MaxTextCtrl * bmx_wxtextctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style);
	void bmx_wxtextctrl_appendtext(MaxTextCtrl * ctrl, BBString * text);
	bool bmx_wxtextctrl_cancopy(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_cancut(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canpaste(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canredo(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canundo(MaxTextCtrl * ctrl);
	void bmx_wxtextctrl_clear(MaxTextCtrl * ctrl);
	void bmx_wxtextctrl_copy(MaxTextCtrl * ctrl);
	void bmx_wxtextctrl_cut(MaxTextCtrl * ctrl);

	void bmx_wxtextctrl_discardedits(MaxTextCtrl * ctrl);
	const wxTextAttr * bmx_wxtextctrl_getdefaultstyle(MaxTextCtrl * ctrl);
	long bmx_wxtextctrl_getinsertionpoint(MaxTextCtrl * ctrl);
	long bmx_wxtextctrl_getlastposition(MaxTextCtrl * ctrl);
	int bmx_wxtextctrl_getlinelength(MaxTextCtrl * ctrl, long lineNo);
	BBString * bmx_wxtextctrl_getlinetext(MaxTextCtrl * ctrl, long lineNo);
	int bmx_wxtextctrl_getnumberoflines(MaxTextCtrl * ctrl);
	BBString * bmx_wxtextctrl_getrange(MaxTextCtrl * ctrl, long fromPos, long toPos);
	void bmx_wxtextctrl_getselection(MaxTextCtrl * ctrl, long * fromPos, long * toPos);
	BBString * bmx_wxtextctrl_getstringselection(MaxTextCtrl * ctrl);
	const wxTextAttr * bmx_wxtextctrl_getstyle(MaxTextCtrl * ctrl, long position);
	BBString * bmx_wxtextctrl_getvalue(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_iseditable(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_isempty(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_ismodified(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_ismultiline(MaxTextCtrl * ctrl);
	bool bmx_wxtextctrl_issingleline(MaxTextCtrl * ctrl);
	
	int bmx_wxtextctrl_geteventtype(int type);
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTextCtrl : public wxTextCtrl
{
public:
	MaxTextCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style);
	~MaxTextCtrl();

private:
	BBObject * maxHandle;

};

