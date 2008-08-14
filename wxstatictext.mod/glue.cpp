/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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

MaxStaticText::MaxStaticText(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxStaticText(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxStaticText::MaxStaticText()
{}

MaxStaticText::~MaxStaticText() {
	wxunbind(this);
}

void MaxStaticText::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxStaticTextXmlHandler, wxStaticTextXmlHandler)

MaxStaticTextXmlHandler::MaxStaticTextXmlHandler()
	: wxStaticTextXmlHandler()
{}


wxObject * MaxStaticTextXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(text, MaxStaticText)

    text->Create(m_parentAsWindow,
                 GetID(),
                 GetText(wxT("label")),
                 GetPosition(), GetSize(),
                 GetStyle(),
                 GetName());

    SetupWindow(text);

	text->MaxBind(_wx_wxstatictext_wxStaticText__xrcNew(text));

    long wrap = GetLong(wxT("wrap"), -1);
    if (wrap != -1)
        text->Wrap(wrap);

    return text;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxStaticText, wxStaticText)
END_EVENT_TABLE()

MaxStaticText * bmx_wxstatictext_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxStaticText(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

BBString * bmx_wxstatictext_getlabel(wxStaticText * text) {
	return bbStringFromWxString(text->GetLabel());
}

void bmx_wxstatictext_setlabel(wxStaticText * text, BBString * label) {
	text->SetLabel(wxStringFromBBString(label));
}

void bmx_wxstatictext_wrap(wxStaticText * text, int width) {
	text->Wrap(width);
}

// *********************************************

void bmx_wxstatictext_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxStaticTextXmlHandler);
}

