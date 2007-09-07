/*
  Copyright (c) 2007 Bruce A Henderson
 
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
#include "../wxcursor.mod/glue.h"

class MaxWindow;
class MaxBoxSizer;
class MaxGridSizer;
class MaxFlexGridSizer;


extern "C" {

#include <blitz.h>

	MaxWindow * bmx_wxwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	bool bmx_wxwindow_show(wxWindow * window, bool value);
	bool bmx_wxwindow_close(wxWindow * window, bool force);
	void bmx_wxwindow_setsizer(wxWindow * window, wxSizer * sizer, bool deleteOld);
	void bmx_wxwindow_setautolayout(wxWindow * window, bool autoLayout);
	void bmx_wxwindow_delete(wxWindow * window);
	wxSizer * bmx_wxwindow_getsizer(wxWindow * window);
	void bmx_wxwindow_layout(wxWindow * window);
	long bmx_wxwindow_getwindowstyleflag(wxWindow * window);
	void bmx_wxwindow_getbestsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_setfocus(wxWindow * window);
	void bmx_wxwindow_clearbackground(wxWindow * window);
	void bmx_wxwindow_clienttoscreen(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_setbackgroundcolour(wxWindow * window, MaxColour * colour);
	void bmx_wxwindow_setforegroundcolour(wxWindow * window, MaxColour * colour);
	void bmx_wxwindow_setfont(wxWindow * window, MaxFont * font);
	MaxFont * bmx_wxwindow_getfont(wxWindow * window);
	BBString * bmx_wxwindow_gethelptext(wxWindow * window);
	int bmx_wxwindow_getid(wxWindow * window);
	BBString * bmx_wxwindow_getlabel(wxWindow * window);
	void bmx_wxwindow_preparedc(wxWindow * window, MaxDC * dc);
	void bmx_wxwindow_refresh(wxWindow * window, bool erase);
	wxWindow * bmx_wxwindow_getparent(wxWindow * window);
	int bmx_wxwindow_getscrollpos(wxWindow * window, int orientation);
	int bmx_wxwindow_getscrollrange(wxWindow * window, int orientation);
	int bmx_wxwindow_getscrollthumb(wxWindow * window, int orientation);
	int bmx_wxwindow_getcharheight(wxWindow * window);
	int bmx_wxwindow_getcharwidth(wxWindow * window);
	void bmx_wxwindow_getclientsize(wxWindow * window, int * width, int * height);
	MaxColour * bmx_wxwindow_getforegroundcolour(wxWindow * window);
	wxWindow * bmx_wxwindow_getgrandparent(wxWindow * window);

	BBString * bmx_wxwindow_gethelptextatpoint(wxWindow * window, int x, int y, wxHelpEvent::Origin origin);
	void bmx_wxwindow_getmaxsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_getminsize(wxWindow * window, int * w, int * h);
	BBString * bmx_wxwindow_getname(wxWindow * window);
	void bmx_wxwindow_getposition(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_getrect(wxWindow * window, int * x, int * y, int * w, int * h);
	void bmx_wxwindow_getscreenposition(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_getscreenrect(wxWindow * window, int * x, int * y, int * w, int * h);
	void bmx_wxwindow_getsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_sethelptext(wxWindow * window, BBString * helpText);
	void bmx_wxwindow_setid(wxWindow * window, int id);
	void bmx_wxwindow_setlabel(wxWindow * window, BBString * label);
	void bmx_wxwindow_setscrollbar(wxWindow * window, int orientation, int position, int thumbsize, int range, bool refresh);
	void bmx_wxwindow_setscrollpos(wxWindow * window, int orientation, int pos, bool refresh);
	
	void bmx_wxwindow_setcursor(wxWindow * window, MaxCursor * cursor);
	void bmx_wxwindow_setwindowstyle(wxWindow * window, long style);
	void bmx_wxwindow_setwindowstyleflag(wxWindow * window, long style);

	MaxBoxSizer * bmx_wxboxsizer_create(BBObject * maxHandle, int orient);
	wxSizerItem * bmx_wxsizer_add(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border);
	bool bmx_wxsizer_detach(wxSizer * sizer, wxWindow * window);
	bool bmx_wxsizer_detachsizer(wxSizer * sizer, wxSizer * sz);
	wxSizerItem * bmx_wxsizer_insert(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_insertsizer(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addcustomspacer(wxSizer * sizer, int width, int height, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addspacer(wxSizer * sizer, int size);
	wxSizerItem * bmx_wxsizer_addstretchspacer(wxSizer * sizer, int prop);
	void bmx_wxsizer_setitemminsize(wxSizer * sizer, int index, int width, int height);
	void bmx_wxsizer_setitemminsizewindow(wxSizer * sizer, wxWindow * window, int width, int height);
	void bmx_wxsizer_setitemminsizesizer(wxSizer * sizer, wxSizer * sz, int width, int height);
	MaxGridSizer * bmx_wxgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap);
	int bmx_wxgridsizer_getcols(MaxGridSizer * sizer);
	int bmx_wxgridsizer_gethgap(MaxGridSizer * sizer);
	int bmx_wxgridsizer_getrows(MaxGridSizer * sizer);
	int bmx_wxgridsizer_getvgap(MaxGridSizer * sizer);
	void bmx_wxgridsizer_setcols(MaxGridSizer * sizer, int cols);
	void bmx_wxgridsizer_sethgap(MaxGridSizer * sizer, int hgap);
	void bmx_wxgridsizer_setrows(MaxGridSizer * sizer, int rows);
	void bmx_wxgridsizer_setvgap(MaxGridSizer * sizer, int vgap);
	void bmx_wxsizer_setsizehints(wxSizer * sizer, wxWindow * window);
	MaxFlexGridSizer * bmx_wxflexgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap);
	void bmx_wxflexgridsizer_addgrowablecol(MaxFlexGridSizer * sizer, int index, int prop);
	void bmx_wxflexgridsizer_addgrowablerow(MaxFlexGridSizer * sizer, int index, int prop);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxWindow : public wxWindow
{
public:
	MaxWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxWindow();
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBoxSizer : public wxBoxSizer
{
public:
	MaxBoxSizer(BBObject * handle, int orient);
	~MaxBoxSizer();

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxGridSizer : public wxGridSizer
{
public:
	MaxGridSizer(BBObject * handle, int cols, int vgap, int hgap);
	~MaxGridSizer();

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFlexGridSizer : public wxFlexGridSizer
{
public:
	MaxFlexGridSizer(BBObject * handle, int cols, int vgap, int hgap);
	~MaxFlexGridSizer();

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
