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

#include "wxglue.h"
#include "wx/dirctrl.h"
#include "../wxtreectrl.mod/glue.h"
#include "wx/xrc/xh_gdctl.h"
#include "wx/xml/xml.h"


class MaxGenericDirCtrl;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxgenericdirctrl_wxGenericDirCtrl__xrcNew(wxGenericDirCtrl * dir);

	wxGenericDirCtrl * bmx_wxgenericdirctrl_create(BBObject * handle, wxWindow * parent, wxWindowID id,
		BBString * dir, int x, int y, int w, int h, long style, BBString * filter, int defaultFilter);
	void bmx_wxgenericdirctrl_init(wxGenericDirCtrl * dir);
	void bmx_wxgenericdirctrl_collapsetree(wxGenericDirCtrl * dir);
	bool bmx_wxgenericdirctrl_expandpath(wxGenericDirCtrl * dir, BBString * path);
	bool bmx_wxgenericdirctrl_collapsepath(wxGenericDirCtrl * dir, BBString * path);
	BBString * bmx_wxgenericdirctrl_getdefaultpath(wxGenericDirCtrl * dir);
	BBString * bmx_wxgenericdirctrl_getpath(wxGenericDirCtrl * dir);
	BBString * bmx_wxgenericdirctrl_getfilepath(wxGenericDirCtrl * dir);
	BBString * bmx_wxgenericdirctrl_getfilter(wxGenericDirCtrl * dir);
	int bmx_wxgenericdirctrl_getfilterindex(wxGenericDirCtrl * dir);
	MaxTreeItem * bmx_wxgenericdirctrl_getrootid(wxGenericDirCtrl * dir);
	wxTreeCtrl * bmx_wxgenericdirctrl_gettreectrl(wxGenericDirCtrl * dir);
	void bmx_wxgenericdirctrl_recreatetree(wxGenericDirCtrl * dir);
	void bmx_wxgenericdirctrl_setdefaultpath(wxGenericDirCtrl * dir, BBString * path);
	void bmx_wxgenericdirctrl_setfilter(wxGenericDirCtrl * dir, BBString * filter);
	void bmx_wxgenericdirctrl_setfilterindex(wxGenericDirCtrl * dir, int index);
	void bmx_wxgenericdirctrl_setpath(wxGenericDirCtrl * dir, BBString * path);
	void bmx_wxgenericdirctrl_showhidden(wxGenericDirCtrl * dir, bool show);

	void bmx_wxgenericdirctrl_addresourcehandler();
	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGenericDirCtrl : public wxGenericDirCtrl
{
public:
	MaxGenericDirCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& dir,
		int x, int y, int w, int h, long style, const wxString& filter, int defaultFilter);
	MaxGenericDirCtrl();
	~MaxGenericDirCtrl();

	void MaxBind(BBObject * handle);

protected:	
    virtual wxTreeCtrl* CreateTreeCtrl(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long treeStyle);


private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
    DECLARE_DYNAMIC_CLASS(MaxGenericDirCtrl)
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGenericDirCtrlXmlHandler : public wxGenericDirCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxGenericDirCtrlXmlHandler)

public:
    MaxGenericDirCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
