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


void bmx_wxscrolledwindow_calcscrolledposition(wxScrolledWindow * window, int x, int y, int * xx, int * yy) {
	window->CalcScrolledPosition(x, y, xx, yy);
}

void bmx_wxscrolledwindow_calcunscrolledposition(wxScrolledWindow * window, int x, int y, int * xx, int * yy) {
	window->CalcUnscrolledPosition(x, y, xx, yy);
}

void bmx_wxscrolledwindow_enablescrolling(wxScrolledWindow * window, int xScrolling, int yScrolling) {
	window->EnableScrolling(xScrolling, yScrolling);
}

void bmx_wxscrolledwindow_getscrollpixelsperunit(wxScrolledWindow * window, int * xUnit, int * yUnit) {
	window->GetScrollPixelsPerUnit(xUnit, yUnit);
}

void bmx_wxscrolledwindow_getviewstart(wxScrolledWindow * window, int * x, int * y) {
	window->GetViewStart(x, y);
}

void bmx_wxscrolledwindow_getvirtualsize(wxScrolledWindow * window, int * x, int * y) {
	window->GetVirtualSize(x, y);
}

void bmx_wxscrolledwindow_dopreparedc(wxScrolledWindow * window, MaxDC * dc) {
	window->DoPrepareDC(* dc->GetDC());
}

void bmx_wxscrolledwindow_scroll(wxScrolledWindow * window, int x, int y) {
	window->Scroll(x, y);
}

void bmx_wxscrolledwindow_setscrollbars(wxScrolledWindow * window, int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, int xPos, int yPos, bool noRefresh) {
	window->SetScrollbars(pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, xPos, yPos, noRefresh);
}

void bmx_wxscrolledwindow_setscrollrate(wxScrolledWindow * window, int xStep, int yStep) {
	window->SetScrollRate(xStep, yStep);
}

void bmx_wxscrolledwindow_settargetwindow(wxScrolledWindow * window, wxWindow * target) {
	window->SetTargetWindow(target);
}

