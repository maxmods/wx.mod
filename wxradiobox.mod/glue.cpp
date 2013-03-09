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

MaxRadioBox::MaxRadioBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, const wxArrayString& array, int majorDimension, long style)
	: wxRadioBox(parent, id, label, wxPoint(x, y), wxSize(w, h), array, majorDimension, style)
{
	wxbind(this, handle);
}

MaxRadioBox::MaxRadioBox()
{}

MaxRadioBox::~MaxRadioBox() {
	wxunbind(this);
}

void MaxRadioBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxRadioBoxXmlHandler, wxRadioBoxXmlHandler)

MaxRadioBoxXmlHandler::MaxRadioBoxXmlHandler()
	: wxRadioBoxXmlHandler(), m_insideBox(false)
{}


wxObject * MaxRadioBoxXmlHandler::DoCreateResource()
{
    if ( m_class == wxT("wxRadioBox"))
    {
        // find the selection
        long selection = GetLong( wxT("selection"), -1 );

        // need to build the list of strings from children
        m_insideBox = true;
        CreateChildrenPrivately( NULL, GetParamNode(wxT("content")));

        wxString *strings;
        if ( !labels.empty() )
        {
            strings = new wxString[labels.size()];
            const unsigned count = labels.size();
            for( unsigned i = 0; i < count; i++ )
                strings[i] = labels[i];
        }
        else
        {
            strings = NULL;
        }

        XRC_MAKE_INSTANCE(control, MaxRadioBox)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetText(wxT("label")),
                        GetPosition(), GetSize(),
                        labels.size(),
                        strings,
                        GetLong(wxT("dimension"), 1),
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());

        delete[] strings;

        if (selection != -1)
            control->SetSelection(selection);

		control->MaxBind(_wx_wxradiobox_wxRadioBox__xrcNew(control));

        SetupWindow(control);

        const unsigned count = labels.size();
        for( unsigned i = 0; i < count; i++ )
        {
#if wxUSE_TOOLTIPS
            if ( !tooltips[i].empty() )
                control->SetItemToolTip(i, tooltips[i]);
#endif // wxUSE_TOOLTIPS
#if wxUSE_HELP
            if ( helptextSpecified[i] )
                control->SetItemHelpText(i, helptexts[i]);
#endif // wxUSE_HELP
        }

        labels.clear();    // dump the strings

        tooltips.clear();    // dump the tooltips

        helptexts.clear();   // dump the helptexts
        helptextSpecified.clear();

        return control;
    }
    else // inside the radiobox element
    {
        // we handle handle <item tooltip="..." helptext="...">Label</item> constructs here

        wxString str = GetNodeContent(m_node);

        wxString tooltip;
        m_node->GetPropVal(wxT("tooltip"), &tooltip);

        wxString helptext;
        bool hasHelptext = m_node->GetPropVal(wxT("helptext"), &helptext);

        if (m_resource->GetFlags() & wxXRC_USE_LOCALE)
        {
            str = wxGetTranslation(str, m_resource->GetDomain());
            if ( !tooltip.empty() )
                tooltip = wxGetTranslation(tooltip, m_resource->GetDomain());
            if ( hasHelptext )
                helptext = wxGetTranslation(helptext, m_resource->GetDomain());
        }

        labels.push_back(str);
        tooltips.push_back(tooltip);
        helptexts.push_back(helptext);
        helptextSpecified.push_back(hasHelptext);

        return NULL;
    }

}

bool MaxRadioBoxXmlHandler::CanHandle(wxXmlNode *node)
{
    return (IsOfClass(node, wxT("wxRadioBox")) ||
           (m_insideBox && node->GetName() == wxT("item")));
}


// *********************************************

MaxRadioBox * bmx_wxradiobox_create(BBObject * handle, wxWindow * parent, int id, BBString * label,
		int x, int y, int w, int h, BBArray * array, int majorDimension, long style) {
	return new MaxRadioBox(handle, parent, id, wxStringFromBBString(label), x, y, w, h, 
		bbStringArrayTowxArrayStr(array), majorDimension, style);
}

