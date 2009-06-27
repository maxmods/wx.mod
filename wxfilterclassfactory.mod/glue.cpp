/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

const wxFilterClassFactory * bmx_wxfilterclassfactory_find(BBString * protocol, wxStreamProtocolType protocolType) {
	return wxFilterClassFactory::Find(wxStringFromBBString(protocol), protocolType);
}

int bmx_wxfilterclassfactory_canhandle(wxFilterClassFactory * factory, BBString * protocol, wxStreamProtocolType protocolType) {
	return static_cast<int>(factory->CanHandle(wxStringFromBBString(protocol), protocolType));
}

BBString * bmx_wxfilterclassfactory_getprotocol(wxFilterClassFactory * factory) {
	return bbStringFromWxString(factory->GetProtocol());
}

wxFilterInputStream * bmx_wxfilterclassfactory_newinputstream(wxFilterClassFactory * factory, wxInputStream * stream) {
	return factory->NewStream(stream);
}

BBString * bmx_wxfilterclassfactory_popextension(wxFilterClassFactory * factory, BBString * location) {
	return bbStringFromWxString(factory->PopExtension(wxStringFromBBString(location)));
}

void bmx_wxfilterclassfactory_pushfront(wxFilterClassFactory * factory) {
	factory->PushFront();
}

void bmx_wxfilterclassfactory_remove(wxFilterClassFactory * factory) {
	factory->Remove();
}


