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
bbdoc: wxCountingOutputStream
End Rem
Module wx.wxCountingOutputStream

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
bbdoc: wxCountingOutputStream is a specialized output stream which does not write any data anywhere.
about: Instead it counts how many bytes would get written if this were a normal stream. This
can sometimes be useful or required if some data gets serialized to a stream or compressed by
using stream compression and thus the final size of the stream cannot be known other than
pretending to write the stream. One case where the resulting size would have to be known is
if the data has to be written to a piece of memory and the memory has to be allocated before
writing to it (which is probably always the case when writing to a memory stream).
End Rem
Type wxCountingOutputStream Extends wxOutputStream

	Rem
	bbdoc: Creates a wxCountingOutputStream object.
	End Rem
	Function CreateOutputStream:wxCountingOutputStream()
		Return New wxCountingOutputStream.Create()
	End Function
	
	Rem
	bbdoc: Creates a wxCountingOutputStream object.
	End Rem
	Method Create:wxCountingOutputStream()
		wxStreamPtr = bmx_wxcountingoutputstream_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the current size of the stream.
	End Rem
	Method GetSize:Int()
		Return bmx_wxcountingoutputstream_getsize(wxStreamPtr)
	End Method

	Method Free()
		If wxStreamPtr Then
			bmx_wxcountingoutputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
End Type

