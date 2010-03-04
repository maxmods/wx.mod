/*
  Copyright (c) 2010 Bruce A Henderson
 
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
#include "wx/treelistctrl.h"

#include "../wxtreectrl.mod/glue.h"

class MaxTreeListCtrl;

extern "C" {

#include <blitz.h>

	int _wx_wxtreelistctrl_wxTreeListCtrl__OnCompareItems(BBObject * maxHandle, MaxTreeItem * item1, MaxTreeItem * item2);

	BBArray * _wx_wxtreelistctrl_wxTreeListCtrl__newSelections(int size);
	void _wx_wxtreelistctrl_wxTreeListCtrl__setSelection(BBArray * array, int index, MaxTreeItem * item);

	MaxTreeListCtrl * bmx_wxtreelistctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	MaxTreeItem * bmx_wxtreelistctrl_addroot(wxTreeListCtrl * tree, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreelistctrl_appenditem(wxTreeListCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data);
	void bmx_wxtreelistctrl_assignimagelist(wxTreeListCtrl * tree, wxImageList * list);
	void bmx_wxtreelistctrl_expand(wxTreeListCtrl * tree, MaxTreeItem * item);
	
	void bmx_wxtreelistctrl_assignstateimagelist(wxTreeListCtrl * tree, wxImageList * imageList);
	void bmx_wxtreelistctrl_collapse(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_collapseandreset(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_deleteitem(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_deletechildren(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_editlabel(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_ensurevisible(wxTreeListCtrl * tree, MaxTreeItem * item);
	bool bmx_wxtreelistctrl_getboundingrect(wxTreeListCtrl * tree, MaxTreeItem * item, int * x, int * y, int * w, int * h, bool textOnly);
	MaxRect * bmx_wxtreelistctrl_getboundingrectrect(wxTreeListCtrl * tree, MaxTreeItem * item, bool textOnly);
	int bmx_wxtreelistctrl_getchildrencount(wxTreeListCtrl * tree, MaxTreeItem * item, bool recursively);
	int bmx_wxtreelistctrl_getcount(wxTreeListCtrl * tree);

	BBObject * bmx_wxtreelistctrl_getitemdata(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getfirstchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue);
	MaxTreeItem * bmx_wxtreelistctrl_getfirstvisibleitem(wxTreeListCtrl * tree);
	MaxTreeItem * bmx_wxtreelistctrl_getnextchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * idvalue);
	int bmx_wxtreelistctrl_getindent(wxTreeListCtrl * tree);
	MaxColour * bmx_wxtreelistctrl_getitembackgroundcolour(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxFont * bmx_wxtreelistctrl_getitemfont(wxTreeListCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreelistctrl_getitemimage(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIcon which);
	MaxColour * bmx_wxtreelistctrl_getitemtextcolour(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getlastchild(wxTreeListCtrl * tree, MaxTreeItem * item, wxTreeItemIdValue * value);
	MaxTreeItem * bmx_wxtreelistctrl_getnextsibling(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getnextvisible(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getitemparent(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getprevsibling(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getprevvisible(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getrootitem(wxTreeListCtrl * tree);
	MaxTreeItem * bmx_wxtreelistctrl_getselection(wxTreeListCtrl * tree);
	bool bmx_wxtreelistctrl_isbold(wxTreeListCtrl * tree, MaxTreeItem * item);
	bool bmx_wxtreelistctrl_isexpanded(wxTreeListCtrl * tree, MaxTreeItem * item);
	bool bmx_wxtreelistctrl_isselected(wxTreeListCtrl * tree, MaxTreeItem * item);
	bool bmx_wxtreelistctrl_isvisible(wxTreeListCtrl * tree, MaxTreeItem * item);

	void bmx_wxtreelistctrl_scrollto(wxTreeListCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreelistctrl_selectitem(wxTreeListCtrl * tree, MaxTreeItem * item, MaxTreeItem * last, int selected);
	void bmx_wxtreelistctrl_setindent(wxTreeListCtrl * tree, int indent);
	void bmx_wxtreelistctrl_setimagelist(wxTreeListCtrl * tree, wxImageList * imageList);
	void bmx_wxtreelistctrl_setitembackgroundcolour(wxTreeListCtrl * tree, MaxTreeItem * item, MaxColour * colour);
	void bmx_wxtreelistctrl_setitembold(wxTreeListCtrl * tree, MaxTreeItem * item, int bold);
	void bmx_wxtreelistctrl_setitemdata(wxTreeListCtrl * tree, MaxTreeItem * item, BBObject * data);
	void bmx_wxtreelistctrl_setitemfont(wxTreeListCtrl * tree, MaxTreeItem * item, MaxFont * font);
	void bmx_wxtreelistctrl_setitemhaschildren(wxTreeListCtrl * tree, MaxTreeItem * item, int hasChildren);
	void bmx_wxtreelistctrl_setitemtextcolour(wxTreeListCtrl * tree, MaxTreeItem * item, MaxColour * colour);
	void bmx_wxtreelistctrl_setstateimagelist(wxTreeListCtrl * tree, wxImageList * imageList);
	void bmx_wxtreelistctrl_setwindowstyle(wxTreeListCtrl * tree, long style);
	void bmx_wxtreelistctrl_sortchildren(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_toggle(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_unselect(wxTreeListCtrl * tree);
	void bmx_wxtreelistctrl_unselectall(wxTreeListCtrl * tree);

	MaxTreeItem * bmx_wxtreelistctrl_hittest(wxTreeListCtrl * tree, int x, int y, int * flags);
	MaxTreeItem * bmx_wxtreelistctrl_insertitem(wxTreeListCtrl * tree, MaxTreeItem * parent, MaxTreeItem * previous, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreelistctrl_insertitembefore(wxTreeListCtrl * tree, MaxTreeItem * parent, int before, BBString * text, int image, int selImage, BBObject * data);
	MaxTreeItem * bmx_wxtreelistctrl_prependitem(wxTreeListCtrl * tree, MaxTreeItem * parent, BBString * text, int image, int selImage, BBObject * data);

	BBArray * bmx_wxtreelistctrl_getselections(wxTreeListCtrl * tree);

	void bmx_wxtreelistctrl_deleteroot(wxTreeListCtrl * tree);
	MaxTreeItem * bmx_wxtreelistctrl_finditem(wxTreeListCtrl * tree, MaxTreeItem * item, BBString * text, int flags);
	MaxTreeItem * bmx_wxtreelistctrl_getfirstexpandeditem(wxTreeListCtrl * tree);
	void bmx_wxtreelistctrl_expandall(wxTreeListCtrl * tree, MaxTreeItem * item);
	BBString * bmx_wxtreelistctrl_getitemtext(wxTreeListCtrl * tree, MaxTreeItem * item, int column);
	int bmx_wxtreelistctrl_getlinespacing(wxTreeListCtrl * tree);
	MaxTreeItem * bmx_wxtreelistctrl_getnext(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getnextexpanded(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getprev(wxTreeListCtrl * tree, MaxTreeItem * item);
	MaxTreeItem * bmx_wxtreelistctrl_getprevexpanded(wxTreeListCtrl * tree, MaxTreeItem * item);
	int bmx_wxtreelistctrl_haschildren(wxTreeListCtrl * tree, MaxTreeItem * item);
	void bmx_wxtreelistctrl_setitemimage(wxTreeListCtrl * tree, MaxTreeItem * item, int image, int column, int which);
	void bmx_wxtreelistctrl_setitemtext(wxTreeListCtrl * tree, MaxTreeItem * item, BBString * text, int column);
	void bmx_wxtreelistctrl_setlinespacing(wxTreeListCtrl * tree, int value);

	void bmx_wxtreelistctrl_addcolumn(wxTreeListCtrl * tree, BBString * text, int width, int alignment);
	int bmx_wxtreelistctrl_getcolumnalignment(wxTreeListCtrl * tree, int column);
	int bmx_wxtreelistctrl_getcolumncount(wxTreeListCtrl * tree);
	int bmx_wxtreelistctrl_getcolumnimage(wxTreeListCtrl * tree, int column);
	BBString * bmx_wxtreelistctrl_getcolumntext(wxTreeListCtrl * tree, int column);
	int bmx_wxtreelistctrl_getcolumnwidth(wxTreeListCtrl * tree, int column);
	void bmx_wxtreelistctrl_insertcolumn(wxTreeListCtrl * tree, int before, BBString * text, int width, int alignment);
	int bmx_wxtreelistctrl_iscolumnshown(wxTreeListCtrl * tree, int column);
	void bmx_wxtreelistctrl_removecolumn(wxTreeListCtrl * tree, int column);
	void bmx_wxtreelistctrl_setcolumnalignment(wxTreeListCtrl * tree, int column, int align);
	void bmx_wxtreelistctrl_setcolumnimage(wxTreeListCtrl * tree, int column, int image);
	void bmx_wxtreelistctrl_setcolumntext(wxTreeListCtrl * tree, int column, BBString * text);
	void bmx_wxtreelistctrl_setcolumnwidth(wxTreeListCtrl * tree, int column, int width);
	void bmx_wxtreelistctrl_setmaincolumn(wxTreeListCtrl * tree, int column);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTreeListCtrl : public wxTreeListCtrl
{
DECLARE_DYNAMIC_CLASS(MaxTreeListCtrl)

public:
	MaxTreeListCtrl();
	MaxTreeListCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxTreeListCtrl(wxWindow * parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long treeStyle);
	~MaxTreeListCtrl();
	
	int OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2);

	void MaxBind(BBObject * handle);
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};
