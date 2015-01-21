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

MaxToggleButton::MaxToggleButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxToggleButton(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxToggleButton::MaxToggleButton()
{}

MaxToggleButton::~MaxToggleButton() {
	wxunbind(this);
}

void MaxToggleButton::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxToggleButtonXmlHandler, wxToggleButtonXmlHandler)

MaxToggleButtonXmlHandler::MaxToggleButtonXmlHandler()
	: wxToggleButtonXmlHandler()
{}


wxObject * MaxToggleButtonXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxToggleButton)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetText(wxT("label")),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());

	control->MaxBind(CB_PREF(wx_wxtogglebutton_wxToggleButton__xrcNew)(control));

    control->SetValue(GetBool( wxT("checked")));
    SetupWindow(control);

    return control;
}


// *********************************************

BEGIN_EVENT_TABLE(MaxToggleButton, wxToggleButton)
END_EVENT_TABLE()

MaxToggleButton * bmx_wxtogglebutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxToggleButton(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

int bmx_wxtogglebutton_getvalue(wxToggleButton * button) {
	return static_cast<int>(button->GetValue());
}

void bmx_wxtogglebutton_setvalue(wxToggleButton * button, int state) {
	button->SetValue(static_cast<bool>(state));
}

int bmx_wxtogglebutton_geteventtype(int type) {
	switch(type) {
		case 19: return wxEVT_COMMAND_TOGGLEBUTTON_CLICKED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxtogglebutton_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxToggleButtonXmlHandler);
}

