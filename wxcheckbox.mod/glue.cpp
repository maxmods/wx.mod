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

MaxCheckBox::MaxCheckBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxCheckBox(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxCheckBox::MaxCheckBox()
{}

MaxCheckBox::~MaxCheckBox() {
	wxunbind(this);
}

void MaxCheckBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxCheckBoxXmlHandler, wxCheckBoxXmlHandler)

MaxCheckBoxXmlHandler::MaxCheckBoxXmlHandler()
	: wxCheckBoxXmlHandler()
{}

wxObject * MaxCheckBoxXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxCheckBox)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetText(wxT("label")),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());

	control->MaxBind(_wx_wxcheckbox_wxCheckBox__xrcNew(control));

    control->SetValue(GetBool( wxT("checked")));
    SetupWindow(control);

    return control;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxCheckBox, wxCheckBox)
END_EVENT_TABLE()

MaxCheckBox * bmx_wxcheckbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxCheckBox(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

int bmx_wxcheckbox_getvalue(MaxCheckBox * checkbox) {
	return static_cast<int>(checkbox->GetValue());
}

int bmx_wxcheckbox_get3statevalue(MaxCheckBox * checkbox) {
	return checkbox->Get3StateValue();
}

int bmx_wxcheckbox_is3rdstateallowedforuser(MaxCheckBox * checkbox) {
	return static_cast<int>(checkbox->Is3rdStateAllowedForUser());
}

int bmx_wxcheckbox_is3state(MaxCheckBox * checkbox) {
	return static_cast<int>(checkbox->Is3State());
}

int bmx_wxcheckbox_ischecked(MaxCheckBox * checkbox) {
	return static_cast<int>(checkbox->IsChecked());
}

void bmx_wxcheckbox_setvalue(MaxCheckBox * checkbox, int state) {
	checkbox->SetValue(static_cast<bool>(state));
}

void bmx_wxcheckbox_set3statevalue(MaxCheckBox * checkbox, int state) {
	checkbox->Set3StateValue((wxCheckBoxState)state);
}

int bmx_wxcheckbox_geteventtype(int type) {
	switch(type) {
		case 2: return wxEVT_COMMAND_CHECKBOX_CLICKED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxcheckbox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxCheckBoxXmlHandler);
}
