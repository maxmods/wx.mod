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

MaxNotebook::MaxNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxNotebook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxNotebook::MaxNotebook()
{}

MaxNotebook::~MaxNotebook() {
	wxunbind(this);
}

void MaxNotebook::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxNotebookXmlHandler, wxNotebookXmlHandler)

MaxNotebookXmlHandler::MaxNotebookXmlHandler()
	: wxNotebookXmlHandler(), m_isInside(false), m_notebook(NULL)
{}


wxObject * MaxNotebookXmlHandler::DoCreateResource()
{
    if (m_class == wxT("notebookpage"))
    {
        wxXmlNode *n = GetParamNode(wxT("object"));

        if ( !n )
            n = GetParamNode(wxT("object_ref"));

        if (n)
        {
            bool old_ins = m_isInside;
            m_isInside = false;
            wxObject *item = CreateResFromNode(n, m_notebook, NULL);
            m_isInside = old_ins;
            wxWindow *wnd = wxDynamicCast(item, wxWindow);

            if (wnd)
            {
                m_notebook->AddPage(wnd, GetText(wxT("label")),
                                         GetBool(wxT("selected")));
                if ( HasParam(wxT("bitmap")) )
                {
                    wxBitmap bmp = GetBitmap(wxT("bitmap"), wxART_OTHER);
                    wxImageList *imgList = m_notebook->GetImageList();
                    if ( imgList == NULL )
                    {
                        imgList = new wxImageList( bmp.GetWidth(), bmp.GetHeight() );
                        m_notebook->AssignImageList( imgList );
                    }
                    int imgIndex = imgList->Add(bmp);
                    m_notebook->SetPageImage(m_notebook->GetPageCount()-1, imgIndex );
                }
            }
            else
                wxLogError(wxT("Error in resource."));
            return wnd;
        }
        else
        {
            wxLogError(wxT("Error in resource: no control within notebook's <page> tag."));
            return NULL;
        }
    }

    else
    {
        XRC_MAKE_INSTANCE(nb, MaxNotebook)

        nb->Create(m_parentAsWindow,
                   GetID(),
                   GetPosition(), GetSize(),
                   GetStyle(wxT("style")),
                   GetName());

		nb->MaxBind(CB_PREF(wx_wxnotebook_wxNotebook__xrcNew)(nb));

        SetupWindow(nb);

        wxNotebook *old_par = m_notebook;
        m_notebook = nb;
        bool old_ins = m_isInside;
        m_isInside = true;
        CreateChildren(m_notebook, true/*only this handler*/);
        m_isInside = old_ins;
        m_notebook = old_par;

        return nb;
    }
}

bool MaxNotebookXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxNotebook"))) ||
            (m_isInside && IsOfClass(node, wxT("notebookpage"))));
}

// *********************************************

MaxNotebook * bmx_wxnotebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxNotebook(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxnotebook_getrowcount(wxNotebook * notebook) {
	return notebook->GetRowCount();
}

MaxColour * bmx_wxnotebook_getthemebackgroundcolour(wxNotebook * notebook) {
	wxColour c(notebook->GetThemeBackgroundColour());
	return new MaxColour(c);
}

void bmx_wxnotebook_setpadding(wxNotebook * notebook, int width, int height) {
	notebook->SetPadding(wxSize(width, height));
}

// *********************************************

void bmx_wxnotebook_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxNotebookXmlHandler);
}

