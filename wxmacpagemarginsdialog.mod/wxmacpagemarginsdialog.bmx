' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxMacPageMarginsDialog
End Rem
Module wx.wxMacPageMarginsDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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

' Mac Only :-)
?macos
Import "common.bmx"

Rem
bbdoc: A Mac dialog for setting the page margins separately from page setup since (native) wxMacPageSetupDialog doesn't let you set margins.
End Rem
Type wxMacPageMarginsDialog Extends wxDialog

	Rem
	bbdoc: 
	End Rem
	Function CreateMacPageMarginsDialog:wxMacPageMarginsDialog(parent:wxFrame, data:wxPageSetupDialogData = Null)
		Return New wxMacPageMarginsDialog.Create(parent, data)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMacPageMarginsDialog(parent:wxFrame, data:wxPageSetupDialogData = Null)
		If data Then
			wxObjectPtr = bmx_wxmacpagemarginsdialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxmacpagemarginsdialog_create(Self, parent.wxObjectPtr, Null)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TransferToWindow:Int()
		Return bmx_wxmacpagemarginsdialog_transfertowindow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TransferDataFromWindow:Int()
		Return bmx_wxmacpagemarginsdialog_transferdatafromwindow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPageSetupDialogData:wxPageSetupDialogData()
		Return wxPageSetupDialogData._create(bmx_wxmacpagemarginsdialog_getpagesetupdialogdata(wxObjectPtr))
	End Method

End Type











?

