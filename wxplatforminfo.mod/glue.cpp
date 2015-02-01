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


int bmx_wxplatforminfo_checkosversion(int major, int minor) {
	return static_cast<int>(wxPlatformInfo::Get().CheckOSVersion(major, minor));
}

int bmx_wxplatforminfo_checktoolkitversion(int major, int minor) {
	return static_cast<int>(wxPlatformInfo::Get().CheckToolkitVersion(major, minor));
}

wxArchitecture bmx_wxplatforminfo_getarch(BBString * arch) {
	return wxPlatformInfo::GetArch(wxStringFromBBString(arch));
}

BBString * bmx_wxplatforminfo_getarchname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetArchName());
}

wxArchitecture bmx_wxplatforminfo_getarchitecture() {
	return wxPlatformInfo::Get().GetArchitecture();
}

wxEndianness bmx_wxplatforminfo_getendianness() {
	return wxPlatformInfo::Get().GetEndianness();
}

BBString * bmx_wxplatforminfo_getendiannessname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetEndiannessName());
}

int bmx_wxplatforminfo_getosmajorversion() {
	return wxPlatformInfo::Get().GetOSMajorVersion();
}

int bmx_wxplatforminfo_getosminorversion() {
	return wxPlatformInfo::Get().GetOSMinorVersion();
}

BBString * bmx_wxplatforminfo_getoperatingsystemfamilyname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetOperatingSystemFamilyName());
}

wxOperatingSystemId bmx_wxplatforminfo_getoperatingsytemid() {
	return wxPlatformInfo::Get().GetOperatingSystemId();
}

BBString * bmx_wxplatforminfo_getoperatingsystemidname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetOperatingSystemIdName());
}

wxPortId bmx_wxplatforminfo_getportid() {
	return wxPlatformInfo::Get().GetPortId();
}

BBString * bmx_wxplatforminfo_getportidname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetPortIdName());
}

BBString * bmx_wxplatforminfo_getportidshortname() {
	return bbStringFromWxString(wxPlatformInfo::Get().GetPortIdShortName());
}

int bmx_wxplatforminfo_gettoolkitmajorversion() {
	return wxPlatformInfo::Get().GetToolkitMajorVersion();
}

int bmx_wxplatforminfo_gettoolkitminorversion() {
	return wxPlatformInfo::Get().GetToolkitMinorVersion();
}

