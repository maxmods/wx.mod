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

MaxPropertyGrid::MaxPropertyGrid(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: wxPropertyGrid(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxPropertyGrid::~MaxPropertyGrid() {
	wxunbind(this);
}

MaxPGId::MaxPGId(const wxPGId& p)
{
	pgId = wxPGId(p);
}

wxPGId & MaxPGId::PGId() {
	return pgId;
}

MaxColourPropertyValue::MaxColourPropertyValue(const wxColourPropertyValue& v)
{
	value = wxColourPropertyValue(v);
}

wxColourPropertyValue & MaxColourPropertyValue::Value() {
	return value;
}

// *********************************************

wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxPropertyGrid(handle, parent, id, x, y, w, h, style);
}

MaxPGId * bmx_wxpropertygrid_append(wxPropertyGrid * grid, wxPGProperty * property) {
	return new MaxPGId(grid->Append(property));
}

wxPropertyGrid * bmx_wxpropertygrid_getgrid(wxPropertyGrid * grid) {
	return grid->GetGrid();
}

MaxColour * bmx_wxpropertygrid_getcaptionbackgroundcolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetCaptionBackgroundColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getcaptionforegroundcolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetCaptionForegroundColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getcellbackgroundcolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetCellBackgroundColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getcelldisabledtextcolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetCellDisabledTextColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getcelltextcolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetCellTextColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getlinecolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetLineColour());
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getmargincolour(wxPropertyGrid * grid) {
	wxColour c(grid->GetMarginColour());
	return new MaxColour(c);
}


// *********************************************

wxPGProperty * bmx_wxstringproperty_create(BBString * label, BBString * name, BBString * value) {
	if (name != &bbEmptyString) {
		return new wxStringProperty(wxStringFromBBString(label), wxStringFromBBString(name), wxStringFromBBString(value));
	} else {
		return new wxStringProperty(wxStringFromBBString(label), wxPG_LABEL, wxStringFromBBString(value));
	}
}
	
// *********************************************

wxPGProperty * bmx_wxpropertycategory_create(BBString * label, BBString * name) {
	if (name != &bbEmptyString) {
		return new wxPropertyCategory(wxStringFromBBString(label), wxStringFromBBString(name));
	} else {
		return new wxPropertyCategory(wxStringFromBBString(label));
	}
}

// *********************************************

wxPGProperty * bmx_wxfontproperty_create(BBString * label, BBString * name, MaxFont * font) {
	return new wxFontProperty(wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxPG_LABEL,
		(font) ? font->Font() : wxFont());
}

// *********************************************

void bmx_wxpropertycontainermethods_setpropertyhelpstringid(wxPropertyContainerMethods * prop, MaxPGId * id, BBString * helpString) {
	prop->SetPropertyHelpString(id->PGId(), wxStringFromBBString(helpString));
}

void bmx_wxpropertycontainermethods_setpropertyhelpstring(wxPropertyContainerMethods * prop, BBString * name, BBString * helpString) {
	prop->SetPropertyHelpString(wxStringFromBBString(name), wxStringFromBBString(helpString));
}

// *********************************************

wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBString * label, BBString * name, MaxColour * value) {
	return new wxSystemColourProperty(wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxPG_LABEL,
		(value) ? value->Colour() : wxColour());
}

// *********************************************

void bmx_wxcolourpropertyvalue_delete(MaxColourPropertyValue * value) {
	delete value;
}

// *********************************************

void bmx_wxpgid_delete(MaxPGId * id) {
	delete id;
}

