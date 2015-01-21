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

#include "glue.h"

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxDocument , wxDocument)

// called when the framework creates an instance of wxDocument
MaxDocument::MaxDocument()
{
	// create a bmx object and bind to self
	maxHandle = CB_PREF(wx_wxdocument_wxDocument__create)(this);
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
	CB_PREF(wx_wxdocument_wxDocument__OnChangedViewList)(maxHandle);
}

bool MaxDocument::OnCloseDocument() {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnCloseDocument)(maxHandle));
}

bool MaxDocument::OnCreate(const wxString& path, long flags) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnCreate)(maxHandle, bbStringFromWxString(path), flags));
}

wxCommandProcessor* MaxDocument::OnCreateCommandProcessor() {
	return CB_PREF(wx_wxdocument_wxDocument__OnCreateCommandProcessor)(maxHandle);
}

bool MaxDocument::OnNewDocument() {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnNewDocument)(maxHandle));
}

bool MaxDocument::OnOpenDocument(const wxString& filename) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnOpenDocument)(maxHandle, bbStringFromWxString(filename)));
}

bool MaxDocument::OnSaveDocument(const wxString& filename) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnSaveDocument)(maxHandle, bbStringFromWxString(filename)));
}

bool MaxDocument::OnSaveModified() {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__OnSaveModified)(maxHandle));
}

bool MaxDocument::IsModified() {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocument__IsModified)(maxHandle));
}

void MaxDocument::Modify(bool doModify) {
	CB_PREF(wx_wxdocument_wxDocument__Modify)(maxHandle, static_cast<int>(doModify));
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
	maxHandle = CB_PREF(wx_wxdocument_wxView__create)(this);
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

void MaxView::OnActivateView(bool activate, wxView *activeView, wxView *deactiveView) {
	CB_PREF(wx_wxdocument_wxView__OnActivateView)(maxHandle, static_cast<int>(activate), activeView, deactiveView);
}

void MaxView::OnChangeFilename() {
	CB_PREF(wx_wxdocument_wxView_OnChangeFilename)(maxHandle);
}

bool MaxView::OnClose(bool deleteWindow) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxView_OnClose)(maxHandle, deleteWindow));
}

void MaxView::OnClosingDocument() {
	CB_PREF(wx_wxdocument_wxView_OnClosingDocument)(maxHandle);
}

bool MaxView::OnCreate(wxDocument* doc, long flags) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxView_OnCreate)(maxHandle, doc, flags));
}

wxPrintout* MaxView::OnCreatePrintout() {
	return CB_PREF(wx_wxdocument_wxView_OnCreatePrintout)(maxHandle);
}

void MaxView::OnDraw(wxDC* dc) {
	CB_PREF(wx_wxdocument_wxView_OnDraw)(maxHandle, new MaxDC(dc));
}

void MaxView::OnUpdate(wxView* sender, wxObject* hint) {
	CB_PREF(wx_wxdocument_wxView_OnUpdate)(maxHandle, sender);
}


void MaxView::OnActivateView_default(bool activate, wxView *activeView, wxView *deactiveView) {
	wxView::OnActivateView(static_cast<int>(activate), activeView, deactiveView);
}

void MaxView::OnChangeFilename_default() {
	wxView::OnChangeFilename();
}

bool MaxView::OnClose_default(bool deleteWindow) {
	return wxView::OnClose(deleteWindow);
}

void MaxView::OnClosingDocument_default() {
	wxView::OnClosingDocument();
}

bool MaxView::OnCreate_default(wxDocument* doc, long flags) {
	return wxView::OnCreate(doc, flags);
}

wxPrintout* MaxView::OnCreatePrintout_default() {
	return wxView::OnCreatePrintout();
}

void MaxView::OnDraw_default(wxDC* dc) {
	// default... does nothing...
	//wxView::OnDraw(dc);
}

void MaxView::OnUpdate_default(wxView* sender, wxObject* hint) {
	wxView::OnUpdate(sender, hint);
}


// +++++++++++++++++++++++++++++++++++++++++++++

MaxDocTemplate::MaxDocTemplate(BBObject * handle, wxDocManager* manager, const wxString& descr, const wxString& filter,
		const wxString& dir, const wxString& ext, const wxString& docTypeName, const wxString& viewTypeName, long flags)
	: maxHandle(handle), wxDocTemplate(manager, descr, filter, dir, ext, docTypeName, viewTypeName, NULL, NULL, flags)
{
	wxbind(this, maxHandle);
}

MaxDocTemplate::~MaxDocTemplate()
{
	wxunbind(this);
}

