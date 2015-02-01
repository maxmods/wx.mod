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

#ifndef _WX_MAX_TREECTRL_H_
#define _WX_MAX_TREECTRL_H_

#include "wxglue.h"
#include "wx/treectrl.h"
#include "wx/imaglist.h"
#include "wx/xrc/xh_tree.h"
#include "wx/xml/xml.h"

class MaxTreeCtrl;
class MaxTreeItem;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxtreectrl_wxTreeCtrl__xrcNew)(wxTreeCtrl * tree);
	int CB_PREF(wx_wxtreectrl_wxTreeCtrl__OnCompareItems)(BBObject * maxHandle, MaxTreeItem * item1, MaxTreeItem * item2);

	BBArray * CB_PREF(wx_wxtreectrl_wxTreeCtrl__newSelections)(int size);
	void CB_PREF(wx_wxtreectrl_wxTreeCtrl__setSelection)(BBArray * array, int index, MaxTreeItem * item);

	MaxTreeCtrl * bmx_wxtreectrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	MaxTreeItem * bmx_wxtreectrl_addroot(wxTreeCtrl * tree, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreectrl_appenditem(wxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data);
	void bmx_wxtreectrl_assignimagelist(wxTreeCtrl * tree, wxImageList * list);
	void bmx_wxtreectrl_expand(wxTreeCtrl * tree, MaxTreeItem * item);
	
	void bmx_wxtreectrl_assignstateimagelist(wxTreeCtrl * tree, wxImageList * imageList);
	void bmx_wxtreectrl_collapse(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_collapseall(wxTreeCtrl * tree);
	void bmx_wxtreectrl_collapseallchildren(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_collapseandreset(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_deleteitem(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_deleteallitems(wxTreeCtrl * tree);
	void bmx_wxtreectrl_deletechildren(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_editlabel(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_endeditlabel(wxTreeCtrl * tree, MaxTreeItem * item, int cancelEdit);
	void bmx_wxtreectrl_ensurevisible(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_expandall(wxTreeCtrl * tree);
	void bmx_wxtreectrl_expandallchildren(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_getboundingrect(wxTreeCtrl * tree, MaxTreeItem * item, int * x, int * y, int * w, int * h, int textOnly);
	MaxRect * bmx_wxtreectrl_getboundingrectrect(wxTreeCtrl * tree, MaxTreeItem * item, int textOnly);
	int bmx_wxtreectrl_getchildrencount(wxTreeCtrl * tree, MaxTreeItem * item, int recursively);
	int bmx_wxtreectrl_getcount(wxTreeCtrl * tree);
	wxTextCtrl * bmx_wxtreectrl_geteditcontrol(wxTreeCtrl * tree);

	BBObject * bmx_wxtreectrl_getitemdata(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getfirstchild(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue);
	MaxTreeItem * bmx_wxtreectrl_getfirstvisibleitem(wxTreeCtrl * tree);
	MaxTreeItem * bmx_wxtreectrl_getnextchild(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue);
	int bmx_wxtreectrl_getindent(wxTreeCtrl * tree);
	MaxColour * bmx_wxtreectrl_getitembackgroundcolour(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxFont * bmx_wxtreectrl_getitemfont(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_getitemimage(wxTreeCtrl * tree, MaxTreeItem * item, wxTreeItemIcon which);
	BBString * bmx_wxtreectrl_getitemtext(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxColour * bmx_wxtreectrl_getitemtextcolour(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getlastchild(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getnextsibling(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getnextvisible(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getitemparent(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getprevsibling(wxTreeCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreectrl_getprevvisible(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_getquickbestsize(wxTreeCtrl * tree);
	MaxTreeItem * bmx_wxtreectrl_getrootitem(wxTreeCtrl * tree);
	MaxTreeItem * bmx_wxtreectrl_getselection(wxTreeCtrl * tree);
	int bmx_wxtreectrl_isbold(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_isempty(wxTreeCtrl * tree);
	int bmx_wxtreectrl_isexpanded(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_isselected(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_isvisible(wxTreeCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreectrl_itemhaschildren(wxTreeCtrl * tree, MaxTreeItem * item);

	void bmx_wxtreectrl_scrollto(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_selectitem(wxTreeCtrl * tree, MaxTreeItem * item, int selected);
	void bmx_wxtreectrl_setindent(wxTreeCtrl * tree, int indent);
	void bmx_wxtreectrl_setimagelist(wxTreeCtrl * tree, wxImageList * imageList);
	void bmx_wxtreectrl_setitembackgroundcolour(wxTreeCtrl * tree, MaxTreeItem * item, MaxColour * colour);
	void bmx_wxtreectrl_setitembold(wxTreeCtrl * tree, MaxTreeItem * item, int bold);
	void bmx_wxtreectrl_setitemdata(wxTreeCtrl * tree, MaxTreeItem * item, BBObject * data);
	void bmx_wxtreectrl_setitemdrophighlight(wxTreeCtrl * tree, MaxTreeItem * item, int highlight);
	void bmx_wxtreectrl_setitemfont(wxTreeCtrl * tree, MaxTreeItem * item, MaxFont * font);
	void bmx_wxtreectrl_setitemhaschildren(wxTreeCtrl * tree, MaxTreeItem * item, int hasChildren);
	void bmx_wxtreectrl_setitemimage(wxTreeCtrl * tree, MaxTreeItem * item, int image, wxTreeItemIcon which);
	void bmx_wxtreectrl_setitemtext(wxTreeCtrl * tree, MaxTreeItem * item, BBString * text);
	void bmx_wxtreectrl_setitemtextcolour(wxTreeCtrl * tree, MaxTreeItem * item, MaxColour * colour);
	void bmx_wxtreectrl_setquickbestsize(wxTreeCtrl * tree, int quickBestSize);
	void bmx_wxtreectrl_setstateimagelist(wxTreeCtrl * tree, wxImageList * imageList);
	void bmx_wxtreectrl_setwindowstyle(wxTreeCtrl * tree, long style);
	void bmx_wxtreectrl_sortchildren(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_toggle(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_toggleitemselection(wxTreeCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreectrl_unselect(wxTreeCtrl * tree);
	void bmx_wxtreectrl_unselectall(wxTreeCtrl * tree);
	void bmx_wxtreectrl_unselectitem(wxTreeCtrl * tree, MaxTreeItem * item);

	MaxTreeItem * bmx_wxtreectrl_hittest(wxTreeCtrl * tree, int x, int y, int * flags);
	MaxTreeItem * bmx_wxtreectrl_insertitem(wxTreeCtrl * tree, MaxTreeItem * parent, MaxTreeItem * previous, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreectrl_insertitembefore(wxTreeCtrl * tree, MaxTreeItem * parent, int before, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreectrl_prependitem(wxTreeCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data);

	BBArray * bmx_wxtreectrl_getselections(wxTreeCtrl * tree);

	wxTreeItemIdValue * bmx_wxtreeitemidvalue_create();
	void bmx_wxtreeitemidvalue_delete(wxTreeItemIdValue * idvalue);

	int bmx_wxtreeitemid_isok(MaxTreeItem * item);
	int bmx_wxtreeitemid_equals(MaxTreeItem * item, MaxTreeItem * otheritem);

	void bmx_wxtreeitemid_delete(MaxTreeItem * item);
	int bmx_wxtreectrl_geteventtype(int type);

	int bmx_wxtreeevent_getkeycode(wxTreeEvent & event);
	MaxTreeItem * bmx_wxtreeevent_getitem(wxTreeEvent & event);
	const wxKeyEvent & bmx_wxtreeevent_getkeyevent(wxTreeEvent & event);
	BBString * bmx_wxtreeevent_getlabel(wxTreeEvent & event);
	MaxTreeItem * bmx_wxtreeevent_getolditem(wxTreeEvent & event);
	void bmx_wxtreeevent_getpoint(wxTreeEvent & event, int * x, int * y);
	int bmx_wxtreeevent_iseditcancelled(wxTreeEvent & event);
	void bmx_wxtreeevent_settooltip(wxTreeEvent & event, BBString * tip);

	void bmx_wxtreectrl_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTreeCtrl : public wxTreeCtrl
{
DECLARE_DYNAMIC_CLASS(MaxTreeCtrl)

public:
	MaxTreeCtrl();
	MaxTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxTreeCtrl(wxWindow * parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long treeStyle);
	~MaxTreeCtrl();
	
	int OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2);

	void MaxBind(BBObject * handle);
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

class MaxTreeItem
{
public :
	MaxTreeItem(wxTreeItemId treeItem);
	wxTreeItemId Item();

private :
	wxTreeItemId item;
};


class MaxTreeItemData : public wxTreeItemData
{
public:
	MaxTreeItemData(BBObject * data);
	~MaxTreeItemData();
	void SetData(BBObject * data);
	BBObject * GetData();

private :
	BBObject * maxHandle;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTreeCtrlXmlHandler : public wxTreeCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxTreeCtrlXmlHandler)

public:
    MaxTreeCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};

#endif
