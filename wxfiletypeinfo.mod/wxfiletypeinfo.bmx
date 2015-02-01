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
bbdoc: wxFileTypeInfo
End Rem
Module wx.wxFileTypeInfo

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
bbdoc: Container of information about wxFileType.
about: This type simply stores information associated with the file type.
It doesn't do anything on its own and is used only to allow constructing wxFileType from it (instead of specifying all the constituent pieces separately)
End Rem
Type wxFileTypeInfo Extends wxObject

	Rem
	bbdoc: Constructs a wxFileTypeInfo specifying the MIME type name.
	End Rem
	Function CreateFileTypeInfo:wxFileTypeInfo(mimeType:String)
		Return New wxFileTypeInfo.Create(mimeType)
	End Function
	
	Rem
	bbdoc: Constructs a wxFileTypeInfo specifying the MIME type name.
	End Rem
	Method Create:wxFileTypeInfo(mimeType:String)
		wxObjectPtr = bmx_wxfiletypeinfo_create(mimeType)
		Return Self
	End Method

	Function _create:wxFileTypeInfo(wxObjectPtr:Byte Ptr)
		Local this:wxFileTypeInfo = New wxFileTypeInfo
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Add another extension associated with this file type.
	End Rem
	Method AddExtension(ext:String)
		bmx_wxfiletypeinfo_addextension(wxObjectPtr, ext)
	End Method
	
	Rem
	bbdoc: Set the file type description.
	End Rem
	Method SetDescription(description:String)
		bmx_wxfiletypeinfo_setdescription(wxObjectPtr, description)
	End Method
	
	Rem
	bbdoc: Set the command to be used for opening files of this type.
	End Rem
	Method SetOpenCommand(command:String)
		bmx_wxfiletypeinfo_setopencommand(wxObjectPtr, command)
	End Method
	
	Rem
	bbdoc: Set the command to be used for printing files of this type.
	End Rem
	Method SetPrintCommand(command:String)
		bmx_wxfiletypeinfo_setprintcommand(wxObjectPtr, command)
	End Method
	
	Rem
	bbdoc: Set the short description for the files of this type.
	about: This is only used under MSW for some of the registry keys used for the file type registration.
	End Rem
	Method SetShortDesc(shortDesc:String)
		bmx_wxfiletypeinfo_setshortdesc(wxObjectPtr, shortDesc)
	End Method
	
	Rem
	bbdoc: Set the icon information.
	End Rem
	Method SetIcon(iconFile:String, iconIndex:Int = 0)
		bmx_wxfiletypeinfo_seticon(wxObjectPtr, iconFile, iconIndex)
	End Method
	
	Rem
	bbdoc: Get the MIME type.
	End Rem
	Method GetMimeType:String()
		Return bmx_wxfiletypeinfo_getmimetype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the open command.
	End Rem
	Method GetOpenCommand:String()
		Return bmx_wxfiletypeinfo_getopencommand(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the print command.
	End Rem
	Method GetPrintCommand:String()
		Return bmx_wxfiletypeinfo_getprintcommand(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the short description (only used under Win32 so far)
	End Rem
	Method GetShortDesc:String()
		Return bmx_wxfiletypeinfo_getshortdesc(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the long, user visible description.
	End Rem
	Method GetDescription:String()
		Return bmx_wxfiletypeinfo_getdescription(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the array of all extensions.
	End Rem
	Method GetExtensions:String[]()
		Return bmx_wxfiletypeinfo_getextensions(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the number of extensions.
	End Rem
	Method GetExtensionsCount:Int()
		Return bmx_wxfiletypeinfo_getextensionscount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the icon filename.
	End Rem
	Method GetIconFile:String()
		Return bmx_wxfiletypeinfo_geticonfile(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the index of the icon within the icon file.
	End Rem
	Method GetIconIndex:Int()
		Return bmx_wxfiletypeinfo_geticonindex(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxfiletypeinfo_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type
