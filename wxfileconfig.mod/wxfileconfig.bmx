' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxFileConfig
End Rem
Module wx.wxFileConfig

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxFileConfig implements wxConfigBase interface for storing and retrieving configuration information using plain text files.
about: The files have a simple format reminiscent of Windows INI files with lines of the form
key = value defining the keys and lines of special form [group] indicating the start of each group.
<p>
This type is used by default for wxConfig on Unix platforms but may also be used explicitly if
you want to use files and not the registry even under Windows.
</p>
End Rem
Type wxFileConfig Extends wxConfigBase

	Rem
	bbdoc: Creates a new wxFileConfig.
	about: Parameters:
	<ul>
	<li><b>appName</b> : The application name. If this is empty, the ype will normally use wxApp::GetAppName
	to set it. The application name can be used to deduce the local filename parameter if that is missing.</li>
	<li><b>vendorName</b> : The vendor name. If this is empty, it is assumed that no vendor name
	is wanted, if this is optional for the current config class.</li>
	<li><b>localFilename</b> : Some config classes require a local filename. If this is not present, but required, the application name will be used instead.</li>
	<li><b>globalFilename</b> : Some config classes require a global filename. If this is not present, but required, the application name will be used instead.</li>
	<li><b>style</b> : Can be one of wxCONFIG_USE_LOCAL_FILE and wxCONFIG_USE_GLOBAL_FILE. The style
	interpretation depends on the config class and is ignored by some implementations. These styles
	determine whether a local or global config file is created or used: if wxCONFIG_USE_GLOBAL_FILE is used,
	then settings are read from the global config file and if wxCONFIG_USE_LOCAL_FILE is used, settings are
	read from and written to local config file (if they are both set, global file is read first, then local
	file, overwriting global settings). If the flag is present but the parameter is empty, the parameter
	will be set to a default. If the parameter is present but the style flag not, the relevant flag will be
	added to the style.<br>
	You can also add wxCONFIG_USE_RELATIVE_PATH by logically or'ing it to either of the _FILE options to tell
	wxFileConfig to use relative instead of absolute paths.<br>
	On Unix systems, the default local configuration file is ~/.appname. However, this path may be also used
	as user data directory (see wxStandardPaths::GetUserDataDir) if the application has several data files. In
	this case wxCONFIG_USE_SUBDIR flag, which changes the default local configuration file to ~/.appname/appname
	should be used. Notice that this flag is ignored on non-Unix system, or if a non-default localFilename is
	provided.<br>
	You can also add wxCONFIG_USE_NO_ESCAPE_CHARACTERS which will turn off character escaping for the values of
	entries stored in the config file: for example a foo key with some backslash characters will be stored as
	foo=C:\mydir instead of the usual storage of foo=C:\\mydir.<br>
	The wxCONFIG_USE_NO_ESCAPE_CHARACTERS style can be helpful if your config file must be read or written to by
	a non-wxWidgets program (which might not understand the escape characters). Note, however, that if
	wxCONFIG_USE_NO_ESCAPE_CHARACTERS style is used, it is is now your application's responsibility to ensure that
	there is no newline or other illegal characters in a value, before writing that value to the file.</li>
	</ul>
	End Rem
	Function CreateFileConfig:wxFileConfig(appName:String = "", vendorName:String = "", ..
			localFilename:String = "", globalFilename:String = "", style:Int = 0)
		Return New wxFileConfig.Create(appName, vendorName, localFilename, globalFilename, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxFileConfig.
	about: Parameters:
	<ul>
	<li><b>appName</b> : The application name. If this is empty, the ype will normally use wxApp::GetAppName
	to set it. The application name can be used to deduce the local filename parameter if that is missing.</li>
	<li><b>vendorName</b> : The vendor name. If this is empty, it is assumed that no vendor name
	is wanted, if this is optional for the current config class.</li>
	<li><b>localFilename</b> : Some config classes require a local filename. If this is not present, but required, the application name will be used instead.</li>
	<li><b>globalFilename</b> : Some config classes require a global filename. If this is not present, but required, the application name will be used instead.</li>
	<li><b>style</b> : Can be one of wxCONFIG_USE_LOCAL_FILE and wxCONFIG_USE_GLOBAL_FILE. The style
	interpretation depends on the config class and is ignored by some implementations. These styles
	determine whether a local or global config file is created or used: if wxCONFIG_USE_GLOBAL_FILE is used,
	then settings are read from the global config file and if wxCONFIG_USE_LOCAL_FILE is used, settings are
	read from and written to local config file (if they are both set, global file is read first, then local
	file, overwriting global settings). If the flag is present but the parameter is empty, the parameter
	will be set to a default. If the parameter is present but the style flag not, the relevant flag will be
	added to the style.<br>
	You can also add wxCONFIG_USE_RELATIVE_PATH by logically or'ing it to either of the _FILE options to tell
	wxFileConfig to use relative instead of absolute paths.<br>
	On Unix systems, the default local configuration file is ~/.appname. However, this path may be also used
	as user data directory (see wxStandardPaths::GetUserDataDir) if the application has several data files. In
	this case wxCONFIG_USE_SUBDIR flag, which changes the default local configuration file to ~/.appname/appname
	should be used. Notice that this flag is ignored on non-Unix system, or if a non-default localFilename is
	provided.<br>
	You can also add wxCONFIG_USE_NO_ESCAPE_CHARACTERS which will turn off character escaping for the values of
	entries stored in the config file: for example a foo key with some backslash characters will be stored as
	foo=C:\mydir instead of the usual storage of foo=C:\\mydir.<br>
	The wxCONFIG_USE_NO_ESCAPE_CHARACTERS style can be helpful if your config file must be read or written to by
	a non-wxWidgets program (which might not understand the escape characters). Note, however, that if
	wxCONFIG_USE_NO_ESCAPE_CHARACTERS style is used, it is is now your application's responsibility to ensure that
	there is no newline or other illegal characters in a value, before writing that value to the file.</li>
	</ul>
	End Rem
	Method Create:wxFileConfig(appName:String = "", vendorName:String = "", ..
			localFilename:String = "", globalFilename:String = "", style:Int = 0)
		wxObjectPtr = bmx_wxfileconfig_create(appName, vendorName, localFilename, globalFilename, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Allows to set the mode to be used for the config file creation.
	about: For example, to create a config file which is not readable by other users (useful if
	it stores some sensitive information, such as passwords), you could use SetUmask(0077).
	<p>
	This method doesn't do anything on non-Unix platforms.
	</p>
	End Rem
	Method SetUmask(mode:Int)
		bmx_wxfileconfig_setumask(wxObjectPtr, mode)
	End Method
	
End Type
