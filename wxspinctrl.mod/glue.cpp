/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxSpinCtrl::MaxSpinCtrl(BBObject * handle, wxWindow* parent, wxWindowID id, const wxString& value, int x, int y,
		int w, int h, long style, int min, int max, int initial)
	: wxSpinCtrl(parent, id, value, wxPoint(x, y), wxSize(w, h), style, min, max, initial)
{
	wxbind(this, handle);
}

MaxSpinCtrl::MaxSpinCtrl()
{}

MaxSpinCtrl::~MaxSpinCtrl() {
	wxunbind(this);
}

void MaxSpinCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxSpinCtrlXmlHandler, wxSpinCtrlXmlHandler)

MaxSpinCtrlXmlHandler::MaxSpinCtrlXmlHandler()
	: wxSpinCtrlXmlHandler()
{}


wxObject * MaxSpinCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxSpinCtrl)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetText(wxT("value")),
                    GetPosition(), GetSize(),
                    GetStyle(wxT("style"), wxSP_ARROW_KEYS),
                    GetLong(wxT("min"), 0),
                    GetLong(wxT("max"), 100),
                    GetLong(wxT("value"), 0),
                    GetName());

	control->MaxBind(_wx_wxspinctrl_wxSpinCtrl__xrcNew(control));

    SetupWindow(control);

    return control;
}


// *********************************************

BEGIN_EVENT_TABLE(MaxSpinCtrl, wxSpinCtrl)
END_EVENT_TABLE()

MaxSpinCtrl * bmx_wxspinctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y,
		int w, int h, long style, int min, int max, int initial) {

	return new MaxSpinCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, min, max, initial);
}


void bmx_wxspinctrl_setvalue(wxSpinCtrl * spin, int value) {
	spin->SetValue(value);
}

void bmx_wxspinctrl_settextvalue(wxSpinCtrl * spin, BBString * value) {
	spin->SetValue(wxStringFromBBString(value));
}

int bmx_wxspinctrl_getvalue(wxSpinCtrl * spin) {
	return spin->GetValue();
}

void bmx_wxspinctrl_setrange(wxSpinCtrl * spin, int minVal, int maxVal) {
	spin->SetRange(minVal, maxVal);
}

void bmx_wxspinctrl_setselection(wxSpinCtrl * spin, int fromPos, int toPos) {
	spin->SetSelection(fromPos, toPos);
}

int bmx_wxspinctrl_getmin(wxSpinCtrl * spin) {
	return spin->GetMin();
}

int bmx_wxspinctrl_getmax(wxSpinCtrl * spin) {
	return spin->GetMax();
}




int bmx_wxspinctrl_geteventtype(int type) {

	switch(type) {
		case 18: return wxEVT_COMMAND_SPINCTRL_UPDATED;
	}
	return 0;
}

// *********************************************

void bmx_wxspinctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxSpinCtrlXmlHandler);
}

