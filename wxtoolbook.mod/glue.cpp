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

MaxToolbook::MaxToolbook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxToolbook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxToolbook::MaxToolbook()
{
}

MaxToolbook::~MaxToolbook() {
	wxunbind(this);
}

void MaxToolbook::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxToolbookXmlHandler, wxToolbookXmlHandler)

MaxToolbookXmlHandler::MaxToolbookXmlHandler()
	: wxToolbookXmlHandler()
{}


wxObject * MaxToolbookXmlHandler::DoCreateResource()
{
    if (m_class == wxT("toolbookpage"))
    {
        wxXmlNode *n = GetParamNode(wxT("object"));

        if ( !n )
            n = GetParamNode(wxT("object_ref"));

        if (n)
        {
            bool old_ins = m_isInside;
            m_isInside = false;
            wxObject *item = CreateResFromNode(n, m_toolbook, NULL);
            m_isInside = old_ins;
            wxWindow *wnd = wxDynamicCast(item, wxWindow);

            if (wnd)
            {
                int imgId = -1;

                if ( HasParam(wxT("bitmap")) )
                {
                    wxBitmap bmp = GetBitmap(wxT("bitmap"), wxART_OTHER);
                    wxImageList *imgList = m_toolbook->GetImageList();
                    if ( imgList == NULL )
                    {
                        imgList = new wxImageList( bmp.GetWidth(), bmp.GetHeight() );
                        m_toolbook->AssignImageList( imgList );
                    }
                    imgId = imgList->Add(bmp);
                }
                else if ( HasParam(wxT("image")) )
                {
                    if ( m_toolbook->GetImageList() )
                    {
                        imgId = (int)GetLong(wxT("image"));
                    }
                    else // image without image list?
                    {
                        ReportError(n, "image can only be used in conjunction "
                                       "with imagelist");
                    }
                }

                m_toolbook->AddPage(wnd, GetText(wxT("label")),
                        GetBool(wxT("selected")), imgId );
            }
            else
            {
                ReportError(n, "toolbookpage child must be a window");
            }
            return wnd;
        }
        else
        {
            ReportError("toolbookpage must have a window child");
            return NULL;
        }
    }

    else
    {
        XRC_MAKE_INSTANCE(nb, MaxToolbook)

        nb->Create( m_parentAsWindow,
                    GetID(),
                    GetPosition(), GetSize(),
                    GetStyle(wxT("style")),
                    GetName() );

		nb->MaxBind(CB_PREF(wx_wxtoolbook_wxToolbook__xrcNew)(nb));

        wxImageList *imagelist = GetImageList();
        if ( imagelist )
            nb->AssignImageList(imagelist);

        wxToolbook *old_par = m_toolbook;
        m_toolbook = nb;
        bool old_ins = m_isInside;
        m_isInside = true;
        CreateChildren(m_toolbook, true/*only this handler*/);
        m_isInside = old_ins;
        m_toolbook = old_par;

        return nb;
    }
}

bool MaxToolbookXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxToolbook"))) ||
            (m_isInside && IsOfClass(node, wxT("toolbookpage"))));
}

// *********************************************

MaxToolbook * bmx_wxtoolbook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxToolbook(maxHandle, parent, id, x, y, w, h, style);
}

wxToolBarBase * bmx_wxtoolbook_gettoolbar(wxToolbook * book) {
	return book->GetToolBar();
}

// *********************************************

void bmx_wxtoolbook_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxToolbookXmlHandler);
}
