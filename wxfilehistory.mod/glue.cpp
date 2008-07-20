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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxFileHistory::MaxFileHistory(BBObject * handle, size_t maxFiles, wxWindowID idBase)
	: wxFileHistory(maxFiles, idBase)
{
	wxbind(this, handle);
}

MaxFileHistory::~MaxFileHistory() {
	wxunbind(this);
}

// *********************************************


wxFileHistory * bmx_wxfilehistory_create(BBObject * handle, int maxFiles, wxWindowID idBase) {
	return new MaxFileHistory(handle, static_cast<size_t>(maxFiles), idBase);
}

void bmx_wxfilehistory_addfiletohistory(wxFileHistory * hist, BBString * filename) {
	hist->AddFileToHistory(wxStringFromBBString(filename));
}

void bmx_wxfilehistory_addfilestomenu(wxFileHistory * hist, wxMenu * menu) {
	if (menu) {
		hist->AddFilesToMenu(menu);
	} else {
		hist->AddFilesToMenu();
	}
}

wxWindowID bmx_wxfilehistory_getbaseid(wxFileHistory * hist) {
	return hist->GetBaseId();
}

int bmx_wxfilehistory_getcount(wxFileHistory * hist) {
	return static_cast<int>(hist->GetCount());
}

BBString * bmx_wxfilehistory_gethistoryfile(wxFileHistory * hist, int index) {
	return bbStringFromWxString(hist->GetHistoryFile(static_cast<size_t>(index)));
}

int bmx_wxfilehistory_getmaxfiles(wxFileHistory * hist) {
	return hist->GetMaxFiles();
}

void bmx_wxfilehistory_load(wxFileHistory * hist, wxConfigBase * config) {
	hist->Load(*config);
}

void bmx_wxfilehistory_removefilefromhistory(wxFileHistory * hist, int index) {
	hist->RemoveFileFromHistory(static_cast<size_t>(index));
}

void bmx_wxfilehistory_removemenu(wxFileHistory * hist, wxMenu * menu) {
	hist->RemoveMenu(menu);
}

void bmx_wxfilehistory_save(wxFileHistory * hist, wxConfigBase * config) {
	hist->Save(*config);
}

void bmx_wxfilehistory_setbaseid(wxFileHistory * hist, wxWindowID id) {
	hist->SetBaseId(id);
}

void bmx_wxfilehistory_usemenu(wxFileHistory * hist, wxMenu * menu) {
	hist->UseMenu(menu);
}

BBArray * bmx_wxfilehistory_getmenus(wxFileHistory * hist) {

	wxList list = hist->GetMenus();
	int size = list.GetCount();
	
	BBArray * menus = _wx_wxfilehistory_wxFileHistory__makeMenus(size);
	
	for( int i=0;i<size;++i ){
		_wx_wxfilehistory_wxFileHistory__addMenu(menus, i, (wxMenu*)list.Item(i)->GetData());
	}
	
	return menus;
}
