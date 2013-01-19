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
bbdoc: wxZipOutputStream
End Rem
Module wx.wxZipOutputStream

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
bbdoc: Output stream for writing zip files.
about: PutNextEntry() is used to create a new entry in the output zip, then the entry's data is
written to the wxZipOutputStream. Another call to PutNextEntry() closes the current entry and
begins the next.
End Rem
Type wxZipOutputStream Extends wxArchiveOutputStream

	Rem
	bbdoc: Constructor.
	about: @level is the compression level to use. It can be a value between 0 and 9 or -1 to
	use the default value which currently is equivalent to 6.
	End Rem
	Function CreateZipOutputStream:wxZipOutputStream(stream:wxOutputStream, level:Int = -1)
		Return New wxZipOutputStream.Create(stream, level)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: @level is the compression level to use. It can be a value between 0 and 9 or -1 to
	use the default value which currently is equivalent to 6.
	End Rem
	Method Create:wxZipOutputStream(stream:wxOutputStream, level:Int = -1)
		wxStreamPtr = bmx_wxzipoutputstream_create(stream.wxStreamPtr, level)
		Return Self
	End Method

	Rem
	bbdoc: Finishes writing the zip, returning true if successful.
	about: Called by the destructor if not called explicitly.
	End Rem
	Method Close:Int()
		Return bmx_wxzipoutputstream_close(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Close the current entry.
	about: It is called implicitly whenever another new entry is created with PutNextEntry(), or
	when the zip is closed.
	End Rem
	Method CloseEntry:Int()
		Return bmx_wxzipoutputstream_closeentry(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Gets the compression level.
	End Rem
	Method GetLevel:Int()
		Return bmx_wxzipoutputstream_getlevel(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Set the compression level that will be used the next time an entry is created.
	about: It can be a value between 0 and 9 or -1 to use the default value which currently
	is equivalent to 6.
	End Rem
	Method SetLevel(level:Int)
		bmx_wxzipoutputstream_setlevel(wxStreamPtr, level)
	End Method
	
	Rem
	bbdoc: Creates a new directory entry (see wxArchiveEntry::IsDir()) with the given @name and optional @timestamp.
	about: PutNextEntry() can also be used to create directory entries, by supplying a name with
	a trailing path separator.
	End Rem
	Method PutNextDirEntry:Int(name:String, dt:wxDateTime = Null)
		If dt Then
			Return bmx_wxzipoutputstream_putnextdirentry(wxStreamPtr, name, dt.wxObjectPtr)
		Else
			Return bmx_wxzipoutputstream_putnextdirentry(wxStreamPtr, name, Null)
		End If
	End Method
	
	Rem
	bbdoc: Create a new entry with the given @name and optional @timestamp.
	End Rem
	Method PutNextEntry:Int(name:String, dt:wxDateTime = Null)
		If dt Then
			Return bmx_wxzipoutputstream_putnextentry(wxStreamPtr, name, dt.wxObjectPtr)
		Else
			Return bmx_wxzipoutputstream_putnextentry(wxStreamPtr, name, Null)
		End If
	End Method
	
	Rem
	bbdoc: Sets a comment for the zip as a whole. It is written at the end of the zip.
	End Rem
	Method SetComment(comment:String)
		bmx_wxzipoutputstream_setcomment(wxStreamPtr, comment)
	End Method

	Rem
	bbdoc: Frees the output stream.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxzipoutputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

