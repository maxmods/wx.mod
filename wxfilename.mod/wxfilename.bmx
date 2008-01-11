' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxFileName
End Rem
Module wx.wxFileName

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxFileName encapsulates a file name.
about: This type serves two purposes: first, it provides the functions to split the file names into components and to
recombine these components in the full file name which can then be passed to the OS file functions (and wxWidgets
functions wrapping them). Second, it includes the functions for working with the files itself. Note that to change the
file data you should use wxFile class instead. wxFileName provides methods for working with the file attributes.
<p>
When working with directory names (i.e. without filename and extension) make sure not to misuse the file name part
of this class with the last directory. Instead initialize the wxFileName instance like this:
<pre>
Local dirname:wxFileName = new wxFileName.Create( "C:\mydir", "")
MyMethod( dirname.GetPath() )
</pre>
</p>
<p>
The same can be done using the static method wxFileName::DirName:
<pre>
Local dirname:wxFileName = wxFileName.DirName( "C:\mydir" )
MyMethod( dirname.GetPath() )
</pre>
</p>
<p>
Accordingly, methods dealing with directories or directory names like IsDirReadable use GetPath whereas methods dealing
with file names like IsFileReadable use GetFullPath.
</p>
<p>
If it is not known wether a string contains a directory name or a complete file name (such as when interpreting user
input) you need to use the static function wxFileName::DirExists and construct the wxFileName instance accordingly.
This will only work if the directory actually exists, of course:
Local user_input:String
' get input from user

Local fname:wxFileName = new wxFileName.Create()
If wxDirExists(user_input) Then
    fname.AssignDir( user_input )
Else
    fname.Assign( user_input )
