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
#include "wx/print.h"

class MaxPreviewFrame;

extern "C" {

#include <blitz.h>

	void _wx_wxpreviewframe_wxPreviewFrame__CreateControlBar(BBObject * handle);
	void _wx_wxpreviewframe_wxPreviewFrame__CreateCanvas(BBObject * handle);


	wxPreviewFrame * bmx_wxpreviewframe_create(BBObject * handle, wxPrintPreview * preview, wxWindow * parent, BBString * title,
		int x, int y, int w, int h, long style);

	void bmx_wxpreviewframe_createcontrolbar(MaxPreviewFrame * frame);
	void bmx_wxpreviewframe_createcanvas(MaxPreviewFrame * frame);
	void bmx_wxpreviewframe_initialize(wxPreviewFrame * frame);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxPreviewFrame : public wxPreviewFrame
{
public:
    MaxPreviewFrame(BBObject * handle, wxPrintPreview * preview, wxWindow* parent, const wxString& title, int x,
		int y, int w, int h, long style);
	~ MaxPreviewFrame();
	void CreateControlBar();
	void CreateCanvas();
	void CreateControlBarX();
	void CreateCanvasX();
	
private:
	BBObject * maxHandle;
};
