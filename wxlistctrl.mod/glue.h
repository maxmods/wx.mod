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

#include "wxglue.h"
#include "wx/listbase.h"
#include "wx/listctrl.h"
#include "wx/xrc/xh_listc.h"
#include "wx/xml/xml.h"

class MaxListCtrl;
class MaxListItem;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxlistctrl_wxListCtrl__xrcNew)(wxListCtrl * list);

	wxListItemAttr * CB_PREF(wx_wxlistctrl_wxListCtrl__OnGetItemAttr)(BBObject * handle, long item);
	BBString * CB_PREF(wx_wxlistctrl_wxListCtrl__OnGetItemText)(BBObject * handle, long item, long column);
	int CB_PREF(wx_wxlistctrl_wxListCtrl__OnGetItemColumnImage)(BBObject * handle, long item, long column);
	int CB_PREF(wx_wxlistctrl_wxListCtrl__OnGetItemImage)(BBObject * handle, long item);
	int CB_PREF(wx_wxlistctrl_wxListCtrl__sortCallback)(BBObject * item1, BBObject * item2, BBObject * data);

	MaxListCtrl * bmx_wxlistctrl_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, long style);
	int bmx_wxlistctrl_arrange(wxListCtrl * list, int flag);
	void bmx_wxlistctrl_assignimagelist(wxListCtrl * list, wxImageList * imageList, int which);
	void bmx_wxlistctrl_clearall(wxListCtrl * list);
	int bmx_wxlistctrl_deleteallitems(wxListCtrl * list);
	int bmx_wxlistctrl_deletecolumn(wxListCtrl * list, int col);
	int bmx_wxlistctrl_deleteitem(wxListCtrl * list, long item);
	void bmx_wxlistctrl_editlabel(wxListCtrl * list, long item);
	int bmx_wxlistctrl_ensurevisible(wxListCtrl * list, long item);
	long bmx_wxlistctrl_finditem(wxListCtrl * list, long start, BBString * text, int partial);
	long bmx_wxlistctrl_finditemdata(wxListCtrl * list, long start, BBObject * data);
	long bmx_wxlistctrl_finditematpos(wxListCtrl * list, long start, int x, int y, int direction);
	int bmx_wxlistctrl_getcolumn(wxListCtrl * list, int col, MaxListItem * item);
	int bmx_wxlistctrl_getcolumncount(wxListCtrl * list);
	int bmx_wxlistctrl_getcolumnwidth(wxListCtrl * list, int col);
	int bmx_wxlistctrl_getcountperpage(wxListCtrl * list);
	wxTextCtrl * bmx_wxlistctrl_geteditcontrol(wxListCtrl * list);
	wxImageList * bmx_wxlistctrl_getimagelist(wxListCtrl * list, int which);
	int bmx_wxlistctrl_getitem(wxListCtrl * list, MaxListItem * item);
	MaxColour * bmx_wxlistctrl_getitembackgroundcolour(wxListCtrl * list, long item);
	int bmx_wxlistctrl_getitemcount(wxListCtrl * list);
	BBObject * bmx_wxlistctrl_getitemdata(wxListCtrl * list, long item);
	MaxFont * bmx_wxlistctrl_getitemfont(wxListCtrl * list, long item);
	int bmx_wxlistctrl_getitemposition(wxListCtrl * list, long item, int * x, int * y);
	int bmx_wxlistctrl_getitemrect(wxListCtrl * list, long item, int * x, int * y, int * w, int * h, int code);
	int bmx_wxlistctrl_getsubitemrect(wxListCtrl * list, long item, long subitem, int * x, int * y, int * w, int * h, int code);
	void bmx_wxlistctrl_getitemspacing(wxListCtrl * list, int * w, int * h);
	int bmx_wxlistctrl_getitemstate(wxListCtrl * list, long item, long stateMask);
	BBString * bmx_wxlistctrl_getitemtext(wxListCtrl * list, long item);
	MaxColour * bmx_wxlistctrl_getitemtextcolour(wxListCtrl * list, long item);
	long bmx_wxlistctrl_getnextitem(wxListCtrl * list, long item, int geometry, int state);
	int bmx_wxlistctrl_getselecteditemcount(wxListCtrl * list);
	MaxColour * bmx_wxlistctrl_gettextcolour(wxListCtrl * list);
	long bmx_wxlistctrl_gettopitem(wxListCtrl * list);
	void bmx_wxlistctrl_getviewrect(wxListCtrl * list, int * x, int * y, int * w, int * h);
	long bmx_wxlistctrl_hittest(wxListCtrl * list, int x, int y, int * flags, long * subitem);
	long bmx_wxlistctrl_insertcolumn(wxListCtrl * list, long col, BBString * heading, int format, int width);
	long bmx_wxlistctrl_insertcolumnitem(wxListCtrl * list, long col, MaxListItem * info);
	long bmx_wxlistctrl_insertitem(wxListCtrl * list, MaxListItem * item);
	long bmx_wxlistctrl_insertstringitem(wxListCtrl * list, long index, BBString * label);
	long bmx_wxlistctrl_insertimageitem(wxListCtrl * list, long index, int imageIndex);
	long bmx_wxlistctrl_insertimagestringitem(wxListCtrl * list, long index, BBString * label, int imageIndex);
	void bmx_wxlistctrl_refreshitem(wxListCtrl * list, long item);
	void bmx_wxlistctrl_refreshitems(wxListCtrl * list, long itemFrom, long itemTo);
	int bmx_wxlistctrl_scrolllist(wxListCtrl * list, int dx, int dy);
	void bmx_wxlistctrl_setbackgroundcolour(wxListCtrl * list, MaxColour * colour);
	int bmx_wxlistctrl_setcolumn(wxListCtrl * list, int col, MaxListItem * item);
	int bmx_wxlistctrl_setcolumnwidth(wxListCtrl * list, int col, int width);
	void bmx_wxlistctrl_setimagelist(wxListCtrl * list, wxImageList * imageList, int which);
	int bmx_wxlistctrl_setitem(wxListCtrl * list, MaxListItem * item);
	long bmx_wxlistctrl_setstringitem(wxListCtrl * list, long item, int col, BBString * label, int imageId);
	void bmx_wxlistctrl_setitembackgroundcolour(wxListCtrl * list, long item, MaxColour * colour);
	void bmx_wxlistctrl_setitemcount(wxListCtrl * list, long count);
	int bmx_wxlistctrl_setitemdata(wxListCtrl * list, long item, BBObject * data);
	void bmx_wxlistctrl_setitemfont(wxListCtrl * list, long item, MaxFont * font);
	int bmx_wxlistctrl_setitemimage(wxListCtrl * list, long item, int image);
	int bmx_wxlistctrl_setitemcolumnimage(wxListCtrl * list, long item, int col, int image);
	int bmx_wxlistctrl_setitemposition(wxListCtrl * list, long item, int x, int y);
	int bmx_wxlistctrl_setitemstate(wxListCtrl * list, long item, long state, long stateMask);
	void bmx_wxlistctrl_setitemtext(wxListCtrl * list, long item, BBString * text);
	void bmx_wxlistctrl_setitemtextcolour(wxListCtrl * list, long item, MaxColour * colour);
	void bmx_wxlistctrl_setsinglestyle(wxListCtrl * list, long style, int add);
	void bmx_wxlistctrl_settextcolour(wxListCtrl * list, MaxColour * colour);
	void bmx_wxlistctrl_setwindowstyleflag(wxListCtrl * list, long style);
	int bmx_wxlistctrl_sortitems(MaxListCtrl * list);

	MaxListItem * bmx_wxlistitem_create();
	void bmx_wxlistitem_delete(MaxListItem * item);
	void bmx_wxlistitem_clear(MaxListItem * item);
	wxListColumnFormat bmx_wxlistitem_getalign(MaxListItem * item);
	MaxColour * bmx_wxlistitem_getbackgroundcolour(MaxListItem * item);
	int bmx_wxlistitem_getcolumn(MaxListItem * item);
	BBObject * bmx_wxlistitem_getdata(MaxListItem * item);
	MaxFont * bmx_wxlistitem_getfont(MaxListItem * item);
	long bmx_wxlistitem_getid(MaxListItem * item);
	int bmx_wxlistitem_getimage(MaxListItem * item);
	long bmx_wxlistitem_getmask(MaxListItem * item);
	long bmx_wxlistitem_getstate(MaxListItem * item);
	BBString * bmx_wxlistitem_gettext(MaxListItem * item);
	MaxColour * bmx_wxlistitem_gettextcolour(MaxListItem * item);
	int bmx_wxlistitem_getwidth(MaxListItem * item);
	void bmx_wxlistitem_setalign(MaxListItem * item, wxListColumnFormat align);
	void bmx_wxlistitem_setbackgroundcolour(MaxListItem * item, MaxColour * colour);
	void bmx_wxlistitem_setcolumn(MaxListItem * item, int col);
	void bmx_wxlistitem_setdata(MaxListItem * item, BBObject * data);
	void bmx_wxlistitem_setfont(MaxListItem * item, MaxFont * font);
	void bmx_wxlistitem_setid(MaxListItem * item, long id);
	void bmx_wxlistitem_setimage(MaxListItem * item, int image);
	void bmx_wxlistitem_setmask(MaxListItem * item, long mask);
	void bmx_wxlistitem_setstate(MaxListItem * item, long state);
	void bmx_wxlistitem_setstatemask(MaxListItem * item, long stateMask);
	void bmx_wxlistitem_settext(MaxListItem * item, BBString * text);
	void bmx_wxlistitem_settextcolour(MaxListItem * item, MaxColour * colour);
	void bmx_wxlistitem_setwidth(MaxListItem * item, int width);
	wxListItemAttr * bmx_wxlistitem_getattributes(MaxListItem * item);
	int bmx_wxlistitem_hasattributes(MaxListItem * item);


	wxListItemAttr * bmx_wxlistitemattr_create(MaxColour * textCol, MaxColour * backCol, MaxFont * font);
	MaxColour * bmx_wxlistitemattr_getbackgroundcolour(wxListItemAttr * attr);
	MaxFont * bmx_wxlistitemattr_getfont(wxListItemAttr * attr);
	MaxColour * bmx_wxlistitemattr_gettextcolour(wxListItemAttr * attr);
	int bmx_wxlistitemattr_hasbackgroundcolour(wxListItemAttr * attr);
	int bmx_wxlistitemattr_hasfont(wxListItemAttr * attr);
	int bmx_wxlistitemattr_hastextcolour(wxListItemAttr * attr);
	void bmx_wxlistitemattr_setbackgroundcolour(wxListItemAttr * attr, MaxColour * colour);
	void bmx_wxlistitemattr_setfont(wxListItemAttr * attr, MaxFont * font);
	void bmx_wxlistitemattr_settextcolour(wxListItemAttr * attr, MaxColour * colour);
	void bmx_wxlistitemattr_delete(wxListItemAttr * attr);

	long bmx_wxlistevent_getcachefrom(wxListEvent & event);
	long bmx_wxlistevent_getcacheto(wxListEvent & event);
	int bmx_wxlistevent_getkeycode(wxListEvent & event);
	long bmx_wxlistevent_getindex(wxListEvent & event);
	long bmx_wxlistevent_getcolumn(wxListEvent & event);
	void bmx_wxlistevent_getpoint(wxListEvent & event, int * x, int * y);
	BBString * bmx_wxlistevent_getlabel(wxListEvent & event);
	BBString * bmx_wxlistevent_gettext(wxListEvent & event);
	int bmx_wxlistevent_getimage(wxListEvent & event);
	long bmx_wxlistevent_getdata(wxListEvent & event);
	long bmx_wxlistevent_getmask(wxListEvent & event);
	MaxListItem * bmx_wxlistevent_getitem(wxListEvent & event);
	int bmx_wxlistevent_iseditcancelled(wxListEvent & event);

	int bmx_wxlistctrl_geteventtype(int type);

	void bmx_wxlistctrl_addresourcehandler();
	
	void bmx_releaseallclientdata(wxListCtrl * list);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxListItem
{
public:
	MaxListItem();
	MaxListItem(wxListItem & item);
	~MaxListItem();
	wxListItem & Item();

private:
	wxListItem item;

};


class MaxListCtrl : public wxListCtrl
{
public:
	MaxListCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxListCtrl();
	~MaxListCtrl();

	virtual wxString OnGetItemText(long item, long column) const;
	virtual int OnGetItemColumnImage(long item, long column) const;
	virtual wxListItemAttr *OnGetItemAttr(long item) const;
	virtual int OnGetItemImage(long item) const;

	void MaxBind(BBObject * handle);

	bool SetSortCallback();
//	int wxCALLBACK compare(long item1, long item2, long sortData);
	
private:
	BBObject * maxHandle;
	DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxListCtrlXmlHandler : public wxListCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxListCtrlXmlHandler)

public:
    MaxListCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
