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

MaxPGPropArg::MaxPGPropArg(wxPGPropArg p)
{
	pgId = wxPGPropArg(p);
}

wxPGPropArgCls & MaxPGPropArg::PGId() {
	return pgId;
}

MaxColourPropertyValue::MaxColourPropertyValue(const wxColourPropertyValue& v)
{
	value = wxColourPropertyValue(v);
}

wxColourPropertyValue & MaxColourPropertyValue::Value() {
	return value;
}

MaxPGChoices::MaxPGChoices(const wxPGChoices & c)
	: choices(c)
{
}

MaxPGChoices::MaxPGChoices()
{
}

wxPGChoices & MaxPGChoices::Choices() {
	return choices;
}

MaxPGChoiceEntry::MaxPGChoiceEntry(const wxPGChoiceEntry & e)
	: entry(e)
{
}

wxPGChoiceEntry & MaxPGChoiceEntry::Entry() {
	return entry;
}

MaxPropertyCategory::MaxPropertyCategory(BBObject * handle, const wxString &label, const wxString &name)
	: wxPropertyCategory(label, name)
{
	wxbind(this, handle);
}
MaxPropertyCategory::~MaxPropertyCategory() {
	wxunbind(this);
}

MaxStringProperty::MaxStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value)
	: wxStringProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxStringProperty::~MaxStringProperty() {
	wxunbind(this);
}

MaxFontProperty::MaxFontProperty(BBObject * handle, const wxString &label, const wxString &name, const wxFont &value)
	: wxFontProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxFontProperty::~MaxFontProperty() {
	wxunbind(this);
}

MaxSystemColourProperty::MaxSystemColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value)
	: wxSystemColourProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxSystemColourProperty::~MaxSystemColourProperty() {
	wxunbind(this);
}

MaxIntProperty::MaxIntProperty(BBObject * handle, const wxString &label, const wxString &name, long value)
	: wxIntProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxIntProperty::~MaxIntProperty() {
	wxunbind(this);
}

MaxUIntProperty::MaxUIntProperty(BBObject * handle, const wxString &label, const wxString &name, unsigned long value)
	: wxUIntProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxUIntProperty::~MaxUIntProperty() {
	wxunbind(this);
}

MaxFloatProperty::MaxFloatProperty(BBObject * handle, const wxString &label, const wxString &name, double value)
	: wxFloatProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxFloatProperty::~MaxFloatProperty() {
	wxunbind(this);
}

MaxBoolProperty::MaxBoolProperty(BBObject * handle, const wxString &label, const wxString &name, bool value)
	: wxBoolProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxBoolProperty::~MaxBoolProperty() {
	wxunbind(this);
}

MaxFlagsProperty::MaxFlagsProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value)
	: wxFlagsProperty(label, name, labels, values, value)
{
	wxbind(this, handle);
}
MaxFlagsProperty::~MaxFlagsProperty() {
	wxunbind(this);
}

MaxFileProperty::MaxFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value)
	: wxFileProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxFileProperty::~MaxFileProperty() {
	wxunbind(this);
}

MaxLongStringProperty::MaxLongStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value)
	: wxLongStringProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxLongStringProperty::~MaxLongStringProperty() {
	wxunbind(this);
}

MaxDirProperty::MaxDirProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value)
	: wxDirProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxDirProperty::~MaxDirProperty() {
	wxunbind(this);
}

MaxArrayStringProperty::MaxArrayStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &value)
	: wxArrayStringProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxArrayStringProperty::~MaxArrayStringProperty() {
	wxunbind(this);
}

MaxCursorProperty::MaxCursorProperty(BBObject * handle, const wxString &label, const wxString &name, int value)
	: wxCursorProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxCursorProperty::~MaxCursorProperty() {
	wxunbind(this);
}

MaxImageFileProperty::MaxImageFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value)
	: wxImageFileProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxImageFileProperty::~MaxImageFileProperty() {
	wxunbind(this);
}

MaxDateProperty::MaxDateProperty(BBObject * handle, const wxString &label, const wxString &name, const wxDateTime &value)
	: wxDateProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxDateProperty::~MaxDateProperty() {
	wxunbind(this);
}

MaxEnumProperty::MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value)
	: wxEnumProperty(label, name, labels, values, value)
{
	wxbind(this, handle);
}
MaxEnumProperty::MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, int value)
	: wxEnumProperty(label, name, choices, value)
{
	wxbind(this, handle);
}
MaxEnumProperty::~MaxEnumProperty() {
	wxunbind(this);
}

MaxMultiChoiceProperty::MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayString &value)
	: wxMultiChoiceProperty(label, name, labels, value)
{
	wxbind(this, handle);
}
MaxMultiChoiceProperty::MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, const wxArrayString &value)
	: wxMultiChoiceProperty(label, name, choices, value)
{
	wxbind(this, handle);
}
MaxMultiChoiceProperty::~MaxMultiChoiceProperty() {
	wxunbind(this);
}

MaxColourProperty::MaxColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value)
	: wxColourProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxColourProperty::~MaxColourProperty() {
	wxunbind(this);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxPropertyGrid, wxPropertyGrid)
END_EVENT_TABLE()

wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxPropertyGrid(handle, parent, id, x, y, w, h, style);
}

wxPGProperty * bmx_wxpropertycontainermethods_append(wxPropertyContainerMethods * prop, wxPGProperty * property) {
	return prop->Append(property);
}

wxPGProperty * bmx_wxpropertygrid_append(wxPropertyGrid * prop, wxPGProperty * property) {
	return prop->Append(property);
}

wxPGProperty * bmx_wxpropertygrid_appendin(wxPropertyGrid * prop, wxPGProperty * parent, wxPGProperty * newproperty) {
	return prop->AppendIn(parent, newproperty);
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

wxPGProperty * bmx_wxstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxStringProperty( handle,
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}
	
// *********************************************

wxPGProperty * bmx_wxpropertycategory_create(BBObject * handle, BBString * label, BBString * name) {
	return new MaxPropertyCategory( handle,
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME") );
}

// *********************************************

wxPGProperty * bmx_wxfontproperty_create(BBObject * handle, BBString * label, BBString * name, MaxFont * font) {
	return new MaxFontProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(font) ? font->Font() : wxFont());
}

// *********************************************

void bmx_wxpropertygrid_setpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop ,BBString * helpString) {
	grid->SetPropertyHelpString(prop, wxStringFromBBString(helpString));
}

void bmx_wxpropertygrid_setpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name, BBString * helpString) {
	grid->SetPropertyHelpString(wxStringFromBBString(name), wxStringFromBBString(helpString));
}


MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolour(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxColour c(grid->GetPropertyBackgroundColour(prop));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertycolour(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxColour c(grid->GetPropertyColour(prop));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertytextcolour(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxColour c(grid->GetPropertyTextColour(prop));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxPropertyGrid * grid, BBString * name) {
	wxColour c(grid->GetPropertyBackgroundColour(wxStringFromBBString(name)));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertycolourbyname(wxPropertyGrid * grid, BBString * name) {
	wxColour c(grid->GetPropertyColour(wxStringFromBBString(name)));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertytextcolourbyname(wxPropertyGrid * grid, BBString * name) {
	wxColour c(grid->GetPropertyTextColour(wxStringFromBBString(name)));
	return new MaxColour(c);
}

void bmx_wxpropertygrid_beginaddchildren(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->BeginAddChildren(prop);
}

void bmx_wxpropertygrid_beginaddchildrenbyname(wxPropertyGrid * grid, BBString * name) {
	grid->BeginAddChildren(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_clearpropertyvalue(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->ClearPropertyValue(prop);
}

bool bmx_wxpropertygrid_clearpropertyvaluebyname(wxPropertyGrid * grid, BBString * name) {
	return grid->ClearPropertyValue(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_clearselection(wxPropertyGrid * grid) {
	return grid->ClearSelection();
}

bool bmx_wxpropertygrid_collapse(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->Collapse(prop);
}

bool bmx_wxpropertygrid_collapsebyname(wxPropertyGrid * grid, BBString * name) {
	return grid->Collapse(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_deleteproperty(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->DeleteProperty(prop);
}

void bmx_wxpropertygrid_deletepropertybyname(wxPropertyGrid * grid, BBString * name) {
	grid->DeleteProperty(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_deletepropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, int index) {
	grid->DeletePropertyChoice(prop, index);
}

void bmx_wxpropertygrid_deletepropertychoicebyname(wxPropertyGrid * grid, BBString * name, int index) {
	grid->DeletePropertyChoice(wxStringFromBBString(name), index);
}

bool bmx_wxpropertygrid_disableproperty(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->DisableProperty(prop);
}

bool bmx_wxpropertygrid_disablepropertybyname(wxPropertyGrid * grid, BBString * name) {
	return grid->DisableProperty(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_enableproperty(wxPropertyGrid * grid, wxPGProperty * prop, bool enable) {
	return grid->EnableProperty(prop, enable);
}

bool bmx_wxpropertygrid_enablepropertybyname(wxPropertyGrid * grid, BBString * name, bool enable) {
	return grid->EnableProperty(wxStringFromBBString(name), enable);
}

void bmx_wxpropertygrid_endaddchildren(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->EndAddChildren(prop);
}

void bmx_wxpropertygrid_endaddchildrenbyname(wxPropertyGrid * grid, BBString * name) {
	grid->EndAddChildren(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_setpropertyattribute(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, int value, int argFlags) {
	grid->SetPropertyAttribute(prop, wxStringFromBBString(attrName), value, argFlags);
}

void bmx_wxpropertygrid_setpropertyattributebyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, int value, int argFlags) {
	grid->SetPropertyAttribute(wxStringFromBBString(name), wxStringFromBBString(attrName), value, argFlags);
}

void bmx_wxpropertygrid_setpropertyattributestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, BBString * value, int argFlags) {
	grid->SetPropertyAttribute(prop, wxStringFromBBString(attrName), wxStringFromBBString(value), argFlags);
}

void bmx_wxpropertygrid_setpropertyattributestringbyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, BBString * value, int argFlags) {
	grid->SetPropertyAttribute(wxStringFromBBString(name), wxStringFromBBString(attrName), wxStringFromBBString(value), argFlags);
}

bool bmx_wxpropertygrid_expand(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->Expand(prop);
}

bool bmx_wxpropertygrid_expandbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->Expand(wxStringFromBBString(name));
}

wxPGProperty * bmx_wxpropertygrid_getfirst(wxPropertyGrid * grid, int flags) {
	return grid->GetFirst(flags);
}

MaxPGChoices * bmx_wxpropertygrid_getpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop) {
	return new MaxPGChoices(grid->GetPropertyChoices(prop));
}

BBString * bmx_wxpropertygrid_getpropertyclassname(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyClassName(prop));
}

BBObject * bmx_wxpropertygrid_getpropertyclientdata(wxPropertyGrid * grid, wxPGProperty * prop) {
	void * data = grid->GetPropertyClientData(prop);
	if (data) {
		return (BBObject*)data;
	} else {
	 return &bbNullObject;
	}
}

const wxPGEditor * bmx_wxpropertygrid_getpropertyeditor(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyEditor(prop);
}

BBString * bmx_wxpropertygrid_getpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyHelpString(prop));
}

MaxBitmap * bmx_wxpropertygrid_getpropertyimage(wxPropertyGrid * grid, wxPGProperty * prop) {
	return new MaxBitmap(*grid->GetPropertyImage(prop));
}

unsigned int bmx_wxpropertygrid_getpropertyindex(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyIndex(prop);
}

BBString * bmx_wxpropertygrid_getpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyLabel(prop));
}

BBString * bmx_wxpropertygrid_getpropertyname(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyName(prop));
}

wxPGProperty * bmx_wxpropertygrid_getpropertyparent(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyParent(prop);
}

bool bmx_wxpropertygrid_setpropertymaxlength(wxPropertyGrid * grid, wxPGProperty * prop, int maxLen) {
	return grid->SetPropertyMaxLength(prop, maxLen);
}

bool bmx_wxpropertygrid_setpropertymaxlengthbyname(wxPropertyGrid * grid, BBString * name, int maxLen) {
	return grid->SetPropertyMaxLength(wxStringFromBBString(name), maxLen);
}

// *********************************************

wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value) {
	return new MaxSystemColourProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value) ? value->Colour() : wxColour());
}

// *********************************************

wxIntProperty * bmx_wxintproperty_create(BBObject * handle, BBString * label, BBString * name, int value) {
	return new MaxIntProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		value);
}

// *********************************************

wxUIntProperty * bmx_wxuintproperty_create(BBObject * handle, BBString * label, BBString * name, unsigned long value) {
	return new MaxUIntProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		value);
}

// *********************************************

wxFloatProperty * bmx_wxdoubleproperty_create(BBObject * handle, BBString * label, BBString * name, double value) {
	return new MaxFloatProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		value);
}

// *********************************************

wxBoolProperty * bmx_wxboolproperty_create(BBObject * handle, BBString * label, BBString * name, bool value) {
	return new MaxBoolProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		value);
}

// *********************************************

wxCursorProperty * bmx_wxcursorproperty_create(BBObject * handle, BBString * label, BBString * name, int value) {
	return new MaxCursorProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		value);
}

// *********************************************

wxImageFileProperty * bmx_wximagefileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxImageFileProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxDateProperty * bmx_wxdateproperty_create(BBObject * handle, BBString * label, BBString * name, MaxDateTime * value) {
	return new MaxDateProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value) ? value->DateTime(): wxDateTime());
}

// *********************************************

wxFlagsProperty * bmx_wxflagsproperty_create(BBObject * handle, BBString * label, BBString * name,
		BBArray * labels, BBArray * values, int value) {
	return new MaxFlagsProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(values) ? bbIntArrayTowxArrayInt(values) : wxArrayInt(),
		value);
}

// *********************************************

wxFileProperty * bmx_wxfileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxFileProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxLongStringProperty * bmx_wxlongstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxLongStringProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxDirProperty * bmx_wxdirproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxDirProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxArrayStringProperty * bmx_wxarraystringproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * value) {
	return new MaxArrayStringProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		bbStringArrayTowxArrayStr(value));
}

// *********************************************

