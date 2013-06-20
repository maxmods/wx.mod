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
#include "wx/aui/aui.h"
#include "../wxbitmap.mod/glue.h"

class MaxAuiManager;
class MaxAuiPaneInfo;
class MaxAuiNotebook;

extern "C" {

#include <blitz.h>

	BBArray * _wx_wxaui_wxAuiManager__createpanearray(int size);
	void _wx_wxaui_wxAuiManager__setpanevalue(BBArray * arr, int index, MaxAuiPaneInfo * info);

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


