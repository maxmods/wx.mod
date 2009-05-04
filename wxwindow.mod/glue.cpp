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

MaxBoxSizer::MaxBoxSizer(int orient)
	: wxBoxSizer(orient)
{
}

MaxBoxSizer::~MaxBoxSizer() {
	wxunbind(this);
}

void MaxBoxSizer::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
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

MaxGridSizer::MaxGridSizer(int rows, int cols, int vgap, int hgap)
	: wxGridSizer(rows, cols, vgap, hgap)
{
}

MaxGridSizer::~MaxGridSizer() {
	wxunbind(this);
}

void MaxGridSizer::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

MaxFlexGridSizer::MaxFlexGridSizer(BBObject * handle, int cols, int vgap, int hgap)
	: maxHandle(handle), wxFlexGridSizer(cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxFlexGridSizer::MaxFlexGridSizer(BBObject * handle, int rows, int cols, int vgap, int hgap)
	: maxHandle(handle), wxFlexGridSizer(rows, cols, vgap, hgap)
{
	wxbind(this, handle);
}

MaxFlexGridSizer::MaxFlexGridSizer(int rows, int cols, int vgap, int hgap)
	: wxFlexGridSizer(rows, cols, vgap, hgap)
{
}

MaxFlexGridSizer::~MaxFlexGridSizer() {
	wxunbind(this);
}

void MaxFlexGridSizer::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

MaxGridBagSizer::MaxGridBagSizer(BBObject * handle, int vgap, int hgap)
	: maxHandle(handle), wxGridBagSizer(vgap, hgap)
{
	wxbind(this, handle);
}

MaxGridBagSizer::MaxGridBagSizer(int vgap, int hgap)
	: wxGridBagSizer(vgap, hgap)
{
}

MaxGridBagSizer::~MaxGridBagSizer() {
	wxunbind(this);
}

void MaxGridBagSizer::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxSizerXmlHandler , wxSizerXmlHandler)

MaxSizerXmlHandler::MaxSizerXmlHandler()
	: wxSizerXmlHandler()
{}

wxSizer*  MaxSizerXmlHandler::Handle_wxBoxSizer() {
    MaxBoxSizer * sizer = new MaxBoxSizer(GetStyle(wxT("orient"), wxHORIZONTAL));
	sizer->MaxBind(_wx_wxwindow_wxBoxSizer__xrcNew(sizer));
	return sizer;
}

wxSizer*  MaxSizerXmlHandler::Handle_wxGridSizer() {
    MaxGridSizer * sizer = new MaxGridSizer(GetLong(wxT("rows")), GetLong(wxT("cols")),
                           GetDimension(wxT("vgap")), GetDimension(wxT("hgap")));

	sizer->MaxBind(_wx_wxwindow_wxGridSizer__xrcNew(sizer));
	return sizer;
}

wxSizer*  MaxSizerXmlHandler::Handle_wxFlexGridSizer() {
    MaxFlexGridSizer *sizer =
        new MaxFlexGridSizer(GetLong(wxT("rows")), GetLong(wxT("cols")),
                            GetDimension(wxT("vgap")), GetDimension(wxT("hgap")));
    SetGrowables(sizer, wxT("growablerows"), true);
    SetGrowables(sizer, wxT("growablecols"), false);
	sizer->MaxBind(_wx_wxwindow_wxFlexGridSizer__xrcNew(sizer));
    return sizer;

}

wxSizer*  MaxSizerXmlHandler::Handle_wxGridBagSizer() {
    MaxGridBagSizer *sizer =
        new MaxGridBagSizer(GetDimension(wxT("vgap")), GetDimension(wxT("hgap")));
    SetGrowables(sizer, wxT("growablerows"), true);
    SetGrowables(sizer, wxT("growablecols"), false);
	sizer->MaxBind(_wx_wxwindow_wxGridBagSizer__xrcNew(sizer));
    return sizer;
}

bool MaxSizerXmlHandler::IsSizerNode(wxXmlNode *node)
{
    return (IsOfClass(node, wxT("wxBoxSizer"))) ||
           (IsOfClass(node, wxT("wxGridSizer"))) ||
           (IsOfClass(node, wxT("wxFlexGridSizer"))) ||
           (IsOfClass(node, wxT("wxGridBagSizer")));
}


