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


MaxChoice::MaxChoice(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxChoice(parent, id, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxChoice::MaxChoice()
{}

MaxChoice::~MaxChoice() {
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

void MaxChoice::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxChoiceXmlHandler, wxChoiceXmlHandler)

MaxChoiceXmlHandler::MaxChoiceXmlHandler()
	: wxChoiceXmlHandler(), m_insideBox(false)
{}


wxObject * MaxChoiceXmlHandler::DoCreateResource()
{
    if( m_class == wxT("wxChoice"))
    {
        // find the selection
        long selection = GetLong(wxT("selection"), -1);

        // need to build the list of strings from children
        m_insideBox = true;
        CreateChildrenPrivately(NULL, GetParamNode(wxT("content")));

        XRC_MAKE_INSTANCE(control, MaxChoice)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetPosition(), GetSize(),
                        strList,
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());


	control->MaxBind(_wx_wxchoice_wxChoice__xrcNew(control));

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

bool MaxChoiceXmlHandler::CanHandle(wxXmlNode *node)
{
    return (IsOfClass(node, wxT("wxChoice")) ||
           (m_insideBox && node->GetName() == wxT("item")));
}


// *********************************************

BEGIN_EVENT_TABLE(MaxChoice, wxChoice)
END_EVENT_TABLE()


MaxChoice * bmx_wxchoice_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxChoice(maxHandle, parent, id, bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

int bmx_wxchoice_getcurrentselection(MaxChoice * choice) {
	return choice->GetCurrentSelection();
}

int bmx_wxchoice_geteventtype(int type) {
	switch(type) {
		case 3: return wxEVT_COMMAND_CHOICE_SELECTED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxchoice_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxChoiceXmlHandler);
}
