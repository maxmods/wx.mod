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

#include "glue.h"


// ---------------------------------------------------------------------------------------

MaxTextCtrl::MaxTextCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style)
	: wxTextCtrl(parent, id, value, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxTextCtrl::~MaxTextCtrl() {
	wxunbind(this);
}

// *********************************************


MaxTextCtrl * bmx_wxtextctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style) {
	return new MaxTextCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style);
}

void bmx_wxtextctrl_appendtext(wxTextCtrl * ctrl, BBString * text) {
	ctrl->AppendText(wxStringFromBBString(text));
}

bool bmx_wxtextctrl_cancopy(wxTextCtrl * ctrl) {
	return ctrl->CanCopy();
}

bool bmx_wxtextctrl_cancut(wxTextCtrl * ctrl) {
	return ctrl->CanCut();
}

bool bmx_wxtextctrl_canpaste(wxTextCtrl * ctrl) {
	return ctrl->CanPaste();
}

bool bmx_wxtextctrl_canredo(wxTextCtrl * ctrl) {
	return ctrl->CanRedo();
}

bool bmx_wxtextctrl_canundo(wxTextCtrl * ctrl) {
	return ctrl->CanUndo();
}

void bmx_wxtextctrl_clear(wxTextCtrl * ctrl) {
	ctrl->Clear();
}

void bmx_wxtextctrl_copy(wxTextCtrl * ctrl) {
	ctrl->Copy();
}

void bmx_wxtextctrl_cut(wxTextCtrl * ctrl) {
	ctrl->Cut();
}

void bmx_wxtextctrl_discardedits(wxTextCtrl * ctrl) {
	ctrl->DiscardEdits();
}

const wxTextAttr * bmx_wxtextctrl_getdefaultstyle(wxTextCtrl * ctrl) {
	return & ctrl->GetDefaultStyle();
}

long bmx_wxtextctrl_getinsertionpoint(wxTextCtrl * ctrl) {
	return ctrl->GetInsertionPoint();
}

long bmx_wxtextctrl_getlastposition(wxTextCtrl * ctrl) {
	return ctrl->GetLastPosition();
}

int bmx_wxtextctrl_getlinelength(wxTextCtrl * ctrl, long lineNo) {
	return ctrl->GetLineLength(lineNo);
}

BBString * bmx_wxtextctrl_getlinetext(wxTextCtrl * ctrl, long lineNo) {
	return bbStringFromWxString(ctrl->GetLineText(lineNo));
}

int bmx_wxtextctrl_getnumberoflines(wxTextCtrl * ctrl) {
	return ctrl->GetNumberOfLines();
}

BBString * bmx_wxtextctrl_getrange(wxTextCtrl * ctrl, long fromPos, long toPos) {
	return bbStringFromWxString(ctrl->GetRange(fromPos, toPos));
}

void bmx_wxtextctrl_getselection(wxTextCtrl * ctrl, long * fromPos, long * toPos) {
	ctrl->GetSelection(fromPos, toPos);
}

BBString * bmx_wxtextctrl_getstringselection(wxTextCtrl * ctrl) {
	return bbStringFromWxString(ctrl->GetStringSelection());
}

const wxTextAttr * bmx_wxtextctrl_getstyle(wxTextCtrl * ctrl, long position) {
	wxTextAttr attr;
	bool ret = ctrl->GetStyle(position, attr);
	
	if (ret) {
		return & attr;
	}
	
	return 0;
}

BBString * bmx_wxtextctrl_getvalue(wxTextCtrl * ctrl) {
	return bbStringFromWxString(ctrl->GetValue());
}

bool bmx_wxtextctrl_iseditable(wxTextCtrl * ctrl) {
	return ctrl->IsEditable();
}

bool bmx_wxtextctrl_isempty(wxTextCtrl * ctrl) {
	return ctrl->IsEmpty();
}

bool bmx_wxtextctrl_ismodified(wxTextCtrl * ctrl) {
	return ctrl->IsModified();
}

bool bmx_wxtextctrl_ismultiline(wxTextCtrl * ctrl) {
	return ctrl->IsMultiLine();
}

bool bmx_wxtextctrl_issingleline(wxTextCtrl * ctrl) {
	return ctrl->IsSingleLine();
}

int bmx_wxtextctrl_geteventtype(int type) {
	switch(type) {
		case -7: return wxEVT_COMMAND_TEXT_UPDATED;
		case -8: return wxEVT_COMMAND_TEXT_ENTER;
		case -13: return wxEVT_COMMAND_TEXT_URL;
		case -14: return wxEVT_COMMAND_TEXT_MAXLEN;
	}
	
	return 0;
}