bool MaxDocTemplate::InitDocument(wxDocument* doc, const wxString& path, long flags) {
	return static_cast<bool>(CB_PREF(wx_wxdocument_wxDocTemplate_InitDocument)(maxHandle, doc, bbStringFromWxString(path), flags));
}

bool MaxDocTemplate::InitDocument_default(wxDocument* doc, const wxString& path, long flags) {
	return wxDocTemplate::InitDocument(doc, path, flags);
}


// +++++++++++++++++++++++++++++++++++++++++++++

MaxDocManager::MaxDocManager(BBObject * handle)
{
	wxbind(this, handle);
}

MaxDocManager::~MaxDocManager()
{
	wxunbind(this);
}


// *********************************************

wxDocument * bmx_wxdocument_create(BBObject * handle) {
	return new MaxDocument(handle);
}

int bmx_wxdocument_addview(wxDocument * doc, wxView * view) {
	return static_cast<int>(doc->AddView(view));
}

int bmx_wxdocument_close(wxDocument * doc) {
	return static_cast<int>(doc->Close());
}

int bmx_wxdocument_deleteallviews(wxDocument * doc) {
	return static_cast<int>(doc->DeleteAllViews());
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

int bmx_wxdocument_ismodified(MaxDocument * doc) {
	return static_cast<int>(doc->IsModified_default());
}

#if !defined(__WXGTK__)
wxInputStream * bmx_wxdocument_loadobject(wxDocument * doc, wxInputStream * stream) {
	return &doc->LoadObject(*stream);
}
#endif

void bmx_wxdocument_modify(MaxDocument * doc, int doModify) {
	doc->Modify_default(static_cast<bool>(doModify));
}

void bmx_wxdocument_onchangedviewlist(MaxDocument * doc) {
	doc->OnChangedViewList_default();
}

int bmx_wxdocument_onclosedocument(MaxDocument * doc) {
	return static_cast<int>(doc->OnCloseDocument_default());
}

int bmx_wxdocument_oncreate(MaxDocument * doc, BBString * path, long flags) {
	return static_cast<int>(doc->OnCreate_default(wxStringFromBBString(path), flags));
}

wxCommandProcessor * bmx_wxdocument_oncreatecommandprocessor(MaxDocument * doc) {
	return doc->OnCreateCommandProcessor_default();
}

int bmx_wxdocument_onnewdocument(MaxDocument * doc) {
	return static_cast<int>(doc->OnNewDocument_default());
}

int bmx_wxdocument_onopendocument(MaxDocument * doc, BBString * filename) {
	return static_cast<int>(doc->OnOpenDocument_default(wxStringFromBBString(filename)));
}

int bmx_wxdocument_onsavedocument(MaxDocument * doc, BBString * filename) {
	return static_cast<int>(doc->OnSaveDocument_default(wxStringFromBBString(filename)));
}

int bmx_wxdocument_onsavemodified(MaxDocument * doc) {
	return static_cast<int>(doc->OnSaveModified_default());
}

int bmx_wxdocument_removeview(wxDocument * doc, wxView * view) {
	return static_cast<int>(doc->RemoveView(view));
}

int bmx_wxdocument_save(wxDocument * doc) {
	return static_cast<int>(doc->Save());
}

int bmx_wxdocument_saveas(wxDocument * doc) {
	return static_cast<int>(doc->SaveAs());
}

#if !defined(__WXGTK__)
wxOutputStream * bmx_wxdocument_saveobject(wxDocument * doc, wxOutputStream * stream) {
	return &doc->SaveObject(*stream);
}
#endif

void bmx_wxdocument_setcommandprocessor(wxDocument * doc, wxCommandProcessor * processor) {
	doc->SetCommandProcessor(processor);
}

void bmx_wxdocument_setdocumentname(wxDocument * doc, BBString * name) {
	doc->SetDocumentName(wxStringFromBBString(name));
}

void bmx_wxdocument_setdocumenttemplate(wxDocument * doc, wxDocTemplate * templ) {
	doc->SetDocumentTemplate(templ);
}

void bmx_wxdocument_setfilename(wxDocument * doc, BBString * filename, int notifyViews) {
	doc->SetFilename(wxStringFromBBString(filename), static_cast<bool>(notifyViews));
}

void bmx_wxdocument_settitle(wxDocument * doc, BBString * title) {
	doc->SetTitle(wxStringFromBBString(title));
}

void bmx_wxdocument_updateallviews(wxDocument * doc, wxView * sender) {
	doc->UpdateAllViews(sender);
}

// *********************************************


wxDocTemplate * bmx_wxdoctemplate_create(BBObject * handle, wxDocManager * manager, BBString *desc, BBString * filter,
		BBString * dir, BBString * ext, BBString * docTypeName, BBString * viewTypeName, long flags) {
	return new MaxDocTemplate(handle, manager, wxStringFromBBString(desc), wxStringFromBBString(filter), 
		wxStringFromBBString(dir), wxStringFromBBString(ext), wxStringFromBBString(docTypeName),
		wxStringFromBBString(viewTypeName), flags);
}

BBString * bmx_wxdoctemplate_getdefaultextension(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetDefaultExtension());
}

