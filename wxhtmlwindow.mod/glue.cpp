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

MaxHtmlWindow::MaxHtmlWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxHtmlWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxHtmlWindow::MaxHtmlWindow()
{}

MaxHtmlWindow::~MaxHtmlWindow() {
	wxunbind(this);
}

wxHtmlOpeningStatus MaxHtmlWindow::OnOpeningURL(wxHtmlURLType type,const wxString& url, wxString *redirect) const {
	wxHtmlOpeningStatus status;

	*redirect = wxStringFromBBString(CB_PREF(wx_wxhtmlwindow_wxHtmlWindow__OnOpeningURL)(maxHandle, type,
		bbStringFromWxString(url), &status));

	return status;
}

void MaxHtmlWindow::OnSetTitle(const wxString& title) const{
	CB_PREF(wx_wxhtmlwindow_wxHtmlWindow__OnSetTitle)(maxHandle, bbStringFromWxString(title));
}

void MaxHtmlWindow::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

MaxHtmlProcessor::MaxHtmlProcessor(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxHtmlProcessor::~MaxHtmlProcessor() {
	wxunbind(this);
}

wxString MaxHtmlProcessor::Process(const wxString& text) const {
	return wxStringFromBBString(CB_PREF(wx_wxhtmlwindow_wxHtmlProcessor__Process)(maxHandle, bbStringFromWxString(text)));
}


MaxHtmlLinkInfo::MaxHtmlLinkInfo(const wxHtmlLinkInfo & linkInfo)
{
	info = linkInfo;
}

wxHtmlLinkInfo & MaxHtmlLinkInfo::Info() {
	return info;
}

MaxHtmlTagsModule::MaxHtmlTagsModule(BBObject * handle)
	: maxHandle(handle), wxHtmlTagsModule()
{
	RegisterModule(this);
	wxHtmlWinParser::AddModule(this);
	wxbind(this, handle);
}

void MaxHtmlTagsModule::FillHandlersTable(wxHtmlWinParser *parser) {
	CB_PREF(wx_wxhtmlwindow_wxHtmlTagsModule__FillHandlersTable)(maxHandle, parser);
}


MaxHtmlTagHandler::MaxHtmlTagHandler(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxHtmlTagHandler::~MaxHtmlTagHandler() {
	wxunbind(this);
}

bool MaxHtmlTagHandler::HandleTag(const wxHtmlTag& tag) {
	return static_cast<bool>(CB_PREF(wx_wxhtmlwindow_wxHtmlTagHandler__HandleTag)(maxHandle, new MaxHtmlTag(tag)));
}

wxString MaxHtmlTagHandler::GetSupportedTags() {
	return wxStringFromBBString(CB_PREF(wx_wxhtmlwindow_wxHtmlTagHandler__GetSupportedTags)(maxHandle));
}


MaxHtmlTag::MaxHtmlTag(const wxHtmlTag & t)
{
	tag = &t;
}

const wxHtmlTag & MaxHtmlTag::Tag() {
	return *tag;
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxHtmlWindowXmlHandler, wxHtmlWindowXmlHandler)

MaxHtmlWindowXmlHandler::MaxHtmlWindowXmlHandler()
	: wxHtmlWindowXmlHandler()
{}


wxObject * MaxHtmlWindowXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxHtmlWindow)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetPosition(), GetSize(),
                    GetStyle(wxT("style"), wxHW_SCROLLBAR_AUTO),
                    GetName());

    if (HasParam(wxT("borders")))
    {
        control->SetBorders(GetDimension(wxT("borders")));
    }

    if (HasParam(wxT("url")))
    {
        wxString url = GetParamValue(wxT("url"));
        wxFileSystem& fsys = GetCurFileSystem();

        wxFSFile *f = fsys.OpenFile(url);
        if (f)
        {
            control->LoadPage(f->GetLocation());
            delete f;
        }
        else
            control->LoadPage(url);
    }

    else if (HasParam(wxT("htmlcode")))
    {
        control->SetPage(GetText(wxT("htmlcode")));
    }

	control->MaxBind(CB_PREF(wx_wxhtmlwindow_wxHtmlWindow__xrcNew)(control));

    SetupWindow(control);

    return control;

}

// *********************************************

BEGIN_EVENT_TABLE(MaxHtmlWindow, wxHtmlWindow)
END_EVENT_TABLE()


