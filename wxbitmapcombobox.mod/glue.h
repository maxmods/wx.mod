/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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
#include "wx/bmpcbox.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/xrc/xh_bmpcbox.h"


class MaxBitmapComboBox;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxbitmapcombobox_wxBitmapComboBox__xrcNew(wxBitmapComboBox * combobox);

	MaxBitmapComboBox * bmx_wxbitmapcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style);
	int bmx_wxbitmapcombobox_append(wxBitmapComboBox * combobox, BBString * item, MaxBitmap * bitmap, void * clientData);
	void bmx_wxbitmapcombobox_getbitmapsize(wxBitmapComboBox * combobox, int * w, int * h);
	MaxBitmap * bmx_wxbitmapcombobox_getitembitmap(wxBitmapComboBox * combobox, unsigned int item);
	int bmx_wxbitmapcombobox_insert(wxBitmapComboBox * combobox, unsigned int pos, BBString * item, MaxBitmap * bitmap, void * clientData);
	void bmx_wxbitmapcombobox_setitembitmap(wxBitmapComboBox * combobox, unsigned int item, MaxBitmap * bitmap);

	void bmx_wxbitmapcombobox_selectitem(wxBitmapComboBox * combobox, int item);
	void bmx_wxbitmapcombobox_setselection(wxBitmapComboBox * combobox, int item);

	void bmx_wxbitmapcombobox_clear(wxBitmapComboBox * combobox);
	void bmx_wxbitmapcombobox_deleteitem(wxBitmapComboBox * combobox, int item);
	int bmx_wxbitmapcombobox_getselection(wxBitmapComboBox * combobox);
	int bmx_wxbitmapcombobox_getcount(wxBitmapComboBox * combobox);
	int bmx_wxbitmapcombobox_isempty(wxBitmapComboBox * combobox);
	BBString * bmx_wxbitmapcombobox_getstring(wxBitmapComboBox * combobox, int item);
	BBArray * bmx_wxbitmapcombobox_getstrings(wxBitmapComboBox * combobox);
	BBString * bmx_wxbitmapcombobox_getstringselection(wxBitmapComboBox * combobox);

	void bmx_wxbitmapcombobox_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBitmapComboBox : public wxBitmapComboBox
{
public:
	MaxBitmapComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style);
	MaxBitmapComboBox();
	~MaxBitmapComboBox();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBitmapComboBoxXmlHandler : public wxBitmapComboBoxXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxBitmapComboBoxXmlHandler)

public:
    MaxBitmapComboBoxXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    wxBitmapComboBox*    m_combobox;
    bool                m_isInside;
};


