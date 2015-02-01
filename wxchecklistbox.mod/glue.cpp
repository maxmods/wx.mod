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


MaxCheckListBox::MaxCheckListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxCheckListBox(parent, id, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxCheckListBox::MaxCheckListBox()
{}

MaxCheckListBox::~MaxCheckListBox() {
	wxunbind(this);

	// we need to free any items
	int count = GetCount();
	if (HasClientUntypedData()) {
		for (int i = 0; i < count; i++) {
			void * data = GetClientData(i);
			if (data) {
				BBRELEASE((BBObject*)data);
			}
		}
	}
}

void MaxCheckListBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

void MaxCheckListBox::Clear() {
	// we need to free any items
	int count = GetCount();
	if (HasClientUntypedData()) {
		for (int i = 0; i < count; i++) {
			void * data = GetClientData(i);
			if (data) {
				BBRELEASE((BBObject*)data);
				SetClientData(i, 0);
			}
		}
	}
	wxCheckListBox::Clear();
}

void MaxCheckListBox::Delete(unsigned int n) {
	if (HasClientUntypedData()) {
		void * data = GetClientData(n);
		if (data) {
			BBRELEASE((BBObject*)data);
			SetClientData(n, 0);
		}
	}
	
	wxCheckListBox::Delete(n);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxCheckListBoxXmlHandler, wxCheckListBoxXmlHandler)

MaxCheckListBoxXmlHandler::MaxCheckListBoxXmlHandler()
	: wxCheckListBoxXmlHandler()
{}


wxObject * MaxCheckListBoxXmlHandler::DoCreateResource()
{
    if (m_class == wxT("wxCheckListBox"))
    {
        // need to build the list of strings from children
        m_insideBox = true;
        CreateChildrenPrivately(NULL, GetParamNode(wxT("content")));

        XRC_MAKE_INSTANCE(control, MaxCheckListBox)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetPosition(), GetSize(),
                        strList,
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());

        // step through children myself (again.)
        wxXmlNode *n = GetParamNode(wxT("content"));
        if (n)
            n = n->GetChildren();
        int i = 0;
        while (n)
        {
            if (n->GetType() != wxXML_ELEMENT_NODE ||
                n->GetName() != wxT("item"))
               { n = n->GetNext(); continue; }

            // checking boolean is a bit ugly here (see GetBool() )
            wxString v = n->GetPropVal(wxT("checked"), wxEmptyString);
            v.MakeLower();
            if (v == wxT("1"))
                control->Check( i, true );

            i++;
            n = n->GetNext();
        }

		control->MaxBind(CB_PREF(wx_wxchecklistbox_wxCheckListBox__xrcNew)(control));

        SetupWindow(control);

        strList.Clear();    // dump the strings

        return control;
    }
    else
    {
        // on the inside now.
        // handle <item checked="boolean">Label</item>

        // add to the list
        wxString str = GetNodeContent(m_node);
        if (m_resource->GetFlags() & wxXRC_USE_LOCALE)
            str = wxGetTranslation(str, m_resource->GetDomain());
        strList.Add(str);
        return NULL;
    }
}

bool MaxCheckListBoxXmlHandler::CanHandle(wxXmlNode *node)
{
    return (IsOfClass(node, wxT("wxCheckListBox")) ||
           (m_insideBox && node->GetName() == wxT("item")));
}

// *********************************************

BEGIN_EVENT_TABLE(MaxCheckListBox, wxCheckListBox)
END_EVENT_TABLE()

MaxCheckListBox * bmx_wxchecklistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxCheckListBox(maxHandle, parent, id, bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

void bmx_wxchecklistbox_check(wxCheckListBox * listbox, int item, int check) {
	listbox->Check(item, static_cast<bool>(check));
}

int bmx_wxchecklistbox_ischecked(wxCheckListBox * listbox, int item) {
	return static_cast<int>(listbox->IsChecked(item));
}

int bmx_wxchecklistbox_append(wxCheckListBox * listbox, BBString * item) {
	return listbox->Append(wxStringFromBBString(item));
}

int bmx_wxchecklistbox_geteventtype(int type) {
	switch(type) {
		case 6: return wxEVT_COMMAND_CHECKLISTBOX_TOGGLED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxchecklistbox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxCheckListBoxXmlHandler);
}
