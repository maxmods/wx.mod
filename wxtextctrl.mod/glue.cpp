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

MaxTextCtrl::MaxTextCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style, const wxValidator & val)
	: wxTextCtrl(parent, id, value, wxPoint(x, y), wxSize(w, h), style, val)
{
	wxbind(this, handle);
}

MaxTextCtrl::MaxTextCtrl()
{}

MaxTextCtrl::~MaxTextCtrl() {
	wxunbind(this);
}

int MaxTextCtrl::GetLineLength(long lineNo) const {
	return wxTextCtrl::GetLineLength(lineNo);
}

wxString MaxTextCtrl::GetLineText(long lineNo) const {
	return wxTextCtrl::GetLineText(lineNo);
}

int MaxTextCtrl::GetNumberOfLines() const {
	return wxTextCtrl::GetNumberOfLines();
}

bool MaxTextCtrl::IsModified() const {
	return wxTextCtrl::IsModified();
}

void MaxTextCtrl::MarkDirty() {
	wxTextCtrl::MarkDirty();
}

void MaxTextCtrl::DiscardEdits() {
	wxTextCtrl::DiscardEdits();
}

bool MaxTextCtrl::SetStyle(long start, long end, const wxTextAttr& style) {
	return wxTextCtrl::SetStyle(start, end, style);
}

bool MaxTextCtrl::GetStyle(long position, wxTextAttr& style) {
	return wxTextCtrl::GetStyle(position, style);
}

bool MaxTextCtrl::SetDefaultStyle(const wxTextAttr& style) {
	return wxTextCtrl::SetDefaultStyle(style);
}

long MaxTextCtrl::XYToPosition(long x, long y) const {
	return wxTextCtrl::XYToPosition(x, y);
}

bool MaxTextCtrl::PositionToXY(long pos, long *x, long *y) const {
	return wxTextCtrl::PositionToXY(pos, x, y);
}

void MaxTextCtrl::ShowPosition(long pos) {
	wxTextCtrl::ShowPosition(pos);
}

bool MaxTextCtrl::DoLoadFile(const wxString& file, int fileType) {
	return wxTextCtrl::DoLoadFile(file, fileType);
}

bool MaxTextCtrl::DoSaveFile(const wxString& file, int fileType) {
	return wxTextCtrl::DoSaveFile(file, fileType);
}

void MaxTextCtrl::SetMaxLength(unsigned long len) {
	wxTextCtrl::SetMaxLength(len);
}

void MaxTextCtrl::Copy() {
	wxTextCtrl::Copy();
}

void MaxTextCtrl::Cut() {
	wxTextCtrl::Cut();
}

void MaxTextCtrl::Paste() {
	wxTextCtrl::Paste();
}


MaxTextAttr::MaxTextAttr(const wxTextAttr& b)
	: textAttr(b)
{
}

wxTextAttr & MaxTextAttr::TextAttr() {
	return textAttr;
}

void MaxTextCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxTextCtrlXmlHandler , wxTextCtrlXmlHandler)

MaxTextCtrlXmlHandler:: MaxTextCtrlXmlHandler()
	: wxTextCtrlXmlHandler()
{}


wxObject * MaxTextCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(text, MaxTextCtrl)

    text->Create(m_parentAsWindow,
                 GetID(),
                 GetText(wxT("value")),
                 GetPosition(), GetSize(),
                 GetStyle(),
                 wxDefaultValidator,
                 GetName());

	text->MaxBind(_wx_wxtextctrl_wxTextCtrl__xrcNew(text));

    SetupWindow(text);

    if (HasParam(wxT("maxlength")))
        text->SetMaxLength(GetLong(wxT("maxlength")));

    return text;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxTextCtrl, wxTextCtrl)
END_EVENT_TABLE()


MaxTextCtrl * bmx_wxtextctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style, wxValidator * validator) {
	if (validator) {
		return new MaxTextCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, *validator);
	} else {
		return new MaxTextCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, wxDefaultValidator);
	}
}

void bmx_wxtextctrl_appendtext(wxTextCtrl * ctrl, BBString * text) {
	ctrl->AppendText(wxStringFromBBString(text));
}

