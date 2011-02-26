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
bbdoc: wxPropertySheetDialog
End Rem
Module wx.wxPropertySheetDialog

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
bbdoc: This type represents a property sheet dialog: a tabbed dialog for showing settings.
about: It can be customized to use different controllers instead of the default notebook style.
<p>
To use this type, extend wxPropertySheetDialog, and then, in the OnInit, call CreateButtons, and create pages, adding them
to the book control. Finally call LayoutDialog.
</p>
<p>
For example:
<pre>
Method OnInit()
    CreateButtons(wxOK | wxCANCEL | wxHELP)

    ' Add page
    Local panel:wxPanel = new wxPanel.Create(GetBookCtrl(), ...)
    GetBookCtrl().AddPage(panel, "General")

    LayoutDialog()

End Method
</pre>
If necessary, override CreateBookCtrl and AddBookCtrl to create and add a different kind of book control.
</p>
End Rem
Type wxPropertySheetDialog Extends wxDialog

	Function _create:wxPropertySheetDialog(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPropertySheetDialog = New wxPropertySheetDialog
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxPropertySheetDialog(wxObjectPtr:Byte Ptr)
		Return wxPropertySheetDialog._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Creates a new wxPropertySheetDialog.
	End Rem
	Function CreatePropertySheetDialog:wxPropertySheetDialog(parent:wxWindow, id:Int, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		Return New wxPropertySheetDialog.Create(parent, id, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxPropertySheetDialog.
	End Rem
	Method Create:wxPropertySheetDialog(parent:wxWindow, id:Int, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE)
		If parent Then
			wxObjectPtr = bmx_wxpropertysheetdialog_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxpropertysheetdialog_create(Self, Null, id, title, x, y, w, h, style)
		End If
		OnInit()
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

	Rem
	bbdoc: Override this if you wish to create a different kind of book control.
	about: By default, the value passed to SetSheetStyle is used to determine the control.
	The default behaviour is to create a notebook.
	End Rem
	Method CreateBookCtrl:wxBookCtrlBase()
		Return wxBookCtrlBase._create(bmx_wxpropertysheetdialog_createbookctrl(wxObjectPtr))
	End Method
	
	Function _CreateBookCtrl:Byte Ptr(obj:wxPropertySheetDialog)
		Return obj.CreateBookCtrl().wxObjectPtr
	End Function

	Rem
	bbdoc: Call this to create the buttons for the dialog.
	about: This calls wxDialog::CreateButtonSizer, and the flags are the same.
	End Rem
	Method CreateButtons(flags:Int = wxOK | wxCANCEL)
		bmx_wxpropertysheetdialog_createbuttons(wxObjectPtr, flags)
	End Method

	Rem
	bbdoc: Returns the book control that will contain your settings pages.
	End Rem
	Method GetBookCtrl:wxBookCtrlBase()
		Return wxBookCtrlBase._create(bmx_wxpropertysheetdialog_getbookctrl(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the inner sizer that contains the book control and button sizer.
	End Rem
	Method GetInnerSizer:wxSizer()
		Return wxSizer._create(bmx_wxpropertysheetdialog_getinnersizer(wxObjectPtr))
	End Method

	Rem
	bbdoc: Returns the sheet style.
	End Rem
	Method GetSheetStyle:Int()
		Return bmx_wxpropertysheetdialog_getsheetstyle(wxObjectPtr)
	End Method

	Rem
	bbdoc: Call this to lay out the dialog.
	End Rem
	Method LayoutDialog(centreFlags:Int = wxBOTH)
		bmx_wxpropertysheetdialog_layoutdialog(wxObjectPtr, centreFlags)
	End Method

	Rem
	bbdoc: Sets the book control used for the dialog.
	about: You will normally not need to use this.
	End Rem
	Method SetBookCtrl(bookCtrl:wxBookCtrlBase)
		bmx_wxpropertysheetdialog_setbookctrl(wxObjectPtr, bookCtrl.wxObjectPtr)
	End Method

End Type


Type TPropertySheetDialogResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxpropertysheetdialog_addresourcehandler()
	End Method
		
End Type

New TPropertySheetDialogResourceFactory
