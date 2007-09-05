/*
  Copyright (c) 2007 Bruce A Henderson
 
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
#include "wx/toolbar.h"
#include "../wxbitmap.mod/glue.h"

class MaxToolBar;

extern "C" {

#include <blitz.h>

	MaxToolBar * bmx_wxtoolbar_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id,
		int x, int y, int w, int h, long style);
	bool bmx_wxtoolbar_addcontrol(MaxToolBar * toolbar, wxControl * control);
	void bmx_wxtoolbar_addseparator(MaxToolBar * toolbar);
	void bmx_wxtoolbar_addtool(MaxToolBar * toolbar, int id, BBString * label, MaxBitmap * bitmap1, 
			MaxBitmap * bitmap2, wxItemKind kind, BBString * shortHelp, BBString * longHelp, void * clientData);
	bool bmx_wxtoolbar_realize(MaxToolBar * toolbar);
	void bmx_wxtoolbar_settoolbitmapsize(MaxToolBar * toolbar, int w, int h);

	int bmx_wxtoolbar_geteventtype(int type);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolBar : public wxToolBar
{
public:
	MaxToolBar(wxWindow * parent, long style, wxWindowID id, const wxString& name);
	MaxToolBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxToolBar();
	void injectSelf(BBObject * handle);
	
private:
	BBObject * maxHandle;

};



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