int bmx_wxtextctrl_cancopy(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->CanCopy());
}

int bmx_wxtextctrl_cancut(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->CanCut());
}

int bmx_wxtextctrl_canpaste(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->CanPaste());
}

int bmx_wxtextctrl_canredo(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->CanRedo());
}

int bmx_wxtextctrl_canundo(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->CanUndo());
}

void bmx_wxtextctrl_clear(wxTextCtrl * ctrl) {
	ctrl->Clear();
}

void bmx_wxtextctrl_copy(wxTextCtrl * ctrl) {
	ctrl->Copy();
}

void bmx_wxtextctrl_cut(wxTextCtrl * ctrl) {
	ctrl->Cut();
}

void bmx_wxtextctrl_discardedits(wxTextCtrl * ctrl) {
	ctrl->DiscardEdits();
}

MaxTextAttr * bmx_wxtextctrl_getdefaultstyle(wxTextCtrl * ctrl) {
	wxTextAttr a(ctrl->GetDefaultStyle());
	return new MaxTextAttr(a);
}

long bmx_wxtextctrl_getinsertionpoint(wxTextCtrl * ctrl) {
	return ctrl->GetInsertionPoint();
}

long bmx_wxtextctrl_getlastposition(wxTextCtrl * ctrl) {
	return ctrl->GetLastPosition();
}

int bmx_wxtextctrl_getlinelength(wxTextCtrl * ctrl, long lineNo) {
	return ctrl->GetLineLength(lineNo);
}

BBString * bmx_wxtextctrl_getlinetext(wxTextCtrl * ctrl, long lineNo) {
	return bbStringFromWxString(ctrl->GetLineText(lineNo));
}

int bmx_wxtextctrl_getnumberoflines(wxTextCtrl * ctrl) {
	return ctrl->GetNumberOfLines();
}

BBString * bmx_wxtextctrl_getrange(wxTextCtrl * ctrl, long fromPos, long toPos) {
	return bbStringFromWxString(ctrl->GetRange(fromPos, toPos));
}

void bmx_wxtextctrl_getselection(wxTextCtrl * ctrl, long * fromPos, long * toPos) {
	ctrl->GetSelection(fromPos, toPos);
}

BBString * bmx_wxtextctrl_getstringselection(wxTextCtrl * ctrl) {
	return bbStringFromWxString(ctrl->GetStringSelection());
}

MaxTextAttr * bmx_wxtextctrl_getstyle(wxTextCtrl * ctrl, long position) {
	wxTextAttr attr;
	bool ret = ctrl->GetStyle(position, attr);
	
	return new MaxTextAttr(attr);
}

BBString * bmx_wxtextctrl_getvalue(wxTextCtrl * ctrl) {
	return bbStringFromWxString(ctrl->GetValue());
}

int bmx_wxtextctrl_iseditable(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->IsEditable());
}

int bmx_wxtextctrl_isempty(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->IsEmpty());
}

int bmx_wxtextctrl_ismodified(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->IsModified());
}

int bmx_wxtextctrl_ismultiline(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->IsMultiLine());
}

int bmx_wxtextctrl_issingleline(wxTextCtrl * ctrl) {
	return static_cast<int>(ctrl->IsSingleLine());
}


int bmx_wxtextctrl_loadfile(wxTextCtrl * ctrl, BBString * filename, int ftype) {
	return static_cast<int>(ctrl->LoadFile(wxStringFromBBString(filename), ftype));
}

void bmx_wxtextctrl_markdirty(wxTextCtrl * ctrl) {
	ctrl->MarkDirty();
}

void bmx_wxtextctrl_paste(wxTextCtrl * ctrl) {
	ctrl->Paste();
}

int bmx_wxtextctrl_positiontoxy(wxTextCtrl * ctrl, long pos, long * x, long * y) {
	return static_cast<int>(ctrl->PositionToXY(pos, x, y));
}

void bmx_wxtextctrl_redo(wxTextCtrl * ctrl) {
	ctrl->Redo();
}

void bmx_wxtextctrl_remove(wxTextCtrl * ctrl, long fromPos, long toPos) {
	ctrl->Remove(fromPos, toPos);
}

