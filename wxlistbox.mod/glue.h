/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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
#include "wx/xrc/xh_listb.h"
#include "wx/xml/xml.h"

class MaxListBox;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxlistbox_wxListBox__xrcNew(wxListBox * listbox);

	MaxListBox * bmx_wxlistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style);
	void bmx_wxlistbox_insertitems(wxListBox * listbox, BBArray * items, int pos);
	BBArray * bmx_wxlistbox_getselections(wxListBox * listbox);
	
	bool bmx_wxlistbox_isselected(wxListBox * listbox, int item);
	void bmx_wxlistbox_deselect(wxListBox * listbox, int item);
	int bmx_wxlistbox_hittest(wxListBox * listbox, int x, int y);
	void bmx_wxlistbox_setfirstitem(wxListBox * listbox, int item);
	void bmx_wxlistbox_setfirstitemstr(wxListBox * listbox, BBString * item);

	int bmx_wxlistbox_geteventtype(int type);

	void bmx_wxlistbox_addresourcehandler();
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxListBox : public wxListBox
{
public:
	MaxListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style);
	MaxListBox();
	~MaxListBox();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxListBoxXmlHandler : public wxListBoxXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxListBoxXmlHandler)

public:
    MaxListBoxXmlHandler();
    virtual wxObject *DoCreateResource();

	bool m_insideBox;
	wxArrayString strList;
};

