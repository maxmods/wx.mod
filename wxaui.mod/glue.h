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
#include "wx/aui/aui.h"
#include "../wxbitmap.mod/glue.h"

class MaxAuiManager;
class MaxAuiPaneInfo;
class MaxAuiNotebook;

extern "C" {

#include <blitz.h>

	MaxAuiManager * bmx_wxauimanager_create(BBObject * handle, wxWindow * window, unsigned int flags);
	bool bmx_wxauimanager_addpane(MaxAuiManager * manager, wxWindow * window, int direction, BBString * caption);
	bool bmx_wxauimanager_addpaneinfo(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * panelinfo, int dx, int dy);
	bool bmx_wxauimanager_detachpane(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_getdocksizeconstraint(MaxAuiManager * manager, double * width, double * height);
	unsigned int bmx_wxauimanager_getflags(MaxAuiManager * manager);
	wxWindow * bmx_wxauimanager_getmanagedwindow(MaxAuiManager * manager);
	wxAuiManager * bmx_wxauimanager_getmanager(wxWindow * window);
	MaxAuiPaneInfo * bmx_wxauimanager_getpane(MaxAuiManager * manager, BBString * name);
	MaxAuiPaneInfo * bmx_wxauimanager_getpanewindow(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_hidehint(MaxAuiManager * manager);
	bool bmx_wxauimanager_insertpane(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * location, int level);
	MaxAuiPaneInfo * bmx_wxauimanager_loadpaneinfo(MaxAuiManager * manager, BBString * panePart);
	bool bmx_wxauimanager_loadperspective(MaxAuiManager * manager, BBString * perspective, bool update);
	BBString * bmx_wxauimanager_savepaneinfo(MaxAuiManager * manager, MaxAuiPaneInfo * info);
	BBString * bmx_wxauimanager_saveperspective(MaxAuiManager * manager);
	void bmx_wxauimanager_setdocksizeconstraint(MaxAuiManager * manager, double width, double height);
	void bmx_wxauimanager_setflags(MaxAuiManager * manager, unsigned int flags);
	void bmx_wxauimanager_setmanagedwindow(MaxAuiManager * manager, wxWindow * window);
	void bmx_wxauimanager_showhint(MaxAuiManager * manager, int x, int y, int w, int h);
	void bmx_wxauimanager_uninit(MaxAuiManager * manager);
	void bmx_wxauimanager_update(MaxAuiManager * manager);
	wxAuiDockArt * bmx_wxauimanager_getartprovider(MaxAuiManager * manager);

	MaxAuiPaneInfo * bmx_wxauipanelinfo_create();
	void bmx_wxauipanelinfo_delete(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_bestsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_bottom(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_bottomdockable(MaxAuiPaneInfo * info, bool dockable);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_caption(MaxAuiPaneInfo * info, BBString * caption);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_captionvisible(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_centre(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_center(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_centrepane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_centerpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_closebutton(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_defaultpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_destroyonclose(MaxAuiPaneInfo * info, bool dest);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_direction(MaxAuiPaneInfo * info, int dir);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_dock(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_dockable(MaxAuiPaneInfo * info, bool dock);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_fixed(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_floatpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_floatable(MaxAuiPaneInfo * info, bool value);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingposition(MaxAuiPaneInfo * info, int x, int y);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_gripper(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_grippertop(MaxAuiPaneInfo * info, bool attop);
	
	bool bmx_wxauipanelinfo_hasborder(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hascaption(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hasclosebutton(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hasflag(MaxAuiPaneInfo * info, unsigned int flag);
	bool bmx_wxauipanelinfo_hasgripper(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hasgrippertop(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hasmaximizebutton(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_hasminimizebutton(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_haspinbutton(MaxAuiPaneInfo * info);
	
	MaxAuiPaneInfo * bmx_wxauipanelinfo_hide(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isbottomdockable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isdocked(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isfixed(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isfloatable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isfloating(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isleftdockable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_ismovable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isok(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isresizable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isrightdockable(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_isshown(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_istoolbar(MaxAuiPaneInfo * info);
	bool bmx_wxauipanelinfo_istopdockable(MaxAuiPaneInfo * info);
	
	MaxAuiPaneInfo * bmx_wxauipanelinfo_layer(MaxAuiPaneInfo * info, int value);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_left(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_leftdockable(MaxAuiPaneInfo * info, bool dockable);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_maxsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_maximizebutton(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_minsize(MaxAuiPaneInfo * info, int w, int h);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_minimizebutton(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_movable(MaxAuiPaneInfo * info, bool move);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_name(MaxAuiPaneInfo * info, BBString * n);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_paneborder(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_pinbutton(MaxAuiPaneInfo * info, bool visible);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_position(MaxAuiPaneInfo * info, int pos);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_resizable(MaxAuiPaneInfo * info, bool value);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_right(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_rightdockable(MaxAuiPaneInfo * info, bool dockable);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_row(MaxAuiPaneInfo * info, int value);
	void bmx_wxauipanelinfo_safeset(MaxAuiPaneInfo * info, MaxAuiPaneInfo * source);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_setflag(MaxAuiPaneInfo * info, unsigned int flag, bool option_state);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_show(MaxAuiPaneInfo * info, bool value);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_toolbarpane(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_top(MaxAuiPaneInfo * info);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_topdocakable(MaxAuiPaneInfo * info, bool value);
	MaxAuiPaneInfo * bmx_wxauipanelinfo_window(MaxAuiPaneInfo * info, wxWindow * window);
	
	BBString * bmx_wxauipanelinfo_getcaption(MaxAuiPaneInfo * info);
	BBString * bmx_wxauipanelinfo_getname(MaxAuiPaneInfo * info);
	unsigned int bmx_wxauipanelinfo_getstate(MaxAuiPaneInfo * info);
	int bmx_wxauipanelinfo_getdirection(MaxAuiPaneInfo * info);
	int bmx_wxauipanelinfo_getlayer(MaxAuiPaneInfo * info);
	int bmx_wxauipanelinfo_getrow(MaxAuiPaneInfo * info);
	int bmx_wxauipanelinfo_getpos(MaxAuiPaneInfo * info);
	void bmx_wxauipanelinfo_getfloatingpos(MaxAuiPaneInfo * info, int * x, int * y);
	void bmx_wxauipanelinfo_getfloatingsize(MaxAuiPaneInfo * info, int * w, int * h);
	
	MaxAuiPaneInfo * bmx_wxauimanagerevent_getpane(wxAuiManagerEvent & event);
	int bmx_wxauimanagerevent_getbutton(wxAuiManagerEvent & event);
	void bmx_wxauimanagerevent_veto(wxAuiManagerEvent & event, bool veto);

	int bmx_wxauidockart_getmetric(wxAuiDockArt * dockart, int id);
	MaxColour * bmx_wxauidockart_getcolor(wxAuiDockArt * dockart, int id);
	MaxColour * bmx_wxauidockart_getcolour(wxAuiDockArt * dockart, int id);
	void bmx_wxauidockart_setmetric(wxAuiDockArt * dockart, int id, int value);
	void bmx_wxauidockart_setcolor(wxAuiDockArt * dockart, int id, MaxColour * colour);
	void bmx_wxauidockart_setcolour(wxAuiDockArt * dockart, int id, MaxColour * colour);

	MaxAuiNotebook * bmx_wxauinotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	bool bmx_wxauinotebook_addpage(MaxAuiNotebook * notebook, wxWindow * page, BBString * caption, bool sel, MaxBitmap * bitmap);

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


