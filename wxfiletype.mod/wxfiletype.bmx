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
bbdoc: wxFileType
End Rem
Module wx.wxFileType

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
bbdoc: This type holds information about a given file type.
about: File type is the same as MIME type under Unix, but under Windows it corresponds more to an extension than to MIME type
(in fact, several extensions may correspond to a file type).
<p>
This object may be created in several different ways: the program might know the file extension and wish to find out the corresponding MIME type or,
conversely, it might want to find the right extension for the file to which it writes the contents of given MIME type. Depending on how it was
created some fields may be unknown so the return value of all the accessors must be checked: false will be returned if the corresponding information couldn't be found.
</p>
<p>
The objects of this class are never created by the application code but are returned by wxMimeTypesManager::GetFileTypeFromMimeType and
wxMimeTypesManager::GetFileTypeFromExtension methods.
</p>
End Rem
Type wxFileType Extends wxObject

	Function _create:wxFileType(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFileType = New wxFileType
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns a brief description for this file type: for example, "text document" for the "text/plain" MIME type, or Null if there is no description.
	End Rem
	Method GetDescription:String()
		Return bmx_wxfiletype_getdescription(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of all extensions associated with this file type.
	about: For example, it may contain the following two elements for the MIME type "text/html" (notice the absence of the leading dot): "html" and "htm".
	End Rem
	Method GetExtensions:String[]()
		Return bmx_wxfiletype_getextensions(wxObjectPtr)
	End Method
	
	'Method GetIcon()
	' TODO
	'End Method
	
	Rem
	bbdoc: Returns the full MIME type specification for this file type: for example, "text/plain", or Null if the value is not set.
	End Rem
	Method GetMimeType:String()
		Return bmx_wxfiletype_getmimtype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of all mime types associated with this file type.
	about: This array will contain only one item in most cases but sometimes, notably under Unix with KDE, may contain more MIME types.
	This happens when one file extension is mapped to different MIME types by KDE, mailcap and mime.types.
	End Rem
	Method GetMimeTypes:String[]()
		Return bmx_wxfiletype_getmimetypes(wxObjectPtr)
	End Method

	'Method GetPrintCommand:String(params:MessageParameters)
	' TODO
	'End Method
	
	Rem
	bbdoc: Returns the command which must be executed (see wxExecute()) in order to open the file of the given type.
	about: An empty string is returned to indicate that an error occurred (typically meaning that there is no standard way to open this kind of files).
	End Rem
	Method GetOpenCommand:String(filename:String)
		Return bmx_wxfiletype_getopencommand(wxObjectPtr, filename)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxfiletype_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

