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
bbdoc: wxZipInputStream
End Rem
Module wx.wxZipInputStream

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
bbdoc: Input stream for reading zip files.
about: GetNextEntry() returns an wxZipEntry object containing the meta-data for the next entry in the zip (and
gives away ownership). Reading from the wxZipInputStream then returns the entry's data. Eof() becomes true after
an attempt has been made to read past the end of the entry's data. When there are no more entries, GetNextEntry()
returns NULL and sets Eof().
<p>
Note that in general zip entries are not seekable, and wxZipInputStream::SeekI() always returns wxInvalidOffset.
</p>
End Rem
Type wxZipInputStream Extends wxArchiveInputStream

	Rem
	bbdoc: Creates a new wxZipInputStream.
	End Rem
	Function CreateZipInputStream:wxZipInputStream(stream:wxInputStream)
		Return New wxZipInputStream.Create(stream)
	End Function
	
	Rem
	bbdoc: Creates a new wxZipInputStream.
	End Rem
	Method Create:wxZipInputStream(stream:wxInputStream)
		wxStreamPtr = bmx_wxzipinputstream_create(stream.wxStreamPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Closes the current entry.
	about: On a non-seekable stream reads to the end of the current entry first.
	End Rem
	Method CloseEntry:Int()
		Return bmx_wxzipinputstream_closeentry(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Returns the zip comment.
	about: This is stored at the end of the zip, therefore when reading a zip from a non-seekable stream,
	it returns the empty string until the end of the zip has been reached, i.e. when GetNextEntry() returns NULL.
	End Rem
	Method GetComment:String()
		Return bmx_wxzipinputstream_getcomment(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Closes the current entry if one is open, then reads the meta-data for the next entry and returns it in a wxZipEntry object, giving away ownership.
	about: The stream is then open and can be read.
	End Rem
	Method GetNextEntry:wxZipEntry()
		Return wxZipEntry._create(bmx_wxzipinputstream_getnextentry(wxStreamPtr))
	End Method
	
	Rem
	bbdoc: For a zip on a seekable stream returns the total number of entries in the zip.
	about: For zips on non-seekable streams returns the number of entries returned so far by GetNextEntry().
	End Rem
	Method GetTotalEntries:Int()
		Return bmx_wxzipinputstream_gettotalentries(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Closes the current entry if one is open, then opens the entry specified by the entry object.
	about: Parameters:
	<ul>
	<li><b>entry</b> should be from the same zip file, and the zip should be on a seekable stream.</li>
	</ul>
	End Rem
	Method OpenEntry:Int(entry:wxArchiveEntry)
		Return bmx_wxzipinputstream_openentry(wxStreamPtr, entry.wxObjectPtr)
	End Method

	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxzipinputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

