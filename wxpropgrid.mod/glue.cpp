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

MaxPropertyGrid::MaxPropertyGrid(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style)
	: wxPropertyGrid(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxPropertyGrid::MaxPropertyGrid()
{}

MaxPropertyGrid::~MaxPropertyGrid() {
	wxunbind(this);
}

void MaxPropertyGrid::MaxBind(BBObject * handle) {
	wxbind(this, handle);
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

void MaxMultiChoiceProperty::SetValueIntArray(wxArrayInt array) {
	wxVariant variant;
	wxArrayString value;
	
	unsigned int i;
	for (i = 0; i < array.GetCount(); i++ ) {
		if (m_choices.Index(array.Item(i)) != -1) {
			value.Add(m_choices.GetLabel(m_choices.Index(array.Item(i))));
		}
	}
	
	variant = WXVARIANT(value);
	SetValue(variant);
}

MaxColourProperty::MaxColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value)
	: wxColourProperty(label, name, value)
{
	wxbind(this, handle);
}
MaxColourProperty::~MaxColourProperty() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

#if wxCHECK_VERSION(2,9,0)
    #define wxXML_GetAttribute(A,B,C)   (A->GetAttribute(B,C))
#else
    #define wxXML_GetAttribute(A,B,C)   (A->GetPropVal(B,C))
#endif

/*
IMPLEMENT_DYNAMIC_CLASS(MaxPropertyGridXmlHandler, wxPropertyGridXmlHandler)

MaxPropertyGridXmlHandler:: MaxPropertyGridXmlHandler()
	: wxPropertyGridXmlHandler(), m_populator(NULL), m_manager(NULL)
{}


wxObject * MaxPropertyGridXmlHandler::DoCreateResource()
{
    const wxXmlNode* node = m_node;
    wxString nodeName = node->GetName();
    wxString emptyString;

    if ( nodeName == wxT("property") )
    {
        // property
        wxString clas = wxXML_GetAttribute(node, wxT("class"), emptyString);

        wxString label;
        wxString sLabel(wxT("label"));
        if ( HasParam(sLabel) )
            label = GetText(sLabel);

        wxString name;
        wxString sName(wxT("name"));
        if ( HasParam(sName) )
            label = GetText(sName);
        else
            name = label;

        wxString sValue(wxT("value"));
        wxString value;
        wxString* pValue = NULL;
        if ( HasParam(sValue) )
        {
            value = GetText(sValue);
            pValue = &value;
        }

        wxXmlNode* choicesNode = GetParamNode(wxT("choices"));
        wxPGChoices choices;
        if ( choicesNode )
        {
            choices = m_populator->ParseChoices( choicesNode->GetNodeContent(),
                                                 wxXML_GetAttribute(choicesNode, wxT("id"), emptyString));
        }

        wxPGProperty* property = m_populator->Add( clas, label, name, pValue, &choices );

        if ( !property )
            return NULL;

        wxString sFlags(wxT("flags"));
        wxString flags;
        if ( HasParam(sFlags) )
            property->SetFlagsFromString( GetText(sFlags) );

        wxString sTip(wxT("tip"));
        if ( HasParam(sTip) )
            property->SetHelpString(GetText(sTip));

        if ( property->GetChildCount() )
        {
            wxPGPropertyWithChildren* pwc = (wxPGPropertyWithChildren*) property;

            // FIXME
            wxString sExpanded(wxT("expanded"));
            if ( HasParam(sExpanded) )
                pwc->SetExpanded(GetBool(sExpanded));
        }

        // Need to call AddChildren even for non-parent properties for attributes and such
        m_populator->AddChildren(property);
    }
    else if ( nodeName == wxT("attribute") )
    {
        // attribute
        wxString s1 = wxXML_GetAttribute(node, wxT("name"), emptyString);
        if ( s1.length() )
        {
            m_populator->AddAttribute( s1, wxXML_GetAttribute(node, wxT("type"), emptyString),
                                       node->GetNodeContent() );
        }
    }
    else if( m_class == wxT("wxPropertyGrid"))
    {
        XRC_MAKE_INSTANCE(control, MaxPropertyGrid)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetPosition(), GetSize(),
                        GetStyle(),
                        GetName());


		control->MaxBind(_wx_wxpropgrid_wxPropertyGrid__xrcNew(control));

        m_pg = control;
        HandlePropertyGridParams();

        InitPopulator();
        PopulatePage(control->GetState());
        DonePopulator();

        SetupWindow(control);

        return control;
    }
    else if ( nodeName == wxT("choices") )
    {
        // choices

        //
        // Add choices list outside of a property
        m_populator->ParseChoices( node->GetNodeContent(),
                                   wxXML_GetAttribute(node, wxT("id"), emptyString));
    }
    else if ( nodeName == wxT("splitterpos") )
    {
        // splitterpos
        wxASSERT(m_populator);
        wxString sIndex = wxXML_GetAttribute(node, wxT("index"), emptyString);

        long index;
        if ( !sIndex.ToLong(&index, 10) )
            index = 0;

        wxString s = node->GetNodeContent();
        long pos;
        if ( wxPropertyGridPopulator::ToLongPCT(s, &pos, m_pg->GetClientSize().x) )
            m_populator->GetState()->DoSetSplitterPosition( pos, index, false );
    }
#if wxPG_INCLUDE_MANAGER
    else if ( nodeName == wxT("page") )
    {
        // page
        wxASSERT(m_manager);

        wxString label;
        wxString sLabel(wxT("label"));
        if ( HasParam(sLabel) )
            label = GetText(sLabel);
        else
            label = wxString::Format(_("Page %i"),(int)(m_manager->GetPageCount()+1));

        m_manager->AddPage(label);
        wxPropertyGridState* state = m_manager->GetPage(m_manager->GetPageCount()-1);
        PopulatePage(state);
    }
    else if( m_class == wxT("wxPropertyGridManager"))
    {
        XRC_MAKE_INSTANCE(control, wxPropertyGridManager)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetPosition(), GetSize(),
                        GetStyle(),
                        GetName());

        wxPropertyGridManager* oldManager = m_manager;
        m_manager = control;
        m_pg = control->GetGrid();
        HandlePropertyGridParams();

        InitPopulator();
        CreateChildrenPrivately(control, NULL);
        DonePopulator();

        m_manager = oldManager;
        SetupWindow(control);

        return control;
    }
#endif
    else
    {
        wxASSERT( false );
    }

    return NULL;
}

bool MaxPropertyGridXmlHandler::CanHandle(wxXmlNode *node)
{
#if wxCHECK_VERSION(2,7,0)
    #define fOurClass(A) IsOfClass(node, A)
#else
    #define fOurClass(A) (wxXML_GetAttribute(node, wxT("class"), wxEmptyString) == A)
#endif

    wxString name = node->GetName();

    return (
            (
             m_populator && ( name == wxT("property") ||
                              name == wxT("attribute") ||
                              name == wxT("choices") ||
                              name == wxT("splitterpos")
                            )
            ) ||
            (m_manager && name == wxT("page")) ||
            (!m_populator && fOurClass(wxT("wxPropertyGrid")))
#if wxPG_INCLUDE_MANAGER
            ||
            (!m_populator && fOurClass(wxT("wxPropertyGridManager")))
#endif
           );
}
*/

// *********************************************

BEGIN_EVENT_TABLE(MaxPropertyGrid, wxPropertyGrid)
END_EVENT_TABLE()

wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxPropertyGrid(handle, parent, id, x, y, w, h, style);
}

