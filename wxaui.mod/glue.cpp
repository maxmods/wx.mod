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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxAuiManager::MaxAuiManager(BBObject * handle, wxWindow * managed, unsigned int flags)
	: maxHandle(handle), wxAuiManager(managed, flags)
{
	wxbind(this, handle);
}

MaxAuiManager::~MaxAuiManager() {
	wxunbind(this);
}


MaxAuiPaneInfo::MaxAuiPaneInfo()
	: info(wxAuiNullPaneInfo)
{
	info = wxAuiPaneInfo();
}

MaxAuiPaneInfo::MaxAuiPaneInfo(wxAuiPaneInfo & paneInfo)
	: info(paneInfo)
{
}

wxAuiPaneInfo & MaxAuiPaneInfo::Info() {
	return info;
}

MaxAuiNotebook::MaxAuiNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxAuiNotebook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxAuiNotebook::~MaxAuiNotebook() {
	wxunbind(this);
}


// *********************************************

MaxAuiManager * bmx_wxauimanager_create(BBObject * handle, wxWindow * window, unsigned int flags) {
	return new MaxAuiManager(handle, window, flags);
}

int bmx_wxauimanager_addpane(MaxAuiManager * manager, wxWindow * window, int direction, BBString * caption) {
	return static_cast<int>(manager->AddPane(window, direction, wxStringFromBBString(caption)));
}

int bmx_wxauimanager_addpaneinfo(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * panelinfo, int dx, int dy) {
	if ((dx == -1) || (dy == -1)) {
		return static_cast<int>(manager->AddPane(window, panelinfo->Info()));
	} else {
		return static_cast<int>(manager->AddPane(window, panelinfo->Info(), wxPoint(dx, dy)));
	}
}

int bmx_wxauimanager_detachpane(MaxAuiManager * manager, wxWindow * window) {
	return static_cast<int>(manager->DetachPane(window));
}

void bmx_wxauimanager_getdocksizeconstraint(MaxAuiManager * manager, double * width, double * height) {
	manager->GetDockSizeConstraint(width, height);
}

unsigned int bmx_wxauimanager_getflags(MaxAuiManager * manager) {
	return manager->GetFlags();
}

wxWindow * bmx_wxauimanager_getmanagedwindow(MaxAuiManager * manager) {
	return manager->GetManagedWindow();
}

wxAuiManager * bmx_wxauimanager_getmanager(wxWindow * window) {
	return wxAuiManager::GetManager(window);
}

MaxAuiPaneInfo * bmx_wxauimanager_getpane(MaxAuiManager * manager, BBString * name) {
	return new MaxAuiPaneInfo(manager->GetPane(wxStringFromBBString(name)));
}

MaxAuiPaneInfo * bmx_wxauimanager_getpanewindow(MaxAuiManager * manager, wxWindow * window) {
	return new MaxAuiPaneInfo(manager->GetPane(window));
}

void bmx_wxauimanager_hidehint(MaxAuiManager * manager) {
	manager->HideHint();
}

int bmx_wxauimanager_insertpane(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * location, int level) {
	return static_cast<int>(manager->InsertPane(window, location->Info(), level));
}

MaxAuiPaneInfo * bmx_wxauimanager_loadpaneinfo(MaxAuiManager * manager, BBString * panePart) {
	wxAuiPaneInfo pane;
	manager->LoadPaneInfo(wxStringFromBBString(panePart), pane);
	return new MaxAuiPaneInfo(pane);
}

int bmx_wxauimanager_loadperspective(MaxAuiManager * manager, BBString * perspective, int update) {
	return static_cast<int>(manager->LoadPerspective(wxStringFromBBString(perspective), static_cast<bool>(update)));
}

BBString * bmx_wxauimanager_savepaneinfo(MaxAuiManager * manager, MaxAuiPaneInfo * info) {
	return bbStringFromWxString(manager->SavePaneInfo(info->Info()));
}

BBString * bmx_wxauimanager_saveperspective(MaxAuiManager * manager) {
	return bbStringFromWxString(manager->SavePerspective());
}

void bmx_wxauimanager_setdocksizeconstraint(MaxAuiManager * manager, double width, double height) {
	manager->SetDockSizeConstraint(width, height);
}

void bmx_wxauimanager_setflags(MaxAuiManager * manager, unsigned int flags) {
	manager->SetFlags(flags);
}

