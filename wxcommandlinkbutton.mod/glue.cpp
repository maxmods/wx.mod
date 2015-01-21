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

MaxCommandLinkButton::MaxCommandLinkButton(BBObject * handle, wxWindow * parent, wxWindowID id, BBString * mainLabel, BBString * note, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxCommandLinkButton(parent, id, wxStringFromBBString(mainLabel), wxStringFromBBString(note), wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxCommandLinkButton::MaxCommandLinkButton()
{}

MaxCommandLinkButton::~MaxCommandLinkButton() {
	wxunbind(this);
}

void MaxCommandLinkButton::MaxBind(BBObject * handle) {
	maxHandle = handle;
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxCommandLinkButtonXmlHandler, wxCommandLinkButtonXmlHandler)

MaxCommandLinkButtonXmlHandler::MaxCommandLinkButtonXmlHandler()
	: wxCommandLinkButtonXmlHandler()
{}


wxObject * MaxCommandLinkButtonXmlHandler::DoCreateResource()
{
   XRC_MAKE_INSTANCE(button, MaxCommandLinkButton)

   button->Create(m_parentAsWindow,
                    GetID(),
                    GetText(wxS("label")),
                    GetText(wxS("note")),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());

	button->MaxBind(CB_PREF(wx_wxcommandlinkbutton_wxCommandLinkButton__xrcNew)(button));

    SetupWindow(button);

    return button;
}


// *********************************************

BEGIN_EVENT_TABLE(MaxCommandLinkButton, wxCommandLinkButton)
END_EVENT_TABLE()

MaxCommandLinkButton * bmx_wxcommandlinkbutton_create(BBObject * handle, wxWindow * parent, int id, BBString * mainLabel, BBString * note, int x, int y, int w, int h, int style) {
	return new MaxCommandLinkButton(handle, parent, id, mainLabel, note, x, y, w, h, style);
}

void bmx_wxcommandlinkbutton_setlabel(wxCommandLinkButton * button, BBString * label) {
	button->SetLabel(wxStringFromBBString(label));
}

BBString * bmx_wxcommandlinkbutton_getlabel(wxCommandLinkButton * button) {
	return bbStringFromWxString(button->GetLabel());
}

void bmx_wxcommandlinkbutton_setmainlabel(wxCommandLinkButton * button, BBString * mainLabel) {
	button->SetMainLabel(wxStringFromBBString(mainLabel));
}

void bmx_wxcommandlinkbutton_setnote(wxCommandLinkButton * button, BBString * note) {
	button->SetNote(wxStringFromBBString(note));
}

BBString * bmx_wxcommandlinkbutton_getmainlabel(wxCommandLinkButton * button) {
	return bbStringFromWxString(button->GetMainLabel());
}

BBString * bmx_wxcommandlinkbutton_getnote(wxCommandLinkButton * button) {
	return bbStringFromWxString(button->GetNote());
}


// *********************************************

void bmx_wxcommandlinkbutton_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxCommandLinkButtonXmlHandler);
}
