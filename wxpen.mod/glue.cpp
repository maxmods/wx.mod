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

MaxPen::MaxPen()
	: pen(wxNullPen)
{
	pen = wxPen();
}

MaxPen::MaxPen(wxPen & p)
{
	pen = wxPen(p);
}

wxPen & MaxPen::Pen() {
	return pen;
}

// *********************************************


MaxPen * bmx_wxpen_create(BBString * name, int width, int style) {
	wxPen p(wxStringFromBBString(name), width, style);
	return new MaxPen(p);
}

MaxPen * bmx_wxpen_createfromcolour(MaxColour * colour, int width, int style) {
	wxPen p(colour->Colour(), width, style);
	return new MaxPen(p);
}

void bmx_wxpen_delete(MaxPen * pen) {
	delete pen;
}

MaxPen * bmx_wxpen_null() {
	return new MaxPen(wxNullPen);
}

// *********************************************

MaxPen * bmx_wxstockgdi_pen_blackdashed() {
	wxPen p(*wxBLACK_DASHED_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_black() {
	wxPen p(*wxBLACK_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_cyan() {
	wxPen p(*wxCYAN_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_green() {
	wxPen p(*wxGREEN_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_grey() {
	wxPen p(*wxGREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_lightgrey() {
	wxPen p(*wxLIGHT_GREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_mediumgrey() {
	wxPen p(*wxMEDIUM_GREY_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_red() {
	wxPen p(*wxRED_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_transparent() {
	wxPen p(*wxTRANSPARENT_PEN);
	return new MaxPen(p);
}

MaxPen * bmx_wxstockgdi_pen_white() {
	wxPen p(*wxWHITE_PEN);
	return new MaxPen(p);
}


// *********************************************

int bmx_wxpen_getcap(MaxPen * pen) {
	return pen->Pen().GetCap();
}

MaxColour * bmx_wxpen_getcolour(MaxPen * pen) {
	wxColour c(pen->Pen().GetColour());
	return new MaxColour(c);
}

int bmx_wxpen_getjoin(MaxPen * pen) {
	return pen->Pen().GetJoin();
}

MaxBitmap * bmx_wxpen_getstipple(MaxPen * pen) {
#ifdef WIN32 || defined(__APPLE__)
	return new MaxBitmap(* pen->Pen().GetStipple());
#else
	return new MaxBitmap(wxNullBitmap);
#endif
}

int bmx_wxpen_getstyle(MaxPen * pen) {
	return pen->Pen().GetStyle();
}

int bmx_wxpen_getwidth(MaxPen * pen) {
	return pen->Pen().GetWidth();
}

bool bmx_wxpen_isok(MaxPen * pen) {
	return pen->Pen().IsOk();
}

void bmx_wxpen_setcap(MaxPen * pen, int style) {
	pen->Pen().SetCap(style);
}

void bmx_wxpen_setcolour(MaxPen * pen, BBString * name) {
	pen->Pen().SetColour(wxStringFromBBString(name));
}

void bmx_wxpen_setfromcolour(MaxPen * pen, MaxColour * colour) {
	pen->Pen().SetColour(colour->Colour());
}

void bmx_wxpen_setfromrgb(MaxPen * pen, int red, int green, int blue) {
	pen->Pen().SetColour( static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wxpen_setjoin(MaxPen * pen, int style) {
	pen->Pen().SetJoin(style);
}

void bmx_wxpen_setstipple(MaxPen * pen, MaxBitmap * stipple) {
#ifdef WIN32 || defined(__APPLE__)
	pen->Pen().SetStipple(stipple->Bitmap());
#endif
}

void bmx_wxpen_setstyle(MaxPen * pen, int style) {
	pen->Pen().SetStyle(style);
}

void bmx_wxpen_setwidth(MaxPen * pen, int width) {
	pen->Pen().SetWidth(width);
}

