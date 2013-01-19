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

MaxBitmapButton::MaxBitmapButton(BBObject * handle, wxWindow * parent, wxWindowID id, const wxBitmap & bitmap, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxBitmapButton(parent, id, bitmap, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxBitmapButton::MaxBitmapButton()
{}

MaxBitmapButton::~MaxBitmapButton() {
	wxunbind(this);
}

void MaxBitmapButton::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxBitmapButtonXmlHandler, wxBitmapButtonXmlHandler)

MaxBitmapButtonXmlHandler::MaxBitmapButtonXmlHandler()
	: wxBitmapButtonXmlHandler()
{}


wxObject * MaxBitmapButtonXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(button, MaxBitmapButton)

    button->Create(m_parentAsWindow,
                   GetID(),
                   GetBitmap(wxT("bitmap"), wxART_BUTTON),
                   GetPosition(), GetSize(),
                   GetStyle(wxT("style"), wxBU_AUTODRAW),
                   wxDefaultValidator,
                   GetName());
    if (GetBool(wxT("default"), 0))
        button->SetDefault();
    SetupWindow(button);

	button->MaxBind(_wx_wxbitmapbutton_wxBitmapButton__xrcNew(button));


    if (GetParamNode(wxT("selected")))
        button->SetBitmapSelected(GetBitmap(wxT("selected")));
    if (GetParamNode(wxT("focus")))
        button->SetBitmapFocus(GetBitmap(wxT("focus")));
    if (GetParamNode(wxT("disabled")))
        button->SetBitmapDisabled(GetBitmap(wxT("disabled")));
    if (GetParamNode(wxT("hover")))
        button->SetBitmapHover(GetBitmap(wxT("hover")));

    return button;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxBitmapButton, wxBitmapButton)
END_EVENT_TABLE()

MaxBitmapButton * bmx_wxbitmapbutton_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, MaxBitmap * bitmap, int x, int y,
		int w, int h, long style) {

	return new MaxBitmapButton(maxHandle, parent, id, bitmap->Bitmap(), x, y, w, h, style);
}

void bmx_wxbitmapbutton_setbitmaplabel(wxBitmapButton * button, MaxBitmap * bitmap) {
	button->SetBitmapLabel(bitmap->Bitmap());
}

MaxBitmap * bmx_wxbitmapbutton_getbitmapdisabled(wxBitmapButton * button) {
	wxBitmap b(button->GetBitmapDisabled());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmapbutton_getbitmapfocus(wxBitmapButton * button) {
	wxBitmap b(button->GetBitmapFocus());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmapbutton_getbitmaphover(wxBitmapButton * button) {
	wxBitmap b(button->GetBitmapHover());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmapbutton_getbitmaplabel(wxBitmapButton * button) {
	wxBitmap b(button->GetBitmapLabel());
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmapbutton_getbitmapselected(wxBitmapButton * button) {
	wxBitmap b(button->GetBitmapSelected());
	return new MaxBitmap(b);
}

void bmx_wxbitmapbutton_setbitmapdisabled(wxBitmapButton * button, MaxBitmap * bitmap) {
	button->SetBitmapDisabled(bitmap->Bitmap());
}

void bmx_wxbitmapbutton_setbitmapfocus(wxBitmapButton * button, MaxBitmap * bitmap) {
	button->SetBitmapFocus(bitmap->Bitmap());
}

void bmx_wxbitmapbutton_setbitmaphover(wxBitmapButton * button, MaxBitmap * bitmap) {
	button->SetBitmapHover(bitmap->Bitmap());
}

void bmx_wxbitmapbutton_setbitmapselected(wxBitmapButton * button, MaxBitmap * bitmap) {
	button->SetBitmapSelected(bitmap->Bitmap());
}

// *********************************************

void bmx_wxbitmapbutton_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxBitmapButtonXmlHandler);
}

