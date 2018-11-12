/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

#ifndef _WX_MAX_FONTMETRICS_H_
#define _WX_MAX_FONTMETRICS_H_

#include "wxglue.h"
#include "wx/dc.h"

class MaxFontMetrics;

extern "C" {

#include <blitz.h>

	MaxFontMetrics * bmx_wxfontmetrics_create();
	void bmx_wxfontmetrics_free(MaxFontMetrics * metrics);
	int bmx_wxfontmetrics_getheight(MaxFontMetrics  * metrics);
	int bmx_wxfontmetrics_getascent(MaxFontMetrics  * metrics);
	int bmx_wxfontmetrics_getdescent(MaxFontMetrics  * metrics);
	int bmx_wxfontmetrics_getinternalleading(MaxFontMetrics  * metrics);
	int bmx_wxfontmetrics_getexternalleading(MaxFontMetrics  * metrics);
	int bmx_wxfontmetrics_getaveragewidth(MaxFontMetrics  * metrics);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxFontMetrics
{
public:
	MaxFontMetrics();
	MaxFontMetrics(wxFontMetrics & fontMetrics);
	wxFontMetrics & FontMetrics();

private:
	wxFontMetrics fontMetrics;

};

#endif _WX_MAX_FONTMETRICS_H_
