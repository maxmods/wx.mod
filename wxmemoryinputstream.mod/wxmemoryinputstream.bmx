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
bbdoc: wxMemoryInputStream
End Rem
Module wx.wxMemoryInputStream

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2008-2009 Bruce A Henderson"


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
bbdoc: A memory input stream.
End Rem
Type wxMemoryInputStream Extends wxInputStream

	Rem
	bbdoc: Initializes a new read-only memory stream which will use the specified buffer of the given length.
	about: The stream does not take ownership of the buffer, i.e. the buffer will not be
	deleted in its destructor.
	End Rem
	Function CreateInputStream:wxMemoryInputStream(data:Byte Ptr, length:Int)
		Return New wxMemoryInputStream.Create(data, length)
	End Function
	
	Rem
	bbdoc: Creates a new read-only memory stream, initializing it with the data from the given output stream.
	End Rem
	Function CreateInputStreamFromOutput:wxMemoryInputStream(outputStream:wxMemoryOutputStream)
		Return New wxMemoryInputStream.CreateFromOutput(outputStream)
	End Function
	
	Rem
	bbdoc: Initializes a new read-only memory stream which will use the specified buffer of the given length.
	about: The stream does not take ownership of the buffer, i.e. the buffer will not be
	deleted in its destructor.
	End Rem
	Method Create:wxMemoryInputStream(data:Byte Ptr, length:Int)
		wxStreamPtr = bmx_wxmemoryinputstream_create(data, length)
		Return Self
	End Method
	
	Rem
	bbdoc: Creates a new read-only memory stream, initializing it with the data from the given output stream.
	End Rem
	Method CreateFromOutput:wxMemoryInputStream(outputStream:wxMemoryOutputStream)
		wxStreamPtr = bmx_wxmemoryinputstream_createfromoutput(outputStream.wxStreamPtr)
		Return Self
	End Method
	
	Method Free()
		If wxStreamPtr Then
			bmx_wxmemoryinputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method

	
End Type

