' Copyright (c) 2007-2011 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxPlatformInfo
End Rem
Module wx.wxPlatformInfo

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This type holds informations about the operating system and the toolkit that the application is running under and some basic architecture info of the machine where it's running.
End Rem
Type wxPlatformInfo Extends wxObject

	Rem
	bbdoc: Returns true if the OS version is at least major.minor.
	End Rem
	Function CheckOSVersion:Int(major:Int, minor:Int)
		Return bmx_wxplatforminfo_checkosversion(major, minor)
	End Function
	
	Rem
	bbdoc: Returns true if the toolkit version is at least major.minor.
	End Rem
	Function CheckToolkitVersion:Int(major:Int, minor:Int)
		Return bmx_wxplatforminfo_checktoolkitversion(major, minor)
	End Function
	
	Rem
	bbdoc: Converts the given string to an architecture value or to wxARCH_INVALID if the given string is not a valid architecture string (i.e. does not contain nor 32 nor 64 strings).
	End Rem
	Function GetArch:Int(arch:String)
		Return bmx_wxplatforminfo_getarch(arch)
	End Function
	
	Rem
	bbdoc: Returns the name for the architecture of this platform.
	End Rem
	Function GetArchName:String()
		Return bmx_wxplatforminfo_getarchname()
	End Function
	
	Rem
	bbdoc: Returns the architecture ID of this platform.
	End Rem
	Function GetArchitecture:Int()
		Return bmx_wxplatforminfo_getarchitecture()
	End Function
	
	Rem
	bbdoc: Returns the endianness ID of this platform.
	End Rem
	Function GetEndianness:Int()
		Return bmx_wxplatforminfo_getendianness()
	End Function
	
	Rem
	bbdoc: Returns the name for the endianness of this platform.
	End Rem
	Function GetEndiannessName:String()
		Return bmx_wxplatforminfo_getendiannessname()
	End Function
	
	Rem
	bbdoc: Returns the run-time major version of the OS associated with this platform.
	End Rem
	Function GetOSMajorVersion:Int()
		Return bmx_wxplatforminfo_getosmajorversion()
	End Function
	
	Rem
	bbdoc: Returns the run-time minor version of the OS associated with this platform.
	End Rem
	Function GetOSMinorVersion:Int()
		Return bmx_wxplatforminfo_getosminorversion()
	End Function
	
	Rem
	bbdoc: Returns the operating system family name of the OS associated with this platform.
	End Rem
	Function GetOperatingSystemFamilyName:String()
		Return bmx_wxplatforminfo_getoperatingsystemfamilyname()
	End Function
	
	Rem
	bbdoc: Returns the operating system ID of this platform.
	End Rem
	Function GetOperatingSystemId:Int()
		Return bmx_wxplatforminfo_getoperatingsytemid()
	End Function
	
	Rem
	bbdoc: Returns the operating system name of the OS associated with this platform.
	End Rem
	Function GetOperatingSystemIdName:String()
		Return bmx_wxplatforminfo_getoperatingsystemidname()
	End Function
	
	Rem
	bbdoc: Returns the wxWidgets port ID associated with this platform.
	End Rem
	Function GetPortId:Int()
		Return bmx_wxplatforminfo_getportid()
	End Function
	
	Rem
	bbdoc: Returns the name of the wxWidgets port ID associated with this platform.
	End Rem
	Function GetPortIdName:String()
		Return bmx_wxplatforminfo_getportidname()
	End Function
	
	Rem
	bbdoc: Returns the short name of the wxWidgets port ID associated with this platform.
	End Rem
	Function GetPortIdShortName:String()
		Return bmx_wxplatforminfo_getportidshortname()
	End Function
	
	Rem
	bbdoc: Returns the run-time major version of the toolkit associated with this platform.
	about: Note that if GetPortId returns wxPORT_BASE, then this value is zero; that is, no native toolkit is in use.
	End Rem
	Function GetToolkitMajorVersion:Int()
		Return bmx_wxplatforminfo_gettoolkitmajorversion()
	End Function
	
	Rem
	bbdoc: Returns the run-time minor version of the toolkit associated with this platform.
	about: Note that if GetPortId returns wxPORT_BASE, then this value is zero; that is, no native toolkit is in use.
	End Rem
	Function GetToolkitMinorVersion:Int()
		Return bmx_wxplatforminfo_gettoolkitminorversion()
	End Function

End Type
