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



// *********************************************

wxMemoryFSHandler * bmx_wxmemoryfshandler_new(BBObject * handle) {

	wxMemoryFSHandler * handler = new wxMemoryFSHandler;
	wxbind(handler, handle);
	return handler;

}


void bmx_wxmemoryfshandler_addimagefile(BBString * filename, MaxImage * image, wxBitmapType type) {
	wxMemoryFSHandler::AddFile(wxStringFromBBString(filename), image->Image(), type);
}

void bmx_wxmemoryfshandler_addbitmapfile(BBString * filename, MaxBitmap * bitmap, wxBitmapType type) {
	wxMemoryFSHandler::AddFile(wxStringFromBBString(filename), bitmap->Bitmap(), type);
}

void bmx_wxmemoryfshandler_addfilewithmimetype(BBString * filename, BBString * textData, BBString * mimeType) {
	wxMemoryFSHandler::AddFileWithMimeType(wxStringFromBBString(filename), wxStringFromBBString(textData), wxStringFromBBString(mimeType));
}

void bmx_wxmemoryfshandler_addbinaryfilewithmimetype(BBString * filename, const void * data, int size, BBString * mimeType) {
	wxMemoryFSHandler::AddFileWithMimeType(wxStringFromBBString(filename), data, static_cast<size_t>(size), wxStringFromBBString(mimeType));
}

void bmx_wxmemoryfshandler_removefile(BBString * filename) {
	wxMemoryFSHandler::RemoveFile(wxStringFromBBString(filename));
}


