/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxListbook:: MaxListbook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxListbook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxListbook::MaxListbook()
{}

MaxListbook::~MaxListbook() {
	wxunbind(this);
}

void MaxListbook::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxListbookXmlHandler, wxListbookXmlHandler)

MaxListbookXmlHandler::MaxListbookXmlHandler()
	: wxListbookXmlHandler(), m_isInside(false), m_listbook(NULL)
{}


wxObject * MaxListbookXmlHandler::DoCreateResource()
{
    if (m_class == wxT("listbookpage"))
    {
        wxXmlNode *n = GetParamNode(wxT("object"));

        if ( !n )
            n = GetParamNode(wxT("object_ref"));

        if (n)
        {
            bool old_ins = m_isInside;
            m_isInside = false;
            wxObject *item = CreateResFromNode(n, m_listbook, NULL);
            m_isInside = old_ins;
            wxWindow *wnd = wxDynamicCast(item, wxWindow);

            if (wnd)
            {
                m_listbook->AddPage(wnd, GetText(wxT("label")),
                                         GetBool(wxT("selected")));
                if ( HasParam(wxT("bitmap")) )
                {
                    wxBitmap bmp = GetBitmap(wxT("bitmap"), wxART_OTHER);
                    wxImageList *imgList = m_listbook->GetImageList();
                    if ( imgList == NULL )
                    {
                        imgList = new wxImageList( bmp.GetWidth(), bmp.GetHeight() );
                        m_listbook->AssignImageList( imgList );
                    }
                    int imgIndex = imgList->Add(bmp);
                    m_listbook->SetPageImage(m_listbook->GetPageCount()-1, imgIndex );
                }
            }
            else
                wxLogError(wxT("Error in resource."));
            return wnd;
        }
        else
        {
            wxLogError(wxT("Error in resource: no control within listbook's <page> tag."));
            return NULL;
        }
    }

    else
    {
        XRC_MAKE_INSTANCE(nb, MaxListbook)

        nb->Create(m_parentAsWindow,
                   GetID(),
                   GetPosition(), GetSize(),
                   GetStyle(wxT("style")),
                   GetName());

	nb->MaxBind(_wx_wxlistbook_wxListbook__xrcNew(nb));

       wxListbook *old_par = m_listbook;
        m_listbook = nb;
        bool old_ins = m_isInside;
        m_isInside = true;
        CreateChildren(m_listbook, true/*only this handler*/);
        m_isInside = old_ins;
        m_listbook = old_par;

        return nb;
    }

}

bool MaxListbookXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxListbook"))) ||
            (m_isInside && IsOfClass(node, wxT("listbookpage"))));
}


// *********************************************

MaxListbook * bmx_wxlistbook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxListbook(maxHandle, parent, id, x, y, w, h, style);
}

wxListView * bmx_wxlistbook_getlistview(wxListbook * book) {
	return book->GetListView();
}

// *********************************************

void bmx_wxlistbook_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxListbookXmlHandler);
}

