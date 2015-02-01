/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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
#include "wx/pickerbase.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	void bmx_wxpickerbase_setinternalmargin(wxPickerBase * picker, int margin);
	int bmx_wxpickerbase_getinternalmargin(wxPickerBase * picker);
	void bmx_wxpickerbase_settextctrlproportion(wxPickerBase * picker, int prop);
	void bmx_wxpickerbase_setpickerctrlproportion(wxPickerBase * picker, int prop);
	int bmx_wxpickerbase_gettextctrlproportion(wxPickerBase * picker);
	int bmx_wxpickerbase_getpickerctrlproportion(wxPickerBase * picker);
	int bmx_wxpickerbase_hastextctrl(wxPickerBase * picker);
	wxTextCtrl * bmx_wxpickerbase_gettextctrl(wxPickerBase * picker);
	int bmx_wxpickerbase_istextctrlgrowable(wxPickerBase * picker);
	void bmx_wxpickerbase_setpickerctrlgrowable(wxPickerBase * picker, int grow);
	void bmx_wxpickerbase_settextctrlgrowable(wxPickerBase * picker, int grow);
	int bmx_wxpickerbase_ispickerctrlgrowable(wxPickerBase * picker);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