void MaxSizerXmlHandler::SetGrowables(wxFlexGridSizer* sizer, const wxChar* param, bool rows) {
    wxStringTokenizer tkn;
    unsigned long l;
    tkn.SetString(GetParamValue(param), wxT(","));
    while (tkn.HasMoreTokens())
    {
        if (!tkn.GetNextToken().ToULong(&l))
            wxLogError(wxT("growable[rows|cols] must be comma-separated list of row numbers"));
        else {
            if (rows)
                sizer->AddGrowableRow(l);
            else
                sizer->AddGrowableCol(l);
        }
    }
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

BBArray * bmx_wxwindow_getchildren(wxWindow * window) {
	wxWindowList wlist = window->GetChildren();
	int size = wlist.size();
	BBArray * array = _wx_wxwindow_wxWindow__newwindowarray(size);

	wxWindowList::iterator iter;
	int i = 0;
	for (iter = wlist.begin(); iter != wlist.end(); ++iter) { 
		wxWindow * win = *iter;
		_wx_wxwindow_wxWindow__setwindow(array, i++, win);
	}
	return array;
}

void bmx_wxwindow_convertdialogtopixels(wxWindow * window, int dx, int dy, int * px, int  * py) {
	wxPoint p = window->ConvertDialogToPixels(wxPoint(dx, dy));
	*px = p.x;
	*py = p.y;
}

void bmx_wxwindow_convertpixelstodialog(wxWindow * window, int px, int py, int * dx, int * dy) {
	wxPoint p = window->ConvertPixelsToDialog(wxPoint(px, py));
	*dx = p.x;
	*dy = p.y;
}

wxWindow * bmx_wxwindow_findwindow(wxWindow * window, long id) {
	return window->FindWindow(id);
}

wxWindow * bmx_wxwindow_findwindowbyid(long id, wxWindow * parent) {
	if (parent) {
		return wxWindow::FindWindowById(id, parent);
	} else {
		return wxWindow::FindWindowById(id);
	}
}

wxWindow * bmx_wxwindow_findwindowbyname(BBString * name, wxWindow * parent) {
	if (parent) {
		return wxWindow::FindWindowByName(wxStringFromBBString(name), parent);
	} else {
		return wxWindow::FindWindowByName(wxStringFromBBString(name));
	}
}

wxWindow * bmx_wxwindow_findwindowbylabel(BBString * label, wxWindow * parent) {
	if (parent) {
		return wxWindow::FindWindowByLabel(wxStringFromBBString(label), parent);
	} else {
		return wxWindow::FindWindowByLabel(wxStringFromBBString(label));
	}
}

wxWindow * bmx_wxwindow_getcapture() {
	return wxWindow::GetCapture();
}

wxCaret * bmx_wxwindow_getcaret(wxWindow * window) {
	return window->GetCaret();
}

wxSizer * bmx_wxwindow_getcontainingsizer(wxWindow * window) {
	return window->GetContainingSizer();
}

MaxCursor * bmx_wxwindow_getcursor(wxWindow * window) {
	wxCursor c(window->GetCursor());
	return new MaxCursor(c);
}

long bmx_wxwindow_getextrastyle(wxWindow * window) {
	return window->GetExtraStyle();
}

wxEvtHandler * bmx_wxwindow_geteventhandler(wxWindow * window) {
	return window->GetEventHandler();
}

void bmx_wxwindow_gettextextent(wxWindow * window, BBString * text, int * x, int * y, int * descent,
		int * externalLeading, MaxFont * font, bool use16) {
	if (font) {
		window->GetTextExtent(wxStringFromBBString(text), x, y, descent, externalLeading, &font->Font());//, use16);
	} else {
		window->GetTextExtent(wxStringFromBBString(text), x, y, descent, externalLeading, NULL);//, use16);
	}
}

void bmx_wxwindow_getvirtualsize(wxWindow * window, int * width, int * height) {
	window->GetVirtualSize(width, height);
}

void bmx_wxwindow_getwindowbordersize(wxWindow * window, int * leftRight, int * topBottom) {
	wxSize s(window->GetWindowBorderSize());
	*leftRight = s.x;
	*topBottom = s.y;
}

void bmx_wxwindow_navigate(wxWindow * window, int flags) {
	window->Navigate(flags);
}

bool bmx_wxwindow_registerhotkey(wxWindow * window, int hotKeyId, int modifiers, int virtualKeyCode) {
#ifdef WIN32
	return window->RegisterHotKey(hotKeyId, modifiers, virtualKeyCode);
#else
	return false;
#endif
}

bool bmx_wxwindow_scrolllines(wxWindow * window, int lines) {
	return window->ScrollLines(lines);
}

bool bmx_wxwindow_scrollpages(wxWindow * window, int pages) {
	return window->ScrollPages(pages);
}

void bmx_wxwindow_setcaret(wxWindow * window, wxCaret * caret) {
	window->SetCaret(caret);
}

void bmx_wxwindow_setwindowvariant(wxWindow * window, wxWindowVariant variant) {
	window->SetWindowVariant(variant);
}

bool bmx_wxwindow_unregisterhotkey(wxWindow * window, int hotKeyId) {
#ifdef WIN32
	return window->UnregisterHotKey(hotKeyId);
#else
	return false;
#endif
}

void bmx_wxwindow_warppointer(wxWindow * window, int x, int y) {
	window->WarpPointer(x, y);
}

wxDropTarget * bmx_wxwindow_getdroptarget(wxWindow * window) {
	return window->GetDropTarget();
}

void bmx_wxwindow_setdroptarget(wxWindow * window, wxDropTarget * target) {
	window->SetDropTarget(target);
}

MaxAcceleratorTable * bmx_wxwindow_getacceleratortable(wxWindow * window) {
	return new MaxAcceleratorTable(*window->GetAcceleratorTable());
}

void bmx_wxwindow_setacceleratortable(wxWindow * window, MaxAcceleratorTable * table) {
	window->SetAcceleratorTable(table->Table());
}

wxToolTip * bmx_wxwindow_gettooltip(wxWindow * window) {
	return window->GetToolTip();
}

void bmx_wxwindow_scrollwindow(wxWindow * window, int dx, int dy, int x, int y, int w, int h) {
	if ((x != 0) || (y != 0) || (w != 0) || (h != 0)) {
		wxRect r(x, y, w, h);
		window->ScrollWindow(dx, dy, &r);
	} else {
		window->ScrollWindow(dx, dy);
	}
}

void bmx_wxwindow_scrollwindowrect(wxWindow * window, int dx, int dy, MaxRect * rect) {
	if (rect) {
		window->ScrollWindow(dx, dy, &rect->Rect());
	} else {
		window->ScrollWindow(dx, dy);
	}
}

void bmx_wxwindow_setvalidator(wxWindow * window, wxValidator * validator) {
	if (validator) {
		window->SetValidator(*validator);
	} else {
		window->SetValidator(wxDefaultValidator);
	}
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

void bmx_wxsizer_clear(wxSizer * sizer, bool deleteWindows) {
	sizer->Clear(deleteWindows);
}

void bmx_wxsizer_fitinside(wxSizer * sizer, wxWindow * window) {
	sizer->FitInside(window);
}

wxWindow * bmx_wxsizer_getcontainingwindow(wxSizer * sizer) {
	return sizer->GetContainingWindow();
}

void bmx_wxsizer_getsize(wxSizer * sizer, int * w, int * h) {
	wxSize s = sizer->GetSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxsizer_getposition(wxSizer * sizer, int * x, int * y) {
	wxPoint p = sizer->GetPosition();
	*x = p.x;
	*y = p.y;
}

void bmx_wxsizer_getminsize(wxSizer * sizer, int * w, int * h) {
	wxSize s = sizer->GetMinSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxsizer_setvirtualsizehints(wxSizer * sizer, wxWindow * window) {
	sizer->SetVirtualSizeHints(window);
}

bool bmx_wxsizer_show(wxSizer * sizer, wxWindow * window, bool doShow, bool recursive) {
	return sizer->Show(window, doShow, recursive);
}

bool bmx_wxsizer_showsizer(wxSizer * sizer, wxSizer * s, bool doShow, bool recursive) {
	return sizer->Show(s, doShow, recursive);
}

bool bmx_wxsizer_showitem(wxSizer * sizer, int index, bool doShow) {
	return sizer->Show(index, doShow);
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

MaxFlexGridSizer * bmx_wxflexgridsizer_createrc(BBObject * maxHandle, int rows, int cols, int vgap, int hgap) {
	return new MaxFlexGridSizer(maxHandle, rows, cols, vgap, hgap);
}


void bmx_wxflexgridsizer_addgrowablecol(wxFlexGridSizer * sizer, int index, int prop) {
	sizer->AddGrowableCol(index, prop);
}

void bmx_wxflexgridsizer_addgrowablerow(wxFlexGridSizer * sizer, int index, int prop) {
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

int bmx_wxboxsizer_getorientation(wxBoxSizer * sizer) {
	return sizer->GetOrientation();
}

bool bmx_wxsizer_isshown(wxSizer * sizer, int index) {
	return sizer->IsShown(index);
}

void bmx_wxsizer_layout(wxSizer * sizer) {
	sizer->Layout();
}

void bmx_wxsizer_recalcsizes(wxSizer * sizer) {
	sizer->RecalcSizes();
}

int bmx_wxflexgridsizer_getflexibledirection(wxFlexGridSizer * sizer) {
    return sizer->GetFlexibleDirection();
}

int bmx_wxflexgridsizer_getnonflexiblegrowmode(wxFlexGridSizer * sizer) {
    return sizer->GetNonFlexibleGrowMode();
}

void bmx_wxflexgridsizer_removegrowablecol(wxFlexGridSizer * sizer, int idx) {
    sizer->RemoveGrowableCol(idx);
}

void bmx_wxflexgridsizer_removegrowablerow(wxFlexGridSizer * sizer, int idx) {
    sizer->RemoveGrowableRow(idx);
}

void bmx_wxflexgridsizer_setflexibledirection(wxFlexGridSizer * sizer, int direction) {
    sizer->SetFlexibleDirection(direction);
}

void bmx_wxflexgridsizer_setnonflexiblegrowmode(wxFlexGridSizer * sizer, wxFlexSizerGrowMode mode) {
    sizer->SetNonFlexibleGrowMode(mode);
}

wxSizerItem * bmx_wxsizer_insertspacer(wxSizer * sizer, int index, int size) {
	return sizer->InsertSpacer(index, size);
}

wxSizerItem * bmx_wxsizer_insertstretchspacer(wxSizer * sizer, int index, int prop) {
	return sizer->InsertStretchSpacer(index, prop);
}

bool bmx_wxsizer_iswindowshown(wxSizer * sizer, wxWindow * window) {
	return sizer->IsShown(window);
}

bool bmx_wxsizer_issizershown(wxSizer * sizer, wxSizer * sz) {
	return sizer->IsShown(sz);
}

void bmx_wxsizer_setdimension(wxSizer * sizer, int x, int y, int width, int height) {
	sizer->SetDimension(x, y, width, height);
}

void bmx_wxsizer_setminsize(wxSizer * sizer, int width, int height) {
	sizer->SetMinSize(width, height);
}

wxSizerItem * bmx_wxsizer_prepend(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border) {
	return sizer->Prepend(window, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_prependsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border) {
	return sizer->Prepend(sz, proportion, flag, border);
}

wxSizerItem * bmx_wxsizer_prependspacer(wxSizer * sizer, int size) {
	return sizer->PrependSpacer(size);
}

wxSizerItem * bmx_wxsizer_prependstretchspacer(wxSizer * sizer, int prop) {
	return sizer->PrependStretchSpacer(prop);
}

bool bmx_wxsizer_removesizer(wxSizer * sizer, wxSizer * sz) {
	return sizer->Remove(sz);
}

bool bmx_wxsizer_remove(wxSizer * sizer, int index) {
	return sizer->Remove(index);
}

bool bmx_wxsizer_replacewindow(wxSizer * sizer, wxWindow * oldWin, wxWindow * newWin, bool recursive) {
	return sizer->Replace(oldWin, newWin, recursive);
}

bool bmx_wxsizer_replacesizer(wxSizer * sizer, wxSizer * oldsz, wxSizer * newsz, bool recursive) {
	return sizer->Replace(oldsz, newsz, recursive);
}

bool bmx_wxsizer_replace(wxSizer * sizer, int oldIndex, wxSizerItem * newItem) {
	return sizer->Replace(oldIndex, newItem);
}

BBArray * bmx_wxsizer_getchildren(wxSizer * sizer) {
	wxSizerItemList ilist = sizer->GetChildren();
	int size = ilist.size();
	BBArray * array = _wx_wxwindow_wxSizer__newsizeritemsarray(size);

	wxSizerItemList::iterator iter;
	int i = 0;
	for (iter = ilist.begin(); iter != ilist.end(); ++iter) { 
		wxSizerItem * item = *iter;
		_wx_wxwindow_wxSizer__setsizeritem(array, i++, item);
	}
	return array;
}

// *********************************************


void bmx_wxtooltip_enable(bool flag) {
	wxToolTip::Enable(flag);
}

void bmx_wxtooltip_setdelay(long msecs) {
	wxToolTip::SetDelay(msecs);
}

void bmx_wxtooltip_settip(wxToolTip * tip, BBString * text) {
	tip->SetTip(wxStringFromBBString(text));
}

BBString * bmx_wxtooltip_gettip(wxToolTip * tip) {
	return bbStringFromWxString(tip->GetTip());
}

wxWindow * bmx_wxtooltip_getwindow(wxToolTip * tip) {
	return tip->GetWindow();
}

// *********************************************

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


//bool bmx_wxidleevent_cansend(wxWindow * window) {
//	return wxIdleEvent::CanSend(window);
//}

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

// *********************************************

wxWindow * bmx_wxfocusevent_getwindow(wxFocusEvent & event) {
	return event.GetWindow();
}

// *********************************************

MaxCursor * bmx_wxsetcursorevent_getcursor(wxSetCursorEvent & event) {
	wxCursor c(event.GetCursor());
	return new MaxCursor(c);
}

int bmx_wxsetcursorevent_getx(wxSetCursorEvent & event) {
	return event.GetX();
}

int bmx_wxsetcursorevent_gety(wxSetCursorEvent & event) {
	return event.GetY();
}

bool bmx_wxsetcursorevent_hascursor(wxSetCursorEvent & event) {
	return event.HasCursor();
}

void bmx_wxsetcursorevent_setcursor(wxSetCursorEvent & event, MaxCursor * cursor) {
	event.SetCursor(cursor->Cursor());
}

// *********************************************

MaxDC * bmx_wxeraseevent_getdc(wxEraseEvent & event) {
	return new MaxDC(event.GetDC());
}

// *********************************************

wxCaret * bmx_wxcaret_create(wxWindow * window, int width, int height) {
	return new wxCaret(window, width, height);
}

int bmx_wxcaret_getblinktime() {
	return wxCaret::GetBlinkTime();
}

void bmx_wxcaret_getposition(wxCaret * caret, int * x, int * y) {
	caret->GetPosition(x, y);
}

void bmx_wxcaret_getsize(wxCaret * caret, int * width, int * height) {
	caret->GetSize(width, height);
}

wxWindow * bmx_wxcaret_getwindow(wxCaret * caret) {
	return caret->GetWindow();
}

void bmx_wxcaret_hide(wxCaret * caret) {
	caret->Hide();
}

bool bmx_wxcaret_isok(wxCaret * caret) {
	return caret->IsOk();
}

bool bmx_wxcaret_isvisible(wxCaret * caret) {
	return caret->IsVisible();
}

void bmx_wxcaret_move(wxCaret * caret, int x, int y) {
	caret->Move(x, y);
}

void bmx_wxcaret_setblinktime(int milliseconds) {
	wxCaret::SetBlinkTime(milliseconds);
}

void bmx_wxcaret_setsize(wxCaret * caret, int width, int height) {
	caret->SetSize(width, height);
}

void bmx_wxcaret_show(wxCaret * caret, bool _show) {
	caret->Show(_show);
}

// *********************************************

wxWindow * bmx_wxfindwindowatpoint(int x, int y) {
	return wxFindWindowAtPoint(wxPoint(x, y));
}

wxWindow * bmx_wxfindwindowatpointer(int * x, int * y) {
	wxPoint p;
	wxWindow * win = wxFindWindowAtPointer(p);
	*x = p.x;
	*y = p.y;
	return win;
}

wxWindow * bmx_wxgetactivewindow() {
	return wxGetActiveWindow();
}

// *********************************************

wxGridBagSizer * bmx_wxgridbagsizer_create(BBObject * handle, int vgap, int hgap) {
	return new MaxGridBagSizer(handle, vgap, hgap);
}

wxSizerItem * bmx_wxgridbagsizer_add(wxGridBagSizer * gb, wxWindow * window, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(window, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(sizer, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addspacer(wxGridBagSizer * gb, int width, int height, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(width, height, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addgbsizeritem(wxGridBagSizer * gb, wxGBSizerItem * item) {
	return gb->Add(item);
}

bool bmx_wxgridbagsizer_checkforintersection(wxGridBagSizer * gb, wxGBSizerItem * item, wxGBSizerItem * excludeItem) {
	return gb->CheckForIntersection(item, excludeItem);
}

bool bmx_wxgridbagsizer_checkforintersectionpos(wxGridBagSizer * gb, int row, int col, int rowspan, int colspan, wxGBSizerItem * excludeItem) {
	return gb->CheckForIntersection(wxGBPosition(row, col), wxGBSpan(rowspan, colspan), excludeItem);
}

void bmx_wxgridbagsizer_getcellsize(wxGridBagSizer * gb, int row, int col, int * width, int * height) {
	wxSize s = gb->GetCellSize(row, col);
	*width = s.x;
	*height = s.y;
}

void bmx_wxgridbagsizer_getemptycellsize(wxGridBagSizer * gb, int * width, int * height) {
	wxSize s = gb->GetEmptyCellSize();
	*width = s.x;
	*height = s.y;
}

void bmx_wxgridbagsizer_getitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(window);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(sizer);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitemposition(wxGridBagSizer * gb, int index, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(index);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(window);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_getitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(sizer);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_getitemspan(wxGridBagSizer * gb, int index, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(index);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_setemptycellsize(wxGridBagSizer * gb, int width, int height) {
	gb->SetEmptyCellSize(wxSize(width, height));
}

bool bmx_wxgridbagsizer_setitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int row, int col) {
	return gb->SetItemPosition(window, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col) {
	return gb->SetItemPosition(sizer, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitemposition(wxGridBagSizer * gb, int index, int row, int col) {
	return gb->SetItemPosition(index, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int rowspan, int colspan) {
	return gb->SetItemSpan(window, wxGBSpan(rowspan, colspan));
}

bool bmx_wxgridbagsizer_setitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int rowspan, int colspan) {
	return gb->SetItemSpan(sizer, wxGBSpan(rowspan, colspan));
}

bool bmx_wxgridbagsizer_setitemspan(wxGridBagSizer * gb, int index, int rowspan, int colspan) {
	return gb->SetItemSpan(index, wxGBSpan(rowspan, colspan));
}

wxGBSizerItem * bmx_wxgridbagsizer_finditemwindow(wxGridBagSizer * gb, wxWindow * window) {
	return gb->FindItem(window);
}

wxGBSizerItem * bmx_wxgridbagsizer_finditemsizer(wxGridBagSizer * gb, wxSizer * sizer) {
	return gb->FindItem(sizer);
}

wxGBSizerItem * bmx_wxgridbagsizer_finditematpoint(wxGridBagSizer * gb, int x, int y) {
	return gb->FindItemAtPoint(wxPoint(x, y));
}

wxGBSizerItem * bmx_wxgridbagsizer_finditematposition(wxGridBagSizer * gb, int row, int col) {
	return gb->FindItemAtPosition(wxGBPosition(row, col));
}

// *********************************************

void bmx_wxsizer_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxSizerXmlHandler);
}