wxPGProperty * bmx_wxpropertycontainermethods_append(wxPropertyGridInterface * prop, wxPGProperty * property) {
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
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}
	
// *********************************************

wxPGProperty * bmx_wxpropertycategory_create(BBObject * handle, BBString * label, BBString * name) {
	return new MaxPropertyCategory( handle,
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label) );
}

// *********************************************

wxPGProperty * bmx_wxfontproperty_create(BBObject * handle, BBString * label, BBString * name, MaxFont * font) {
	return new MaxFontProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
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

MaxColour * bmx_wxpropertygrid_getpropertytextcolour(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxColour c(grid->GetPropertyTextColour(prop));
	return new MaxColour(c);
}

MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxPropertyGrid * grid, BBString * name) {
	wxColour c(grid->GetPropertyBackgroundColour(wxStringFromBBString(name)));
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

int bmx_wxpropertygrid_clearselection(wxPropertyGrid * grid) {
	return static_cast<int>(grid->ClearSelection());
}

int bmx_wxpropertygrid_collapse(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->Collapse(prop));
}

int bmx_wxpropertygrid_collapsebyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->Collapse(wxStringFromBBString(name)));
}

void bmx_wxpropertygrid_deleteproperty(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->DeleteProperty(prop);
}

void bmx_wxpropertygrid_deletepropertybyname(wxPropertyGrid * grid, BBString * name) {
	grid->DeleteProperty(wxStringFromBBString(name));
}

int bmx_wxpropertygrid_disableproperty(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->DisableProperty(prop));
}

int bmx_wxpropertygrid_disablepropertybyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->DisableProperty(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_enableproperty(wxPropertyGrid * grid, wxPGProperty * prop, int enable) {
	return static_cast<int>(grid->EnableProperty(prop, static_cast<bool>(enable)));
}

int bmx_wxpropertygrid_enablepropertybyname(wxPropertyGrid * grid, BBString * name, int enable) {
	return static_cast<int>(grid->EnableProperty(wxStringFromBBString(name), static_cast<bool>(enable)));
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

int bmx_wxpropertygrid_expand(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->Expand(prop));
}

int bmx_wxpropertygrid_expandbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->Expand(wxStringFromBBString(name)));
}

wxPGProperty * bmx_wxpropertygrid_getfirst(wxPropertyGrid * grid, int flags) {
	return ((wxPropertyGridInterface*)grid)->GetFirst(flags);
}

MaxPGChoices * bmx_wxpropertygrid_getpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop) {
	return new MaxPGChoices(prop->GetChoices());
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

BBString * bmx_wxpropertygrid_getpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyLabel(prop));
}

BBString * bmx_wxpropertygrid_getpropertyname(wxPropertyGrid * grid, wxPGProperty * prop) {
	return bbStringFromWxString(grid->GetPropertyName(prop));
}

wxPGProperty * bmx_wxpropertygrid_getpropertyparent(wxPropertyGrid * grid, wxPGProperty * prop) {
	return grid->GetPropertyParent(prop);
}

int bmx_wxpropertygrid_setpropertymaxlength(wxPropertyGrid * grid, wxPGProperty * prop, int maxLen) {
	return static_cast<int>(grid->SetPropertyMaxLength(prop, maxLen));
}

int bmx_wxpropertygrid_setpropertymaxlengthbyname(wxPropertyGrid * grid, BBString * name, int maxLen) {
	return static_cast<int>(grid->SetPropertyMaxLength(wxStringFromBBString(name), maxLen));
}

