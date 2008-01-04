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
#include "wx/toolbar.h"
#include "../wxbitmap.mod/glue.h"

class MaxToolBar;

extern "C" {

#include <blitz.h>

	void bmx_wxtoolbar_injectSelf(MaxToolBar * toolbar, BBObject * handle);

	MaxToolBar * bmx_wxtoolbar_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id,
		int x, int y, int w, int h, long style);
	bool bmx_wxtoolbar_addcontrol(wxToolBar * toolbar, wxControl * control);
	void bmx_wxtoolbar_addseparator(wxToolBar * toolbar);
	wxToolBarToolBase * bmx_wxtoolbar_addtool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, 
			MaxBitmap * bitmap2, wxItemKind kind, BBString * shortHelp, BBString * longHelp, void * clientData);
	bool bmx_wxtoolbar_realize(wxToolBar * toolbar);
	void bmx_wxtoolbar_settoolbitmapsize(wxToolBar * toolbar, int w, int h);


	void bmx_wxtoolbar_cleartools(wxToolBar * toolbar);
	bool bmx_wxtoolbar_deletetool(wxToolBar * toolbar, int toolId);
	bool bmx_wxtoolbar_deletetoolbypos(wxToolBar * toolbar, int pos);
	void bmx_wxtoolbar_enabletool(wxToolBar * toolbar, int toolId, bool enable);
	int bmx_wxtoolbar_gettoolscount(wxToolBar * toolbar);
	void bmx_wxtoolbar_gettoolsize(wxToolBar * toolbar, int * width, int * height);
	void bmx_wxtoolbar_gettoolbitmapsize(wxToolBar * toolbar, int * width, int * height);
	void bmx_wxtoolbar_getmargins(wxToolBar * toolbar, int * leftRight, int * topBottom);
	bool bmx_wxtoolbar_gettoolenabled(wxToolBar * toolbar, int toolId);
	BBString * bmx_wxtoolbar_gettoollonghelp(wxToolBar * toolbar, int toolId);
	int bmx_wxtoolbar_gettoolpacking(wxToolBar * toolbar);
	int bmx_wxtoolbar_gettoolpos(wxToolBar * toolbar, int toolId);
	int bmx_wxtoolbar_gettoolseparation(wxToolBar * toolbar);
	BBString * bmx_wxtoolbar_gettoolshorthelp(wxToolBar * toolbar, int toolId);
	bool bmx_wxtoolbar_gettoolstate(wxToolBar * toolbar, int toolId);

	wxToolBarToolBase * bmx_wxtoolbar_addchecktool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, MaxBitmap * bitmap2,
			BBString * shortHelp, BBString * longHelp, void * clientData);
	wxToolBarToolBase * bmx_wxtoolbar_addradiotool(wxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, MaxBitmap * bitmap2,
			BBString * shortHelp, BBString * longHelp, void * clientData);
	wxToolBarToolBase * bmx_wxtoolbar_inserttool(wxToolBar * toolbar, size_t pos, int id, BBString * label, MaxBitmap * bitmap1,
		MaxBitmap * bitmap2, wxItemKind kind, void * clientData, BBString * shortHelp, BBString * longHelp);
	void bmx_wxtoolbar_setmargins(wxToolBar * toolbar, int leftRight, int topBottom);
	void bmx_wxtoolbar_settoolclientdata(wxToolBar * toolbar, int id, void * clientData);
	void bmx_wxtoolbar_settooldisabledbitmap(wxToolBar * toolbar, int id, MaxBitmap * bitmap);
	void bmx_wxtoolbar_settoollonghelp(wxToolBar * toolbar, int id, BBString * helpString);
	void bmx_wxtoolbar_settoolpacking(wxToolBar * toolbar, int packing);
	void bmx_wxtoolbar_settoolshorthelp(wxToolBar * toolbar, int id, BBString * helpString);
	void bmx_wxtoolbar_settoolnormalbitmap(wxToolBar * toolbar, int id, MaxBitmap * bitmap);
	void bmx_wxtoolbar_settoolseparation(wxToolBar * toolbar, int separation);
	void bmx_wxtoolbar_toggletool(wxToolBar * toolbar, int id, bool toggle);
	wxToolBarToolBase * bmx_wxtoolbar_removetool(wxToolBar * toolbar, int id);
	void * bmx_wxtoolbar_gettoolclientdata(wxToolBar * toolbar, int id);
	wxToolBarToolBase * bmx_wxtoolbar_findbyid(wxToolBar * toolbar, int id);
	wxControl * bmx_wxtoolbar_findcontrol(wxToolBar * toolbar, int id);
	wxToolBarToolBase * bmx_wxtoolbar_findtoolforposition(wxToolBar * toolbar, int x, int y);
	wxToolBarToolBase * bmx_wxtoolbar_insertcontrol(wxToolBar * toolbar, int pos, wxControl * control);
	wxToolBarToolBase * bmx_wxtoolbar_insertseparator(wxToolBar * toolbar, int pos);

	int bmx_wxtoolbar_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolBar : public wxToolBar
{
public:
	MaxToolBar(wxWindow * parent, long style, wxWindowID id, const wxString& name);
	MaxToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxToolBar();
	void injectSelf(BBObject * handle);
};



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
