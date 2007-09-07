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
	void bmx_wxtextctrl_appendtext(wxTextCtrl * ctrl, BBString * text);
	bool bmx_wxtextctrl_cancopy(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_cancut(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canpaste(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canredo(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_canundo(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_clear(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_copy(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_cut(wxTextCtrl * ctrl);

	void bmx_wxtextctrl_discardedits(wxTextCtrl * ctrl);
	const wxTextAttr * bmx_wxtextctrl_getdefaultstyle(wxTextCtrl * ctrl);
	long bmx_wxtextctrl_getinsertionpoint(wxTextCtrl * ctrl);
	long bmx_wxtextctrl_getlastposition(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_getlinelength(wxTextCtrl * ctrl, long lineNo);
	BBString * bmx_wxtextctrl_getlinetext(wxTextCtrl * ctrl, long lineNo);
	int bmx_wxtextctrl_getnumberoflines(wxTextCtrl * ctrl);
	BBString * bmx_wxtextctrl_getrange(wxTextCtrl * ctrl, long fromPos, long toPos);
	void bmx_wxtextctrl_getselection(wxTextCtrl * ctrl, long * fromPos, long * toPos);
	BBString * bmx_wxtextctrl_getstringselection(wxTextCtrl * ctrl);
	const wxTextAttr * bmx_wxtextctrl_getstyle(wxTextCtrl * ctrl, long position);
	BBString * bmx_wxtextctrl_getvalue(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_iseditable(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_isempty(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_ismodified(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_ismultiline(wxTextCtrl * ctrl);
	bool bmx_wxtextctrl_issingleline(wxTextCtrl * ctrl);
	
	int bmx_wxtextctrl_geteventtype(int type);
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTextCtrl : public wxTextCtrl
{
public:
	MaxTextCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style);
	~MaxTextCtrl();
};

