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
#include "wx/html/htmlwin.h"
#include "wx/html/htmlproc.h"
#include "wx/html/htmlcell.h"

class MaxHtmlWindow;
class MaxHtmlProcessor;
class MaxHtmlLinkInfo;
class MaxHtmlTagsModule;
class MaxHtmlTag;
class MaxHtmlTagHandler;

extern "C" {

#include <blitz.h>

	BBString * _wx_wxhtmlwindow_wxHtmlProcessor__Process(BBObject * handle, BBString * text);
	BBString * _wx_wxhtmlwindow_wxHtmlWindow__OnOpeningURL(BBObject * handle, wxHtmlURLType urlType, BBString * url, wxHtmlOpeningStatus * returnStatus);
	void _wx_wxhtmlwindow_wxHtmlWindow__OnSetTitle(BBObject * handle, BBString * title);
	void _wx_wxhtmlwindow_wxHtmlTagsModule__FillHandlersTable(BBObject * handle, wxHtmlWinParser * parser);
	bool _wx_wxhtmlwindow_wxHtmlTagHandler__HandleTag(BBObject * handle, MaxHtmlTag * tag);
	BBString * _wx_wxhtmlwindow_wxHtmlTagHandler__GetSupportedTags(BBObject * handle);

	MaxHtmlWindow * bmx_wxhtmlwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	bool bmx_wxhtmlwindow_setpage(wxHtmlWindow * window, BBString * source);

	bool bmx_wxhtmlwindow_appendtopage(wxHtmlWindow * window, BBString * source);
	BBString * bmx_wxhtmlwindow_getopenedanchor(wxHtmlWindow * window);
	BBString * bmx_wxhtmlwindow_getopenedpage(wxHtmlWindow * window);
	BBString * bmx_wxhtmlwindow_getopenedpagetitle(wxHtmlWindow * window);
	wxFrame * bmx_wxhtmlwindow_getrelatedframe(wxHtmlWindow * window);
	bool bmx_wxhtmlwindow_historyback(wxHtmlWindow * window);
	bool bmx_wxhtmlwindow_hisotrycanback(wxHtmlWindow * window);
	bool bmx_wxhtmlwindow_historycanforward(wxHtmlWindow * window);
	void bmx_wxhtmlwindow_historyclear(wxHtmlWindow * window);
	bool bmx_wxhtmlwindow_historyforward(wxHtmlWindow * window);
	bool bmx_wxhtmlwindow_loadpage(wxHtmlWindow * window, BBString * location);
	void bmx_wxhtmlwindow_selectall(wxHtmlWindow * window);
	BBString * bmx_wxhtmlwindow_selectiontotext(wxHtmlWindow * window);
	void bmx_wxhtmlwindow_selectline(wxHtmlWindow * window, int x, int y);
	void bmx_wxhtmlwindow_selectword(wxHtmlWindow * window, int x, int y);
	void bmx_wxhtmlwindow_setborders(wxHtmlWindow * window, int size);
	void bmx_wxhtmlwindow_setfonts(wxHtmlWindow * window, BBString * normalFace, BBString * fixedFace, BBArray * sizes);
	void bmx_wxhtmlwindow_setrelatedframe(wxHtmlWindow * window, wxFrame * frame, BBString * format);
	void bmx_wxhtmlwindow_setrelatedstatusbar(wxHtmlWindow * window, int bar);
	BBString * bmx_wxhtmlwindow_totext(wxHtmlWindow * window);

	void bmx_wxhtmlwindow_addprocessor(wxHtmlWindow * window, wxHtmlProcessor * proc);

	MaxHtmlProcessor * bmx_wxhtmlprocessor_create(BBObject * handle);
	void bmx_wxhtmlprocessor_enable(wxHtmlProcessor * proc, bool value);
	bool bmx_wxhtmlprocessor_isenabled(wxHtmlProcessor * proc);

	MaxHtmlLinkInfo * bmx_wxhtmllinkevent_getlinkinfo(wxHtmlLinkEvent & event);
	
	void bmx_wxhtmlcellevent_getpoint(wxHtmlCellEvent & event, int * x, int * y);
	void bmx_wxhtmlcellevent_setlinkclicked(wxHtmlCellEvent & event, bool clicked);
	bool bmx_wxhtmlcellevent_getlinkclicked(wxHtmlCellEvent & event);
	wxHtmlCell * bmx_wxhtmlcellevent_getcell(wxHtmlCellEvent & event);


	const wxMouseEvent & bmx_wxhtmllinkinfo_getevent(MaxHtmlLinkInfo * info);
	BBString * bmx_wxhtmllinkinfo_gethref(MaxHtmlLinkInfo * info);
	BBString * bmx_wxhtmllinkinfo_gettarget(MaxHtmlLinkInfo * info);
	void bmx_wxhtmllinkinfo_delete(MaxHtmlLinkInfo * info);

	int bmx_wxhtmlevent_geteventtype(int type);
	
	
	MaxHtmlTagsModule * bmx_wxhtmltagsmodule_create(BBObject * handle);

	void bmx_wxhtmltag_delete(MaxHtmlTag * tag);
	BBString * bmx_wxhtmltag_getallparams(MaxHtmlTag * tag);
	int bmx_wxhtmltag_getbeginpos(MaxHtmlTag * tag);
	int bmx_wxhtmltag_getendpos1(MaxHtmlTag * tag);
	int bmx_wxhtmltag_getendpos2(MaxHtmlTag * tag);
	BBString * bmx_wxhtmltag_getname(MaxHtmlTag * tag);
	BBString * bmx_wxhtmltag_getparam(MaxHtmlTag * tag, BBString * par, bool withCommas);
	MaxColour * bmx_wxhtmltag_getparamascolour(MaxHtmlTag * tag, BBString * par);
	int bmx_wxhtmltag_getparamasint(MaxHtmlTag * tag, BBString * par, int * value);
	bool bmx_wxhtmltag_hasending(MaxHtmlTag * tag);
	bool bmx_wxhtmltag_hasparam(MaxHtmlTag * tag, BBString * par);

	MaxHtmlTagHandler * bmx_wxhtmltaghandler_create(BBObject * handle);
	wxHtmlWinParser * bmx_wxhtmltaghandler_getparser(MaxHtmlTagHandler * handler);
	void bmx_wxhtmltaghandler_parseinner(MaxHtmlTagHandler * handler, MaxHtmlTag * tag);

	void bmx_wxhtmlcontainercell_insertcell(wxHtmlContainerCell * container, wxHtmlCell * cell);
	wxHtmlWidgetCell * bmx_wxhtmlwidgetcell_create(wxWindow * wnd, int w);

	void bmx_wxhtmlparser_addtaghandler(wxHtmlParser * parser, wxHtmlTagHandler * handler);

	wxHtmlContainerCell * bmx_wxhtmlwinparser_getcontainer(wxHtmlWinParser * parser);
	wxHtmlWindowInterface * bmx_wxhtmlwinparser_getwindowinterface(wxHtmlWinParser * parser);

	wxWindow * bmx_wxhtmlwindowinterface_gethtmlwindow(wxHtmlWindowInterface * win);

}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxHtmlWindow : public wxHtmlWindow
{
public:
	MaxHtmlWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	~MaxHtmlWindow();
	
	virtual wxHtmlOpeningStatus OnOpeningURL(wxHtmlURLType type, const wxString& url, wxString *redirect) const;
	virtual void OnSetTitle(const wxString& title) const;
	
private:
	BBObject * maxHandle;
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

class MaxHtmlProcessor : public wxHtmlProcessor
{
public:
	MaxHtmlProcessor(BBObject * handle);
	~MaxHtmlProcessor();

	wxString Process(const wxString& text) const;

private:
	BBObject * maxHandle;
};

class MaxHtmlLinkInfo
{
public:
	MaxHtmlLinkInfo(const wxHtmlLinkInfo & linkInfo);
	wxHtmlLinkInfo & Info();

private:
	wxHtmlLinkInfo info;

};

class MaxHtmlTagsModule : public wxHtmlTagsModule
{
public:
	MaxHtmlTagsModule(BBObject * handle);
	
	virtual void FillHandlersTable(wxHtmlWinParser *parser);

private :
	BBObject * maxHandle;
	
};

class MaxHtmlTag
{
public:
	MaxHtmlTag(const wxHtmlTag & t);
	const wxHtmlTag & Tag();

private:
	const wxHtmlTag * tag;

};

class MaxHtmlTagHandler : public wxHtmlWinTagHandler
{
public :
	MaxHtmlTagHandler(BBObject * handle);
	~MaxHtmlTagHandler();
	
	virtual bool HandleTag(const wxHtmlTag& tag);
	virtual wxString GetSupportedTags();
	
	wxHtmlWinParser * GetParser() { return m_WParser; }
	void XParseInner(const wxHtmlTag& tag) { ParseInner(tag); }
	
private:
	BBObject * maxHandle;
	
};