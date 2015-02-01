' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxPrinter
End Rem
Module wx.wxPrinter

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: This type represents the Windows or PostScript printer, and is the vehicle through which printing may be launched by an application.
about: Printing can also be achieved through using of lower functions and types, but this and associated types
provide a more convenient and general method of printing.
End Rem
Type wxPrinter Extends wxObject

	Rem
	bbdoc: Constructor.
	about: Pass an optional block of print dialog data, which will be copied to
	the printer object's local data.
	End Rem
	Function CreatePrinter:wxPrinter(data:wxPrintDialogData = Null)
		Return New wxPrinter.Create(data)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass an optional block of print dialog data, which will be copied to
	the printer object's local data.
	End Rem
	Method Create:wxPrinter(data:wxPrintDialogData = Null)
		If data Then
			wxObjectPtr = bmx_wxprinter_create(data.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxprinter_create(Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Creates the default printing abort window, with a cancel button.
	End Rem
	Method CreateAbortWindow(parent:wxWindow, printout:wxPrintout)
		bmx_wxprinter_createabortwindow(wxObjectPtr, parent.wxObjectPtr, printout.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the user has aborted the print job.
	End Rem
	Method GetAbort:Int()
		Return bmx_wxprinter_getabort(wxObjectPtr)
	End Method
		
	Rem
	bbdoc: Return last error.
	about: Valid after calling Print, PrintDialog or wxPrintPreview::Print. These functions set last error
	to wxPRINTER_NO_ERROR if no error happened.
	End Rem
	Function GetLastError:Int()
		Return bmx_wxprinter_getlasterror()
	End Function
	
	Rem
	bbdoc: Returns the print data associated with the printer object.
	End Rem
	Method GetPrintDialogData:wxPrintDialogData()
		Return wxPrintDialogData._create(bmx_wxprinter_getprintdialogdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Starts the printing process.
	about: Provide a parent window, a user-defined wxPrintout object which controls the printing of a document,
	and whether the print dialog should be invoked first.
	<p>
	Print could return false if there was a problem initializing the printer device context (current printer not
	set, for example) or the user cancelled printing. Call wxPrinter::GetLastError to get detailed information
	about the kind of the error.
	</p>
	End Rem
	Method Print:Int(parent:wxWindow, printout:wxPrintout, prompt:Int = True)
		Return bmx_wxprinter_print(wxObjectPtr, parent.wxObjectPtr, printout.wxObjectPtr, prompt)
	End Method
	
	Rem
	bbdoc: Invokes the print dialog.
	about: If successful (the user did not press Cancel and no error occurred), a suitable device context will
	be returned (otherwise NULL is returned -- call wxPrinter::GetLastError to get detailed information about
	the kind of the error).
	<p>
	The application <b>must</b> Free() this device context to avoid a memory leak.
	</p>
	End Rem
	Method PrintDialog:wxDC(parent:wxWindow)
		Return wxDC._create(bmx_wxprinter_printdialog(wxObjectPtr, parent.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Default error-reporting method.
	End Rem
	Method ReportError(parent:wxWindow, printout:wxPrintout, message:String)
		bmx_wxprinter_reporterror(wxObjectPtr, parent.wxObjectPtr, printout.wxObjectPtr, message)
	End Method
	
	Rem
	bbdoc: Invokes the print setup dialog.
	about: Note that the setup dialog is obsolete from Windows 95, though retained for backward compatibility.
	End Rem
	Method Setup(parent:wxWindow)
		bmx_wxprinter_setup(wxObjectPtr, parent.wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxprinter_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type
