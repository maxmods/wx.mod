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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxSheet::MaxSheet(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSheet(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSheet::~MaxSheet() {
	wxunbind(this);
}


MaxSheetSplitter::MaxSheetSplitter(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxSheetSplitter(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSheetSplitter::~MaxSheetSplitter() {
	wxunbind(this);
}


MaxSheetCellEditor::MaxSheetCellEditor(const wxSheetCellEditor& e)
{
	editor = e;
}

wxSheetCellEditor & MaxSheetCellEditor::Editor() {
	return editor;
}

MaxSheetCellRenderer::MaxSheetCellRenderer(const wxSheetCellRenderer& r)
{
	renderer = r;
}

wxSheetCellRenderer & MaxSheetCellRenderer::Renderer() {
	return renderer;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxSheet, wxSheet)
END_EVENT_TABLE()

MaxSheet * bmx_wxsheet_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSheet(handle, parent, id, x, y, w, h, style);
}

bool bmx_wxsheet_creategrid(wxSheet * sheet, int numRows, int numCols, int options) {
	return sheet->CreateGrid(numRows, numCols, options);
}

int bmx_wxsheet_getnumberrows(wxSheet * sheet) {
	return sheet->GetNumberRows();
}

int bmx_wxsheet_getnumbercols(wxSheet * sheet) {
	return sheet->GetNumberCols();
}

bool bmx_wxsheet_containscell(wxSheet * sheet, int row, int col) {
	return sheet->ContainsCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_containsgridrow(wxSheet * sheet, int row) {
	return sheet->ContainsGridRow(row);
}

bool bmx_wxsheet_containsgridcol(wxSheet * sheet, int col) {
	return sheet->ContainsGridCol(col);
}

bool bmx_wxsheet_containsgridcell(wxSheet * sheet, int row, int col) {
	return sheet->ContainsGridCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_containsrowlabelcell(wxSheet * sheet, int row, int col) {
	return sheet->ContainsRowLabelCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_containscollabelcell(wxSheet * sheet, int row, int col) {
	return sheet->ContainsColLabelCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_isgridcell(wxSheet * sheet, int row, int col) {
	return sheet->IsGridCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_islabelcell(wxSheet * sheet, int row, int col) {
	return sheet->IsLabelCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_isrowlabelcell(wxSheet * sheet, int row, int col) {
	return sheet->IsRowLabelCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_iscollabelcell(wxSheet * sheet, int row, int col) {
	return sheet->IsColLabelCell(wxSheetCoords(row, col));
}

bool bmx_wxsheet_iscornerlabelcell(wxSheet * sheet, int row, int col) {
	return sheet->IsCornerLabelCell(wxSheetCoords(row, col));
}

void bmx_wxsheet_clearvalues(wxSheet * sheet, int update) {
	sheet->ClearValues(update);
}

bool bmx_wxsheet_insertrows(wxSheet * sheet, int row, int numRows, int update) {
	return sheet->InsertRows(row, numRows, update);
}

bool bmx_wxsheet_appendrows(wxSheet * sheet, int numRows, int update) {
	return sheet->AppendRows(numRows, update);
}

bool bmx_wxsheet_deleterows(wxSheet * sheet, int row, int numRows, int update) {
	return sheet->DeleteRows(row, numRows, update);
}

bool bmx_wxsheet_insertcols(wxSheet * sheet, int col, int numCols, int update) {
	return sheet->InsertCols(col, numCols, update);
}

bool bmx_wxsheet_appendcols(wxSheet * sheet, int numCols, int update) {
	return sheet->AppendCols(numCols, update);
}

bool bmx_wxsheet_deletecols(wxSheet * sheet, int col, int numCols, int update) {
	return sheet->DeleteCols(col, numCols, update);
}

void bmx_wxsheet_setrowheight(wxSheet * sheet, int row, int height, bool ignoreMinSize) {
	sheet->SetRowHeight(row, height, ignoreMinSize);
}

void bmx_wxsheet_setcolwidth(wxSheet * sheet, int col, int width, bool ignoreMinSize) {
	sheet->SetColWidth(col, width, ignoreMinSize);
}

int bmx_wxsheet_getrowheight(wxSheet * sheet, int row) {
	return sheet->GetRowHeight(row);
}

int bmx_wxsheet_getrowtop(wxSheet * sheet, int row) {
	return sheet->GetRowTop(row);
}

int bmx_wxsheet_getrowbottom(wxSheet * sheet, int row) {
	return sheet->GetRowBottom(row);
}

int bmx_wxsheet_getcolwidth(wxSheet * sheet, int col) {
	return sheet->GetColWidth(col);
}

int bmx_wxsheet_getcolleft(wxSheet * sheet, int col) {
	return sheet->GetColLeft(col);
}

int bmx_wxsheet_getcolright(wxSheet * sheet, int col) {
	return sheet->GetColRight(col);
}

BBString * bmx_wxsheet_getcellvalue(wxSheet * sheet, int row, int col) {
	return bbStringFromWxString(sheet->GetCellValue(wxSheetCoords(row, col)));
}

void bmx_wxsheet_setcellvalue(wxSheet * sheet, int row, int col, BBString * value) {
	sheet->SetCellValue(wxSheetCoords(row, col), wxStringFromBBString(value));
}

int bmx_wxsheet_hascellvalue(wxSheet * sheet, int row, int col) {
	return sheet->HasCellValue(wxSheetCoords(row, col));
}

void bmx_wxsheet_setattrrenderer(wxSheet * sheet, int row, int col, MaxSheetCellRenderer * renderer, wxSheetAttr_Type attrType) {
	sheet->SetAttrRenderer(wxSheetCoords(row, col), renderer->Renderer(), attrType);
}

void bmx_wxsheet_setattreditor(wxSheet * sheet, int row, int col, MaxSheetCellEditor * editor, wxSheetAttr_Type attrType) {
	sheet->SetAttrEditor(wxSheetCoords(row, col), editor->Editor(), attrType);
}

void bmx_wxsheet_setattrreadonly(wxSheet * sheet, int row, int col, bool isReadOnly, wxSheetAttr_Type attrType) {
	sheet->SetAttrReadOnly(wxSheetCoords(row, col), isReadOnly, attrType);
}

void bmx_wxsheet_setattrorientation(wxSheet * sheet, int row, int col, int orientation, wxSheetAttr_Type attrType) {
	sheet->SetAttrOrientation(wxSheetCoords(row, col), orientation, attrType);
}



// *********************************************

BEGIN_EVENT_TABLE(MaxSheetSplitter, wxSheetSplitter)
END_EVENT_TABLE()

MaxSheetSplitter * bmx_wxsheetsplitter_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSheetSplitter(handle, parent, id, x, y, w, h, style);
}

void bmx_wxsheetsplitter_initialize(wxSheetSplitter * splitter, wxSheet * sheet) {
	splitter->Initialize(sheet);
}





// *********************************************

void bmx_wxsheettable_setview(wxSheetTable * table, wxSheet * sheet) {
	table->SetView(sheet);
}

int bmx_wxsheettable_getnumberrows(wxSheetTable * table) {
	return table->GetNumberRows();
}

int bmx_wxsheettable_getnumbercols(wxSheetTable * table) {
	return table->GetNumberCols();
}

bool bmx_wxsheettable_containsgridrow(wxSheetTable * table, int row) {
	return table->ContainsGridRow(row);
}

bool bmx_wxsheettable_containsgridcol(wxSheetTable * table, int col) {
	return table->ContainsGridCol(col);
}

bool bmx_wxsheettable_containsgridcell(wxSheetTable * table, int row, int col) {
	return table->ContainsGridCell(wxSheetCoords(row, col));
}

BBString * bmx_wxsheettable_getvalue(wxSheetTable * table, int row, int col) {
	return bbStringFromWxString(table->GetValue(wxSheetCoords(row, col)));
}

void bmx_wxsheettable_setvalue(wxSheetTable * table, int row, int col, BBString * value) {
	table->SetValue(wxSheetCoords(row, col), wxStringFromBBString(value));
}

bool bmx_wxsheettable_hasvalue(wxSheetTable * table, int row, int col) {
	return table->HasValue(wxSheetCoords(row, col));
}

int bmx_wxsheettable_getfirstnonemptycoltoleft(wxSheetTable * table, int row, int col) {
	return table->GetFirstNonEmptyColToLeft(wxSheetCoords(row, col));
}

void bmx_wxsheettable_clearvalues(wxSheetTable * table, int update) {
	table->ClearValues(update);
}

BBString * bmx_wxsheettable_getdefaultrowlabelvalue(wxSheetTable * table, int row) {
	return bbStringFromWxString(table->GetDefaultRowLabelValue(row));
}

BBString * bmx_wxsheettable_getdefaultcollabelvalue(wxSheetTable * table, int col) {
	return bbStringFromWxString(table->GetDefaultColLabelValue(col));
}

long bmx_wxsheettable_getvalueasint(wxSheetTable * table, int row, int col) {
	return table->GetValueAsLong(wxSheetCoords(row, col));
}

double bmx_wxsheettable_getvalueasdouble(wxSheetTable * table, int row, int col) {
	return table->GetValueAsDouble(wxSheetCoords(row, col));
}

bool bmx_wxsheettable_getvalueasbool(wxSheetTable * table, int row, int col) {
	return table->GetValueAsBool(wxSheetCoords(row, col));
}


// *********************************************

MaxSheetCellEditor * bmx_wxsheetcelleditor_create(wxSheetCellEditorRefData * data) {
	wxSheetCellEditor e(data);
	return new MaxSheetCellEditor(e);
}

void bmx_wxsheetcelleditor_delete(MaxSheetCellEditor * editor) {
	delete editor;
}

// *********************************************

wxSheetCellAutoWrapStringEditorRefData * bmx_wxsheetcellautowrapstringeditorrefdata_create() {
	return new wxSheetCellAutoWrapStringEditorRefData();
}

// *********************************************

MaxSheetCellRenderer * bmx_wxsheetcellrenderer_create(wxSheetCellRendererRefData * data) {
	wxSheetCellRenderer r(data);
	return new MaxSheetCellRenderer(r);
}

void bmx_wxsheetcellrenderer_delete(MaxSheetCellRenderer * renderer) {
	delete renderer;
}
	
// *********************************************

wxSheetCellAutoWrapStringRendererRefData * bmx_wxsheetcellautowrapstringrendererrefdata_create() {
	return new wxSheetCellAutoWrapStringRendererRefData();
}

