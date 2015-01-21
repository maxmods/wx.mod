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
#include "wx/combobox.h"
#include "wx/xrc/xh_combo.h"
#include "wx/xml/xml.h"

class MaxComboBox;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxcombobox_wxComboBox__xrcNew)(wxComboBox * combo);

	MaxComboBox * bmx_wxcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style);

	int bmx_wxcombobox_cancopy(wxComboBox * combo);
	int bmx_wxcombobox_cancut(wxComboBox * combo);
	int bmx_wxcombobox_canpaste(wxComboBox * combo);
	int bmx_wxcombobox_canredo(wxComboBox * combo);
	int bmx_wxcombobox_canundo(wxComboBox * combo);
	void bmx_wxcombobox_copy(wxComboBox * combo);
	void bmx_wxcombobox_cut(wxComboBox * combo);
	int bmx_wxcombobox_getcurrentselection(wxComboBox * combo);
	long bmx_wxcombobox_getinsertionpoint(wxComboBox * combo);
	wxTextPos bmx_wxcombobox_getlastposition(wxComboBox * combo);
	void bmx_wxcombobox_gettextselection(wxComboBox * combo, long * fromPos, long * toPos);
	BBString * bmx_wxcombobox_getvalue(wxComboBox * combo);
	void bmx_wxcombobox_paste(wxComboBox * combo);
	void bmx_wxcombobox_redo(wxComboBox * combo);
	void bmx_wxcombobox_replace(wxComboBox * combo, long fromPos, long toPos, BBString * text);
	void bmx_wxcombobox_remove(wxComboBox * combo, long fromPos, long toPos);
	void bmx_wxcombobox_setinsertionpoint(wxComboBox * combo, long pos);
	void bmx_wxcombobox_setinsertionpointend(wxComboBox * combo);
	void bmx_wxcombobox_settextselection(wxComboBox * combo, long fromPos, long toPos);
	void bmx_wxcombobox_setvalue(wxComboBox * combo, BBString * text);
	void bmx_wxcombobox_undo(wxComboBox * combo);

	int bmx_wxcombobox_geteventtype(int type);

	void bmx_wxcombobox_addresourcehandler();
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxComboBox : public wxComboBox
{
public:
	MaxComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style);
	MaxComboBox();
	~MaxComboBox();

	void MaxBind(BBObject * handle);
private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxComboBoxXmlHandler : public wxComboBoxXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxComboBoxXmlHandler)

public:
    MaxComboBoxXmlHandler();
    virtual wxObject *DoCreateResource();
	virtual bool CanHandle(wxXmlNode *node);
	
    bool m_insideBox;
    wxArrayString strList;
};

