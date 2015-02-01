/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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
#include "wx/wxFlatNotebook/wxFlatNotebook.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/wxFlatNotebook/xh_fnb.h"
#include "wx/xml/xml.h"

class MaxFlatNotebook;

extern "C" {

#include <blitz.h>
	
	BBArray * CB_PREF(wx_wxflatnotebook_wxFlatNotebook__newbitmaparray)(int size);
	void CB_PREF(wx_wxflatnotebook_wxFlatNotebook__setbitmap)(BBArray * list, int index, MaxBitmap * bitmap);
	MaxBitmap * CB_PREF(wx_wxflatnotebook_wxFlatNotebook__getbitmap)(BBArray * list, int index);
	BBObject * CB_PREF(wx_wxflatnotebook_wxFlatNotebook__xrcNew)(wxFlatNotebook * fnb);

	wxFlatNotebook * bmx_wxflatnotebook_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);

    void bmx_wxflatnotebook_advanceselection(wxFlatNotebook * fnb, int forward);
    int bmx_wxflatnotebook_addpage(wxFlatNotebook * fnb, wxWindow * window, BBString * caption, int selected, int imgIndex);
    int bmx_wxflatnotebook_insertpage(wxFlatNotebook * fnb, int index, wxWindow * page, BBString * text, int selected, int imgIndex);
    void bmx_wxflatnotebook_setselection(wxFlatNotebook * fnb, int page);
    void bmx_wxflatnotebook_deletepage(wxFlatNotebook * fnb, int page, int _notify);
    int bmx_wxflatnotebook_deleteallpages(wxFlatNotebook * fnb);
    int bmx_wxflatnotebook_getpagecount(wxFlatNotebook * fnb);
    wxWindow * bmx_wxflatnotebook_getcurrentpage(wxFlatNotebook * fnb);
    wxWindow * bmx_wxflatnotebook_getpage(wxFlatNotebook * fnb, int page);
    int bmx_wxflatnotebook_getpageindex(wxFlatNotebook * fnb, wxWindow * win);
    int bmx_wxflatnotebook_getselection(wxFlatNotebook * fnb);
    int bmx_wxflatnotebook_getpreviousselection(wxFlatNotebook * fnb);
    int bmx_wxflatnotebook_getpageshapeangle(wxFlatNotebook * fnb, int page, unsigned int * result);
    void bmx_wxflatnotebook_setpageshapeangle(wxFlatNotebook * fnb, int page, unsigned int angle);
    void bmx_wxflatnotebook_setallpagesshapeangle(wxFlatNotebook * fnb, unsigned int angle);
    void bmx_wxflatnotebook_getpagebestsize(wxFlatNotebook * fnb, int * w, int * h);
    int bmx_wxflatnotebook_setpagetext(wxFlatNotebook * fnb, int page, BBString * text);
    int bmx_wxflatnotebook_removepage(wxFlatNotebook * fnb, int page, int _notify);
    void bmx_wxflatnotebook_setpadding(wxFlatNotebook * fnb, int padW, int padH);
    void bmx_wxflatnotebook_setwindowstyleflag(wxFlatNotebook * fnb, long style);
    void bmx_wxflatnotebook_setrightclickmenu(wxFlatNotebook * fnb, wxMenu * menu);
    BBString * bmx_wxflatnotebook_getpagetext(wxFlatNotebook * fnb, int page);
    void bmx_wxflatnotebook_setpageimageindex(wxFlatNotebook * fnb, int page, int imgIndex);
    int bmx_wxflatnotebook_getpageimageindex(wxFlatNotebook * fnb, int page);
    void bmx_wxflatnotebook_setgradientcolors(wxFlatNotebook * fnb, MaxColour * colFrom, MaxColour * colTo, MaxColour * border);
    void bmx_wxflatnotebook_setgradientcolorfrom(wxFlatNotebook * fnb, MaxColour * colour);
    void bmx_wxflatnotebook_setgradientcolorto(wxFlatNotebook * fnb, MaxColour * colour);
    void bmx_wxflatnotebook_setgradientcolorborder(wxFlatNotebook * fnb, MaxColour * colour);
    void bmx_wxflatnotebook_enablepage(wxFlatNotebook * fnb, int page, int enabled);
    int bmx_wxflatnotebook_getpageenabled(wxFlatNotebook * fnb, int page);
    void bmx_wxflatnotebook_setactivetabtextcolour(wxFlatNotebook * fnb, MaxColour * colour);
    MaxColour * bmx_wxflatnotebook_getgradientcolorfrom(wxFlatNotebook * fnb);
    MaxColour * bmx_wxflatnotebook_getgradientcolorto(wxFlatNotebook * fnb);
    MaxColour * bmx_wxflatnotebook_getgradientcolorborder(wxFlatNotebook * fnb);
    MaxColour * bmx_wxflatnotebook_getactivetabtextcolour(wxFlatNotebook * fnb);
    MaxColour * bmx_wxflatnotebook_getnonactivetabtextcolour(wxFlatNotebook * fnb);
    void bmx_wxflatnotebook_setnonactivetabtextcolour(wxFlatNotebook * fnb, MaxColour * colour);
    wxPanel * bmx_wxflatnotebook_gettabarea(wxFlatNotebook * fnb);
    MaxColour * bmx_wxflatnotebook_gettabareacolour(wxFlatNotebook * fnb);
    void bmx_wxflatnotebook_settabareacolour(wxFlatNotebook * fnb, MaxColour * colour);
    MaxColour * bmx_wxflatnotebook_getactivetabcolour(wxFlatNotebook * fnb);
    void bmx_wxflatnotebook_setactivetabcolour(wxFlatNotebook * fnb, MaxColour * colour);
    int bmx_wxflatnotebook_getpadding(wxFlatNotebook * fnb);
    void bmx_wxflatnotebook_setcustomizeoptions(wxFlatNotebook * fnb, long options);
    long bmx_wxflatnotebook_getcustomizeoptions(wxFlatNotebook * fnb);
    void bmx_wxflatnotebook_setforceselection(wxFlatNotebook * fnb, int force);
    int bmx_wxflatnotebook_getforceselection(wxFlatNotebook * fnb);
    wxBoxSizer * bmx_wxflatnotebook_getmainsizer(wxFlatNotebook * fnb);

	wxFlatNotebookImageList * bmx_wxflatnotebook_setimagelist(wxFlatNotebook * fnb, BBArray * bits);
	BBArray * bmx_wxflatnotebook_getimagelist(wxFlatNotebook * fnb);
	void bmx_wxflatnotebook_deleteimagelist(wxFlatNotebookImageList * list);

	int bmx_wxflatnotebook_geteventtype(int type);

	void bmx_wxflatnotebookevent_setselection(wxFlatNotebookEvent & event, int selection);
	void bmx_wxflatnotebookevent_setoldselection(wxFlatNotebookEvent & event, int selection);
	int bmx_wxflatnotebookevent_getselection(wxFlatNotebookEvent & event);
	int bmx_wxflatnotebookevent_getoldselection(wxFlatNotebookEvent & event);

	void bmx_wxflatnotebook_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFlatNotebook : public wxFlatNotebook
{
public:
	MaxFlatNotebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxFlatNotebook();
	~ MaxFlatNotebook();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFlatNotebookXmlHandler : public wxFlatNotebookXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxFlatNotebookXmlHandler)

public:
    MaxFlatNotebookXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    bool m_isInside;
    wxFlatNotebook *m_notebook;
};

