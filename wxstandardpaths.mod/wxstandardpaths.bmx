' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxStandardPaths
End Rem
Module wx.wxStandardPaths

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: wxStandardPaths returns the standard locations in the file system and should be used by applications to find their data files in a portable way.
about: In the description of the methods below, the example return values are given for the Unix, Windows and Mac OS X systems, however please note that these are just the examples and the actual values may differ. For example, under Windows: the system administrator may change the standard directories locations, i.e. the Windows directory may be named W:\Win2003 instead of the default C:\Windows.
<p>
The strings appname and username should be replaced with the value returned by wxApp::GetAppName
and the name of the currently logged in user, respectively. The string prefix is only used under
Unix and is /usr/local by default but may be changed using SetInstallPrefix.
</p>
<p>
The directories returned by the methods of this class may or may not exist. If they don't exist,
it's up to the caller to create them, wxStandardPaths doesn't do it.
</p>
<p>
Finally note that these functions only work with standardly packaged applications. I.e. under
Unix you should follow the standard installation conventions and under Mac you should create your
application bundle according to the Apple guidelines. Again, this class doesn't help you to do it.
</p>
End Rem
Type wxStandardPaths

	Field wxObjectPtr:Byte Ptr

	Function _create:wxStandardPaths(wxObjectPtr:Byte Ptr)
		Local this:wxStandardPaths = New wxStandardPaths
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns reference to the unique global standard paths object.
	End Rem
	Function Get:wxStandardPaths()
		Return wxStandardPaths._create(bmx_wxstandardpaths_get())
	End Function
	
	Rem
	bbdoc: Return the directory containing the system config files.
	about: Example return values: 
	<ul>
	<li>Unix: /etc </li>
	<li>Windows: C:\Documents and Settings\All Users\Application Data </li>
	<li>Mac: /Library/Preferences </li>
	</ul>
	End Rem
	Method GetConfigDir:String()
		Return bmx_wxstandardpaths_getconfigdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the location of the applications global, i.e. not user-specific, data files.
	about: Example return values: 
	<ul>
	<li>Unix: prefix/share/appname </li>
	<li>Windows: the directory where the executable file is located </li>
	<li>Mac: appname.app/Contents/SharedSupport bundle subdirectory </li>
	</ul>
	End Rem
	Method GetDataDir:String()
		Return bmx_wxstandardpaths_getdatadir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory containing the current user's documents.
	about: Example return values: 
	<ul>
	<li>Unix: ~ (the home directory) </li>
	<li>Windows: C:\Documents and Settings\username\Documents </li>
	<li>Mac: ~/Documents </li>
	</ul>
	End Rem
	Method GetDocumentsDir:String()
		Return bmx_wxstandardpaths_getdocumentsdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory and the filename for the current executable.
	about: Example return values: 
	<ul>
	<li>Unix: /usr/local/bin/exename </li>
	<li>Windows: C:\Programs\AppFolder\exename.exe </li>
	<li>Mac: /Programs/exename </li>
	</ul>
	End Rem
	Method GetExecutablePath:String()
		Return bmx_wxstandardpaths_getexecutablepath(wxObjectPtr)
	End Method

?linux	
	Rem
	bbdoc: Return the program installation prefix, e.g. /usr, /opt or /home/zeitlin.
	about: If the prefix had been previously by SetInstallPrefix, returns that value, otherwise
	tries to determine it automatically (Linux only right now) and finally returns the
	default /usr/local value if it failed.
	<p>
	Note: This method is only available under Unix.
	</p>
	End Rem
	Method GetInstallPrefix:String()
		Return bmx_wxstandardpaths_getinstallprefix(wxObjectPtr)
	End Method
?
	
	Rem
	bbdoc: Return the location for application data files which are host-specific and can't, or shouldn't, be shared with the other machines.
	about: This is the same as GetDataDir() except under Unix where it returns /etc/appname.
	End Rem
	Method GetLocalDataDir:String()
		Return bmx_wxstandardpaths_getlocaldatadir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory where the loadable modules (plugins) live.
	about: Example return values: 
	<ul>
	<li>Unix: prefix/lib/appname </li>
	<li>Windows: the directory of the executable file </li>
	<li>Mac: appname.app/Contents/PlugIns bundle subdirectory </li>
	</ul>
	End Rem
	Method GetPluginsDir:String()
		Return bmx_wxstandardpaths_getpluginsdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory where the application resource files are located.
	about: The resources are the auxiliary data files needed for the application to run
	and include, for example, image and sound files it might use.
	<p>
	This method is the same as GetDataDir for all platforms except Mac OS X.
	</p>
	Example return values: 
	<ul>
	<li>Unix: prefix/share/appname </li>
	<li>Windows: the directory where the executable file is located </li>
	<li>Mac: appname.app/Contents/Resources bundle subdirectory </li>
	</ul>
	End Rem
	Method GetResourcesDir:String()
		Return bmx_wxstandardpaths_getresourcesdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory for storing temporary files.
	about: To create unique temporary files, it is best to use wxFileName::CreateTempFileName for correct behaviour when multiple processes
	are attempting to create temporary files.
	End Rem
	Method GetTempDir:String()
		Return bmx_wxstandardpaths_gettempdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory for the user config files: 
	about:
	<ul>
	<li>Unix: ~ (the home directory) </li>
	<li>Windows: C:\Documents and Settings\username\Application Data </li>
	<li>Mac: ~/Library/Preferences </li>
	</ul>
	<p>
	Only use this method if you have a single configuration file to put in this directory,
	otherwise GetUserDataDir() is more appropriate.
	</p>
	End Rem
	Method GetUserConfigDir:String()
		Return bmx_wxstandardpaths_getuserconfigdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory for the user-dependent application data files: 
	<ul>
	<li>Unix: ~/.appname </li>
	<li>Windows: C:\Documents and Settings\username\Application Data\appname </li>
	<li>Mac: ~/Library/Application Support/appname </li>
	</ul>
	End Rem
	Method GetUserDataDir:String()
		Return bmx_wxstandardpaths_getuserdatadir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the directory for user data files which shouldn't be shared with the other machines.
	about: This is the same as GetUserDataDir() for all platforms except Windows where it
	returns C:\Documents and Settings\username\Local Settings\Application Data\appname
	End Rem
	Method GetUserLocalDataDir:String()
		Return bmx_wxstandardpaths_getuserlocaldatadir(wxObjectPtr)
	End Method

?linux
	Rem
	bbdoc: Lets wxStandardPaths know about the real program installation prefix on a Unix system.
	about: By default, the value returned by GetInstallPrefix is used.
	<p>
	Although under Linux systems the program prefix may usually be determined automatically,
	portable programs should call this function. Usually the prefix is set during program
	configuration if using GNU autotools and so it is enough to pass its value defined in
	config.h to this function.
	</p>
	<p>
	Note: This method is only available under Unix.
	</p>
	End Rem
	Method SetInstallPrefix(prefix:String)
		bmx_wxstandardpaths_setinstallprefix(wxObjectPtr, prefix)
	End Method
?

End Type

