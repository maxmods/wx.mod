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


MaxAuiToolBar::MaxAuiToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxAuiToolBar(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxAuiToolBar::~MaxAuiToolBar() {
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


MaxAuiPaneInfo * bmx_wxauipaneinfo_create() {
	return new MaxAuiPaneInfo();
}

void bmx_wxauipaneinfo_delete(MaxAuiPaneInfo * info) {
	delete info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_bestsize(MaxAuiPaneInfo * info, int w, int h) {
	info->Info().BestSize(wxSize(w, h));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_bottom(MaxAuiPaneInfo * info) {
	info->Info().Bottom();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_bottomdockable(MaxAuiPaneInfo * info, int dockable) {
	info->Info().BottomDockable(static_cast<bool>(dockable));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_caption(MaxAuiPaneInfo * info, BBString * caption) {
	info->Info().Caption(wxStringFromBBString(caption));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_captionvisible(MaxAuiPaneInfo * info, int visible) {
	info->Info().CaptionVisible(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_centre(MaxAuiPaneInfo * info) {
	info->Info().Centre();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_center(MaxAuiPaneInfo * info) {
	info->Info().Center();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_centrepane(MaxAuiPaneInfo * info) {
	info->Info().CentrePane();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_centerpane(MaxAuiPaneInfo * info) {
	info->Info().CenterPane();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_closebutton(MaxAuiPaneInfo * info, int visible) {
	info->Info().CloseButton(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_defaultpane(MaxAuiPaneInfo * info) {
	info->Info().DefaultPane();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_destroyonclose(MaxAuiPaneInfo * info, int dest) {
	info->Info().DestroyOnClose(static_cast<bool>(dest));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_direction(MaxAuiPaneInfo * info, int dir) {
	info->Info().Direction(dir);
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_dock(MaxAuiPaneInfo * info) {
	info->Info().Dock();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_dockable(MaxAuiPaneInfo * info, int dock) {
	info->Info().Dockable(static_cast<bool>(dock));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_fixed(MaxAuiPaneInfo * info) {
	info->Info().Fixed();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_floatpane(MaxAuiPaneInfo * info) {
	info->Info().Float();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_floatable(MaxAuiPaneInfo * info, int value) {
	info->Info().Floatable(static_cast<bool>(value));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_floatingposition(MaxAuiPaneInfo * info, int x, int y) {
	info->Info().FloatingPosition(wxPoint(x, y));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_floatingsize(MaxAuiPaneInfo * info, int w, int h) {
	info->Info().FloatingSize(wxSize(w, h));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_gripper(MaxAuiPaneInfo * info, int visible) {
	info->Info().Gripper(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_grippertop(MaxAuiPaneInfo * info, int attop) {
	info->Info().GripperTop(static_cast<bool>(attop));
	return info;
}


int bmx_wxauipaneinfo_hasborder(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasBorder());
}

int bmx_wxauipaneinfo_hascaption(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasCaption());
}

int bmx_wxauipaneinfo_hasclosebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasCloseButton());
}

int bmx_wxauipaneinfo_hasflag(MaxAuiPaneInfo * info, unsigned int flag) {
	return static_cast<int>(info->Info().HasFlag(flag));
}

int bmx_wxauipaneinfo_hasgripper(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasGripper());
}

int bmx_wxauipaneinfo_hasgrippertop(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasGripperTop());
}

int bmx_wxauipaneinfo_hasmaximizebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasMaximizeButton());
}

int bmx_wxauipaneinfo_hasminimizebutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasMinimizeButton());
}

int bmx_wxauipaneinfo_haspinbutton(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().HasPinButton());
}


MaxAuiPaneInfo * bmx_wxauipaneinfo_hide(MaxAuiPaneInfo * info) {
	info->Info().Hide();
	return info;
}

int bmx_wxauipaneinfo_isbottomdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsBottomDockable());
}

int bmx_wxauipaneinfo_isdocked(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsDocked());
}

int bmx_wxauipaneinfo_isfixed(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFixed());
}

int bmx_wxauipaneinfo_isfloatable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFloatable());
}

int bmx_wxauipaneinfo_isfloating(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsFloating());
}

int bmx_wxauipaneinfo_isleftdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsLeftDockable());
}

int bmx_wxauipaneinfo_ismovable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsMovable());
}

int bmx_wxauipaneinfo_isok(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsOk());
}

int bmx_wxauipaneinfo_isresizable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsResizable());
}

int bmx_wxauipaneinfo_isrightdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsRightDockable());
}

