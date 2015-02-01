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

#include "glue.h"

// ---------------------------------------------------------------------------------------


MaxMenu::MaxMenu(BBObject * handle, const wxString& title, long style)
	: wxMenu(title, style)
{
	wxbind(this, handle);
}

MaxMenu::MaxMenu(long style)
	: wxMenu(style)
{}

MaxMenu::~MaxMenu() {
	wxunbind(this);
}

void MaxMenu::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxMenuXmlHandler, wxMenuXmlHandler)

MaxMenuXmlHandler::MaxMenuXmlHandler()
	: m_insideMenu(false)
{}


wxObject * MaxMenuXmlHandler::DoCreateResource()
{
    if (m_class == wxT("wxMenu"))
    {

	     MaxMenu *menu;
		
		if (m_instance) {
			menu = wxStaticCast(m_instance, MaxMenu);
		} else {
	          menu = new MaxMenu(GetStyle());
			menu->MaxBind(CB_PREF(wx_wxmenu_wxMenu__xrcNew)(menu));
		}

        wxString title = GetText(wxT("label"));
        wxString help = GetText(wxT("help"));

        bool oldins = m_insideMenu;
        m_insideMenu = true;
        CreateChildren(menu, true/*only this handler*/);
        m_insideMenu = oldins;

        wxMenuBar *p_bar = wxDynamicCast(m_parent, wxMenuBar);
        if (p_bar)
        {
            p_bar->Append(menu, title);
        }
        else
        {
            wxMenu *p_menu = wxDynamicCast(m_parent, wxMenu);
            if (p_menu)
            {
                p_menu->Append(GetID(), title, menu, help);
                if (HasParam(wxT("enabled")))
                    p_menu->Enable(GetID(), GetBool(wxT("enabled")));
            }
        }

        return menu;
    }

    else
    {
        wxMenu *p_menu = wxDynamicCast(m_parent, wxMenu);

        if (m_class == wxT("separator"))
            p_menu->AppendSeparator();
        else if (m_class == wxT("break"))
            p_menu->Break();
        else /*wxMenuItem*/
        {
            int id = GetID();
            wxString label = GetText(wxT("label"));
            wxString accel = GetText(wxT("accel"), false);
            wxString fullLabel = label;
            if (!accel.empty())
                fullLabel << wxT("\t") << accel;

            wxItemKind kind = wxITEM_NORMAL;
            if (GetBool(wxT("radio")))
                kind = wxITEM_RADIO;
            if (GetBool(wxT("checkable")))
            {
                wxASSERT_MSG( kind == wxITEM_NORMAL, _T("can't have both checkable and radion button at once") );
                kind = wxITEM_CHECK;
            }

            wxMenuItem *mitem = new wxMenuItem(p_menu, id, fullLabel,
                                               GetText(wxT("help")), kind);

#if (!defined(__WXMSW__) && !defined(__WXPM__)) || wxUSE_OWNER_DRAWN
            if (HasParam(wxT("bitmap")))
                mitem->SetBitmap(GetBitmap(wxT("bitmap"), wxART_MENU));
#endif
            p_menu->Append(mitem);
            mitem->Enable(GetBool(wxT("enabled"), true));
            if (kind == wxITEM_CHECK)
                mitem->Check(GetBool(wxT("checked")));
        }
        return NULL;
    }
}

bool MaxMenuXmlHandler::CanHandle(wxXmlNode *node)
{
    return IsOfClass(node, wxT("wxMenu")) ||
           (m_insideMenu &&
               (IsOfClass(node, wxT("wxMenuItem")) ||
                IsOfClass(node, wxT("break")) ||
                IsOfClass(node, wxT("separator")))
           );
}

// *********************************************


MaxMenu * bmx_wxmenu_create(BBObject * maxHandle, BBString * title, long style) {
	return new MaxMenu(maxHandle, wxStringFromBBString(title), style);
}

wxMenuItem * bmx_wxmenu_append(wxMenu * menu, int id, BBString * item, BBString * helpString, wxItemKind kind) {
	return menu->Append(id, wxStringFromBBString(item), wxStringFromBBString(helpString), kind);
}

wxMenuItem * bmx_wxmenu_appenditem(wxMenu * menu, wxMenuItem * item) {
	return menu->Append(item);
}

wxMenuItem * bmx_wxmenu_appendseparator(wxMenu * menu) {
	return menu->AppendSeparator();
}

