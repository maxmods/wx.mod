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

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	bool bmx_wxplatforminfo_checkosversion(int major, int minor);
	bool bmx_wxplatforminfo_checktoolkitversion(int major, int minor);
	wxArchitecture bmx_wxplatforminfo_getarch(BBString * arch);
	BBString * bmx_wxplatforminfo_getarchname();
	wxArchitecture bmx_wxplatforminfo_getarchitecture();
	wxEndianness bmx_wxplatforminfo_getendianness();
	BBString * bmx_wxplatforminfo_getendiannessname();
	int bmx_wxplatforminfo_getosmajorversion();
	int bmx_wxplatforminfo_getosminorversion();
	BBString * bmx_wxplatforminfo_getoperatingsystemfamilyname();
	wxOperatingSystemId bmx_wxplatforminfo_getoperatingsytemid();
	BBString * bmx_wxplatforminfo_getoperatingsystemidname();
	wxPortId bmx_wxplatforminfo_getportid();
	BBString * bmx_wxplatforminfo_getportidname();
	BBString * bmx_wxplatforminfo_getportidshortname();
	int bmx_wxplatforminfo_gettoolkitmajorversion();
	int bmx_wxplatforminfo_gettoolkitminorversion();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

