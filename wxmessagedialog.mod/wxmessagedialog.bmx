' Copyright (c) 2007-2011 Bruce A Henderson
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
bbdoc: wxMessageDialog
End Rem
Module wx.wxMessageDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This type represents a dialog that shows a single or multi-line message, with a choice of OK, Yes, No and Cancel buttons.
End Rem
Type wxMessageDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Use wxMessageDialog::ShowModal to show the dialog.
	End Rem
	Function CreateMessageDialog:wxMessageDialog(parent:wxWindow, message:String, caption:String = "Message box", ..
			style:Int = wxOK | wxCANCEL, x:Int = -1, y:Int = -1)
		Return New wxMessageDialog.Create(parent, message, caption, style, x, y)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Use wxMessageDialog::ShowModal to show the dialog.
	End Rem
	Method Create:wxMessageDialog(parent:wxWindow, message:String, caption:String = "Message box", ..
			style:Int = wxOK | wxCANCEL, x:Int = -1, y:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxmessagedialog_create(Self, parent.wxObjectPtr, message, caption, style, x, y)
		Else
			wxObjectPtr = bmx_wxmessagedialog_create(Self, Null, message, caption, style, x, y)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Shows the dialog, returning one of wxID_OK, wxID_CANCEL, wxID_YES, wxID_NO.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxmessagedialog_showmodal(wxObjectPtr)
	End Method
	
End Type