// *********************************************

wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value) {
	return new MaxSystemColourProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value) ? value->Colour() : wxColour());
}

// *********************************************

wxIntProperty * bmx_wxintproperty_create(BBObject * handle, BBString * label, BBString * name, int value) {
	return new MaxIntProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		value);
}

// *********************************************

wxUIntProperty * bmx_wxuintproperty_create(BBObject * handle, BBString * label, BBString * name, unsigned long value) {
	return new MaxUIntProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		value);
}

// *********************************************

wxFloatProperty * bmx_wxdoubleproperty_create(BBObject * handle, BBString * label, BBString * name, double value) {
	return new MaxFloatProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		value);
}

// *********************************************

wxFloatProperty * bmx_wxfloatproperty_create(BBObject * handle, BBString * label, BBString * name, double value) {
	return new MaxFloatProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		value);
}

// *********************************************

wxBoolProperty * bmx_wxboolproperty_create(BBObject * handle, BBString * label, BBString * name, int value) {
	return new MaxBoolProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		static_cast<bool>(value));
}

// *********************************************

wxCursorProperty * bmx_wxcursorproperty_create(BBObject * handle, BBString * label, BBString * name, int value) {
	return new MaxCursorProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		value);
}

// *********************************************

wxImageFileProperty * bmx_wximagefileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxImageFileProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxDateProperty * bmx_wxdateproperty_create(BBObject * handle, BBString * label, BBString * name, MaxDateTime * value) {
	return new MaxDateProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value) ? value->DateTime(): wxDateTime());
}

// *********************************************

wxFlagsProperty * bmx_wxflagsproperty_create(BBObject * handle, BBString * label, BBString * name,
		BBArray * labels, BBArray * values, int value) {
	return new MaxFlagsProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(values) ? bbIntArrayTowxArrayInt(values) : wxArrayInt(),
		value);
}

// *********************************************

wxFileProperty * bmx_wxfileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxFileProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxLongStringProperty * bmx_wxlongstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxLongStringProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxDirProperty * bmx_wxdirproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value) {
	return new MaxDirProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(value != &bbEmptyString) ? wxStringFromBBString(value) : wxString());
}

// *********************************************

wxArrayStringProperty * bmx_wxarraystringproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * value) {
	return new MaxArrayStringProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		bbStringArrayTowxArrayStr(value));
}

// *********************************************

wxColourProperty * bmx_wxcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value) {
	return new MaxColourProperty(handle, wxStringFromBBString(label), 
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
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

int bmx_wxpropertygriditeratorbase_atend(wxPropertyGridIteratorBase * iter) {
	return static_cast<int>(iter->AtEnd());
}

wxPGProperty * bmx_wxpropertygriditeratorbase_getproperty(wxPropertyGridIteratorBase * iter) {
	return iter->GetProperty();
}

//wxPGPropertyWithChildren * bmx_wxpropertygriditeratorbase_getpropertywithchildren(wxPropertyGridIteratorBase * iter) {
//	return iter->GetProperty();
//}

void bmx_wxpropertygriditeratorbase_nextproperty(wxPropertyGridIteratorBase * iter, int iterateChildren) {
	iter->Next(static_cast<bool>(iterateChildren));
}

void bmx_wxpropertygriditeratorbase_prevproperty(wxPropertyGridIteratorBase * iter) {
	iter->Prev();
}

void bmx_wxpropertygriditeratorbase_setbaseparent(wxPropertyGridIteratorBase * iter, wxPGProperty * baseParent) {
	iter->SetBaseParent(baseParent);
}

void bmx_wxpropertygrid_addpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int value) {
	prop->AddChoice(wxStringFromBBString(label), value);
}

void bmx_wxpropertygrid_addpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int value) {
	wxPGProperty * prop = grid->GetPropertyByLabel(wxStringFromBBString(name));
	if (prop) {
		prop->AddChoice(wxStringFromBBString(label), value);
	}
}

wxPGProperty * bmx_wxpropertygrid_getpropertyptr(wxPropertyGrid * grid, wxPGProperty * prop) {
	return prop;
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayint(wxPropertyGrid * grid, wxPGProperty * prop) {
	wxArrayInt a;
	wxVariant v = grid->GetPropertyValue(prop);
	a << v;
	return wxArrayIntToBBIntArray(a);
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxPropertyGrid * grid, BBString * name) {
	wxArrayInt a;
	wxVariant v = grid->GetPropertyValue(wxStringFromBBString(name));
	a << v;
	return wxArrayIntToBBIntArray(a);
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystring(wxPropertyGrid * grid, wxPGProperty * prop) {
	return wxArrayStringToBBStringArray(grid->GetPropertyValue(prop).GetArrayString());
}

BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxPropertyGrid * grid, BBString * name) {
	return wxArrayStringToBBStringArray(grid->GetPropertyValue(wxStringFromBBString(name)).GetArrayString());
}

int bmx_wxpropertygrid_getpropertyvalueasbool(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->GetPropertyValue(prop).GetBool());
}

int bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->GetPropertyValue(wxStringFromBBString(name)).GetBool());
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
	//wxLongLong ll;
	wxVariant v = grid->GetPropertyValue(prop);
	//ll = v.GetLongLong();
	*value = v.GetLongLong().GetValue();
}

void bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 * value) {
	//wxLongLong ll;
	wxVariant v = grid->GetPropertyValue(wxStringFromBBString(name));
	//ll = v.GetLongLong();
	*value = v.GetLongLong().GetValue();
}


void bmx_wxpropertygrid_getpropertyvalueaspoint(wxPropertyGrid * grid, wxPGProperty * prop, int * x, int * y) {
	wxPoint s;
	wxVariant v = grid->GetPropertyValue(prop);
	s << v;
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxPropertyGrid * grid, BBString * name, int * x, int * y) {
	wxPoint s;
	wxVariant v = grid->GetPropertyValue(wxStringFromBBString(name));
	s << v;
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueassize(wxPropertyGrid * grid, wxPGProperty * prop, int * w, int * h) {
	wxVariant v = grid->GetPropertyValue(prop);
	wxSize s;
	s << v;
	*w = s.x;
	*h = s.y;
}

void bmx_wxpropertygrid_getpropertyvalueassizebyname(wxPropertyGrid * grid, BBString * name, int * w, int * h) {
	wxVariant v = grid->GetPropertyValue(wxStringFromBBString(name));
	wxSize s;
	s << v;
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
	return bbStringFromWxString(prop->GetValueType());
}

BBString * bmx_wxpropertygrid_getpropertyvaluetypebyname(wxPropertyGrid * grid, BBString * name) {
	wxPGProperty * prop = grid->GetPropertyByLabel(wxStringFromBBString(name));
	if (prop) {
		return bbStringFromWxString(prop->GetValueType());
	}
	return &bbEmptyString;
}

wxPGProperty * bmx_wxpropertygrid_getselection(wxPropertyGrid * grid) {
	return grid->GetSelection();
}

int bmx_wxpropertygrid_ispropertcategory(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyCategory(prop));
}

int bmx_wxpropertygrid_ispropertyenabled(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyEnabled(prop));
}

int bmx_wxpropertygrid_ispropertyexpanded(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyExpanded(prop));
}

int bmx_wxpropertygrid_ispropertymodified(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyModified(prop));
}

int bmx_wxpropertygrid_ispropertyshown(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyShown(prop));
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

int bmx_wxpropertygrid_hideproperty(wxPropertyGrid * grid, wxPGProperty * prop, int hide) {
	return static_cast<int>(grid->HideProperty(static_cast<bool>(hide)));
}

wxPGProperty * bmx_wxpropertygrid_insert(wxPropertyGrid * grid, wxPGProperty * parent, int index, wxPGProperty * newproperty) {
	return grid->Insert(parent, index, newproperty);
}

void bmx_wxpropertygrid_insertpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int index, int value) {
	prop->InsertChoice(wxStringFromBBString(label), index, value);
}

int bmx_wxpropertygrid_ispropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop) {
	return static_cast<int>(grid->IsPropertyValueUnspecified(prop));
}

void bmx_wxpropertygrid_limitpropertyediting(wxPropertyGrid * grid, wxPGProperty * prop, int limit) {
	grid->LimitPropertyEditing(prop, static_cast<bool>(limit));
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
	wxPGProperty * prop = grid->GetPropertyByLabel(wxStringFromBBString(name));
	if (prop) {
		wxPGChoices p(prop->GetChoices());
		return new MaxPGChoices(p);
	}
}

BBString * bmx_wxpropertygrid_getpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyHelpString(wxStringFromBBString(name)));
}

MaxBitmap * bmx_wxpropertygrid_getpropertyimagebyname(wxPropertyGrid * grid, BBString * name) {
	wxBitmap * b = grid->GetPropertyImage(wxStringFromBBString(name));
	return new MaxBitmap((b) ? *b : wxNullBitmap);
}

BBString * bmx_wxpropertygrid_getpropertylabelbyname(wxPropertyGrid * grid, BBString * name) {
	return bbStringFromWxString(grid->GetPropertyLabel(wxStringFromBBString(name)));
}

void bmx_wxpropertygrid_insertpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int index, int value) {
	wxPGProperty * prop = grid->GetPropertyByLabel(wxStringFromBBString(name));
	if (prop) {
		prop->InsertChoice(wxStringFromBBString(label), index, value);
	}
}

int bmx_wxpropertygrid_ispropertycategorybyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyCategory(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_ispropertyenabledbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyEnabled(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_ispropertyexpandedbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyExpanded(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_ispropertymodifiedbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyModified(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_ispropertyshownbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyShown(wxStringFromBBString(name)));
}

int bmx_wxpropertygrid_ispropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name) {
	return static_cast<int>(grid->IsPropertyValueUnspecified(wxStringFromBBString(name)));
}

void bmx_wxpropertygrid_limitpropertyeditingbyname(wxPropertyGrid * grid, BBString * name, int limit) {
	grid->LimitPropertyEditing(wxStringFromBBString(name), static_cast<bool>(limit));
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

void bmx_wxpropertygrid_setpropertyreadonly(wxPropertyGrid * grid, wxPGProperty * prop, int set) {
	grid->SetPropertyReadOnly(static_cast<bool>(set));
}

void bmx_wxpropertygrid_setpropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop) {
	grid->SetPropertyValueUnspecified(prop);
}

void bmx_wxpropertygrid_setpropertyvalueintarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	wxArrayInt a = bbIntArrayTowxArrayInt(value);
	wxVariant v;
	v << a;
	grid->SetPropertyValue(prop, v);
}

