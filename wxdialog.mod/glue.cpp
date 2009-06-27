/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

MaxDialog::MaxDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style)
	: wxDialog(parent, id, title, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxDialog::MaxDialog()
{}

MaxDialog::~MaxDialog() {
	wxunbind(this);
}

void MaxDialog::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxDialogXmlHandler, wxDialogXmlHandler)

MaxDialogXmlHandler::MaxDialogXmlHandler()
	: wxDialogXmlHandler()
{}


wxObject * MaxDialogXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(dlg, MaxDialog);

    dlg->Create(m_parentAsWindow,
                GetID(),
                GetText(wxT("title")),
                wxDefaultPosition, wxDefaultSize,
                GetStyle(wxT("style"), wxDEFAULT_DIALOG_STYLE),
                GetName());

	dlg->MaxBind(_wx_wxdialog_wxDialog__xrcNew(dlg));

    if (HasParam(wxT("size")))
        dlg->SetClientSize(GetSize(wxT("size"), dlg));
    if (HasParam(wxT("pos")))
        dlg->Move(GetPosition());
    if (HasParam(wxT("icon")))
        dlg->SetIcon(GetIcon(wxT("icon"), wxART_FRAME_ICON));

    SetupWindow(dlg);

    CreateChildren(dlg);

    if (GetBool(wxT("centered"), false))
        dlg->Centre();

    return dlg;
}

// *********************************************


MaxDialog * bmx_wxdialog_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * title, int x, int y,
		int w, int h, long style) {
	if (parent) {
		return new MaxDialog(maxHandle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
	} else {
		return new MaxDialog(maxHandle, NULL, id, wxStringFromBBString(title), x, y, w, h, style);
	}
}

void bmx_wxdialog_free(wxDialog * dialog) {
	delete dialog;
}

void bmx_wxdialog_centre(wxDialog * dialog, int direction) {
	dialog->Centre(direction);
}

int bmx_wxdialog_show(wxDialog * dialog, int show) {
	return static_cast<int>(dialog->Show(static_cast<bool>(show)));
}

int bmx_wxdialog_showmodal(wxDialog * dialog) {
	return dialog->ShowModal();
}


wxSizer * bmx_wxdialog_createbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateButtonSizer(flags);
}

wxSizer * bmx_wxdialog_createseparatedbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateSeparatedButtonSizer(flags);
}

wxStdDialogButtonSizer * bmx_wxdialog_createstddialogbuttonsizer(wxDialog * dialog, int flags) {
	return dialog->CreateStdDialogButtonSizer(flags);
}

void bmx_wxdialog_endmodal(wxDialog * dialog, int retCode) {
	dialog->EndModal(retCode);
}

int bmx_wxdialog_getaffirmativeid(wxDialog * dialog) {
	return dialog->GetAffirmativeId();
}

int bmx_wxdialog_getescapeid(wxDialog * dialog) {
	return dialog->GetEscapeId();
}

int bmx_wxdialog_getreturncode(wxDialog * dialog) {
	return dialog->GetReturnCode();
}

void bmx_wxdialog_iconize(wxDialog * dialog, int value) {
	dialog->Iconize(static_cast<bool>(value));
}

int bmx_wxdialog_isiconized(wxDialog * dialog) {
	return static_cast<int>(dialog->IsIconized());
}

int bmx_wxdialog_ismodal(wxDialog * dialog) {
	return static_cast<int>(dialog->IsModal());
}

void bmx_wxdialog_setaffirmativeid(wxDialog * dialog, int id) {
	dialog->SetAffirmativeId(id);
}

void bmx_wxdialog_setescapeid(wxDialog * dialog, int id) {
	dialog->SetEscapeId(id);
}

void bmx_wxdialog_seticon(wxDialog * dialog, MaxIcon * icon) {
	dialog->SetIcon(icon->Icon());
}

void bmx_wxdialog_setreturncode(wxDialog * dialog, int retCode) {
	dialog->SetReturnCode(retCode);
}

void bmx_wxdialog_seticons(wxDialog * dialog, MaxIconBundle * icons) {
	dialog->SetIcons(icons->Bundle());
}

// *********************************************

void bmx_wxdialog_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxDialogXmlHandler);
}

