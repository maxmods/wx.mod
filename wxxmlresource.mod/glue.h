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

#ifndef _WX_MAX_XMLRESOURCE_H_
#define _WX_MAX_XMLRESOURCE_H_

#include "wxglue.h"
#include "wx/xrc/xmlres.h"
#include "wx/xrc/xh_unkwn.h"
#include "wx/xrc/xh_bmp.h"
#include "wx/xml/xml.h"

extern "C" {

#include <blitz.h>

	wxXmlResource * bmx_wxxmlresource_get();
	void bmx_wxxmlresource_initallhandlers(wxXmlResource * res);
	bool bmx_wxxmlresource_load(wxXmlResource * res, BBString * filemask);
	wxFrame * bmx_wxxmlresource_loadframe(wxXmlResource * res, wxWindow * parent, BBString * name);
	wxWindow * bmx_wxxmlresource_xrcctrl(wxWindow * parent, BBString * id);
	int bmx_wxxmlresource_wrcid(BBString * name);
	wxObject * bmx_wxxmlresource_loadobject(wxXmlResource * res, BBObject * win, wxWindow * parent, 
		BBString * name, BBString * classname);
	void bmx_wxxmlresource_clearhandlers(wxXmlResource * res);
	long bmx_wxxmlresource_getflags(wxXmlResource * res);
	wxDialog * bmx_wxxmlresource_loaddialog(wxXmlResource * res, wxWindow * parent, BBString * name);
	wxMenuBar * bmx_wxxmlresource_loadmenubar(wxXmlResource * res, wxWindow * parent, BBString * name);
	wxPanel * bmx_wxxmlresource_loadpanel(wxXmlResource * res, wxWindow * parent, BBString * name);
	wxToolBar * bmx_wxxmlresource_loadtoolbar(wxXmlResource * res, wxWindow * parent, BBString * name);
	bool bmx_wxxmlresource_unload(wxXmlResource * res, BBString * filename);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#endif
