' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxArchive
End Rem
Module wx.wxArchive

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: An abstract base class which serves as a common interface to archive entry classes such as wxZipEntry.
about: These hold the meta-data (filename, timestamp, etc.), for entries in archive files such as zips and tars.
End Rem
Type wxArchiveEntry Extends wxObject

	Function _create:wxArchiveEntry(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxArchiveEntry = New wxArchiveEntry
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method GetDateTime:wxDateTime()
'		Return bmx_wxarchiveentry_getformat(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInternalFormat:Int()
		Return bmx_wxarchiveentry_getinternalformat(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInternalName:String()
		Return bmx_wxarchiveentry_getinternalname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetName:String(format:Int = wxPATH_NATIVE)
		Return bmx_wxarchiveentry_getname(wxObjectPtr, format)
	End Method
	
	Method SetName(name:String, format:Int = wxPATH_NATIVE)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOffset:Int()
		Return bmx_wxarchiveentry_getoffset(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSize:Int()
		Return bmx_wxarchiveentry_getsize(wxObjectPtr)
	End Method
	
	Method SetSize(size:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsDir:Int()
		Return bmx_wxarchiveentry_isdir(wxObjectPtr)
	End Method
	
	Method SetIsDir(dir:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsReadOnly:Int()
		Return bmx_wxarchiveentry_isreadonly(wxObjectPtr)
	End Method
	
	Method SetIsReadOnly(readOnly:Int = True)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxArchiveInputStream Extends wxFilterInputStream

	Function _create:wxArchiveInputStream(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxArchiveInputStream = New wxArchiveInputStream
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CloseEntry:Int()
		Return bmx_wxarchiveinputstream_closeentry(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextEntry:wxArchiveEntry()
		Return wxArchiveEntry._create(bmx_wxarchiveinputstream_getnextentry(wxStreamPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method OpenEntry:Int(entry:wxArchiveEntry)
		Return bmx_wxarchiveinputstream_openentry(wxStreamPtr, entry.wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxArchiveOutputStream Extends wxFilterOutputStream

	Function _create:wxArchiveOutputStream(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxArchiveOutputStream = New wxArchiveOutputStream
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function

	Method Close:Int()
	End Method
	
	Method CloseEntry:Int()
	End Method
	
	Method CopyArchiveMetaData:Int(stream:wxArchiveInputStream)
	End Method
	
	Method CopyEntry:Int(entry:wxArchiveEntry, stream:wxArchiveInputStream)
	End Method
	
	Method PutNextDirEntry:Int(name:String, dt:wxDateTime = Null)
	End Method
	
	Method PutNextEntry:Int(name:String, dt:wxDateTime = Null)
	End Method
	
End Type
