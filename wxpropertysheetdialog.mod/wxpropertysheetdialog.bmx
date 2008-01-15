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
bbdoc: wxPropertySheetDialog
End Rem
Module wx.wxPropertySheetDialog

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
bbdoc: This type represents a property sheet dialog: a tabbed dialog for showing settings.
End Rem
Type wxPropertySheetDialog Extends wxDialog

	Function CreatePropertySheetDialog:wxPropertySheetDialog(parent:wxWindow, id:Int, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		Return New wxPropertySheetDialog.Create(parent, id, title, x, y, w, h, style)
	End Function
	
	Method Create:wxPropertySheetDialog(parent:wxWindow, id:Int, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		wxObjectPtr = bmx_wxpropertysheetdialog_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Override this if you wish to add the book control in a way different from the standard way (for example, using different spacing).
	End Rem
	Method AddBookCtrl(sizer:wxSizer)
		bmx_wxpropertysheetdialog_addbookctrl(wxObjectPtr, sizer.wxSizerPtr)
	End Method
	
	Function _AddBookCtrl(obj:wxPropertySheetDialog, sizer:Byte Ptr)
		obj.AddBookCtrl(wxSizer._create(sizer))
	End Function

	Method CreateBookCtrl:wxBookCtrlBase()
		Return wxBookCtrlBase._create(bmx_wxpropertysheetdialog_createbookctrl(wxObjectPtr))
	End Method
	
	Function _CreateBookCtrl:Byte Ptr(obj:wxPropertySheetDialog)
		Return obj.CreateBookCtrl().wxObjectPtr
	End Function

	Method CreateButtons(flags:Int = wxOK | wxCANCEL)
		bmx_wxpropertysheetdialog_createbuttons(wxObjectPtr, flags)
	End Method

	Method GetBookCtrl:wxBookCtrlBase()
		Return wxBookCtrlBase._create(bmx_wxpropertysheetdialog_getbookctrl(wxObjectPtr))
	End Method

	Method GetInnerSizer:wxSizer()
		Return wxSizer._create(bmx_wxpropertysheetdialog_getinnersizer(wxObjectPtr))
	End Method

	Method GetSheetStyle:Int()
		Return bmx_wxpropertysheetdialog_getsheetstyle(wxObjectPtr)
	End Method

	Method LayoutDialog(centreFlags:Int = wxBOTH)
		bmx_wxpropertysheetdialog_layoutdialog(wxObjectPtr, centreFlags)
	End Method

	Method SetBookCtrl(bookCtrl:wxBookCtrlBase)
		bmx_wxpropertysheetdialog_setbookctrl(wxObjectPtr, bookCtrl.wxObjectPtr)
	End Method

End Type
