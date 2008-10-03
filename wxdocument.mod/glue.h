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
#include "wx/docview.h"

class MaxDocument;
class MaxView;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxdocument_wxDocument__create(wxDocument * doc);
	void _wx_wxdocument_wxDocument__OnChangedViewList(BBObject * handle);
	bool _wx_wxdocument_wxDocument__OnCloseDocument(BBObject * handle);
	bool _wx_wxdocument_wxDocument__OnCreate(BBObject * handle, BBString * path, long flags);
	wxCommandProcessor * _wx_wxdocument_wxDocument__OnCreateCommandProcessor(BBObject * handle);
	bool _wx_wxdocument_wxDocument__OnNewDocument(BBObject * handle);
	bool _wx_wxdocument_wxDocument__OnOpenDocument(BBObject * handle, BBString * filename);
	bool _wx_wxdocument_wxDocument__OnSaveDocument(BBObject * handle, BBString * filename);
	bool _wx_wxdocument_wxDocument__OnSaveModified(BBObject * handle);
	bool _wx_wxdocument_wxDocument__IsModified(BBObject * handle);
	void _wx_wxdocument_wxDocument__Modify(BBObject * handle, bool doModify);

	BBObject * _wx_wxdocument_wxView__create(wxView * view);

	wxDocument * bmx_wxdocument_create(BBObject * handle);
	bool bmx_wxdocument_addview(wxDocument * doc, wxView * view);
	bool bmx_wxdocument_close(wxDocument * doc);
	bool bmx_wxdocument_deleteallviews(wxDocument * doc);
	wxCommandProcessor * bmx_wxdocument_getcommandprocessor(wxDocument * doc);
	wxDocTemplate * bmx_wxdocument_getdocumenttemplate(wxDocument * doc);
	wxDocManager * bmx_wxdocument_getdocumentmanager(wxDocument * doc);
	BBString * bmx_wxdocument_getdocumentname(wxDocument * doc);
	wxWindow * bmx_wxdocument_getdocumentwindow(wxDocument * doc);
	BBString * bmx_wxdocument_getfilename(wxDocument * doc);
	wxView * bmx_wxdocument_getfirstview(wxDocument * doc);
	BBString * bmx_wxdocument_getprintablename(wxDocument * doc);
	BBString * bmx_wxdocument_gettitle(wxDocument * doc);
	bool bmx_wxdocument_ismodified(MaxDocument * doc);
	wxInputStream * bmx_wxdocument_loadobject(wxDocument * doc, wxInputStream * stream);
	void bmx_wxdocument_modify(MaxDocument * doc, bool doModify);
	void bmx_wxdocument_onchangedviewlist(MaxDocument * doc);
	bool bmx_wxdocument_onclosedocument(MaxDocument * doc);
	bool bmx_wxdocument_oncreate(MaxDocument * doc, BBString * path, long flags);
	wxCommandProcessor * bmx_wxdocument_oncreatecommandprocessor(MaxDocument * doc);
	bool bmx_wxdocument_onnewdocument(MaxDocument * doc);
	bool bmx_wxdocument_onopendocument(MaxDocument * doc, BBString * filename);
	bool bmx_wxdocument_onsavedocument(MaxDocument * doc, BBString * filename);
	bool bmx_wxdocument_onsavemodified(MaxDocument * doc);
	bool bmx_wxdocument_removeview(wxDocument * doc, wxView * view);
	bool bmx_wxdocument_save(wxDocument * doc);
	bool bmx_wxdocument_saveas(wxDocument * doc);
	wxOutputStream * bmx_wxdocument_saveobject(wxDocument * doc, wxOutputStream * stream);
	void bmx_wxdocument_setcommandprocessor(wxDocument * doc, wxCommandProcessor * processor);
	void bmx_wxdocument_setdocumentname(wxDocument * doc, BBString * name);
	void bmx_wxdocument_setdocumenttemplate(wxDocument * doc, wxDocTemplate * templ);
	void bmx_wxdocument_setfilename(wxDocument * doc, BBString * filename, bool notifyViews);
	void bmx_wxdocument_settitle(wxDocument * doc, BBString * title);
	void bmx_wxdocument_updateallviews(wxDocument * doc, wxView * sender);

	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDocument : public wxDocument
{

	DECLARE_DYNAMIC_CLASS(MaxDocument)

public:
	MaxDocument();
	MaxDocument(BBObject * handle);
	~MaxDocument();
	
	void OnChangedViewList();
	bool OnCloseDocument();
	bool OnCreate(const wxString& path, long flags);
	wxCommandProcessor* OnCreateCommandProcessor();
	bool OnNewDocument();
	bool OnOpenDocument(const wxString& filename);
	bool OnSaveDocument(const wxString& filename);
	bool OnSaveModified();
	bool IsModified();
	void Modify(bool doModify);

	void OnChangedViewList_default();
	bool OnCloseDocument_default();
	bool OnCreate_default(const wxString& path, long flags);
	wxCommandProcessor* OnCreateCommandProcessor_default();
	bool OnNewDocument_default();
	bool OnOpenDocument_default(const wxString& filename);
	bool OnSaveDocument_default(const wxString& filename);
	bool OnSaveModified_default();
	bool IsModified_default();
	void Modify_default(bool doModify);

private:
	BBObject * maxHandle;
};

class MaxView : public wxView
{

	DECLARE_DYNAMIC_CLASS(MaxView)

public:
	MaxView();
	MaxView(BBObject * handle);
	~MaxView();

	void OnDraw(wxDC* dc);

private:
	BBObject * maxHandle;
};


