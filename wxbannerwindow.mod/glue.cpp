/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxBannerWindow::MaxBannerWindow(BBObject * handle, wxWindow * parent, wxWindowID id, wxDirection dir, int x, int y,
		int w, int h, long style)
	: wxBannerWindow(parent, id, dir, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxBannerWindow::MaxBannerWindow()
{}

MaxBannerWindow::~MaxBannerWindow() {
	wxunbind(this);
}

void MaxBannerWindow::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxBannerWindowXmlHandler , wxBannerWindowXmlHandler)

MaxBannerWindowXmlHandler:: MaxBannerWindowXmlHandler()
	: wxBannerWindowXmlHandler()
{}

wxObject * MaxBannerWindowXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(banner, MaxBannerWindow)

    banner->Create(m_parentAsWindow,
                   GetID(),
                   GetDirection(wxS("direction")),
                   GetPosition(),
                   GetSize(),
                   GetStyle(wxS("style")),
                   GetName());

	banner->MaxBind(_wx_wxbannerwindow_wxBannerWindow__xrcNew(banner));

    SetupWindow(banner);

    const wxColour colStart = GetColour(wxS("gradient-start"));
    const wxColour colEnd = GetColour(wxS("gradient-end"));
    if ( colStart.IsOk() || colEnd.IsOk() )
    {
        if ( !colStart.IsOk() || !colEnd.IsOk() )
        {
            ReportError
            (
                "Both start and end gradient colours must be "
                "specified if either one is."
            );
        }
        else
        {
            banner->SetGradient(colStart, colEnd);
        }
    }

    wxBitmap bitmap = GetBitmap();
    if ( bitmap.IsOk() )
    {
        if ( colStart.IsOk() || colEnd.IsOk() )
        {
            ReportError
            (
                "Gradient colours are ignored by wxBannerWindow "
                "if the background bitmap is specified."
            );
        }

        banner->SetBitmap(bitmap);
    }

    return banner;
}

// *********************************************

MaxBannerWindow * bmx_wxbannerwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int dir, int x, int y,
		int w, int h, long style) {
		
	return new MaxBannerWindow(maxHandle, parent, id, (wxDirection)dir, x, y, w, h, style);
}
	
void bmx_wxbannerwindow_setbitmap(wxBannerWindow * banner, MaxBitmap * bitmap) {
	banner->SetBitmap(bitmap->Bitmap());
}

void bmx_wxbannerwindow_settext(wxBannerWindow * banner, BBString * title, BBString * message) {
	banner->SetText(wxStringFromBBString(title), wxStringFromBBString(message));
}

void bmx_wxbannerwindow_setgradient(wxBannerWindow * banner, MaxColour * colStart, MaxColour * colEnd) {
	banner->SetGradient(colStart->Colour(), colEnd->Colour());
}