void bmx_wxpropertygrid_setpropertyvalueulong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluelong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluesize(wxPropertyGrid * grid, wxPGProperty * prop, int w, int h) {
	wxSize s(w, h);
	wxVariant v;
	v << s;
	grid->SetPropertyValue(prop, v);
}

void bmx_wxpropertygrid_setpropertyvaluepoint(wxPropertyGrid * grid, wxPGProperty * prop, int x, int y) {
	wxVariant v;
	v << wxPoint(x, y);
	grid->SetPropertyValue(prop, v);
}

void bmx_wxpropertygrid_setpropertyvaluebyteptr(wxPropertyGrid * grid, wxPGProperty * prop, void * value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvaluestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * value) {
	grid->SetPropertyValue(prop, wxStringFromBBString(value));
}

void bmx_wxpropertygrid_setpropertyvaluedatetime(wxPropertyGrid * grid, wxPGProperty * prop, MaxDateTime * time) {
	grid->SetPropertyValue(prop, time);
}

void bmx_wxpropertygrid_setpropertyvaluestringarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	grid->SetPropertyValue(prop, bbStringArrayTowxArrayStr(value));
}

void bmx_wxpropertygrid_setpropertyvaluebool(wxPropertyGrid * grid, wxPGProperty * prop, int value) {
	grid->SetPropertyValue(prop, static_cast<bool>(value));
}

void bmx_wxpropertygrid_setpropertyvaluedouble(wxPropertyGrid * grid, wxPGProperty * prop, double value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyvalueint(wxPropertyGrid * grid, wxPGProperty * prop, int value) {
	grid->SetPropertyValue(prop, value);
}

void bmx_wxpropertygrid_setpropertyreadonlybyname(wxPropertyGrid * grid, BBString * name, int set) {
	grid->SetPropertyReadOnly(wxStringFromBBString(name), static_cast<bool>(set));
}

void bmx_wxpropertygrid_setpropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name) {
	grid->SetPropertyValueUnspecified(wxStringFromBBString(name));
}

void bmx_wxpropertygrid_setpropertyvalueintarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	wxArrayInt a = bbIntArrayTowxArrayInt(value);
	wxVariant v;
	v << a;
	grid->SetPropertyValue(wxStringFromBBString(name), v);
}

void bmx_wxpropertygrid_setpropertyvalueulongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluelongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluesizebyname(wxPropertyGrid * grid, BBString * name, int w, int h) {
	wxSize s(w, h);
	wxVariant v;
	v << s;
	grid->SetPropertyValue(wxStringFromBBString(name), v);
}

void bmx_wxpropertygrid_setpropertyvaluepointbyname(wxPropertyGrid * grid, BBString * name, int x, int y) {
	wxPoint p(x, y);
	wxVariant v;
	v << p;
	grid->SetPropertyValue(wxStringFromBBString(name), v);
}

void bmx_wxpropertygrid_setpropertyvaluebyteptrbyname(wxPropertyGrid * grid, BBString * name, void * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), value);
}

void bmx_wxpropertygrid_setpropertyvaluestringbyname(wxPropertyGrid * grid, BBString * name, BBString * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), wxStringFromBBString(value));
}

void bmx_wxpropertygrid_setpropertyvaluedatetimebyname(wxPropertyGrid * grid, BBString * name, MaxDateTime * time) {
	grid->SetPropertyValue(wxStringFromBBString(name), time);
}

void bmx_wxpropertygrid_setpropertyvaluestringarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	grid->SetPropertyValue(wxStringFromBBString(name), bbStringArrayTowxArrayStr(value));
}