void bmx_wxtextctrl_replace(wxTextCtrl * ctrl, long fromPos, long toPos, BBString * value) {
	ctrl->Replace(fromPos, toPos, wxStringFromBBString(value));
}

int bmx_wxtextctrl_savefile(wxTextCtrl * ctrl, BBString * filename, int ftype) {
	return static_cast<int>(ctrl->SaveFile(wxStringFromBBString(filename), ftype));
}

int bmx_wxtextctrl_setdefaultstyle(wxTextCtrl * ctrl, MaxTextAttr * style) {
	return static_cast<int>(ctrl->SetDefaultStyle(style->TextAttr()));
}

void bmx_wxtextctrl_seteditable(wxTextCtrl * ctrl, int editable) {
	ctrl->SetEditable(static_cast<bool>(editable));
}

void bmx_wxtextctrl_setinsertionpoint(wxTextCtrl * ctrl, long pos) {
	ctrl->SetInsertionPoint(pos);
}

void bmx_wxtextctrl_setinsertionpointend(wxTextCtrl * ctrl) {
	ctrl->SetInsertionPointEnd();
}

void bmx_wxtextctrl_setmaxlength(wxTextCtrl * ctrl, unsigned long length) {
	ctrl->SetMaxLength(length);
}

void bmx_wxtextctrl_setmodified(wxTextCtrl * ctrl, int modified) {
	ctrl->SetModified(static_cast<bool>(modified));
}

void bmx_wxtextctrl_setselection(wxTextCtrl * ctrl, long fromPos, long toPos) {
	ctrl->SetSelection(fromPos, toPos);
}

void bmx_wxtextctrl_setstyle(wxTextCtrl * ctrl, long fromPos, long toPos, MaxTextAttr * style) {
	ctrl->SetStyle(fromPos, toPos, style->TextAttr());
}

void bmx_wxtextctrl_changevalue(wxTextCtrl * ctrl, BBString * value) {
	ctrl->ChangeValue(wxStringFromBBString(value));
}

void bmx_wxtextctrl_showposition(wxTextCtrl * ctrl, long pos) {
	ctrl->ShowPosition(pos);
}

void bmx_wxtextctrl_undo(wxTextCtrl * ctrl) {
	ctrl->Undo();
}

void bmx_wxtextctrl_writetext(wxTextCtrl * ctrl, BBString * text) {
	ctrl->WriteText(wxStringFromBBString(text));
}

long bmx_wxtextctrl_xytoposition(wxTextCtrl * ctrl, long x, long y) {
	return ctrl->XYToPosition(x, y);
}

wxTextCtrlHitTestResult bmx_wxtextctrl_hittest(wxTextCtrl * ctrl, int x, int y, long * col, long * row) {
	return ctrl->HitTest(wxPoint(x, y), col, row);
}

int bmx_wxtextctrl_emulatekeypress(wxTextCtrl * ctrl, wxKeyEvent & event) {
	return ctrl->EmulateKeyPress(event);
}

void bmx_wxtextattr_delete(MaxTextAttr * style) {
	delete style;
}


wxTextAttrAlignment bmx_wxtextattr_getalignment(MaxTextAttr * style) {
	return style->TextAttr().GetAlignment();
}

MaxColour * bmx_wxtextattr_getbackgroundcolour(MaxTextAttr * style) {
	wxColour c(style->TextAttr().GetBackgroundColour());
	return new MaxColour(c);
}

MaxFont * bmx_wxtextattr_getfont(MaxTextAttr * style) {
	wxFont f(style->TextAttr().GetFont());
	return new MaxFont(f);
}

int bmx_wxtextattr_getleftindent(MaxTextAttr * style) {
	return style->TextAttr().GetLeftIndent();
}

int bmx_wxtextattr_getleftsubindent(MaxTextAttr * style) {
	return style->TextAttr().GetLeftSubIndent();
}

int bmx_wxtextattr_getrightindent(MaxTextAttr * style) {
	return style->TextAttr().GetRightIndent();
}

BBArray * bmx_wxtextattr_gettabs(MaxTextAttr * style) {
	return wxArrayIntToBBIntArray(style->TextAttr().GetTabs());
}

