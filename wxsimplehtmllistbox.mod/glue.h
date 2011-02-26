/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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
#include "wx/htmllbox.h"

class MaxSimpleHtmlListBox;

extern "C" {

#include <blitz.h>

	MaxSimpleHtmlListBox * bmx_wxsimplehtmllistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);

	int bmx_wxsimplehtmllistbox_append(wxSimpleHtmlListBox * listbox, BBString * item, BBObject * clientData);
	void bmx_wxsimplehtmllistbox_clear(wxSimpleHtmlListBox * listbox);
	void bmx_wxsimplehtmllistbox_deleteitem(wxSimpleHtmlListBox * listbox, int item);
	int bmx_wxsimplehtmllistbox_getselection(wxSimpleHtmlListBox * listbox);
	int bmx_wxsimplehtmllistbox_getcount(wxSimpleHtmlListBox * listbox);
	bool bmx_wxsimplehtmllistbox_isempty(wxSimpleHtmlListBox * listbox);
	void bmx_wxsimplehtmllistbox_selectitem(wxSimpleHtmlListBox * listbox, int item);
	int bmx_wxsimplehtmllistbox_insert(wxSimpleHtmlListBox * listbox, BBString * item, int pos, BBObject * clientData);
	BBString * bmx_wxsimplehtmllistbox_getstring(wxSimpleHtmlListBox * listbox, int item);
	void bmx_wxsimplehtmllistbox_setselection(wxSimpleHtmlListBox * listbox, int item);

	void bmx_wxsimplehtmllistbox_appenditems(wxSimpleHtmlListBox * listbox, BBArray * items);
	int bmx_wxsimplehtmllistbox_findstring(wxSimpleHtmlListBox * listbox, BBString * text, int caseSensitive);
	BBObject * bmx_wxsimplehtmllistbox_getclientdata(wxSimpleHtmlListBox * listbox, int item);
	BBArray * bmx_wxsimplehtmllistbox_getstrings(wxSimpleHtmlListBox * listbox);
	BBString * bmx_wxsimplehtmllistbox_getstringselection(wxSimpleHtmlListBox * listbox);
	void bmx_wxsimplehtmllistbox_setclientdata(wxSimpleHtmlListBox * listbox, int item, BBObject * clientData);
	void bmx_wxsimplehtmllistbox_setstring(wxSimpleHtmlListBox * listbox, unsigned int item, BBString * text);
	void bmx_wxsimplehtmllistbox_setstringselection(wxSimpleHtmlListBox * listbox, BBString * text);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSimpleHtmlListBox : public wxSimpleHtmlListBox
{
public:
	MaxSimpleHtmlListBox(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxSimpleHtmlListBox();
	~ MaxSimpleHtmlListBox();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
