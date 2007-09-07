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



