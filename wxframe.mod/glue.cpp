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


BEGIN_EVENT_TABLE(MaxFrame, wxFrame)
END_EVENT_TABLE()

MaxFrame::MaxFrame()
{}

MaxFrame::MaxFrame(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& title, int x,
		int y, int w, int h, long style)
       : wxFrame(parent, id, title, wxPoint(x, y), wxSize(w,h), style)
{
	wxbind(this, handle);
}

MaxFrame::~MaxFrame() {
	wxunbind(this);
}

MaxStatusBar * MaxFrame::OnCreateStatusBar(int number, long style, wxWindowID id, const wxString& name) {
	MaxStatusBar * statusbar = new MaxStatusBar(this, style, id, name);
	statusbar->SetFieldsCount(number);
	return statusbar;
}


MaxToolBar * MaxFrame::OnCreateToolBar(long style, wxWindowID id, const wxString& name) {
	return new MaxToolBar(this, style, id, name);
}

void MaxFrame::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxFrameXmlHandler, wxFrameXmlHandler)

MaxFrameXmlHandler::MaxFrameXmlHandler()
	: wxFrameXmlHandler()
{}


wxObject * MaxFrameXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(frame, MaxFrame);

    frame->Create(m_parentAsWindow,
                  GetID(),
                  GetText(wxT("title")),
                  wxDefaultPosition, wxDefaultSize,
                  GetStyle(wxT("style"), wxDEFAULT_FRAME_STYLE),
                  GetName());

	frame->MaxBind(_wx_wxframe_wxFrame__xrcNew(frame));

    if (HasParam(wxT("size")))
        frame->SetClientSize(GetSize(wxT("size"), frame));
    if (HasParam(wxT("pos")))
        frame->Move(GetPosition());
    if (HasParam(wxT("icon")))
        frame->SetIcon(GetIcon(wxT("icon"), wxART_FRAME_ICON));

    SetupWindow(frame);

    CreateChildren(frame);

    if (GetBool(wxT("centered"), false))
        frame->Centre();

    return frame;
}



// ---------------------------------------------------------------------------------------

MaxFrame * bmx_wxframe_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, BBString * title, int x,
		int y, int w, int h, long style) {
		
	return new MaxFrame(maxHandle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
}

void bmx_wxframe_setmenubar(wxFrame * frame, MaxMenuBar * menubar) {
	frame->SetMenuBar(menubar);
}

MaxStatusBar * bmx_wxframe_createstatusbar(wxFrame * frame, int number, long style, wxWindowID id) {
	return (MaxStatusBar *)frame->CreateStatusBar(number, style, id);
}

void bmx_wxframe_setstatustext(wxFrame * frame, BBString * text, int number) {
	frame->SetStatusText(wxStringFromBBString(text), number);
}

wxMenuBar * bmx_wxframe_getmenubar(wxFrame * frame) {
	return frame->GetMenuBar();
}

void bmx_wxframe_setstatusbar(wxFrame * frame, wxStatusBar * statusbar) {
	if (statusbar) {
		frame->SetStatusBar(statusbar);
	} else {
		frame->SetStatusBar(NULL);
	}
}

wxStatusBar * bmx_wxframe_getstatusbar(wxFrame * frame) {
	return frame->GetStatusBar();
}

void bmx_wxframe_positionstatusbar(MaxFrame * frame) {
	frame->PositionStatusBar();
}

wxToolBar * bmx_wxframe_createtoolbar(wxFrame * frame, long style, wxWindowID id) {
	return frame->CreateToolBar(style, id);
}

wxToolBar * bmx_wxframe_gettoolbar(wxFrame * frame) {
	return frame->GetToolBar();
}

void bmx_wxframe_settoolbar(wxFrame * frame, wxToolBar * toolbar) {
	frame->SetToolBar(toolbar);
}

void bmx_wxframe_sendsizeevent(wxFrame * frame) {
	frame->SendSizeEvent();
}

void bmx_wxframe_processcommand(wxFrame * frame, int id) {
	frame->ProcessCommand(id);
}

void bmx_wxframe_setstatusbarpane(wxFrame * frame, int n) {
	frame->SetStatusBarPane(n);
}

// *********************************************

void bmx_wxframe_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxFrameXmlHandler);
}

