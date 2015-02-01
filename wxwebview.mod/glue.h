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

#include "wxglue.h"
#include "wx/webview.h"

class MaxWebViewHistoryItem;

extern "C" {

#include <blitz.h>

	BBArray * CB_PREF(wx_wxwebview_wxWebViewHistoryItem__newArray)(int size);
	void CB_PREF(wx_wxwebview_wxWebViewHistoryItem__setArrayValue)(BBArray * arr, int index, MaxWebViewHistoryItem * item);

	wxWebView * bmx_wxwebview_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * url, int x, int y,
		int w, int h, long style);
	BBString * bmx_wxwebview_getcurrenttitle(wxWebView * view);
	BBString * bmx_wxwebview_getcurrenturl(wxWebView * view);
	BBString * bmx_wxwebview_getpagesource(wxWebView * view);
	BBString * bmx_wxwebview_getpagetext(wxWebView * view);
	int bmx_wxwebview_isbusy(wxWebView * view);
	int bmx_wxwebview_iseditable(wxWebView * view);
	void bmx_wxwebview_loadurl(wxWebView * view, BBString * url);
	void bmx_wxwebview_print(wxWebView * view);
	void bmx_wxwebview_reload(wxWebView * view, int flags);
	void bmx_wxwebview_runscript(wxWebView * view, BBString * script);
	void bmx_wxwebview_seteditable(wxWebView * view, int enable);
	void bmx_wxwebview_setpage(wxWebView * view, BBString * html, BBString * baseUrl);
	void bmx_wxwebview_setpagestream(wxWebView * view, wxInputStream * html, BBString * baseUrl);
	void bmx_wxwebview_stop(wxWebView * view);
	int bmx_wxwebview_cancopy(wxWebView * view);
	int bmx_wxwebview_cancut(wxWebView * view);
	int bmx_wxwebview_canpaste(wxWebView * view);
	void bmx_wxwebview_copy(wxWebView * view);
	void bmx_wxwebview_cut(wxWebView * view);
	void bmx_wxwebview_paste(wxWebView * view);
	void bmx_wxwebview_enablecontextmenu(wxWebView * view, int enable);
	int bmx_wxwebview_iscontextmenuenabled(wxWebView * view);
	int bmx_wxwebview_cangoback(wxWebView * view);
	int bmx_wxwebview_cangoforward(wxWebView * view);
	void bmx_wxwebview_clearhistory(wxWebView * view);
	void bmx_wxwebview_enablehistory(wxWebView * view, int enable);
	BBArray * bmx_wxwebview_getbackwardhistory(wxWebView * view);
	BBArray * bmx_wxwebview_getforwardhistory(wxWebView * view);
	void bmx_wxwebview_goback(wxWebView * view);
	void bmx_wxwebview_goforward(wxWebView * view);
	void bmx_wxwebview_loadhistoryitem(wxWebView * view, MaxWebViewHistoryItem * item);
	void bmx_wxwebview_clearselection(wxWebView * view);
	void bmx_wxwebview_deleteselection(wxWebView * view);
	BBString * bmx_wxwebview_getselectedsource(wxWebView * view);
	BBString * bmx_wxwebview_getselectedtext(wxWebView * view);
	int bmx_wxwebview_hasselection(wxWebView * view);
	void bmx_wxwebview_selectall(wxWebView * view);
	int bmx_wxwebview_canredo(wxWebView * view);
	int bmx_wxwebview_canundo(wxWebView * view);
	void bmx_wxwebview_redo(wxWebView * view);
	void bmx_wxwebview_undo(wxWebView * view);
	int bmx_wxwebview_find(wxWebView * view, BBString * text, int flags);
	int bmx_wxwebview_cansetzoomtype(wxWebView * view, int zoomtype);
	int bmx_wxwebview_getzoom(wxWebView * view);
	int bmx_wxwebview_getzoomtype(wxWebView * view);
	void bmx_wxwebview_setzoom(wxWebView * view, int zoom);
	void bmx_wxwebview_setzoomtype(wxWebView * view, int zoomType);

	MaxWebViewHistoryItem * bmx_wxwebviewhistoryitem_create(BBString * url, BBString * title);
	BBString * bmx_wxwebviewhistoryitem_geturl(MaxWebViewHistoryItem * item);
	BBString * bmx_wxwebviewhistoryitem_gettitle(MaxWebViewHistoryItem * item);
	void bmx_wxwebviewhistoryitem_free(MaxWebViewHistoryItem * item);

	BBString * bmx_wxwebviewevent_gettarget(wxWebViewEvent & event);
	BBString * bmx_wxwebviewevent_geturl(wxWebViewEvent & event);

	int bmx_wxwebview_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxWebViewHistoryItem
{
public:
	MaxWebViewHistoryItem(wxSharedPtr< wxWebViewHistoryItem > i);
	~MaxWebViewHistoryItem();

	wxSharedPtr< wxWebViewHistoryItem > Item();
	
private:
	wxSharedPtr< wxWebViewHistoryItem > item;
};

