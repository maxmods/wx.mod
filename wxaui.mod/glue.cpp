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

bool bmx_wxauimanager_addpane(MaxAuiManager * manager, wxWindow * window, int direction, BBString * caption) {
	return manager->AddPane(window, direction, wxStringFromBBString(caption));
}

bool bmx_wxauimanager_addpaneinfo(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * panelinfo, int dx, int dy) {
	if ((dx == -1) || (dy == -1)) {
		return manager->AddPane(window, panelinfo->Info());
	} else {
		return manager->AddPane(window, panelinfo->Info(), wxPoint(dx, dy));
	}
}

bool bmx_wxauimanager_detachpane(MaxAuiManager * manager, wxWindow * window) {
	return manager->DetachPane(window);
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

bool bmx_wxauimanager_insertpane(MaxAuiManager * manager, wxWindow * window, MaxAuiPaneInfo * location, int level) {
	return manager->InsertPane(window, location->Info(), level);
}

MaxAuiPaneInfo * bmx_wxauimanager_loadpaneinfo(MaxAuiManager * manager, BBString * panePart) {
	wxAuiPaneInfo pane;
	manager->LoadPaneInfo(wxStringFromBBString(panePart), pane);
	return new MaxAuiPaneInfo(pane);
}

bool bmx_wxauimanager_loadperspective(MaxAuiManager * manager, BBString * perspective, bool update) {
	return manager->LoadPerspective(wxStringFromBBString(perspective), update);
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

MaxAuiPaneInfo * bmx_wxauipanelinfo_bottomdockable(MaxAuiPaneInfo * info, bool dockable) {
	return new MaxAuiPaneInfo(info->Info().BottomDockable(dockable));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_caption(MaxAuiPaneInfo * info, BBString * caption) {
	return new MaxAuiPaneInfo(info->Info().Caption(wxStringFromBBString(caption)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_captionvisible(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().CaptionVisible(visible));
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

MaxAuiPaneInfo * bmx_wxauipanelinfo_closebutton(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().CloseButton(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_defaultpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().DefaultPane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_destroyonclose(MaxAuiPaneInfo * info, bool dest) {
	return new MaxAuiPaneInfo(info->Info().DestroyOnClose(dest));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_direction(MaxAuiPaneInfo * info, int dir) {
	return new MaxAuiPaneInfo(info->Info().Direction(dir));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_dock(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Dock());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_dockable(MaxAuiPaneInfo * info, bool dock) {
	return new MaxAuiPaneInfo(info->Info().Dockable(dock));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_fixed(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Fixed());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Float());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatable(MaxAuiPaneInfo * info, bool value) {
	return new MaxAuiPaneInfo(info->Info().Floatable(value));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingposition(MaxAuiPaneInfo * info, int x, int y) {
	return new MaxAuiPaneInfo(info->Info().FloatingPosition(wxPoint(x, y)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_floatingsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().FloatingSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_gripper(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().Gripper(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_grippertop(MaxAuiPaneInfo * info, bool attop) {
	return new MaxAuiPaneInfo(info->Info().GripperTop(attop));
}


bool bmx_wxauipanelinfo_hasborder(MaxAuiPaneInfo * info) {
	return info->Info().HasBorder();
}

bool bmx_wxauipanelinfo_hascaption(MaxAuiPaneInfo * info) {
	return info->Info().HasCaption();
}

bool bmx_wxauipanelinfo_hasclosebutton(MaxAuiPaneInfo * info) {
	return info->Info().HasCloseButton();
}

bool bmx_wxauipanelinfo_hasflag(MaxAuiPaneInfo * info, unsigned int flag) {
	return info->Info().HasFlag(flag);
}

bool bmx_wxauipanelinfo_hasgripper(MaxAuiPaneInfo * info) {
	return info->Info().HasGripper();
}

bool bmx_wxauipanelinfo_hasgrippertop(MaxAuiPaneInfo * info) {
	return info->Info().HasGripperTop();
}

bool bmx_wxauipanelinfo_hasmaximizebutton(MaxAuiPaneInfo * info) {
	return info->Info().HasMaximizeButton();
}

bool bmx_wxauipanelinfo_hasminimizebutton(MaxAuiPaneInfo * info) {
	return info->Info().HasMinimizeButton();
}

bool bmx_wxauipanelinfo_haspinbutton(MaxAuiPaneInfo * info) {
	return info->Info().HasPinButton();
}


MaxAuiPaneInfo * bmx_wxauipanelinfo_hide(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Hide());
}

bool bmx_wxauipanelinfo_isbottomdockable(MaxAuiPaneInfo * info) {
	return info->Info().IsBottomDockable();
}

bool bmx_wxauipanelinfo_isdocked(MaxAuiPaneInfo * info) {
	return info->Info().IsDocked();
}

bool bmx_wxauipanelinfo_isfixed(MaxAuiPaneInfo * info) {
	return info->Info().IsFixed();
}

bool bmx_wxauipanelinfo_isfloatable(MaxAuiPaneInfo * info) {
	return info->Info().IsFloatable();
}

bool bmx_wxauipanelinfo_isfloating(MaxAuiPaneInfo * info) {
	return info->Info().IsFloating();
}

bool bmx_wxauipanelinfo_isleftdockable(MaxAuiPaneInfo * info) {
	return info->Info().IsLeftDockable();
}

bool bmx_wxauipanelinfo_ismovable(MaxAuiPaneInfo * info) {
	return info->Info().IsMovable();
}

bool bmx_wxauipanelinfo_isok(MaxAuiPaneInfo * info) {
	return info->Info().IsOk();
}

bool bmx_wxauipanelinfo_isresizable(MaxAuiPaneInfo * info) {
	return info->Info().IsResizable();
}

bool bmx_wxauipanelinfo_isrightdockable(MaxAuiPaneInfo * info) {
	return info->Info().IsRightDockable();
}

bool bmx_wxauipanelinfo_isshown(MaxAuiPaneInfo * info) {
	return info->Info().IsShown();
}

bool bmx_wxauipanelinfo_istoolbar(MaxAuiPaneInfo * info) {
	return info->Info().IsToolbar();
}

bool bmx_wxauipanelinfo_istopdockable(MaxAuiPaneInfo * info) {
	return info->Info().IsTopDockable();
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_layer(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Layer(value));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_left(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Left());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_leftdockable(MaxAuiPaneInfo * info, bool dockable) {
	return new MaxAuiPaneInfo(info->Info().LeftDockable(dockable));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_maxsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().MaxSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_maximizebutton(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().MaximizeButton(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_minsize(MaxAuiPaneInfo * info, int w, int h) {
	return new MaxAuiPaneInfo(info->Info().MinSize(wxSize(w, h)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_minimizebutton(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().MinimizeButton(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_movable(MaxAuiPaneInfo * info, bool move) {
	return new MaxAuiPaneInfo(info->Info().Movable(move));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_name(MaxAuiPaneInfo * info, BBString * n) {
	return new MaxAuiPaneInfo(info->Info().Name(wxStringFromBBString(n)));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_paneborder(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().PaneBorder(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_pinbutton(MaxAuiPaneInfo * info, bool visible) {
	return new MaxAuiPaneInfo(info->Info().PinButton(visible));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_position(MaxAuiPaneInfo * info, int pos) {
	return new MaxAuiPaneInfo(info->Info().Position(pos));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_resizable(MaxAuiPaneInfo * info, bool value) {
	return new MaxAuiPaneInfo(info->Info().Resizable(value));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_right(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Right());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_rightdockable(MaxAuiPaneInfo * info, bool dockable) {
	return new MaxAuiPaneInfo(info->Info().RightDockable(dockable));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_row(MaxAuiPaneInfo * info, int value) {
	return new MaxAuiPaneInfo(info->Info().Row(value));
}

void bmx_wxauipanelinfo_safeset(MaxAuiPaneInfo * info, MaxAuiPaneInfo * source) {
	info->Info().SafeSet(source->Info());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_setflag(MaxAuiPaneInfo * info, unsigned int flag, bool option_state) {
	return new MaxAuiPaneInfo(info->Info().SetFlag(flag, option_state));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_show(MaxAuiPaneInfo * info, bool value) {
	return new MaxAuiPaneInfo(info->Info().Show(value));
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_toolbarpane(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().ToolbarPane());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_top(MaxAuiPaneInfo * info) {
	return new MaxAuiPaneInfo(info->Info().Top());
}

MaxAuiPaneInfo * bmx_wxauipanelinfo_topdocakable(MaxAuiPaneInfo * info, bool value) {
	return new MaxAuiPaneInfo(info->Info().TopDockable(value));
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


MaxAuiPaneInfo * bmx_wxauimanagerevent_getpane(wxAuiManagerEvent & event) {
	return new MaxAuiPaneInfo(*event.pane);
}

int bmx_wxauimanagerevent_getbutton(wxAuiManagerEvent & event) {
	return event.button;
}

void bmx_wxauimanagerevent_veto(wxAuiManagerEvent & event, bool veto) {
	event.Veto(veto);
}


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

// *********************************************

MaxAuiNotebook * bmx_wxauinotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {

	return new MaxAuiNotebook(maxHandle, parent, id, x, y, w, h, style);
}
		
bool bmx_wxauinotebook_addpage(MaxAuiNotebook * notebook, wxWindow * page, BBString * caption, bool sel, MaxBitmap * bitmap) {
	if (bitmap) {
		return notebook->AddPage(page, wxStringFromBBString(caption), sel, bitmap->Bitmap());
	} else {
		return notebook->AddPage(page, wxStringFromBBString(caption), sel);
	}
}

void bmx_wxauinotebook_advanceselection(wxAuiNotebook * notebook, bool forward) {
	notebook->AdvanceSelection(forward);
}

bool bmx_wxauinotebook_deletepage(wxAuiNotebook * notebook, int page) {
	return notebook->DeletePage(page);
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

bool bmx_wxauinotebook_insertpage(wxAuiNotebook * notebook, int index, wxWindow * page, BBString * caption, bool sel, MaxBitmap * bitmap) {
	if (bitmap) {
		return notebook->InsertPage(index, page, wxStringFromBBString(caption), sel, bitmap->Bitmap());
	} else {
		return notebook->InsertPage(index, page, wxStringFromBBString(caption), sel);
	}
}

bool bmx_wxauinotebook_removepage(wxAuiNotebook * notebook, int page) {
	return notebook->RemovePage(page);
}

void bmx_wxauinotebook_setartprovider(wxAuiNotebook * notebook, wxAuiTabArt * art) {
	notebook->SetArtProvider(art);
}

bool bmx_wxauinotebook_setfont(wxAuiNotebook * notebook, MaxFont * font) {
	return notebook->SetFont(font->Font());
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

bool bmx_wxauinotebook_setpagebitmap(wxAuiNotebook * notebook, int page, MaxBitmap * bitmap) {
	return notebook->SetPageBitmap(page, bitmap->Bitmap());
}

bool bmx_wxauinotebook_setpagetext(wxAuiNotebook * notebook, int page, BBString * text) {
	return notebook->SetPageText(page, wxStringFromBBString(text));
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

bool bmx_wxauinotebook_showwindowmenu(wxAuiNotebook * notebook) {
	return notebook->ShowWindowMenu();
}



// *********************************************

int bmx_wxaui_geteventtype(int type) {
	switch(type) {
		case -20: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE;
		case -21: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED;
		case -22: return wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING;
		case -23: return wxEVT_COMMAND_AUINOTEBOOK_BUTTON;
		case -24: return wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG;
		case -25: return wxEVT_COMMAND_AUINOTEBOOK_END_DRAG;
		case -26: return wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION;
		case -27: return wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND;
		case -28: return wxEVT_AUI_PANE_BUTTON;
		case -29: return wxEVT_AUI_PANE_CLOSE;
		case -30: return wxEVT_AUI_PANE_MAXIMIZE;
		case -31: return wxEVT_AUI_PANE_RESTORE;
		case -32: return wxEVT_AUI_RENDER;
		case -33: return wxEVT_AUI_FIND_MANAGER;
	}
	
	return 0;
}

