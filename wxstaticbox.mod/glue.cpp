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

MaxStaticBox::MaxStaticBox(void * handle, wxWindow * parent, wxWindowID id, const wxString& label, int x, int y,
		int w, int h, long style)
	: wxStaticBox(parent, id, label, wxPoint(x, y), wxSize(w, h), style)
{
}

MaxStaticBox::MaxStaticBox()
{}

void MaxStaticBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxStaticBoxXmlHandler, wxStaticBoxXmlHandler)

MaxStaticBoxXmlHandler::MaxStaticBoxXmlHandler()
	: wxStaticBoxXmlHandler()
{}


wxObject * MaxStaticBoxXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(box, MaxStaticBox)

    box->Create(m_parentAsWindow,
                GetID(),
                GetText(wxT("label")),
                GetPosition(), GetSize(),
                GetStyle(),
                GetName());

	box->MaxBind(_wx_wxstaticbox_wxStaticBox__xrcNew(box));
    SetupWindow(box);

    return box;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxStaticBox, wxStaticBox)
END_EVENT_TABLE()

MaxStaticBox * bmx_wxstaticbox_create(void * maxHandle, wxWindow * parent, wxWindowID id, BBString * label, int x, int y,
		int w, int h, long style) {

	return new MaxStaticBox(maxHandle, parent, id, wxStringFromBBString(label), x, y, w, h, style);
}

// *********************************************

void bmx_wxstaticbox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxStaticBoxXmlHandler);
}

