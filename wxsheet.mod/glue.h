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