MaxColour * bmx_wxtextattr_gettextcolour(MaxTextAttr * style) {
	wxColour c(style->TextAttr().GetTextColour());
	return new MaxColour(c);
}

int bmx_wxtextattr_hasalignment(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasAlignment());
}

int bmx_wxtextattr_hasbackgroundcolour(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasBackgroundColour());
}

int bmx_wxtextattr_hasfont(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasFont());
}

int bmx_wxtextattr_hasleftindent(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasLeftIndent());
}

int bmx_wxtextattr_hasrightindent(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasRightIndent());
}

int bmx_wxtextattr_hastabs(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasTabs());
}

int bmx_wxtextattr_hastextcolour(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().HasTextColour());
}

long bmx_wxtextattr_getflags(MaxTextAttr * style) {
	return style->TextAttr().GetFlags();
}

int bmx_wxtextattr_isdefault(MaxTextAttr * style) {
	return static_cast<int>(style->TextAttr().IsDefault());
}

void bmx_wxtextattr_merge(MaxTextAttr * style, MaxTextAttr * overlay) {
	style->TextAttr().Merge(overlay->TextAttr());
}

void bmx_wxtextattr_setalignment(MaxTextAttr * style, wxTextAttrAlignment alignment) {
	style->TextAttr().SetAlignment(alignment);
}

void bmx_wxtextattr_setbackgroundcolour(MaxTextAttr * style, MaxColour * colour) {
	style->TextAttr().SetBackgroundColour(colour->Colour());
}

void bmx_wxtextattr_setflags(MaxTextAttr * style, long flags) {
	style->TextAttr().SetFlags(flags);
}

void bmx_wxtextattr_setfont(MaxTextAttr * style, MaxFont * font) {
	style->TextAttr().SetFont(font->Font());
}

void bmx_wxtextattr_setleftindent(MaxTextAttr * style, int indent, int subIndent) {
	style->TextAttr().SetLeftIndent(indent, subIndent);
}

void bmx_wxtextattr_setrightindent(MaxTextAttr * style, int indent) {
	style->TextAttr().SetRightIndent(indent);
}

void bmx_wxtextattr_settabs(MaxTextAttr * style, BBArray * tabs) {
	style->TextAttr().SetTabs(bbIntArrayTowxArrayInt(tabs));
}

void bmx_wxtextattr_settextcolour(MaxTextAttr * style, MaxColour * colour) {
	style->TextAttr().SetTextColour(colour->Colour());
}

MaxTextAttr * bmx_wxtextattr_create(MaxColour * colText, MaxColour * colBack, MaxFont * font, wxTextAttrAlignment alignment) {

	wxTextAttr attr;
	
	if (colBack) {
		if (font) {
			attr = wxTextAttr(colText->Colour(), colBack->Colour(), font->Font(), alignment);
		} else {
			attr = wxTextAttr(colText->Colour(), colBack->Colour(), wxNullFont, alignment);
		}
	} else {
		if (font) {
			attr = wxTextAttr(colText->Colour(), wxNullColour, font->Font(), alignment);
		} else {
			attr = wxTextAttr(colText->Colour(), wxNullColour, wxNullFont, alignment);
		}
	}

	return new MaxTextAttr(attr);
}

const wxMouseEvent & bmx_wxtexturlevent_getmouseevent(wxTextUrlEvent & event) {
	return event.GetMouseEvent();
}

long bmx_wxtexturlevent_geturlstart(wxTextUrlEvent & event) {
	return event.GetURLStart();
}

long bmx_wxtexturlevent_geturlend(wxTextUrlEvent & event) {
	return event.GetURLEnd();
}


int bmx_wxtextctrl_geteventtype(int type) {
	switch(type) {
		case -7: return wxEVT_COMMAND_TEXT_UPDATED;
		case -8: return wxEVT_COMMAND_TEXT_ENTER;
		case -13: return wxEVT_COMMAND_TEXT_URL;
		case -14: return wxEVT_COMMAND_TEXT_MAXLEN;
	}
	
	return 0;
}

// *********************************************

void bmx_wxtextctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxTextCtrlXmlHandler);
}