BBString * bmx_wxdoctemplate_getdescription(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetDescription());
}

BBString * bmx_wxdoctemplate_getdirectory(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetDirectory());
}

wxDocManager * bmx_wxdoctemplate_getdocumentmanager(wxDocTemplate * templ) {
	return templ->GetDocumentManager();
}

BBString * bmx_wxdoctemplate_getdocumentname(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetDocumentName());
}

BBString * bmx_wxdoctemplate_getfilefilter(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetFileFilter());
}

long bmx_wxdoctemplate_getflags(wxDocTemplate * templ) {
	return templ->GetFlags();
}

BBString * bmx_wxdoctemplate_getviewname(wxDocTemplate * templ) {
	return bbStringFromWxString(templ->GetViewName());
}

int bmx_wxdoctemplate_initdocument(MaxDocTemplate * templ, wxDocument * doc, BBString * path, long flags) {
	return static_cast<int>(templ->InitDocument_default(doc, wxStringFromBBString(path), flags));
}

int bmx_wxdoctemplate_isvisible(wxDocTemplate * templ) {
	return static_cast<int>(templ->IsVisible());
}

void bmx_wxdoctemplate_setdefaultextension(wxDocTemplate * templ, BBString * ext) {
	templ->SetDefaultExtension(wxStringFromBBString(ext));
}

void bmx_wxdoctemplate_setdescription(wxDocTemplate * templ, BBString * desc) {
	templ->SetDescription(wxStringFromBBString(desc));
}

void bmx_wxdoctemplate_setdirectory(wxDocTemplate * templ, BBString * dir) {
	templ->SetDirectory(wxStringFromBBString(dir));
}

void bmx_wxdoctemplate_setfilefilter(wxDocTemplate * templ, BBString * filter) {
	templ->SetFileFilter(wxStringFromBBString(filter));
}

void bmx_wxdoctemplate_setflags(wxDocTemplate * templ, long flags) {
	templ->SetFlags(flags);
}

// *********************************************


wxDocManager * bmx_wxdocmanager_create(BBObject * handle) {
	return new MaxDocManager(handle);
}

void bmx_wxdocmanager_activateview(wxDocManager * mgr, wxView * doc, int activate) {
	mgr->ActivateView(doc, static_cast<bool>(activate));
}

void bmx_wxdocmanager_adddocument(wxDocManager * mgr, wxDocument * doc) {
	mgr->AddDocument(doc);
}

void bmx_wxdocmanager_addfiletohistory(wxDocManager * mgr, BBString * filename) {
	mgr->AddFileToHistory(wxStringFromBBString(filename));
}

void bmx_wxdocmanager_associatetemplate(wxDocManager * mgr, wxDocTemplate * temp) {
	mgr->AssociateTemplate(temp);
}

int bmx_wxdocmanager_closedocuments(wxDocManager * mgr, int force) {
	return static_cast<int>(mgr->CloseDocuments(static_cast<bool>(force)));
}

wxDocument * bmx_wxdocmanager_createdocument(wxDocManager * mgr, BBString * path, long flags) {
	return mgr->CreateDocument(wxStringFromBBString(path), flags);
}

wxView * bmx_wxdocmanager_createview(wxDocManager * mgr, wxDocument * doc, long flags) {
	return mgr->CreateView(doc, flags);
}

void bmx_wxdocmanager_disassociatetemplate(wxDocManager * mgr, wxDocTemplate * temp) {
	mgr->DisassociateTemplate(temp);
}

void bmx_wxdocmanager_filehistoryaddfilestomenu(wxDocManager * mgr) {
	mgr->FileHistoryAddFilesToMenu();
}

void bmx_wxdocmanager_filehistoryload(wxDocManager * mgr, wxConfigBase * config) {
	mgr->FileHistoryLoad(*config);
}

void bmx_wxdocmanager_filehistoryremovemenu(wxDocManager * mgr, wxMenu * menu) {
	mgr->FileHistoryRemoveMenu(menu);
}

