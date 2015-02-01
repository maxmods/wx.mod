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
#include "wx/popupwin.h"

class MaxPopupWindow;

extern "C" {

#include <blitz.h>

	void CB_PREF(wx_wxpopupwindow_wxPopupWindow__Position)(BBObject * handle, int x, int y, int w, int h);

	wxPopupWindow * bmx_wxpopupwindow_create(BBObject * handle, wxWindow * parent, int flags);
	void bmx_wxpopupwindow_position(MaxPopupWindow * window, int x, int y, int w, int h);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPopupWindow : public wxPopupWindow
{
public:
    MaxPopupWindow(BBObject * handle, wxWindow* parent, int flags);
	~MaxPopupWindow();
	
	void Position(const wxPoint &ptOrigin, const wxSize &sizePopup);
	void Position_default(int x, int y, int w, int h);
	
private:
	BBObject * maxHandle;
};
