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

#include "glue.h"

// ---------------------------------------------------------------------------------------


MaxWindow::MaxWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: maxHandle(handle), wxWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxWindow::~MaxWindow() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxBoxSizer::MaxBoxSizer(BBObject * handle, int orient)
	: maxHandle(handle), wxBoxSizer(orient)
{
	wxbind(this, handle);
}

MaxBoxSizer::~MaxBoxSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------


MaxGridSizer::MaxGridSizer(BBObject * handle, int cols, int vgap, int hgap)
	: maxHandle(handle), wxGridSizer(cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxGridSizer::MaxGridSizer(BBObject * handle, int rows, int cols, int vgap, int hgap)
	: maxHandle(handle), wxGridSizer(rows, cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxGridSizer::~MaxGridSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxFlexGridSizer::MaxFlexGridSizer(BBObject * handle, int cols, int vgap, int hgap)
	: maxHandle(handle), wxFlexGridSizer(cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxFlexGridSizer::~MaxFlexGridSizer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------


// *********************************************


BEGIN_EVENT_TABLE(MaxWindow, wxWindow)
END_EVENT_TABLE()

MaxWindow * bmx_wxwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxWindow(maxHandle, parent, id, x, y, w, h, style);
}

// *********************************************


bool bmx_wxwindow_show(wxWindow * window, bool value) {
	return window->Show(value);
}

bool bmx_wxwindow_close(wxWindow * window, bool force) {
	return window->Close(force);
}

void bmx_wxwindow_setsizer(wxWindow * window, wxSizer * sizer, bool deleteOld) {
	window->SetSizer(sizer, deleteOld);
}

void bmx_wxwindow_setautolayout(wxWindow * window, bool autoLayout) {
	window->SetAutoLayout(autoLayout);
}

void bmx_wxwindow_delete(wxWindow * window) {
	delete window;
}

wxSizer * bmx_wxwindow_getsizer(wxWindow * window) {
	return window->GetSizer();
}

void bmx_wxwindow_layout(wxWindow * window){
	window->Layout();
}

long bmx_wxwindow_getwindowstyleflag(wxWindow * window) {
	return window->GetWindowStyleFlag();
}

void bmx_wxwindow_getbestsize(wxWindow * window, int * w, int * h) {
	wxSize size = window->GetBestSize();
	*w = size.x;
	*h = size.y;
}

void bmx_wxwindow_setfocus(wxWindow * window) {
	window->SetFocus();
}

void bmx_wxwindow_clearbackground(wxWindow * window) {
	window->ClearBackground();
}

void bmx_wxwindow_clienttoscreen(wxWindow * window, int * x, int * y) {
	window->ClientToScreen(x, y);
}

void bmx_wxwindow_setbackgroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetBackgroundColour(colour->Colour());
}

void bmx_wxwindow_setforegroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetForegroundColour(colour->Colour());
}

void bmx_wxwindow_setfont(wxWindow * window, MaxFont * font) {
	window->SetFont(font->Font());
}

MaxFont * bmx_wxwindow_getfont(wxWindow * window) {
	wxFont f(window->GetFont());
	return new MaxFont(f);
}

BBString * bmx_wxwindow_gethelptext(wxWindow * window) {
	return bbStringFromWxString(window->GetHelpText());
}

int bmx_wxwindow_getid(wxWindow * window) {
	return window->GetId();
}

BBString * bmx_wxwindow_getlabel(wxWindow * window) {
	return bbStringFromWxString(window->GetLabel());
}

void bmx_wxwindow_preparedc(wxWindow * window, MaxDC * dc) {
	window->PrepareDC(*dc->GetDC());
}

void bmx_wxwindow_refresh(wxWindow * window, bool erase) {
	window->Refresh(erase);
}

wxWindow * bmx_wxwindow_getparent(wxWindow * window) {
	return window->GetParent();
}

int bmx_wxwindow_getscrollpos(wxWindow * window, int orientation) {
	return window->GetScrollPos(orientation);
}

int bmx_wxwindow_getscrollrange(wxWindow * window, int orientation) {
	return window->GetScrollRange(orientation);
}

