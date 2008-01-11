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
	
	Function CreateFileName:wxFileName(path:String = "", name:String = "", format:Int = wxPATH_NATIVE)
	End Function
	
	Method Create:wxFileName(path:String = "", name:String = "", format:Int = wxPATH_NATIVE)
	End Method
	
	Method AppendDir(dir:String)
	End Method
	
	Method AssignCwd(volume:String = "")
	End Method
	
	Method AssignDir(dir:String, format:Int = wxPATH_NATIVE)
	End Method
	
	Method AssignHomeDir()
	End Method
	
	Method Clear()
	End Method
	
	Method SetClearExt()
	End Method
	
	Function DirExists:Int(dir:String)
	End Function
	
	Function DirName:wxFileName(dir:String, format:Int = wxPATH_NATIVE)
	End Function
	
	Method FileExists:Int()
	End Method
	
	Function FFileExists:Int(filename:String)
	End Function
	
	Function FileName:wxFileName(file:String, format:Int = wxPATH_NATIVE)
	End Function
	
	Function GetCwd:String(volume:String = "")
	End Function
	
	Method GetDirCount:Int()
	End Method
	
	Method GetDirs:String[]()
	End Method
	
	Method GetExt:String()
	End Method
	
	Function GetForbiddenChars:String(format:Int = wxPATH_NATIVE)
	End Function
	
	Function GetFormat:Int(format:Int = wxPATH_NATIVE)
	End Function
	
	Method GetFullName:String()
	End Method
	
	Method GetFullPath:String(format:Int = wxPATH_NATIVE)
	End Method
	
	Function GetHomeDir:String()
	End Function
	
	Method GetLongPath:String()
	End Method
	
	Method GetModificationTime:Int()
	End Method
	
	Method GetName:String()
	End Method
	
	Method GetPath:String(flags:Int = wxPATH_GET_VOLUME, format:Int = wxPATH_NATIVE)
	End Method
	
	Function GetPathSeparator:String(format:Int = wxPATH_NATIVE)
	End Function 
	
	Function GetPathSeparators:String(format:Int = wxPATH_NATIVE)
	End Function 
	
	Function GetPathTerminators:String(format:Int = wxPATH_NATIVE)
	End Function
	
	Method GetPathWithSep:String(format:Int = wxPATH_NATIVE)
	End Method
	
	Method GetShortPath:String()
	End Method
	
	Method GetSize:Long()
	End Method
	
	Function FGetSize:Long(filename:String)
	End Function
	
	Method GetHumanReadableSize:String(failmsg:String = "Not available", precision:Int = 1)
	End Method
	
	Function FGetHumanReadableSize:String(size:Long, failmsg:String = "Not available", precision:Int = 1)
	End Function 
	
	Function GetTempDir:String()
	End Function
	
	Method GetVolume:String()
	End Method
	
	Function GetVolumeSeparator:String(format:Int = wxPATH_NATIVE)
	End Function
	
	Method HasExt:Int()
	End Method
	
	Method HasName:Int()
	End Method
	
	Method HasVolume:Int()
	End Method
	
	Method InsertDir(before:Int, dir:String)
	End Method
	
	Method IsAbsolute:Int(format:Int = wxPATH_NATIVE)
	End Method
	
	Function IsCaseSensitive:Int(format:Int = wxPATH_NATIVE)
	End Function
	
	Method IsDirReadable:Int()
	End Method
	
	Function FIsDirReadable:Int(dir:String)
	End Function
	
	Method IsDirWritable:Int()
	End Method
	
	Function FIsDirWritable:Int(dir:String)
	End Function
	
	Method IsFileExecutable:Int()
	End Method
	
	Function FIsFileExecutable:Int(file:String)
	End Function
	
	Method IsFileReadable:Int()
	End Method
	
	Function FIsFileReadable:Int(file:String)
	End Function
	
	Method IsFileWritable:Int()
	End Method
	
	Function FIsFileWritable:Int(file:String)
	End Function
	
	Method IsOk:Int()
	End Method
	
	Function IsPathSeparator:Int(char:String, format:Int = wxPATH_NATIVE)
	End Function
	
	Method IsRelative:Int(format:Int = wxPATH_NATIVE)
	End Method
	
	Method IsDir:Int()
	End Method
	
?macos
	Function MacFindDefaultTypeAndCreator:Int(ext:String, ftype:Int Var, creator:Int Var)
	End Function
	
	Function MacRegisterDefaultTypeAndCreator(ext:String, ftype:Int, creator:Int)
	End Function
	
	Method MacSetDefaultTypeAndCreator:Int()
	End Method
?

	Method MakeAbsolute:Int(cwd:String = "", format:Int = wxPATH_NATIVE)
	End Method
	
	Method MakeRelativeTo:Int(pathBase:String = "", format:Int = wxPATH_NATIVE)
	End Method
	
	Method Mkdir:Int(perm:Int = 511, flags:Int = 0)
	End Method
	
	Function FMkdir:Int(dir:String, perm:Int = 511, flags:Int = 0)
	End Function
	
	Method Normalize:Int(flags:Int = wxPATH_NORM_ALL, cwd:String = "", format:Int = wxPATH_NATIVE)
	End Method
	
	Method PrependDir(dir:String)
	End Method
	
	Method RemoveDir(pos:Int)
	End Method
	
	Method RemoveLastDir()
	End Method
	
	Method Rmdir:Int()
	End Method
	
	Function FRmdir:Int(dir:String)
	End Function
	
	Method SameAs:Int(filename:wxFileName, format:Int = wxPATH_NATIVE)
	End Method
	
	Method SetCwd:Int()
	End Method
	
	Function FSetCwd:Int(dir:String)
	End Function
	
	Method SetExt(ext:String)
	End Method
	
	Method SetEmptyExt()
	End Method
	
	Method SetFullName(name:String)
	End Method
	
	Method SetName(name:String)
	End Method
	
	Method SetVolume(volume:String)
	End Method
	
	Method Touch:Int()
	End Method

End Type
