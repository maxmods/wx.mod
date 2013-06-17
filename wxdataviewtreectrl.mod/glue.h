/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

#ifndef _WX_MAX_DATAVIEWTREECTRL_H_
#define _WX_MAX_DATAVIEWTREECTRL_H_

#include "wxglue.h"
#include <wx/dataview.h>
#include "../wxdataviewmodel.mod/glue.h"
#include "../wxicon.mod/glue.h"

class MaxDataViewTreeCtrl;

extern "C" {

#include <blitz.h>

	MaxDataViewTreeCtrl * bmx_wxdataviewtreectrl_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, int style);
	MaxDataViewItem * bmx_wxdataviewtreectrl_appendcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, int expanded, BBObject * data);
	MaxDataViewItem * bmx_wxdataviewtreectrl_appenditem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, BBObject * data);
	void bmx_wxdataviewtreectrl_deleteallitems(wxDataViewTreeCtrl * tree);
	void bmx_wxdataviewtreectrl_deletechildren(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	void bmx_wxdataviewtreectrl_deleteitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	int bmx_wxdataviewtreectrl_getchildcount(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent);
	wxImageList * bmx_wxdataviewtreectrl_getimagelist(wxDataViewTreeCtrl * tree);
	MaxIcon * bmx_wxdataviewtreectrl_getitemexpandedicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	MaxIcon * bmx_wxdataviewtreectrl_getitemicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	BBString * bmx_wxdataviewtreectrl_getitemtext(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	MaxDataViewItem * bmx_wxdataviewtreectrl_getnthchild(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, int pos);
	MaxDataViewItem * bmx_wxdataviewtreectrl_insertcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, MaxDataViewItem * previous, BBString * text, int icon, int expanded, BBObject * data);
	MaxDataViewItem * bmx_wxdataviewtreectrl_insertitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, MaxDataViewItem * previous, BBString * text, int icon, BBObject * data);
	int bmx_wxdataviewtreectrl_iscontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * item);
	MaxDataViewItem * bmx_wxdataviewtreectrl_prependcontainer(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, int expanded, BBObject * data);
	MaxDataViewItem * bmx_wxdataviewtreectrl_prependitem(wxDataViewTreeCtrl * tree, MaxDataViewItem * parent, BBString * text, int icon, BBObject * data);
	void bmx_wxdataviewtreectrl_setimagelist(wxDataViewTreeCtrl * tree, wxImageList * imageList);
	void bmx_wxdataviewtreectrl_setitemexpandedicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, MaxIcon * icon);
	void bmx_wxdataviewtreectrl_setitemicon(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, MaxIcon * icon);
	void bmx_wxdataviewtreectrl_setitemtext(wxDataViewTreeCtrl * tree, MaxDataViewItem * item, BBString * text);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDataViewTreeCtrl : public wxDataViewTreeCtrl
{
public:
	MaxDataViewTreeCtrl();
	MaxDataViewTreeCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxDataViewTreeCtrl();

	void MaxBind(BBObject * handle);
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};


#endif
