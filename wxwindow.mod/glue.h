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

#ifndef _WX_MAX_WINDOW_H_
#define _WX_MAX_WINDOW_H_


#include "wxglue.h"
#include "wx/tooltip.h"
#include "../wxcursor.mod/glue.h"

class MaxWindow;
class MaxBoxSizer;
class MaxGridSizer;
class MaxFlexGridSizer;


extern "C" {

#include <blitz.h>

	BBArray * _wx_wxwindow_wxWindow__newwindowarray(int size);
	void _wx_wxwindow_wxWindow__setwindow(BBArray * array, int index, wxWindow * window);

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
	MaxRect * bmx_wxwindow_getrectrect(wxWindow * window);
	MaxRect * bmx_wxwindow_getscreenrectrect(wxWindow * window);
	void bmx_wxwindow_getsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_sethelptext(wxWindow * window, BBString * helpText);
	void bmx_wxwindow_setid(wxWindow * window, int id);
	void bmx_wxwindow_setlabel(wxWindow * window, BBString * label);
	void bmx_wxwindow_setscrollbar(wxWindow * window, int orientation, int position, int thumbsize, int range, bool refresh);
	void bmx_wxwindow_setscrollpos(wxWindow * window, int orientation, int pos, bool refresh);
	
	void bmx_wxwindow_setcursor(wxWindow * window, MaxCursor * cursor);
	void bmx_wxwindow_setwindowstyle(wxWindow * window, long style);
	void bmx_wxwindow_setwindowstyleflag(wxWindow * window, long style);
	bool bmx_wxwindow_hide(wxWindow * window);
	void bmx_wxwindow_move(wxWindow * window, int x, int y);
	void bmx_wxwindow_setdimensions(wxWindow * window, int x, int y, int w, int h, int flags);
	void bmx_wxwindow_setdimensionsrect(wxWindow * window, MaxRect * rect);
	void bmx_wxwindow_pusheventhandler(wxWindow * window, wxEvtHandler * evt);

	wxWindowVariant bmx_wxwindow_getwindowvariant(wxWindow * window);
	bool bmx_wxwindow_hascapture(wxWindow * window);
	bool bmx_wxwindow_hasflag(wxWindow * window, int flag);
	bool bmx_wxwindow_hasmultiplepages(wxWindow * window);
	bool bmx_wxwindow_hastransparentbackground(wxWindow * window);
	bool bmx_wxwindow_hasscrollbar(wxWindow * window, int orient);
	void bmx_wxwindow_inheritattributes(wxWindow * window);
	void bmx_wxwindow_initdialog(wxWindow * window);
	void bmx_wxwindow_invalidatebestsize(wxWindow * window);
	bool bmx_wxwindow_isdoublebuffered(wxWindow * window);
	bool bmx_wxwindow_isenabled(wxWindow * window);
	bool bmx_wxwindow_isexposed(wxWindow * window, int x, int y, int w, int h);
	bool bmx_wxwindow_isexposedrect(wxWindow * window, MaxRect * rect);
	bool bmx_wxwindow_isfrozen(wxWindow * window);
	bool bmx_wxwindow_isretained(wxWindow * window);
	bool bmx_wxwindow_isshown(wxWindow * window);
	bool bmx_wxwindow_isshownonscreen(wxWindow * window);
	bool bmx_wxwindow_istoplevel(wxWindow * window);
	bool bmx_wxwindow_reparent(wxWindow * window, wxWindow * parent);

	bool bmx_wxwindow_destroy(wxWindow * window);
	void bmx_wxwindow_destroyChildren(wxWindow * window);
	bool bmx_wxwindow_disable(wxWindow * window);
	void bmx_wxwindow_dragacceptfiles(wxWindow * window, bool accept);
	bool bmx_wxwindow_enable(wxWindow * window, bool value);
	void bmx_wxwindow_fit(wxWindow * window);
	void bmx_wxwindow_fitinside(wxWindow * window);
	void bmx_wxwindow_freeze(wxWindow * window);
	MaxColour * bmx_wxwindow_getbackgroundcolour(wxWindow * window);
	int bmx_wxwindow_getbackgroundstyle(wxWindow * window);
	void bmx_wxwindow_geteffectiveminsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_capturemouse(wxWindow * window);
	void bmx_wxwindow_centre(wxWindow * window, int direction);
	void bmx_wxwindow_centreonparent(wxWindow * window, int direction);
	bool bmx_wxwindow_popupmenu(wxWindow * window, wxMenu * menu, int x, int y);
	void bmx_wxwindow_refreshrect(wxWindow * window, int x, int y, int w, int h, bool erase);
	void bmx_wxwindow_refreshrectrect(wxWindow * window, MaxRect * rect, bool erase);
	void bmx_wxwindow_releasemouse(wxWindow * window);
	void bmx_wxwindow_screentoclient(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_setsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setposition(wxWindow * window, int x, int y);

	void * bmx_wxwindow_gethandle(wxWindow * window);
	void bmx_wxwindow_linedown(wxWindow * window);
	void bmx_wxwindow_lineup(wxWindow * window);
	void bmx_wxwindow_lower(wxWindow * window);
	void bmx_wxwindow_makemodal(wxWindow * window, bool flag);
	void bmx_wxwindow_moveafterintaborder(wxWindow * window, wxWindow * win);
	void bmx_wxwindow_movebeforeintaborder(wxWindow * window, wxWindow * win);
	void bmx_wxwindow_pagedown(wxWindow * window);
	void bmx_wxwindow_pageup(wxWindow * window);
	wxEvtHandler * bmx_wxwindow_popeventhandler(wxWindow * window, bool deleteHandler);
	void bmx_wxwindow_raise(wxWindow * window);
	bool bmx_wxwindow_removeeventhandler(wxWindow * window, wxEvtHandler * handler);
	void bmx_wxwindow_setbackgroundstyle(wxWindow * window, wxBackgroundStyle style);
	void bmx_wxwindow_setinitialsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_setclientsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_setcontainingsizer(wxWindow * window, wxSizer * sizer);
	//void bmx_wxwindow_setinitialbestsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_seteventhandler(wxWindow * window, wxEvtHandler * handler);
	void bmx_wxwindow_setextrastyle(wxWindow * window, long style);
	void bmx_wxwindow_setmaxsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setminsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setname(wxWindow * window, BBString * name);
	void bmx_wxwindow_setownbackgroundcolour(wxWindow * window, MaxColour * colour);
	void bmx_wxwindow_setownfont(wxWindow * window, MaxFont * font);
	void bmx_wxwindow_setownforegroundcolour(wxWindow * window, MaxColour * colour);

	wxWindow * bmx_wxwindow_findfocus();
	void bmx_wxwindow_thaw(wxWindow * window);
	bool bmx_wxwindow_togglewindowstyle(wxWindow * window, int flag);
	bool bmx_wxwindow_transferdatafromwindow(wxWindow * window);
	bool bmx_wxwindow_transferdatatowindow(wxWindow * window);
	void bmx_wxwindow_udpate(wxWindow * window);
	void bmx_wxwindow_updatewindowui(wxWindow * window, long flags);
	bool bmx_wxwindow_validate(wxWindow * window);
	void bmx_wxwindow_setsizerandfit(wxWindow * window, wxSizer * sizer, bool deleteOld);
	void bmx_wxwindow_setthemeenabled(wxWindow * window, bool enable);
	void bmx_wxwindow_settooltip(wxWindow * window, BBString * tip);
	void bmx_wxwindow_setvirtualsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setvirtualsizehints(wxWindow * window, int minW, int minH, int maxW, int maxH);
	
	BBArray * bmx_wxwindow_getchildren(wxWindow * window);
	void bmx_wxwindow_convertdialogtopixels(wxWindow * window, int dx, int dy, int * px, int  * py);
	void bmx_wxwindow_convertpixelstodialog(wxWindow * window, int px, int py, int * dx, int * dy);
	wxWindow * bmx_wxwindow_findwindow(wxWindow * window, long id);
	wxWindow * bmx_wxwindow_findwindowbyid(long id, wxWindow * parent);
	wxWindow * bmx_wxwindow_findwindowbyname(BBString * name, wxWindow * parent);
	wxWindow * bmx_wxwindow_findwindowbylabel(BBString * label, wxWindow * parent);
	wxWindow * bmx_wxwindow_getcapture();
	wxCaret * bmx_wxwindow_getcaret(wxWindow * window);
	wxSizer * bmx_wxwindow_getcontainingsizer(wxWindow * window);
	MaxCursor * bmx_wxwindow_getcursor(wxWindow * window);
	long bmx_wxwindow_getextrastyle(wxWindow * window);
	wxEvtHandler * bmx_wxwindow_geteventhandler(wxWindow * window);
	void bmx_wxwindow_gettextextent(wxWindow * window, BBString * text, int * x, int * y, int * descent, int * externalLeading, MaxFont * font, bool use16);
	void bmx_wxwindow_getvirtualsize(wxWindow * window, int * width, int * height);
	void bmx_wxwindow_getwindowbordersize(wxWindow * window, int * leftRight, int * topBottom);
	void bmx_wxwindow_navigate(wxWindow * window, int flags);
	bool bmx_wxwindow_registerhotkey(wxWindow * window, int hotKeyId, int modifiers, int virtualKeyCode);
	bool bmx_wxwindow_scrolllines(wxWindow * window, int lines);
	bool bmx_wxwindow_scrollpages(wxWindow * window, int pages);
	void bmx_wxwindow_setcaret(wxWindow * window, wxCaret * caret);
	void bmx_wxwindow_setwindowvariant(wxWindow * window, wxWindowVariant variant);
	bool bmx_wxwindow_unregisterhotkey(wxWindow * window, int hotKeyId);
	void bmx_wxwindow_warppointer(wxWindow * window, int x, int y);


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
	void bmx_wxsizer_clear(wxSizer * sizer, bool deleteWindows);
	void bmx_wxsizer_fitinside(wxSizer * sizer, wxWindow * window);
	wxWindow * bmx_wxsizer_getcontainingwindow(wxSizer * sizer);
	void bmx_wxsizer_getsize(wxSizer * sizer, int * w, int * h);
	void bmx_wxsizer_getposition(wxSizer * sizer, int * x, int * y);
	void bmx_wxsizer_getminsize(wxSizer * sizer, int * w, int * h);
	void bmx_wxsizer_setvirtualsizehints(wxSizer * sizer, wxWindow * window);
	bool bmx_wxsizer_show(wxSizer * sizer, wxWindow * window, bool doShow, bool recursive);
	bool bmx_wxsizer_showsizer(wxSizer * sizer, wxSizer * s, bool doShow, bool recursive);
	bool bmx_wxsizer_showitem(wxSizer * sizer, int index, bool doShow);
	MaxGridSizer * bmx_wxgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap);
	MaxGridSizer * bmx_wxgridsizer_createrc(BBObject * maxHandle, int rows, int cols, int vgap, int hgap);
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
	void bmx_wxsizer_fit(wxSizer * sizer, wxWindow * window);
	void bmx_wxsizer_fitsize(wxSizer * sizer, wxWindow * window, int * w, int * h);
	int bmx_wxboxsizer_getorientation(wxBoxSizer * sizer);
	bool bmx_wxsizer_isshown(wxSizer * sizer, int index);
	void bmx_wxsizer_layout(wxSizer * sizer);
	void bmx_wxsizer_recalcsizes(wxSizer * sizer);

	wxSizerItem * bmx_wxsizer_insertspacer(wxSizer * sizer, int index, int size);
	wxSizerItem * bmx_wxsizer_insertstretchspacer(wxSizer * sizer, int index, int prop);
	bool bmx_wxsizer_iswindowshown(wxSizer * sizer, wxWindow * window);
	bool bmx_wxsizer_issizershown(wxSizer * sizer, wxSizer * sz);
	void bmx_wxsizer_setdimension(wxSizer * sizer, int x, int y, int width, int height);
	void bmx_wxsizer_setminsize(wxSizer * sizer, int width, int height);
	wxSizerItem * bmx_wxsizer_prepend(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_prependsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_prependspacer(wxSizer * sizer, int size);
	wxSizerItem * bmx_wxsizer_prependstretchspacer(wxSizer * sizer, int prop);
	bool bmx_wxsizer_removesizer(wxSizer * sizer, wxSizer * sz);
	bool bmx_wxsizer_remove(wxSizer * sizer, int index);
	bool bmx_wxsizer_replacewindow(wxSizer * sizer, wxWindow * oldWin, wxWindow * newWin, bool recursive);
	bool bmx_wxsizer_replacesizer(wxSizer * sizer, wxSizer * oldsz, wxSizer * newsz, bool recursive);
	bool bmx_wxsizer_replace(wxSizer * sizer, int oldIndex, wxSizerItem * newItem);

	int bmx_wxflexgridsizer_getflexibledirection(wxFlexGridSizer * sizer);
	int bmx_wxflexgridsizer_getnonflexiblegrowmode(wxFlexGridSizer * sizer);
	void bmx_wxflexgridsizer_removegrowablecol(wxFlexGridSizer * sizer, int idx);
	void bmx_wxflexgridsizer_removegrowablerow(wxFlexGridSizer * sizer, int idx);
	void bmx_wxflexgridsizer_setflexibledirection(wxFlexGridSizer * sizer, int direction);
	void bmx_wxflexgridsizer_setnonflexiblegrowmode(wxFlexGridSizer * sizer, wxFlexSizerGrowMode mode);

	void bmx_wxtooltip_enable(bool flag);
	void bmx_wxtooltip_setdelay(long msecs);
	void bmx_wxtooltip_settip(wxToolTip * tip, BBString * tip);
	BBString * bmx_wxtooltip_gettip(wxToolTip * tip);
	wxWindow * bmx_wxtooltip_getwindow(wxToolTip * tip);

	bool bmx_wxupdateeventui_canupdate(wxWindow * window);
	bool bmx_wxupdateeventui_getchecked(wxUpdateUIEvent & event);
	bool bmx_wxupdateeventui_getenabled(wxUpdateUIEvent & event);
	bool bmx_wxupdateeventui_getshown(wxUpdateUIEvent & event);
	BBString * bmx_wxupdateeventui_gettext(wxUpdateUIEvent & event);
	wxUpdateUIMode bmx_wxupdateeventui_getmode();
	long bmx_wxupdateeventui_getupdateinterval();
	void bmx_wxupdateeventui_setmode(wxUpdateUIMode mode);
	void bmx_wxupdateeventui_settext(wxUpdateUIEvent & event, BBString * text);
	void bmx_wxupdateeventui_setupdateinterval(long interval);

	bool bmx_wxidleevent_cansend(wxWindow * window);
	wxIdleMode bmx_wxidleevent_getmode();
	void bmx_wxidleevent_requestmore(wxIdleEvent & event, bool needMore);
	bool bmx_wxidleevent_morerequested(wxIdleEvent & event);
	void bmx_wxidleevent_setmode(wxIdleMode mode);

	wxWindow * bmx_wxfocusevent_getwindow(wxFocusEvent & event);

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
	MaxGridSizer(BBObject * handle, int rows, int cols, int vgap, int hgap);
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


#endif // _WX_MAX_WINDOW_H_
