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
bbdoc: wxDialog
End Rem
Module wx.wxDialog

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
bbdoc: A dialog box is a window with a title bar and sometimes a system menu, which can be moved around the screen.
about: It can contain controls and other windows and is often used to allow the user to make some
choice or to answer a question.
End Rem
Type wxDialog Extends wxTopLevelWindow

	Rem
	bbdoc: 
	End Rem
	Function CreateDialog:wxDialog(parent:wxWindow, id:Int, title:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		Return New wxDialog.Create_(parent, id, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create_:wxDialog(parent:wxWindow, id:Int, title:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		wxObjectPtr = bmx_wxdialog_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Centre(direction:Int = wxBOTH)
		bmx_wxdialog_centre(wxObjectPtr, direction)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateButtonSizer:wxSizer(flags:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateSeparatedButtonSizer:wxSizer(flags:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateStdDialogButtonSizer:wxStdDialogButtonSizer(flags:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DoOK:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndModal(retCode:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAffirmativeId:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEscapeId:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetReturnCode:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Iconize(value:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsIconized:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsModal:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAffirmativeId(id:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEscapeId(id:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetIcon(icon:wxIcon)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetIcons()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetModal(flag:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetReturnCode(retCode:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Show:Int(value:Int)
		Return bmx_wxdialog_show(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowModal:Int()
		Return bmx_wxdialog_showmodal(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Frees the Dialog object from memory.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxdialog_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

Type wxStdDialogButtonSizer Extends wxBoxSizer

End Type