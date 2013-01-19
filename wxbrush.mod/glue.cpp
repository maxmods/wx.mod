/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

MaxBrush::MaxBrush()
	: brush(wxNullBrush)
{
	brush = wxBrush();
}

MaxBrush::MaxBrush(wxBrush & b)
{
	brush = wxBrush(b);
}

wxBrush & MaxBrush::Brush() {
	return brush;
}

// *********************************************

MaxBrush * bmx_wxstockgdi_brush_black() {
	wxBrush b(*wxBLACK_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_blue() {
	wxBrush b(*wxBLUE_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_cyan() {
	wxBrush b(*wxCYAN_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_green() {
	wxBrush b(*wxGREEN_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_grey() {
	wxBrush b(*wxGREY_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_lightgrey() {
	wxBrush b(*wxLIGHT_GREY_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_mediumgrey() {
	wxBrush b(*wxMEDIUM_GREY_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_red() {
	wxBrush b(*wxRED_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_transparent() {
	wxBrush b(*wxTRANSPARENT_BRUSH);
	return new MaxBrush(b);
}

MaxBrush * bmx_wxstockgdi_brush_white() {
	wxBrush b(*wxWHITE_BRUSH);
	return new MaxBrush(b);
}


MaxBrush * bmx_wxbrush_create(BBString * name, int style) {
	wxBrush b(wxStringFromBBString(name), style);
	return new MaxBrush(b);
}

void bmx_wxbrush_delete(MaxBrush * brush) {
	delete brush;
}

MaxBrush * bmx_wxbrush_createfromcolour(MaxColour * colour, int style) {
	wxBrush b(colour->Colour(), style);
	return new MaxBrush(b);
}

MaxColour * bmx_wxbrush_getcolour(MaxBrush * brush) {
	wxColour c(brush->Brush().GetColour());
	return new MaxColour(c);
}

MaxBitmap * bmx_wxbrush_getstipple(MaxBrush * brush) {
	wxBitmap * b = brush->Brush().GetStipple();
	return new MaxBitmap(*b);
}

int bmx_wxbrush_getstyle(MaxBrush * brush) {
	return brush->Brush().GetStyle();
}

int bmx_wxbrush_ishatch(MaxBrush * brush) {
	return static_cast<int>(brush->Brush().IsHatch());
}

int bmx_wxbrush_isok(MaxBrush * brush) {
	return static_cast<int>(brush->Brush().IsOk());
}

void bmx_wxbrush_setcolour(MaxBrush * brush, BBString * colour) {
	brush->Brush().SetColour(wxStringFromBBString(colour));
}

void bmx_wxbrush_setfromcolour(MaxBrush * brush, MaxColour * colour) {
	brush->Brush().SetColour(colour->Colour());
}

void bmx_wxbrush_setfromrgb(MaxBrush * brush, int red, int green, int blue) {
	brush->Brush().SetColour(static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}


void bmx_wxbrush_setstipple(MaxBrush * brush, MaxBitmap * bitmap) {
	brush->Brush().SetStipple(bitmap->Bitmap());
}

void bmx_wxbrush_setstyle(MaxBrush * brush, int style) {
	brush->Brush().SetStyle(style);
}

MaxBrush * bmx_wxbrush_null() {
	return new MaxBrush(wxNullBrush);
}


