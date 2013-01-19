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
bbdoc: wxMemoryFSHandler
End Rem
Module wx.wxMemoryFSHandler

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
bbdoc: This wxFileSystem handler can store arbitrary data in memory stream and make them accessible via URL.
about: It is particularly suitable for storing bitmaps from resources or included XPM files so that they
can be used with wxHTML.
<p>
Filenames are prefixed with "memory:", e.g. "memory:myfile.html".
</p>
End Rem
Type wxMemoryFSHandler Extends wxFileSystemHandler

	Method New()
		wxObjectPtr = bmx_wxmemoryfshandler_new(Self)
	End Method

	Rem
	bbdoc: Add an image file to list of files stored in memory.
	about: Stored data will be copied into private memory stream and available under name "memory:" + filename.
	<p>
	The @_type argument is one of wxBITMAP_TYPE_XXX constants. Note that you must use a type value
	(aka image format) that wxWidgets can save (e.g. JPG, PNG, see wxImage documentation)!
	</p>
	End Rem
	Function AddImageFile(filename:String, image:wxImage, _type:Int)
		bmx_wxmemoryfshandler_addimagefile(filename, image.wxObjectPtr, _type)
	End Function

	Rem
	bbdoc: Add a bitmap file to list of files stored in memory.
	about: Stored data will be copied into private memory stream and available under name "memory:" + filename.
	<p>
	The @_type argument is one of wxBITMAP_TYPE_XXX constants. Note that you must use a type value
	(aka image format) that wxWidgets can save (e.g. JPG, PNG, see wxImage documentation)!
	</p>
	End Rem
	Function AddBitmapFile(filename:String, bitmap:wxBitmap, _type:Int)
		bmx_wxmemoryfshandler_addbitmapfile(filename, bitmap.wxObjectPtr, _type)
	End Function

	Rem
	bbdoc: Like AddFile, but lets you explicitly specify added file's MIME type.
	about: This version should be used whenever you know the MIME type, because it makes accessing
	the files faster.
	End Rem
	Function AddFileWithMimeType(filename:String, textData:String, mimeType:String)
		bmx_wxmemoryfshandler_addfilewithmimetype(filename, textData, mimeType)
	End Function

	Rem
	bbdoc: Like AddFile, but lets you explicitly specify added file's MIME type.
	about: This version should be used whenever you know the MIME type, because it makes accessing
	the files faster.
	End Rem
	Function AddBinaryFileWithMimeType(filename:String, data:Byte Ptr, size:Int, mimeType:String)
		bmx_wxmemoryfshandler_addbinaryfilewithmimetype(filename, data, size, mimeType)
	End Function

	Rem
	bbdoc: Remove file from memory FS and free occupied memory.
	End Rem
	Function RemoveFile(filename:String)
		bmx_wxmemoryfshandler_removefile(filename)
	End Function
	
End Type

