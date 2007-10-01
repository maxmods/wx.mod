/*
  Copyright (c) 2007 Bruce A Henderson
 
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
#include "wx/sheet/sheet.h"
#include "wx/sheet/sheetspt.h"
#include "wx/sheet/sheetedt.h"
#include "wx/sheet/sheetren.h"

class MaxSheet;
class MaxSheetSplitter;
class MaxSheetCellEditor;
class MaxSheetCellRenderer;
class MaxSheetCellAttr;

extern "C" {

#include <blitz.h>

	MaxSheet * bmx_wxsheet_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	bool bmx_wxsheet_creategrid(wxSheet * sheet, int numRows, int numCols, int options);
	int bmx_wxsheet_getnumberrows(wxSheet * sheet);
	int bmx_wxsheet_getnumbercols(wxSheet * sheet);
	bool bmx_wxsheet_containscell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containsgridrow(wxSheet * sheet, int row);
	bool bmx_wxsheet_containsgridcol(wxSheet * sheet, int col);
	bool bmx_wxsheet_containsgridcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containsrowlabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containscollabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_isgridcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_islabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_isrowlabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_iscollabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_iscornerlabelcell(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_clearvalues(wxSheet * sheet, int update);
	bool bmx_wxsheet_insertrows(wxSheet * sheet, int row, int numRows, int update);
	bool bmx_wxsheet_appendrows(wxSheet * sheet, int numRows, int update);
	bool bmx_wxsheet_deleterows(wxSheet * sheet, int row, int numRows, int update);
	bool bmx_wxsheet_insertcols(wxSheet * sheet, int col, int numCols, int update);
	bool bmx_wxsheet_appendcols(wxSheet * sheet, int numCols, int update);
	bool bmx_wxsheet_deletecols(wxSheet * sheet, int col, int numCols, int update);
	void bmx_wxsheet_setrowheight(wxSheet * sheet, int row, int height, bool ignoreMinSize);
	void bmx_wxsheet_setcolwidth(wxSheet * sheet, int col, int width, bool ignoreMinSize);
	int bmx_wxsheet_getrowheight(wxSheet * sheet, int row);
	int bmx_wxsheet_getrowtop(wxSheet * sheet, int row);
	int bmx_wxsheet_getrowbottom(wxSheet * sheet, int row);
	int bmx_wxsheet_getcolwidth(wxSheet * sheet, int col);
	int bmx_wxsheet_getcolleft(wxSheet * sheet, int col);
	int bmx_wxsheet_getcolright(wxSheet * sheet, int col);
	BBString * bmx_wxsheet_getcellvalue(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_setcellvalue(wxSheet * sheet, int row, int col, BBString * value);
	int bmx_wxsheet_hascellvalue(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_setattrrenderer(wxSheet * sheet, int row, int col, MaxSheetCellRenderer * renderer, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattreditor(wxSheet * sheet, int row, int col, MaxSheetCellEditor * editor, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrreadonly(wxSheet * sheet, int row, int col, bool isReadOnly, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrorientation(wxSheet * sheet, int row, int col, int orientation, wxSheetAttr_Type attrType);

	void bmx_wxsheet_setattrbackgroundcolour(wxSheet * sheet, int row, int col, MaxColour * colour, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrforegroundcolour(wxSheet * sheet, int row, int col, MaxColour * colour, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrfont(wxSheet * sheet, int row, int col, MaxFont * font, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattralignment(wxSheet * sheet, int row, int col, int align, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrlevel(wxSheet * sheet, int row, int col, int level, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattroverflow(wxSheet * sheet, int row, int col, bool allow, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattroverflowmarker(wxSheet * sheet, int row, int col, bool drawMarker, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrshoweditor(wxSheet * sheet, int row, int col, bool showEditor, wxSheetAttr_Type attrType);
	MaxColour * bmx_wxsheet_getattrbackgroundcolour(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxColour * bmx_wxsheet_getattrforegroundcolour(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxFont * bmx_wxsheet_getattrfont(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattralignment(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattrorientation(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattrlevel(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattroverflow(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattroverflowmarker(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattrshoweditor(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattrreadonly(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellRenderer * bmx_wxsheet_getattrrenderer(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellEditor * bmx_wxsheet_getattreditor(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setcolformatbool(wxSheet * sheet, int col);
	void bmx_wxsheet_setcolformatnumber(wxSheet * sheet, int col);
	void bmx_wxsheet_setcolformatfloat(wxSheet * sheet, int col, int width, int precision);
	void bmx_wxsheet_setcolformatcustom(wxSheet * sheet, int col, BBString * typeName);
	bool bmx_wxsheet_iscellvisible(wxSheet * sheet, int row, int col, bool wholeCellVisible);
	bool bmx_wxsheet_isrowvisible(wxSheet * sheet, int row, bool wholeRowVisible);
	bool bmx_wxsheet_iscolvisible(wxSheet * sheet, int col, bool wholeColVisible);
	void bmx_wxsheet_makecellvisible(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_getgridcursorcell(wxSheet * sheet, int * row, int * col);
	int bmx_wxsheet_getgridcursorrow(wxSheet * sheet);
	int bmx_wxsheet_getgridcursorcol(wxSheet * sheet);
	void bmx_wxsheet_setgridcursorcell(wxSheet * sheet, int row, int col);

	MaxSheetCellAttr * bmx_wxsheet_getorcreateattr(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellAttr * bmx_wxsheet_getattr(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattr(wxSheet * sheet, int row, int col, MaxSheetCellAttr * attr, wxSheetAttr_Type attrType);
	MaxSheetCellAttr * bmx_wxsheet_getgridattr(wxSheet * sheet, int row, int col);
	MaxSheetCellAttr * bmx_wxsheet_getgridcellattr(wxSheet * sheet, int row, int col);
	MaxSheetCellAttr * bmx_wxsheet_getgridrowattr(wxSheet * sheet, int row);
	MaxSheetCellAttr * bmx_wxsheet_getgridcolattr(wxSheet * sheet, int col);
	void bmx_wxsheet_setgridcellattr(wxSheet * sheet, int row, int col, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setgridrowattr(wxSheet * sheet, int row, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setgridcolattr(wxSheet * sheet, int col, MaxSheetCellAttr * attr);

	MaxSheetSplitter * bmx_wxsheetsplitter_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	void bmx_wxsheetsplitter_initialize(wxSheetSplitter * splitter, wxSheet * sheet);


	void bmx_wxsheettable_setview(wxSheetTable * table, wxSheet * sheet);
	int bmx_wxsheettable_getnumberrows(wxSheetTable * table);
	int bmx_wxsheettable_getnumbercols(wxSheetTable * table);
	bool bmx_wxsheettable_containsgridrow(wxSheetTable * table, int row);
	bool bmx_wxsheettable_containsgridcol(wxSheetTable * table, int col);
	bool bmx_wxsheettable_containsgridcell(wxSheetTable * table, int row, int col);
	BBString * bmx_wxsheettable_getvalue(wxSheetTable * table, int row, int col);
	void bmx_wxsheettable_setvalue(wxSheetTable * table, int row, int col, BBString * value);
	bool bmx_wxsheettable_hasvalue(wxSheetTable * table, int row, int col);
	int bmx_wxsheettable_getfirstnonemptycoltoleft(wxSheetTable * table, int row, int col);
	void bmx_wxsheettable_clearvalues(wxSheetTable * table, int update);
	BBString * bmx_wxsheettable_getdefaultrowlabelvalue(wxSheetTable * table, int row);
	BBString * bmx_wxsheettable_getdefaultcollabelvalue(wxSheetTable * table, int col);
	long bmx_wxsheettable_getvalueasint(wxSheetTable * table, int row, int col);
	double bmx_wxsheettable_getvalueasdouble(wxSheetTable * table, int row, int col);
	bool bmx_wxsheettable_getvalueasbool(wxSheetTable * table, int row, int col);


	MaxSheetCellEditor * bmx_wxsheetcelleditor_create(wxSheetCellEditorRefData * data);
	void bmx_wxsheetcelleditor_delete(MaxSheetCellEditor * editor);

	wxSheetCellAutoWrapStringEditorRefData * bmx_wxsheetcellautowrapstringeditorrefdata_create();

	MaxSheetCellRenderer * bmx_wxsheetcellrenderer_create(wxSheetCellRendererRefData * data);
	void bmx_wxsheetcellrenderer_delete(MaxSheetCellRenderer * renderer);
	
	wxSheetCellAutoWrapStringRendererRefData * bmx_wxsheetcellautowrapstringrendererrefdata_create();


	MaxSheetCellAttr * bmx_wxsheetcellattr_create(bool createData);
	void bmx_wxsheetcellattr_setforegroundcolour(MaxSheetCellAttr * attr, MaxColour * colour);
	void bmx_wxsheetcellattr_setbackgroundcolour(MaxSheetCellAttr * attr, MaxColour * colour);
	void bmx_wxsheetcellattr_setfont(MaxSheetCellAttr * attr, MaxFont * font);
	void bmx_wxsheetcellattr_setalignment(MaxSheetCellAttr * attr, int align);
	void bmx_wxsheetcellattr_setalignmenthv(MaxSheetCellAttr * attr, int horzAlign, int vertAlign);
	void bmx_wxsheetcellattr_setorientation(MaxSheetCellAttr * attr, int orientation);
	void bmx_wxsheetcellattr_setlevel(MaxSheetCellAttr * attr, wxSheetAttrLevel_Type level);
	void bmx_wxsheetcellattr_setoverflow(MaxSheetCellAttr * attr, bool allow);
	void bmx_wxsheetcellattr_setoverflowmarker(MaxSheetCellAttr * attr, bool drawMarker);
	void bmx_wxsheetcellattr_setshoweditor(MaxSheetCellAttr * attr, bool showEditor);
	void bmx_wxsheetcellattr_setreadonly(MaxSheetCellAttr * attr, bool isReadOnly);
	void bmx_wxsheetcellattr_setrenderer(MaxSheetCellAttr * attr, MaxSheetCellRenderer * renderer);
	void bmx_wxsheetcellattr_seteditor(MaxSheetCellAttr * attr, MaxSheetCellEditor * editor);
	void bmx_wxsheetcellattr_setkind(MaxSheetCellAttr * attr, wxSheetAttr_Type kind);
	bool bmx_wxsheetcellattr_hasforegroundcolour(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasbackgroundcolour(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasfont(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasalignment(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasorientation(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_haslevel(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasoverflowmode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasoverflowmarkermode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasshoweditormode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasreadwritemode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasrenderer(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_haseditor(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasdefaultattr(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_iscomplete(MaxSheetCellAttr * attr);
	MaxColour * bmx_wxsheetcellattr_getforegroundcolour(MaxSheetCellAttr * attr);
	MaxColour * bmx_wxsheetcellattr_getbackgroundcolour(MaxSheetCellAttr * attr);
	MaxFont * bmx_wxsheetcellattr_getfont(MaxSheetCellAttr * attr);
	int bmx_wxsheetcellattr_getalignment(MaxSheetCellAttr * attr);
	wxOrientation bmx_wxsheetcellattr_getorientation(MaxSheetCellAttr * attr);
	wxSheetAttrLevel_Type bmx_wxsheetcellattr_getlevel(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getoverflow(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getoverflowmarker(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getshoweditor(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getreadonly(MaxSheetCellAttr * attr);
	MaxSheetCellRenderer * bmx_wxsheetcellattr_getrenderer(MaxSheetCellAttr * attr, wxSheet * sheet, int row, int col);
	MaxSheetCellEditor * bmx_wxsheetcellattr_geteditor(MaxSheetCellAttr * attr, wxSheet * sheet, int row, int col);
	wxSheetAttr_Type bmx_wxsheetcellattr_getkind(MaxSheetCellAttr * attr);
	void bmx_wxsheetcellattr_delete(MaxSheetCellAttr * attr);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSheet : public wxSheet
{
public:
	MaxSheet(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSheet();
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

class MaxSheetSplitter : public wxSheetSplitter
{
public:
	MaxSheetSplitter(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSheetSplitter();
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};


class MaxSheetCellEditor
{
public:
	MaxSheetCellEditor(const wxSheetCellEditor & e);
	wxSheetCellEditor & Editor();

private:
	wxSheetCellEditor editor;

};

class MaxSheetCellRenderer
{
public:
	MaxSheetCellRenderer(const wxSheetCellRenderer & r);
	wxSheetCellRenderer & Renderer();

private:
	wxSheetCellRenderer renderer;

};

class MaxSheetCellAttr
{
public:
	MaxSheetCellAttr(const wxSheetCellAttr & a);
	wxSheetCellAttr & Attr();

private:
	wxSheetCellAttr attr;

};
