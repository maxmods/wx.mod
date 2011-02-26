/*
  Copyright (c) 2009-2011 Bruce A Henderson
 
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
#include "wxGradientButton.h"

class MaxGradientButton;

extern "C" {

#include <blitz.h>

	wxGradientButton * bmx_wxgradientbutton_create(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y, int w, int h, long style);
	BBString * bmx_wxgradientbutton_getlabel(wxGradientButton * button);
	void bmx_wxgradientbutton_setlabel(wxGradientButton * button, BBString * value);
	MaxColour * bmx_wxgradientbutton_getgradienttopstartcolour(wxGradientButton * button);
	void bmx_wxgradientbutton_setgradienttopstartcolour(wxGradientButton * button, MaxColour * value);
	MaxColour * bmx_wxgradientbutton_getgradienttopendcolour(wxGradientButton * button);
	void bmx_wxgradientbutton_setgradienttopendcolour(wxGradientButton * button, MaxColour * value);
	MaxColour * bmx_wxgradientbutton_getgradientbottomstartcolour(wxGradientButton * button);
	void bmx_wxgradientbutton_setgradientbottomstartcolour(wxGradientButton * button, MaxColour * value);
	MaxColour * bmx_wxgradientbutton_getgradientbottomendcolour(wxGradientButton * button);
	void bmx_wxgradientbutton_setgradientbottomendcolour(wxGradientButton * button, MaxColour * value);
	MaxColour * bmx_wxgradientbutton_getpressedcolourtop(wxGradientButton * button);
	void bmx_wxgradientbutton_setpressedcolourtop(wxGradientButton * button, MaxColour * value);
	MaxColour * bmx_wxgradientbutton_getpressedcolourbottom(wxGradientButton * button);
	void bmx_wxgradientbutton_setpressedcolourbottom(wxGradientButton * button, MaxColour * value);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGradientButton : public wxGradientButton
{
public:
	MaxGradientButton(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style);
	MaxGradientButton();
	~MaxGradientButton();

	void MaxBind(BBObject * handle);
	
private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