End if
</pre>
End Rem
Type wxFileName

	Field wxObjectPtr:Byte Ptr

	Function _create:wxFileName(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFileName = New wxFileName
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateFileName:wxFileName(path:String = "", name:String = "", format:Int = wxPATH_NATIVE)
		Return New wxFileName.Create(path, name, format)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxFileName(path:String = "", name:String = "", format:Int = wxPATH_NATIVE)
		wxObjectPtr = bmx_wxfilename_create(path, name, format)
		Return Self
	End Method
	
	Rem
	bbdoc: Appends a directory component to the path.
	about: This component should contain a single directory name level, i.e. not contain any
	path or volume separators nor should it be empty, otherwise the method does nothing.
	End Rem
	Method AppendDir(dir:String)
		bmx_wxfilename_appenddir(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Makes this object refer to the current working directory on the specified volume (or current volume if volume is empty).
	End Rem
	Method AssignCwd(volume:String = "")
		bmx_wxfilename_assigncwd(wxObjectPtr, volume)
	End Method
	
	Rem
	bbdoc: Sets this file name object to the given directory name.
	about: The name and extension will be empty.
	End Rem
	Method AssignDir(dir:String, format:Int = wxPATH_NATIVE)
		bmx_wxfilename_assigndir(wxObjectPtr, dir, format)
	End Method
	
	Rem
	bbdoc: Sets this file name object to the home directory.
	End Rem
	Method AssignHomeDir()
		bmx_wxfilename_assignhomedir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Reset all components to default, uninitialized state.
	End Rem
	Method Clear()
		bmx_wxfilename_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the extension from the file name resulting in a file name with no trailing dot.
	End Rem
	Method ClearExt()
		bmx_wxfilename_clearext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the directory with this name exists.
	End Rem
	Function DirExists:Int(dir:String)
		Return bmx_wxfilename_direxists(dir)
	End Function
	
	Rem
	bbdoc: Returns the object corresponding to the directory with the given name.
	about: The @dir parameter may have trailing path separator or not.
	End Rem
	Function DirName:wxFileName(dir:String, format:Int = wxPATH_NATIVE)
		Return wxFileName._create(bmx_wxfilename_dirname(dir, format))
	End Function
	
	Rem
	bbdoc: Returns true if the file exists.
	End Rem
	Method FileExists:Int()
		Return bmx_wxfilename_fileexists(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the file with this name exists.
	End Rem
	Function FFileExists:Int(filename:String)
		Return bmx_wxfilename_ffileexists(filename)
	End Function
	
	Rem
	bbdoc: Returns the file name object corresponding to the given file.
	about: This function exists mainly for symmetry with DirName.
	End Rem
	Function FileName:wxFileName(file:String, format:Int = wxPATH_NATIVE)
		Return wxFileName._create(bmx_wxfilename_filename(file, format))
	End Function
	
	Rem
	bbdoc: Retrieves the value of the current working directory on the specified volume.
	about: If the volume is empty, the program's current working directory is returned for
	the current volume.
	End Rem
	Function GetCwd:String(volume:String = "")
		Return bmx_wxfilename_getcwd(volume)
	End Function
	
	Rem
	bbdoc: Returns the number of directories in the file name.
	End Rem
	Method GetDirCount:Int()
		Return bmx_wxfilename_getdircount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the directories in string array form.
	End Rem
	Method GetDirs:String[]()
		Return bmx_wxfilename_getdirs(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the file name extension.
	End Rem
	Method GetExt:String()
		Return bmx_wxfilename_getext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the characters that can't be used in filenames and directory names for the specified format.
	End Rem
	Function GetForbiddenChars:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getforbiddenchars(format)
	End Function
	
	Rem
	bbdoc: Returns the canonical path format for this platform.
	End Rem
	Function GetFormat:Int(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getformat(format)
	End Function
	
	Rem
	bbdoc: Returns the full name (including extension but excluding directories).
	End Rem
	Method GetFullName:String()
		Return bmx_wxfilename_getfullname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the full path with name and extension.
	End Rem
	Method GetFullPath:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getfullpath(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Returns the home directory.
	End Rem
	Function GetHomeDir:String()
		Return bmx_wxfilename_gethomedir()
	End Function
	
	Rem
	bbdoc: Return the long form of the path (returns identity on non-Windows platforms)
	End Rem
	Method GetLongPath:String()
		Return bmx_wxfilename_getlongpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the last time the file was last modified, as number of seconds since Epoch (1 Jan 1970)
	End Rem
	Method GetModificationTime:Int()
		Return bmx_wxfilename_getmodificationtime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the name part of the filename (without extension).
	End Rem
	Method GetName:String()
		Return bmx_wxfilename_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the path part of the filename (without the name or extension).
	End Rem
	Method GetPath:String(flags:Int = wxPATH_GET_VOLUME, format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getpath(wxObjectPtr, flags, format)
	End Method
	
	Rem
	bbdoc: Returns the usually used path separator for this format.
	about: For all formats but wxPATH_DOS there is only one path separator anyhow, but for
	DOS there are two of them and the native one, i.e. the backslash is returned by this
	method.
	End Rem
	Function GetPathSeparator:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getpathseparator(format)
	End Function 
	
	Rem
	bbdoc: Returns the string containing all the path separators for this format.
	about: For all formats but wxPATH_DOS this string contains only one character but for
	DOS and Windows both '/' and '\' may be used as separators.
	End Rem
	Function GetPathSeparators:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getpathseparators(format)
	End Function 
	
	Rem
	bbdoc: Returns the string of characters which may terminate the path part.
	about: This is the same as GetPathSeparators except for VMS path format where ] is used
	at the end of the path part.
	End Rem
	Function GetPathTerminators:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getpathterminators(format)
	End Function
	
	Rem
	bbdoc: Returns the path with the trailing separator, useful for appending the name to the given path.
	about: This is the same as calling <tt>GetPath (wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR, format)<tt>.
	End Rem
	Method GetPathWithSep:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getpathwithsep(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Return the short form of the path (returns identity on non-Windows platforms).
	End Rem
	Method GetShortPath:String()
		Return bmx_wxfilename_getshortpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the size of this file.
	about: If the file does not exist or its size could not be read (because e.g. the file
	is locked by another process) the returned value is wxInvalidSize.
	End Rem
	Method GetSize:Long()
		Local size:Long
		bmx_wxfilename_getsize(wxObjectPtr, Varptr size)
		Return size
	End Method
	
	Rem
	bbdoc: Returns the size of the given file.
	about: If the file does not exist or its size could not be read (because e.g. the file
	is locked by another process) the returned value is wxInvalidSize.
	End Rem
	Function FGetSize:Long(filename:String)
		Local size:Long
		bmx_wxfilename_fgetsize(filename, Varptr size)
		Return size
	End Function
	
	Rem
	bbdoc: Returns the size of this file in a human-readable form.
	about: If the size could not be retrieved the failmsg string is returned.
	<p>
	In case of success, the returned string is a floating-point number with precision decimal
	digits followed by the size unit (B, kB, MB, GB, TB: respectively bytes, kilobytes,
	megabytes, gigabytes, terabytes).
	</p>
	End Rem
	Method GetHumanReadableSize:String(failmsg:String = "Not available", precision:Int = 1)
		Return bmx_wxfilename_gethumanreadablesize(wxObjectPtr, failmsg, precision)
	End Method
	
	Rem
	bbdoc: Returns the size of the given number of bytes in a human-readable form.
	about:  If bytes is wxInvalidSize or zero, then nullsize is returned.
	<p>
	In case of success, the returned string is a floating-point number with precision decimal
	digits followed by the size unit (B, kB, MB, GB, TB: respectively bytes, kilobytes,
	megabytes, gigabytes, terabytes).
	</p>
	End Rem
	Function FGetHumanReadableSize:String(size:Long, failmsg:String = "Not available", precision:Int = 1)
		Return bmx_wxfilename_fgethumanreadablesize(size, failmsg, precision)
	End Function 
	
	Rem
	bbdoc: Returns the directory used for temporary files.
	End Rem
	Function GetTempDir:String()
		Return bmx_wxfilename_gettempdir()
	End Function
	
	Rem
	bbdoc: Returns the string containing the volume for this file name, empty if it doesn't have one or if the file system doesn't support volumes at all (for example, Unix).
	End Rem
	Method GetVolume:String()
		Return bmx_wxfilename_getvolume(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string separating the volume from the path for this format.
	End Rem
	Function GetVolumeSeparator:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_getvolumeseparator(format)
	End Function
	
	Rem
	bbdoc: Returns true if an extension is present.
	End Rem
	Method HasExt:Int()
		Return bmx_wxfilename_hasext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a name is present.
	End Rem
	Method HasName:Int()
		Return bmx_wxfilename_hasname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a volume specifier is present.
	End Rem
	Method HasVolume:Int()
		Return bmx_wxfilename_hasvolume(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inserts a directory component before the zero-based position in the directory list.
	about: Please see AppendDir for important notes.
	End Rem
	Method InsertDir(before:Int, dir:String)
		bmx_wxfilename_insertdir(wxObjectPtr, before, dir)
	End Method
	
	Rem
	bbdoc: Returns true if this filename is absolute.
	End Rem
	Method IsAbsolute:Int(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_isabsolute(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Returns true if the file names of this type are case-sensitive.
	End Rem
	Function IsCaseSensitive:Int(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_iscasesensitive(format)
	End Function
	
	Rem
	bbdoc: Returns true if the directory component of this instance is an existing directory and this process has read permissions on it.
	about: Read permissions on a directory mean that you can list the directory contents but
	it doesn't imply that you have read permissions on the files contained.
	End Rem
	Method IsDirReadable:Int()
		Return bmx_wxfilename_isdirreadable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the directory component of @dir is an existing directory and this process has read permissions on it.
	about: Read permissions on a directory mean that you can list the directory contents but
	it doesn't imply that you have read permissions on the files contained.
	End Rem
	Function FIsDirReadable:Int(dir:String)
		Return bmx_wxfilename_fisdirreadable(dir)
	End Function
	
	Rem
	bbdoc: Returns true if the directory component of this instance is an existing directory and this process has write permissions on it.
	about: Write permissions on a directory mean that you can create new files in the directory.
	End Rem
	Method IsDirWritable:Int()
		Return bmx_wxfilename_isdirwritable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the directory component of @dir is an existing directory and this process has write permissions on it.
	about: Write permissions on a directory mean that you can create new files in the directory.
	End Rem
	Function FIsDirWritable:Int(dir:String)
		Return bmx_wxfilename_fisdirwritable(dir)
	End Function
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has execute permissions on it.
	End Rem
	Method IsFileExecutable:Int()
		Return bmx_wxfilename_isfileexecutable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has execute permissions on it.
	End Rem
	Function FIsFileExecutable:Int(file:String)
		Return bmx_wxfilename_fisfileexecutable(file)
	End Function
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has read permissions on it.
	End Rem
	Method IsFileReadable:Int()
		Return bmx_wxfilename_isfilereadable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has read permissions on it.
	End Rem
	Function FIsFileReadable:Int(file:String)
		Return bmx_wxfilename_fisfilereadable(file)
	End Function
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has write permissions on it.
	End Rem
	Method IsFileWritable:Int()
		Return bmx_wxfilename_isfilewritable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if a file with this name exists and if this process has write permissions on it.
	End Rem
	Function FIsFileWritable:Int(file:String)
		Return bmx_wxfilename_fisfilewritable(file)
	End Function
	
	Rem
	bbdoc: Returns true if the filename is valid, false if it is not initialized yet.
	about: The assignment functions and Clear may reset the object to the uninitialized,
	invalid state (the former only do it on failure).
	End Rem
	Method IsOk:Int()
		Return bmx_wxfilename_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the char is a path separator for this format.
	End Rem
	Function IsPathSeparator:Int(char:String, format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_ispathseparator(char, format)
	End Function
	
	Rem
	bbdoc: Returns true if this filename is not absolute.
	End Rem
	Method IsRelative:Int(format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_isrelative(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Returns true if this object represents a directory, false otherwise (i.e. if it is a file).
	about: Note that this method doesn't test whether the directory or file really exists,
	you should use DirExists or FileExists for this.
	End Rem
	Method IsDir:Int()
		Return bmx_wxfilename_isdir(wxObjectPtr)
	End Method
	
?macos
	Rem
	bbdoc: On Mac OS, gets the common type and creator for the given extension.
	End Rem
	Function MacFindDefaultTypeAndCreator:Int(ext:String, ftype:Int Var, creator:Int Var)
		Return bmx_wxfilename_macfinddefaulttypeandcreator(ext, Varptr ftype, Varptr creator)
	End Function
	
	Rem
	bbdoc: On Mac OS, registers application defined extensions and their default type and creator.
	End Rem
	Function MacRegisterDefaultTypeAndCreator(ext:String, ftype:Int, creator:Int)
		bmx_wxfilename_macregisterdefaulttypeandcreator(ext, ftype, creator)
	End Function
	
	Rem
	bbdoc: On Mac OS, looks up the appropriate type and creator from the registration and then sets it.
	End Rem
	Method MacSetDefaultTypeAndCreator:Int()
		Return bmx_wxfilename_macsetdefaulttypeandcreator(wxObjectPtr)
	End Method
?

	Rem
	bbdoc: Make the file name absolute.
	about: This is a shortcut for <tt>Normalize(wxPATH_NORM_DOTS | wxPATH_NORM_ABSOLUTE | wxPATH_NORM_TILDE, cwd, format)</tt>.
	End Rem
	Method MakeAbsolute:Int(cwd:String = "", format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_makeabsolute(wxObjectPtr, cwd, format)
	End Method
	
	Rem
	bbdoc: This method tries to put this file name in a form relative to pathBase.
	returns: True if the file name has been changed, False if we failed to do anything with it (currently this only happens if the file name is on a volume different from the volume specified by pathBase).
	about: In other words, it returns the file name which should be used to access this
	file if the current directory were pathBase.
	End Rem
	Method MakeRelativeTo:Int(pathBase:String = "", format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_makerelativeto(wxObjectPtr, pathBase, format)
	End Method
	
	Rem
	bbdoc: Creates a directory.
	returns: True if the directory was successfully created, false otherwise.
	End Rem
	Method Mkdir:Int(perm:Int = 511, flags:Int = 0)
		Return bmx_wxfilename_mkdir(wxObjectPtr, perm, flags)
	End Method
	
	Rem
	bbdoc: Creates a directory.
	returns: True if the directory was successfully created, false otherwise.
	End Rem
	Function FMkdir:Int(dir:String, perm:Int = 511, flags:Int = 0)
		Return bmx_wxfilename_fmkdir(dir, perm, flags)
	End Function
	
	Rem
	bbdoc: Normalize the path.
	about: With the default flags value, the path will be made absolute, without any ".."
	and "." and all environment variables will be expanded in it.
	End Rem
	Method Normalize:Int(flags:Int = wxPATH_NORM_ALL, cwd:String = "", format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_normalize(wxObjectPtr, flags, cwd, format)
	End Method
	
	Rem
	bbdoc: Prepends a directory to the file path.
	about: Please see AppendDir for important notes.
	End Rem
	Method PrependDir(dir:String)
		bmx_wxfilename_prependdir(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Removes the specified directory component from the path.
	End Rem
	Method RemoveDir(pos:Int)
		bmx_wxfilename_removedir(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Removes last directory component from the path.
	End Rem
	Method RemoveLastDir()
		bmx_wxfilename_removelastdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes the specified directory from the file system.
	End Rem
	Method Rmdir:Int()
		Return bmx_wxfilename_rmdir(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes the specified directory from the file system.
	End Rem
	Function FRmdir:Int(dir:String)
		Return bmx_wxfilename_frmdir(dir)
	End Function
	
	Rem
	bbdoc: Compares the filename using the rules of this platform.
	End Rem
	Method SameAs:Int(filename:wxFileName, format:Int = wxPATH_NATIVE)
		Return bmx_wxfilename_sameas(wxObjectPtr, filename.wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Changes the current working directory.
	End Rem
	Method SetCwd:Int()
		Return bmx_wxfilename_setcwd(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Changes the current working directory.
	End Rem
	Function FSetCwd:Int(dir:String)
		Return bmx_wxfilename_fsetcwd(dir)
	End Function
	
	Rem
	bbdoc: Sets the extension of the file name.
	about: Setting an empty string as the extension will remove the extension resulting in
	a file name without a trailing dot, unlike a call to SetEmptyExt.
	End Rem
	Method SetExt(ext:String)
		bmx_wxfilename_setext(wxObjectPtr, ext)
	End Method
	
	Rem
	bbdoc: Sets the extension of the file name to be an empty extension.
	about: This is different from having no extension at all as the file name will have a
	trailing dot after a call to this method.
	End Rem
	Method SetEmptyExt()
		bmx_wxfilename_setemptyext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: The full name is the file name and extension (but without the path).
	End Rem
	Method SetFullName(name:String)
		bmx_wxfilename_setfullname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the name part (without extension).
	End Rem
	Method SetName(name:String)
		bmx_wxfilename_setname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the volume specifier.
	End Rem
	Method SetVolume(volume:String)
		bmx_wxfilename_setvolume(wxObjectPtr, volume)
	End Method
	
	Rem
	bbdoc: Sets the access and modification times to the current moment.
	End Rem
	Method Touch:Int()
		Return bmx_wxfilename_touch(wxObjectPtr)
	End Method

	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxfilename_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type
