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
//#include "wx/event.h"
#include "wx/ptr_scpd.h"

#include <map>

class MaxApp;
class MaxEvtHandler;
class MaxObject;
class MaxColour;
class MaxFont;
class MaxDC;
class MaxPaintDC;
class MaxRect;

extern "C" {

#include <blitz.h>

	void _wx_wx_TEventHandler_eventCallback(wxEvent &, void * data);
	int _wx_wxapp_wxAppMain__MainLoop();

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
	int _wx_wxapp_wxApp__OnInit();
	int bmx_wxapp_macexitmenuitemid();
	void bmx_wxapp_settopwindow(wxWindow * window);
	void bmx_wxapp_setappname(BBString * name);
	bool bmx_wxapp_yield(bool onlyIfNeeded);
	void bmx_wxapp_setownmain();
	bool bmx_wxapp_dispatch();
	int bmx_wxapp_pending();
	bool bmx_wxapp_processidle();

	MaxEvtHandler * bmx_wxevthandler_create(BBObject * maxHandle);
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
	void * bmx_wxcommandevent_getclientdata(wxCommandEvent & event);
	void bmx_wxcommandevent_setclientdata(wxCommandEvent & event, void * data);
	void bmx_wxmoveevent_getposition(wxMoveEvent & event, int * x, int * y);
	void bmx_wxevent_skip(wxEvent & event, bool skip);
	void bmx_wxsizeevent_getsize(wxSizeEvent & event, int * w, int * h);
	wxEventType bmx_wxevent_geteventtype(wxEvent & event);
	int bmx_wxevent_getid(wxEvent & event);
	bool bmx_wxevent_getskipped(wxEvent & event);
	long bmx_wxevent_gettimestamp(wxEvent & event);
	bool bmx_wxevent_iscommandevent(wxEvent & event);
	void bmx_wxevent_resumepropagation(wxEvent & event, int propagationLevel);
	bool bmx_wxevent_shouldpropagate(wxEvent & event);
	int bmx_wxevent_stoppropagation(wxEvent & event);
	wxObject * bmx_wxevent_geteventobject(wxEvent & event);

	
	void bmx_wxupdateeventui_check(wxUpdateUIEvent & event, bool value);
	void bmx_wxupdateeventui_enable(wxUpdateUIEvent & event, bool value);
	void bmx_wxupdateeventui_show(wxUpdateUIEvent & event, bool value);
	
	void bmx_wxnotifyevent_allow(wxNotifyEvent & event);
	void bmx_wxnotifyevent_veto(wxNotifyEvent & event);
	bool bmx_wxnotifyevent_isallowed(wxNotifyEvent & event);

	int bmx_wxscrollevent_getorientation(wxScrollEvent & event);
	int bmx_wxscrollevent_getposition(wxScrollEvent & event);
	
	void bmx_wxcontextmenuevent_getposition(wxContextMenuEvent & event, int * x, int * y);
	void bmx_wxcontextmenuevent_setposition(wxContextMenuEvent & event, int x, int y);

	bool bmx_wxkeyevent_altdown(wxKeyEvent & event);
	bool bmx_wxkeyevent_cmddown(wxKeyEvent & event);
	bool bmx_wxkeyevent_controldown(wxKeyEvent & event);
	int bmx_wxkeyevent_getkeycode(wxKeyEvent & event);
	int bmx_wxkeyevent_getmodifiers(wxKeyEvent & event);
	void bmx_wxkeyevent_getposition(wxKeyEvent & event, int * x, int * y);
	int bmx_wxkeyevent_getrawkeycode(wxKeyEvent & event);
	int bmx_wxkeyevent_getrawkeyflags(wxKeyEvent & event);
	BBString * bmx_wxkeyevent_getunicodekey(wxKeyEvent & event);
	long bmx_wxkeyevent_getx(wxKeyEvent & event);
	long bmx_wxkeyevent_gety(wxKeyEvent & event);
	bool bmx_wxkeyevent_hasmodifiers(wxKeyEvent & event);
	bool bmx_wxkeyevent_metadown(wxKeyEvent & event);
	bool bmx_wxkeyevent_shiftdown(wxKeyEvent & event);

	bool bmx_wxcloseevent_canveto(wxCloseEvent & event);
	bool bmx_wxcloseevent_getloggingoff(wxCloseEvent & event);
	void bmx_wxcloseevent_setcanveto(wxCloseEvent & event, bool canVeto);
	void bmx_wxcloseevent_setloggingoff(wxCloseEvent & event, bool loggingOff);
	void bmx_wxcloseevent_veto(wxCloseEvent & event, bool value);


	BBString * bmx_wxversion_string();
	BBString * bmx_wxgetosdescription();
	
	int bmx_wxmessagebox(BBString * message, BBString * caption, int style, wxWindow * parent, int x, int y);
	
	wxAboutDialogInfo * bmx_wxaboutdialoginfo_create();
	void bmx_wxaboutdialoginfo_delete(wxAboutDialogInfo * info);
	void bmx_wxaboutbox(wxAboutDialogInfo * info);

	BBString * bmx_wxcontrol_getlabel(wxControl * control);
	BBString * bmx_wxcontrol_getlabeltext(wxControl * control);
	void bmx_wxcontrol_setlabel(wxControl * control, BBString * label);
	

	MaxColour * bmx_wxcolour_create(int r, int g, int b, int a);
	MaxColour * bmx_wxcolour_null();
	void bmx_wxcolour_delete(MaxColour * col);
	bool bmx_wxcolour_isok(MaxColour * col);
	int bmx_wxcolour_red(MaxColour * col);
	int bmx_wxcolour_green(MaxColour * col);
	int bmx_wxcolour_blue(MaxColour * col);
	int bmx_wxcolour_alpha(MaxColour * col);
	BBString * bmx_wxcolour_getasstring(MaxColour * col, int flags);
	MaxColour * bmx_wxcolour_createnamedcolour(BBString * name);
	void bmx_wxcolour_set(MaxColour * col, int r, int g, int b, int a);
	bool bmx_wxcolour_setasnamedcolour(MaxColour * col, BBString * name);
	
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

	MaxFont * bmx_wxfont_create();
	MaxFont * bmx_wxfont_createattr(int pointSize, wxFontFamily family, int style, wxFontWeight weight,
			bool underline, BBString * faceName, wxFontEncoding encoding);
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
	void bmx_wxfont_setdefaultencoding(wxFontEncoding encoding);
	bool bmx_wxfont_setfacename(MaxFont * font, BBString * name);
	void bmx_wxfont_setfamily(MaxFont * font, int family);
	bool bmx_wxfont_setnativefontinfo(MaxFont * font, BBString * info);
	bool bmx_wxfont_setnativefontinfouserdesc(MaxFont * font, BBString * info);
	void bmx_wxfont_setencoding(MaxFont * font, wxFontEncoding encoding);

	MaxPaintDC * bmx_wxpaintdc_create(wxWindow * window);
	void bmx_wxpaintdc_delete(MaxPaintDC * dc);
	
	wxFontEncoding bmx_wxfontmapper_getencoding(int n);
	BBString * bmx_wxfontmapper_getencodingdescription(wxFontEncoding encoding);
	BBString * bmx_wxfontmapper_getencodingname(wxFontEncoding encoding);
	int bmx_wxfontmapper_getsupportedencodingcount();

	void bmx_wxstreambase_getlength(wxStreamBase * stream, BBInt64 * i);
	int bmx_wxstreambase_getlasterror(wxStreamBase * stream);
	int bmx_wxstreambase_getsize(wxStreamBase * stream);
	bool bmx_wxstreambase_isok(wxStreamBase * stream);
	bool bmx_wxstreambase_isseekable(wxStreamBase * stream);

	int bmx_wxacceleratorentry_getcommand(wxAcceleratorEntry * entry);
	int bmx_wxacceleratorentry_getflags(wxAcceleratorEntry * entry);
	int bmx_wxacceleratorentry_getkeycode(wxAcceleratorEntry * entry);
	void bmx_wxacceleratorentry_set(wxAcceleratorEntry * entry, int flags, int keyCode, int cmd);
	void bmx_wxacceleratorentry_delete(wxAcceleratorEntry * entry);
	
	int bmx_wxisalnum(int code);
	int bmx_wxisprint(int code);
	void bmx_wxinitallimagehandlers();
	bool bmx_wxlaunchdefaultbrowser(BBString * url, int flags);

	MaxRect * bmx_wxrect_create(int x, int y, int w, int h);
	MaxRect * bmx_wxrect_centrein(MaxRect * rect, MaxRect * r, int dir);
	MaxRect * bmx_wxrect_centerin(MaxRect * rect, MaxRect * r, int dir);
	bool bmx_wxrect_contains(MaxRect * rect, int x, int y);
	bool bmx_wxrect_containsrect(MaxRect * rect, MaxRect * r);
	void bmx_wxrect_deflate(MaxRect * rect, int dx, int dy);
	int bmx_wxrect_getbottom(MaxRect * rect);
	int bmx_wxrect_getheight(MaxRect * rect);
	int bmx_wxrect_getleft(MaxRect * rect);
	void bmx_wxrect_getposition(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_gettopleft(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_gettopright(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_getbottomleft(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_getbottomright(MaxRect * rect, int * x, int * y);
	int bmx_wxrect_getright(MaxRect * rect);
	void bmx_wxrect_getsize(MaxRect * rect, int * w, int * h);
	int bmx_wxrect_gettop(MaxRect * rect);
	int bmx_wxrect_getwidth(MaxRect * rect);
	int bmx_wxrect_getx(MaxRect * rect);
	int bmx_wxrect_gety(MaxRect * rect);
	void bmx_wxrect_inflate(MaxRect * rect, int dx, int dy);
	bool bmx_wxrect_intersects(MaxRect * rect, MaxRect * r);
	bool bmx_wxrect_isempty(MaxRect * rect);
	void bmx_wxrect_offset(MaxRect * rect, int dx, int dy);
	void bmx_wxrect_setheight(MaxRect * rect, int height);
	void bmx_wxrect_setsize(MaxRect * rect, int w, int h);
	void bmx_wxrect_setwidth(MaxRect * rect, int width);
	void bmx_wxrect_setx(MaxRect * rect, int x);
	void bmx_wxrect_sety(MaxRect * rect, int y);
	MaxRect * bmx_wxrect_union(MaxRect * rect, MaxRect * r);
	void bmx_wxrect_delete(MaxRect * rect);

}

/*
class wxMainEventLoop : public wxEventLoop
{
	public:

	wxMainEventLoop(MaxApp *maxApp);
	virtual void OnExit();

	private:
	MaxApp *mMaxApp;
};
*/

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxApp : public wxApp
{
public:
	virtual bool OnInit();
	virtual int MainLoop();

	static bool ownMain;
private:

	wxEventLoop * eventLoop;
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


class MaxFont
{
public:
	MaxFont();
	MaxFont(const wxFont & font);
	~MaxFont();
	wxFont & Font();

private:
	wxFont font;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDC
{
public:
	MaxDC();
	MaxDC(wxDC & dc);
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

class MaxEvtHandler : public wxEvtHandler
{
public:
	MaxEvtHandler(BBObject * handle);
	~MaxEvtHandler();

private:
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRect
{
public:
	MaxRect(const wxRect & r);
	~MaxRect();
	wxRect & Rect();

private:
	wxRect rect;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#endif // _WX_MAX_H_
