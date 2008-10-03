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

IMPLEMENT_DYNAMIC_CLASS(MaxDocument , wxDocument)

// called when the framework creates an instance of wxDocument
MaxDocument::MaxDocument()
{
	// create a bmx object and bind to self
	maxHandle = _wx_wxdocument_wxDocument__create(this);
	wxbind(this, maxHandle);
}

MaxDocument::MaxDocument(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxDocument::~MaxDocument()
{
	wxunbind(this);
}

void MaxDocument::OnChangedViewList() {
	_wx_wxdocument_wxDocument__OnChangedViewList(maxHandle);
}

bool MaxDocument::OnCloseDocument() {
	return _wx_wxdocument_wxDocument__OnCloseDocument(maxHandle);
}

bool MaxDocument::OnCreate(const wxString& path, long flags) {
	return _wx_wxdocument_wxDocument__OnCreate(maxHandle, bbStringFromWxString(path), flags);
}

wxCommandProcessor* MaxDocument::OnCreateCommandProcessor() {
	return _wx_wxdocument_wxDocument__OnCreateCommandProcessor(maxHandle);
}

bool MaxDocument::OnNewDocument() {
	return _wx_wxdocument_wxDocument__OnNewDocument(maxHandle);
}

bool MaxDocument::OnOpenDocument(const wxString& filename) {
	return _wx_wxdocument_wxDocument__OnOpenDocument(maxHandle, bbStringFromWxString(filename));
}

bool MaxDocument::OnSaveDocument(const wxString& filename) {
	return _wx_wxdocument_wxDocument__OnSaveDocument(maxHandle, bbStringFromWxString(filename));
}

bool MaxDocument::OnSaveModified() {
	return _wx_wxdocument_wxDocument__OnSaveModified(maxHandle);
}

bool MaxDocument::IsModified() {
	return _wx_wxdocument_wxDocument__IsModified(maxHandle);
}

void MaxDocument::Modify(bool doModify) {
	_wx_wxdocument_wxDocument__Modify(maxHandle, doModify);
}

void MaxDocument::OnChangedViewList_default() {
	wxDocument::OnChangedViewList();
}

bool MaxDocument::OnCloseDocument_default() {
	return wxDocument::OnCloseDocument();
}

bool MaxDocument::OnCreate_default(const wxString& path, long flags) {
	return wxDocument::OnCreate(path, flags);
}

wxCommandProcessor* MaxDocument::OnCreateCommandProcessor_default() {
	return wxDocument::OnCreateCommandProcessor();
}

bool MaxDocument::OnNewDocument_default() {
	return wxDocument::OnNewDocument();
}

bool MaxDocument::OnOpenDocument_default(const wxString& filename) {
	return wxDocument::OnOpenDocument(filename);
}

bool MaxDocument::OnSaveDocument_default(const wxString& filename) {
	return wxDocument::OnSaveDocument(filename);
}

bool MaxDocument::OnSaveModified_default() {
	return wxDocument::OnSaveModified();
}

bool MaxDocument::IsModified_default() {
	return wxDocument::IsModified();
}

void MaxDocument::Modify_default(bool doModify) {
	wxDocument::Modify(doModify);
}

// +++++++++++++++++++++++++++++++++++++++++++++

IMPLEMENT_DYNAMIC_CLASS(MaxView , wxView)

// called when the framework creates an instance of wxView
MaxView::MaxView() {
	// create a bmx object and bind to self
	maxHandle = _wx_wxdocument_wxView__create(this);
	wxbind(this, maxHandle);
}

MaxView::MaxView(BBObject * handle)
	: maxHandle(handle)
{
	wxbind(this, handle);
}

MaxView::~MaxView() {
	wxunbind(this);
}

// *********************************************

wxDocument * bmx_wxdocument_create(BBObject * handle) {
	return new MaxDocument(handle);
}

bool bmx_wxdocument_addview(wxDocument * doc, wxView * view) {
	return doc->AddView(view);
}

bool bmx_wxdocument_close(wxDocument * doc) {
	return doc->Close();
}

bool bmx_wxdocument_deleteallviews(wxDocument * doc) {
	return doc->DeleteAllViews();
}

wxCommandProcessor * bmx_wxdocument_getcommandprocessor(wxDocument * doc) {
	return doc->GetCommandProcessor();
}

wxDocTemplate * bmx_wxdocument_getdocumenttemplate(wxDocument * doc) {
	return doc->GetDocumentTemplate();
}

wxDocManager * bmx_wxdocument_getdocumentmanager(wxDocument * doc) {
	return doc->GetDocumentManager();
}

BBString * bmx_wxdocument_getdocumentname(wxDocument * doc) {
	return bbStringFromWxString(doc->GetDocumentName());
}

wxWindow * bmx_wxdocument_getdocumentwindow(wxDocument * doc) {
	return doc->GetDocumentWindow();
}

BBString * bmx_wxdocument_getfilename(wxDocument * doc) {
	return bbStringFromWxString(doc->GetFilename());
}

wxView * bmx_wxdocument_getfirstview(wxDocument * doc) {
	return doc->GetFirstView();
}

BBString * bmx_wxdocument_getprintablename(wxDocument * doc) {
	wxString s;
	doc->GetPrintableName(s);
	return bbStringFromWxString(s);
}

BBString * bmx_wxdocument_gettitle(wxDocument * doc) {
	return bbStringFromWxString(doc->GetTitle());
}

bool bmx_wxdocument_ismodified(MaxDocument * doc) {
	return doc->IsModified_default();
}

wxInputStream * bmx_wxdocument_loadobject(wxDocument * doc, wxInputStream * stream) {
	return &doc->LoadObject(*stream);
}

void bmx_wxdocument_modify(MaxDocument * doc, bool doModify) {
	doc->Modify_default(doModify);
}

void bmx_wxdocument_onchangedviewlist(MaxDocument * doc) {
	doc->OnChangedViewList_default();
}

bool bmx_wxdocument_onclosedocument(MaxDocument * doc) {
	return doc->OnCloseDocument_default();
}

bool bmx_wxdocument_oncreate(MaxDocument * doc, BBString * path, long flags) {
	return doc->OnCreate_default(wxStringFromBBString(path), flags);
}

wxCommandProcessor * bmx_wxdocument_oncreatecommandprocessor(MaxDocument * doc) {
	return doc->OnCreateCommandProcessor_default();
}

bool bmx_wxdocument_onnewdocument(MaxDocument * doc) {
	return doc->OnNewDocument_default();
}

bool bmx_wxdocument_onopendocument(MaxDocument * doc, BBString * filename) {
	return doc->OnOpenDocument_default(wxStringFromBBString(filename));
}

bool bmx_wxdocument_onsavedocument(MaxDocument * doc, BBString * filename) {
	return doc->OnSaveDocument_default(wxStringFromBBString(filename));
}

bool bmx_wxdocument_onsavemodified(MaxDocument * doc) {
	return doc->OnSaveModified_default();
}

bool bmx_wxdocument_removeview(wxDocument * doc, wxView * view) {
	return doc->RemoveView(view);
}

bool bmx_wxdocument_save(wxDocument * doc) {
	return doc->Save();
}

bool bmx_wxdocument_saveas(wxDocument * doc) {
	return doc->SaveAs();
}

wxOutputStream * bmx_wxdocument_saveobject(wxDocument * doc, wxOutputStream * stream) {
	return &doc->SaveObject(*stream);
}

void bmx_wxdocument_setcommandprocessor(wxDocument * doc, wxCommandProcessor * processor) {
	doc->SetCommandProcessor(processor);
}

void bmx_wxdocument_setdocumentname(wxDocument * doc, BBString * name) {
	doc->SetDocumentName(wxStringFromBBString(name));
}

void bmx_wxdocument_setdocumenttemplate(wxDocument * doc, wxDocTemplate * templ) {
	doc->SetDocumentTemplate(templ);
}

void bmx_wxdocument_setfilename(wxDocument * doc, BBString * filename, bool notifyViews) {
	doc->SetFilename(wxStringFromBBString(filename), notifyViews);
}

void bmx_wxdocument_settitle(wxDocument * doc, BBString * title) {
	doc->SetTitle(wxStringFromBBString(title));
}

void bmx_wxdocument_updateallviews(wxDocument * doc, wxView * sender) {
	doc->UpdateAllViews(sender);
}


