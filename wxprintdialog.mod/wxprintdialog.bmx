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
bbdoc: wxPrintDialog
End Rem
Module wx.wxPrintDialog

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
bbdoc: This type represents the print and print setup common dialogs.
about: You may obtain a wxPrinterDC device context from a successfully dismissed print dialog.
End Rem
Type wxPrintDialog Extends wxDialog

	Rem
	bbdoc: Constructor
	about: Pass a parent window, and optionally a block of print data, which will be copied
	to the print dialog's print data.
	End Rem
	Function CreatePrintDialog:wxPrintDialog(parent:wxWindow, data:wxPrintDialogData = Null)
		Return New wxPrintDialog.Create(parent, data)
	End Function
	
	Rem
	bbdoc: Constructor
	about: Pass a parent window, and optionally a block of print data, which will be copied
	to the print dialog's print data.
	End Rem
	Method Create:wxPrintDialog(parent:wxWindow, data:wxPrintDialogData = Null)
		If data Then
			wxObjectPtr = bmx_wxprintdialog_create(Self, parent, data.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxprintdialog_create(Self, parent, Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Returns the print dialog data associated with the print dialog.
	End Rem
	Method GetPrintDialogData:wxPrintDialogData()
		Return wxPrintDialogData._create(bmx_wxprintdialog_getprintdialogdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the device context created by the print dialog, if any.
	about: When this method has been called, the ownership of the device context is transferred to the application,
	so it must then be deleted explicitly using wxDC.Free().
	End Rem
	Method GetPrintDC:wxDC()
		Return wxDC._create(bmx_wxprintdialog_getprintdc(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	about: After this method is called, a device context may be retrievable using wxPrintDialog::GetPrintDC.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxprintdialog_showmodal(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: This type holds information related to the visual characteristics of wxPrintDialog.
about: It contains a wxPrintData object with underlying printing settings.
End Rem
Type wxPrintDialogData Extends wxObject

	Rem
	bbdoc: Constructs a wxPrintDialogData object with an optional print data object.
	End Rem
	Function CreatePrintDialogData:wxPrintDialogData(printData:wxPrintData = Null)
		Return New wxPrintDialogData.Create(printData)
	End Function
	
	Rem
	bbdoc: Constructs a wxPrintDialogData object with an optional print data object.
	End Rem
	Method Create:wxPrintDialogData(printData:wxPrintData = Null)
		If printData Then
			wxObjectPtr = bmx_wxprintdialogdata_create(printData.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxprintdialogdata_create(Null)
		End If
		Return Self
	End Method

	Function _create:wxPrintDialogData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPrintDialogData = New wxPrintDialogData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Enables or disables the 'Help' button.
	End Rem
	Method EnableHelp(flag:Int)
		bmx_wxprintdialogdata_enablehelp(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Page numbers' controls.
	End Rem
	Method EnablePageNumbers(flag:Int)
		bmx_wxprintdialogdata_enablepagenumbers(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Print to file' checkbox.
	End Rem
	Method EnablePrintToFile(flag:Int)
		bmx_wxprintdialogdata_enableprinttofile(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Selection' radio button.
	End Rem
	Method EnableSelection(flag:Int)
		bmx_wxprintdialogdata_enableselection(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that all pages be printed.
	End Rem
	Method GetAllPages:Int()
		Return bmx_wxprintdialogdata_getallpages(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that the document(s) be collated.
	End Rem
	Method GetCollate:Int()
		Return bmx_wxprintdialogdata_getcollate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the from page number, as entered by the user.
	End Rem
	Method GetFromPage:Int()
		Return bmx_wxprintdialogdata_getfrompage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the maximum page number.
	End Rem
	Method GetMaxPage:Int()
		Return bmx_wxprintdialogdata_getmaxpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the minimum page number.
	End Rem
	Method GetMinPage:Int()
		Return bmx_wxprintdialogdata_getminpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of copies requested by the user.
	End Rem
	Method GetNoCopies:Int()
		Return bmx_wxprintdialogdata_getnocopies(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a reference to the internal wxPrintData object.
	End Rem
	Method GetPrintData:wxPrintData()
		Return wxPrintData._create(bmx_wxprintdialogdata_getprintdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns true if the user has selected printing to a file.
	End Rem
	Method GetPrintToFile:Int()
		Return bmx_wxprintdialogdata_getprinttofile(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that the selection be printed (where 'selection' is a concept specific to the application).
	End Rem
	Method GetSelection:Int()
		Return bmx_wxprintdialogdata_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the to page number, as entered by the user.
	End Rem
	Method GetToPage:Int()
		Return bmx_wxprintdialogdata_gettopage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the print data is valid for using in print dialogs.
	about: This can return false on Windows if the current printer is not set, for example. On all other
	platforms, it returns true.
	End Rem
	Method IsOk:Int()
		Return bmx_wxprintdialogdata_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the 'Collate' checkbox to true or false.
	End Rem
	Method SetCollate(flag:Int)
		bmx_wxprintdialogdata_setcollate(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the from page number.
	End Rem
	Method SetFromPage(page:Int)
		bmx_wxprintdialogdata_setfrompage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the maximum page number.
	End Rem
	Method SetMaxPage(page:Int)
		bmx_wxprintdialogdata_setmaxpage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the minimum page number.
	End Rem
	Method SetMinPage(page:Int)
		bmx_wxprintdialogdata_setminpage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the default number of copies the user has requested to be printed out.
	End Rem
	Method SetNoCopies(count:Int)
		bmx_wxprintdialogdata_setnocopies(wxObjectPtr, count)
	End Method
	
	Rem
	bbdoc: Sets the internal wxPrintData.
	End Rem
	Method SetPrintData(printData:wxPrintData)
		bmx_wxprintdialogdata_setprintdata(wxObjectPtr, printdata.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the 'Print to file' checkbox to true or false.
	End Rem
	Method SetPrintToFile(flag:Int)
		bmx_wxprintdialogdata_setprinttofile(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Selects the 'Selection' radio button.
	about: The effect of printing the selection depends on how the application implements this command, if at all.
	End Rem
	Method SetSelection(flag:Int)
		bmx_wxprintdialogdata_setselection(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the to page number.
	End Rem
	Method SetToPage(page:Int)
		bmx_wxprintdialogdata_settopage(wxObjectPtr, page)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxprintdialogdata_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