void bmx_wxpropertygrid_setpropertyvalueboolbyname(wxPropertyGrid * grid, BBString * name, int value) {
	grid->SetPropertyValue(wxStringFromBBString(name), static_cast<bool>(value));
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

int bmx_wxpropertygrid_hidepropertybyname(wxPropertyGrid * grid, BBString * name, int hide) {
	return static_cast<int>(grid->HideProperty(wxStringFromBBString(name), static_cast<bool>(hide)));
}

wxPGProperty * bmx_wxpropertygrid_insertbyname(wxPropertyGrid * grid, BBString * parent, int index, wxPGProperty * newproperty) {
	return grid->Insert(wxStringFromBBString(parent), index, newproperty);
}

void bmx_wxpropertygrid_clear(wxPropertyGrid * grid) {
	grid->Clear();
}

void bmx_wxpropertygrid_clearmodifiedstatus(wxPropertyGrid * grid) {
	grid->ClearModifiedStatus();
}

void bmx_wxpropertygrid_clearpropertymodifiedstatus(wxPropertyGrid * grid, wxPGProperty * prop) {
	prop->SetModifiedStatus(false);
}

void bmx_wxpropertygrid_clearpropertymodifiedstatusbyname(wxPropertyGrid * grid, BBString * name) {
	wxPGProperty * prop = grid->GetPropertyByLabel(wxStringFromBBString(name));
	if (prop) {
		prop->SetModifiedStatus(false);
	}
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

BBArray * bmx_wxpropertygrid_getpropertieswithflag(wxPropertyGrid * grid, int flags, int inverse, int iterFlags) {
	wxArrayPGProperty arr;
	
	grid->GetPropertiesWithFlag(&arr, flags, static_cast<bool>(inverse), iterFlags);
	
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
	
    for (int i=0; i< arr.size(); i++ ) {
        names.Add( arr[i]->GetName() );
	}

	
	return wxArrayStringToBBStringArray(names);
}

BBArray * bmx_wxpropertygrid_namestoproperties(wxPropertyGrid * grid, BBArray * names) {

	wxArrayString arr = bbStringArrayTowxArrayStr(names);

	wxArrayPGProperty props;
	
	for ( int i=0; i<arr.size(); i++ ) {
		wxPGProperty* p = grid->GetPropertyByName(arr[i]);
		if ( p ) {
			props.push_back(p);
		}
	}
	
	int n = props.GetCount();
	BBArray * properties = _wx_wxpropgrid_wxPropertyGrid__newPropertiesArray(n);
	for( int i=0;i<n;++i ){
		_wx_wxpropgrid_wxPropertyGrid__addProperty(properties, i, props[i]);
	}

	return properties;
}

void bmx_wxpropertygrid_centersplitter(wxPropertyGrid * grid, int enableAutoCentering) {
	grid->CenterSplitter(static_cast<bool>(enableAutoCentering));
}

int bmx_wxpropertygrid_getsplitterposition(wxPropertyGrid * grid) {
	return grid->GetSplitterPosition();
}

void bmx_wxpropertygrid_setsplitterleft(wxPropertyGrid * grid, int subProps) {
	grid->SetSplitterLeft(static_cast<bool>(subProps));
}

void bmx_wxpropertygrid_setsplitterposition(wxPropertyGrid * grid, int xPos, int refresh) {
	grid->SetSplitterPosition(xPos, static_cast<bool>(refresh));
}

int bmx_wxpropertygrid_commitchangesfromeditor(wxPropertyGrid * grid, int flags) {
	return static_cast<int>(grid->CommitChangesFromEditor(flags));
}

int bmx_wxpropertygrid_selectproperty(wxPropertyGrid * grid, wxPGProperty * prop, int focus) {
	return static_cast<int>(grid->SelectProperty(prop, static_cast<bool>(focus)));
}


int bmx_wxpropertygrid_changepropertyvalueintarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	wxArrayInt arr = bbIntArrayTowxArrayInt(value);
	wxVariant v = WXVARIANT(arr);
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvalueintarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	wxArrayInt arr = bbIntArrayTowxArrayInt(value);
	wxVariant v = WXVARIANT(arr);
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvalueulong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	wxVariant v = WXVARIANT(wxULongLong(value));
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvalueulongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	wxVariant v = WXVARIANT(wxULongLong(value));
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvaluelong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value) {
	wxLongLong a = value;
	wxVariant v(a);
	//v << a;
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvaluelongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value) {
	wxLongLong a = value;
	wxVariant v(a);
	//v << a;
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvaluesize(wxPropertyGrid * grid, wxPGProperty * prop, int w, int h) {
	wxVariant v = WXVARIANT(wxSize(w, h));
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvaluesizebyname(wxPropertyGrid * grid, BBString * name, int w, int h) {
	wxVariant v = WXVARIANT(wxSize(w, h));
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvaluepoint(wxPropertyGrid * grid, wxPGProperty * prop, int x, int y) {
	wxVariant v = WXVARIANT(wxPoint(x, y));
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvaluepointbyname(wxPropertyGrid * grid, BBString * name, int x, int y) {
	wxVariant v = WXVARIANT(wxPoint(x, y));
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvaluebyteptr(wxPropertyGrid * grid, wxPGProperty * prop, void * value) {
	return static_cast<int>(grid->ChangePropertyValue(prop, value));
}

int bmx_wxpropertygrid_changepropertyvaluebyteptrbyname(wxPropertyGrid * grid, BBString * name, void * value) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), value));
}

int bmx_wxpropertygrid_changepropertyvaluestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * value) {
	return static_cast<int>(grid->ChangePropertyValue(prop, wxStringFromBBString(value)));
}

int bmx_wxpropertygrid_changepropertyvaluestringbyname(wxPropertyGrid * grid, BBString * name, BBString * value) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), wxStringFromBBString(value)));
}

int bmx_wxpropertygrid_changepropertyvaluedatetime(wxPropertyGrid * grid, wxPGProperty * prop, MaxDateTime * time) {
	return static_cast<int>(grid->ChangePropertyValue(prop, time->DateTime()));
}

int bmx_wxpropertygrid_changepropertyvaluedatetimebyname(wxPropertyGrid * grid, BBString * name, MaxDateTime * time) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), time->DateTime()));
}

int bmx_wxpropertygrid_changepropertyvaluestringarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value) {
	wxArrayString arr = bbStringArrayTowxArrayStr(value);
	wxVariant v = WXVARIANT(arr);
	return static_cast<int>(grid->ChangePropertyValue(prop, v));
}

int bmx_wxpropertygrid_changepropertyvaluestringarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value) {
	wxArrayString arr = bbStringArrayTowxArrayStr(value);
	wxVariant v = WXVARIANT(arr);
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), v));
}

int bmx_wxpropertygrid_changepropertyvaluebool(wxPropertyGrid * grid, wxPGProperty * prop, int value) {
	return static_cast<int>(grid->ChangePropertyValue(prop, static_cast<bool>(value)));
}

int bmx_wxpropertygrid_changepropertyvalueboolbyname(wxPropertyGrid * grid, BBString * name, int value) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), static_cast<bool>(value)));
}

int bmx_wxpropertygrid_changepropertyvaluedouble(wxPropertyGrid * grid, wxPGProperty * prop, double value) {
	return static_cast<int>(grid->ChangePropertyValue(prop, value));
}

int bmx_wxpropertygrid_changepropertyvaluedoublebyname(wxPropertyGrid * grid, BBString * name, double value) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), value));
}

