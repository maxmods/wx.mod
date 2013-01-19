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
bbdoc: wxBZipStream
End Rem
Module wx.wxBZipStream

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
bbdoc: A BZip input stream.
End Rem
Type wxBZipInputStream Extends wxFilterInputStream

	Rem
	bbdoc: 
	about: If @lessMemory is true, uses decompression algorithm which uses less memory, but is also
	slower.
	End Rem
	Function CreateBZipInputStream:wxBZipInputStream(stream:wxInputStream, lessMemory:Int = False)
		Return New wxBZipInputStream.Create(stream, lessMemory)
	End Function
	
	Rem
	bbdoc: 
	about: If @lessMemory is true, uses decompression algorithm which uses less memory, but is also
	slower.
	End Rem
	Method Create:wxBZipInputStream(stream:wxInputStream, lessMemory:Int = False)
		wxStreamPtr = bmx_wxbzipinputstream_create(stream.wxStreamPtr, lessMemory)
		Return Self
	End Method

	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxbzipinputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: A BZip output stream.
End Rem
Type wxBZipOutputStream Extends wxFilterOutputStream

	Rem
	bbdoc: 
	about: @compressionFactor is from 1-9. Compression is higher but slower at higher numbers
	End Rem
	Function CreateBZipOutputStream:wxBZipOutputStream(stream:wxOutputStream, compressionFactor:Int = 4)
		Return New wxBZipOutputStream.Create(stream, compressionFactor)
	End Function
	
	Rem
	bbdoc: 
	about: @compressionFactor is from 1-9. Compression is higher but slower at higher numbers
	End Rem
	Method Create:wxBZipOutputStream(stream:wxOutputStream, compressionFactor:Int = 4)
		wxStreamPtr = bmx_wxbzipoutputstream_create(stream.wxStreamPtr, compressionFactor)
		Return Self
	End Method

	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxbzipoutputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

