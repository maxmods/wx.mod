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

MaxFontDialog::MaxFontDialog(BBObject * handle, wxWindow * parent, const wxFontData& data)
	: wxFontDialog(parent, data)
{
	wxbind(this, handle);
}

MaxFontDialog::~MaxFontDialog() {
	wxunbind(this);
}

MaxFontData::MaxFontData(wxFontData & d)
	: data(d)
{
}

MaxFontData::MaxFontData()
{
	data = wxFontData();
}

wxFontData & MaxFontData::FontData() {
	return data;
}


// *********************************************

MaxFontDialog * bmx_wxfontdialog_create(BBObject * handle, wxWindow  * parent, MaxFontData * data) {
	if (data) {
		return new MaxFontDialog(handle, parent, data->FontData());
	} else {
		wxFontData f;
		return new MaxFontDialog(handle, parent, f);
	}
}

MaxFontData * bmx_wxfontdialog_getfontdata(wxFontDialog * dialog) {
	wxFontData d(dialog->GetFontData());
	return new MaxFontData(d);
}

int bmx_wxfontdialog_showmodal(wxFontDialog * dialog) {
	return dialog->ShowModal();
}


MaxFont * bmx_wxgetfontfromuser(wxWindow * window, MaxFont * font, BBString * caption) {
	wxFont f;
	if (font) {
		f = wxGetFontFromUser(window, font->Font(), wxStringFromBBString(caption));
	} else {
		f = wxGetFontFromUser(window, wxNullFont, wxStringFromBBString(caption));
	}
	return new MaxFont(f);
}

MaxFontData * bmx_wxfontdata_create() {
	return new MaxFontData();
}

void bmx_wxfontdata_enableeffects(MaxFontData * data, bool enable) {
	data->FontData().EnableEffects(enable);
}

bool bmx_wxfontdata_getallowsymbols(MaxFontData * data) {
	return data->FontData().GetAllowSymbols();
}

MaxColour * bmx_wxfontdata_getcolour(MaxFontData * data) {
	wxColour c(data->FontData().GetColour());
	return new MaxColour(c);
}

MaxFont * bmx_wxfontdata_getchosenfont(MaxFontData * data) {
	wxFont f(data->FontData().GetChosenFont());
	return new MaxFont(f);
}

bool bmx_wxfontdata_getenableeffects(MaxFontData * data) {
	return data->FontData().GetEnableEffects();
}

MaxFont * bmx_wxfontdata_getinitialfont(MaxFontData * data) {
	wxFont f(data->FontData().GetInitialFont());
	return new MaxFont(f);
}

bool bmx_wxfontdata_getshowhelp(MaxFontData * data) {
	return data->FontData().GetShowHelp();
}

void bmx_wxfontdata_setallowsymbols(MaxFontData * data, bool allowSymbols) {
	data->FontData().SetAllowSymbols(allowSymbols);
}

void bmx_wxfontdata_setchosenfont(MaxFontData * data, MaxFont * font) {
	data->FontData().SetChosenFont(font->Font());
}

void bmx_wxfontdata_setcolour(MaxFontData * data, MaxColour * colour) {
	data->FontData().SetColour(colour->Colour());
}

void bmx_wxfontdata_setinitialfont(MaxFontData * data, MaxFont * font) {
	data->FontData().SetInitialFont(font->Font());
}

void bmx_wxfontdata_setrange(MaxFontData * data, int minSize, int maxSize) {
	data->FontData().SetRange(minSize, maxSize);
}

void bmx_wxfontdata_setshowhelp(MaxFontData * data, bool showhelp) {
	data->FontData().SetShowHelp(showhelp);
}


