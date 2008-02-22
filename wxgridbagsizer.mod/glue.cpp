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

MaxGridBagSizer::MaxGridBagSizer(BBObject * handle, int vgap, int hgap)
	: maxHandle(handle), wxGridBagSizer(vgap, hgap)
{
	wxbind(this, handle);
}

MaxGridBagSizer::~MaxGridBagSizer() {
	wxunbind(this);
}


// *********************************************

wxGridBagSizer * bmx_wxgridbagsizer_create(BBObject * handle, int vgap, int hgap) {
	return new MaxGridBagSizer(handle, vgap, hgap);
}

wxSizerItem * bmx_wxgridbagsizer_add(wxGridBagSizer * gb, wxWindow * window, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(window, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(sizer, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addspacer(wxGridBagSizer * gb, int width, int height, int row, int col, int rowspan, int colspan, int flag, int border) {
	return gb->Add(width, height, wxGBPosition(row, col), wxGBSpan(rowspan, colspan), flag, border);
}

wxSizerItem * bmx_wxgridbagsizer_addgbsizeritem(wxGridBagSizer * gb, wxGBSizerItem * item) {
	return gb->Add(item);
}

bool bmx_wxgridbagsizer_checkforintersection(wxGridBagSizer * gb, wxGBSizerItem * item, wxGBSizerItem * excludeItem) {
	return gb->CheckForIntersection(item, excludeItem);
}

bool bmx_wxgridbagsizer_checkforintersectionpos(wxGridBagSizer * gb, int row, int col, int rowspan, int colspan, wxGBSizerItem * excludeItem) {
	return gb->CheckForIntersection(wxGBPosition(row, col), wxGBSpan(rowspan, colspan), excludeItem);
}

void bmx_wxgridbagsizer_getcellsize(wxGridBagSizer * gb, int row, int col, int * width, int * height) {
	wxSize s = gb->GetCellSize(row, col);
	*width = s.x;
	*height = s.y;
}

void bmx_wxgridbagsizer_getemptycellsize(wxGridBagSizer * gb, int * width, int * height) {
	wxSize s = gb->GetEmptyCellSize();
	*width = s.x;
	*height = s.y;
}

void bmx_wxgridbagsizer_getitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(window);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(sizer);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitemposition(wxGridBagSizer * gb, int index, int * row, int * col) {
	wxGBPosition p = gb->GetItemPosition(index);
	*row = p.GetRow();
	*col = p.GetCol();
}

void bmx_wxgridbagsizer_getitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(window);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_getitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(sizer);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_getitemspan(wxGridBagSizer * gb, int index, int * rowspan, int * colspan) {
	wxGBSpan s = gb->GetItemSpan(index);
	*rowspan = s.GetRowspan();
	*colspan = s.GetColspan();
}

void bmx_wxgridbagsizer_setemptycellsize(wxGridBagSizer * gb, int width, int height) {
	gb->SetEmptyCellSize(wxSize(width, height));
}

bool bmx_wxgridbagsizer_setitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int row, int col) {
	return gb->SetItemPosition(window, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col) {
	return gb->SetItemPosition(sizer, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitemposition(wxGridBagSizer * gb, int index, int row, int col) {
	return gb->SetItemPosition(index, wxGBPosition(row, col));
}

bool bmx_wxgridbagsizer_setitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int rowspan, int colspan) {
	return gb->SetItemSpan(window, wxGBSpan(rowspan, colspan));
}

bool bmx_wxgridbagsizer_setitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int rowspan, int colspan) {
	return gb->SetItemSpan(sizer, wxGBSpan(rowspan, colspan));
}

bool bmx_wxgridbagsizer_setitemspan(wxGridBagSizer * gb, int index, int rowspan, int colspan) {
	return gb->SetItemSpan(index, wxGBSpan(rowspan, colspan));
}

wxGBSizerItem * bmx_wxgridbagsizer_finditemwindow(wxGridBagSizer * gb, wxWindow * window) {
	return gb->FindItem(window);
}

wxGBSizerItem * bmx_wxgridbagsizer_finditemsizer(wxGridBagSizer * gb, wxSizer * sizer) {
	return gb->FindItem(sizer);
}

wxGBSizerItem * bmx_wxgridbagsizer_finditematpoint(wxGridBagSizer * gb, int x, int y) {
	return gb->FindItemAtPoint(wxPoint(x, y));
}

wxGBSizerItem * bmx_wxgridbagsizer_finditematposition(wxGridBagSizer * gb, int row, int col) {
	return gb->FindItemAtPosition(wxGBPosition(row, col));
}


