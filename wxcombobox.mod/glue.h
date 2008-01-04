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

#include "wxglue.h"
#include "wx/combobox.h"

class MaxComboBox;

extern "C" {

#include <blitz.h>

	MaxComboBox * bmx_wxcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style);

	bool bmx_wxcombobox_cancopy(MaxComboBox * combo);
	bool bmx_wxcombobox_cancut(MaxComboBox * combo);
	bool bmx_wxcombobox_canpaste(MaxComboBox * combo);
	bool bmx_wxcombobox_canredo(MaxComboBox * combo);
	bool bmx_wxcombobox_canundo(MaxComboBox * combo);
	void bmx_wxcombobox_copy(MaxComboBox * combo);
	void bmx_wxcombobox_cut(MaxComboBox * combo);
	int bmx_wxcombobox_getcurrentselection(MaxComboBox * combo);
	long bmx_wxcombobox_getinsertionpoint(MaxComboBox * combo);
	wxTextPos bmx_wxcombobox_getlastposition(MaxComboBox * combo);
	void bmx_wxcombobox_gettextselection(MaxComboBox * combo, long * fromPos, long * toPos);
	BBString * bmx_wxcombobox_getvalue(MaxComboBox * combo);
	void bmx_wxcombobox_paste(MaxComboBox * combo);
	void bmx_wxcombobox_redo(MaxComboBox * combo);
	void bmx_wxcombobox_replace(MaxComboBox * combo, long fromPos, long toPos, BBString * text);
	void bmx_wxcombobox_remove(MaxComboBox * combo, long fromPos, long toPos);
	void bmx_wxcombobox_setinsertionpoint(MaxComboBox * combo, long pos);
	void bmx_wxcombobox_setinsertionpointend(MaxComboBox * combo);
	void bmx_wxcombobox_settextselection(MaxComboBox * combo, long fromPos, long toPos);
	void bmx_wxcombobox_setvalue(MaxComboBox * combo, BBString * text);
	void bmx_wxcombobox_undo(MaxComboBox * combo);

	int bmx_wxcombobox_geteventtype(int type);

}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxComboBox : public wxComboBox
{
public:
	MaxComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style);
	~MaxComboBox();

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};