int bmx_wxradiobox_enable(wxRadioBox * radiobox, int value) {
	return static_cast<int>(radiobox->Enable(static_cast<bool>(value)));
}

int bmx_wxradiobox_enableitem(wxRadioBox * radiobox, unsigned int item, int value) {
	return static_cast<int>(radiobox->Enable(item, static_cast<bool>(value)));
}

int bmx_wxradiobox_findstring(wxRadioBox * radiobox, BBString * text, int caseSensitive) {
	return radiobox->FindString(wxStringFromBBString(text), static_cast<bool>(caseSensitive));
}

unsigned int bmx_wxradiobox_getcolumncount(wxRadioBox * radiobox) {
	return radiobox->GetColumnCount();
}

BBString * bmx_wxradiobox_getitemhelptext(wxRadioBox * radiobox, unsigned int item) {
	return bbStringFromWxString(radiobox->GetItemHelpText(item));
}

int bmx_wxradiobox_getitemfrompoint(wxRadioBox * radiobox, int x, int y) {
	return radiobox->GetItemFromPoint(wxPoint(x, y));
}

BBString * bmx_wxradiobox_getlabel(wxRadioBox * radiobox) {
	return bbStringFromWxString(radiobox->GetLabel());
}

BBString * bmx_wxradiobox_getitemlabel(wxRadioBox * radiobox, int item) {
	return bbStringFromWxString(radiobox->GetString(item));
}

unsigned int bmx_wxradiobox_getrowcount(wxRadioBox * radiobox) {
	return radiobox->GetRowCount();
}

int bmx_wxradiobox_getselection(wxRadioBox * radiobox) {
	return radiobox->GetSelection();
}

BBString * bmx_wxradiobox_getstringselection(wxRadioBox * radiobox) {
	return bbStringFromWxString(radiobox->GetStringSelection());
}

BBString * bmx_wxradiobox_getstring(wxRadioBox * radiobox, unsigned int item) {
	return bbStringFromWxString(radiobox->GetString(item));
}

int bmx_wxradiobox_isitemenabled(wxRadioBox * radiobox, unsigned int item) {
	return static_cast<int>(radiobox->IsItemEnabled(item));
}

int bmx_wxradiobox_isitemshown(wxRadioBox * radiobox, unsigned int item) {
	return static_cast<int>(radiobox->IsItemShown(item));
}

void bmx_wxradiobox_setitemhelptext(wxRadioBox * radiobox, unsigned int item, BBString * helpText) {
	radiobox->SetItemHelpText(item, wxStringFromBBString(helpText));
}

void bmx_wxradiobox_setlabel(wxRadioBox * radiobox, BBString * label) {
	radiobox->SetLabel(wxStringFromBBString(label));
}

void bmx_wxradiobox_setitemlabel(wxRadioBox * radiobox, int item, BBString * label) {
	radiobox->SetString(item, wxStringFromBBString(label));
}

void bmx_wxradiobox_setselection(wxRadioBox * radiobox, int item) {
	radiobox->SetSelection(item);
}

void bmx_wxradiobox_setstringselection(wxRadioBox * radiobox, BBString * text) {
	radiobox->SetStringSelection(wxStringFromBBString(text));
}

void bmx_wxradiobox_setitemtooltip(wxRadioBox * radiobox, unsigned int item, BBString * text) {
	radiobox->SetItemToolTip(item, wxStringFromBBString(text));
}

int bmx_wxradiobox_show(wxRadioBox * radiobox, int value) {
	return static_cast<int>(radiobox->Show(static_cast<bool>(value)));
}

int bmx_wxradiobox_showItem(wxRadioBox * radiobox, unsigned int item, int value) {
	return static_cast<int>(radiobox->Show(item, static_cast<bool>(value)));
}

wxToolTip * bmx_wxradiobox_getitemtooltip(wxRadioBox * radiobox, int item) {
	return radiobox->GetItemToolTip(item);
}

int bmx_wxradiobox_geteventtype(int type) {
	switch(type) {
		case 11: return wxEVT_COMMAND_RADIOBOX_SELECTED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxradiobox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxRadioBoxXmlHandler);
}