MaxHtmlWindow * bmx_wxhtmlwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style) {

	return new MaxHtmlWindow(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxhtmlwindow_setpage(wxHtmlWindow * window, BBString * source) {
	return static_cast<int>(window->SetPage(wxStringFromBBString(source)));
}


int bmx_wxhtmlwindow_appendtopage(wxHtmlWindow * window, BBString * source) {
	return static_cast<int>(window->AppendToPage(wxStringFromBBString(source)));
}

BBString * bmx_wxhtmlwindow_getopenedanchor(wxHtmlWindow * window) {
	return bbStringFromWxString(window->GetOpenedAnchor());
}

BBString * bmx_wxhtmlwindow_getopenedpage(wxHtmlWindow * window) {
	return bbStringFromWxString(window->GetOpenedPage());
}

BBString * bmx_wxhtmlwindow_getopenedpagetitle(wxHtmlWindow * window) {
	return bbStringFromWxString(window->GetOpenedPageTitle());
}

wxFrame * bmx_wxhtmlwindow_getrelatedframe(wxHtmlWindow * window) {
	return window->GetRelatedFrame();
}

int bmx_wxhtmlwindow_historyback(wxHtmlWindow * window) {
	return static_cast<int>(window->HistoryBack());
}

int bmx_wxhtmlwindow_hisotrycanback(wxHtmlWindow * window) {
	return static_cast<int>(window->HistoryCanBack());
}

int bmx_wxhtmlwindow_historycanforward(wxHtmlWindow * window) {
	return static_cast<int>(window->HistoryCanForward());
}

void bmx_wxhtmlwindow_historyclear(wxHtmlWindow * window) {
	window->HistoryClear();
}

int bmx_wxhtmlwindow_historyforward(wxHtmlWindow * window) {
	return static_cast<int>(window->HistoryForward());
}

int bmx_wxhtmlwindow_loadpage(wxHtmlWindow * window, BBString * location) {
	return static_cast<int>(window->LoadPage(wxStringFromBBString(location)));
}

void bmx_wxhtmlwindow_selectall(wxHtmlWindow * window) {
	window->SelectAll();
}

BBString * bmx_wxhtmlwindow_selectiontotext(wxHtmlWindow * window) {
	return bbStringFromWxString(window->SelectionToText());
}

void bmx_wxhtmlwindow_selectline(wxHtmlWindow * window, int x, int y) {
	window->SelectLine(wxPoint(x, y));
}

void bmx_wxhtmlwindow_selectword(wxHtmlWindow * window, int x, int y) {
	window->SelectWord(wxPoint(x, y));
}

void bmx_wxhtmlwindow_setborders(wxHtmlWindow * window, int size) {
	window->SetBorders(size);
}

void bmx_wxhtmlwindow_setfonts(wxHtmlWindow * window, BBString * normalFace, BBString * fixedFace, BBArray * sizes) {
	//window->SetFonts(wxStringFromBBString(normalFace), wxStringFromBBString(fixedFace), 
}

void bmx_wxhtmlwindow_setrelatedframe(wxHtmlWindow * window, wxFrame * frame, BBString * format) {
	window->SetRelatedFrame(frame, wxStringFromBBString(format));
}

void bmx_wxhtmlwindow_setrelatedstatusbar(wxHtmlWindow * window, int bar) {
	window->SetRelatedStatusBar(bar);
}

BBString * bmx_wxhtmlwindow_totext(wxHtmlWindow * window) {
	return bbStringFromWxString(window->ToText());
}


MaxHtmlLinkInfo * bmx_wxhtmllinkevent_getlinkinfo(wxHtmlLinkEvent & event) {
	return new MaxHtmlLinkInfo(event.GetLinkInfo());
}

void bmx_wxhtmlcellevent_getpoint(wxHtmlCellEvent & event, int * x, int * y) {
	wxPoint p = event.GetPoint();
	*x = p.x;
	*y = p.y;
}

void bmx_wxhtmlcellevent_setlinkclicked(wxHtmlCellEvent & event, int clicked) {
	event.SetLinkClicked(static_cast<bool>(clicked));
}

int bmx_wxhtmlcellevent_getlinkclicked(wxHtmlCellEvent & event) {
	return static_cast<int>(event.GetLinkClicked());
}

wxHtmlCell * bmx_wxhtmlcellevent_getcell(wxHtmlCellEvent & event) {
	return event.GetCell();
}



const wxMouseEvent & bmx_wxhtmllinkinfo_getevent(MaxHtmlLinkInfo * info) {
	return * info->Info().GetEvent();
}

BBString * bmx_wxhtmllinkinfo_gethref(MaxHtmlLinkInfo * info) {
	return bbStringFromWxString(info->Info().GetHref());
}

BBString * bmx_wxhtmllinkinfo_gettarget(MaxHtmlLinkInfo * info) {
	return bbStringFromWxString(info->Info().GetTarget());
}

void bmx_wxhtmllinkinfo_delete(MaxHtmlLinkInfo * info) {
	delete info;
}


void bmx_wxhtmlwindow_addprocessor(wxHtmlWindow * window, wxHtmlProcessor * proc) {
	window->AddProcessor(proc);
}

MaxHtmlProcessor * bmx_wxhtmlprocessor_create(BBObject * handle) {
	return new MaxHtmlProcessor(handle);
}

void bmx_wxhtmlprocessor_enable(wxHtmlProcessor * proc, int value) {
	proc->Enable(static_cast<bool>(value));
}

int bmx_wxhtmlprocessor_isenabled(wxHtmlProcessor * proc) {
	return static_cast<int>(proc->IsEnabled());
}


int bmx_wxhtmlevent_geteventtype(int type) {
	switch(type) {
		case 1000: return wxEVT_COMMAND_HTML_CELL_CLICKED;
		case 1001: return wxEVT_COMMAND_HTML_CELL_HOVER;
		case 1002: return wxEVT_COMMAND_HTML_LINK_CLICKED;
	}
	
	return 0;
}

// *********************************************


void bmx_wxhtmltag_delete(MaxHtmlTag * tag) {
	delete tag;
}

BBString * bmx_wxhtmltag_getallparams(MaxHtmlTag * tag) {
	return bbStringFromWxString(tag->Tag().GetAllParams());
}

int bmx_wxhtmltag_getbeginpos(MaxHtmlTag * tag) {
	return tag->Tag().GetBeginPos();
}

int bmx_wxhtmltag_getendpos1(MaxHtmlTag * tag) {
	return tag->Tag().GetEndPos1();
}

int bmx_wxhtmltag_getendpos2(MaxHtmlTag * tag) {
	return tag->Tag().GetEndPos2();
}

BBString * bmx_wxhtmltag_getname(MaxHtmlTag * tag) {
	return bbStringFromWxString(tag->Tag().GetName());
}

BBString * bmx_wxhtmltag_getparam(MaxHtmlTag * tag, BBString * par, int withCommas) {
	return bbStringFromWxString(tag->Tag().GetParam(wxStringFromBBString(par), static_cast<bool>(withCommas)));
}

MaxColour * bmx_wxhtmltag_getparamascolour(MaxHtmlTag * tag, BBString * par) {
	wxColour c;
	if (tag->Tag().GetParamAsColour(wxStringFromBBString(par), &c)) {
		return new MaxColour(c);
	}
	return new MaxColour(wxNullColour);
}

int bmx_wxhtmltag_getparamasint(MaxHtmlTag * tag, BBString * par, int * value) {
	return tag->Tag().GetParamAsInt(wxStringFromBBString(par), value);
}

int bmx_wxhtmltag_hasending(MaxHtmlTag * tag) {
	return static_cast<int>(tag->Tag().HasEnding());
}

int bmx_wxhtmltag_hasparam(MaxHtmlTag * tag, BBString * par) {
	return static_cast<int>(tag->Tag().HasParam(wxStringFromBBString(par)));
}


// *********************************************

MaxHtmlTagsModule * bmx_wxhtmltagsmodule_create(BBObject * handle) {
	return new MaxHtmlTagsModule(handle);
}

MaxHtmlTagHandler * bmx_wxhtmltaghandler_create(BBObject * handle) {
	return new MaxHtmlTagHandler(handle);
}

wxHtmlWinParser * bmx_wxhtmltaghandler_getparser(MaxHtmlTagHandler * handler) {
	return handler->GetParser();
}

void bmx_wxhtmltaghandler_parseinner(MaxHtmlTagHandler * handler, MaxHtmlTag * tag) {
	handler->XParseInner(tag->Tag());
}


void bmx_wxhtmlcontainercell_insertcell(wxHtmlContainerCell * container, wxHtmlCell * cell) {
	container->InsertCell(cell);
}

wxHtmlWidgetCell * bmx_wxhtmlwidgetcell_create(wxWindow * wnd, int w) {
	return new wxHtmlWidgetCell(wnd, w);
}

void bmx_wxhtmlparser_addtaghandler(wxHtmlParser * parser, wxHtmlTagHandler * handler) {
	parser->AddTagHandler(handler);
}

// *********************************************

wxHtmlContainerCell * bmx_wxhtmlwinparser_getcontainer(wxHtmlWinParser * parser) {
	return parser->GetContainer();
}

wxHtmlWindowInterface * bmx_wxhtmlwinparser_getwindowinterface(wxHtmlWinParser * parser) {
	return parser->GetWindowInterface();
}
	
wxWindow * bmx_wxhtmlwindowinterface_gethtmlwindow(wxHtmlWindowInterface * win) {
	return win->GetHTMLWindow();
}

// *********************************************

void bmx_wxhtmlwindow_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxHtmlWindowXmlHandler);
}
