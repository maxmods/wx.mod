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

MaxSpinButton::MaxSpinButton(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSpinButton(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSpinButton::MaxSpinButton()
{}

MaxSpinButton::~MaxSpinButton() {
	wxunbind(this);
}

void MaxSpinButton::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxSpinButtonXmlHandler, wxSpinButtonXmlHandler)

MaxSpinButtonXmlHandler::MaxSpinButtonXmlHandler()
	: wxSpinButtonXmlHandler()
{}


wxObject * MaxSpinButtonXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxSpinButton)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetPosition(), GetSize(),
                    GetStyle(wxT("style"), wxSP_VERTICAL | wxSP_ARROW_KEYS),
                    GetName());

	control->MaxBind(_wx_wxspinbutton_wxSpinButton__xrcNew(control));

    control->SetValue(GetLong( wxT("value"), 0));
    control->SetRange(GetLong( wxT("min"), 0),
                      GetLong(wxT("max"), 100));
    SetupWindow(control);

    return control;
}


// *********************************************

BEGIN_EVENT_TABLE(MaxSpinButton, wxSpinButton)
END_EVENT_TABLE()

MaxSpinButton * bmx_wxspinbutton_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSpinButton(handle, parent, id, x, y, w, h, style);
}

int bmx_wxspinbutton_getmax(wxSpinButton * button) {
	return button->GetMax();
}

int bmx_wxspinbutton_getmin(wxSpinButton * button) {
	return button->GetMin();
}

int bmx_wxspinbutton_getvalue(wxSpinButton * button) {
	return button->GetValue();
}

void bmx_wxspinbutton_setrange(wxSpinButton * button, int minValue, int maxValue) {
	button->SetRange(minValue, maxValue);
}

void bmx_wxspinbutton_setvalue(wxSpinButton * button, int value) {
	button->SetValue(value);
}



int bmx_wxspinevent_getposition(wxSpinEvent & event) {
	return event.GetPosition();
}

void bmx_wxspinevent_setposition(wxSpinEvent & event, int pos) {
	event.SetPosition(pos);
}


int bmx_wxspinbutton_geteventtype(int type) {

	switch(type) {
		case -302: return wxEVT_SCROLL_LINEUP;
		case -303: return wxEVT_SCROLL_LINEDOWN;
		case -306: return wxEVT_SCROLL_THUMBTRACK;
	}
	return 0;
}

// *********************************************

void bmx_wxspinbutton_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxSpinButtonXmlHandler);
}