int bmx_wxauipaneinfo_isshown(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsShown());
}

int bmx_wxauipaneinfo_istoolbar(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsToolbar());
}

int bmx_wxauipaneinfo_istopdockable(MaxAuiPaneInfo * info) {
	return static_cast<int>(info->Info().IsTopDockable());
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_layer(MaxAuiPaneInfo * info, int value) {
	info->Info().Layer(value);
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_left(MaxAuiPaneInfo * info) {
	info->Info().Left();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_leftdockable(MaxAuiPaneInfo * info, int dockable) {
	info->Info().LeftDockable(static_cast<bool>(dockable));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_maxsize(MaxAuiPaneInfo * info, int w, int h) {
	info->Info().MaxSize(wxSize(w, h));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_maximizebutton(MaxAuiPaneInfo * info, int visible) {
	info->Info().MaximizeButton(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_minsize(MaxAuiPaneInfo * info, int w, int h) {
	info->Info().MinSize(wxSize(w, h));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_minimizebutton(MaxAuiPaneInfo * info, int visible) {
	info->Info().MinimizeButton(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_movable(MaxAuiPaneInfo * info, int move) {
	info->Info().Movable(static_cast<bool>(move));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_name(MaxAuiPaneInfo * info, BBString * n) {
	info->Info().Name(wxStringFromBBString(n));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_paneborder(MaxAuiPaneInfo * info, int visible) {
	info->Info().PaneBorder(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_pinbutton(MaxAuiPaneInfo * info, int visible) {
	info->Info().PinButton(static_cast<bool>(visible));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_position(MaxAuiPaneInfo * info, int pos) {
	info->Info().Position(pos);
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_resizable(MaxAuiPaneInfo * info, int value) {
	info->Info().Resizable(static_cast<bool>(value));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_right(MaxAuiPaneInfo * info) {
	info->Info().Right();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_rightdockable(MaxAuiPaneInfo * info, int dockable) {
	info->Info().RightDockable(static_cast<bool>(dockable));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_row(MaxAuiPaneInfo * info, int value) {
	info->Info().Row(value);
	return info;
}

void bmx_wxauipaneinfo_safeset(MaxAuiPaneInfo * info, MaxAuiPaneInfo * source) {
	info->Info().SafeSet(source->Info());
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_setflag(MaxAuiPaneInfo * info, unsigned int flag, int option_state) {
	info->Info().SetFlag(flag, static_cast<bool>(option_state));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_show(MaxAuiPaneInfo * info, int value) {
	info->Info().Show(static_cast<bool>(value));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_toolbarpane(MaxAuiPaneInfo * info) {
	info->Info().ToolbarPane();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_top(MaxAuiPaneInfo * info) {
	info->Info().Top();
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_topdocakable(MaxAuiPaneInfo * info, int value) {
	info->Info().TopDockable(static_cast<bool>(value));
	return info;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_window(MaxAuiPaneInfo * info, wxWindow * window) {
	info->Info().Window(window);
	return info;
}

BBString * bmx_wxauipaneinfo_getcaption(MaxAuiPaneInfo * info) {
	return bbStringFromWxString(info->Info().caption);
}

BBString * bmx_wxauipaneinfo_getname(MaxAuiPaneInfo * info) {
	return bbStringFromWxString(info->Info().name);
}

unsigned int bmx_wxauipaneinfo_getstate(MaxAuiPaneInfo * info) {
	return info->Info().state;
}

int bmx_wxauipaneinfo_getdirection(MaxAuiPaneInfo * info) {
	return info->Info().dock_direction;
}

int bmx_wxauipaneinfo_getlayer(MaxAuiPaneInfo * info) {
	return info->Info().dock_layer;
}

int bmx_wxauipaneinfo_getrow(MaxAuiPaneInfo * info) {
	return info->Info().dock_row;
}

int bmx_wxauipaneinfo_getpos(MaxAuiPaneInfo * info) {
	return info->Info().dock_pos;
}

void bmx_wxauipaneinfo_getfloatingpos(MaxAuiPaneInfo * info, int * x, int * y) {
	wxPoint p = info->Info().floating_pos;
	*x = p.x;
	*y = p.y;
}

void bmx_wxauipaneinfo_getfloatingsize(MaxAuiPaneInfo * info, int * w, int * h) {
	wxSize p = info->Info().floating_size;
	*w = p.x;
	*h = p.y;
}

MaxAuiPaneInfo * bmx_wxauipaneinfo_dockfixed(MaxAuiPaneInfo * info) {
	info->Info().DockFixed();
	return info;
}

wxWindow * bmx_wxauipaneinfo_getwindow(MaxAuiPaneInfo * info) {
	return info->Info().window;
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

MaxAuiToolBar * bmx_wxauitoolbar_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {

	return new MaxAuiToolBar(maxHandle, parent, id, x, y, w, h, style);
}

void bmx_wxauitoolbar_setwindowstyle(wxAuiToolBar * tb, int style) {
	tb->SetWindowStyle(style);
}

int bmx_wxauitoolbar_getwindowstyle(wxAuiToolBar * tb) {
	return static_cast<int>(tb->GetWindowStyle());
}

void bmx_wxauitoolbar_setartprovider(wxAuiToolBar * tb, wxAuiToolBarArt * art) {
	tb->SetArtProvider(art);
}

wxAuiToolBarArt * bmx_wxauitoolbar_getartprovider(wxAuiToolBar * tb) {
	return tb->GetArtProvider();
}

int bmx_wxauitoolbar_setfont(wxAuiToolBar * tb, MaxFont * font) {
	return static_cast<int>(tb->SetFont(font->Font()));
}

wxAuiToolBarItem * bmx_wxauitoolbar_addtool(wxAuiToolBar * tb, int toolId, BBString * label, MaxBitmap * bitmap, BBString * shortHelp, int kind) {
	return tb->AddTool(toolId, wxStringFromBBString(label), bitmap->Bitmap(), wxStringFromBBString(shortHelp), static_cast<wxItemKind>(kind));
}

wxAuiToolBarItem * bmx_wxauitoolbar_addlabel(wxAuiToolBar * tb, int toolId, BBString * label, int width) {
	return tb->AddLabel(toolId, wxStringFromBBString(label), width);
}

wxAuiToolBarItem * bmx_wxauitoolbar_addcontrol(wxAuiToolBar * tb, wxControl * control, BBString * label) {
	return tb->AddControl(control, wxStringFromBBString(label));
}

wxAuiToolBarItem * bmx_wxauitoolbar_addseparator(wxAuiToolBar * tb) {
	return tb->AddSeparator();
}

wxAuiToolBarItem * bmx_wxauitoolbar_addspacer(wxAuiToolBar * tb, int pixels) {
	return tb->AddSpacer(pixels);
}

wxAuiToolBarItem * bmx_wxauitoolbar_addstretchspacer(wxAuiToolBar * tb, int proportion) {
	return tb->AddStretchSpacer(proportion);
}

int bmx_wxauitoolbar_realize(wxAuiToolBar * tb) {
	return static_cast<int>(tb->Realize());
}

wxControl * bmx_wxauitoolbar_findcontrol(wxAuiToolBar * tb, int windowId) {
	return tb->FindControl(windowId);
}

wxAuiToolBarItem * bmx_wxauitoolbar_findtoolbyposition(wxAuiToolBar * tb, int x, int y) {
	return tb->FindToolByPosition(x, y);
}

wxAuiToolBarItem * bmx_wxauitoolbar_findtoolbyindex(wxAuiToolBar * tb, int idx) {
	return tb->FindToolByIndex(idx);
}

wxAuiToolBarItem * bmx_wxauitoolbar_findtool(wxAuiToolBar * tb, int toolId) {
	return tb->FindTool(toolId);
}

void bmx_wxauitoolbar_cleartools(wxAuiToolBar * tb) {
	tb->ClearTools();
}

void bmx_wxauitoolbar_clear(wxAuiToolBar * tb) {
	tb->Clear();
}

int bmx_wxauitoolbar_deletetool(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->DeleteTool(toolId));
}

int bmx_wxauitoolbar_deletebyindex(wxAuiToolBar * tb, int idx) {
	return static_cast<int>(tb->DeleteByIndex(idx));
}

int bmx_wxauitoolbar_gettoolcount(wxAuiToolBar * tb) {
	return static_cast<int>(tb->GetToolCount());
}

int bmx_wxauitoolbar_gettoolpos(wxAuiToolBar * tb, int toolId) {
	return tb->GetToolPos(toolId);
}

int bmx_wxauitoolbar_gettoolindex(wxAuiToolBar * tb, int toolId) {
	return tb->GetToolIndex(toolId);
}

int bmx_wxauitoolbar_gettoolfits(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->GetToolFits(toolId));
}

void bmx_wxauitoolbar_gettoolrect(wxAuiToolBar * tb, int toolId, int * x, int * y, int * w, int * h) {
	wxRect r(tb->GetToolRect(toolId));
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

int bmx_wxauitoolbar_gettoolfitsbyindex(wxAuiToolBar * tb, int idx) {
	return static_cast<int>(tb->GetToolFitsByIndex(idx));
}

int bmx_wxauitoolbar_gettoolbarfits(wxAuiToolBar * tb) {
	return static_cast<int>(tb->GetToolBarFits());
}

void bmx_wxauitoolbar_setmargins(wxAuiToolBar * tb, int w, int h) {
	tb->SetMargins(w, h);
}

void bmx_wxauitoolbar_setmarginsrect(wxAuiToolBar * tb, int Left, int Right, int top, int bottom) {
	tb->SetMargins(Left, Right, top, bottom);
}

void bmx_wxauitoolbar_settoolbitmapsize(wxAuiToolBar * tb, int w, int h) {
	tb->SetToolBitmapSize(wxSize(w, h));
}

void bmx_wxauitoolbar_gettoolbitmapsize(wxAuiToolBar * tb, int * w, int * h) {
	wxSize s(tb->GetToolBitmapSize());
	*w = s.GetWidth();
	*h = s.GetHeight();
}

int bmx_wxauitoolbar_getoverflowvisible(wxAuiToolBar * tb) {
	return static_cast<int>(tb->GetOverflowVisible());
}

void bmx_wxauitoolbar_setoverflowvisible(wxAuiToolBar * tb, int visible) {
	tb->SetOverflowVisible(static_cast<bool>(visible));
}

int bmx_wxauitoolbar_getgrippervisible(wxAuiToolBar * tb) {
	return static_cast<int>(tb->GetGripperVisible());
}

void bmx_wxauitoolbar_setgrippervisible(wxAuiToolBar * tb, int visible) {
	tb->SetGripperVisible(static_cast<bool>(visible));
}

void bmx_wxauitoolbar_toggletool(wxAuiToolBar * tb, int toolId, int state) {
	tb->ToggleTool(toolId, static_cast<bool>(state));
}

int bmx_wxauitoolbar_gettooltoggled(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->GetToolToggled(toolId));
}

void bmx_wxauitoolbar_enabletool(wxAuiToolBar * tb, int toolId, int state) {
	tb->EnableTool(toolId, static_cast<bool>(state));
}

int bmx_wxauitoolbar_gettoolenabled(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->GetToolEnabled(toolId));
}

void bmx_wxauitoolbar_settooldropdown(wxAuiToolBar * tb, int toolId, int dropdown) {
	tb->SetToolDropDown(toolId, static_cast<bool>(dropdown));
}

int bmx_wxauitoolbar_gettooldropdown(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->GetToolDropDown(toolId));
}

void bmx_wxauitoolbar_settoolborderpadding(wxAuiToolBar * tb, int padding) {
	tb->SetToolBorderPadding(padding);
}

int bmx_wxauitoolbar_gettoolborderpadding(wxAuiToolBar * tb) {
	return tb->GetToolBorderPadding();
}

void bmx_wxauitoolbar_settooltextorientation(wxAuiToolBar * tb, int orientation) {
	tb->SetToolTextOrientation(orientation);
}

int bmx_wxauitoolbar_gettooltextorientation(wxAuiToolBar * tb) {
	return tb->GetToolTextOrientation();
}

void bmx_wxauitoolbar_settoolpacking(wxAuiToolBar * tb, int packing) {
	tb->SetToolPacking(packing);
}

int bmx_wxauitoolbar_gettoolpacking(wxAuiToolBar * tb) {
	return tb->GetToolPacking();
}

void bmx_wxauitoolbar_settoolproportion(wxAuiToolBar * tb, int toolId, int proportion) {
	tb->SetToolProportion(toolId, proportion);
}

int bmx_wxauitoolbar_gettoolproportion(wxAuiToolBar * tb, int toolId) {
	return tb->GetToolProportion(toolId);
}

void bmx_wxauitoolbar_settoolseparation(wxAuiToolBar * tb, int separation) {
	tb->SetToolSeparation(separation);
}

int bmx_wxauitoolbar_gettoolseparation(wxAuiToolBar * tb) {
	return tb->GetToolSeparation();
}

void bmx_wxauitoolbar_settoolsticky(wxAuiToolBar * tb, int toolId, int sticky) {
	tb->SetToolSticky(toolId, static_cast<bool>(sticky));
}

int bmx_wxauitoolbar_gettoolsticky(wxAuiToolBar * tb, int toolId) {
	return static_cast<int>(tb->GetToolSticky(toolId));
}

BBString * bmx_wxauitoolbar_gettoollabel(wxAuiToolBar * tb, int toolId) {
	return bbStringFromWxString(tb->GetToolLabel(toolId));
}

void bmx_wxauitoolbar_settoollabel(wxAuiToolBar * tb, int toolId, BBString * label) {
	tb->SetToolLabel(toolId, wxStringFromBBString(label));
}

MaxBitmap * bmx_wxauitoolbar_gettoolbitmap(wxAuiToolBar * tb, int toolId) {
	wxBitmap b(tb->GetToolBitmap(toolId));
	return new MaxBitmap(b);
}

void bmx_wxauitoolbar_settoolbitmap(wxAuiToolBar * tb, int toolId, MaxBitmap * bitmap) {
	tb->SetToolBitmap(toolId, bitmap->Bitmap());
}

BBString * bmx_wxauitoolbar_gettoolshorthelp(wxAuiToolBar * tb, int toolId) {
	return bbStringFromWxString(tb->GetToolShortHelp(toolId));
}

void bmx_wxauitoolbar_settoolshorthelp(wxAuiToolBar * tb, int toolId, BBString * helpString) {
	tb->SetToolShortHelp(toolId, wxStringFromBBString(helpString));
}

BBString * bmx_wxauitoolbar_gettoollonghelp(wxAuiToolBar * tb, int toolId) {
	return bbStringFromWxString(tb->GetToolLongHelp(toolId));
}

void bmx_wxauitoolbar_settoollonghelp(wxAuiToolBar * tb, int toolId, BBString * helpString) {
	tb->SetToolLongHelp(toolId, wxStringFromBBString(helpString));
}

void bmx_wxauitoolbar_gethintsize(wxAuiToolBar * tb, int dockDirection, int * w, int * h) {
	wxSize s(tb->GetHintSize(dockDirection));
	*w = s.GetWidth();
	*h = s.GetHeight();
}

int bmx_wxauitoolbar_ispanevalid(wxAuiToolBar * tb, MaxAuiPaneInfo * pane) {
	return static_cast<int>(tb->IsPaneValid(pane->Info()));
}

// *********************************************

int bmx_wxauitoolbarevent_isdropdownclicked(wxAuiToolBarEvent & event) {
	return static_cast<int>(event.IsDropDownClicked());
}

void bmx_wxauitoolbarevent_getclickpoint(wxAuiToolBarEvent & event, int * x, int * y) {
	wxPoint p(event.GetClickPoint());
	*x = p.x;
	*y = p.y;
}

void bmx_wxauitoolbarevent_getitemrect(wxAuiToolBarEvent & event, int * x, int * y, int * w, int * h) {
	wxRect r(event.GetItemRect());
	*x = r.GetX();
	*y = r.GetY();
	*w = r.GetWidth();
	*h = r.GetHeight();
}

int bmx_wxauitoolbarevent_gettoolid(wxAuiToolBarEvent & event) {
	return event.GetToolId();
}


// *********************************************

void bmx_wxauitoolbaritem_setwindow(wxAuiToolBarItem * item, wxWindow * w) {
	item->SetWindow(w);
}

wxWindow * bmx_wxauitoolbaritem_getwindow(wxAuiToolBarItem * item) {
	return item->GetWindow();
}

void bmx_wxauitoolbaritem_setid(wxAuiToolBarItem * item, int newId) {
	item->SetId(newId);
}

int bmx_wxauitoolbaritem_getid(wxAuiToolBarItem * item) {
	return item->GetId();
}

void bmx_wxauitoolbaritem_setkind(wxAuiToolBarItem * item, int newKind) {
	item->SetKind(newKind);
}

int bmx_wxauitoolbaritem_getkind(wxAuiToolBarItem * item) {
	return item->GetKind();
}

void bmx_wxauitoolbaritem_setstate(wxAuiToolBarItem * item, int newState) {
	item->SetState(newState);
}

int bmx_wxauitoolbaritem_getstate(wxAuiToolBarItem * item) {
	return item->GetState();
}

void bmx_wxauitoolbaritem_setSizerItem(wxAuiToolBarItem * item, wxSizerItem * s) {
	item->SetSizerItem(s);
}

wxSizerItem * bmx_wxauitoolbaritem_getsizeritem(wxAuiToolBarItem * item) {
	return item->GetSizerItem();
}

void bmx_wxauitoolbaritem_setlabel(wxAuiToolBarItem * item, BBString * s) {
	item->SetLabel(wxStringFromBBString(s));
}

BBString * bmx_wxauitoolbaritem_getlabel(wxAuiToolBarItem * item) {
	return bbStringFromWxString(item->GetLabel());
}

void bmx_wxauitoolbaritem_setbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp) {
	item->SetBitmap(bmp->Bitmap());
}

MaxBitmap * bmx_wxauitoolbaritem_getbitmap(wxAuiToolBarItem * item) {
	wxBitmap b(item->GetBitmap());
	return new MaxBitmap(b);
}

void bmx_wxauitoolbaritem_setdisabledbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp) {
	item->SetDisabledBitmap(bmp->Bitmap());
}

MaxBitmap * bmx_wxauitoolbaritem_getdisabledbitmap(wxAuiToolBarItem * item) {
	wxBitmap b(item->GetDisabledBitmap());
	return new MaxBitmap(b);
}

void bmx_wxauitoolbaritem_sethoverbitmap(wxAuiToolBarItem * item, MaxBitmap * bmp) {
	item->SetHoverBitmap(bmp->Bitmap());
}

MaxBitmap * bmx_wxauitoolbaritem_gethoverbitmap(wxAuiToolBarItem * item) {
	wxBitmap b(item->GetHoverBitmap());
	return new MaxBitmap(b);
}

void bmx_wxauitoolbaritem_setshorthelp(wxAuiToolBarItem * item, BBString * s) {
	item->SetShortHelp(wxStringFromBBString(s));
}

BBString * bmx_wxauitoolbaritem_getshorthelp(wxAuiToolBarItem * item) {
	return bbStringFromWxString(item->GetShortHelp());
}

void bmx_wxauitoolbaritem_setlonghelp(wxAuiToolBarItem * item, BBString * s) {
	item->SetLongHelp(wxStringFromBBString(s));
}

BBString * bmx_wxauitoolbaritem_getlonghelp(wxAuiToolBarItem * item) {
	return bbStringFromWxString(item->GetLongHelp());
}

void bmx_wxauitoolbaritem_setminsize(wxAuiToolBarItem * item, int w, int h) {
	item->SetMinSize(wxSize(w, h));
}

void bmx_wxauitoolbaritem_getminsize(wxAuiToolBarItem * item, int * w, int * h) {
	wxSize s(item->GetMinSize());
	*w = s.GetWidth();
	*h = s.GetHeight();
}

void bmx_wxauitoolbaritem_setspacerpixels(wxAuiToolBarItem * item, int s) {
	item->SetSpacerPixels(s);
}

int bmx_wxauitoolbaritem_getspacerpixels(wxAuiToolBarItem * item) {
	return item->GetSpacerPixels();
}

void bmx_wxauitoolbaritem_setproportion(wxAuiToolBarItem * item, int p) {
	item->SetProportion(p);
}

int bmx_wxauitoolbaritem_getproportion(wxAuiToolBarItem * item) {
	return item->GetProportion();
}

void bmx_wxauitoolbaritem_setactive(wxAuiToolBarItem * item, int active) {
	item->SetActive(static_cast<bool>(active));
}

int bmx_wxauitoolbaritem_isactive(wxAuiToolBarItem * item) {
	return static_cast<int>(item->IsActive());
}

void bmx_wxauitoolbaritem_sethasdropdown(wxAuiToolBarItem * item, int value) {
	item->SetHasDropDown(static_cast<bool>(value));
}

int bmx_wxauitoolbaritem_hasdropdown(wxAuiToolBarItem * item) {
	return static_cast<int>(item->HasDropDown());
}

void bmx_wxauitoolbaritem_setsticky(wxAuiToolBarItem * item, int value) {
	item->SetSticky(static_cast<bool>(value));
}

int bmx_wxauitoolbaritem_issticky(wxAuiToolBarItem * item) {
	return static_cast<int>(item->IsSticky());
}

void bmx_wxauitoolbaritem_setuserdata(wxAuiToolBarItem * item, int data) {
	item->SetUserData(static_cast<long>(data));
}

int bmx_wxauitoolbaritem_getuserdata(wxAuiToolBarItem * item) {
	return static_cast<int>(item->GetUserData());
}

void bmx_wxauitoolbaritem_setalignment(wxAuiToolBarItem * item, int value) {
	item->SetAlignment(value);
}

int bmx_wxauitoolbaritem_getalignment(wxAuiToolBarItem * item) {
	return item->GetAlignment();
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
		case -41: return wxEVT_AUITOOLBAR_TOOL_DROPDOWN;
		case -42: return wxEVT_AUITOOLBAR_OVERFLOW_CLICK;
		case -43: return wxEVT_AUITOOLBAR_RIGHT_CLICK;
		case -44: return wxEVT_AUITOOLBAR_MIDDLE_CLICK;
		case -45: return wxEVT_AUITOOLBAR_BEGIN_DRAG;
	}
	
	return 0;
}

