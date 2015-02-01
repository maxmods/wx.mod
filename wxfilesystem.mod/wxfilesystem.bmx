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
bbdoc: wxFileSystem
End Rem
Module wx.wxFileSystem

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
bbdoc: This type provides an interface for opening files on different file systems.
about: It can handle absolute and/or local filenames. It uses a system of handlers to provide access to user-defined
virtual file systems.
End Rem
Type wxFileSystem Extends wxObject

	Rem
	bbdoc: Creates a new wxFileSystem instance.
	End Rem
	Function CreateFileSystem:wxFileSystem()
		Return New wxFileSystem.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxFileSystem instance.
	End Rem
	Method Create:wxFileSystem()
		wxObjectPtr = bmx_wxfilesystem_create()
		Return Self
	End Method

	Rem
	bbdoc: Adds new handler into the list of handlers which provide access to virtual FS.
	about: Note that if two handlers for the same protocol are added, the last one added takes precedence.
	End Rem
	Function AddHandler(handler:wxFileSystemHandler)
		bmx_wxfilesystem_addhandler(handler.wxObjectPtr)
	End Function

	Rem
	bbdoc: Returns true if there is a registered handler which can open the given location.
	End Rem
	Function HasHandlerForPath:Int(location:String)
		Return bmx_wxfilesystem_hashandlerforpath(location)
	End Function
	
	Rem
	bbdoc: Sets the current location. location parameter passed to OpenFile is relative to this path.
	about: Caution! Unless @isDir is true the location parameter is not the directory name but the name of the
	file in this directory. All these commands change the path to "dir/subdir/":
	End Rem
	Method ChangePathTo(location:String, isDir:Int = False)
		bmx_wxfilesystem_changepathto(wxObjectPtr, location, isDir)
	End Method
	
	Rem
	bbdoc: Returns actual path (set by ChangePathTo).
	End Rem
	Method GetPath:String()
		Return bmx_wxfilesystem_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Converts filename into URL.
	End Rem
	Function FileNameToURL:String(filename:wxFileName)
		Return bmx_wxfilesystem_filenametourl(filename.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Looks for the file with the given name file in a colon or semi-colon (depending on the current platform) separated list of directories in path.
	about: If the file is found in any directory, returns the full path of the file, otherwise Null.
	End Rem
	Method FindFileInPath:String(path:String, file:String)
		Return bmx_wxfilesystem_findfileinpath(wxObjectPtr, path, file)
	End Method
	
	Rem
	bbdoc: Works like wxFindFirstFile.
	about: Returns name of the first filename (within filesystem's current path) that matches wildcard. @flags may
	be one of wxFILE (only files), wxDIR (only directories) or 0 (both).
	End Rem
	Method FindFirst:String(wildcard:String, flags:Int = 0)
		Return bmx_wxfilesystem_findfirst(wxObjectPtr, wildcard, flags)
	End Method
	
	Rem
	bbdoc: Returns the next filename that matches parameters passed to FindFirst.
	End Rem
	Method FindNext:String()
		Return bmx_wxfilesystem_findnext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Opens the file and returns a wxFSFile object or Null if failed.
	about: It first tries to open the file in relative scope (based on value passed to ChangePathTo() method)
	and then as an absolute path. Note that the user is responsible for Free'ing the returned wxFSFile. 
	End Rem
	Method OpenFile:wxFSFile(location:String, flags:Int = wxFS_READ)
		Return wxFSFile._create(bmx_wxfilesystem_openfile(wxObjectPtr, location, flags))
	End Method
	
	Rem
	bbdoc: Converts URL into a well-formed filename.
	about: The URL must use the file protocol.
	End Rem
	Function URLToFileName:wxFileName(url:String)
		Return wxFileName._create(bmx_wxfilesystem_urltofilename(url))
	End Function
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxfilesystem_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

