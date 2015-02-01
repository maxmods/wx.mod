/*
  Copyright (c) 2007-2015 Bruce A Henderson
 
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

BBString * bmx_wxsystemtoptions_getoption(BBString * name) {
	return bbStringFromWxString(wxSystemOptions::GetOption(wxStringFromBBString(name)));
}

int bmx_wxsystemtoptions_getoptionint(BBString * name) {
	return wxSystemOptions::GetOptionInt(wxStringFromBBString(name));
}

int bmx_wxsystemtoptions_hasoption(BBString * name) {
	return static_cast<int>(wxSystemOptions::HasOption(wxStringFromBBString(name)));
}

int bmx_wxsystemtoptions_isfalse(BBString * name) {
	return static_cast<int>(wxSystemOptions::IsFalse(wxStringFromBBString(name)));
}

void bmx_wxsystemtoptions_setoptionstring(BBString * name, BBString * option) {
	wxSystemOptions::SetOption(wxStringFromBBString(name), wxStringFromBBString(option));
}

void bmx_wxsystemtoptions_setoption(BBString * name, int option) {
	wxSystemOptions::SetOption(wxStringFromBBString(name), option);
}


