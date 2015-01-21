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

MaxPropertySheetDialog::MaxPropertySheetDialog(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& title, int x, int y,
		int w, int h, long style)
	: maxHandle(handle), wxPropertySheetDialog(parent, id, title, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxPropertySheetDialog::~MaxPropertySheetDialog() {
	wxunbind(this);
}

MaxPropertySheetDialog::MaxPropertySheetDialog()
{}

void MaxPropertySheetDialog::AddBookCtrl(wxSizer* sizer) {
	CB_PREF(wx_wxpropertysheetdialog_wxPropertySheetDialog__AddBookCtrl)(maxHandle, sizer);
}

wxBookCtrlBase* MaxPropertySheetDialog::CreateBookCtrl() {
	return CB_PREF(wx_wxpropertysheetdialog_wxPropertySheetDialog__CreateBookCtrl)(maxHandle);
}

void MaxPropertySheetDialog::AddBookCtrl_default(wxSizer* sizer) {
	wxPropertySheetDialog::AddBookCtrl(sizer);
}

wxBookCtrlBase* MaxPropertySheetDialog::CreateBookCtrl_default() {
	return wxPropertySheetDialog::CreateBookCtrl();
}

void MaxPropertySheetDialog::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxPropertySheetDialogXmlHandler, wxPropertySheetDialogXmlHandler)

MaxPropertySheetDialogXmlHandler::MaxPropertySheetDialogXmlHandler()
	: wxPropertySheetDialogXmlHandler(), m_isInside(false), m_dialog(NULL)
{}


wxObject * MaxPropertySheetDialogXmlHandler::DoCreateResource()
{
    if (m_class == wxT("propertysheetpage"))
    {
        wxXmlNode *n = GetParamNode(wxT("object"));

        if (!n) n = GetParamNode(wxT("object_ref"));

        if (n)
        {
            wxBookCtrlBase *bookctrl = m_dialog->GetBookCtrl();
            bool old_ins = m_isInside;
            m_isInside = false;
            wxObject *item = CreateResFromNode(n, bookctrl, NULL);
            m_isInside = old_ins;
            wxWindow *wnd = wxDynamicCast(item, wxWindow);

            if (wnd)
            {
                bookctrl->AddPage(wnd, GetText(wxT("label")), GetBool(wxT("selected")));
                if (HasParam(wxT("bitmap")))
                {
                    wxBitmap bmp = GetBitmap(wxT("bitmap"), wxART_OTHER);
                    wxImageList *imgList = bookctrl->GetImageList();
                    if (imgList == NULL)
                    {
                        imgList = new wxImageList(bmp.GetWidth(), bmp.GetHeight());
                        bookctrl->AssignImageList(imgList);
                    }
                    int imgIndex = imgList->Add(bmp);
                    bookctrl->SetPageImage(bookctrl->GetPageCount()-1, imgIndex);
                }
            }
            else
                wxLogError(wxT("Error in resource."));
            return wnd;
        }
        else
        {
            wxLogError(wxT("Error in resource: no control within wxPropertySheetDialog's <page> tag."));
            return NULL;
        }
    }

    else
    {
        XRC_MAKE_INSTANCE(dlg, MaxPropertySheetDialog)

        dlg->Create(m_parentAsWindow,
                   GetID(),
                   GetText(wxT("title")),
                   GetPosition(),
                   GetSize(),
                   GetStyle(),
                   GetName());

        if (HasParam(wxT("icon"))) dlg->SetIcon(GetIcon(wxT("icon"), wxART_FRAME_ICON));

 		dlg->MaxBind(CB_PREF(wx_wxpropertysheetdialog_wxPropertySheetDialog__xrcNew)(dlg));

       SetupWindow(dlg);

        wxPropertySheetDialog *old_par = m_dialog;
        m_dialog = dlg;
        bool old_ins = m_isInside;
        m_isInside = true;
        CreateChildren(m_dialog, true/*only this handler*/);
        m_isInside = old_ins;
        m_dialog = old_par;

        if (GetBool(wxT("centered"), false)) dlg->Centre();
        wxString buttons = GetText(wxT("buttons"));
        if (!buttons.IsEmpty())
        {
            int flags = 0;
            if (buttons.Find(wxT("wxOK"))         != wxNOT_FOUND) flags |= wxOK;
            if (buttons.Find(wxT("wxCANCEL"))     != wxNOT_FOUND) flags |= wxCANCEL;
            if (buttons.Find(wxT("wxYES"))        != wxNOT_FOUND) flags |= wxYES;
            if (buttons.Find(wxT("wxNO"))         != wxNOT_FOUND) flags |= wxNO;
            if (buttons.Find(wxT("wxHELP"))       != wxNOT_FOUND) flags |= wxHELP;
            if (buttons.Find(wxT("wxNO_DEFAULT")) != wxNOT_FOUND) flags |= wxNO_DEFAULT;
            dlg->CreateButtons(flags);
        }

        return dlg;
    }
}

bool MaxPropertySheetDialogXmlHandler::CanHandle(wxXmlNode *node)
{
    return ((!m_isInside && IsOfClass(node, wxT("wxPropertySheetDialog"))) ||
            (m_isInside && IsOfClass(node, wxT("propertysheetpage"))));
}


// *********************************************

BEGIN_EVENT_TABLE(MaxPropertySheetDialog, wxPropertySheetDialog)
END_EVENT_TABLE()


wxPropertySheetDialog * bmx_wxpropertysheetdialog_create(BBObject * handle, wxWindow * parent,
		wxWindowID id, BBString * title, int x, int y, int w, int h, long style) {
	return new MaxPropertySheetDialog(handle, parent, id, wxStringFromBBString(title), x, y, w, h, style);
}

void bmx_wxpropertysheetdialog_addbookctrl(MaxPropertySheetDialog * dialog, wxSizer * sizer) {
	dialog->AddBookCtrl_default(sizer);
}

wxBookCtrlBase * bmx_wxpropertysheetdialog_createbookctrl(MaxPropertySheetDialog * dialog) {
	return dialog->CreateBookCtrl_default();
}

void bmx_wxpropertysheetdialog_createbuttons(wxPropertySheetDialog * dialog, int flags) {
	dialog->CreateButtons(flags);
}

wxBookCtrlBase * bmx_wxpropertysheetdialog_getbookctrl(wxPropertySheetDialog * dialog) {
	return dialog->GetBookCtrl();
}

wxSizer * bmx_wxpropertysheetdialog_getinnersizer(wxPropertySheetDialog * dialog) {
	return dialog->GetInnerSizer();
}

int bmx_wxpropertysheetdialog_getsheetstyle(wxPropertySheetDialog * dialog) {
	return dialog->GetSheetStyle();
}

void bmx_wxpropertysheetdialog_layoutdialog(wxPropertySheetDialog * dialog, int centreFlags) {
	dialog->LayoutDialog(centreFlags);
}

void bmx_wxpropertysheetdialog_setbookctrl(wxPropertySheetDialog * dialog, wxBookCtrlBase * bookCtrl) {
	dialog->SetBookCtrl(bookCtrl);
}

// *********************************************

void bmx_wxpropertysheetdialog_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxPropertySheetDialogXmlHandler);
}