wxColourProperty * bmx_wxcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value) {
	return new MaxColourProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(value) ? value->Colour() : wxColour());
}

// *********************************************

void bmx_wxcolourpropertyvalue_delete(MaxColourPropertyValue * value) {
	delete value;
}

// *********************************************

void bmx_wxpgproparg_delete(MaxPGPropArg * id) {
	delete id;
}


// *********************************************

bool bmx_wxpropertygriditeratorbase_atend(wxPropertyGridIteratorBase * iter) {
	return iter->AtEnd();
}

wxPGProperty * bmx_wxpropertygriditeratorbase_getproperty(wxPropertyGridIteratorBase * iter) {
	return iter->GetProperty();
}

//wxPGPropertyWithChildren * bmx_wxpropertygriditeratorbase_getpropertywithchildren(wxPropertyGridIteratorBase * iter) {
//	return iter->GetProperty();
//}

void bmx_wxpropertygriditeratorbase_nextproperty(wxPropertyGridIteratorBase * iter, bool iterateChildren) {
	iter->Next(iterateChildren);
}

void bmx_wxpropertygriditeratorbase_prevproperty(wxPropertyGridIteratorBase * iter) {
	iter->Prev();
}

void bmx_wxpropertygriditeratorbase_setbaseparent(wxPropertyGridIteratorBase * iter, wxPGPropertyWithChildren * baseParent) {
	iter->SetBaseParent(baseParent);
}

void bmx_wxpropertygrid_addpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int value) {
	grid->AddPropertyChoice(prop, wxStringFromBBString(label), value);
}

void bmx_wxpropertygrid_addpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int value) {
	grid->AddPropertyChoice(wxStringFromBBString(name), wxStringFromBBString(label), value);
}

void bmx_wxpropertygrid_setpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop, MaxPGChoices * choices) {
	grid->SetPropertyChoices(prop, choices->Choices());
}

void bmx_wxpropertygrid_setpropertychoicesexclusive(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->SetPropertyChoicesExclusive(prop);
}

void bmx_wxpropertygrid_setpropertychoicesbyname(wxPropertyGrid * grid, BBString * name, MaxPGChoices * choices) {
	grid->SetPropertyChoices(wxStringFromBBString(name), choices->Choices());
}

void bmx_wxpropertygrid_setpropertychoicesexclusivebyname(wxPropertyGrid * grid, BBString * name) {
	grid->SetPropertyChoicesExclusive(wxStringFromBBString(name));
}

wxPGProperty * bmx_wxpropertygrid_getpropertyptr(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyPtr(prop);
}

BBString * bmx_wxpropertygrid_getpropertyshortclassname(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyShortClassName(prop));
}

BBString * bmx_wxpropertygrid_getpropertyshortclassnamebyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyShortClassName(wxStringFromBBString(name)));
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayint(wxPropertyGrid * grid, wxPGProperty * prop) {
	return wxArrayIntToBBIntArray(wxArrayIntFromVariant(grid->GetPropertyValue(prop)));
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxPropertyGrid * grid, BBString * name) {
	return wxArrayIntToBBIntArray(wxArrayIntFromVariant(grid->GetPropertyValue(wxStringFromBBString(name))));
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystring(wxPropertyGrid * grid, wxPGProperty * prop) {
	return wxArrayStringToBBStringArray(grid->GetPropertyValue(prop).GetArrayString());
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxPropertyGrid * grid, BBString * name) {
	return wxArrayStringToBBStringArray(grid->GetPropertyValue(wxStringFromBBString(name)).GetArrayString());
}

bool bmx_wxpropertygrid_getpropertyvalueasbool(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyValue(prop).GetBool();
}

bool bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyValue(wxStringFromBBString(name)).GetBool();
}

MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetime(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxDateTime d(grid->GetPropertyValue(prop).GetDateTime());
	return new MaxDateTime(d);
}

MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetimebyname(wxPropertyGrid * grid, BBString * name) {
	wxDateTime d(grid->GetPropertyValue(wxStringFromBBString(name)).GetDateTime());
	return new MaxDateTime(d);
}

double bmx_wxpropertygrid_getpropertyvalueasdouble(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyValue(prop).GetDouble();
}

double bmx_wxpropertygrid_getpropertyvalueasdoublebyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyValue(wxStringFromBBString(name)).GetDouble();
}

long bmx_wxpropertygrid_getpropertyvalueasint(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyValue(prop).GetLong();
}

long bmx_wxpropertygrid_getpropertyvalueasintbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyValue(wxStringFromBBString(name)).GetLong();
}

void bmx_wxpropertygrid_getpropertyvalueaslong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 * value) {
	wxLongLong ll(wxLongLongFromVariant(grid->GetPropertyValue(prop)));
	*value = ll.GetValue();
}

void bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 * value) {
	wxLongLong ll(wxLongLongFromVariant(grid->GetPropertyValue(wxStringFromBBString(name))));
	*value = ll.GetValue();
}


void bmx_wxpropertygrid_getpropertyvalueaspoint(wxPropertyGrid * grid, wxPGProperty * prop, int * x, int * y) {
	wxPoint s(wxPointFromVariant(grid->GetPropertyValue(prop)));
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxPropertyGrid * grid, BBString * name, int * x, int * y) {
	wxPoint s(wxPointFromVariant(grid->GetPropertyValue(wxStringFromBBString(name))));
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueassize(wxPropertyGrid * grid, wxPGProperty * prop, int * w, int * h) {
	wxSize s(wxSizeFromVariant(grid->GetPropertyValue(prop)));
	*w = s.x;
	*h = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueassizebyname(wxPropertyGrid * grid, BBString * name, int * w, int * h) {
	wxSize s(wxSizeFromVariant(grid->GetPropertyValue(wxStringFromBBString(name))));
	*w = s.x;
	*h = s.y;
}

BBString * bmx_wxpropertygrid_getpropertyvalueasstring(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyValue(prop).GetString());
}

BBString * bmx_wxpropertygrid_getpropertyvalueasstringbyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyValue(wxStringFromBBString(name)).GetString());
}

BBString * bmx_wxpropertygrid_getpropertyvaluetype(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyValueType(prop));
}

BBString * bmx_wxpropertygrid_getpropertyvaluetypebyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyValueType(wxStringFromBBString(name)));
}

wxPGProperty * bmx_wxpropertygrid_getselection(wxPropertyGrid * grid) {
	return grid->GetSelection();
}

bool bmx_wxpropertygrid_ispropertcategory(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyCategory(prop);
}

bool bmx_wxpropertygrid_ispropertyenabled(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyEnabled(prop);
}

bool bmx_wxpropertygrid_ispropertyexpanded(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyExpanded(prop);
}

bool bmx_wxpropertygrid_ispropertymodified(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyModified(prop);
}

bool bmx_wxpropertygrid_ispropertyshown(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyShown(prop);
}

wxPGProperty * bmx_wxpropertygrid_getpropertybysubname(wxPropertyGrid * grid, BBString * name, BBString * subName) {
	return grid->GetPropertyByName(wxStringFromBBString(name), wxStringFromBBString(subName));
}

wxPGProperty * bmx_wxpropertygrid_getpropertybyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyByName(wxStringFromBBString(name));
}

wxPropertyCategory * bmx_wxpropertygrid_getpropertycategory(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyCategory(prop);
}

