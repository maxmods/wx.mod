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

MaxWebViewHistoryItem::MaxWebViewHistoryItem(wxSharedPtr< wxWebViewHistoryItem > i)
	: item(i)
{
}

MaxWebViewHistoryItem::~MaxWebViewHistoryItem()
{
}

wxSharedPtr< wxWebViewHistoryItem > MaxWebViewHistoryItem::Item() {
	return item;
}

// *********************************************

wxWebView * bmx_wxwebview_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * url, int x, int y,
		int w, int h, long style) {

	wxWebView * webView = wxWebView::New(parent, id, wxStringFromBBString(url), wxPoint(x, y), wxSize(w, h), wxWebViewBackendDefault, style);
	wxbind(webView, maxHandle);
	
	return webView;
}

BBString * bmx_wxwebview_getcurrenttitle(wxWebView * view) {
	return bbStringFromWxString(view->GetCurrentTitle());
}

BBString * bmx_wxwebview_getcurrenturl(wxWebView * view) {
	return bbStringFromWxString(view->GetCurrentURL());
}

BBString * bmx_wxwebview_getpagesource(wxWebView * view) {
	return bbStringFromWxString(view->GetPageSource());
}

BBString * bmx_wxwebview_getpagetext(wxWebView * view) {
	return bbStringFromWxString(view->GetPageText());
}

int bmx_wxwebview_isbusy(wxWebView * view) {
	return static_cast<int>(view->IsBusy());
}

int bmx_wxwebview_iseditable(wxWebView * view) {
	return static_cast<int>(view->IsEditable());
}

void bmx_wxwebview_loadurl(wxWebView * view, BBString * url) {
	view->LoadURL(wxStringFromBBString(url));
}

void bmx_wxwebview_print(wxWebView * view) {
	view->Print();
}

void bmx_wxwebview_reload(wxWebView * view, int flags) {
	view->Reload(static_cast<wxWebViewReloadFlags>(flags));
}

void bmx_wxwebview_runscript(wxWebView * view, BBString * script) {
	view->RunScript(wxStringFromBBString(script));
}

void bmx_wxwebview_seteditable(wxWebView * view, int enable) {
	view->SetEditable(static_cast<bool>(enable));
}

void bmx_wxwebview_setpage(wxWebView * view, BBString * html, BBString * baseUrl) {
	view->SetPage(wxStringFromBBString(html), wxStringFromBBString(baseUrl));
}

void bmx_wxwebview_setpagestream(wxWebView * view, wxInputStream * html, BBString * baseUrl) {
	view->SetPage(*html, wxStringFromBBString(baseUrl));
}

void bmx_wxwebview_stop(wxWebView * view) {
	view->Stop();
}

int bmx_wxwebview_cancopy(wxWebView * view) {
	return static_cast<int>(view->CanCopy());
}

int bmx_wxwebview_cancut(wxWebView * view) {
	return static_cast<int>(view->CanCut());
}

int bmx_wxwebview_canpaste(wxWebView * view) {
	return static_cast<int>(view->CanPaste());
}

void bmx_wxwebview_copy(wxWebView * view) {
	view->Copy();
}

void bmx_wxwebview_cut(wxWebView * view) {
	view->Cut();
}

void bmx_wxwebview_paste(wxWebView * view) {
	view->Paste();
}

void bmx_wxwebview_enablecontextmenu(wxWebView * view, int enable) {
	view->EnableContextMenu(static_cast<bool>(enable));
}

int bmx_wxwebview_iscontextmenuenabled(wxWebView * view) {
	return static_cast<int>(view->IsContextMenuEnabled());
}

int bmx_wxwebview_cangoback(wxWebView * view) {
	return static_cast<int>(view->CanGoBack());
}

int bmx_wxwebview_cangoforward(wxWebView * view) {
	return static_cast<int>(view->CanGoForward());
}

void bmx_wxwebview_clearhistory(wxWebView * view) {
	view->ClearHistory();
}

void bmx_wxwebview_enablehistory(wxWebView * view, int enable) {
	view->EnableHistory(static_cast<bool>(enable));
}

BBArray * bmx_wxwebview_getbackwardhistory(wxWebView * view) {
	wxVector< wxSharedPtr < wxWebViewHistoryItem > > list = view->GetBackwardHistory();
	if (list.size() > 0) {
		BBArray * arr = CB_PREF(wx_wxwebview_wxWebViewHistoryItem__newArray)(list.size());
		
		for (int i = 0; i < list.size(); i++) {
			CB_PREF(wx_wxwebview_wxWebViewHistoryItem__setArrayValue)(arr, i, new MaxWebViewHistoryItem(list[i]));
		}
		
		return arr;
	} else {
		return &bbEmptyArray;
	}
}

