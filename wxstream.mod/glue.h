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

class MaxInputStream;

extern "C" {

#include <blitz.h>

	bool _wx_wxstream_wxMaxInputStream__eof(BBObject * handle);
	MaxInputStream * _wx_wxstream_wxMaxInputStream__read(BBObject * handle, void *buffer, size_t size);
	size_t _wx_wxstream_wxMaxInputStream__sysread(BBObject * handle, void *buffer, size_t size);
	wxFileOffset _wx_wxstream_wxMaxInputStream__sysseek(BBObject * handle, wxFileOffset seek, wxSeekMode mode);
	wxFileOffset _wx_wxstream_wxMaxInputStream__systell(BBObject * handle);

	MaxInputStream * bmx_wxmaxinputstream_create(BBObject * handle);
	void bmx_wxmaxinputstream_delete(MaxInputStream * handle);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxInputStream : public wxInputStream
{
public:
	MaxInputStream(BBObject * handle);
	~MaxInputStream();
	
//	bool Eof() const;
//	wxInputStream& Read(void *buffer, size_t size);

protected:
    virtual size_t OnSysRead(void *buffer, size_t bufsize);
    virtual wxFileOffset OnSysSeek(wxFileOffset seek, wxSeekMode mode);
    virtual wxFileOffset OnSysTell() const;
	
private:
	BBObject * maxHandle;

};
