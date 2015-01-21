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

#include "wxglue.h"
#include "wx/choicebk.h"
#include "wx/xrc/xh_choicbk.h"
#include "wx/imaglist.h"
#include "wx/xml/xml.h"

class MaxChoicebook;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxchoicebook_wxChoicebook__xrcNew)(wxChoicebook * choice);

	MaxChoicebook * bmx_wxchoicebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	wxChoice * bmx_wxchoicebook_getchoicectrl(wxChoicebook * book);

	void bmx_wxchoicebook_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxChoicebook : public wxChoicebook
{
public:
	MaxChoicebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxChoicebook();
	~ MaxChoicebook();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxChoicebookXmlHandler : public wxChoicebookXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxChoicebookXmlHandler)

public:
    MaxChoicebookXmlHandler();
    virtual wxObject *DoCreateResource();
	virtual bool CanHandle(wxXmlNode *node);
	
    bool m_isInside;
    wxChoicebook *m_choicebook;
};
