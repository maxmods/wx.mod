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
bbdoc: wxHtmlEasyPrinting
End Rem
Module wx.wxHtmlEasyPrinting

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
bbdoc: This type provides very simple interface to printing architecture.
about: It allows you to print HTML documents using only a few commands. 
End Rem
Type wxHtmlEasyPrinting Extends wxObject

	' only a single instance of wxHtmlEasyPrinting should exist, so we track it with this pointer
	Global globalInstancePtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Function CreateHtmlEasyPrinting:wxHtmlEasyPrinting(name:String = "Printing", parent:wxWindow = Null)
		Return New wxHtmlEasyPrinting.Create(name, parent)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxHtmlEasyPrinting(name:String = "Printing", parent:wxWindow = Null)
		If Not globalInstancePtr Then
			'globalInstancePtr = 
		End If
		wxObjectPtr = globalInstancePtr
		Return Self
	End Method
	
	Rem
	bbdoc: Preview HTML file.
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PreviewFile:Int(htmlFile:String)
	End Method
	
	Rem
	bbdoc: Preview HTML text (not file!). 
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PreviewText:Int(htmlText:String, basePath:String = "")
	End Method
	
	Rem
	bbdoc: Print HTML file
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PrintFile:Int(htmlFile:String)
	End Method
	
	Rem
	bbdoc: Print HTML text (not file!).
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PrintText:Int(htmlText:String, basePath:String = "")
	End Method
	
	Rem
	bbdoc: Display page setup dialog and allows the user to modify settings. 
	End Rem
	Method PageSetup()
	End Method
	
	Rem
	bbdoc: Sets fonts.
	about: See wxHtmlWindow::SetFonts for detailed description.
	End Rem
	Method SetFonts(normalFace:String, fixedFace:String, sizes:Int[] = Null)
	End Method
	
	Rem
	bbdoc: Set page header.
	End Rem
	Method SetHeader(header:String, page:Int = wxPAGE_ALL)
	End Method
	
	Rem
	bbdoc: Set page footer.
	End Rem
	Method SetFooter(footer:String, page:Int = wxPAGE_ALL)
	End Method
	
	Rem
	bbdoc: Returns the wxPrintData instance used by this type.
	about: You can set its parameters (via SetXXXX methods).
	End Rem
	Method GetPrintData:wxPrintData()
	End Method
	
	Rem
	bbdoc: Returns a the wxPageSetupDialogData instance used by this type.
	about: You can set its parameters (via SetXXXX methods).
	End Rem
	Method GetPageSetupData:wxPageSetupDialogData()
	End Method
	
End Type

