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

#ifndef _WX_MAX_H_
#define _WX_MAX_H_

#include "wx/wx.h"
#include "wx/evtloop.h"
#include <wx/aboutdlg.h>
#include "wx/artprov.h"
#include "wx/fontmap.h"

#include <map>

class MaxApp;
class MaxMenu;
class MaxObject;
class MaxBoxSizer;
class MaxGridSizer;
class MaxFlexGridSizer;
class MaxColour;
class MaxBrush;
class MaxPen;
class MaxFont;
class MaxWindow;
class MaxDC;
class MaxPaintDC;

extern "C" {

#include <blitz.h>

	void _wx_wx_TEventHandler_eventCallback(wxEvent &, void * data);

	BBString *bbStringFromWxString(const wxString &s );
	wxString wxStringFromBBString(BBString * s);
	wxArrayString bbStringArrayTowxArrayStr( BBArray *p );
	BBArray *wxArrayStringToBBStringArray( wxArrayString t );
	wxArrayInt bbIntArrayTowxArrayInt( BBArray *p );
	BBArray *wxArrayIntToBBIntArray( wxArrayInt t );
	void wxbind( wxObject *obj, BBObject *peer );
	void wxunbind(wxObject *obj);
	BBObject *wxfind( wxObject *obj );

	int bmx_app_wxentry();
	int _wx_wx_wxApp__OnInit();
	int bmx_wxapp_macexitmenuitemid();
	void bmx_wxapp_settopwindow(wxWindow * window);
	void bmx_wxapp_setappname(BBString * name);
	bool bmx_wxapp_yield(bool onlyIfNeeded);

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
	
	MaxMenu * bmx_wxmenu_create(BBObject * maxHandle, BBString * title, long style);
	void bmx_wxmenu_append(MaxMenu * menu, int id, BBString * item, BBString * helpString, int kind);
	void bmx_wxmenu_appendMenu(MaxMenu * menu, int id, BBString * item, MaxMenu * subMenu, BBString * helpString);
	void bmx_wxmenu_appendseparator(MaxMenu * menu);
	void bmx_wxmenu_appendcheckitem(MaxMenu * menu, int id, BBString * item, BBString * helpString);
	void bmx_wxmenu_appendradioitem(MaxMenu * menu, int id, BBString * item, BBString * helpString);
	void bmx_wxmenu_break(MaxMenu * menu);
	
	void bmx_wxevthandler_connectnoid(wxEvtHandler * evtHandler, wxEventType eventType, void * data);
	void bmx_wxevthandler_connect(wxEvtHandler * evtHandler, int id, wxEventType eventType, void * data);
	void bmx_wxevthandler_connectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, void * data);
	
	void * bmx_event_geteventobject(wxEvent * evt);
	wxEventType bmx_eventtype_value(int type);
	BBString * bmx_wxcommandevent_getstring(wxCommandEvent & event);
	bool bmx_wxcommandevent_ischecked(wxCommandEvent & event);
	int bmx_wxcommandevent_getint(wxCommandEvent & event);
	int bmx_wxcommandevent_getselection(wxCommandEvent & event);
	bool bmx_wxcommandevent_isselection(wxCommandEvent & event);
	long bmx_wxcommandevent_getextralong(wxCommandEvent & event);
	void bmx_wxmoveevent_getposition(wxMoveEvent & event, int * x, int * y);
	void bmx_wxevent_skip(wxEvent & event, bool skip);
	void bmx_wxsizeevent_getsize(wxSizeEvent & event, int * w, int * h);
	wxEventType bmx_wxevent_geteventtype(wxEvent & event);
	int bmx_wxevent_getid(wxEvent & event);
	
	void bmx_wxupdateeventui_check(wxUpdateUIEvent & event, bool value);
	
	void bmx_wxnotifyevent_allow(wxNotifyEvent & event);
	void bmx_wxnotifyevent_veto(wxNotifyEvent & event);
	bool bmx_wxnotifyevent_isallowed(wxNotifyEvent & event);

	BBString * bmx_wxversion_string();
	BBString * bmx_wxgetosdescription();
	
	int bmx_wxmessagebox(BBString * message, BBString * caption, int style, wxWindow * parent, int x, int y);
	
	wxAboutDialogInfo * bmx_wxaboutdialoginfo_create();
	void bmx_wxaboutdialoginfo_delete(wxAboutDialogInfo * info);
	void bmx_wxaboutbox(wxAboutDialogInfo * info);

	BBString * bmx_wxcontrol_getlabel(wxControl * control);
	BBString * bmx_wxcontrol_getlabeltext(wxControl * control);
	void bmx_wxcontrol_setlabel(wxControl * control, BBString * label);
	
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

	MaxColour * bmx_wxcolour_create(int r, int g, int b, int a);
	void bmx_wxcolour_delete(MaxColour * col);
	bool bmx_wxcolour_isok(MaxColour * col);
	int bmx_wxcolour_red(MaxColour * col);
	int bmx_wxcolour_green(MaxColour * col);
	int bmx_wxcolour_blue(MaxColour * col);
	int bmx_wxcolour_alpha(MaxColour * col);
	BBString * bmx_wxcolour_getasstring(MaxColour * col, int flags);
	MaxColour * bmx_wxcolour_createnamedcolour(BBString * name);
	
	MaxColour * bmx_wxstockgdi_colour_black();
	MaxColour * bmx_wxstockgdi_colour_blue();
	MaxColour * bmx_wxstockgdi_colour_cyan();
	MaxColour * bmx_wxstockgdi_colour_green();
	MaxColour * bmx_wxstockgdi_colour_lightgrey();
	MaxColour * bmx_wxstockgdi_colour_red();
	MaxColour * bmx_wxstockgdi_colour_white();
	
	MaxFont * bmx_wxstockgdi_font_italic();
	MaxFont * bmx_wxstockgdi_font_normal();
	MaxFont * bmx_wxstockgdi_font_small();
	MaxFont * bmx_wxstockgdi_font_swiss();

	MaxPen * bmx_wxstockgdi_pen_blackdashed();
	MaxPen * bmx_wxstockgdi_pen_black();
	MaxPen * bmx_wxstockgdi_pen_cyan();
	MaxPen * bmx_wxstockgdi_pen_green();
	MaxPen * bmx_wxstockgdi_pen_grey();
	MaxPen * bmx_wxstockgdi_pen_lightgrey();
	MaxPen * bmx_wxstockgdi_pen_mediumgrey();
	MaxPen * bmx_wxstockgdi_pen_red();
	MaxPen * bmx_wxstockgdi_pen_transparent();
	MaxPen * bmx_wxstockgdi_pen_white();

	void bmx_wxfont_delete(MaxFont * font);
	int bmx_wxfont_getpointsize(MaxFont * font);
	void bmx_wxfont_setpointsize(MaxFont * font, int size);
	bool bmx_wxfont_isfixedwidth(MaxFont * font);
	wxFontEncoding bmx_wxfont_getdefaultencoding();
	BBString * bmx_wxfont_getfacename(MaxFont * font);
	int bmx_wxfont_getfamily(MaxFont * font);
	BBString * bmx_wxfont_getfamilystring(MaxFont * font);
	BBString * bmx_wxfont_getnativefontinfodesc(MaxFont * font);
	BBString * bmx_wxfont_getnativefontinfouserdesc(MaxFont * font);
	int bmx_wxfont_getstyle(MaxFont * font);
	bool bmx_wxfont_getunderlined(MaxFont * font);
	int bmx_wxfont_getweight(MaxFont * font);
	bool bmx_wxfont_isok(MaxFont * font);
	wxFontEncoding bmx_wxfont_getencoding(MaxFont * font);
	BBString * bmx_wxfont_getstylestring(MaxFont * font);
	BBString * bmx_wxfont_getweightstring(MaxFont * font);
	void bmx_wxfont_setstyle(MaxFont * font, int style);
	void bmx_wxfont_setunderlined(MaxFont * font, bool underlined);
	void bmx_wxfont_setweight(MaxFont * font, int weight);

	MaxPaintDC * bmx_wxpaintdc_create(wxWindow * window);
	void bmx_wxpaintdc_delete(MaxPaintDC * dc);
	
	MaxBrush * bmx_wxbrush_create(BBString * name, int style);
	void bmx_wxbrush_delete(MaxBrush * brush);
	
	MaxPen * bmx_wxpen_create(BBString * name, int width, int style);
	MaxPen * bmx_wxpen_createfromcolour(MaxColour * colour, int width, int style);
	void bmx_wxpen_delete(MaxPen * pen);

	void bmx_wxdc_clear(MaxDC * dc);	
	void bmx_wxdc_setbackground(MaxDC * dc, MaxBrush * brush);
	void bmx_wxdc_drawtext(MaxDC * dc, BBString * text, int x, int y);
	int bmx_wxdc_getcharheight(MaxDC * dc);
	void bmx_wxdc_setfont(MaxDC * dc, MaxFont * font);
	void bmx_wxdc_settextbackground(MaxDC * dc, MaxColour * colour);
	void bmx_wxdc_settextforeground(MaxDC * dc, MaxColour * colour);
	void bmx_wxdc_gettextextent(MaxDC * dc, BBString * text, int * w, int * h);
	void bmx_wxdc_setmapmode(MaxDC * dc, int mode);
	void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen);
	void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale);
	void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2);

	wxFontEncoding bmx_wxfontmapper_getencoding(int n);
	BBString * bmx_wxfontmapper_getencodingdescription(wxFontEncoding encoding);
	BBString * bmx_wxfontmapper_getencodingname(wxFontEncoding encoding);
	int bmx_wxfontmapper_getsupportedencodingcount();
}