void bmx_wxdocmanager_filehistorysave(wxDocManager * mgr, wxConfigBase * resourceFile) {
	mgr->FileHistorySave(*resourceFile);
}

void bmx_wxdocmanager_filehistoryusemenu(wxDocManager * mgr, wxMenu * menu) {
	mgr->FileHistoryUseMenu(menu);
}

wxDocTemplate * bmx_wxdocmanager_findtemplateforpath(wxDocManager * mgr, BBString * path) {
	return mgr->FindTemplateForPath(wxStringFromBBString(path));
}

wxDocument * bmx_wxdocmanager_getcurrentdocument(wxDocManager * mgr) {
	return mgr->GetCurrentDocument();
}

wxView * bmx_wxdocmanager_getcurrentview(wxDocManager * mgr) {
	return mgr->GetCurrentView();
}

wxFileHistory * bmx_wxdocmanager_getfilehistory(wxDocManager * mgr) {
	return mgr->GetFileHistory();
}

BBString * bmx_wxdocmanager_getlastdirectory(wxDocManager * mgr) {
	return bbStringFromWxString(mgr->GetLastDirectory());
}

int bmx_wxdocmanager_getmaxdocsopen(wxDocManager * mgr) {
	return mgr->GetMaxDocsOpen();
}

int bmx_wxdocmanager_gethistoryfilescount(wxDocManager * mgr) {
	return mgr->GetHistoryFilesCount();
}

BBString * bmx_wxdocmanager_makedefaultname(wxDocManager * mgr) {
	wxString s;
	bool res = mgr->MakeDefaultName(s);
	return bbStringFromWxString(s);
}

void bmx_wxdocmanager_removedocument(wxDocManager * mgr, wxDocument * doc) {
	mgr->RemoveDocument(doc);
}

void bmx_wxdocmanager_setlastdirectory(wxDocManager * mgr, BBString * dir) {
	mgr->SetLastDirectory(wxStringFromBBString(dir));
}

void bmx_wxdocmanager_setmaxdocsopen(wxDocManager * mgr, int num) {
	mgr->SetMaxDocsOpen(num);
}

// *********************************************


wxView * bmx_wxview_create(BBObject * handle) {
	return new MaxView(handle);
}

void bmx_wxview_activate(wxView * view, int doActivate) {
	view->Activate(static_cast<bool>(doActivate));
}

int bmx_wxview_close(wxView * view, int deleteWindow) {
	return static_cast<int>(view->Close(static_cast<bool>(deleteWindow)));
}

wxDocument * bmx_wxview_getdocument(wxView * view) {
	return view->GetDocument();
}

wxDocManager * bmx_wxview_getdocumentmanager(wxView * view) {
	return view->GetDocumentManager();
}

wxWindow * bmx_wxview_getframe(wxView * view) {
	return view->GetFrame();
}

BBString * bmx_wxview_getviewname(wxView * view) {
	return bbStringFromWxString(view->GetViewName());
}

void bmx_wxview_onactivateview(MaxView * view, int activate, wxView * activeView, wxView * deactiveView) {
	view->OnActivateView_default(static_cast<bool>(activate), activeView, deactiveView);
}

void bmx_wxview_onchangefilename(MaxView * view) {
	view->OnChangeFilename_default();
}

int bmx_wxview_onclose(MaxView * view, int deleteWindow) {
	return static_cast<int>(view->OnClose_default(static_cast<bool>(deleteWindow)));
}

void bmx_wxview_onclosingdocument(MaxView * view) {
	view->OnClosingDocument_default();
}

int bmx_wxView_oncreate(MaxView * view, wxDocument * doc, long flags) {
	return static_cast<int>(view->OnCreate_default(doc, flags));
}

wxPrintout * bmx_wxview_oncreateprintout(MaxView * view) {
	return view->OnCreatePrintout_default();
}

void bmx_wxview_ondraw(MaxView * view, MaxDC * dc) {
	view->OnDraw_default(dc->GetDC());
}

void bmx_wxview_onupdate(MaxView * view, wxView * sender) {
	view->OnUpdate_default(sender, NULL);
}

void bmx_wxview_setdocument(wxView * view, wxDocument * doc) {
	view ->SetDocument(doc);
}

void bmx_wxview_setframe(wxView * view, wxWindow * frame) {
	view->SetFrame(frame);
}

void bmx_wxview_setviewname(wxView * view, BBString * name) {
	view->SetViewName(wxStringFromBBString(name));
}