void bmx_wxauimanager_setmanagedwindow(MaxAuiManager * manager, wxWindow * window) {
	manager->SetManagedWindow(window);
}

void bmx_wxauimanager_showhint(MaxAuiManager * manager, int x, int y, int w, int h) {
	manager->ShowHint(wxRect(x, y, w, h));
}

void bmx_wxauimanager_uninit(MaxAuiManager * manager) {
	manager->UnInit();
}

void bmx_wxauimanager_update(MaxAuiManager * manager) {
	manager->Update();
}

wxAuiDockArt * bmx_wxauimanager_getartprovider(MaxAuiManager * manager) {
// ** TODO ** Check if we (the wxAuiDockArt*) are bound, and return the bound object instead?
	return manager->GetArtProvider();
}

BBArray * bmx_wxauimanager_getallpanes(MaxAuiManager * manager) {
	wxAuiPaneInfoArray & infos = manager->GetAllPanes();
	int n = infos.GetCount();
	
	BBArray * arr = _wx_wxaui_wxAuiManager__createpanearray(n);
	
	for (int i = 0; i < n; i++) {
		_wx_wxaui_wxAuiManager__setpanevalue(arr, i, new MaxAuiPaneInfo(infos[i]));
	}
	
	return arr;
}

void bmx_wxauimanager_setartprovider(MaxAuiManager * manager, wxAuiDockArt * artProvider) {
	manager->SetArtProvider(artProvider);
}

// *********************************************


MaxAuiPaneInfo * bmx_wxauipanelinfo_create() {
	return new MaxAuiPaneInfo();
}

void bmx_wxauipanelinfo_delete(MaxAuiPaneInfo * info) {
	delete info;
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_bestsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().BestSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_bottom(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Bottom());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_bottomdockable(MaxAuiPaneInfo * info, int dockable) {
	return new MaxAuiPaneInfo(info->Info().BottomDockable(static_cast<bool>(dockable)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_caption(MaxAuiPaneInfo * info, BBString * caption) {
	return new MaxAuiPaneInfo(info->Info().Caption(wxStringFromBBString(caption)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_captionvisible(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().CaptionVisible(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_centre(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Centre());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_center(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Center());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_centrepane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().CentrePane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_centerpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().CenterPane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_closebutton(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().CloseButton(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_defaultpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().DefaultPane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_destroyonclose(MaxAuiPaneInfo * info, int dest) {
	return new MaxAuiPaneInfo(info->Info().DestroyOnClose(static_cast<bool>(dest)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_direction(MaxAuiPaneInfo * info, int dir) {
	return new MaxAuiPaneInfo(info->Info().Direction(dir));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_dock(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Dock());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_dockable(MaxAuiPaneInfo * info, int dock) {
	return new MaxAuiPaneInfo(info->Info().Dockable(static_cast<bool>(dock)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_fixed(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Fixed());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Float());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatable(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Floatable(static_cast<bool>(value)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingposition(MaxAuiPaneInfo * info, int x, int y) {
	return new MaxAuiPaneInfo(info->Info().FloatingPosition(wxPoint(x, y)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().FloatingSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_gripper(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().Gripper(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_grippertop(MaxAuiPaneInfo * info, int attop) {
	return new MaxAuiPaneInfo(info->Info().GripperTop(static_cast<bool>(attop)));
}


int bmx_wxauipanelinfo_hasborder(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasBorder());
}

int bmx_wxauipanelinfo_hascaption(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasCaption());
}

int bmx_wxauipanelinfo_hasclosebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasCloseButton());
}

int bmx_wxauipanelinfo_hasflag(MaxAuiPaneInfo * info, unsigned int flag) {
	return static_cast<int>(info->Info().HasFlag(flag));
}

int bmx_wxauipanelinfo_hasgripper(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasGripper());
}

int bmx_wxauipanelinfo_hasgrippertop(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasGripperTop());
}

int bmx_wxauipanelinfo_hasmaximizebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasMaximizeButton());
}

int bmx_wxauipanelinfo_hasminimizebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasMinimizeButton());
}

int bmx_wxauipanelinfo_haspinbutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasPinButton());
}


MaxAuiPaneInfo * bmx_wxauipanelinfo_hide(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Hide());
}

int bmx_wxauipanelinfo_isbottomdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsBottomDockable());
}

int bmx_wxauipanelinfo_isdocked(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsDocked());
}

int bmx_wxauipanelinfo_isfixed(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFixed());
}

int bmx_wxauipanelinfo_isfloatable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFloatable());
}

int bmx_wxauipanelinfo_isfloating(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFloating());
}

int bmx_wxauipanelinfo_isleftdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsLeftDockable());
}

int bmx_wxauipanelinfo_ismovable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsMovable());
}

