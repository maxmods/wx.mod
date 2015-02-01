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

#ifndef _WX_MAX_AUI_H_
#define _WX_MAX_AUI_H_

#include "wxglue.h"
#include "wx/aui/aui.h"
#include "../wxbitmap.mod/glue.h"

class MaxAuiManager;
class MaxAuiPaneInfo;
class MaxAuiNotebook;
class MaxAuiToolBar;

extern "C" {

#include <blitz.h>

	BBArray * CB_PREF(wx_wxaui_wxAuiManager__createpanearray)(int size);
	void CB_PREF(wx_wxaui_wxAuiManager__setpanevalue)(BBArray * arr, int index, MaxAuiPaneInfo * info);

	MaxAuiManager * bmx_wxauimanager_create(BBObject * handle, wxWindow * window, unsigned int flags);
	int bmx_wxauimanager_addpane(MaxAuiManager * manager, wxWindow * window, int direction, BBString * caption);
	int bmx_wxauimanager_addpaneinfo(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * panelinfo, int dx, int dy);
	int bmx_wxauimanager_detachpane(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_getdocksizeconstraint(MaxAuiManager * manager, double * width, double * height);
	unsigned int bmx_wxauimanager_getflags(MaxAuiManager * manager);
	wxWindow * bmx_wxauimanager_getmanagedwindow(MaxAuiManager * manager);
	wxAuiManager * bmx_wxauimanager_getmanager(wxWindow * window);
	MaxAuiPaneInfo * bmx_wxauimanager_getpane(MaxAuiManager * manager, BBString * name);
	MaxAuiPaneInfo * bmx_wxauimanager_getpanewindow(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_hidehint(MaxAuiManager * manager);
	int bmx_wxauimanager_insertpane(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * location, int level);
	MaxAuiPaneInfo * bmx_wxauimanager_loadpaneinfo(MaxAuiManager * manager, BBString * panePart);
	int bmx_wxauimanager_loadperspective(MaxAuiManager * manager, BBString * perspective, int update);
	BBString * bmx_wxauimanager_savepaneinfo(MaxAuiManager * manager, MaxAuiPaneInfo * info);
	BBString * bmx_wxauimanager_saveperspective(MaxAuiManager * manager);
	void bmx_wxauimanager_setdocksizeconstraint(MaxAuiManager * manager, double width, double height);
	void bmx_wxauimanager_setflags(MaxAuiManager * manager, unsigned int flags);
	void bmx_wxauimanager_setmanagedwindow(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_showhint(MaxAuiManager * manager, int x, int y, int w, int h);
	void bmx_wxauimanager_uninit(MaxAuiManager * manager);
	void bmx_wxauimanager_update(MaxAuiManager * manager);
	wxAuiDockArt * bmx_wxauimanager_getartprovider(MaxAuiManager * manager);
	BBArray * bmx_wxauimanager_getallpanes(MaxAuiManager * manager);
	void bmx_wxauimanager_setartprovider(MaxAuiManager * manager, wxAuiDockArt * artProvider);

	MaxAuiPaneInfo * bmx_wxauipaneinfo_create();
	void bmx_wxauipaneinfo_delete(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_bestsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_bottom(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_bottomdockable(MaxAuiPaneInfo * info, int dockable);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_caption(MaxAuiPaneInfo * info, BBString * caption);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_captionvisible(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_centre(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_center(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_centrepane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_centerpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_closebutton(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_defaultpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_destroyonclose(MaxAuiPaneInfo * info, int dest);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_direction(MaxAuiPaneInfo * info, int dir);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_dock(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_dockable(MaxAuiPaneInfo * info, int dock);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_fixed(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_floatpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_floatable(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_floatingposition(MaxAuiPaneInfo * info, int x, int y);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_floatingsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_gripper(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_grippertop(MaxAuiPaneInfo * info, int attop);
	wxWindow * bmx_wxauipaneinfo_getwindow(MaxAuiPaneInfo * info);
	
	int bmx_wxauipaneinfo_hasborder(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hascaption(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hasclosebutton(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hasflag(MaxAuiPaneInfo * info, unsigned int flag);
	int bmx_wxauipaneinfo_hasgripper(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hasgrippertop(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hasmaximizebutton(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_hasminimizebutton(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_haspinbutton(MaxAuiPaneInfo * info);
	
	MaxAuiPaneInfo * bmx_wxauipaneinfo_hide(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isbottomdockable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isdocked(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isfixed(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isfloatable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isfloating(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isleftdockable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_ismovable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isok(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isresizable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isrightdockable(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_isshown(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_istoolbar(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_istopdockable(MaxAuiPaneInfo * info);
	
	MaxAuiPaneInfo * bmx_wxauipaneinfo_layer(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_left(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_leftdockable(MaxAuiPaneInfo * info, int dockable);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_maxsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_maximizebutton(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_minsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_minimizebutton(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_movable(MaxAuiPaneInfo * info, int move);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_name(MaxAuiPaneInfo * info, BBString * n);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_paneborder(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_pinbutton(MaxAuiPaneInfo * info, int visible);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_position(MaxAuiPaneInfo * info, int pos);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_resizable(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_right(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_rightdockable(MaxAuiPaneInfo * info, int dockable);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_row(MaxAuiPaneInfo * info, int value);
	void bmx_wxauipaneinfo_safeset(MaxAuiPaneInfo * info, MaxAuiPaneInfo * source);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_setflag(MaxAuiPaneInfo * info, unsigned int flag, int option_state);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_show(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_toolbarpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_top(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_topdocakable(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_window(MaxAuiPaneInfo * info, wxWindow * window);
	MaxAuiPaneInfo * bmx_wxauipaneinfo_dockfixed(MaxAuiPaneInfo * info);

	BBString * bmx_wxauipaneinfo_getcaption(MaxAuiPaneInfo * info);
	BBString * bmx_wxauipaneinfo_getname(MaxAuiPaneInfo * info);
	unsigned int bmx_wxauipaneinfo_getstate(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_getdirection(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_getlayer(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_getrow(MaxAuiPaneInfo * info);
	int bmx_wxauipaneinfo_getpos(MaxAuiPaneInfo * info);
	void bmx_wxauipaneinfo_getfloatingpos(MaxAuiPaneInfo * info, int * x, int * y);
	void bmx_wxauipaneinfo_getfloatingsize(MaxAuiPaneInfo * info, int * w, int * h);
	
	MaxAuiPaneInfo * bmx_wxauimanagerevent_getpane(wxAuiManagerEvent & event);
	int bmx_wxauimanagerevent_getbutton(wxAuiManagerEvent & event);
	void bmx_wxauimanagerevent_veto(wxAuiManagerEvent & event, int veto);
	wxAuiManager * bmx_wxauimanagerevent_getmanager(wxAuiManagerEvent & event);
	MaxDC * bmx_wxauimanagerevent_getdc(wxAuiManagerEvent & event);
	int bmx_wxauimanagerevent_getveto(wxAuiManagerEvent & event);
	int bmx_wxauimanagerevent_canveto(wxAuiManagerEvent & event);
	void bmx_wxauimanagerevent_setcanveto(wxAuiManagerEvent & event, int canVeto);

	int bmx_wxauidockart_getmetric(wxAuiDockArt * dockart, int id);
	MaxColour * bmx_wxauidockart_getcolor(wxAuiDockArt * dockart, int id);
	MaxColour * bmx_wxauidockart_getcolour(wxAuiDockArt * dockart, int id);
	void bmx_wxauidockart_setmetric(wxAuiDockArt * dockart, int id, int value);
	void bmx_wxauidockart_setcolor(wxAuiDockArt * dockart, int id, MaxColour * colour);
	void bmx_wxauidockart_setcolour(wxAuiDockArt * dockart, int id, MaxColour * colour);
	MaxFont * bmx_wxauidockart_getfont(wxAuiDockArt * dockart, int id);
	void bmx_wxauidockart_setfont(wxAuiDockArt * dockart, int id, MaxFont * font);

	MaxAuiNotebook * bmx_wxauinotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	int bmx_wxauinotebook_addpage(MaxAuiNotebook * notebook, wxWindow * page, BBString * caption, int sel, MaxBitmap * bitmap);

	void bmx_wxauinotebook_advanceselection(wxAuiNotebook * notebook, int forward);
	int bmx_wxauinotebook_deletepage(wxAuiNotebook * notebook, int page);
	wxAuiTabArt * bmx_wxauinotebook_getartprovider(wxAuiNotebook * notebook);
	int bmx_wxauinotebook_getheightforpageheight(wxAuiNotebook * notebook, int pageHeight);
	wxWindow * bmx_wxauinotebook_getpage(wxAuiNotebook * notebook, int page);
	MaxBitmap * bmx_wxauinotebook_getpagebitmap(wxAuiNotebook * notebook, int page);
	int bmx_wxauinotebook_getpagecount(wxAuiNotebook * notebook);
	int bmx_wxauinotebook_getpageindex(wxAuiNotebook * notebook, wxWindow * page);
	BBString * bmx_wxauinotebook_getpagetext(wxAuiNotebook * notebook, int page);
	int bmx_wxauinotebook_getselection(wxAuiNotebook * notebook);
	int bmx_wxauinotebook_gettabctrlheight(wxAuiNotebook * notebook);
	int bmx_wxauinotebook_insertpage(wxAuiNotebook * notebook, int index, wxWindow * page, BBString * caption, int sel, MaxBitmap * bitmap);
	int bmx_wxauinotebook_removepage(wxAuiNotebook * notebook, int page);
	void bmx_wxauinotebook_setartprovider(wxAuiNotebook * notebook, wxAuiTabArt * art);
	int bmx_wxauinotebook_setfont(wxAuiNotebook * notebook, MaxFont * font);
	void bmx_wxauinotebook_setnormalfont(wxAuiNotebook * notebook, MaxFont * font);
	void bmx_wxauinotebook_setselectedfont(wxAuiNotebook * notebook, MaxFont * font);
	void bmx_wxauinotebook_setmeasuringfont(wxAuiNotebook * notebook, MaxFont * font);
	int bmx_wxauinotebook_setpagebitmap(wxAuiNotebook * notebook, int page, MaxBitmap * bitmap);
	int bmx_wxauinotebook_setpagetext(wxAuiNotebook * notebook, int page, BBString * text);
	int bmx_wxauinotebook_setselection(wxAuiNotebook * notebook, int page);
	void bmx_wxauinotebook_settabctrlheight(wxAuiNotebook * notebook, int height);
	void bmx_wxauinotebook_setuniformbitmapsize(wxAuiNotebook * notebook, int w, int h);
	void bmx_wxauinotebook_split(wxAuiNotebook * notebook, int page, int direction);
	int bmx_wxauinotebook_showwindowmenu(wxAuiNotebook * notebook);

	
	int bmx_wxaui_geteventtype(int type);


	MaxAuiToolBar * bmx_wxauitoolbar_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	void bmx_wxauitoolbar_setwindowstyle(wxAuiToolBar * tb, int style);
	int bmx_wxauitoolbar_getwindowstyle(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_setartprovider(wxAuiToolBar * tb, wxAuiToolBarArt * art);
	wxAuiToolBarArt * bmx_wxauitoolbar_getartprovider(wxAuiToolBar * tb);
	int bmx_wxauitoolbar_setfont(wxAuiToolBar * tb, MaxFont * font);
	wxAuiToolBarItem * bmx_wxauitoolbar_addtool(wxAuiToolBar * tb, int toolId, BBString * label, MaxBitmap * bitmap, BBString * shortHelp, int kind);
	wxAuiToolBarItem * bmx_wxauitoolbar_addlabel(wxAuiToolBar * tb, int toolId, BBString * label, int width);
	wxAuiToolBarItem * bmx_wxauitoolbar_addcontrol(wxAuiToolBar * tb, wxControl * control, BBString * label);
	wxAuiToolBarItem * bmx_wxauitoolbar_addseparator(wxAuiToolBar * tb);
	wxAuiToolBarItem * bmx_wxauitoolbar_addspacer(wxAuiToolBar * tb, int pixels);
	wxAuiToolBarItem * bmx_wxauitoolbar_addstretchspacer(wxAuiToolBar * tb, int proportion);
	int bmx_wxauitoolbar_realize(wxAuiToolBar * tb);
	wxControl * bmx_wxauitoolbar_findcontrol(wxAuiToolBar * tb, int windowId);
	wxAuiToolBarItem * bmx_wxauitoolbar_findtoolbyposition(wxAuiToolBar * tb, int x, int y);
	wxAuiToolBarItem * bmx_wxauitoolbar_findtoolbyindex(wxAuiToolBar * tb, int idx);
	wxAuiToolBarItem * bmx_wxauitoolbar_findtool(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_cleartools(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_clear(wxAuiToolBar * tb);
	int bmx_wxauitoolbar_deletetool(wxAuiToolBar * tb, int toolId);
	int bmx_wxauitoolbar_deletebyindex(wxAuiToolBar * tb, int idx);
	int bmx_wxauitoolbar_gettoolcount(wxAuiToolBar * tb);
	int bmx_wxauitoolbar_gettoolpos(wxAuiToolBar * tb, int toolId);
	int bmx_wxauitoolbar_gettoolindex(wxAuiToolBar * tb, int toolId);
	int bmx_wxauitoolbar_gettoolfits(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_gettoolrect(wxAuiToolBar * tb, int toolId, int * x, int * y, int * w, int * h);
	int bmx_wxauitoolbar_gettoolfitsbyindex(wxAuiToolBar * tb, int idx);
	int bmx_wxauitoolbar_gettoolbarfits(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_setmargins(wxAuiToolBar * tb, int w, int h);
	void bmx_wxauitoolbar_setmarginsrect(wxAuiToolBar * tb, int Left, int Right, int top, int bottom);
	void bmx_wxauitoolbar_settoolbitmapsize(wxAuiToolBar * tb, int w, int h);
	void bmx_wxauitoolbar_gettoolbitmapsize(wxAuiToolBar * tb, int * w, int * h);
	int bmx_wxauitoolbar_getoverflowvisible(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_setoverflowvisible(wxAuiToolBar * tb, int visible);
	int bmx_wxauitoolbar_getgrippervisible(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_setgrippervisible(wxAuiToolBar * tb, int visible);
	void bmx_wxauitoolbar_toggletool(wxAuiToolBar * tb, int toolId, int state);
	int bmx_wxauitoolbar_gettooltoggled(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_enabletool(wxAuiToolBar * tb, int toolId, int state);
	int bmx_wxauitoolbar_gettoolenabled(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settooldropdown(wxAuiToolBar * tb, int toolId, int dropdown);
	int bmx_wxauitoolbar_gettooldropdown(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoolborderpadding(wxAuiToolBar * tb, int padding);
	int bmx_wxauitoolbar_gettoolborderpadding(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_settooltextorientation(wxAuiToolBar * tb, int orientation);
	int bmx_wxauitoolbar_gettooltextorientation(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_settoolpacking(wxAuiToolBar * tb, int packing);
	int bmx_wxauitoolbar_gettoolpacking(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_settoolproportion(wxAuiToolBar * tb, int toolId, int proportion);
	int bmx_wxauitoolbar_gettoolproportion(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoolseparation(wxAuiToolBar * tb, int separation);
	int bmx_wxauitoolbar_gettoolseparation(wxAuiToolBar * tb);
	void bmx_wxauitoolbar_settoolsticky(wxAuiToolBar * tb, int toolId, int sticky);
	int bmx_wxauitoolbar_gettoolsticky(wxAuiToolBar * tb, int toolId);
	BBString * bmx_wxauitoolbar_gettoollabel(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoollabel(wxAuiToolBar * tb, int toolId, BBString * label);
	MaxBitmap * bmx_wxauitoolbar_gettoolbitmap(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoolbitmap(wxAuiToolBar * tb, int toolId, MaxBitmap * bitmap);
	BBString * bmx_wxauitoolbar_gettoolshorthelp(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoolshorthelp(wxAuiToolBar * tb, int toolId, BBString * helpString);
	BBString * bmx_wxauitoolbar_gettoollonghelp(wxAuiToolBar * tb, int toolId);
	void bmx_wxauitoolbar_settoollonghelp(wxAuiToolBar * tb, int toolId, BBString * helpString);
	void bmx_wxauitoolbar_gethintsize(wxAuiToolBar * tb, int dockDirection, int * w, int * h);
	int bmx_wxauitoolbar_ispanevalid(wxAuiToolBar * tb, MaxAuiPaneInfo * pane);

	int bmx_wxauitoolbarevent_isdropdownclicked(wxAuiToolBarEvent & event);
	void bmx_wxauitoolbarevent_getclickpoint(wxAuiToolBarEvent & event, int * x, int * y);
	void bmx_wxauitoolbarevent_getitemrect(wxAuiToolBarEvent & event, int * x, int * y, int * w, int * h);
	int bmx_wxauitoolbarevent_gettoolid(wxAuiToolBarEvent & event);

	void bmx_wxauitoolbaritem_setwindow(wxAuiToolBarItem * item, wxWindow * w);
	wxWindow * bmx_wxauitoolbaritem_getwindow(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setid(wxAuiToolBarItem * item, int newId);
	int bmx_wxauitoolbaritem_getid(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setkind(wxAuiToolBarItem * item, int newKind);
	int bmx_wxauitoolbaritem_getkind(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setstate(wxAuiToolBarItem * item, int newState);
	int bmx_wxauitoolbaritem_getstate(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setSizerItem(wxAuiToolBarItem * item, wxSizerItem * s);
	wxSizerItem * bmx_wxauitoolbaritem_getsizeritem(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setlabel(wxAuiToolBarItem * item, BBString * s);
	BBString * bmx_wxauitoolbaritem_getlabel(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp);
	MaxBitmap * bmx_wxauitoolbaritem_getbitmap(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setdisabledbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp);
	MaxBitmap * bmx_wxauitoolbaritem_getdisabledbitmap(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_sethoverbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp);
	MaxBitmap * bmx_wxauitoolbaritem_gethoverbitmap(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setshorthelp(wxAuiToolBarItem * item, BBString * s);
	BBString * bmx_wxauitoolbaritem_getshorthelp(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setlonghelp(wxAuiToolBarItem * item, BBString * s);
	BBString * bmx_wxauitoolbaritem_getlonghelp(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setminsize(wxAuiToolBarItem * item, int w, int h);
	void bmx_wxauitoolbaritem_getminsize(wxAuiToolBarItem * item, int * w, int * h);
	void bmx_wxauitoolbaritem_setspacerpixels(wxAuiToolBarItem * item, int s);
	int bmx_wxauitoolbaritem_getspacerpixels(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setproportion(wxAuiToolBarItem * item, int p);
	int bmx_wxauitoolbaritem_getproportion(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setactive(wxAuiToolBarItem * item, int active);
	int bmx_wxauitoolbaritem_isactive(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_sethasdropdown(wxAuiToolBarItem * item, int value);
	int bmx_wxauitoolbaritem_hasdropdown(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setsticky(wxAuiToolBarItem * item, int value);
	int bmx_wxauitoolbaritem_issticky(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setuserdata(wxAuiToolBarItem * item, int data);
	int bmx_wxauitoolbaritem_getuserdata(wxAuiToolBarItem * item);
	void bmx_wxauitoolbaritem_setalignment(wxAuiToolBarItem * item, int value);
	int bmx_wxauitoolbaritem_getalignment(wxAuiToolBarItem * item);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxAuiManager: public wxAuiManager
{
public:
	MaxAuiManager(BBObject * handle, wxWindow * managed, unsigned int flags);
	~MaxAuiManager();
	
private:
	BBObject * maxHandle;

};

class MaxAuiPaneInfo
{
public :
	MaxAuiPaneInfo();
	MaxAuiPaneInfo(wxAuiPaneInfo & paneInfo);
	wxAuiPaneInfo & Info();

private :
	wxAuiPaneInfo & info;
};


class MaxAuiNotebook : public wxAuiNotebook
{
public:
	MaxAuiNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	~MaxAuiNotebook();
	
private:
	BBObject * maxHandle;

};

class MaxAuiToolBar : public wxAuiToolBar
{
public:
	MaxAuiToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	~MaxAuiToolBar();
	
private:
	BBObject * maxHandle;

};

#endif // _WX_MAX_AUI_H_