class wxMainEventLoop : public wxEventLoop
{
	public:

	wxMainEventLoop(MaxApp *maxApp);
	virtual void OnExit();

	private:
	MaxApp *mMaxApp;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxApp : public wxApp
{
public:
	virtual bool OnInit();
	//virtual int OnRun();

	void SetShouldLeave(bool should);
	
private:
	bool mShouldLeave;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxMenu : public wxMenu
{
public:
	MaxMenu(BBObject * handle, const wxString& title, long style);
	~MaxMenu();
	
private:
	BBObject * maxHandle;

};



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxObject : public wxObject
{
public:
	MaxObject(void * handle);
	void * getHandle();
	
private:
	void * maxHandle;

};

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

class MaxColour
{
public:
	MaxColour();
	MaxColour(wxColour & colour = wxNullColour);
	wxColour & Colour();

private:
	wxColour colour;

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


class MaxFont
{
public:
	MaxFont();
	MaxFont(const wxFont & font);
	~MaxFont();
	wxFont & Font();

private:
	wxFont & font;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDC
{
public:
	wxDC * GetDC();
	void init(wxDC * _dc);
private:
	wxDC * dc;
};

class MaxPaintDC : public MaxDC
{
public:
	MaxPaintDC(wxWindow * window);
private:
	wxPaintDC paintDC;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBrush
{
public:
	MaxBrush();
	MaxBrush(wxBrush & brush = wxNullBrush);
	wxBrush & Brush();

private:
	wxBrush brush;

};


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPen
{
public:
	MaxPen();
	MaxPen(wxPen & pen = wxNullPen);
	wxPen & Pen();

private:
	wxPen pen;

};



#endif // _WX_MAX_H_