int bmx_wxwindow_getscrollthumb(wxWindow * window, int orientation) {
	return window->GetScrollThumb(orientation);
}

int bmx_wxwindow_getcharheight(wxWindow * window) {
	return window->GetCharHeight();
}

int bmx_wxwindow_getcharwidth(wxWindow * window) {
	return window->GetCharWidth();
}

void bmx_wxwindow_getclientsize(wxWindow * window, int * width, int * height) {
	window->GetClientSize(width, height);
}

MaxColour * bmx_wxwindow_getforegroundcolour(wxWindow * window) {
	wxColour c(window->GetForegroundColour());
	return new MaxColour(c);
}

wxWindow * bmx_wxwindow_getgrandparent(wxWindow * window) {
	return window->GetGrandParent();
}

BBString * bmx_wxwindow_gethelptextatpoint(wxWindow * window, int x, int y, wxHelpEvent::Origin origin) {
	return bbStringFromWxString(window->GetHelpTextAtPoint(wxPoint(x, y), origin));
}

void bmx_wxwindow_getmaxsize(wxWindow * window, int * w, int * h) {
	wxSize s = window->GetMaxSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxwindow_getminsize(wxWindow * window, int * w, int * h) {
	wxSize s = window->GetMinSize();
	*w = s.x;
	*h = s.y;
}

BBString * bmx_wxwindow_getname(wxWindow * window) {
	return bbStringFromWxString(window->GetName());
}

void bmx_wxwindow_getposition(wxWindow * window, int * x, int * y) {
	window->GetPosition(x, y);
}

void bmx_wxwindow_getrect(wxWindow * window, int * x, int * y, int * w, int * h) {
	wxRect r = window->GetRect();
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

void bmx_wxwindow_getscreenposition(wxWindow * window, int * x, int * y) {
	window->GetScreenPosition(x, y);
}

void bmx_wxwindow_getscreenrect(wxWindow * window, int * x, int * y, int * w, int * h) {
	wxRect r = window->GetScreenRect();
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
}

MaxRect * bmx_wxwindow_getrectrect(wxWindow * window) {
	wxRect r = window->GetRect();
	return new MaxRect(r);
}

MaxRect * bmx_wxwindow_getscreenrectrect(wxWindow * window) {
	wxRect r = window->GetScreenRect();
	return new MaxRect(r);
}

void bmx_wxwindow_getsize(wxWindow * window, int * w, int * h) {
	window->GetSize(w, h);
}

void bmx_wxwindow_sethelptext(wxWindow * window, BBString * helpText) {
	window->SetHelpText(wxStringFromBBString(helpText));
}

void bmx_wxwindow_setid(wxWindow * window, int id) {
	window->SetId(id);
}

void bmx_wxwindow_setlabel(wxWindow * window, BBString * label) {
	window->SetLabel(wxStringFromBBString(label));
}

void bmx_wxwindow_setscrollbar(wxWindow * window, int orientation, int position, int thumbsize, int range, bool refresh) {
	window->SetScrollbar(orientation, position, thumbsize, range, refresh);
}

void bmx_wxwindow_setscrollpos(wxWindow * window, int orientation, int pos, bool refresh) {
	window->SetScrollPos(orientation, pos, refresh);
}

void bmx_wxwindow_setcursor(wxWindow * window, MaxCursor * cursor) {
	window->SetCursor(cursor->Cursor());
}

void bmx_wxwindow_setwindowstyle(wxWindow * window, long style) {
	window->SetWindowStyle(style);
}

void bmx_wxwindow_setwindowstyleflag(wxWindow * window, long style) {
	window->SetWindowStyleFlag(style);
}

bool bmx_wxwindow_hide(wxWindow * window) {
	return window->Hide();
}

void bmx_wxwindow_move(wxWindow * window, int x, int y) {
	window->Move(x, y);
}

void bmx_wxwindow_setdimensions(wxWindow * window, int x, int y, int w, int h, int flags) {
	window->SetSize(x, y, w, h, flags);
}

void bmx_wxwindow_setdimensionsrect(wxWindow * window, MaxRect * rect) {
	window->SetSize(rect->Rect());
}

void bmx_wxwindow_pusheventhandler(wxWindow * window, wxEvtHandler * evt) {
	window->PushEventHandler(evt);
}

wxWindowVariant bmx_wxwindow_getwindowvariant(wxWindow * window) {
	return window->GetWindowVariant();
}

bool bmx_wxwindow_hascapture(wxWindow * window) {
	return window->HasCapture();
}

bool bmx_wxwindow_hasflag(wxWindow * window, int flag) {
	return window->HasFlag(flag);
}

bool bmx_wxwindow_hasmultiplepages(wxWindow * window) {
	return window->HasMultiplePages();
}

bool bmx_wxwindow_hastransparentbackground(wxWindow * window) {
	return window->HasTransparentBackground();
}

bool bmx_wxwindow_hasscrollbar(wxWindow * window, int orient) {
	return window->HasScrollbar(orient);
}

void bmx_wxwindow_inheritattributes(wxWindow * window) {
	window->InheritAttributes();
}

void bmx_wxwindow_initdialog(wxWindow * window) {
	window->InitDialog();
}

void bmx_wxwindow_invalidatebestsize(wxWindow * window) {
	window->InvalidateBestSize();
}

bool bmx_wxwindow_isdoublebuffered(wxWindow * window) {
	return window->IsDoubleBuffered();
}

bool bmx_wxwindow_isenabled(wxWindow * window) {
	return window->IsEnabled();
}

bool bmx_wxwindow_isexposed(wxWindow * window, int x, int y, int w, int h) {
	if (w == 0 || h == 0) {
		return window->IsExposed(x, y);
	} else {
		return window->IsExposed(x, y, w, h);
	}
}

bool bmx_wxwindow_isexposedrect(wxWindow * window, MaxRect * rect) {
	return window->IsExposed(rect->Rect());
}

bool bmx_wxwindow_isfrozen(wxWindow * window) {
	return window->IsFrozen();
}

bool bmx_wxwindow_isretained(wxWindow * window) {
	return window->IsRetained();
}

bool bmx_wxwindow_isshown(wxWindow * window) {
	return window->IsShown();
}

bool bmx_wxwindow_isshownonscreen(wxWindow * window) {
	return window->IsShownOnScreen();
}

bool bmx_wxwindow_istoplevel(wxWindow * window) {
	return window->IsTopLevel();
}

bool bmx_wxwindow_reparent(wxWindow * window, wxWindow * parent) {
	return window->Reparent(parent);
}

bool bmx_wxwindow_destroy(wxWindow * window) {
	return window->Destroy();
}

void bmx_wxwindow_destroyChildren(wxWindow * window) {
	window->DestroyChildren();
}

bool bmx_wxwindow_disable(wxWindow * window) {
	return window->Disable();
}

void bmx_wxwindow_dragacceptfiles(wxWindow * window, bool accept) {
#ifdef WIN32
	window->DragAcceptFiles(accept);
#endif
}

bool bmx_wxwindow_enable(wxWindow * window, bool value) {
	return window->Enable(value);
}

void bmx_wxwindow_fit(wxWindow * window) {
	window->Fit();
}

void bmx_wxwindow_fitinside(wxWindow * window) {
	window->FitInside();
}

void bmx_wxwindow_freeze(wxWindow * window) {
	window->Freeze();
}

MaxColour * bmx_wxwindow_getbackgroundcolour(wxWindow * window) {
	wxColour c(window->GetBackgroundColour());
	return new MaxColour(c);
}

int bmx_wxwindow_getbackgroundstyle(wxWindow * window) {
	return window->GetBackgroundStyle();
}

void bmx_wxwindow_geteffectiveminsize(wxWindow * window, int * w, int * h) {
	wxSize s = window->GetEffectiveMinSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxwindow_capturemouse(wxWindow * window) {
	window->CaptureMouse();
}

void bmx_wxwindow_centre(wxWindow * window, int direction) {
	window->Centre(direction);
}

void bmx_wxwindow_centreonparent(wxWindow * window, int direction) {
	window->CentreOnParent(direction);
}

bool bmx_wxwindow_popupmenu(wxWindow * window, wxMenu * menu, int x, int y) {
	return window->PopupMenu(menu, wxPoint(x, y));
}

void bmx_wxwindow_refreshrect(wxWindow * window, int x, int y, int w, int h, bool erase) {
	window->RefreshRect(wxRect(x, y, w, h), erase);
}

void bmx_wxwindow_refreshrectrect(wxWindow * window, MaxRect * rect, bool erase) {
	window->RefreshRect(rect->Rect(), erase);
}

void bmx_wxwindow_releasemouse(wxWindow * window) {
	window->ReleaseMouse();
}

void bmx_wxwindow_screentoclient(wxWindow * window, int * x, int * y) {
	window->ScreenToClient(x, y);
}

void bmx_wxwindow_setsize(wxWindow * window, int width, int height) {
	window->SetSize(width, height);
}

void bmx_wxwindow_setposition(wxWindow * window, int x, int y) {
	window->SetSize(x, y, -1, -1);
}

void * bmx_wxwindow_gethandle(wxWindow * window) {
	return window->GetHandle();
}

void bmx_wxwindow_linedown(wxWindow * window) {
	window->LineDown();
}

void bmx_wxwindow_lineup(wxWindow * window) {
	window->LineUp();
}

void bmx_wxwindow_lower(wxWindow * window) {
	window->Lower();
}

void bmx_wxwindow_makemodal(wxWindow * window, bool flag) {
	window->MakeModal(flag);
}

void bmx_wxwindow_moveafterintaborder(wxWindow * window, wxWindow * win) {
	window->MoveAfterInTabOrder(win);
}

void bmx_wxwindow_movebeforeintaborder(wxWindow * window, wxWindow * win) {
	window->MoveBeforeInTabOrder(win);
}

void bmx_wxwindow_pagedown(wxWindow * window) {
	window->PageDown();
}

void bmx_wxwindow_pageup(wxWindow * window) {
	window->PageUp();
}

wxEvtHandler * bmx_wxwindow_popeventhandler(wxWindow * window, bool deleteHandler) {
	return window->PopEventHandler(deleteHandler);
}

void bmx_wxwindow_raise(wxWindow * window) {
	window->Raise();
}

bool bmx_wxwindow_removeeventhandler(wxWindow * window, wxEvtHandler * handler) {
	return window->RemoveEventHandler(handler);
}

void bmx_wxwindow_setbackgroundstyle(wxWindow * window, wxBackgroundStyle style) {
	window->SetBackgroundStyle(style);
}

void bmx_wxwindow_setinitialsize(wxWindow * window, int w, int h) {
	window->SetInitialSize(wxSize(w, h));
}

void bmx_wxwindow_setclientsize(wxWindow * window, int w, int h) {
	window->SetClientSize(wxSize(w, h));
}

void bmx_wxwindow_setcontainingsizer(wxWindow * window, wxSizer * sizer) {
	window->SetContainingSizer(sizer);
}

//void bmx_wxwindow_setinitialbestsize(wxWindow * window, int w, int h) {
//	window->SetInitialBestSize(wxSize(w, h));
//}

void bmx_wxwindow_seteventhandler(wxWindow * window, wxEvtHandler * handler) {
	window->SetEventHandler(handler);
}

void bmx_wxwindow_setextrastyle(wxWindow * window, long style) {
	window->SetExtraStyle(style);
}

void bmx_wxwindow_setmaxsize(wxWindow * window, int width, int height) {
	window->SetMaxSize(wxSize(width, height));
}

void bmx_wxwindow_setminsize(wxWindow * window, int width, int height) {
	window->SetMinSize(wxSize(width, height));
}

void bmx_wxwindow_setname(wxWindow * window, BBString * name) {
	window->SetName(wxStringFromBBString(name));
}

void bmx_wxwindow_setownbackgroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetOwnBackgroundColour(colour->Colour());
}

void bmx_wxwindow_setownfont(wxWindow * window, MaxFont * font) {
	window->SetOwnFont(font->Font());
}

void bmx_wxwindow_setownforegroundcolour(wxWindow * window, MaxColour * colour) {
	window->SetOwnForegroundColour(colour->Colour());
}

wxWindow * bmx_wxwindow_findfocus() {
	return wxWindow::FindFocus();
}

void bmx_wxwindow_thaw(wxWindow * window) {
	window->Thaw();
}

bool bmx_wxwindow_togglewindowstyle(wxWindow * window, int flag) {
	return window->ToggleWindowStyle(flag);
}

bool bmx_wxwindow_transferdatafromwindow(wxWindow * window) {
	return window->TransferDataFromWindow();
}

bool bmx_wxwindow_transferdatatowindow(wxWindow * window) {
	return window->TransferDataToWindow();
}

void bmx_wxwindow_udpate(wxWindow * window) {
	window->Update();
}

void bmx_wxwindow_updatewindowui(wxWindow * window, long flags) {
	window->UpdateWindowUI(flags);
}

bool bmx_wxwindow_validate(wxWindow * window) {
	return window->Validate();
}

void bmx_wxwindow_setsizerandfit(wxWindow * window, wxSizer * sizer, bool deleteOld) {
	window->SetSizerAndFit(sizer, deleteOld);
}

void bmx_wxwindow_setthemeenabled(wxWindow * window, bool enable) {
	window->SetThemeEnabled(enable);
}

void bmx_wxwindow_settooltip(wxWindow * window, BBString * tip) {
	window->SetToolTip(wxStringFromBBString(tip));
}

void bmx_wxwindow_setvirtualsize(wxWindow * window, int width, int height) {
	window->SetVirtualSize(width, height);
}

void bmx_wxwindow_setvirtualsizehints(wxWindow * window, int minW, int minH, int maxW, int maxH) {
	window->SetVirtualSizeHints(minW, minH, maxW, maxH);
}


// *********************************************


MaxBoxSizer * bmx_wxboxsizer_create(BBObject * maxHandle, int orient) {
	return new MaxBoxSizer(maxHandle, orient);
}

wxSizerItem * bmx_wxsizer_add(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Add(window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border) {
	return sizer->Add(sz, proportion, flag, border);
}

bool bmx_wxsizer_detach(wxSizer * sizer, wxWindow * window) {
	return sizer->Detach(window);
}

bool bmx_wxsizer_detachsizer(wxSizer * sizer, wxSizer * sz) {
	return sizer->Detach(sz);
}

wxSizerItem * bmx_wxsizer_insert(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Insert(index, window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_insertsizer(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Insert(index, window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addcustomspacer(wxSizer * sizer, int width, int height, int proportion, int flag, int border) {
	return sizer->Add(width, height, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_addspacer(wxSizer * sizer, int size) {
	return sizer->AddSpacer(size);
}

wxSizerItem * bmx_wxsizer_addstretchspacer(wxSizer * sizer, int prop) {
	return sizer->AddStretchSpacer(prop);
}

void bmx_wxsizer_setitemminsize(wxSizer * sizer, int index, int width, int height) {
	sizer->SetItemMinSize(index, width, height);
}

void bmx_wxsizer_setitemminsizewindow(wxSizer * sizer, wxWindow * window, int width, int height) {
	sizer->SetItemMinSize(window, width, height);
}

void bmx_wxsizer_setitemminsizesizer(wxSizer * sizer, wxSizer * sz, int width, int height) {
	sizer->SetItemMinSize(sz, width, height);
}

MaxGridSizer * bmx_wxgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap) {
	return new MaxGridSizer(maxHandle, cols, vgap, hgap);
}

MaxGridSizer * bmx_wxgridsizer_createrc(BBObject * maxHandle, int rows, int cols, int vgap, int hgap) {
	return new MaxGridSizer(maxHandle, rows, cols, vgap, hgap);
}

int bmx_wxgridsizer_getcols(MaxGridSizer * sizer) {
	return sizer->GetCols();
}

int bmx_wxgridsizer_gethgap(MaxGridSizer * sizer) {
	return sizer->GetHGap();
}

int bmx_wxgridsizer_getrows(MaxGridSizer * sizer) {
	return sizer->GetRows();
}

int bmx_wxgridsizer_getvgap(MaxGridSizer * sizer) {
	return sizer->GetVGap();
}

void bmx_wxgridsizer_setcols(MaxGridSizer * sizer, int cols) {
	sizer->SetCols(cols);
}

void bmx_wxgridsizer_sethgap(MaxGridSizer * sizer, int hgap) {
	sizer->SetHGap(hgap);
}

void bmx_wxgridsizer_setrows(MaxGridSizer * sizer, int rows) {
	sizer->SetRows(rows);
}

void bmx_wxgridsizer_setvgap(MaxGridSizer * sizer, int vgap) {
	sizer->SetVGap(vgap);
}

void bmx_wxsizer_setsizehints(wxSizer * sizer, wxWindow * window) {
	sizer->SetSizeHints(window);
}

MaxFlexGridSizer * bmx_wxflexgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap) {
	return new MaxFlexGridSizer(maxHandle, cols, vgap, hgap);
}

void bmx_wxflexgridsizer_addgrowablecol(MaxFlexGridSizer * sizer, int index, int prop) {
	sizer->AddGrowableCol(index, prop);
}

void bmx_wxflexgridsizer_addgrowablerow(MaxFlexGridSizer * sizer, int index, int prop) {
	sizer->AddGrowableRow(index, prop);
}

void bmx_wxsizer_fit(wxSizer * sizer, wxWindow * window) {
	sizer->Fit(window);
}

void bmx_wxsizer_fitsize(wxSizer * sizer, wxWindow * window, int * w, int * h) {
	wxSize s = sizer->Fit(window);
	*w = s.x;
	*h = s.y;
}

void bmx_wxtooltip_enable(bool flag) {
	wxToolTip::Enable(flag);
}

void bmx_wxtooltip_setdelay(long msecs) {
	wxToolTip::SetDelay(msecs);
}

bool bmx_wxupdateeventui_canupdate(wxWindow * window) {
	return wxUpdateUIEvent::CanUpdate(window);
}

bool bmx_wxupdateeventui_getchecked(wxUpdateUIEvent & event) {
	return event.GetChecked();
}

bool bmx_wxupdateeventui_getenabled(wxUpdateUIEvent & event) {
	return event.GetEnabled();
}

bool bmx_wxupdateeventui_getshown(wxUpdateUIEvent & event) {
	return event.GetShown();
}

BBString * bmx_wxupdateeventui_gettext(wxUpdateUIEvent & event) {
	return bbStringFromWxString(event.GetText());
}

wxUpdateUIMode bmx_wxupdateeventui_getmode() {
	return wxUpdateUIEvent::GetMode();
}

long bmx_wxupdateeventui_getupdateinterval() {
	return wxUpdateUIEvent::GetUpdateInterval();
}

void bmx_wxupdateeventui_setmode(wxUpdateUIMode mode) {
	wxUpdateUIEvent::SetMode(mode);
}

void bmx_wxupdateeventui_settext(wxUpdateUIEvent & event, BBString * text) {
	event.SetText(wxStringFromBBString(text));
}

void bmx_wxupdateeventui_setupdateinterval(long interval) {
	wxUpdateUIEvent::SetUpdateInterval(interval);
}


bool bmx_wxidleevent_cansend(wxWindow * window) {
	return wxIdleEvent::CanSend(window);
}

wxIdleMode bmx_wxidleevent_getmode() {
	return wxIdleEvent::GetMode();
}

void bmx_wxidleevent_requestmore(wxIdleEvent & event, bool needMore) {
	event.RequestMore(needMore);
}

bool bmx_wxidleevent_morerequested(wxIdleEvent & event) {
	return event.MoreRequested();
}

void bmx_wxidleevent_setmode(wxIdleMode mode) {
	wxIdleEvent::SetMode(mode);
}



