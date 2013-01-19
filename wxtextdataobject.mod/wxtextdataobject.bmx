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
bbdoc: wxTextDataObject
End Rem
Module wx.wxTextDataObject

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
bbdoc: wxTextDataObject is a specialization of wxDataObject for text data.
about: It can be used without change to paste data into the wxClipboard or a wxDropSource.
A user may wish to derive a new class from this class for providing text on-demand in order to minimize memory
consumption when offering data in several formats, such as plain text and RTF because by default the text is
stored in a string in this class, but it might as well be generated when requested. For this, GetTextLength
and GetText will have to be overridden.
<p>
Note that if you already have the text inside a string, you will not achieve any efficiency gain by overriding these
functions because copying wxStrings is already a very efficient operation (data is not actually copied because
wxStrings are reference counted).
</p>
<p>
<b>NOTE</b : this does not currently support overriding in BlitzMax (TODO)
End Rem
Type wxTextDataObject Extends wxDataObjectSimple

	Rem
	bbdoc: Constructor, may be used to initialise the text (otherwise SetText should be used later).
	End Rem
	Function CreateTextDataObject:wxTextDataObject(text:String = "")
		Return New wxTextDataObject.Create(text)
	End Function
	
	Rem
	bbdoc: Constructor, may be used to initialise the text (otherwise SetText should be used later).
	End Rem
	Method Create:wxTextDataObject(text:String)
		wxObjectPtr = bmx_wxtextdataobject_create(text)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the data size.
	about: By default, returns the size of the text data set in the constructor or using SetText.
	End Rem
	Method GetTextLength:Int()
		Return bmx_wxtextdataobject_gettextlength(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the text associated with the data object. 
	End Rem
	Method GetText:String()
		Return bmx_wxtextdataobject_gettext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the text associated with the data object.
	End Rem
	Method SetText(text:String)
		bmx_wxtextdataobject_settext(wxObjectPtr, text)
	End Method

	Method Delete()
		If wxObjectPtr And owner Then
			bmx_wxtextdataobject_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


