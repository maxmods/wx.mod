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

MaxRadioButton::MaxRadioButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxRadioButton(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxRadioButton::MaxRadioButton()
{}

MaxRadioButton::~MaxRadioButton() {
	wxunbind(this);
}

void MaxRadioButton::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxRadioButtonXmlHandler, wxRadioButtonXmlHandler)

MaxRadioButtonXmlHandler::MaxRadioButtonXmlHandler()
	: wxRadioButtonXmlHandler()
{}


wxObject * MaxRadioButtonXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxRadioButton)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetText(wxT("label")),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());

	control->MaxBind(_wx_wxradiobutton_wxRadioButton__xrcNew(control));

    control->SetValue(GetBool(wxT("value"), 0));
    SetupWindow(control);

    return control;

}

// *********************************************

MaxRadioButton * bmx_wxradiobutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxRadioButton(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

bool bmx_wxradiobutton_getvalue(wxRadioButton * button) {
	return button->GetValue();
}

void bmx_wxradiobutton_setvalue(wxRadioButton * button, bool value) {
	button->SetValue(value);
}

int bmx_wxradiobutton_geteventtype(int type) {
	switch(type) {
		case 12: return wxEVT_COMMAND_RADIOBUTTON_SELECTED;
	}
	
	return 0;
}

// *********************************************

void bmx_wxradiobutton_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxRadioButtonXmlHandler);
}