bool bmx_wxpropertygrid_hideproperty(wxPropertyGrid * grid, wxPGProperty * prop, bool hide) {
	return grid->HideProperty(hide);
}

wxPGProperty * bmx_wxpropertygrid_insert(wxPropertyGrid * grid, wxPGProperty * parent, int index, wxPGProperty * newproperty) {
	return grid->Insert(parent, index, newproperty);
}

wxPGProperty * bmx_wxpropertygrid_insertcategory(wxPropertyGrid * grid, wxPGProperty * prop, int index, BBString * label) {
	return grid->InsertCategory(prop, index, wxStringFromBBString(label));
}

void bmx_wxpropertygrid_insertpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int index, int value) {
	grid->InsertPropertyChoice(prop, wxStringFromBBString(label), index, value);
}

bool bmx_wxpropertygrid_ispropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->IsPropertyUnspecified(prop);
}

void bmx_wxpropertygrid_limitpropertyediting(wxPropertyGrid * grid, wxPGProperty * prop, bool limit) {
	grid->LimitPropertyEditing(prop, limit);
}

wxPGProperty * bmx_wxpropertygrid_replaceproperty(wxPropertyGrid * grid, wxPGProperty * prop, wxPGProperty * property) {
	return grid->ReplaceProperty(prop, property);
}

void bmx_wxpropertygrid_setpropertycell(wxPropertyGrid * grid, wxPGProperty * prop, int column, BBString * text, MaxBitmap * bitmap, MaxColour * fgCol, MaxColour * bgCol) {
	grid->SetPropertyCell(prop, column, wxStringFromBBString(text),
		(bitmap)?bitmap->Bitmap():wxNullBitmap,
		(fgCol)?fgCol->Colour():wxNullColour,
		(bgCol)?bgCol->Colour():wxNullColour);
}

wxPropertyCategory * bmx_wxpropertygrid_getpropertycategorybyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyCategory(wxStringFromBBString(name));
}

MaxPGChoices * bmx_wxpropertygrid_getpropertychoicesbyname(wxPropertyGrid * grid, BBString * name) {
	wxPGChoices p(grid->GetPropertyChoices(wxStringFromBBString(name)));
	return new MaxPGChoices(p);
}

BBString * bmx_wxpropertygrid_getpropertyclassnamebyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyClassName(wxStringFromBBString(name)));
}

BBString * bmx_wxpropertygrid_getpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyHelpString(wxStringFromBBString(name)));
}

MaxBitmap * bmx_wxpropertygrid_getpropertyimagebyname(wxPropertyGrid * grid, BBString * name) {
	wxBitmap * b = grid->GetPropertyImage(wxStringFromBBString(name));
	return new MaxBitmap((b) ? *b : wxNullBitmap);
}

unsigned int bmx_wxpropertygrid_getpropertyindexbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->GetPropertyIndex(wxStringFromBBString(name));
}

BBString * bmx_wxpropertygrid_getpropertylabelbyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyLabel(wxStringFromBBString(name)));
}

BBString * bmx_wxpropertygrid_getpropertynamebyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyName(wxStringFromBBString(name)));
}

void bmx_wxpropertygrid_insertpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int index, int value) {
	grid->InsertPropertyChoice(wxStringFromBBString(name), wxStringFromBBString(label), index, value);
}

bool bmx_wxpropertygrid_ispropertycategorybyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyCategory(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_ispropertyenabledbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyEnabled(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_ispropertyexpandedbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyExpanded(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_ispropertymodifiedbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyModified(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_ispropertyshownbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyShown(wxStringFromBBString(name));
}

bool bmx_wxpropertygrid_ispropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name) {
	return grid->IsPropertyUnspecified(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_limitpropertyeditingbyname(wxPropertyGrid * grid, BBString * name, bool limit) {
	grid->LimitPropertyEditing(wxStringFromBBString(name), limit);
}

wxPGProperty * bmx_wxpropertygrid_replacepropertybyname(wxPropertyGrid * grid, BBString * name, wxPGProperty * property) {
	return grid->ReplaceProperty(wxStringFromBBString(name), property);
}

void bmx_wxpropertygrid_setpropertycellbyname(wxPropertyGrid * grid, BBString * name, int column, BBString * text, MaxBitmap * bitmap, MaxColour * fgCol, MaxColour * bgCol) {
	grid->SetPropertyCell(wxStringFromBBString(name), column, wxStringFromBBString(text),
		(bitmap)?bitmap->Bitmap():wxNullBitmap,
		(fgCol)?fgCol->Colour():wxNullColour,
		(bgCol)?bgCol->Colour():wxNullColour);
}

void bmx_wxpropertygrid_setpropertyimage(wxPropertyGrid * grid, wxPGProperty * prop, MaxBitmap * bmp) {
	grid->SetPropertyImage(prop, bmp->Bitmap());
}

void bmx_wxpropertygrid_setpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label) {
	grid->SetPropertyLabel(prop, wxStringFromBBString(label));
}

void bmx_wxpropertygrid_setpropertyreadonly(wxPropertyGrid * grid, wxPGProperty * prop, bool set) {
	grid->SetPropertyReadOnly(set);
}

void bmx_wxpropertygrid_setpropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->SetPropertyUnspecified(prop);
}

void bmx_wxpropertygrid_setpropertyvalueintarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	grid->SetPropertyValue(prop, bbIntArrayTowxArrayInt(value));
}

void bmx_wxpropertygrid_setpropertyvalueulong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluelong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluesize(wxPropertyGrid * grid, wxPGProperty * prop, int w, int h) {
	grid->SetPropertyValue(prop, wxSize(w, h));
}

void bmx_wxpropertygrid_setpropertyvaluepoint(wxPropertyGrid * grid, wxPGProperty * prop, int x, int y) {
	grid->SetPropertyValue(prop, wxPoint(x, y));
}

void bmx_wxpropertygrid_setpropertyvaluebyteptr(wxPropertyGrid * grid, wxPGProperty * prop, void * value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * value) {
	grid->SetPropertyValue(prop, wxStringFromBBString(value));
}

void bmx_wxpropertygrid_setpropertyvaluedatetime(wxPropertyGrid * grid, wxPGProperty * prop, wxDateTime * time) {
	grid->SetPropertyValue(prop, time);
}

void bmx_wxpropertygrid_setpropertyvaluestringarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	grid->SetPropertyValue(prop, bbStringArrayTowxArrayStr(value));
}

void bmx_wxpropertygrid_setpropertyvaluebool(wxPropertyGrid * grid, wxPGProperty * prop, bool value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluedouble(wxPropertyGrid * grid, wxPGProperty * prop, double value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvalueint(wxPropertyGrid * grid, wxPGProperty * prop, int value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyreadonlybyname(wxPropertyGrid * grid, BBString * name, bool set) {
	grid->SetPropertyReadOnly(wxStringFromBBString(name), set);
}

void bmx_wxpropertygrid_setpropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name) {
	grid->SetPropertyUnspecified(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_setpropertyvalueintarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), bbIntArrayTowxArrayInt(value));
}

void bmx_wxpropertygrid_setpropertyvalueulongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluelongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluesizebyname(wxPropertyGrid * grid, BBString * name, int w, int h) {
	grid->SetPropertyValue(wxStringFromBBString(name), wxSize(w, h));
}

void bmx_wxpropertygrid_setpropertyvaluepointbyname(wxPropertyGrid * grid, BBString * name, int x, int y) {
	grid->SetPropertyValue(wxStringFromBBString(name), wxPoint(x, y));
}

void bmx_wxpropertygrid_setpropertyvaluebyteptrbyname(wxPropertyGrid * grid, BBString * name, void * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluestringbyname(wxPropertyGrid * grid, BBString * name, BBString * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), wxStringFromBBString(value));
}

