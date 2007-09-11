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

MaxMenuBar::MaxMenuBar(BBObject * handle, long style)
	: wxMenuBar(style)
{
	wxbind(this, handle);
}

MaxMenuBar::~MaxMenuBar() {
	wxunbind(this);
}


// *********************************************


MaxMenuBar * bmx_wxmenubar_create(BBObject * maxHandle, long style) {
	return new MaxMenuBar(maxHandle, style);
}

bool bmx_wxmenubar_append(wxMenuBar * menubar, MaxMenu * menu, BBString * title) {
	return menubar->Append(menu, wxStringFromBBString(title));
}

void bmx_wxmenubar_check(wxMenuBar * menubar, int id, bool value) {
	menubar->Check(id, value);
}

void bmx_wxmenubar_enable(wxMenuBar * menubar, int id, bool value) {
	menubar->Enable(id, value);
}

void bmx_wxmenubar_enabletop(wxMenuBar * menubar, int pos, bool value) {
	menubar->EnableTop(pos, value);
}

int bmx_wxmenubar_findmenu(wxMenuBar * menubar, BBString * title) {
	return menubar->FindMenu(wxStringFromBBString(title));
}

int bmx_wxmenubar_findmenuitem(wxMenuBar * menubar, BBString * menuString, BBString * itemString) {
	return menubar->FindMenuItem(wxStringFromBBString(menuString), wxStringFromBBString(itemString));
}

BBString * bmx_wxmenubar_gethelpstring(wxMenuBar * menubar, int id) {
	return bbStringFromWxString(menubar->GetHelpString(id));
}

BBString * bmx_wxmenubar_getlabel(wxMenuBar * menubar, int id) {
	return bbStringFromWxString(menubar->GetLabel(id));
}

BBString * bmx_wxmenubar_getlabeltop(wxMenuBar * menubar, int pos) {
	return bbStringFromWxString(menubar->GetLabelTop(pos));
}

wxMenu * bmx_wxmenubar_getmenu(wxMenuBar * menubar, int index) {
	return menubar->GetMenu(index);
}

int bmx_wxmenubar_getmenucount(wxMenuBar * menubar) {
	return menubar->GetMenuCount();
}

bool bmx_wxmenubar_insert(wxMenuBar * menubar, int pos, MaxMenu * menu, BBString * title) {
	return menubar->Insert(pos, menu, wxStringFromBBString(title));
}

bool bmx_wxmenubar_ischecked(wxMenuBar * menubar, int id) {
	return menubar->IsChecked(id);
}

bool bmx_wxmenubar_isenabled(wxMenuBar * menubar, int id) {
	return menubar->IsEnabled(id);
}

void bmx_wxmenubar_refresh(wxMenuBar * menubar) {
	menubar->Refresh();
}

wxMenu * bmx_wxmenubar_remove(wxMenuBar * menubar, int pos) {
	return menubar->Remove(pos);
}

wxMenu * bmx_wxmenubar_replace(wxMenuBar * menubar, int pos, MaxMenu * menu, BBString * title) {
	return menubar->Replace(pos, menu, wxStringFromBBString(title));
}

void bmx_wxmenubar_sethelpstring(wxMenuBar * menubar, int id, BBString * helpString) {
	menubar->SetHelpString(id, wxStringFromBBString(helpString));
}

void bmx_wxmenubar_setlabel(wxMenuBar * menubar, int id, BBString * label) {
	menubar->SetLabel(id, wxStringFromBBString(label));
}

void bmx_wxmenubar_setlabeltop(wxMenuBar * menubar, int pos, BBString * label) {
	menubar->SetLabelTop(pos, wxStringFromBBString(label));
}

wxMenuItem * bmx_wxmenubar_finditem(wxMenuBar * menubar, int id) {
	return menubar->FindItem(id);
}

