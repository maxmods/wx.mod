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
#include "wx/colordlg.h"

class MaxColourDialog;
class MaxColourData;

extern "C" {

#include <blitz.h>

	MaxColourDialog * bmx_wxcolourdialog_create(BBObject * handle, wxWindow * parent, MaxColourData * data);
	MaxColourData * bmx_wxcolourdialog_getcolourdata(wxColourDialog * dialog);
	int bmx_wxcolourdialog_showmodal(wxColourDialog * dialog);

	MaxColourData * bmx_wxcolourdata_create();
	int bmx_wxcolourdata_getchoosefull(MaxColourData * data);
	MaxColour * bmx_wxcolourdata_getcolour(MaxColourData * data);
	MaxColour * bmx_wxcolourdata_getcustomcolour(MaxColourData * data, int i);
	void bmx_wxcolourdata_setchoosefull(MaxColourData * data, int flag);
	void bmx_wxcolourdata_setcolour(MaxColourData * data, MaxColour * colour);
	void bmx_wxcolourdata_setcustomcolour(MaxColourData * data, int i, MaxColour * colour);
	void bmx_wxcolourdata_delete(MaxColourData * data);

	MaxColour * bmx_wxgetcolourfromuser(wxWindow * parent, MaxColour * init, BBString * caption);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxColourDialog : public wxColourDialog
{
public:
	MaxColourDialog(BBObject * handle, wxWindow * parent, wxColourData * data);
	~MaxColourDialog();
};


class MaxColourData
{
public:
	MaxColourData();
	MaxColourData(const wxColourData & c);
	wxColourData & Data();

private:
	wxColourData data;

};