wxMenuItem * bmx_wxmenu_appendcheckitem(wxMenu * menu, int id, BBString * item, BBString * helpString) {
	return menu->AppendCheckItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

wxMenuItem * bmx_wxmenu_appendradioitem(wxMenu * menu, int id, BBString * item, BBString * helpString) {
	return menu->AppendRadioItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

void bmx_wxmenu_break(wxMenu * menu) {
	menu->Break();
}

wxMenuItem * bmx_wxmenu_appendsubmenu(wxMenu * menu, wxMenu * submenu, BBString * item, BBString * helpString) {
	return menu->AppendSubMenu(submenu, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

void bmx_wxmenu_check(wxMenu * menu, int id, int value) {
	menu->Check(id, static_cast<bool>(value));
}

void bmx_wxmenu_delete(wxMenu * menu, int id) {
	menu->Delete(id);
}

void bmx_wxmenu_destroy(wxMenu * menu, int id) {
	menu->Destroy(id);
}

void bmx_wxmenu_destroyitem(wxMenu * menu, wxMenuItem * item) {
	menu->Destroy(item);
}

void bmx_wxmenu_enable(wxMenu * menu, int id, int value) {
	menu->Enable(id, static_cast<bool>(value));
}

int bmx_wxmenu_finditem(wxMenu * menu, BBString * itemString) {
	return menu->FindItem(wxStringFromBBString(itemString));
}

wxMenuItem * bmx_wxmenu_finditembyposition(wxMenu * menu, int pos) {
	return menu->FindItemByPosition(pos);
}

BBString * bmx_wxmenu_gethelpstring(wxMenu * menu, int id) {
	return bbStringFromWxString(menu->GetHelpString(id));
}

BBString * bmx_wxmenu_getlabel(wxMenu * menu, int id) {
	return bbStringFromWxString(menu->GetLabel(id));
}

int bmx_wxmenu_getmenuitemcount(wxMenu * menu) {
	return menu->GetMenuItemCount();
}

BBString * bmx_wxmenu_gettitle(wxMenu * menu) {
	return bbStringFromWxString(menu->GetTitle());
}

wxMenuItem * bmx_wxmenu_insert(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString, wxItemKind kind) {
	return menu->Insert(pos, id, wxStringFromBBString(item), wxStringFromBBString(helpString), kind);
}

wxMenuItem * bmx_wxmenu_insertitem(wxMenu * menu, int pos, wxMenuItem * item) {
	return menu->Insert(pos, item);
}

wxMenuItem * bmx_wxmenu_insertcheckitem(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString) {
	return menu->InsertCheckItem(pos, id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

wxMenuItem * bmx_wxmenu_insertradioitem(wxMenu * menu, int pos, int id, BBString * item, BBString * helpString) {
	return menu->InsertRadioItem(pos, id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

wxMenuItem * bmx_wxmenu_insertseparator(wxMenu * menu, int pos) {
	return menu->InsertSeparator(pos);
}

int bmx_wxmenu_ischecked(wxMenu * menu, int id) {
	return static_cast<int>(menu->IsChecked(id));
}

int bmx_wxmenu_isenabled(wxMenu * menu, int id) {
	return static_cast<int>(menu->IsEnabled(id));
}

wxMenuItem * bmx_wxmenu_prepend(wxMenu * menu, int id, BBString * item, BBString * helpString, wxItemKind kind) {
	return menu->Prepend(id, wxStringFromBBString(item), wxStringFromBBString(helpString), kind);
}

wxMenuItem * bmx_wxmenu_prependcheckitem(wxMenu * menu, int id, BBString * item, BBString * helpString) {
	return menu->PrependCheckItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

wxMenuItem * bmx_wxmenu_prependradioitem(wxMenu * menu, int id, BBString * item, BBString * helpString) {
	return menu->PrependRadioItem(id, wxStringFromBBString(item), wxStringFromBBString(helpString));
}

wxMenuItem * bmx_wxmenu_prependseparator(wxMenu * menu) {
	return menu->PrependSeparator();
}

void bmx_wxmenu_remove(wxMenu * menu, int id) {
	menu->Remove(id);
}

void bmx_wxmenu_sethelpstring(wxMenu * menu, int id, BBString * helpString) {
	menu->SetHelpString(id, wxStringFromBBString(helpString));
}

void bmx_wxmenu_setlabel(wxMenu * menu, int id, BBString * label) {
	menu->SetLabel(id, wxStringFromBBString(label));
}

void bmx_wxmenu_settitle(wxMenu * menu, BBString * title) {
	menu->SetTitle(wxStringFromBBString(title));
}

void bmx_wxmenu_updateui(wxMenu * menu, wxEvtHandler * source) {
	if (source) {
		menu->UpdateUI(source);
	} else {
		menu->UpdateUI();
	}
}

void bmx_wxmenu_getmenuitems(wxMenu * menu, BBArray * items) {
	int index = 0;
	for ( wxwxMenuItemListNode *node = menu->GetMenuItems().GetFirst(); node; node = node->GetNext() )     { 
		CB_PREF(wx_wxmenu_wxMenu__setmenuitem)(items, index, node->GetData());
		index++;
	} 
}

void bmx_wxmenu_free(wxMenu * menu) {
	delete menu;
}

wxMenuItem * bmx_wxmenu_findchilditem(wxMenu * menu, int id, int pos) {
	size_t p;
	wxMenuItem * item = menu->FindChildItem(id, &p);
	pos = static_cast<int>(p);
	return item;
}

// *********************************************

wxMenuItem * bmx_wxmenuitem_create(wxMenu * parentMenu, int id, BBString * text, BBString * helpString,
		wxItemKind kind, wxMenu * subMenu) {	
	return new wxMenuItem(parentMenu, id, wxStringFromBBString(text), wxStringFromBBString(helpString), kind, subMenu);
}

void bmx_wxmenuitem_delete(wxMenuItem * item) {
	delete item;
}

void bmx_wxmenuitem_check(wxMenuItem * item, int value) {
	item->Check(static_cast<bool>(value));
}

void bmx_wxmenuitem_enable(wxMenuItem * item, int value) {
	item->Enable(static_cast<bool>(value));
}

MaxColour * bmx_wxmenuitem_getbackgroundcolour(wxMenuItem * item) {
#ifdef WIN32
	wxColour c(item->GetBackgroundColour());
#else
	wxColour c = wxNullColour;
#endif
	return new MaxColour(c);
}

MaxBitmap * bmx_wxmenuitem_getbitmap(wxMenuItem * item, int checked) {
#ifdef WIN32
	wxBitmap b(item->GetBitmap(static_cast<bool>(checked)));
#else
	wxBitmap b = wxNullBitmap;
#endif
	return new MaxBitmap(b);
}

MaxFont * bmx_wxmenuitem_getfont(wxMenuItem * item) {
#ifdef WIN32
	wxFont f(item->GetFont());
#else
	wxFont f = wxNullFont;
#endif
	return new MaxFont(f);
}

BBString * bmx_wxmenuitem_gethelp(wxMenuItem * item) {
	return bbStringFromWxString(item->GetHelp());
}

int bmx_wxmenuitem_getid(wxMenuItem * item) {
	return item->GetId();
}

int bmx_wxmenuitem_getkind(wxMenuItem * item) {
	return item->GetKind();
}

BBString * bmx_wxmenuitem_getitemlabeltext(wxMenuItem * item) {
	return bbStringFromWxString(item-> GetItemLabelText());
}

BBString * bmx_wxmenuitem_getlabeltext(BBString * text) {
	return bbStringFromWxString(wxMenuItem::GetLabelText(wxStringFromBBString(text)));
}

int bmx_wxmenuitem_getmarginwidth(wxMenuItem * item) {
#ifdef WIN32
	return item->GetMarginWidth();
#else
	return 0;
#endif
}

wxMenu * bmx_wxmenuitem_getmenu(wxMenuItem * item) {
	return item->GetMenu();
}

BBString * bmx_wxmenuitem_getitemlabel(wxMenuItem * item) {
	return bbStringFromWxString(item-> GetItemLabel());
}

wxMenu * bmx_wxmenuitem_getsubmenu(wxMenuItem * item) {
	return item->GetSubMenu();
}

MaxColour * bmx_wxmenuitem_gettextcolour(wxMenuItem * item) {
#ifdef WIN32
	wxColour c(item->GetTextColour());
#else
	wxColour c = wxNullColour;
#endif
	return new MaxColour(c);
}

int bmx_wxmenuitem_ischeckable(wxMenuItem * item) {
	return static_cast<int>(item->IsCheckable());
}

int bmx_wxmenuitem_ischecked(wxMenuItem * item) {
	return static_cast<int>(item->IsChecked());
}

int bmx_wxmenuitem_isenabled(wxMenuItem * item) {
	return static_cast<int>(item->IsEnabled());
}

int bmx_wxmenuitem_isseparator(wxMenuItem * item) {
	return static_cast<int>(item->IsSeparator());
}

int bmx_wxmenuitem_issubmenu(wxMenuItem * item) {
	return static_cast<int>(item->IsSubMenu());
}

void bmx_wxmenuitem_setbackgroundcolour(wxMenuItem * item, MaxColour * colour) {
#ifdef WIN32
	item->SetBackgroundColour(colour->Colour());
#endif
}

void bmx_wxmenuitem_setbitmap(wxMenuItem * item, MaxBitmap * bitmap) {
#ifdef WIN32
	item->SetBitmap(bitmap->Bitmap());
#endif
}

void bmx_wxmenuitem_setbitmaps(wxMenuItem * item, MaxBitmap * checked, MaxBitmap * unchecked) {
#ifdef WIN32
	if (unchecked) {
		item->SetBitmaps(checked->Bitmap(), unchecked->Bitmap());
	} else {
		item->SetBitmaps(checked->Bitmap());
	}
#endif
}

void bmx_wxmenuitem_setfont(wxMenuItem * item, MaxFont * font) {
#ifdef WIN32
	item->SetFont(font->Font());
#endif
}

void bmx_wxmenuitem_sethelp(wxMenuItem * item, BBString * helpString) {
	item->SetHelp(wxStringFromBBString(helpString));
}

void bmx_wxmenuitem_setmarginwidth(wxMenuItem * item, int width) {
#ifdef WIN32
	item->SetMarginWidth(width);
#endif
}

void bmx_wxmenuitem_setmenu(wxMenuItem * item, wxMenu * menu) {
	item->SetMenu(menu);
}

void bmx_wxmenuitem_setsubmenu(wxMenuItem * item, wxMenu * submenu) {
	item->SetSubMenu(submenu);
}

void bmx_wxmenuitem_setitemlabel(wxMenuItem * item, BBString * text) {
	item->SetItemLabel(wxStringFromBBString(text));
}

void bmx_wxmenuitem_settextcolour(wxMenuItem * item, MaxColour * colour) {
#ifdef WIN32
	item->SetTextColour(colour->Colour());
#endif
}

void bmx_wxmenuitem_toggle(wxMenuItem * item) {
	item->Toggle();
}

wxAcceleratorEntry * bmx_wxmenuitem_getaccel(wxMenuItem * item) {
	return item->GetAccel();
}

void bmx_wxmenuitem_setcheckable(wxMenuItem * item, int checkable) {
	item->SetCheckable(static_cast<bool>(checkable));
}

// *********************************************

wxAcceleratorEntry * bmx_wxacceleratorentry_create(int flags, int keyCode, int cmd, wxMenuItem * item) {
	return new wxAcceleratorEntry(flags, keyCode, cmd, item);
}

int bmx_wxacceleratorentry_getcommand(wxAcceleratorEntry * entry) {
	return entry->GetCommand();
}

int bmx_wxacceleratorentry_getflags(wxAcceleratorEntry * entry) {
	return entry->GetFlags();
}

int bmx_wxacceleratorentry_getkeycode(wxAcceleratorEntry * entry) {
	return entry->GetKeyCode();
}

void bmx_wxacceleratorentry_set(wxAcceleratorEntry * entry, int flags, int keyCode, int cmd) {
	entry->Set(flags, keyCode, cmd);
}

void bmx_wxacceleratorentry_delete(wxAcceleratorEntry * entry) {
	delete entry;
}

int bmx_wxacceleratorentry_fromstring(wxAcceleratorEntry * entry, BBString * text) {
	return static_cast<int>(entry->FromString(wxStringFromBBString(text)));
}

BBString * bmx_wxacceleratorentry_torawstring(wxAcceleratorEntry * entry) {
	return bbStringFromWxString(entry->ToRawString());
}

BBString * bmx_wxacceleratorentry_tostring(wxAcceleratorEntry * entry) {
	return bbStringFromWxString(entry->ToString());
}

wxMenuItem * bmx_wxacceleratorentry_getmenuitem(wxAcceleratorEntry * entry) {
	return entry->GetMenuItem();
}

// *********************************************

wxMenu * bmx_wxmenuevent_getmenu(wxMenuEvent & event) {
	return event.GetMenu();
}

int bmx_wxmenuevent_getmenuid(wxMenuEvent & event) {
	return event.GetMenuId();
}

int bmx_wxmenuevent_ispopup(wxMenuEvent & event) {
	return static_cast<int>(event.IsPopup());
}



int bmx_wxmenu_geteventtype(int type) {
	switch(type) {
		case 421: return wxEVT_MENU_OPEN;
		case 422: return wxEVT_MENU_CLOSE;
		case 423: return wxEVT_MENU_HIGHLIGHT;
	}
	
	return 0;
}

// *********************************************

void bmx_wxmenu_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxMenuXmlHandler);
}

