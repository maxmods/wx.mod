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

MaxStatusBar::MaxStatusBar(wxWindow * parent, long style, wxWindowID id, const wxString& name)
	: wxStatusBar(parent, id, style, name)
{
}

MaxStatusBar::MaxStatusBar(BBObject * handle, wxWindow * parent, wxWindowID id, long style)
	: wxStatusBar(parent, id, style)
{
	wxbind(this, handle);
}

MaxStatusBar::MaxStatusBar()
{}

void MaxStatusBar::injectSelf(BBObject * handle) {
	wxbind(this, handle);
}

MaxStatusBar::~MaxStatusBar() {
	wxunbind(this);
}

void MaxStatusBar::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxStatusBarXmlHandler, wxStatusBarXmlHandler)

MaxStatusBarXmlHandler::MaxStatusBarXmlHandler()
	: wxStatusBarXmlHandler()
{}


wxObject * MaxStatusBarXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(statbar, MaxStatusBar)

    statbar->Create(m_parentAsWindow,
                    GetID(),
                    GetStyle(),
                    GetName());

	statbar->MaxBind(_wx_wxstatusbar_wxStatusBar__xrcNew(statbar));

    int fields = GetLong(wxT("fields"), 1);
    wxString widths = GetParamValue(wxT("widths"));
    wxString styles = GetParamValue(wxT("styles"));

    if (fields > 1 && !widths.IsEmpty())
    {
        int *width = new int[fields];

        for (int i = 0; i < fields; ++i)
        {
            width[i] = wxAtoi(widths.BeforeFirst(wxT(',')));
            if(widths.Find(wxT(',')))
                widths.Remove(0, widths.Find(wxT(',')) + 1);
        }
        statbar->SetFieldsCount(fields, width);
        delete[] width;
    }
    else
        statbar->SetFieldsCount(fields);

    if (!styles.empty())
    {
        int *style = new int[fields];
        for (int i = 0; i < fields; ++i)
        {
            style[i] = wxSB_NORMAL;

            wxString first = styles.BeforeFirst(wxT(','));
            if (first == wxT("wxSB_NORMAL"))
                style[i] = wxSB_NORMAL;
            else if (first == wxT("wxSB_FLAT"))
                style[i] = wxSB_FLAT;
            else if (first == wxT("wxSB_RAISED"))
                style[i] = wxSB_RAISED;
            else if (!first.empty())
                wxLogError(wxT("Error in resource, unknown statusbar field style: ") + first);

            if(styles.Find(wxT(',')))
                styles.Remove(0, styles.Find(wxT(',')) + 1);
        }
        statbar->SetStatusStyles(fields, style);
        delete [] style;
    }

    CreateChildren(statbar);

    if (m_parentAsWindow)
    {
        wxFrame *parentFrame = wxDynamicCast(m_parent, wxFrame);
        if (parentFrame)
            parentFrame->SetStatusBar(statbar);
    }

    return statbar;
}


// *********************************************



void bmx_wxstatusbar_injectSelf(MaxStatusBar * statusbar, BBObject * handle) {
	statusbar->injectSelf(handle);
}

BEGIN_EVENT_TABLE(MaxStatusBar, wxStatusBar)
END_EVENT_TABLE()


MaxStatusBar * bmx_wxstatusbar_create(BBObject * handle, wxWindow * parent, int id, long style) {
	return new MaxStatusBar(handle, parent, id, style);
}

bool bmx_wxstatusbar_getfieldrect(wxStatusBar * statusbar, int index, int * x, int * y, int * w, int * h) {
	wxRect r;
	bool ret = statusbar->GetFieldRect(index, r);
	*x = r.x;
	*y = r.y;
	*w = r.width;
	*h = r.height;
	return ret;
}

MaxRect * bmx_wxstatusbar_getfieldrectrect(wxStatusBar * statusbar, int index) {
	wxRect r;
	bool ret = statusbar->GetFieldRect(index, r);
	if (ret) {
		return new MaxRect(r);
	}
	return 0;
}

int bmx_wxstatusbar_getfieldscount(wxStatusBar * statusbar) {
	return statusbar->GetFieldsCount();
}

BBString *  bmx_wxstatusbar_getstatustext(wxStatusBar * statusbar, int index) {
	return bbStringFromWxString(statusbar->GetStatusText(index));
}

void bmx_wxstatusbar_popstatustext(wxStatusBar * statusbar, int index) {
	statusbar->PopStatusText(index);
}

void bmx_wxstatusbar_pushstatustext(wxStatusBar * statusbar, BBString * text, int index) {
	statusbar->PushStatusText(wxStringFromBBString(text), index);
}

void bmx_wxstatusbar_setfieldscount(wxStatusBar * statusbar, int count) {
	statusbar->SetFieldsCount(count);
}

void bmx_wxstatusbar_setminheight(wxStatusBar * statusbar, int height) {
	statusbar->SetMinHeight(height);
}

void bmx_wxstatusbar_setstatustext(wxStatusBar * statusbar, BBString * text, int index) {
	statusbar->SetStatusText(wxStringFromBBString(text), index);
}

void bmx_wxstatusbar_setstatuswidths(wxStatusBar * statusbar, BBArray * widths) {
	statusbar->SetStatusWidths(widths->scales[0], (int*)BBARRAYDATA( widths, widths->dims ));
}

void bmx_wxstatusbar_setstatusstyles(wxStatusBar * statusbar, BBArray * styles) {
	statusbar->SetStatusStyles(styles->scales[0], (int*)BBARRAYDATA( styles, styles->dims ));
}

// *********************************************

void bmx_wxstatusbar_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxStatusBarXmlHandler);
}
