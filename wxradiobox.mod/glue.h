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
#include "wx/radiobox.h"
#include "wx/xrc/xh_radbx.h"
#include "wx/xml/xml.h"

class MaxRadioBox;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxradiobox_wxRadioBox__xrcNew)(wxRadioBox * radiobox);

	MaxRadioBox * bmx_wxradiobox_create(BBObject * handle, wxWindow * parent, int id, BBString * label,
		int x, int y, int w, int h, BBArray * array, int majorDimension, long style);
	int bmx_wxradiobox_enable(wxRadioBox * radiobox, int value);
	int bmx_wxradiobox_enableitem(wxRadioBox * radiobox, unsigned int item, int value);
	int bmx_wxradiobox_findstring(wxRadioBox * radiobox, BBString * text, int caseSensitive);
	unsigned int bmx_wxradiobox_getcolumncount(wxRadioBox * radiobox);
	BBString * bmx_wxradiobox_getitemhelptext(wxRadioBox * radiobox, unsigned int item);
	int bmx_wxradiobox_getitemfrompoint(wxRadioBox * radiobox, int x, int y);
	BBString * bmx_wxradiobox_getlabel(wxRadioBox * radiobox);
	BBString * bmx_wxradiobox_getitemlabel(wxRadioBox * radiobox, int item);
	unsigned int bmx_wxradiobox_getrowcount(wxRadioBox * radiobox);
	int bmx_wxradiobox_getselection(wxRadioBox * radiobox);
	BBString * bmx_wxradiobox_getstringselection(wxRadioBox * radiobox);
	BBString * bmx_wxradiobox_getstring(wxRadioBox * radiobox, unsigned int item);
	int bmx_wxradiobox_isitemenabled(wxRadioBox * radiobox, unsigned int item);
	int bmx_wxradiobox_isitemshown(wxRadioBox * radiobox, unsigned int item);
	void bmx_wxradiobox_setitemhelptext(wxRadioBox * radiobox, unsigned int item, BBString * helpText);
	void bmx_wxradiobox_setlabel(wxRadioBox * radiobox, BBString * label);
	void bmx_wxradiobox_setitemlabel(wxRadioBox * radiobox, int item, BBString * label);
	void bmx_wxradiobox_setselection(wxRadioBox * radiobox, int item);
	int bmx_wxradiobox_setstringselection(wxRadioBox * radiobox, BBString * text);
	void bmx_wxradiobox_setitemtooltip(wxRadioBox * radiobox, unsigned int item, BBString * text);
	int bmx_wxradiobox_show(wxRadioBox * radiobox, int value);
	int bmx_wxradiobox_showItem(wxRadioBox * radiobox, unsigned int item, int value);
	wxToolTip * bmx_wxradiobox_getitemtooltip(wxRadioBox * radiobox, int item);

	int bmx_wxradiobox_geteventtype(int type);

	void bmx_wxradiobox_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRadioBox : public wxRadioBox
{
public:
	MaxRadioBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, const wxArrayString& array, int majorDimension, long style);
	MaxRadioBox();
	~MaxRadioBox();
	
	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRadioBoxXmlHandler : public wxRadioBoxXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxRadioBoxXmlHandler)

public:
    MaxRadioBoxXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    bool m_insideBox;

    // the items labels
    wxArrayString labels;

    // the items tooltips
    wxArrayString tooltips;

    // the item help text
    wxArrayString helptexts;
    wxArrayInt    helptextSpecified;
};

