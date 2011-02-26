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
bbdoc: 
End Rem
Module wx.wxFSFile

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
bbdoc: Represents a single file opened by wxFileSystem.
about: It provides more information than wxWindow's input stream (stream, filename, mime type, anchor).
End Rem
Type wxFSFile Extends wxObject

	Function _create:wxFSFile(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFSFile = New wxFSFile
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Detaches the stream from the wxFSFile object.
	about: That is, the stream obtained with GetStream() will continue its existance after the wxFSFile object is deleted.
	You will have to delete the stream yourself.
	End Rem
	Method DetachStream()
		bmx_wxfsfile_detachstream(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns anchor (if present).
	about: The term of anchor can be easily explained using few examples:
	<pre>
index.htm#anchor                      /* 'anchor' is anchor */ 
index/wx001.htm                       /* NO anchor here!    */ 
archive/main.zip#zip:index.htm#global /* 'global'           */ 
archive/main.zip#zip:index.htm        /* NO anchor here!    */ 
</pre>
	Usually an anchor is presented only if the MIME type is 'text/html'. But it may have some meaning with other files;
	for example myanim.avi#200 may refer to position in animation or reality.wrl#MyView may refer to a predefined
	view in VRML.
	End Rem
	Method GetAnchor:String()
		Return bmx_wxfsfile_getanchor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns full location of the file, including path and protocol.
	End Rem
	Method GetLocation:String()
		Return bmx_wxfsfile_getlocation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the MIME type of the content of this file.
	about: It is either extension-based (see wxMimeTypesManager) or extracted from HTTP protocol Content-Type header.
	End Rem
	Method GetMimeType:String()
		Return bmx_wxfsfile_getmimetype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns time when this file was modified.
	End Rem
	Method GetModificationTime:wxDateTime()
		Return wxDateTime._create(bmx_wxfsfile_getmodificationtime(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the stream.
	about: You can use the returned stream to directly access data. You may suppose that the stream provide Seek and
	GetSize functionality (even in the case of the HTTP protocol which doesn't provide this by default. wxHtml
	uses local cache to work around this and to speed up the connection).
	End Rem
	Method GetStream:wxInputStream()
		Return wxInputStream._create(bmx_wxfsfile_getstream(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Frees the wxFSFile object.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxfsfile_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type
