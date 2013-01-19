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
bbdoc: wxHtmlModalHelp
End Rem
Module wx.wxHtmlModalHelp

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
bbdoc: This type uses wxHtmlHelpController to display help in a modal dialog.
about: This is useful on platforms such as wxMac where if you display help from a modal
dialog, the help window must itself be a modal dialog.
End Rem
Type wxHtmlModalHelp

	Field wxObjectPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem	
	Function CreateHtmlModalHelp:wxHtmlModalHelp(parent:wxWindow, helpFile:String, topic:String = "", ..
			style:Int = wxHF_DEFAULT_STYLE | wxHF_DIALOG | wxHF_MODAL)
		Return New wxHtmlModalHelp.Create(parent, helpFile, topic, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem	
	Method Create:wxHtmlModalHelp(parent:wxWindow, helpFile:String, topic:String = "", ..
			style:Int = wxHF_DEFAULT_STYLE | wxHF_DIALOG | wxHF_MODAL)
		wxObjectPtr = bmx_wxhtmlmodalhelp_create(parent.wxObjectPtr, helpFile, topic, style)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem	
	Method Free()
		If wxObjectPtr Then
			bmx_wxhtmlmodalhelp_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type