int bmx_wxpropertygrid_changepropertyvalueint(wxPropertyGrid * grid, wxPGProperty * prop, int value) {
	return static_cast<int>(grid->ChangePropertyValue(prop, value));
}

int bmx_wxpropertygrid_changepropertyvalueintbyname(wxPropertyGrid * grid, BBString * name, int value) {
	return static_cast<int>(grid->ChangePropertyValue(wxStringFromBBString(name), value));
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

int bmx_wxpgchoices_isok(MaxPGChoices * choices) {
	return static_cast<int>(choices->Choices().IsOk());
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
		(values != &bbEmptyArray) ? bbIntArrayTowxArrayInt(values) : wxArrayInt());
}

void bmx_wxpgchoices_clear(MaxPGChoices * choices) {
	choices->Choices().Clear();
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

void bmx_wxpgproperty_setattributebool(wxPGProperty * prop, BBString * name, int value) {
	prop->SetAttribute(wxStringFromBBString(name), static_cast<bool>(value));
}

void bmx_wxpgproperty_addchild(wxPGProperty * prop, wxPGProperty * child) {
	prop->AppendChild(child);
}

int bmx_wxpgproperty_addchoice(wxPGProperty * prop, BBString * label, int value) {
	return prop->AddChoice(wxStringFromBBString(label), value);
}

void bmx_wxpgproperty_deletechoice(wxPGProperty * prop, int index) {
	prop->DeleteChoice(index);
}

void bmx_wxpgproperty_deletechildren(wxPGProperty * prop) {
	prop->DeleteChildren();
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

int bmx_wxpgproperty_hasflag(wxPGProperty * prop, int flag) {
	return static_cast<int>(prop->HasFlag((wxPGPropertyFlags)flag));
}

int bmx_wxpgproperty_hide(wxPGProperty * prop, int hide) {
	return static_cast<int>(prop->Hide(static_cast<bool>(hide)));
}

int bmx_wxpgproperty_iscategory(wxPGProperty * prop) {
	return static_cast<int>(prop->IsCategory());
}

int bmx_wxpgproperty_isenabled(wxPGProperty * prop) {
	return static_cast<int>(prop->IsEnabled());
}

int bmx_wxpgproperty_isexpanded(wxPGProperty * prop) {
	return static_cast<int>(prop->IsExpanded());
}

int bmx_wxpgproperty_isroot(wxPGProperty * prop) {
	return static_cast<int>(prop->IsRoot());
}

int bmx_wxpgproperty_issubproperty(wxPGProperty * prop) {
	return static_cast<int>(prop->IsSubProperty());
}

int bmx_wxpgproperty_isvalueunspecified(wxPGProperty * prop) {
	return static_cast<int>(prop->IsValueUnspecified());
}

int bmx_wxpgproperty_isvisible(wxPGProperty * prop) {
	return static_cast<int>(prop->IsVisible());
}

wxPGProperty * bmx_wxpgproperty_item(wxPGProperty * prop, int i) {
	return prop->Item(i);
}

wxPGProperty * bmx_wxpgproperty_last(wxPGProperty * prop) {
	return prop->Last();
}

int bmx_wxpgproperty_recreateeditor(wxPGProperty * prop) {
	return static_cast<int>(prop->RecreateEditor());
}

void bmx_wxpgproperty_refreshchildren(wxPGProperty * prop) {
	prop->RefreshChildren();
}

void bmx_wxpgproperty_refresheditor(wxPGProperty * prop) {
	prop->RefreshEditor();
}

void bmx_wxpgproperty_setexpanded(wxPGProperty * prop, int expanded) {
	prop->SetExpanded(static_cast<bool>(expanded));
}

void bmx_wxpgproperty_setflag(wxPGProperty * prop, int flag) {
	prop->SetFlag((wxPGPropertyFlags)flag);
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

int bmx_wxpgproperty_setmaxlength(wxPGProperty * prop, int maxLen) {
	return static_cast<int>(prop->SetMaxLength(maxLen));
}

void bmx_wxpgproperty_clearflag(wxPGProperty * prop, int flag) {
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
	wxVariant v = prop->GetAttribute(wxStringFromBBString(name));
	//wxLongLong a;
	//a << v;
	*value = v.GetLongLong().GetValue();
}

BBString * bmx_wxpgproperty_getdisplayedstring(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetDisplayedString());
}

int bmx_wxpgproperty_getflags(wxPGProperty * prop) {
	return prop->GetFlags();
}

BBString * bmx_wxpgproperty_getflagsasstring(wxPGProperty * prop, int flagsMask) {
	return bbStringFromWxString(prop->GetFlagsAsString(flagsMask));
}

wxPropertyGrid * bmx_wxpgproperty_getgrid(wxPGProperty * prop) {
	return prop->GetGrid();
}

BBString * bmx_wxpgproperty_gethelpstring(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetHelpString());
}

void bmx_wxpgproperty_getimagesize(wxPGProperty * prop, int * w, int * h) {
	wxSize s = prop->GetGrid()->GetImageSize(prop);
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

BBString * bmx_wxpgproperty_getvaluetype(wxPGProperty * prop) {
	return bbStringFromWxString(prop->GetValueType());
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

void bmx_wxpgproperty_setvaluebool(wxPGProperty * prop, int value) {
	prop->SetValue(static_cast<bool>(value));
}

void bmx_wxpgproperty_setvaluedouble(wxPGProperty * prop, double value) {
	prop->SetValue(value);
}

void bmx_wxpgproperty_setvalueint(wxPGProperty * prop, int value) {
	prop->SetValue(value);
}

BBArray * bmx_wxpgproperty_getvalueasarrayint(wxPGProperty * prop) {
	wxArrayInt a;
	wxVariant v = prop->GetValue();
	a << v;
	return wxArrayIntToBBIntArray(a);
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

int bmx_wxpgproperty_getvalueasbool(wxPGProperty * prop) {
	return static_cast<int>(prop->GetValue().GetBool());
}

long bmx_wxpgproperty_getvalueasint(wxPGProperty * prop) {
	return prop->GetValue().GetLong();
}

void bmx_wxpgproperty_getvalueaslong(wxPGProperty * prop, BBInt64 * value) {
	wxVariant v = prop->GetValue();
	//wxLongLong ll;
	//ll << v;
	*value = v.GetLongLong().GetValue();
}

void bmx_wxpgproperty_getvalueaspoint(wxPGProperty * prop, int * x, int * y) {
	wxPoint p;
	wxVariant v = prop->GetValue();
	p << v;
	*x = p.x;
	*y = p.y;
}

void bmx_wxpgproperty_getvalueassize(wxPGProperty * prop, int * w, int * h) {
	wxSize s;
	wxVariant v = prop->GetValue();
	s << v;
	*w = s.x;
	*h = s.y;
}

void bmx_wxpgproperty_setvaluecolour(wxPGProperty * prop, MaxColour * value) {
	wxVariant v = WXVARIANT(value->Colour());
	prop->SetValue(v);
}

unsigned int bmx_wxpgproperty_getchoicecount(wxPGProperty * prop) {
	const wxPGChoices& choices = prop->GetChoices();
	if ( &choices && choices.IsOk() ) {
		return choices.GetCount();
	}
	return 0;
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
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(values) ? bbIntArrayTowxArrayInt(values) : wxArrayInt(),
		value);
}

wxEnumProperty * bmx_wxenumproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, int value) {
	return new MaxEnumProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		choices->Choices(),
		value);
}

// *********************************************

wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * value) {
	return new MaxMultiChoiceProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		(labels) ? bbStringArrayTowxArrayStr(labels) : wxArrayString(),
		(value) ? bbStringArrayTowxArrayStr(value) : wxArrayString() );
}

wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, BBArray * value) {
	return new MaxMultiChoiceProperty(handle, 
		(label != &bbEmptyString) ? wxStringFromBBString(label) : wxT("_LABEL_AS_NAME"),
		(name != &bbEmptyString) ? wxStringFromBBString(name) : wxStringFromBBString(label),
		choices->Choices(),
		(value) ? bbStringArrayTowxArrayStr(value) : wxArrayString() );
}

BBArray * bmx_wxmultichoiceproperty_getvalueasarrayint(wxMultiChoiceProperty * prop) {
	return wxArrayIntToBBIntArray(prop->GetValueAsArrayInt());
}

void bmx_wxmultichoiceproperty_setvalueintarray(MaxMultiChoiceProperty * prop, BBArray * value) {
	prop->SetValueIntArray(bbIntArrayTowxArrayInt(value));
}

// *********************************************

wxPGProperty * bmx_wxpropertygridevent_getmainparent(wxPropertyGridEvent & event) {
	return event.GetMainParent();
}

wxPGProperty * bmx_wxpropertygridevent_getproperty(wxPropertyGridEvent & event) {
	return event.GetProperty();
}

int bmx_wxpropertygridevent_canveto(wxPropertyGridEvent & event) {
	return static_cast<int>(event.CanVeto());
}

void bmx_wxpropertygridevent_veto(wxPropertyGridEvent & event, int value) {
	event.Veto(static_cast<bool>(value));
}

BBArray * bmx_wxpropertygridevent_getvalueasarrayint(wxPropertyGridEvent & event) {
	wxArrayInt a;
	wxVariant v = event.GetValue();
	a << v;
	return wxArrayIntToBBIntArray(a);
}

BBArray * bmx_wxpropertygridevent_getvalueasarraystring(wxPropertyGridEvent & event) {
	return wxArrayStringToBBStringArray(event.GetValue().GetArrayString());
}

int bmx_wxpropertygridevent_getvalueasbool(wxPropertyGridEvent & event) {
	return static_cast<int>(event.GetValue().GetBool());
}

double bmx_wxpropertygridevent_getvalueasdouble(wxPropertyGridEvent & event) {
	return event.GetValue().GetDouble();
}

long bmx_wxpropertygridevent_getvalueasint(wxPropertyGridEvent & event) {
	return event.GetValue().GetLong();
}

void bmx_wxpropertygridevent_getvalueaspoint(wxPropertyGridEvent & event, int * x, int * y) {
	wxPoint s;
	wxVariant v = event.GetValue();
	s << v;
	*x = s.x;
	*y = s.y;
}

void bmx_wxpropertygridevent_getvalueassize(wxPropertyGridEvent & event, int * w, int * h) {
	wxSize s;
	wxVariant v = event.GetValue();
	s << v;
	*w = s.x;
	*h = s.y;
}

BBString * bmx_wxpropertygridevent_getvalueasstring(wxPropertyGridEvent & event) {
	return bbStringFromWxString(event.GetValue().GetString());
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

// *********************************************
/*
void bmx_wxpropertygrid_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxPropertyGridXmlHandler);
}
*/