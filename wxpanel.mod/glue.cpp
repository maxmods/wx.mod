/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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


MaxPanel::MaxPanel(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxPanel(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxPanel::MaxPanel()
{}

MaxPanel::~MaxPanel() {
	wxunbind(this);
}

void MaxPanel::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxPanelXmlHandler, wxPanelXmlHandler)

MaxPanelXmlHandler::MaxPanelXmlHandler ()
	: wxPanelXmlHandler()
{}

wxObject * MaxPanelXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(panel, MaxPanel)

    panel->Create(m_parentAsWindow,
                  GetID(),
                  GetPosition(), GetSize(),
                  GetStyle(wxT("style"), wxTAB_TRAVERSAL),
                  GetName());

	panel->MaxBind(_wx_wxpanel_wxPanel__xrcNew(panel));

    SetupWindow(panel);
    CreateChildren(panel);

    return panel;
}

// *********************************************


BEGIN_EVENT_TABLE(MaxPanel, wxPanel)
END_EVENT_TABLE()

MaxPanel * bmx_wxpanel_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxPanel(maxHandle, parent, id, x, y, w, h, style);
}

void bmx_wxpanel_initdialog(wxPanel * panel) {
	panel->InitDialog();
}

void bmx_wxpanel_setfocus(wxPanel * panel) {
	panel->SetFocus();
}

void bmx_wxpanel_setfocusignoringchildren(wxPanel * panel) {
	panel->SetFocusIgnoringChildren();
}

// *********************************************

void bmx_wxpanel_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxPanelXmlHandler);
}


