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
#include "wx/gbsizer.h"

class MaxGridBagSizer;

extern "C" {

#include <blitz.h>

	wxGridBagSizer * bmx_wxgridbagsizer_create(BBObject * handle, int vgap, int hgap);
	wxSizerItem * bmx_wxgridbagsizer_add(wxGridBagSizer * gb, wxWindow * window, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addspacer(wxGridBagSizer * gb, int width, int height, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addgbsizeritem(wxGridBagSizer * gb, wxGBSizerItem * item);
	bool bmx_wxgridbagsizer_checkforintersection(wxGridBagSizer * gb, wxGBSizerItem * item, wxGBSizerItem * excludeItem);
	bool bmx_wxgridbagsizer_checkforintersectionpos(wxGridBagSizer * gb, int row, int col, int rowspan, int colspan, wxGBSizerItem * excludeItem);
	void bmx_wxgridbagsizer_getcellsize(wxGridBagSizer * gb, int row, int col, int * width, int * height);
	void bmx_wxgridbagsizer_getemptycellsize(wxGridBagSizer * gb, int * width, int * height);
	void bmx_wxgridbagsizer_getitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int * row, int * col);
	void bmx_wxgridbagsizer_getitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int * row, int * col);
	void bmx_wxgridbagsizer_getitemposition(wxGridBagSizer * gb, int index, int * row, int * col);
	void bmx_wxgridbagsizer_getitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_getitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_getitemspan(wxGridBagSizer * gb, int index, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_setemptycellsize(wxGridBagSizer * gb, int width, int height);
	bool bmx_wxgridbagsizer_setitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int row, int col);
	bool bmx_wxgridbagsizer_setitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col);
	bool bmx_wxgridbagsizer_setitemposition(wxGridBagSizer * gb, int index, int row, int col);
	bool bmx_wxgridbagsizer_setitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int rowspan, int colspan);
	bool bmx_wxgridbagsizer_setitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int rowspan, int colspan);
	bool bmx_wxgridbagsizer_setitemspan(wxGridBagSizer * gb, int index, int rowspan, int colspan);
	wxGBSizerItem * bmx_wxgridbagsizer_finditemwindow(wxGridBagSizer * gb, wxWindow * window);
	wxGBSizerItem * bmx_wxgridbagsizer_finditemsizer(wxGridBagSizer * gb, wxSizer * sizer);
	wxGBSizerItem * bmx_wxgridbagsizer_finditematpoint(wxGridBagSizer * gb, int x, int y);
	wxGBSizerItem * bmx_wxgridbagsizer_finditematposition(wxGridBagSizer * gb, int row, int col);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGridBagSizer : public wxGridBagSizer
{
public:
	MaxGridBagSizer(BBObject * handle, int vgap, int hgap);
	~MaxGridBagSizer();

private:
	BBObject * maxHandle;

};

