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

MaxToolBar::MaxToolBar(wxWindow * parent, long style, wxWindowID id, const wxString& name)
	: wxToolBar(parent, id, wxDefaultPosition, wxDefaultSize, style, name)
{
}

MaxToolBar::MaxToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxToolBar(parent, id, wxPoint(x, y), wxSize(w,h), style)
{
	wxbind(this, handle);
}


MaxToolBar::~MaxToolBar() {
	wxunbind(this);
}

void MaxToolBar::injectSelf(BBObject * handle) {
	wxbind(this, handle);
}

// *********************************************

void bmx_wxtoolbar_injectSelf(MaxToolBar * toolbar, BBObject * handle) {
	toolbar->injectSelf(handle);
}

MaxToolBar * bmx_wxtoolbar_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxToolBar(maxHandle, parent, id, x, y, w, h, style);
}

bool bmx_wxtoolbar_addcontrol(wxToolBar * toolbar, wxControl * control) {
	return toolbar->AddControl(control);
}

void bmx_wxtoolbar_addseparator(wxToolBar * toolbar) {
	toolbar->AddSeparator();
}

wxToolBarToolBase * bmx_wxtoolbar_addtool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, 
		MaxBitmap * bitmap2, wxItemKind kind, BBString * shortHelp, BBString * longHelp, void * clientData) {

	if (bitmap2) {
		return toolbar->AddTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), bitmap2->Bitmap(), kind, 
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp));
	} else {
		return toolbar->AddTool(id, wxStringFromBBString(label), bitmap1->Bitmap(), wxNullBitmap, kind, 
			wxStringFromBBString(shortHelp), wxStringFromBBString(longHelp));
	}
}

bool bmx_wxtoolbar_realize(wxToolBar * toolbar) {
	return toolbar->Realize();
}

void bmx_wxtoolbar_settoolbitmapsize(wxToolBar * toolbar, int w, int h) {
	toolbar->SetToolBitmapSize(wxSize(w, h));
}


void bmx_wxtoolbar_cleartools(wxToolBar * toolbar) {
	toolbar->ClearTools();
}

bool bmx_wxtoolbar_deletetool(wxToolBar * toolbar, int toolId) {
	return toolbar->DeleteTool(toolId);
}

bool bmx_wxtoolbar_deletetoolbypos(wxToolBar * toolbar, int pos) {
	return toolbar->DeleteToolByPos(pos);
}

void bmx_wxtoolbar_enabletool(wxToolBar * toolbar, int toolId, bool enable) {
	toolbar->EnableTool(toolId, enable);
}

int bmx_wxtoolbar_gettoolscount(wxToolBar * toolbar) {
	return toolbar->GetToolsCount();
}

void bmx_wxtoolbar_gettoolsize(wxToolBar * toolbar, int * width, int * height) {
	wxSize m = toolbar->GetToolSize();
	*width = m.x;
	*height = m.y;
}

void bmx_wxtoolbar_gettoolbitmapsize(wxToolBar * toolbar, int * width, int * height) {
	wxSize m = toolbar->GetToolBitmapSize();
	*width = m.x;
	*height = m.y;
}

void bmx_wxtoolbar_getmargins(wxToolBar * toolbar, int * leftRight, int * topBottom) {
	wxSize m = toolbar->GetMargins();
	*leftRight = m.x;
	*topBottom = m.y;
}

bool bmx_wxtoolbar_gettoolenabled(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolEnabled(toolId);
}

BBString * bmx_wxtoolbar_gettoollonghelp(wxToolBar * toolbar, int toolId) {
	return bbStringFromWxString(toolbar->GetToolLongHelp(toolId));
}

int bmx_wxtoolbar_gettoolpacking(wxToolBar * toolbar) {
	return toolbar->GetToolPacking();
}

int bmx_wxtoolbar_gettoolpos(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolPos(toolId);
}

int bmx_wxtoolbar_gettoolseparation(wxToolBar * toolbar) {
	return toolbar->GetToolSeparation();
}

BBString * bmx_wxtoolbar_gettoolshorthelp(wxToolBar * toolbar, int toolId) {
	return bbStringFromWxString(toolbar->GetToolShortHelp(toolId));
}

bool bmx_wxtoolbar_gettoolstate(wxToolBar * toolbar, int toolId) {
	return toolbar->GetToolState(toolId);
}




int bmx_wxtoolbar_geteventtype(int type) {
	switch(type) {
		case 9: return wxEVT_COMMAND_TOOL_CLICKED;
		case 16: return wxEVT_COMMAND_TOOL_RCLICKED;
		case 17: return wxEVT_COMMAND_TOOL_ENTER;
	}
	
	return 0;
}
