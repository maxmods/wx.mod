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
#include "wx/wxledpanel.h"

class MaxLEDPanel;

extern "C" {

#include <blitz.h>

	wxLEDPanel * bmx_wxledpanel_create(BBObject * handle, wxWindow* parent, wxWindowID id, int pointW, int pointH,
			int fieldW, int fieldH, int padding, int x, int y, long style);
	void bmx_wxledpanel_clear(wxLEDPanel * panel);
	void bmx_wxledpanel_reset(wxLEDPanel * panel);
	void bmx_wxledpanel_getfieldsize(wxLEDPanel * panel, int * w, int * h);
	void bmx_wxledpanel_getpointsize(wxLEDPanel * panel, int * w, int * h);
	void bmx_wxledpanel_setledcolour(wxLEDPanel * panel, wxLEDColour colourID);
	MaxColour * bmx_wxledpanel_getledcolour(wxLEDPanel * panel);
	void bmx_wxledpanel_setscrollspeed(wxLEDPanel * panel, int speed);
	int bmx_wxledpanel_getscrollspeed(wxLEDPanel * panel);
	void bmx_wxledpanel_setscrolldirection(wxLEDPanel * panel, wxLEDScrollDirection direction);
	wxLEDScrollDirection bmx_wxledpanel_getscrolldirection(wxLEDPanel * panel);
	void bmx_wxledpanel_showinverted(wxLEDPanel * panel, bool invert);
	void bmx_wxledpanel_showinactiveleds(wxLEDPanel * panel, bool showInactives);
	void bmx_wxledpanel_settextalign(wxLEDPanel * panel, int align);
	int bmx_wxledpanel_gettextalign(wxLEDPanel * panel);
	void bmx_wxledpanel_settext(wxLEDPanel * panel, BBString * text, int align);
	BBString * bmx_wxledpanel_gettext(wxLEDPanel * panel);
	void bmx_wxledpanel_settextpaddingleft(wxLEDPanel * panel, int padLeft);
	void bmx_wxledpanel_settextpaddingright(wxLEDPanel * panel, int padRight);
	int bmx_wxledpanel_gettextpaddingleft(wxLEDPanel * panel);
	int bmx_wxledpanel_gettextpaddingright(wxLEDPanel * panel);
	void bmx_wxledpanel_setletterspace(wxLEDPanel * panel, int letterSpace);
	int bmx_wxledpanel_getletterspace(wxLEDPanel * panel);
	void bmx_wxledpanel_setfonttypewide(wxLEDPanel * panel);
	void bmx_wxledpanel_setfonttypesmall(wxLEDPanel * panel);
	bool bmx_wxledpanel_isfonttypesmall(wxLEDPanel * panel);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxLEDPanel : public wxLEDPanel
{
public:
	MaxLEDPanel(BBObject * handle, wxWindow * parent, wxWindowID id, int pointW, int pointH,
		int fieldW, int fieldH, int padding, int x, int y, long style);
	~MaxLEDPanel();
	
private:
	DECLARE_EVENT_TABLE()
};
