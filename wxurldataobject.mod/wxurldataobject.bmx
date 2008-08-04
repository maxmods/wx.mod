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
bbdoc: wxURLDataObject
End Rem
Module wx.wxURLDataObject

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
bbdoc: wxURLDataObject is a wxDataObject containing an URL and can be used e.g. when you need to put an URL on or retrieve it from the clipboard.
End Rem
?win32
Type wxURLDataObject Extends wxDataObjectComposite
?Not win32
Type wxURLDataObject Extends wxTextDataObject
?
	Rem
	bbdoc: Constructor, may be used to initialize the URL.
	about: If @url is empty, SetURL can be used later.
	End Rem
	Function CreateURLDataObject:wxURLDataObject(url:String = "")
		Return New wxURLDataObject.Create(url)
	End Function
	
	Rem
	bbdoc: Constructor, may be used to initialize the URL.
	about: If @url is empty, SetURL can be used later.
	End Rem
	Method Create:wxURLDataObject(url:String = "")
		wxObjectPtr = bmx_wxurldataobject_create(url)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the URL stored by this object, as a string.
	End Rem
	Method GetURL:String()
		Return bmx_wxurldataobject_geturl(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the URL stored by this object.
	End Rem
	Method SetURL(url:String)
		bmx_wxurldataobject_seturl(wxObjectPtr, url)
	End Method

	Method Delete()
		If wxObjectPtr And owner Then
			bmx_wxurldataobject_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type