void bmx_wxpropertygrid_setpropertyvaluedatetimebyname(wxPropertyGrid * grid, BBString * name, wxDateTime * time) {
	grid->SetPropertyValue(wxStringFromBBString(name), time);
}

void bmx_wxpropertygrid_setpropertyvaluestringarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), bbStringArrayTowxArrayStr(value));
}

void bmx_wxpropertygrid_setpropertyvalueboolbyname(wxPropertyGrid * grid, BBString * name, bool value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluedoublebyname(wxPropertyGrid * grid, BBString * name, double value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvalueintbyname(wxPropertyGrid * grid, BBString * name, int value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyimagebyname(wxPropertyGrid * grid, BBString * name, MaxBitmap * bmp) {
	grid->SetPropertyImage(wxStringFromBBString(name), bmp->Bitmap());
}

void bmx_wxpropertygrid_setpropertylabelbyname(wxPropertyGrid * grid, BBString * name, BBString * newproplabel) {
	grid->SetPropertyLabel(wxStringFromBBString(name), wxStringFromBBString(newproplabel));
}

bool bmx_wxpropertygrid_hidepropertybyname(wxPropertyGrid * grid, BBString * name, bool hide) {
	return grid->HideProperty(wxStringFromBBString(name), hide);
}

wxPGProperty * bmx_wxpropertygrid_insertbyname(wxPropertyGrid * grid, BBString * parent, int index, wxPGProperty * newproperty) {
	return grid->Insert(wxStringFromBBString(parent), index, newproperty);
}

wxPGProperty * bmx_wxpropertygrid_insertcategorybyname(wxPropertyGrid * grid, BBString * name, int index, BBString * label) {
	return grid->InsertCategory(wxStringFromBBString(name), index, wxStringFromBBString(label));
}

void bmx_wxpropertygrid_clear(wxPropertyGrid * grid) {
	grid->Clear();
}

void bmx_wxpropertygrid_clearmodifiedstatus(wxPropertyGrid * grid) {
	grid->ClearModifiedStatus();
}

void bmx_wxpropertygrid_clearpropertymodifiedstatus(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->ClearModifiedStatus(prop);
}

void bmx_wxpropertygrid_clearpropertymodifiedstatusbyname(wxPropertyGrid * grid, BBString * name) {
	grid->ClearModifiedStatus(wxStringFromBBString(name));
}

MaxColour * bmx_wxpropertygrid_getpropertyvalueascolour(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxColour c;
	c << grid->GetPropertyValue(prop);
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertyvalueascolourbyname(wxPropertyGrid * grid, BBString * name) {
	wxColour c;
	c << grid->GetPropertyValue(wxStringFromBBString(name));
	return new MaxColour(c);
}

void bmx_wxpropertygrid_setpropertyvaluecolour(wxPropertyGrid * grid, wxPGProperty * prop, MaxColour * value) {
	grid->SetPropertyValue(prop, value->Colour());
}

void bmx_wxpropertygrid_setpropertyvaluecolourbyname(wxPropertyGrid * grid, BBString * name, MaxColour * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value->Colour());
}

BBArray * bmx_wxpropertygrid_getpropertieswithflag(wxPropertyGrid * grid, wxPGProperty::FlagType flags, bool inverse, int iterFlags) {
	wxArrayPGProperty arr;
	
	grid->GetPropertiesWithFlag(&arr, flags, inverse, iterFlags);
	
	int n = arr.GetCount();
	BBArray * props = _wx_wxpropgrid_wxPropertyGrid__newPropertiesArray(n);
	for( int i=0;i<n;++i ){
		_wx_wxpropgrid_wxPropertyGrid__addProperty(props, i, arr[i]);
	}

	return props;
}

BBArray * bmx_wxpropertygrid_propertiestonames(wxPropertyGrid * grid, BBArray * props) {
	wxArrayPGProperty arr;
	
	int n = props->scales[0];
	arr.Alloc(n);
	
	for( int i=0;i<n;++i ){
		arr.Add(_wx_wxpropgrid_wxPropertyGrid__getProperty(props, i));
	}

	wxArrayString names;
	
	grid->PropertiesToNames(&names, arr);
	
	return wxArrayStringToBBStringArray(names);
}

BBArray * bmx_wxpropertygrid_namestoproperties(wxPropertyGrid * grid, BBArray * names) {

	wxArrayString arr = bbStringArrayTowxArrayStr(names);

	wxArrayPGProperty props;
	
	grid->NamesToProperties(&props, arr);
	
	int n = props.GetCount();
	BBArray * properties = _wx_wxpropgrid_wxPropertyGrid__newPropertiesArray(n);
	for( int i=0;i<n;++i ){
		_wx_wxpropgrid_wxPropertyGrid__addProperty(properties, i, props[i]);
	}

	return properties;
}

// *********************************************

MaxPGChoices * bmx_wxpgchoices_create() {
//	wxPGChoices c;
	return new MaxPGChoices();
}

void bmx_wxpgchoices_delete(MaxPGChoices * choices) {
	delete choices;
}

MaxPGChoiceEntry * bmx_wxpgchoices_add(MaxPGChoices * choices, BBString * label, int value) {
	wxPGChoiceEntry e(choices->Choices().Add(wxStringFromBBString(label), value));
	return new MaxPGChoiceEntry(e);
}

void bmx_wxpgchoices_addentries(MaxPGChoices * choices, BBArray * labels, BBArray * values) {
	choices->Choices().Add(bbStringArrayTowxArrayStr(labels), bbIntArrayTowxArrayInt(values));
}

MaxPGChoiceEntry * bmx_wxpgchoices_addassorted(MaxPGChoices * choices, BBString * label, int value) {
	wxPGChoiceEntry e(choices->Choices().AddAsSorted(wxStringFromBBString(label), value));
	return new MaxPGChoiceEntry(e);
}

int bmx_wxpgchoices_getcount(MaxPGChoices * choices) {
	return static_cast<int>(choices->Choices().GetCount());
}

BBString * bmx_wxpgchoices_getlabel(MaxPGChoices * choices, int index) {
	return bbStringFromWxString(choices->Choices().GetLabel(static_cast<size_t>(index)));
}

BBArray * bmx_wxpgchoices_getlabels(MaxPGChoices * choices) {
	return wxArrayStringToBBStringArray(choices->Choices().GetLabels());
}

int bmx_wxpgchoices_getvalue(MaxPGChoices * choices, int index) {
	return choices->Choices().GetValue(static_cast<size_t>(index));
}

bool bmx_wxpgchoices_hasvalue(MaxPGChoices * choices, int value) {
	return choices->Choices().HasValue(value);
}

bool bmx_wxpgchoices_hasvalues(MaxPGChoices * choices) {
	return choices->Choices().HasValues();
}

int bmx_wxpgchoices_index(MaxPGChoices * choices, int value) {
	return static_cast<int>(choices->Choices().Index(value));
}

int bmx_wxpgchoices_indexforlabel(MaxPGChoices * choices, BBString * label) {
	return static_cast<int>(choices->Choices().Index(wxStringFromBBString(label)));
}

MaxPGChoiceEntry * bmx_wxpgchoices_insert(MaxPGChoices * choices, BBString * label, int index, int value) {
	wxPGChoiceEntry e(choices->Choices().Insert(wxStringFromBBString(label), static_cast<size_t>(index), value));
	return new MaxPGChoiceEntry(e);
}

bool bmx_wxpgchoices_isok(MaxPGChoices * choices) {
	return choices->Choices().IsOk();
}

MaxPGChoiceEntry * bmx_wxpgchoices_item(MaxPGChoices * choices, int index) {
	wxPGChoiceEntry e(choices->Choices().Item(static_cast<size_t>(index)));
	return new MaxPGChoiceEntry(e);
}

void bmx_wxpgchoices_removeat(MaxPGChoices * choices, int index, int count) {
	choices->Choices().RemoveAt(static_cast<size_t>(index), count);
}

void bmx_wxpgchoices_set(MaxPGChoices * choices, BBArray * labels, BBArray * values) {
	choices->Choices().Set(bbStringArrayTowxArrayStr(labels),
		(values != &bbEmptyArray) ? bbIntArrayTowxArrayInt(values) : wxPG_EMPTY_ARRAYINT);
}

// *********************************************

MaxColour * bmx_wxpgchoiceentry_getbgcol(MaxPGChoiceEntry * entry) {
	wxColour c(entry->Entry().GetBgCol());
	return new MaxColour(c);
}

MaxBitmap * bmx_wxpgchoiceentry_getbitmap(MaxPGChoiceEntry * entry) {
	wxBitmap b(entry->Entry().GetBitmap());
	return new MaxBitmap(b);
}

MaxColour * bmx_wxpgchoiceentry_getfgcol(MaxPGChoiceEntry * entry) {
	wxColour c(entry->Entry().GetFgCol());
	return new MaxColour(c);
}

BBString * bmx_wxpgchoiceentry_gettext(MaxPGChoiceEntry * entry) {
	return bbStringFromWxString(entry->Entry().GetText());
}

void bmx_wxpgchoiceentry_setbgcol(MaxPGChoiceEntry * entry, MaxColour * col) {
	entry->Entry().SetBgCol(col->Colour());
}

void bmx_wxpgchoiceentry_setbitmap(MaxPGChoiceEntry * entry, MaxBitmap * bitmap) {
	entry->Entry().SetBitmap(bitmap->Bitmap());
}

void bmx_wxpgchoiceentry_setfgcol(MaxPGChoiceEntry * entry, MaxColour * col) {
	entry->Entry().SetFgCol(col->Colour());
}

void bmx_wxpgchoiceentry_settext(MaxPGChoiceEntry * entry, BBString * text) {
	entry->Entry().SetText(wxStringFromBBString(text));
}

void bmx_wxpgchoiceentry_delete(MaxPGChoiceEntry * entry) {
	delete entry;
}

int bmx_wxpgchoiceentry_getvalue(MaxPGChoiceEntry * entry) {
	return entry->Entry().GetValue();
}

bool bmx_wxpgchoiceentry_hasvalue(MaxPGChoiceEntry * entry) {
	return entry->Entry().HasValue();
}

void bmx_wxpgchoiceentry_setvalue(MaxPGChoiceEntry * entry, int value) {
	entry->Entry().SetValue(value);
}

// *********************************************

void bmx_wxpgproperty_setattributestring(wxPGProperty * prop, BBString * name, BBString * value) {
	prop->SetAttribute(wxStringFromBBString(name), wxStringFromBBString(value));
}

void bmx_wxpgproperty_setattributeint(wxPGProperty * prop, BBString * name, int value) {
	prop->SetAttribute(wxStringFromBBString(name), value);
}

void bmx_wxpgproperty_setattributedouble(wxPGProperty * prop, BBString * name, double value) {
	prop->SetAttribute(wxStringFromBBString(name), value);
}

void bmx_wxpgproperty_setattributebool(wxPGProperty * prop, BBString * name, bool value) {
	prop->SetAttribute(wxStringFromBBString(name), value);
}

void bmx_wxpgproperty_addchild(wxPGProperty * prop, wxPGProperty * child) {
	prop->AddChild(child);
}

int bmx_wxpgproperty_appendchoice(wxPGProperty * prop, BBString * label, int value) {
	return prop->AppendChoice(wxStringFromBBString(label), value);
}

bool bmx_wxpgproperty_canhaveextrachildren(wxPGProperty * prop) {
	return prop->CanHaveExtraChildren();
}

void bmx_wxpgproperty_deletechoice(wxPGProperty * prop, int index) {
	prop->DeleteChoice(index);
}

void bmx_wxpgproperty_empty(wxPGProperty * prop) {
	prop->Empty();
}

//bool bmx_wxpgproperty_ensuredataext(wxPGProperty * prop) {
//	return prop->EnsureDataExt();
//}

BBString * bmx_wxpgproperty_getbasename(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetBaseName());
}

unsigned int bmx_wxpgproperty_getchildcount(wxPGProperty * prop) {
	return prop->GetChildCount();
}

int bmx_wxpgproperty_getchildrenheight(wxPGProperty * prop, int lh, int iMax) {
	return prop->GetChildrenHeight(lh, iMax);
}

int bmx_wxpgproperty_getcommonvalue(wxPGProperty * prop) {
	return prop->GetCommonValue();
}

unsigned int bmx_wxpgproperty_getcount(wxPGProperty * prop) {
	return prop->GetCount();
}

unsigned int bmx_wxpgproperty_getdepth(wxPGProperty * prop) {
	return prop->GetDepth();
}

int bmx_wxpgproperty_getdisplayedcommonvaluecount(wxPGProperty * prop) {
	return prop->GetDisplayedCommonValueCount();
}

MaxColour * bmx_wxpgproperty_getvalueascolour(wxPGProperty * prop) {
	wxColour c;
	c << prop->GetValue();
	return new MaxColour(c);
}

BBString * bmx_wxpgproperty_getvaluestring(wxPGProperty * prop, int argFlags) {
	return bbStringFromWxString(prop->GetValueString(argFlags));
}

int bmx_wxpgproperty_gety(wxPGProperty * prop) {
	return prop->GetY();
}

bool bmx_wxpgproperty_hasflag(wxPGProperty * prop, wxPGProperty::FlagType flag) {
	return prop->HasFlag(flag);
}

bool bmx_wxpgproperty_hide(wxPGProperty * prop, bool hide) {
	return prop->Hide(hide);
}

bool bmx_wxpgproperty_iscategory(wxPGProperty * prop) {
	return prop->IsCategory();
}

bool bmx_wxpgproperty_isenabled(wxPGProperty * prop) {
	return prop->IsEnabled();
}

bool bmx_wxpgproperty_isexpanded(wxPGProperty * prop) {
	return prop->IsExpanded();
}

bool bmx_wxpgproperty_isflagset(wxPGProperty * prop, wxPGProperty::FlagType flag) {
	return prop->IsFlagSet(flag);
}

bool bmx_wxpgproperty_isroot(wxPGProperty * prop) {
	return prop->IsRoot();
}

bool bmx_wxpgproperty_issubproperty(wxPGProperty * prop) {
	return prop->IsSubProperty();
}

bool bmx_wxpgproperty_isvalueunspecified(wxPGProperty * prop) {
	return prop->IsValueUnspecified();
}

bool bmx_wxpgproperty_isvisible(wxPGProperty * prop) {
	return prop->IsVisible();
}

wxPGProperty * bmx_wxpgproperty_item(wxPGProperty * prop, int i) {
	return prop->Item(i);
}

wxPGProperty * bmx_wxpgproperty_last(wxPGProperty * prop) {
	return prop->Last();
}

bool bmx_wxpgproperty_recreateeditor(wxPGProperty * prop) {
	return prop->RecreateEditor();
}

void bmx_wxpgproperty_refreshchildren(wxPGProperty * prop) {
	prop->RefreshChildren();
}

void bmx_wxpgproperty_refresheditor(wxPGProperty * prop) {
	prop->RefreshEditor();
}

void bmx_wxpgproperty_setexpanded(wxPGProperty * prop, bool expanded) {
	prop->SetExpanded(expanded);
}

void bmx_wxpgproperty_setflag(wxPGProperty * prop, wxPGProperty::FlagType flag) {
	prop->SetFlag(flag);
}

void bmx_wxpgproperty_setflagsfromstring(wxPGProperty * prop, BBString * s) {
	prop->SetFlagsFromString(wxStringFromBBString(s));
}

void bmx_wxpgproperty_sethelpstring(wxPGProperty * prop, BBString * helpString) {
	prop->SetHelpString(wxStringFromBBString(helpString));
}

void bmx_wxpgproperty_setlabel(wxPGProperty * prop, BBString * label) {
	prop->SetLabel(wxStringFromBBString(label));
}

bool bmx_wxpgproperty_setmaxlength(wxPGProperty * prop, int maxLen) {
	return prop->SetMaxLength(maxLen);
}

unsigned int bmx_wxpgproperty_getarrindex(wxPGProperty * prop) {
	return prop->GetArrIndex();
}

void bmx_wxpgproperty_clearflag(wxPGProperty * prop, wxPGProperty::FlagType flag) {
	prop->ClearFlag(flag);
}

long bmx_wxpgproperty_getattributeasint(wxPGProperty * prop, BBString * name, long defVal) {
	return prop->GetAttributeAsLong(wxStringFromBBString(name), defVal);
}

BBString * bmx_wxpgproperty_getattributeasstring(wxPGProperty * prop, BBString * name, BBString * defVal) {
	return bbStringFromWxString(prop->GetAttribute(wxStringFromBBString(name), wxStringFromBBString(defVal)));
}

double bmx_wxpgproperty_getattributeasdouble(wxPGProperty * prop, BBString * name) {
	return prop->GetAttribute(wxStringFromBBString(name)).GetDouble();
}

void bmx_wxpgproperty_getattributeaslong(wxPGProperty * prop, BBString * name, BBInt64 * value) {
	*value = wxLongLongFromVariant(prop->GetAttribute(wxStringFromBBString(name))).GetValue();
}

BBString * bmx_wxpgproperty_getdisplayedstring(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetDisplayedString());
}

wxPGProperty::FlagType bmx_wxpgproperty_getflags(wxPGProperty * prop) {
	return prop->GetFlags();
}

BBString * bmx_wxpgproperty_getflagsasstring(wxPGProperty * prop, wxPGProperty::FlagType flagsMask) {
	return bbStringFromWxString(prop->GetFlagsAsString(flagsMask));
}

wxPropertyGrid * bmx_wxpgproperty_getgrid(wxPGProperty * prop) {
	return prop->GetGrid();
}

BBString * bmx_wxpgproperty_gethelpstring(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetHelpString());
}

