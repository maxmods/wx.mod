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
bbdoc: wxPrintDialog
End Rem
Module wx.wxPrintDialog

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
bbdoc: This type represents the print and print setup common dialogs.
about: You may obtain a wxPrinterDC device context from a successfully dismissed print dialog.
End Rem
Type wxPrintDialog Extends wxDialog

	Rem
	bbdoc: Returns the print dialog data associated with the print dialog.
	End Rem
	Method GetPrintDialogData:wxPrintDialogData()
	End Method
	
	Rem
	bbdoc: Returns the device context created by the print dialog, if any.
	about: When this method has been called, the ownership of the device context is transferred to the application,
	so it must then be deleted explicitly.
	End Rem
	Method GetPrintDC:wxDC()
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	about: After this method is called, a device context may be retrievable using wxPrintDialog::GetPrintDC.
	End Rem
	Method ShowModal:Int()
	End Method
	
End Type

Rem
bbdoc: This type holds information related to the visual characteristics of wxPrintDialog.
about: It contains a wxPrintData object with underlying printing settings.
End Rem
Type wxPrintDialogData Extends wxObject

	Rem
	bbdoc: Enables or disables the 'Help' button.
	End Rem
	Method EnableHelp(flag:Int)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Page numbers' controls.
	End Rem
	Method EnablePageNumbers(flag:Int)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Print to file' checkbox.
	End Rem
	Method EnablePrintToFile(flag:Int)
	End Method
	
	Rem
	bbdoc: Enables or disables the 'Selection' radio button.
	End Rem
	Method EnableSelection(flag:Int)
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that all pages be printed.
	End Rem
	Method GetAllPages:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that the document(s) be collated.
	End Rem
	Method GetCollate:Int()
	End Method
	
	Rem
	bbdoc: Returns the from page number, as entered by the user.
	End Rem
	Method GetFromPage:Int()
	End Method
	
	Rem
	bbdoc: Returns the maximum page number.
	End Rem
	Method GetMaxPage:Int()
	End Method
	
	Rem
	bbdoc: Returns the minimum page number.
	End Rem
	Method GetMinPage:Int()
	End Method
	
	Rem
	bbdoc: Returns the number of copies requested by the user.
	End Rem
	Method GetNoCopies:Int()
	End Method
	
	Rem
	bbdoc: Returns a reference to the internal wxPrintData object.
	End Rem
	Method GetPrintData:wxPrintData()
	End Method
	
	Rem
	bbdoc: Returns true if the user has selected printing to a file.
	End Rem
	Method GetPrintToFile:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the user requested that the selection be printed (where 'selection' is a concept specific to the application).
	End Rem
	Method GetSelection:Int()
	End Method
	
	Rem
	bbdoc: Returns the to page number, as entered by the user.
	End Rem
	Method GetToPage:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the print data is valid for using in print dialogs.
	about: This can return false on Windows if the current printer is not set, for example. On all other
	platforms, it returns true.
	End Rem
	Method IsOk:Int()
	End Method
	
	Rem
	bbdoc: Sets the 'Collate' checkbox to true or false.
	End Rem
	Method SetCollate(flag:Int)
	End Method
	
	Rem
	bbdoc: Sets the from page number.
	End Rem
	Method SetFromPage(page:Int)
	End Method
	
	Rem
	bbdoc: Sets the maximum page number.
	End Rem
	Method SetMaxPage(page:Int)
	End Method
	
	Rem
	bbdoc: Sets the minimum page number.
	End Rem
	Method SetMinPage(page:Int)
	End Method
	
	Rem
	bbdoc: Sets the default number of copies the user has requested to be printed out.
	End Rem
	Method SetNoCopies(count:Int)
	End Method
	
	Rem
	bbdoc: Sets the internal wxPrintData.
	End Rem
	Method SetPrintData(printData:wxPrintData)
	End Method
	
	Rem
	bbdoc: Sets the 'Print to file' checkbox to true or false.
	End Rem
	Method SetPrintToFile(flag:Int)
	End Method
	
	Rem
	bbdoc: Selects the 'Selection' radio button.
	about: The effect of printing the selection depends on how the application implements this command, if at all.
	End Rem
	Method SetSelection(flag:Int)
	End Method
	
	Rem
	bbdoc: Sets the to page number.
	End Rem
	Method SetToPage(page:Int)
	End Method
	
End Type


