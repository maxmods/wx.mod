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
bbdoc: wxArchive
End Rem
Module wx.wxArchive

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
bbdoc: An abstract base class which serves as a common interface to archive entry classes such as wxZipEntry.
about: These hold the meta-data (filename, timestamp, etc.), for entries in archive files such as zips and tars.
End Rem
Type wxArchiveEntry Extends wxObject

	Method GetDateTime:wxDateTime()
	End Method
	
	Method GetInternalFormat:Int()
	End Method
	
	Method GetInternalName:String()
	End Method
	
	Method GetName:String(format:Int = wxPATH_NATIVE)
	End Method
	
	Method SetName(name:String, format:Int = wxPATH_NATIVE)
	End Method
	
	Method GetOffset:Int()
	End Method
	
	Method GetSize:Int()
	End Method
	
	Method SetSize(size:Int)
	End Method
	
	Method IsDir:Int()
	End Method
	
	Method SetIsDir(dir:Int = True)
	End Method
	
	Method IsReadOnly:Int()
	End Method
	
	Method SetIsReadOnly(readOnly:Int = True)
	End Method
	
End Type

Type wxArchiveInputStream Extends wxFilterInputStream

	Method CloseEntry:Int()
	End Method
	
	Method GetNextEntry:wxArchiveEntry()
	End Method
	
	Method OpenEntry:Int(entry:wxArchiveEntry)
	End Method
	
End Type

Type wxArchiveOutputStream Extends wxFilterOutputStream

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
