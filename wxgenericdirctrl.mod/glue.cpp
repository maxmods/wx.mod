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

#include "glue.h"

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxGenericDirCtrl, wxGenericDirCtrl)


MaxGenericDirCtrl::MaxGenericDirCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& dir,
		int x, int y, int w, int h, long style, const wxString& filter, int defaultFilter)
	: wxGenericDirCtrl(parent, id, dir, wxPoint(x, y), wxSize(w, h), style, filter, defaultFilter)
{
	wxbind(this, handle);
}

MaxGenericDirCtrl::MaxGenericDirCtrl()
{}

MaxGenericDirCtrl::~MaxGenericDirCtrl() {
	wxunbind(this);
}

void MaxGenericDirCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

wxTreeCtrl* MaxGenericDirCtrl::CreateTreeCtrl(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long treeStyle) {
	MaxTreeCtrl * tree = new MaxTreeCtrl(parent, id, pos, size, treeStyle);
	tree->MaxBind(_wx_wxtreectrl_wxTreeCtrl__xrcNew(tree));
	return tree;
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxGenericDirCtrlXmlHandler, wxGenericDirCtrlXmlHandler)

MaxGenericDirCtrlXmlHandler::MaxGenericDirCtrlXmlHandler()
	: wxGenericDirCtrlXmlHandler()
{}


wxObject * MaxGenericDirCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(ctrl, MaxGenericDirCtrl)

    ctrl->Create(m_parentAsWindow,
                 GetID(),
                 GetText(wxT("defaultfolder")),
                 GetPosition(), GetSize(),
                 GetStyle(),
                 GetText(wxT("filter")),
                 (int)GetLong(wxT("defaultfilter")),
                 GetName());

	ctrl->MaxBind(_wx_wxgenericdirctrl_wxGenericDirCtrl__xrcNew(ctrl));

    SetupWindow(ctrl);

    return ctrl;

}

// *********************************************

BEGIN_EVENT_TABLE(MaxGenericDirCtrl, wxGenericDirCtrl)
END_EVENT_TABLE()

wxGenericDirCtrl * bmx_wxgenericdirctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id,
		BBString * dir, int x, int y, int w, int h, long style, BBString * filter, int defaultFilter) {
	MaxGenericDirCtrl * ctrl = new MaxGenericDirCtrl();
	ctrl->MaxBind(handle);
	ctrl->Create(parent, id, wxStringFromBBString(dir), wxPoint(x, y), wxSize(w, h), style, wxStringFromBBString(filter), defaultFilter);
	return ctrl;
}

void bmx_wxgenericdirctrl_init(wxGenericDirCtrl * dir) {
	dir->Init();
}

void bmx_wxgenericdirctrl_collapsetree(wxGenericDirCtrl * dir) {
	dir->CollapseTree();
}

bool bmx_wxgenericdirctrl_expandpath(wxGenericDirCtrl * dir, BBString * path) {
	return dir->ExpandPath(wxStringFromBBString(path));
}

bool bmx_wxgenericdirctrl_collapsepath(wxGenericDirCtrl * dir, BBString * path) {
	return dir->CollapsePath(wxStringFromBBString(path));
}

BBString * bmx_wxgenericdirctrl_getdefaultpath(wxGenericDirCtrl * dir) {
	return bbStringFromWxString(dir->GetDefaultPath());
}

BBString * bmx_wxgenericdirctrl_getpath(wxGenericDirCtrl * dir) {
	return bbStringFromWxString(dir->GetPath());
}

BBString * bmx_wxgenericdirctrl_getfilepath(wxGenericDirCtrl * dir) {
	return bbStringFromWxString(dir->GetFilePath());
}

BBString * bmx_wxgenericdirctrl_getfilter(wxGenericDirCtrl * dir) {
	return bbStringFromWxString(dir->GetFilter());
}

int bmx_wxgenericdirctrl_getfilterindex(wxGenericDirCtrl * dir) {
	return dir->GetFilterIndex();
}

MaxTreeItem * bmx_wxgenericdirctrl_getrootid(wxGenericDirCtrl * dir) {
	return new MaxTreeItem(dir->GetRootId());
}

wxTreeCtrl * bmx_wxgenericdirctrl_gettreectrl(wxGenericDirCtrl * dir) {
	return dir->GetTreeCtrl();
}

void bmx_wxgenericdirctrl_recreatetree(wxGenericDirCtrl * dir) {
	dir->ReCreateTree();
}

void bmx_wxgenericdirctrl_setdefaultpath(wxGenericDirCtrl * dir, BBString * path) {
	dir->SetDefaultPath(wxStringFromBBString(path));
}

void bmx_wxgenericdirctrl_setfilter(wxGenericDirCtrl * dir, BBString * filter) {
	dir->SetFilter(wxStringFromBBString(filter));
}

void bmx_wxgenericdirctrl_setfilterindex(wxGenericDirCtrl * dir, int index) {
	dir->SetFilterIndex(index);
}

void bmx_wxgenericdirctrl_setpath(wxGenericDirCtrl * dir, BBString * path) {
	dir->SetPath(wxStringFromBBString(path));
}

void bmx_wxgenericdirctrl_showhidden(wxGenericDirCtrl * dir, bool show) {
	dir->ShowHidden(show);
}

// *********************************************

void bmx_wxgenericdirctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxGenericDirCtrlXmlHandler);
}
