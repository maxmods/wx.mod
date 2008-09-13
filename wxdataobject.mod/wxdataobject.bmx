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
bbdoc: wxDataObject
End Rem
Module wx.wxDataObject

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
bbdoc: A wxDataObject represents data that can be copied to or from the clipboard, or dragged and dropped.
about: The important thing about wxDataObject is that this is a 'smart' piece of data unlike 'dumb' data
containers such as memory buffers or files. Being 'smart' here means that the data object itself should know
what data formats it supports and how to render itself in each of its supported formats.
<p>
A supported format, incidentally, is exactly the format in which the data can be requested from a data
object or from which the data object may be set. In the general case, an object may support different formats
on 'input' and 'output', i.e. it may be able to render itself in a given format but not be created from data on
this format or vice versa.
</p>
End Rem
Type wxDataObject

	Field wxObjectPtr:Byte Ptr
	Field owner:Int = True

	Function _create:wxDataObject(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDataObject = New wxDataObject
			this.wxObjectPtr = wxObjectPtr
			this.owner = False
			Return this
		End If
	End Function

	Method releaseObject()
		owner = False
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxDataObjectSimple Extends wxDataObject

End Type

Rem
bbdoc: 
End Rem
Type wxDataObjectComposite Extends wxDataObject

End Type