void bmx_wxpgproperty_getimagesize(wxPGProperty * prop, int * w, int * h) {
	wxSize s = prop->GetImageSize();
	*w = s.x;
	*h = s.y;
}

unsigned int bmx_wxpgproperty_getindexinparent(wxPGProperty * prop) {
	return prop->GetIndexInParent();
}

wxPGProperty * bmx_wxpgproperty_getitematy(wxPGProperty * prop, unsigned int y, unsigned int lh, unsigned int *nextItemY) {
	return prop->GetItemAtY(y, lh, nextItemY);
}

BBString * bmx_wxpgproperty_getlabel(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetLabel());
}

const wxPGProperty * bmx_wxpgproperty_getlastvisiblesubitem(wxPGProperty * prop) {
	return prop->GetLastVisibleSubItem();
}

wxPGProperty * bmx_wxpgproperty_getmainparent(wxPGProperty * prop) {
	return prop->GetMainParent();
}

int bmx_wxpgproperty_getmaxlength(wxPGProperty * prop) {
	return prop->GetMaxLength();
}

BBString * bmx_wxpgproperty_getname(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetName());
}

wxPGProperty * bmx_wxpgproperty_getparent(wxPGProperty * prop) {
	return prop->GetParent();
}

wxPGProperty * bmx_wxpgproperty_getpropertybyname(wxPGProperty * prop, BBString * name) {
	return prop->GetPropertyByName(wxStringFromBBString(name));
}

