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
#include "wx/menu.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/xrc/xh_menu.h"
#include "wx/xml/xml.h"

class MaxMenu;

extern "C" {

#include <blitz.h>

	void _wx_wxmenu_wxMenu__setmenuitem(BBArray * items, int index, wxMenuItem * item);
	BBObject * _wx_wxmenu_wxMenu__xrcNew(wxMenu * menu);

	MaxMenu * bmx_wxmenu_create(BBObject * maxHandle, BBString * title, long style);
	wxMenuItem * bmx_wxmenu_append(wxMenu * menu, int id, BBString * item, BBString * helpString, wxItemKind kind);
	wxMenuItem * bmx_wxmenu_appenditem(wxMenu * menu, wxMenuItem * item);
	wxMenuItem * bmx_wxmenu_appendseparator(wxMenu * menu);
	wxMenuItem * bmx_wxmenu_appendcheckitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	wxMenuItem * bmx_wxmenu_appendradioitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	void bmx_wxmenu_break(wxMenu * menu);
	void bmx_wxmenu_free(wxMenu * menu);

	wxMenuItem * bmx_wxmenu_appendsubmenu(wxMenu * menu, wxMenu * submenu, BBString * item, BBString * helpString);
	void bmx_wxmenu_check(wxMenu * menu, int id, int value);
	void bmx_wxmenu_delete(wxMenu * menu, int id);
	void bmx_wxmenu_destroy(wxMenu * menu, int id);
	void bmx_wxmenu_destroyitem(wxMenu * menu, wxMenuItem * item);
	void bmx_wxmenu_enable(wxMenu * menu, int id, int value);
	int bmx_wxmenu_finditem(wxMenu * menu, BBString * itemString);
	wxMenuItem * bmx_wxmenu_finditembyposition(wxMenu * menu, int pos);
	BBString * bmx_wxmenu_gethelpstring(wxMenu * menu, int id);
	BBString * bmx_wxmenu_getlabel(wxMenu * menu, int id);
	int bmx_wxmenu_getmenuitemcount(wxMenu * menu);
	BBString * bmx_wxmenu_gettitle(wxMenu * menu);
	wxMenuItem * bmx_wxmenu_insert(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString, wxItemKind kind);
	wxMenuItem * bmx_wxmenu_insertitem(wxMenu * menu, int pos, wxMenuItem * item);
	wxMenuItem * bmx_wxmenu_insertcheckitem(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString);
	wxMenuItem * bmx_wxmenu_insertradioitem(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString);
	wxMenuItem * bmx_wxmenu_insertseparator(wxMenu * menu, int pos);
	int bmx_wxmenu_ischecked(wxMenu * menu, int id);
	int bmx_wxmenu_isenabled(wxMenu * menu, int id);
	wxMenuItem * bmx_wxmenu_prepend(wxMenu * menu, int id, BBString * item, BBString * helpString, wxItemKind kind);
	wxMenuItem * bmx_wxmenu_prependcheckitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	wxMenuItem * bmx_wxmenu_prependradioitem(wxMenu * menu, int id, BBString * item, BBString * helpString);
	wxMenuItem * bmx_wxmenu_prependseparator(wxMenu * menu);
	void bmx_wxmenu_remove(wxMenu * menu, int id);
	void bmx_wxmenu_sethelpstring(wxMenu * menu, int id, BBString * helpString);
	void bmx_wxmenu_setlabel(wxMenu * menu, int id, BBString * label);
	void bmx_wxmenu_settitle(wxMenu * menu, BBString * title);
	void bmx_wxmenu_updateui(wxMenu * menu, wxEvtHandler * source);
	void bmx_wxmenu_getmenuitems(wxMenu * menu, BBArray * items);

	int bmx_wxmenu_geteventtype(int type);

	wxMenuItem * bmx_wxmenuitem_create(wxMenu * parentMenu, int id, BBString * text, BBString * helpString,
		wxItemKind kind, wxMenu * subMenu);
	void bmx_wxmenuitem_delete(wxMenuItem * item);
	void bmx_wxmenuitem_check(wxMenuItem * item, int value);
	void bmx_wxmenuitem_enable(wxMenuItem * item, int value);
	MaxColour * bmx_wxmenuitem_getbackgroundcolour(wxMenuItem * item);
	MaxBitmap * bmx_wxmenuitem_getbitmap(wxMenuItem * item, int checked);
	MaxFont * bmx_wxmenuitem_getfont(wxMenuItem * item);
	BBString * bmx_wxmenuitem_gethelp(wxMenuItem * item);
	int bmx_wxmenuitem_getid(wxMenuItem * item);
	int bmx_wxmenuitem_getkind(wxMenuItem * item);
	BBString * bmx_wxmenuitem_getitemlabeltext(wxMenuItem * item);
	BBString * bmx_wxmenuitem_getlabeltext(BBString * text);
	int bmx_wxmenuitem_getmarginwidth(wxMenuItem * item);
	wxMenu * bmx_wxmenuitem_getmenu(wxMenuItem * item);
	BBString * bmx_wxmenuitem_getitemlabel(wxMenuItem * item);
	wxMenu * bmx_wxmenuitem_getsubmenu(wxMenuItem * item);
	MaxColour * bmx_wxmenuitem_gettextcolour(wxMenuItem * item);
	int bmx_wxmenuitem_ischeckable(wxMenuItem * item);
	int bmx_wxmenuitem_ischecked(wxMenuItem * item);
	int bmx_wxmenuitem_isenabled(wxMenuItem * item);
	int bmx_wxmenuitem_isseparator(wxMenuItem * item);
	int bmx_wxmenuitem_issubmenu(wxMenuItem * item);
	void bmx_wxmenuitem_setbackgroundcolour(wxMenuItem * item, MaxColour * colour);
	void bmx_wxmenuitem_setbitmap(wxMenuItem * item, MaxBitmap * bitmap);
	void bmx_wxmenuitem_setbitmaps(wxMenuItem * item, MaxBitmap * checked, MaxBitmap * unchecked);
	void bmx_wxmenuitem_setfont(wxMenuItem * item, MaxFont * font);
	void bmx_wxmenuitem_sethelp(wxMenuItem * item, BBString * helpString);
	void bmx_wxmenuitem_setmarginwidth(wxMenuItem * item, int width);
	void bmx_wxmenuitem_setmenu(wxMenuItem * item, wxMenu * menu);
	void bmx_wxmenuitem_setsubmenu(wxMenuItem * item, wxMenu * submenu);
	void bmx_wxmenuitem_setitemlabel(wxMenuItem * item, BBString * text);
	void bmx_wxmenuitem_settextcolour(wxMenuItem * item, MaxColour * colour);
	void bmx_wxmenuitem_toggle(wxMenuItem * item);
	wxAcceleratorEntry * bmx_wxmenuitem_getaccel(wxMenuItem * item);

	wxMenu * bmx_wxmenuevent_getmenu(wxMenuEvent & event);
	int bmx_wxmenuevent_getmenuid(wxMenuEvent & event);
	int bmx_wxmenuevent_ispopup(wxMenuEvent & event);

	void bmx_wxmenu_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxMenu : public wxMenu
{
public:
	MaxMenu(BBObject * handle, const wxString& title, long style);
	MaxMenu(long style);
	~MaxMenu();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMenuXmlHandler : public wxMenuXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxMenuXmlHandler)

public:
    MaxMenuXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);

    bool m_insideMenu;
};
