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
#include "wx/glcanvas.h"

#if wxUSE_GLCANVAS


class MaxGLCanvas;

enum{
	FLAGS_BACKBUFFER=	0x2,
	FLAGS_ALPHABUFFER=	0x4,
	FLAGS_DEPTHBUFFER=	0x8,
	FLAGS_STENCILBUFFER=0x10,
	FLAGS_ACCUMBUFFER=	0x20,
	FLAGS_FULLSCREEN=0x80000000
};

extern "C" {

#include <blitz.h>

	void _wx_wxglcanvas_wxGLCanvas__OnPaint(BBObject * event);

	MaxGLCanvas * bmx_wxglcanvas_create(BBObject * handle, wxWindow* parent, wxWindowID id,
		int flags, int x, int y, int w, int h, long style);
	void bmx_wxglcanvas_swapbuffers(wxGLCanvas * canvas);

	void bmx_wxglcanvas_onpainthook(MaxGLCanvas * canvas, BBObject * event);


}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGLCanvas : public wxGLCanvas
{
public:
	MaxGLCanvas(BBObject * handle, wxWindow* parent, wxWindowID id,
		int x, int y, int w, int h, long style, const wxString& name, int* attribList);
	~MaxGLCanvas();
	void Render(BBObject * event);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

#endif
