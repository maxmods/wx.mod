' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxMimeTypesManager
End Rem
Module wx.wxMimeTypesManager

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: This type allows the application to retrieve informations about all known MIME types from a system-specific location and the filename extensions to the MIME types and vice versa.
about: MIME stands for "Multipurpose Internet Mail Extensions" and was originally used in mail protocols. It's standardized by several RFCs.
<p>
Under Windows, the MIME type information is queried from registry. Under Linux and Unix, it is queried from the XDG data directories.
</p>
<p>
Currently, wxMimeTypesManager is limited to reading MIME type information.
</p>
End Rem
Type wxMimeTypesManager Extends wxObject

	Rem
	bbdoc: Creates a new wxMimeTypesManager instance.
	End Rem
	Function CreateMimeTypesManager:wxMimeTypesManager()
		Return New wxMimeTypesManager.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxMimeTypesManager instance.
	End Rem
	Method Create:wxMimeTypesManager()
		Return Self
	End Method

	Rem
	bbdoc: Gather information about the files with given extension and return the corresponding wxFileType object or NULL if the extension is unknown.
	about: The extension parameter may have, or not, the leading dot, if it has it, it is stripped automatically. It must not however be empty.
	End Rem
	Method GetFileTypeFromExtension:wxFileType(extension:String)
		Return wxFileType._create(bmx_wxmimetypesmanager_getfiletypefromextension(extension))
	End Method
	
	Rem
	bbdoc: Gather information about the files with given MIME type and return the corresponding wxFileType object or NULL if the MIME type is unknown. 
	End Rem
	Method GetFileTypeFromMimeType:wxFileType(mimeType:String)
		Return wxFileType._create(bmx_wxmimetypesmanager_getfiletypefrommimetype(mimeType))
	End Method
	
	Rem
	bbdoc: Create a new association using the fields of wxFileTypeInfo (at least the MIME type and the extension should be set).
	End Rem
	Method Associate:wxFileType(info:wxFileTypeInfo)
		Return wxFileType._create(bmx_wxmimetypesmanager_associate(info.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Undo Associate().
	End Rem
	Method Unassociate(ft:wxFileType)
		bmx_wxmimetypesmanager_unassociate(ft.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This function returns True if either the given mimeType is exactly the same as wildcard or if it has the same category and the subtype of wildcard is '*'.
	about: Note that the '*' wildcard is not allowed in mimeType itself.
	The comparison done by this function is case insensitive so it is not necessary to convert the strings to the same case before calling it.
	End Rem
	Function IsOfType:Int(mimeType:String, wildcard:String)
		Return bmx_wxmimetypesmanager_isoftype(mimeType, wildcard)
	End Function

End Type
