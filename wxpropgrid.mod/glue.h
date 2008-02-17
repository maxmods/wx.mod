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

#include "wxglue.h"
#include "wx/propgrid/propgrid.h"
#include "wx/propgrid/advprops.h"
#include "../wxdatetime.mod/glue.h"
#include "../wxbitmap.mod/glue.h"

class MaxPropertyGrid;
class MaxPGPropArg;
class MaxColourPropertyValue;
class MaxPGChoices;
class MaxPGChoiceEntry;
class MaxIntProperty;
class MaxUIntProperty;
class MaxFloatProperty;
class MaxBoolProperty;
class MaxFlagsProperty;
class MaxFileProperty;
class MaxLongStringProperty;
class MaxDirProperty;
class MaxArrayStringProperty;
class MaxCursorProperty;
class MaxImageFileProperty;
class MaxDateProperty;
class MaxMultiChoiceProperty;
	
extern "C" {

#include <blitz.h>

	wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	wxPGProperty * bmx_wxpropertycontainermethods_append(wxPropertyContainerMethods * prop, wxPGProperty * property);
	wxPropertyGrid * bmx_wxpropertygrid_getgrid(wxPropertyGrid * grid);
	wxPGProperty * bmx_wxpropertygrid_append(wxPropertyGrid * prop, wxPGProperty * property);
	MaxColour * bmx_wxpropertygrid_getcaptionbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcaptionforegroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcellbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelldisabledtextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelltextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getlinecolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getmargincolour(wxPropertyGrid * grid);
	
	wxPGProperty * bmx_wxstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	
	wxPGProperty * bmx_wxpropertycategory_create(BBObject * handle, BBString * label, BBString * name);

	wxPGProperty * bmx_wxfontproperty_create(BBObject * handle, BBString * label, BBString * name, MaxFont * font);

	void bmx_wxpropertygrid_setpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * helpString);
	void bmx_wxpropertygrid_setpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name, BBString * helpString);

	wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value);

	void bmx_wxcolourpropertyvalue_delete(MaxColourPropertyValue * value);
	
	void bmx_wxpgproparg_delete(MaxPGPropArg * id);

	bool bmx_wxpropertygriditeratorbase_atend(wxPropertyGridIteratorBase * iter);
	wxPGProperty * bmx_wxpropertygriditeratorbase_getproperty(wxPropertyGridIteratorBase * iter);
	//wxPGPropertyWithChildren * bmx_wxpropertygriditeratorbase_getpropertywithchildren(wxPropertyGridIteratorBase * iter);
	void bmx_wxpropertygriditeratorbase_nextproperty(wxPropertyGridIteratorBase * iter, bool iterateChildren);
	void bmx_wxpropertygriditeratorbase_prevproperty(wxPropertyGridIteratorBase * iter);
	void bmx_wxpropertygriditeratorbase_setbaseparent(wxPropertyGridIteratorBase * iter, wxPGPropertyWithChildren * baseParent);

	wxIntProperty * bmx_wxintproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxUIntProperty * bmx_wxuintproperty_create(BBObject * handle, BBString * label, BBString * name, unsigned long value);
	wxFloatProperty * bmx_wxdoubleproperty_create(BBObject * handle, BBString * label, BBString * name, double value);
	wxBoolProperty * bmx_wxboolproperty_create(BBObject * handle, BBString * label, BBString * name, bool value);
	wxFlagsProperty * bmx_wxflagsproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * values, int value);
	wxFileProperty * bmx_wxfileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxLongStringProperty * bmx_wxlongstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxDirProperty * bmx_wxdirproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxArrayStringProperty * bmx_wxarraystringproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * value);
	wxCursorProperty * bmx_wxcursorproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxImageFileProperty * bmx_wximagefileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxDateProperty * bmx_wxdateproperty_create(BBObject * handle, BBString * label, BBString * name, MaxDateTime * value);

	MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertycolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertytextcolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxPropertyGrid * grid, BBString * name);
	MaxColour * bmx_wxpropertygrid_getpropertycolourbyname(wxPropertyGrid * grid, BBString * name);
	MaxColour * bmx_wxpropertygrid_getpropertytextcolourbyname(wxPropertyGrid * grid, BBString * name);

	void bmx_wxpropertygrid_beginaddchildren(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_beginaddchildrenbyname(wxPropertyGrid * grid, BBString * name);
	bool bmx_wxpropertygrid_clearpropertyvalue(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_clearpropertyvaluebyname(wxPropertyGrid * grid, BBString * name);
	bool bmx_wxpropertygrid_clearselection(wxPropertyGrid * grid);
	bool bmx_wxpropertygrid_collapse(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_collapsebyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_deleteproperty(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_deletepropertybyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_deletepropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, int index);
	void bmx_wxpropertygrid_deletepropertychoicebyname(wxPropertyGrid * grid, BBString * name, int index);
	bool bmx_wxpropertygrid_disableproperty(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_disablepropertybyname(wxPropertyGrid * grid, BBString * name);
	bool bmx_wxpropertygrid_enableproperty(wxPropertyGrid * grid, wxPGProperty * prop, bool enable);
	bool bmx_wxpropertygrid_enablepropertybyname(wxPropertyGrid * grid, BBString * name, bool enable);
	void bmx_wxpropertygrid_endaddchildren(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_endaddchildrenbyname(wxPropertyGrid * grid, BBString * name);


	void bmx_wxpropertygrid_setpropertyattribute(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, int value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributebyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, int value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, BBString * value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributestringbyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, BBString * value, int argFlags);

	bool bmx_wxpropertygrid_expand(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_expandbyname(wxPropertyGrid * grid, BBString * name);
	wxPGProperty * bmx_wxpropertygrid_getfirst(wxPropertyGrid * grid, int flags);
	wxPGProperty * bmx_wxpropertygrid_getnextsibling(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxPGChoices * bmx_wxpropertygrid_getpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyclassname(wxPropertyGrid * grid, wxPGProperty * prop);
	BBObject * bmx_wxpropertygrid_getpropertyclientdata(wxPropertyGrid * grid, wxPGProperty * prop);
	const wxPGEditor * bmx_wxpropertygrid_getpropertyeditor(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxBitmap * bmx_wxpropertygrid_getpropertyimage(wxPropertyGrid * grid, wxPGProperty * prop);
	unsigned int bmx_wxpropertygrid_getpropertyindex(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyname(wxPropertyGrid * grid, wxPGProperty * prop);
	wxPGProperty * bmx_wxpropertygrid_getpropertyparent(wxPropertyGrid * grid, wxPGProperty * prop);

	void bmx_wxpropertygrid_addpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int value);
	void bmx_wxpropertygrid_addpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int value);
	bool bmx_wxpropertygrid_setpropertymaxlength(wxPropertyGrid * grid, wxPGProperty * prop, int maxLen);
	bool bmx_wxpropertygrid_setpropertymaxlengthbyname(wxPropertyGrid * grid, BBString * name, int maxLen);
	void bmx_wxpropertygrid_setpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop, MaxPGChoices * choices);
	void bmx_wxpropertygrid_setpropertychoicesexclusive(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_setpropertychoicesbyname(wxPropertyGrid * grid, BBString * name, MaxPGChoices * choices);
	void bmx_wxpropertygrid_setpropertychoicesexclusivebyname(wxPropertyGrid * grid, BBString * name);

	wxPGProperty * bmx_wxpropertygrid_getpropertyptr(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyshortclassname(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyshortclassnamebyname(wxPropertyGrid * grid, BBString * name);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayint(wxPropertyGrid * grid, wxPGProperty * prop);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxPropertyGrid * grid, BBString * name);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystring(wxPropertyGrid * grid, wxPGProperty * prop);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxPropertyGrid * grid, BBString * name);
	bool bmx_wxpropertygrid_getpropertyvalueasbool(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxPropertyGrid * grid, BBString * name);
	MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetime(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetimebyname(wxPropertyGrid * grid, BBString * name);
	double bmx_wxpropertygrid_getpropertyvalueasdouble(wxPropertyGrid * grid, wxPGProperty * prop);
	double bmx_wxpropertygrid_getpropertyvalueasdoublebyname(wxPropertyGrid * grid, BBString * name);
	long bmx_wxpropertygrid_getpropertyvalueasint(wxPropertyGrid * grid, wxPGProperty * prop);
	long bmx_wxpropertygrid_getpropertyvalueasintbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_getpropertyvalueaslong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 * value);
	void bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 * value);
	void bmx_wxpropertygrid_getpropertyvalueaspoint(wxPropertyGrid * grid, wxPGProperty * prop, int * x, int * y);
	void bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxPropertyGrid * grid, BBString * name, int * x, int * y);
	void bmx_wxpropertygrid_getpropertyvalueassize(wxPropertyGrid * grid, wxPGProperty * prop, int * w, int * h);
	void bmx_wxpropertygrid_getpropertyvalueassizebyname(wxPropertyGrid * grid, BBString * name, int * w, int * h);
	BBString * bmx_wxpropertygrid_getpropertyvalueasstring(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyvalueasstringbyname(wxPropertyGrid * grid, BBString * name);
	BBString * bmx_wxpropertygrid_getpropertyvaluetype(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyvaluetypebyname(wxPropertyGrid * grid, BBString * name);
	wxPGProperty * bmx_wxpropertygrid_getselection(wxPropertyGrid * grid);
	bool bmx_wxpropertygrid_ispropertcategory(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_ispropertyenabled(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_ispropertyexpanded(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_ispropertymodified(wxPropertyGrid * grid, wxPGProperty * prop);
	bool bmx_wxpropertygrid_ispropertyshown(wxPropertyGrid * grid, wxPGProperty * prop);


	MaxPGChoices * bmx_wxpgchoices_create();
	void bmx_wxpgchoices_delete(MaxPGChoices * choices);
	MaxPGChoiceEntry * bmx_wxpgchoices_add(MaxPGChoices * choices, BBString * label, int value);
	void bmx_wxpgchoices_addentries(MaxPGChoices * choices, BBArray * labels, BBArray * values);
	MaxPGChoiceEntry * bmx_wxpgchoices_addassorted(MaxPGChoices * choices, BBString * label, int value);
	int bmx_wxpgchoices_getcount(MaxPGChoices * choices);
	BBString * bmx_wxpgchoices_getlabel(MaxPGChoices * choices, int index);
	BBArray * bmx_wxpgchoices_getlabels(MaxPGChoices * choices);
	int bmx_wxpgchoices_getvalue(MaxPGChoices * choices, int index);
	bool bmx_wxpgchoices_hasvalue(MaxPGChoices * choices, int value);
	bool bmx_wxpgchoices_hasvalues(MaxPGChoices * choices);
	int bmx_wxpgchoices_index(MaxPGChoices * choices, int value);
	int bmx_wxpgchoices_indexforlabel(MaxPGChoices * choices, BBString * label);
	MaxPGChoiceEntry * bmx_wxpgchoices_insert(MaxPGChoices * choices, BBString * label, int index, int value);
	bool bmx_wxpgchoices_isok(MaxPGChoices * choices);
	MaxPGChoiceEntry * bmx_wxpgchoices_item(MaxPGChoices * choices, int index);
	void bmx_wxpgchoices_removeat(MaxPGChoices * choices, int index, int count);
	void bmx_wxpgchoices_set(MaxPGChoices * choices, BBArray * labels, BBArray * values);


	MaxColour * bmx_wxpgchoiceentry_getbgcol(MaxPGChoiceEntry * entry);
	MaxBitmap * bmx_wxpgchoiceentry_getbitmap(MaxPGChoiceEntry * entry);
	MaxColour * bmx_wxpgchoiceentry_getfgcol(MaxPGChoiceEntry * entry);
	BBString * bmx_wxpgchoiceentry_gettext(MaxPGChoiceEntry * entry);
	void bmx_wxpgchoiceentry_setbgcol(MaxPGChoiceEntry * entry, MaxColour * col);
	void bmx_wxpgchoiceentry_setbitmap(MaxPGChoiceEntry * entry, MaxBitmap * bitmap);
	void bmx_wxpgchoiceentry_setfgcol(MaxPGChoiceEntry * entry, MaxColour * col);
	void bmx_wxpgchoiceentry_settext(MaxPGChoiceEntry * entry, BBString * text);
	void bmx_wxpgchoiceentry_delete(MaxPGChoiceEntry * entry);

	int bmx_wxpgchoiceentry_getvalue(MaxPGChoiceEntry * entry);
	bool bmx_wxpgchoiceentry_hasvalue(MaxPGChoiceEntry * entry);
	void bmx_wxpgchoiceentry_setvalue(MaxPGChoiceEntry * entry, int value);

	void bmx_wxpgproperty_setattributestring(wxPGProperty * prop, BBString * name, BBString * value);
	void bmx_wxpgproperty_setattributeint(wxPGProperty * prop, BBString * name, int value);
	void bmx_wxpgproperty_setattributedouble(wxPGProperty * prop, BBString * name, double value);
	void bmx_wxpgproperty_setattributebool(wxPGProperty * prop, BBString * name, bool value);

	wxEnumProperty * bmx_wxenumproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * values, int value);
	wxEnumProperty * bmx_wxenumproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, int value);

	wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * value);
	wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, BBArray * value);

	int bmx_wxpropertygrid_geteventtype(int type);

	wxPGProperty * bmx_wxpropertygridevent_getmainparent(wxPropertyGridEvent & event);
	wxPGProperty * bmx_wxpropertygridevent_getproperty(wxPropertyGridEvent & event);
	bool bmx_wxpropertygridevent_hasproperty(wxPropertyGridEvent & event);
	bool bmx_wxpropertygridevent_ispropertyenabled(wxPropertyGridEvent & event);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxPGPropArg
{
public:
	MaxPGPropArg(wxPGPropArg p);
	wxPGPropArgCls & PGId();

private:
	wxPGPropArgCls pgId;

};

class MaxPropertyGrid : public wxPropertyGrid
{
public:
	MaxPropertyGrid(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~ MaxPropertyGrid();
	
private:
    DECLARE_EVENT_TABLE();
};

class MaxColourPropertyValue
{
public:
	MaxColourPropertyValue(const wxColourPropertyValue & v);
	wxColourPropertyValue & Value();

private:
	wxColourPropertyValue value;

};

class MaxPGChoices
{
public:
	MaxPGChoices(const wxPGChoices & c);
	MaxPGChoices();
	wxPGChoices & Choices();

private:
	wxPGChoices choices;
};

class MaxPGChoiceEntry
{
public:
	MaxPGChoiceEntry(const wxPGChoiceEntry & e);
	wxPGChoiceEntry & Entry();

private:
	wxPGChoiceEntry entry;

};

class MaxPropertyCategory : public wxPropertyCategory
{
public:
	MaxPropertyCategory(BBObject * handle, const wxString &label, const wxString &name);
	~MaxPropertyCategory();
};

class MaxStringProperty : public wxStringProperty
{
public:
	MaxStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxStringProperty();
};

class MaxFontProperty : public wxFontProperty
{
public:
	MaxFontProperty(BBObject * handle, const wxString &label, const wxString &name, const wxFont &value);
	~MaxFontProperty();
};

class MaxSystemColourProperty : public wxSystemColourProperty
{
public:
	MaxSystemColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value);
	~MaxSystemColourProperty();
};

class MaxIntProperty : public wxIntProperty
{
public:
	MaxIntProperty(BBObject * handle, const wxString &label, const wxString &name, long value);
	~MaxIntProperty();
};

class MaxUIntProperty : public wxUIntProperty
{
public:
	MaxUIntProperty(BBObject * handle, const wxString &label, const wxString &name, unsigned long value);
	~MaxUIntProperty();
};

class MaxFloatProperty : public wxFloatProperty
{
public:
	MaxFloatProperty(BBObject * handle, const wxString &label, const wxString &name, double value);
	~MaxFloatProperty();
};

class MaxBoolProperty : public wxBoolProperty
{
public:
	MaxBoolProperty(BBObject * handle, const wxString &label, const wxString &name, bool value);
	~MaxBoolProperty();
};

class MaxFlagsProperty : public wxFlagsProperty
{
public:
	MaxFlagsProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value);
	~MaxFlagsProperty();
};

class MaxFileProperty : public wxFileProperty
{
public:
	MaxFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxFileProperty();
};

class MaxLongStringProperty : public wxLongStringProperty
{
public:
	MaxLongStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxLongStringProperty();
};

class MaxDirProperty : public wxDirProperty
{
public:
	MaxDirProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxDirProperty();
};

class MaxArrayStringProperty : public wxArrayStringProperty
{
public:
	MaxArrayStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &value);
	~MaxArrayStringProperty();
};

class MaxCursorProperty : public wxCursorProperty
{
public:
	MaxCursorProperty(BBObject * handle, const wxString &label, const wxString &name, int value);
	~MaxCursorProperty();
};

class MaxImageFileProperty : public wxImageFileProperty
{
public:
	MaxImageFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxImageFileProperty();
};

class MaxDateProperty : public wxDateProperty
{
public:
	MaxDateProperty(BBObject * handle, const wxString &label, const wxString &name, const wxDateTime &value);
	~MaxDateProperty();
};

class MaxEnumProperty : public wxEnumProperty
{
public:
	MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value);
	MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, int value);
	~MaxEnumProperty();
};

class MaxMultiChoiceProperty : public wxMultiChoiceProperty
{
public:
	MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &value);
	MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, const wxArrayInt &value);
	~MaxMultiChoiceProperty();
};

