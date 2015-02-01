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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxCollapsiblePane::MaxCollapsiblePane(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxCollapsiblePane(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxCollapsiblePane::MaxCollapsiblePane()
{}

MaxCollapsiblePane::~MaxCollapsiblePane() {
	wxunbind(this);
}

void MaxCollapsiblePane::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxCollapsiblePaneXmlHandler, wxCollapsiblePaneXmlHandler)

MaxCollapsiblePaneXmlHandler::MaxCollapsiblePaneXmlHandler()
	: wxCollapsiblePaneXmlHandler(), m_isInside(false)
{}


wxObject * MaxCollapsiblePaneXmlHandler::DoCreateResource()
{
    if (m_class == wxT("panewindow"))   // read the XRC for the pane window
    {
        wxXmlNode *n = GetParamNode(wxT("object"));

        if ( !n )
            n = GetParamNode(wxT("object_ref"));

        if (n)
        {
            bool old_ins = m_isInside;
            m_isInside = false;
            wxObject *item = CreateResFromNode(n, m_collpane->GetPane(), NULL);
            m_isInside = old_ins;

            return item;
        }
        else
        {
            wxLogError(wxT("Error in resource: no control within collapsible pane's <panewindow> tag."));
            return NULL;
        }
    }
    else
    {
        XRC_MAKE_INSTANCE(ctrl, MaxCollapsiblePane)

        wxString label = GetParamValue(wxT("label"));
        if (label.empty())
        {
            wxLogError(wxT("Error in resource: empty label for wxCollapsiblePane"));
            return NULL;
        }

        ctrl->Create(m_parentAsWindow,
                    GetID(),
                    label,
                    GetPosition(), GetSize(),
                    GetStyle(_T("style"), wxCP_DEFAULT_STYLE),
                    wxDefaultValidator,
                    GetName());


		ctrl->MaxBind(CB_PREF(wx_wxcollapsiblepane_wxCollapsiblePane__xrcNew)(ctrl));

        ctrl->Collapse(GetBool(_T("collapsed")));
        SetupWindow(ctrl);

        wxCollapsiblePane *old_par = m_collpane;
        m_collpane = ctrl;
        bool old_ins = m_isInside;
        m_isInside = true;
        CreateChildren(m_collpane, true/*only this handler*/);
        m_isInside = old_ins;
        m_collpane = old_par;

        return ctrl;
    }

}

bool MaxCollapsiblePaneXmlHandler::CanHandle(wxXmlNode *node)
{
    return IsOfClass(node, wxT("wxCollapsiblePane")) ||
            (m_isInside && IsOfClass(node, wxT("panewindow")));
}

// *********************************************

MaxCollapsiblePane * bmx_wxcollapsiblepane_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxCollapsiblePane(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

int bmx_wxcollapsiblepane_iscollapsed(wxCollapsiblePane * pane) {
	return static_cast<int>(pane->IsCollapsed());
}

int bmx_wxcollapsiblepane_isexpanded(wxCollapsiblePane * pane) {
	return static_cast<int>(pane->IsExpanded());
}

void bmx_wxcollapsiblepane_collapse(wxCollapsiblePane * pane, int value) {
	pane->Collapse(static_cast<bool>(value));
}

void bmx_wxcollapsiblepane_expand(wxCollapsiblePane * pane) {
	pane->Expand();
}

wxWindow * bmx_wxcollapsiblepane_getpane(wxCollapsiblePane * pane) {
	return pane->GetPane();
}


int bmx_wxcollapsiblepaneevent_getcollapsed(wxCollapsiblePaneEvent & event) {
	return static_cast<int>(event.GetCollapsed());
}

void bmx_wxcollapsiblepaneevent_setcollapsed(wxCollapsiblePaneEvent & event, int value) {
	event.SetCollapsed(static_cast<bool>(value));
}


int bmx_wxcollapsiblepane_geteventtype(int type) {
	switch(type) {
		case 1102: return wxEVT_COMMAND_COLLPANE_CHANGED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxcollapsiblepane_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxCollapsiblePaneXmlHandler);
}