BBString * bmx_wxpgproperty_gettype(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetType());
}

void bmx_wxpgproperty_setvalueulong(wxPGProperty * prop, BBInt64 value) {
	wxVariant v = WXVARIANT(wxULongLong(value));
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvaluelong(wxPGProperty * prop, BBInt64 value) {
	wxVariant v = WXVARIANT(wxLongLong(value));
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvaluesize(wxPGProperty * prop, int w, int h) {
	wxVariant v = WXVARIANT(wxSize(w, h));
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvaluepoint(wxPGProperty * prop, int x, int y) {
	wxVariant v = WXVARIANT(wxPoint(x, y));
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvaluebyteptr(wxPGProperty * prop, void * value) {
	prop->SetValue(value);
}

void bmx_wxpgproperty_setvaluestring(wxPGProperty * prop, BBString * value) {
	prop->SetValue(wxStringFromBBString(value));
}

void bmx_wxpgproperty_setvaluestringarray(wxPGProperty * prop, BBArray * value) {
	wxArrayString arr = bbStringArrayTowxArrayStr(value);
	wxVariant v = WXVARIANT(arr);
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvalueintarray(wxPGProperty * prop, BBArray * value) {
	wxArrayInt arr = bbIntArrayTowxArrayInt(value);
	wxVariant v = WXVARIANT(arr);
	prop->SetValue(v);
}

void bmx_wxpgproperty_setvaluebool(wxPGProperty * prop, bool value) {
	prop->SetValue(value);
}

void bmx_wxpgproperty_setvaluedouble(wxPGProperty * prop, double value) {
	prop->SetValue(value);
}

void bmx_wxpgproperty_setvalueint(wxPGProperty * prop, int value) {
	prop->SetValue(value);
}

BBArray * bmx_wxpgproperty_getvalueasarrayint(wxPGProperty * prop) {
	return wxArrayIntToBBIntArray(wxArrayIntFromVariant(prop->GetValue()));
}

BBArray * bmx_wxpgproperty_getvalueasarraystring(wxPGProperty * prop) {
	return wxArrayStringToBBStringArray(prop->GetValue().GetArrayString());
}

BBString * bmx_wxpgproperty_getvalueasstring(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetValue().GetString());
}

double bmx_wxpgproperty_getvalueasdouble(wxPGProperty * prop) {
	return prop->GetValue().GetDouble();
}

bool bmx_wxpgproperty_getvalueasbool(wxPGProperty * prop) {
	return prop->GetValue().GetBool();
}

long bmx_wxpgproperty_getvalueasint(wxPGProperty * prop) {
	return prop->GetValue().GetLong();
}

void bmx_wxpgproperty_getvalueaslong(wxPGProperty * prop, BBInt64 * value) {
	wxLongLong ll(wxLongLongFromVariant(prop->GetValue()));
	*value = ll.GetValue();
}

void bmx_wxpgproperty_getvalueaspoint(wxPGProperty * prop, int * x, int * y) {
	wxPoint p(wxPointFromVariant(prop->GetValue()));
	*x = p.x;
	*y = p.y;
}

void bmx_wxpgproperty_getvalueassize(wxPGProperty * prop, int * w, int * h) {
	wxSize s(wxSizeFromVariant(prop->GetValue()));
	*w = s.x;
	*h = s.y;
}

void bmx_wxpgproperty_setvaluecolour(wxPGProperty * prop, MaxColour * value) {
	wxVariant v = WXVARIANT(value->Colour());
	prop->SetValue(v);
}

unsigned int bmx_wxpgproperty_getchoicecount(wxPGProperty * prop) {
	return prop->GetChoiceCount();
}

BBString * bmx_wxpgproperty_getchoicestring(wxPGProperty * prop, int index) {
	return bbStringFromWxString(prop->GetChoiceString(index));
}

BBString * bmx_wxpgproperty_getclassname(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetClassName());
}

// *********************************************

long bmx_wxdateproperty_getdatepickerstyle(wxDateProperty * prop) {
	return prop->GetDatePickerStyle();
}

MaxDateTime * bmx_wxdateproperty_getdatevalue(wxDateProperty * prop) {
	return new MaxDateTime(prop->GetDateValue());
}

BBString * bmx_wxdateproperty_getformat(wxDateProperty * prop) {
	return bbStringFromWxString(prop->GetFormat());
}

void bmx_wxdateproperty_setdatevalue(wxDateProperty * prop, MaxDateTime * dt) {
	prop->SetDateValue(dt->DateTime());
}

void bmx_wxdateproperty_setformat(wxDateProperty * prop, BBString * format) {
	prop->SetFormat(wxStringFromBBString(format));
}


// *********************************************

wxEnumProperty * bmx_wxenumproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * values, int value) {
	return new MaxEnumProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(values) ? bbIntArrayTowxArrayInt(values) : wxArrayInt(),
		value);
}

wxEnumProperty * bmx_wxenumproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, int value) {
	return new MaxEnumProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		choices->Choices(),
		value);
}