int bmx_wxauipanelinfo_isok(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsOk());
}

int bmx_wxauipanelinfo_isresizable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsResizable());
}

int bmx_wxauipanelinfo_isrightdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsRightDockable());
}

int bmx_wxauipanelinfo_isshown(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsShown());
}

int bmx_wxauipanelinfo_istoolbar(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsToolbar());
}

int bmx_wxauipanelinfo_istopdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsTopDockable());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_layer(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Layer(value));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_left(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Left());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_leftdockable(MaxAuiPaneInfo * info, int dockable) {
	return new MaxAuiPaneInfo(info->Info().LeftDockable(static_cast<bool>(dockable)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_maxsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().MaxSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_maximizebutton(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().MaximizeButton(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_minsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().MinSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_minimizebutton(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().MinimizeButton(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_movable(MaxAuiPaneInfo * info, int move) {
	return new MaxAuiPaneInfo(info->Info().Movable(static_cast<bool>(move)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_name(MaxAuiPaneInfo * info, BBString * n) {
	return new MaxAuiPaneInfo(info->Info().Name(wxStringFromBBString(n)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_paneborder(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().PaneBorder(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_pinbutton(MaxAuiPaneInfo * info, int visible) {
	return new MaxAuiPaneInfo(info->Info().PinButton(static_cast<bool>(visible)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_position(MaxAuiPaneInfo * info, int pos) {
	return new MaxAuiPaneInfo(info->Info().Position(pos));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_resizable(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Resizable(static_cast<bool>(value)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_right(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Right());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_rightdockable(MaxAuiPaneInfo * info, int dockable) {
	return new MaxAuiPaneInfo(info->Info().RightDockable(static_cast<bool>(dockable)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_row(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Row(value));
}

void bmx_wxauipanelinfo_safeset(MaxAuiPaneInfo * info, MaxAuiPaneInfo * source) {
	info->Info().SafeSet(source->Info());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_setflag(MaxAuiPaneInfo * info, unsigned int flag, int option_state) {
	return new MaxAuiPaneInfo(info->Info().SetFlag(flag, static_cast<bool>(option_state)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_show(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Show(static_cast<bool>(value)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_toolbarpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().ToolbarPane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_top(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Top());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_topdocakable(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().TopDockable(static_cast<bool>(value)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_window(MaxAuiPaneInfo * info, wxWindow * window) {
	return new MaxAuiPaneInfo(info->Info().Window(window));
}

BBString * bmx_wxauipanelinfo_getcaption(MaxAuiPaneInfo * info) {
	return bbStringFromWxString(info->Info().caption);
}

BBString * bmx_wxauipanelinfo_getname(MaxAuiPaneInfo * info) {
	return bbStringFromWxString(info->Info().name);
}

unsigned int bmx_wxauipanelinfo_getstate(MaxAuiPaneInfo * info) {
	return info->Info().state;
}

int bmx_wxauipanelinfo_getdirection(MaxAuiPaneInfo * info) {
	return info->Info().dock_direction;
}

int bmx_wxauipanelinfo_getlayer(MaxAuiPaneInfo * info) {
	return info->Info().dock_layer;
}

int bmx_wxauipanelinfo_getrow(MaxAuiPaneInfo * info) {
	return info->Info().dock_row;
}

int bmx_wxauipanelinfo_getpos(MaxAuiPaneInfo * info) {
	return info->Info().dock_pos;
}

void bmx_wxauipanelinfo_getfloatingpos(MaxAuiPaneInfo * info, int * x, int * y) {
	wxPoint p = info->Info().floating_pos;
	*x = p.x;
	*y = p.y;
}

void bmx_wxauipanelinfo_getfloatingsize(MaxAuiPaneInfo * info, int * w, int * h) {
	wxSize p = info->Info().floating_size;
	*w = p.x;
	*h = p.y;
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_dockfixed(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().DockFixed());
}

// *********************************************

MaxAuiPaneInfo * bmx_wxauimanagerevent_getpane(wxAuiManagerEvent & event) {
	return new MaxAuiPaneInfo(*event.pane);
}

int bmx_wxauimanagerevent_getbutton(wxAuiManagerEvent & event) {
	return event.button;
}

void bmx_wxauimanagerevent_veto(wxAuiManagerEvent & event, int veto) {
	event.Veto(static_cast<bool>(veto));
}

wxAuiManager * bmx_wxauimanagerevent_getmanager(wxAuiManagerEvent & event) {
	return event.GetManager();
}

MaxDC * bmx_wxauimanagerevent_getdc(wxAuiManagerEvent & event) {
	return new MaxDC(event.GetDC());
}

int bmx_wxauimanagerevent_getveto(wxAuiManagerEvent & event) {
	return static_cast<int>(event.GetVeto());
}

int bmx_wxauimanagerevent_canveto(wxAuiManagerEvent & event) {
	return static_cast<int>(event.CanVeto());
}

void bmx_wxauimanagerevent_setcanveto(wxAuiManagerEvent & event, int canVeto) {
	event.SetCanVeto(static_cast<bool>(canVeto));
}


// *********************************************

int bmx_wxauidockart_getmetric(wxAuiDockArt * dockart, int id) {
	return dockart->GetMetric(id);
}

MaxColour * bmx_wxauidockart_getcolor(wxAuiDockArt * dockart, int id) {
	wxColour c(dockart->GetColor(id));
	return new MaxColour(c);
}

MaxColour * bmx_wxauidockart_getcolour(wxAuiDockArt * dockart, int id) {
	wxColour c(dockart->GetColour(id));
	return new MaxColour(c);
}

void bmx_wxauidockart_setmetric(wxAuiDockArt * dockart, int id, int value) {
	dockart->SetMetric(id, value);
}

void bmx_wxauidockart_setcolor(wxAuiDockArt * dockart, int id, MaxColour * colour) {
	dockart->SetColor(id, colour->Colour());
}

void bmx_wxauidockart_setcolour(wxAuiDockArt * dockart, int id, MaxColour * colour) {
	dockart->SetColour(id, colour->Colour());
}

MaxFont * bmx_wxauidockart_getfont(wxAuiDockArt * dockart, int id) {
	return new MaxFont(dockart->GetFont(id));
}

void bmx_wxauidockart_setfont(wxAuiDockArt * dockart, int id, MaxFont * font) {
	dockart->SetFont(id, font->Font());
}


// *********************************************

MaxAuiNotebook * bmx_wxauinotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {

	return new MaxAuiNotebook(maxHandle, parent, id, x, y, w, h, style);
}
		
int bmx_wxauinotebook_addpage(MaxAuiNotebook * notebook, wxWindow * page, BBString * caption, int sel, MaxBitmap * bitmap) {
	if (bitmap) {
		return static_cast<int>(notebook->AddPage(page, wxStringFromBBString(caption), static_cast<bool>(sel), bitmap->Bitmap()));
	} else {
		return static_cast<int>(notebook->AddPage(page, wxStringFromBBString(caption), static_cast<bool>(sel)));
	}
}

void bmx_wxauinotebook_advanceselection(wxAuiNotebook * notebook, int forward) {
	notebook->AdvanceSelection(static_cast<bool>(forward));
}

int bmx_wxauinotebook_deletepage(wxAuiNotebook * notebook, int page) {
	return static_cast<int>(notebook->DeletePage(page));
}

wxAuiTabArt * bmx_wxauinotebook_getartprovider(wxAuiNotebook * notebook) {
	return notebook->GetArtProvider();
}

int bmx_wxauinotebook_getheightforpageheight(wxAuiNotebook * notebook, int pageHeight) {
	return notebook->GetHeightForPageHeight(pageHeight);
}

wxWindow * bmx_wxauinotebook_getpage(wxAuiNotebook * notebook, int page) {
	return notebook->GetPage(page);
}

MaxBitmap * bmx_wxauinotebook_getpagebitmap(wxAuiNotebook * notebook, int page) {
	return new MaxBitmap(notebook->GetPageBitmap(page));
}

int bmx_wxauinotebook_getpagecount(wxAuiNotebook * notebook) {
	return notebook->GetPageCount();
}

int bmx_wxauinotebook_getpageindex(wxAuiNotebook * notebook, wxWindow * page) {
	return notebook->GetPageIndex(page);
}

BBString * bmx_wxauinotebook_getpagetext(wxAuiNotebook * notebook, int page) {
	return bbStringFromWxString(notebook->GetPageText(page));
}

int bmx_wxauinotebook_getselection(wxAuiNotebook * notebook) {
	return notebook->GetSelection();
}

int bmx_wxauinotebook_gettabctrlheight(wxAuiNotebook * notebook) {
	return notebook->GetTabCtrlHeight();
}

int bmx_wxauinotebook_insertpage(wxAuiNotebook * notebook, int index, wxWindow * page, BBString * caption, int sel, MaxBitmap * bitmap) {
	if (bitmap) {
		return static_cast<int>(notebook->InsertPage(index, page, wxStringFromBBString(caption), static_cast<bool>(sel), bitmap->Bitmap()));
	} else {
		return static_cast<int>(notebook->InsertPage(index, page, wxStringFromBBString(caption), static_cast<bool>(sel)));
	}
}

int bmx_wxauinotebook_removepage(wxAuiNotebook * notebook, int page) {
	return static_cast<int>(notebook->RemovePage(page));
}

void bmx_wxauinotebook_setartprovider(wxAuiNotebook * notebook, wxAuiTabArt * art) {
	notebook->SetArtProvider(art);
}

int bmx_wxauinotebook_setfont(wxAuiNotebook * notebook, MaxFont * font) {
	return static_cast<int>(notebook->SetFont(font->Font()));
}

void bmx_wxauinotebook_setnormalfont(wxAuiNotebook * notebook, MaxFont * font) {
	notebook->SetNormalFont(font->Font());
}

void bmx_wxauinotebook_setselectedfont(wxAuiNotebook * notebook, MaxFont * font) {
	notebook->SetSelectedFont(font->Font());
}

void bmx_wxauinotebook_setmeasuringfont(wxAuiNotebook * notebook, MaxFont * font) {
	notebook->SetMeasuringFont(font->Font());
}

int bmx_wxauinotebook_setpagebitmap(wxAuiNotebook * notebook, int page, MaxBitmap * bitmap) {
	return static_cast<int>(notebook->SetPageBitmap(page, bitmap->Bitmap()));
}

int bmx_wxauinotebook_setpagetext(wxAuiNotebook * notebook, int page, BBString * text) {
	return static_cast<int>(notebook->SetPageText(page, wxStringFromBBString(text)));
}

int bmx_wxauinotebook_setselection(wxAuiNotebook * notebook, int page) {
	return notebook->SetSelection(page);
}

void bmx_wxauinotebook_settabctrlheight(wxAuiNotebook * notebook, int height) {
	notebook->SetTabCtrlHeight(height);
}

void bmx_wxauinotebook_setuniformbitmapsize(wxAuiNotebook * notebook, int w, int h) {
	notebook->SetUniformBitmapSize(wxSize(w, h));
}

void bmx_wxauinotebook_split(wxAuiNotebook * notebook, int page, int direction) {
	notebook->Split(page, direction);
}

int bmx_wxauinotebook_showwindowmenu(wxAuiNotebook * notebook) {
	return static_cast<int>(notebook->ShowWindowMenu());
}



// *********************************************

int bmx_wxaui_geteventtype(int type) {
	switch(type) {
		case -20: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE;
		case -21: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSED;
		case -22: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED;
		case -23: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING;
		case -24: return wxEVT_COMMAND_AUINOTEBOOK_BUTTON;
		case -25: return wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG;
		case -26: return wxEVT_COMMAND_AUINOTEBOOK_END_DRAG;
		case -27: return wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION;
		case -28: return wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND;
		case -29: return wxEVT_AUI_PANE_BUTTON;
		case -30: return wxEVT_AUI_PANE_CLOSE;
		case -31: return wxEVT_AUI_PANE_MAXIMIZE;
		case -32: return wxEVT_AUI_PANE_RESTORE;
		case -33: return wxEVT_AUI_RENDER;
		case -34: return wxEVT_AUI_FIND_MANAGER;
		case -35: return wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_DOWN;
		case -36: return wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_UP;
		case -37: return wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_DOWN;
		case -38: return wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_UP;
		case -39: return wxEVT_COMMAND_AUINOTEBOOK_DRAG_DONE;
		case -40: return wxEVT_COMMAND_AUINOTEBOOK_BG_DCLICK;
	}
	
	return 0;
}

