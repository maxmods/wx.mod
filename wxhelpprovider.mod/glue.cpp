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


void bmx_wxhelpprovider_free(wxHelpProvider * provider) {
	delete provider;
}

wxHelpProvider * bmx_wxhelpprovider_set(wxHelpProvider * helpProvider) {
	return wxHelpProvider::Set(helpProvider);
}

wxHelpProvider * bmx_wxhelpprovider_get() {
	return wxHelpProvider::Get();
}

void bmx_wxhelpprovider_addhelp(wxHelpProvider * provider, wxWindow * window, BBString * text) {
	provider->AddHelp(window, wxStringFromBBString(text));
}

void bmx_wxhelpprovider_addhelpid(wxHelpProvider * provider, wxWindowID windowId, BBString * text) {
	provider->AddHelp(windowId, wxStringFromBBString(text));
}

BBString * bmx_wxhelpprovider_gethelp(wxHelpProvider * provider, wxWindow * window) {
	return bbStringFromWxString(provider->GetHelp(window));
}

void bmx_wxhelpprovider_removehelp(wxHelpProvider * provider, wxWindow * window) {
	provider->RemoveHelp(window);
}

bool bmx_wxhelpprovider_showhelp(wxHelpProvider * provider, wxWindow * window) {
	return provider->ShowHelp(window);
}

bool bmx_wxhelpprovider_showhelpatpoint(wxHelpProvider * provider, wxWindow * window, int x, int y, wxHelpEvent::Origin origin) {
	return provider->ShowHelpAtPoint(window, wxPoint(x, y), origin);
}

// *********************************************

wxSimpleHelpProvider * bmx_wxsimplehelpprovider_create()  {
	return new wxSimpleHelpProvider();
}

