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

class MaxPropertyGrid;
class MaxPGId;
class MaxColourPropertyValue;

extern "C" {

#include <blitz.h>

	wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxPGId * bmx_wxpropertygrid_append(wxPropertyGrid * grid, wxPGProperty * property);
	wxPropertyGrid * bmx_wxpropertygrid_getgrid(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcaptionbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcaptionforegroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcellbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelldisabledtextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelltextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getlinecolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getmargincolour(wxPropertyGrid * grid);
	
	wxPGProperty * bmx_wxstringproperty_create(BBString * label, BBString * name, BBString * value);
	
	wxPGProperty * bmx_wxpropertycategory_create(BBString * label, BBString * name);

	wxPGProperty * bmx_wxfontproperty_create(BBString * label, BBString * name, MaxFont * font);

	void bmx_wxpropertycontainermethods_setpropertyhelpstringid(wxPropertyContainerMethods * prop, MaxPGId * id, BBString * helpString);
	void bmx_wxpropertycontainermethods_setpropertyhelpstring(wxPropertyContainerMethods * prop, BBString * name, BBString * helpString);

	wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBString * label, BBString * name, MaxColour * value);

	void bmx_wxcolourpropertyvalue_delete(MaxColourPropertyValue * value);
	
	void bmx_wxpgid_delete(MaxPGId * id);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxPGId
{
public:
	MaxPGId(const wxPGId & p);
	wxPGId & PGId();

private:
	wxPGId pgId;

};

class MaxPropertyGrid : public wxPropertyGrid
{
public:
	MaxPropertyGrid(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~ MaxPropertyGrid();
	
};

class MaxColourPropertyValue
{
public:
	MaxColourPropertyValue(const wxColourPropertyValue & v);
	wxColourPropertyValue & Value();

private:
	wxColourPropertyValue value;

};

