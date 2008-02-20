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
bbdoc: wxHelpProvider
End Rem
Module wx.wxHelpProvider

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
bbdoc: An abstract class used by a program implementing context-sensitive help to show the help text for the given window.
about: The current help provider must be explicitly set by the application using wxHelpProvider::Set().
End Rem
Type wxHelpProvider Abstract

	Field wxObjectPtr:Byte Ptr

	Function Set:wxHelpProvider(helpProvider:wxHelpProvider)
	End Function
	
	Function Get:wxHelpProvider()
	End Function
	
	Method AddHelp(window:wxWindow, text:String)
	End Method
	
	Method GetHelp:String(window:wxWindow)
	End Method
	
	Method RemoveHelp(window:wxWindow)
	End Method
	
	Rem
	bbdoc: Frees the internal object
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxhelpprovider_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: An implementation of wxHelpProvider which supports only plain text help strings, and shows the string associated with the control (if any) in a tooltip.
End Rem
Type wxSimpleHelpProvider Extends wxHelpProvider

	Function CreateSimpleHelpProvider:wxSimpleHelpProvider()
	End Function
	
	Method Create:wxSimpleHelpProvider()
	End Method

End Type
