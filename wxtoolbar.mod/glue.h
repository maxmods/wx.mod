/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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
#include "wx/xrc/xh_toolb.h"

class MaxToolBar;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxtoolbar_wxToolBar__xrcNew(wxToolBar * toolbar);

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

	bool bmx_wxtoolbartoolbase_isbutton(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_iscontrol(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_isseparator(wxToolBarToolBase * base);
	int bmx_wxtoolbartoolbase_getstyle(wxToolBarToolBase * base);
	wxItemKind bmx_wxtoolbartoolbase_getkind(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_isenabled(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_istoggled(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_canbetoggled(wxToolBarToolBase * base);
	MaxBitmap * bmx_wxtoolbartoolbase_getnormalbitmap(wxToolBarToolBase * base);
	MaxBitmap * bmx_wxtoolbartoolbase_getdisabledbitmap(wxToolBarToolBase * base);
	MaxBitmap * bmx_wxtoolbartoolbase_getbitmap(wxToolBarToolBase * base);
	BBString * bmx_wxtoolbartoolbase_getlabel(wxToolBarToolBase * base);
	BBString * bmx_wxtoolbartoolbase_getshorthelp(wxToolBarToolBase * base);
	BBString * bmx_wxtoolbartoolbase_getlonghelp(wxToolBarToolBase * base);
	BBObject * bmx_wxtoolbartoolbase_getclientdata(wxToolBarToolBase * base);

	bool bmx_wxtoolbartoolbase_enable(wxToolBarToolBase * base, bool value);
	void bmx_wxtoolbartoolbase_toggle(wxToolBarToolBase * base);
	bool bmx_wxtoolbartoolbase_settoggle(wxToolBarToolBase * base, bool value);
	bool bmx_wxtoolbartoolbase_setshorthelp(wxToolBarToolBase * base, BBString * help);
	bool bmx_wxtoolbartoolbase_setlonghelp(wxToolBarToolBase * base, BBString * help);
	void bmx_wxtoolbartoolbase_setnormalbitmap(wxToolBarToolBase * base, MaxBitmap * bitmap);
	void bmx_wxtoolbartoolbase_setdisabledbitmap(wxToolBarToolBase * base, MaxBitmap * bitmap);
	void bmx_wxtoolbartoolbase_setlabel(wxToolBarToolBase * base, BBString * label);
	void bmx_wxtoolbartoolbase_setclientdata(wxToolBarToolBase * base, BBObject * data);
	void bmx_wxtoolbartoolbase_detach(wxToolBarToolBase * base);
	void bmx_wxtoolbartoolbase_attach(wxToolBarToolBase * base, wxToolBarBase * toolbar);

	int bmx_wxtoolbar_geteventtype(int type);

	void bmx_wxtoolbar_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolBar : public wxToolBar
{
public:
	MaxToolBar(wxWindow * parent, long style, wxWindowID id, const wxString& name);
	MaxToolBar();
	MaxToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxToolBar();
	void injectSelf(BBObject * handle);

	void MaxBind(BBObject * handle);
};


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolBarXmlHandler : public wxToolBarXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxToolBarXmlHandler)

public:
    MaxToolBarXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    bool m_isInside;
    wxToolBar *m_toolbar;
};
