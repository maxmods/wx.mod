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

MaxStdDialogButtonSizer::MaxStdDialogButtonSizer(BBObject * handle)
	: maxHandle(handle), wxStdDialogButtonSizer()
{
	wxbind(this, handle);
}

MaxStdDialogButtonSizer::MaxStdDialogButtonSizer()
{}

MaxStdDialogButtonSizer::~MaxStdDialogButtonSizer() {
	wxunbind(this);
}

void MaxStdDialogButtonSizer::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxStdDialogButtonSizerXmlHandler, wxStdDialogButtonSizerXmlHandler)

MaxStdDialogButtonSizerXmlHandler::MaxStdDialogButtonSizerXmlHandler()
	: m_isInside(false)
{}


wxObject * MaxStdDialogButtonSizerXmlHandler::DoCreateResource()
{
    if (m_class == wxT("wxStdDialogButtonSizer"))
    {
        wxASSERT( !m_parentSizer );

        MaxStdDialogButtonSizer *s = new MaxStdDialogButtonSizer;
	   m_parentSizer = s;
	
        m_isInside = true;

		s->MaxBind(_wx_wxstddialogbuttonsizer_wxStdDialogButtonSizer__xrcNew(s));

        CreateChildren(m_parent, true/*only this handler*/);

        m_parentSizer->Realize();

        m_isInside = false;
        m_parentSizer = NULL;

        return s;
    }
    else // m_class == "button"
    {
        wxASSERT( m_parentSizer );

        // find the item to be managed by this sizeritem
        wxXmlNode *n = GetParamNode(wxT("object"));
        if ( !n )
            n = GetParamNode(wxT("object_ref"));

        // did we find one?
        if (n)
        {
            wxObject *item = CreateResFromNode(n, m_parent, NULL);
            wxButton *button = wxDynamicCast(item, wxButton);

            if (button)
                m_parentSizer->AddButton(button);
            else
                wxLogError(wxT("Error in resource - expected button."));

            return item;
        }
        else /*n == NULL*/
        {
            wxLogError(wxT("Error in resource: no button within wxStdDialogButtonSizer."));
            return NULL;
        }
    }
}

bool MaxStdDialogButtonSizerXmlHandler::CanHandle(wxXmlNode *node)
{
    return (!m_isInside && IsOfClass(node, wxT("wxStdDialogButtonSizer"))) ||
           (m_isInside && IsOfClass(node, wxT("button")));
}

// *********************************************

wxStdDialogButtonSizer * bmx_wxstddialogbuttonsizer_create(BBObject * handle) {
	return new MaxStdDialogButtonSizer(handle);
}

void bmx_wxstddialogbuttonsizer_addbutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->AddButton(button);
}

void bmx_wxstddialogbuttonsizer_realize(wxStdDialogButtonSizer * sizer) {
	sizer->Realize();
}

void bmx_wxstddialogbuttonsizer_setaffirmativebutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetAffirmativeButton(button);
}

void bmx_wxstddialogbuttonsizer_setcancelbutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetCancelButton(button);
}

void bmx_wxstddialogbuttonsizer_setnegativebutton(wxStdDialogButtonSizer * sizer, wxButton * button) {
	sizer->SetNegativeButton(button);
}

// *********************************************

void bmx_wxstddialogbuttonsizer_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxStdDialogButtonSizerXmlHandler);
}

