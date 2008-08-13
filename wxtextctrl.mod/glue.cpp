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


MaxTextCtrl * bmx_wxtextctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, long style, MaxTextValidator * validator) {
	if (validator) {
		return new MaxTextCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, validator->Validator());
	} else {
		return new MaxTextCtrl(maxHandle, parent, id, wxStringFromBBString(value), x, y, w, h, style, wxDefaultValidator);
	}
}

void bmx_wxtextctrl_appendtext(wxTextCtrl * ctrl, BBString * text) {
	ctrl->AppendText(wxStringFromBBString(text));
}

bool bmx_wxtextctrl_cancopy(wxTextCtrl * ctrl) {
	return ctrl->CanCopy();
}

bool bmx_wxtextctrl_cancut(wxTextCtrl * ctrl) {
	return ctrl->CanCut();
}

bool bmx_wxtextctrl_canpaste(wxTextCtrl * ctrl) {
	return ctrl->CanPaste();
}

bool bmx_wxtextctrl_canredo(wxTextCtrl * ctrl) {
	return ctrl->CanRedo();
}

bool bmx_wxtextctrl_canundo(wxTextCtrl * ctrl) {
	return ctrl->CanUndo();
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

bool bmx_wxtextctrl_iseditable(wxTextCtrl * ctrl) {
	return ctrl->IsEditable();
}

bool bmx_wxtextctrl_isempty(wxTextCtrl * ctrl) {
	return ctrl->IsEmpty();
}

bool bmx_wxtextctrl_ismodified(wxTextCtrl * ctrl) {
	return ctrl->IsModified();
}

bool bmx_wxtextctrl_ismultiline(wxTextCtrl * ctrl) {
	return ctrl->IsMultiLine();
}

bool bmx_wxtextctrl_issingleline(wxTextCtrl * ctrl) {
	return ctrl->IsSingleLine();
}


bool bmx_wxtextctrl_loadfile(wxTextCtrl * ctrl, BBString * filename, int ftype) {
	return ctrl->LoadFile(wxStringFromBBString(filename), ftype);
}

void bmx_wxtextctrl_markdirty(wxTextCtrl * ctrl) {
	ctrl->MarkDirty();
}

void bmx_wxtextctrl_paste(wxTextCtrl * ctrl) {
	ctrl->Paste();
}

bool bmx_wxtextctrl_positiontoxy(wxTextCtrl * ctrl, long pos, long * x, long * y) {
	return ctrl->PositionToXY(pos, x, y);
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

bool bmx_wxtextctrl_savefile(wxTextCtrl * ctrl, BBString * filename, int ftype) {
	return ctrl->SaveFile(wxStringFromBBString(filename), ftype);
}

bool bmx_wxtextctrl_setdefaultstyle(wxTextCtrl * ctrl, MaxTextAttr * style) {
	return ctrl->SetDefaultStyle(style->TextAttr());
}

void bmx_wxtextctrl_seteditable(wxTextCtrl * ctrl, bool editable) {
	ctrl->SetEditable(editable);
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

void bmx_wxtextctrl_setmodified(wxTextCtrl * ctrl, bool modified) {
	ctrl->SetModified(modified);
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

bool bmx_wxtextattr_hasalignment(MaxTextAttr * style) {
	return style->TextAttr().HasAlignment();
}

bool bmx_wxtextattr_hasbackgroundcolour(MaxTextAttr * style) {
	return style->TextAttr().HasBackgroundColour();
}

bool bmx_wxtextattr_hasfont(MaxTextAttr * style) {
	return style->TextAttr().HasFont();
}

bool bmx_wxtextattr_hasleftindent(MaxTextAttr * style) {
	return style->TextAttr().HasLeftIndent();
}

bool bmx_wxtextattr_hasrightindent(MaxTextAttr * style) {
	return style->TextAttr().HasRightIndent();
}

bool bmx_wxtextattr_hastabs(MaxTextAttr * style) {
	return style->TextAttr().HasTabs();
}

bool bmx_wxtextattr_hastextcolour(MaxTextAttr * style) {
	return style->TextAttr().HasTextColour();
}

long bmx_wxtextattr_getflags(MaxTextAttr * style) {
	return style->TextAttr().GetFlags();
}

bool bmx_wxtextattr_isdefault(MaxTextAttr * style) {
	return style->TextAttr().IsDefault();
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