BBArray * bmx_wxwebview_getforwardhistory(wxWebView * view) {
	wxVector< wxSharedPtr < wxWebViewHistoryItem > > list = view->GetForwardHistory();
	if (list.size() > 0) {
		BBArray * arr = CB_PREF(wx_wxwebview_wxWebViewHistoryItem__newArray)(list.size());
		
		for (int i = 0; i < list.size(); i++) {
			CB_PREF(wx_wxwebview_wxWebViewHistoryItem__setArrayValue)(arr, i, new MaxWebViewHistoryItem(list[i]));
		}
		
		return arr;
	} else {
		return &bbEmptyArray;
	}
}

void bmx_wxwebview_goback(wxWebView * view) {
	view->GoBack();
}

void bmx_wxwebview_goforward(wxWebView * view) {
	view->GoForward();
}

void bmx_wxwebview_loadhistoryitem(wxWebView * view, MaxWebViewHistoryItem * item) {
	view->LoadHistoryItem(item->Item());
}

void bmx_wxwebview_clearselection(wxWebView * view) {
	view->ClearSelection();
}

void bmx_wxwebview_deleteselection(wxWebView * view) {
	view->DeleteSelection();
}

BBString * bmx_wxwebview_getselectedsource(wxWebView * view) {
	return bbStringFromWxString(view->GetSelectedSource());
}

BBString * bmx_wxwebview_getselectedtext(wxWebView * view) {
	return bbStringFromWxString(view->GetSelectedText());
}

int bmx_wxwebview_hasselection(wxWebView * view) {
	return static_cast<int>(view->HasSelection());
}

void bmx_wxwebview_selectall(wxWebView * view) {
	view->SelectAll();
}

int bmx_wxwebview_canredo(wxWebView * view) {
	return static_cast<int>(view->CanRedo());
}

int bmx_wxwebview_canundo(wxWebView * view) {
	return static_cast<int>(view->CanUndo());
}

void bmx_wxwebview_redo(wxWebView * view) {
	view->Redo();
}

void bmx_wxwebview_undo(wxWebView * view) {
	view->Undo();
}

int bmx_wxwebview_find(wxWebView * view, BBString * text, int flags) {
	return static_cast<int>(view->Find(wxStringFromBBString(text), wxWebViewFindFlags(flags)));
}

int bmx_wxwebview_cansetzoomtype(wxWebView * view, int zoomtype) {
	return static_cast<int>(view->CanSetZoomType(wxWebViewZoomType(zoomtype)));
}

int bmx_wxwebview_getzoom(wxWebView * view) {
	return static_cast<int>(view->GetZoom());
}

int bmx_wxwebview_getzoomtype(wxWebView * view) {
	return static_cast<int>(view->GetZoomType());
}

void bmx_wxwebview_setzoom(wxWebView * view, int zoom) {
	view->SetZoom(wxWebViewZoom(zoom));
}

void bmx_wxwebview_setzoomtype(wxWebView * view, int zoomType) {
	view->SetZoomType(wxWebViewZoomType(zoomType));
}


// *********************************************

MaxWebViewHistoryItem * bmx_wxwebviewhistoryitem_create(BBString * url, BBString * title) {
	wxWebViewHistoryItem  * hist = new wxWebViewHistoryItem(wxStringFromBBString(url), wxStringFromBBString(title));
	wxSharedPtr< wxWebViewHistoryItem > item(hist);
	return new MaxWebViewHistoryItem(item);
}

BBString * bmx_wxwebviewhistoryitem_geturl(MaxWebViewHistoryItem * item) {
	return bbStringFromWxString(item->Item()->GetUrl());
}

BBString * bmx_wxwebviewhistoryitem_gettitle(MaxWebViewHistoryItem * item) {
	return bbStringFromWxString(item->Item()->GetTitle());
}

void bmx_wxwebviewhistoryitem_free(MaxWebViewHistoryItem * item) {
	delete item;
}

// *********************************************

BBString * bmx_wxwebviewevent_gettarget(wxWebViewEvent & event) {
	return bbStringFromWxString(event.GetTarget());
}

BBString * bmx_wxwebviewevent_geturl(wxWebViewEvent & event) {
	return bbStringFromWxString(event.GetURL());
}

// *********************************************

int bmx_wxwebview_geteventtype(int type) {
	switch(type) {
		case -61: return wxEVT_WEBVIEW_NAVIGATING;
		case -62: return wxEVT_WEBVIEW_NAVIGATED;
		case -63: return wxEVT_WEBVIEW_LOADED;
		case -64: return wxEVT_WEBVIEW_ERROR;
		case -65: return wxEVT_WEBVIEW_NEWWINDOW;
		case -66: return wxEVT_WEBVIEW_TITLE_CHANGED;
	}
	
	return 0;
}
