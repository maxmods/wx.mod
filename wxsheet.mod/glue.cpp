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

