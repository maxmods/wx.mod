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



// *********************************************

wxClipboard * bmx_wxclipboard_get() {
	return wxTheClipboard;
}

void bmx_wxclipboard_clear(wxClipboard * clip) {
	clip->Clear();
}

void bmx_wxclipboard_close(wxClipboard * clip) {
	clip->Close();
}

bool bmx_wxclipboard_flush(wxClipboard * clip) {
	return clip->Flush();
}

bool bmx_wxclipboard_open(wxClipboard * clip) {
	return clip->Open();
}

bool bmx_wxclipboard_adddata(wxClipboard * clip, wxDataObject * data) {
	return clip->AddData(data);
}

bool bmx_wxclipboard_getdata(wxClipboard * clip, wxDataObject * data) {
	return clip->GetData(*data);
}

bool bmx_wxclipboard_setdata(wxClipboard * clip, wxDataObject * data) {
	return clip->SetData(data);
}

bool bmx_wxclipboard_isopened(wxClipboard * clip) {
	return clip->IsOpened();
}

#ifdef __WXGTK__
void bmx_wxclipboard_useprimaryselection(wxClipboard * clip, bool primary) {
	clip->UsePrimarySelection(primary); 
}
#endif

