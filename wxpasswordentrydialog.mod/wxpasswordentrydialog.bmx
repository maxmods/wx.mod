' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: wxPasswordEntryDialog
End Rem
Module wx.wxPasswordEntryDialog

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
bbdoc: This type represents a dialog that requests a one-line password string from the user.
about: It is implemented as a generic wxWidgets dialog.
End Rem
Type wxPasswordEntryDialog Extends wxTextEntryDialog

	Rem
	bbdoc: Constructor.
	about: Use wxTextEntryDialog::ShowModal to show the dialog.
	End Rem
	Function CreatePasswordEntryDialog:wxPasswordEntryDialog(parent:wxWindow, message:String, caption:String = "Enter password", ..
			defaultValue:String = "", style:Int = wxOK | wxCANCEL | wxCENTRE, x:Int = -1, y:Int = -1)
		Return New wxPasswordEntryDialog.Create(parent, message, caption, defaultValue, style, x, y)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Use wxTextEntryDialog::ShowModal to show the dialog.
	End Rem
	Method Create:wxPasswordEntryDialog(parent:wxWindow, message:String, caption:String = "Enter password", ..
			defaultValue:String = "", style:Int = wxOK | wxCANCEL | wxCENTRE, x:Int = -1, y:Int = -1)
		wxObjectPtr = bmx_wxpasswordentrydialog_create(Self, parent.wxObjectPtr, message, caption, defaultValue, style, x, y)
		Return Self
	End Method

End Type

Rem
bbdoc: Similar to wxGetTextFromUser but the text entered in the dialog is not shown on screen but replaced with stars.
about: This is intended to be used for entering passwords as the function name implies.
End Rem
Function wxGetPasswordFromUser:String(message:String, caption:String = "Input text", defaultValue:String = "", ..
		parent:wxWindow = Null, x:Int = -1, y:Int = -1, centre:Int = True)

	If parent Then
		Return bmx_wxgetpasswordfromuser(message, caption, defaultValue, parent.wxObjectPtr, x, y, centre)
	Else
		Return bmx_wxgetpasswordfromuser(message, caption, defaultValue, Null, x, y, centre)
	End If

End Function

