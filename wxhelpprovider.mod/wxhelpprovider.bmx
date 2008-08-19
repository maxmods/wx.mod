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
Type wxHelpProvider

	Field wxObjectPtr:Byte Ptr
	
	Global currentHelpProvider:wxHelpProvider

	Function _create:wxHelpProvider(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHelpProvider = New wxHelpProvider
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function Set:wxHelpProvider(helpProvider:wxHelpProvider)
		currentHelpProvider = helpProvider
		Return _create(bmx_wxhelpprovider_set(helpProvider.wxObjectPtr))
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function Get:wxHelpProvider()
		If Not currentHelpProvider Then
			Return _create(bmx_wxhelpprovider_get())
		Else
			Return currentHelpProvider
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method AddHelp(window:wxWindow, text:String)
		bmx_wxhelpprovider_addhelp(wxObjectPtr, Window.wxObjectPtr, text)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddHelpId(windowId:Int, text:String)
		bmx_wxhelpprovider_addhelpid(wxObjectPtr, windowId, text)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetHelp:String(window:wxWindow)
		Return bmx_wxhelpprovider_gethelp(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the association between the window pointer and the help text.
	about: This is called by the wxWindow destructor. Without this, the table of help strings will fill up and when window pointers are reused, the wrong help string will be found.
	End Rem
	Method RemoveHelp(window:wxWindow)
		bmx_wxhelpprovider_removehelp(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Method Delete()
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

	Rem
	bbdoc: 
	End Rem
	Function CreateSimpleHelpProvider:wxSimpleHelpProvider()
		Return New wxSimpleHelpProvider.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSimpleHelpProvider()
		wxObjectPtr = bmx_wxsimplehelpprovider_create()
		Return Self
	End Method

End Type
