/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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


MaxListBox::MaxListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxListBox(parent, id, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxListBox::MaxListBox()
{}

MaxListBox::~MaxListBox() {
	wxunbind(this);

	// we need to free any items
	int count = GetCount();
	for (int i = 0; i < count; i++) {
		void * data = GetClientData(i);
		if (data) {
			BBRELEASE((BBObject*)data);
		}
	}
}

void MaxListBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxListBoxXmlHandler , wxListBoxXmlHandler)

MaxListBoxXmlHandler::MaxListBoxXmlHandler()
	: wxListBoxXmlHandler()
{}


wxObject * MaxListBoxXmlHandler::DoCreateResource()
{
    if ( m_class == wxT("wxListBox"))
    {
        // find the selection
        long selection = GetLong(wxT("selection"), -1);

        // need to build the list of strings from children
        m_insideBox = true;
        CreateChildrenPrivately(NULL, GetParamNode(wxT("content")));
        m_insideBox = false;

        XRC_MAKE_INSTANCE(control, MaxListBox)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetPosition(), GetSize(),
                        strList,
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());

		control->MaxBind(_wx_wxlistbox_wxListBox__xrcNew(control));

        if (selection != -1)
            control->SetSelection(selection);

        SetupWindow(control);
        strList.Clear();    // dump the strings

        return control;
    }
    else
    {
        // on the inside now.
        // handle <item>Label</item>

        // add to the list
        wxString str = GetNodeContent(m_node);
        if (m_resource->GetFlags() & wxXRC_USE_LOCALE)
            str = wxGetTranslation(str, m_resource->GetDomain());
        strList.Add(str);

        return NULL;
    }
}

// *********************************************

BEGIN_EVENT_TABLE(MaxListBox, wxListBox)
END_EVENT_TABLE()

MaxListBox * bmx_wxlistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxListBox(maxHandle, parent, id, bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}


void bmx_wxlistbox_insertitems(wxListBox * listbox, BBArray * items, int pos) {
	listbox->InsertItems(bbStringArrayTowxArrayStr(items), pos);
}

BBArray * bmx_wxlistbox_getselections(wxListBox * listbox) {
	wxArrayInt selections;
	listbox->GetSelections(selections);
	return wxArrayIntToBBIntArray(selections);
}

bool bmx_wxlistbox_isselected(wxListBox * listbox, int item) {
	return listbox->IsSelected(item);
}

void bmx_wxlistbox_deselect(wxListBox * listbox, int item) {
	listbox->Deselect(item);
}

int bmx_wxlistbox_hittest(wxListBox * listbox, int x, int y) {
	return listbox->HitTest(wxPoint(x, y));
}

void bmx_wxlistbox_setfirstitem(wxListBox * listbox, int item) {
	listbox->SetFirstItem(item);
}

void bmx_wxlistbox_setfirstitemstr(wxListBox * listbox, BBString * item) {
	listbox->SetFirstItem(wxStringFromBBString(item));
}

int bmx_wxlistbox_geteventtype(int type) {
	switch(type) {
		case 4: return wxEVT_COMMAND_LISTBOX_SELECTED;
		case 5: return wxEVT_COMMAND_LISTBOX_DOUBLECLICKED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxlistbox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxListBoxXmlHandler);
}
