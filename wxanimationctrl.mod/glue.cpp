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

MaxAnimationCtrl::MaxAnimationCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, MaxAnimation * anim, int x, int y,
		int w, int h, long style)
	: wxAnimationCtrl(parent, id, (anim) ? anim->Animation() : wxNullAnimation, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxAnimationCtrl::MaxAnimationCtrl()
{}

MaxAnimationCtrl::~MaxAnimationCtrl() {
	wxunbind(this);
}

void MaxAnimationCtrl::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxAnimationCtrlXmlHandler , wxAnimationCtrlXmlHandler)

MaxAnimationCtrlXmlHandler:: MaxAnimationCtrlXmlHandler()
	: wxAnimationCtrlXmlHandler()
{}

wxObject * MaxAnimationCtrlXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(ctrl, MaxAnimationCtrl)

    wxScopedPtr<wxAnimation> animation(GetAnimation(wxT("animation")));

    ctrl->Create(m_parentAsWindow,
                  GetID(),
                  animation ? *animation : wxNullAnimation,
                  GetPosition(), GetSize(),
                  GetStyle(wxT("style"), wxAC_DEFAULT_STYLE),
                  GetName());

	ctrl->MaxBind(_wx_wxanimationctrl_wxAnimationCtrl__xrcNew(ctrl));

    // if no inactive-bitmap has been provided, GetBitmap() will return wxNullBitmap
    // which just tells wxAnimationCtrl to use the default for inactive status
    ctrl->SetInactiveBitmap(GetBitmap(wxT("inactive-bitmap")));

    SetupWindow(ctrl);

    return ctrl;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxAnimationCtrl, wxAnimationCtrl)
END_EVENT_TABLE()

MaxAnimationCtrl * bmx_wxanimationctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, MaxAnimation * anim, int x, int y,
		int w, int h, long style) {
	return new MaxAnimationCtrl(maxHandle, parent, id, anim, x, y, w, h, style);
}

MaxAnimation * bmx_wxanimationctrl_getanimation(wxAnimationCtrl * anim) {
	return new MaxAnimation(anim->GetAnimation());
}

MaxBitmap * bmx_wxanimationctrl_getinactivebitmap(wxAnimationCtrl * anim) {
	return new MaxBitmap(anim->GetInactiveBitmap());
}

int bmx_wxanimationctrl_isplaying(wxAnimationCtrl * anim) {
	return anim->IsPlaying();
}

int bmx_wxanimationctrl_loadfile(wxAnimationCtrl * anim, BBString * file, int animType) {
	return anim->LoadFile(wxStringFromBBString(file), (wxAnimationType)animType);
}

int bmx_wxanimationctrl_load(wxAnimationCtrl * anim, MaxInputStream * stream, int animType) {
	return anim->Load(*stream, (wxAnimationType)animType);
}

int bmx_wxanimationctrl_play(wxAnimationCtrl * anim) {
	return anim->Play();
}

void bmx_wxanimationctrl_setanimation(wxAnimationCtrl * anim, MaxAnimation * animation) {
	anim->SetAnimation(animation->Animation());
}

void bmx_wxanimationctrl_setinactivebitmap(wxAnimationCtrl * anim, MaxBitmap * bitmap) {
	anim->SetInactiveBitmap(bitmap->Bitmap());
}

void bmx_wxanimationctrl_stop(wxAnimationCtrl * anim) {
	anim->Stop();
}

// *********************************************

void bmx_wxanimationctrl_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxAnimationCtrlXmlHandler);
}