// *********************************************

wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * value) {
	return new MaxMultiChoiceProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(value) ? bbStringArrayTowxArrayStr(value) : wxArrayString() );
}

wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, BBArray * value) {
	return new MaxMultiChoiceProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxT("_LABEL_AS_NAME"),
		choices->Choices(),
		(value) ? bbStringArrayTowxArrayStr(value) : wxArrayString() );
}

// *********************************************

wxPGProperty * bmx_wxpropertygridevent_getmainparent(wxPropertyGridEvent & event) {
	return event.GetMainParent();
}

wxPGProperty * bmx_wxpropertygridevent_getproperty(wxPropertyGridEvent & event) {
	return event.GetProperty();
}

bool bmx_wxpropertygridevent_hasproperty(wxPropertyGridEvent & event) {
	return event.HasProperty();
}

bool bmx_wxpropertygridevent_ispropertyenabled(wxPropertyGridEvent & event) {
	return event.IsPropertyEnabled();
}

bool bmx_wxpropertygridevent_canveto(wxPropertyGridEvent & event) {
	return event.CanVeto();
}

void bmx_wxpropertygridevent_disableproperty(wxPropertyGridEvent & event) {
	event.DisableProperty();
}

void bmx_wxpropertygridevent_enableproperty(wxPropertyGridEvent & event, bool enable) {
	event.EnableProperty(enable);
}

BBString * bmx_wxpropertygridevent_getpropertylabel(wxPropertyGridEvent & event) {
	return bbStringFromWxString(event.GetPropertyLabel());
}

BBString * bmx_wxpropertygridevent_getpropertyname(wxPropertyGridEvent & event) {
	return bbStringFromWxString(event.GetPropertyName());
}

void bmx_wxpropertygridevent_veto(wxPropertyGridEvent & event, bool value) {
	event.Veto(value);
}

BBArray * bmx_wxpropertygridevent_getpropertyvalueasarrayint(wxPropertyGridEvent & event) {
	return wxArrayIntToBBIntArray(wxArrayIntFromVariant(event.GetPropertyValue()));
}

BBArray * bmx_wxpropertygridevent_getpropertyvalueasarraystring(wxPropertyGridEvent & event) {
	return wxArrayStringToBBStringArray(event.GetPropertyValue().GetArrayString());
}

bool bmx_wxpropertygridevent_getpropertyvalueasbool(wxPropertyGridEvent & event) {
	return event.GetPropertyValue().GetBool();
}

double bmx_wxpropertygridevent_getpropertyvalueasdouble(wxPropertyGridEvent & event) {
	return event.GetPropertyValue().GetDouble();
}

long bmx_wxpropertygridevent_getpropertyvalueasint(wxPropertyGridEvent & event) {
	return event.GetPropertyValue().GetLong();
}

void bmx_wxpropertygridevent_getpropertyvalueaspoint(wxPropertyGridEvent & event, int * x, int * y) {
	wxPoint s(wxPointFromVariant(event.GetPropertyValue()));
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygridevent_getpropertyvalueassize(wxPropertyGridEvent & event, int * w, int * h) {
	wxSize s(wxSizeFromVariant(event.GetPropertyValue()));
	*w = s.x;
	*h = s.y;
}

BBString * bmx_wxpropertygridevent_getpropertyvalueasstring(wxPropertyGridEvent & event) {
	return bbStringFromWxString(event.GetPropertyValue().GetString());
}

// *********************************************

int bmx_wxpropertygrid_geteventtype(int type) {

	switch(type) {
		case -4300: return wxEVT_PG_SELECTED;
		case -4301: return wxEVT_PG_CHANGING;
		case -4302: return wxEVT_PG_CHANGED;
		case -4303: return wxEVT_PG_HIGHLIGHTED;
		case -4304: return wxEVT_PG_RIGHT_CLICK;
		case -4305: return wxEVT_PG_PAGE_CHANGED;
		case -4306: return wxEVT_PG_ITEM_EXPANDED;
		case -4307: return wxEVT_PG_ITEM_COLLAPSED;
		case -4308: return wxEVT_PG_DOUBLE_CLICK;

	}
	return 0;

}

