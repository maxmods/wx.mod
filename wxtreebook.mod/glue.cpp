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

MaxTreebook::MaxTreebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxTreebook(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxTreebook::MaxTreebook()
{}

MaxTreebook::~MaxTreebook() {
	wxunbind(this);
}

void MaxTreebook::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxTreebookXmlHandler, wxTreebookXmlHandler)

MaxTreebookXmlHandler::MaxTreebookXmlHandler()
	: wxTreebookXmlHandler(), m_tbk(NULL), m_isInside(false)
{}


wxObject * MaxTreebookXmlHandler::DoCreateResource()
{
    if (m_class == wxT("wxTreebook"))
    {
        XRC_MAKE_INSTANCE(tbk, MaxTreebook)

        tbk->Create(m_parentAsWindow,
                    GetID(),
                    GetPosition(), GetSize(),
                    GetStyle(wxT("style")),
                    GetName());


		tbk->MaxBind(_wx_wxtreebook_wxTreebook__xrcNew(tbk));

        wxTreebook * old_par = m_tbk;
        m_tbk = tbk;

        bool old_ins = m_isInside;
        m_isInside = true;

        wxArrayTbkPageIndexes old_treeContext = m_treeContext;
        m_treeContext.Clear();

        CreateChildren(m_tbk, true/*only this handler*/);

        m_treeContext = old_treeContext;
        m_isInside = old_ins;
        m_tbk = old_par;

        return tbk;
    }

    wxXmlNode *n = GetParamNode(wxT("object"));
    wxWindow *wnd = NULL;

    if ( !n )
        n = GetParamNode(wxT("object_ref"));

    if (n)
    {
        bool old_ins = m_isInside;
        m_isInside = false;
        wxObject *item = CreateResFromNode(n, m_tbk, NULL);
        m_isInside = old_ins;
        wnd = wxDynamicCast(item, wxWindow);

        if (wnd == NULL && item != NULL)
            wxLogError(wxT("Error in resource: control within treebook's <page> tag is not a window."));
    }

    size_t depth = GetLong( wxT("depth") );

    if( depth <= m_treeContext.Count() )
    {
        // first prepare the icon
        int imgIndex = wxNOT_FOUND;
        if ( HasParam(wxT("bitmap")) )
        {
            wxBitmap bmp = GetBitmap(wxT("bitmap"), wxART_OTHER);
            wxImageList *imgList = m_tbk->GetImageList();
            if ( imgList == NULL )
            {
                imgList = new wxImageList( bmp.GetWidth(), bmp.GetHeight() );
                m_tbk->AssignImageList( imgList );
            }
            imgIndex = imgList->Add(bmp);
        }

        // then add the page to the corresponding parent
        if( depth < m_treeContext.Count() )
            m_treeContext.RemoveAt(depth, m_treeContext.Count() - depth );
        if( depth == 0)
        {
            m_tbk->AddPage(wnd,
                GetText(wxT("label")), GetBool(wxT("selected")), imgIndex);
        }
        else
        {
            m_tbk->InsertSubPage(m_treeContext.Item(depth - 1), wnd,
                GetText(wxT("label")), GetBool(wxT("selected")), imgIndex);
        }

        m_treeContext.Add( m_tbk->GetPageCount() - 1);

    }
    else
        wxLogError(wxT("Error in resource. wxTreebookPage has an invalid depth."));
    return wnd;
}

bool MaxTreebookXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxTreebook"))) ||
            (m_isInside && IsOfClass(node, wxT("treebookpage"))));
}


// *********************************************

wxTreebook * bmx_wxtreebook_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxTreebook(handle, parent, id, x, y, w, h, style);
}

int bmx_wxtreebook_addpage(wxTreebook * book, wxWindow * page, BBString * text, int selected, int imageId) {
	return static_cast<int>(book->AddPage(page, wxStringFromBBString(text), static_cast<bool>(selected), imageId));
}

int bmx_wxtreebook_addsubpage(wxTreebook * book, wxWindow * page, BBString * text, int selected, int imageId) {
	return static_cast<int>(book->AddSubPage(page, wxStringFromBBString(text), static_cast<bool>(selected), imageId));
}

int bmx_wxtreebook_insertpage(wxTreebook * book, int index, wxWindow * page, BBString * text, int selected, int imageId) {
	return static_cast<int>(book->InsertPage(static_cast<size_t>(index), page, wxStringFromBBString(text), static_cast<bool>(selected), imageId));
}

int bmx_wxtreebook_insertsubpage(wxTreebook * book, int index, wxWindow * page, BBString * text, int selected, int imageId) {
	return static_cast<int>(book->InsertSubPage(static_cast<size_t>(index), page, wxStringFromBBString(text), static_cast<bool>(selected), imageId));
}

int bmx_wxtreebook_collapsenode(wxTreebook * book, int pageId) {
	return static_cast<int>(book->CollapseNode(static_cast<size_t>(pageId)));
}

int bmx_wxtreebook_expandnode(wxTreebook * book, int pageId, int expand) {
	return static_cast<int>(book->ExpandNode(static_cast<size_t>(pageId), static_cast<bool>(expand)));
}

int bmx_wxtreebook_isnodeexpanded(wxTreebook * book, int pos) {
	return static_cast<int>(book->IsNodeExpanded(static_cast<size_t>(pos)));
}

int bmx_wxtreebook_getpageparent(wxTreebook * book, int pos) {
	return book->GetPageParent(static_cast<size_t>(pos));
}

wxTreeCtrl * bmx_wxtreebook_gettreectrl(wxTreebook * book) {
	return book->GetTreeCtrl();
}


int bmx_wxtreebook_geteventtype(int type) {
	switch(type) {
		case -810: return wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED;
		case -811: return wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxtreebook_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxTreebookXmlHandler);
}
