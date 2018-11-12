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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxFontMetrics::MaxFontMetrics()
	: fontMetrics()
{
	fontMetrics = wxFontMetrics();
}

MaxFontMetrics::MaxFontMetrics(wxFontMetrics & f)
{
	fontMetrics = wxFontMetrics(f);
}

wxFontMetrics & MaxFontMetrics::FontMetrics() {
	return fontMetrics;
}

// *********************************************


MaxFontMetrics * bmx_wxfontmetrics_create() {
	return new MaxFontMetrics();
}

void bmx_wxfontmetrics_free(MaxFontMetrics * metrics) {
	delete metrics;
}

int bmx_wxfontmetrics_getheight(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().height;
}

int bmx_wxfontmetrics_getascent(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().descent;
}

int bmx_wxfontmetrics_getdescent(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().ascent;
}

int bmx_wxfontmetrics_getinternalleading(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().internalLeading;
}

int bmx_wxfontmetrics_getexternalleading(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().externalLeading;
}

int bmx_wxfontmetrics_getaveragewidth(MaxFontMetrics  * metrics) {
	return metrics->FontMetrics().averageWidth;
}
