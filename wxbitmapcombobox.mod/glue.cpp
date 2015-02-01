/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

MaxBitmapComboBox::MaxBitmapComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxBitmapComboBox(parent, id, value, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxBitmapComboBox::MaxBitmapComboBox()
{}

MaxBitmapComboBox::~MaxBitmapComboBox() {
	wxunbind(this);
}

void MaxBitmapComboBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxBitmapComboBoxXmlHandler, wxBitmapComboBoxXmlHandler)

MaxBitmapComboBoxXmlHandler::MaxBitmapComboBoxXmlHandler()
	: wxBitmapComboBoxXmlHandler(), m_combobox(NULL) ,m_isInside(false)
{}


wxObject * MaxBitmapComboBoxXmlHandler::DoCreateResource()
{
    if (m_class == wxT("ownerdrawnitem"))
    {
        wxCHECK_MSG(m_combobox, NULL, wxT("Incorrect syntax of XRC resource: ownerdrawnitem not within a bitmapcombobox!"));

        m_combobox->Append(GetText(wxT("text")), GetBitmap(wxT("bitmap"), wxART_MISSING_IMAGE));

        return m_combobox;
    }
    else /*if( m_class == wxT("wxBitmapComboBox"))*/
    {
        // find the selection
        long selection = GetLong( wxT("selection"), -1 );

        XRC_MAKE_INSTANCE(control, MaxBitmapComboBox)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetText(wxT("value")),
                        GetPosition(), GetSize(),
                        0,
                        NULL,
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());

		control->MaxBind(CB_PREF(wx_wxbitmapcombobox_wxBitmapComboBox__xrcNew)(control));

        m_isInside = true;
        m_combobox = control;

        wxXmlNode *children_node = GetParamNode(wxT("object"));

        wxXmlNode *n = children_node;

        while (n)
        {
            if ((n->GetType() == wxXML_ELEMENT_NODE) &&
                (n->GetName() == wxT("object")))
            {
                CreateResFromNode(n, control, NULL);
            }
            n = n->GetNext();
        }

        m_isInside = false;
        m_combobox = NULL;

        if (selection != -1)
            control->SetSelection(selection);

        SetupWindow(control);

        return control;
    }
}

bool MaxBitmapComboBoxXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxBitmapComboBox"))) ||
            (m_isInside && IsOfClass(node, wxT("ownerdrawnitem"))));
}

// *********************************************

BEGIN_EVENT_TABLE(MaxBitmapComboBox, wxBitmapComboBox)
END_EVENT_TABLE()

MaxBitmapComboBox * bmx_wxbitmapcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, long style) {
	return new MaxBitmapComboBox(maxHandle, parent, id, wxStringFromBBString(value), bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

int bmx_wxbitmapcombobox_append(wxBitmapComboBox * combobox, BBString * item, MaxBitmap * bitmap, void * clientData) {
	if (bitmap) {
		return combobox->Append(wxStringFromBBString(item), bitmap->Bitmap(), clientData);
	} else {
		return combobox->Append(wxStringFromBBString(item), wxNullBitmap, clientData);
	}
}

void bmx_wxbitmapcombobox_getbitmapsize(wxBitmapComboBox * combobox, int * w, int * h) {
	wxSize s = combobox->GetBitmapSize();
	*w = s.x;
	*h = s.y;
}

MaxBitmap * bmx_wxbitmapcombobox_getitembitmap(wxBitmapComboBox * combobox, unsigned int item) {
	wxBitmap b(combobox->GetItemBitmap(item));
	return new MaxBitmap(b);
}

int bmx_wxbitmapcombobox_insert(wxBitmapComboBox * combobox, unsigned int pos, BBString * item, MaxBitmap * bitmap, void * clientData) {
	if (bitmap) {
		return combobox->Insert(wxStringFromBBString(item), bitmap->Bitmap(), pos, clientData);
	} else {
		return combobox->Insert(wxStringFromBBString(item), wxNullBitmap, pos, clientData);
	}
}

void bmx_wxbitmapcombobox_setitembitmap(wxBitmapComboBox * combobox, unsigned int item, MaxBitmap * bitmap) {
	combobox->SetItemBitmap(item, bitmap->Bitmap());
}

void bmx_wxbitmapcombobox_selectitem(wxBitmapComboBox * combobox, int item) {
	combobox->Select(item);
}

void bmx_wxbitmapcombobox_setselection(wxBitmapComboBox * combobox, int item) {
	combobox->SetSelection(item);
}

int bmx_wxbitmapcombobox_getselection(wxBitmapComboBox * combobox) {
	return combobox->GetSelection();
}

int bmx_wxbitmapcombobox_getcount(wxBitmapComboBox * combobox) {
	return combobox->GetCount();
}

int bmx_wxbitmapcombobox_isempty(wxItemContainerImmutable* combobox) {
	return static_cast<int>(combobox->IsEmpty());
}

void bmx_wxbitmapcombobox_clear(wxBitmapComboBox * combobox) {
	combobox->Clear();
}

void bmx_wxbitmapcombobox_deleteitem(wxBitmapComboBox * combobox, int item) {
	combobox->Delete(item);
}

BBString * bmx_wxbitmapcombobox_getstring(wxBitmapComboBox * combobox, int item) {
	return bbStringFromWxString(combobox->GetString(item));
}

BBArray * bmx_wxbitmapcombobox_getstrings(wxBitmapComboBox * combobox) {
	return wxArrayStringToBBStringArray(combobox->GetStrings());
}

BBString * bmx_wxbitmapcombobox_getstringselection(wxBitmapComboBox * combobox) {
	return bbStringFromWxString(((wxTextEntryBase*)(combobox))->GetStringSelection());
}

// *********************************************

void bmx_wxbitmapcombobox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxBitmapComboBoxXmlHandler);
}

