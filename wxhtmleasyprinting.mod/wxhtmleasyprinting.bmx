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
			If parent Then
				globalInstancePtr = bmx_wxhtmleasyprinting_create(name, parent.wxObjectPtr)
			Else
				globalInstancePtr = bmx_wxhtmleasyprinting_create(name, Null)
			End If
			wxObjectPtr = globalInstancePtr
		Else
			wxObjectPtr = globalInstancePtr
			If parent Then
				SetParentWindow(parent)
			End If
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Preview HTML file.
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PreviewFile:Int(htmlFile:String)
		Return bmx_wxhtmleasyprinting_previewfile(wxObjectPtr, htmlFile)
	End Method
	
	Rem
	bbdoc: Preview HTML text (not file!). 
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PreviewText:Int(htmlText:String, basePath:String = "")
		Return bmx_wxhtmleasyprinting_previewtext(wxObjectPtr, htmlText, basePath)
	End Method
	
	Rem
	bbdoc: Print HTML file
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PrintFile:Int(htmlFile:String)
		Return bmx_wxhtmleasyprinting_printfile(wxObjectPtr, htmlFile)
	End Method
	
	Rem
	bbdoc: Print HTML text (not file!).
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	End Rem
	Method PrintText:Int(htmlText:String, basePath:String = "")
		Return bmx_wxhtmleasyprinting_printtext(wxObjectPtr, htmlText, basePath)
	End Method
	
	Rem
	bbdoc: Display page setup dialog and allows the user to modify settings. 
	End Rem
	Method PageSetup()
		bmx_wxhtmleasyprinting_pagesetup(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets fonts.
	about: See wxHtmlWindow::SetFonts for detailed description.
	End Rem
	Method SetFonts(normalFace:String, fixedFace:String, sizes:Int[] = Null)
		If sizes Then
			Assert sizes.length = 7, "Sizes should contain 7 values"
		End If
		bmx_wxhtmleasyprinting_setfonts(wxObjectPtr, normalFace, fixedFace, sizes)
	End Method
	
	Rem
	bbdoc: Set page header.
	about: 
	The following macros can be used inside it: 
	<ul>
	<li>&#64;DATE&#64; is replaced by the current date in default format</li>
	<li>&#64;PAGENUM&#64; is replaced by page number </li>
	<li>&#64;PAGESCNT&#64; is replaced by total number of pages </li>
	<li>&#64;TIME&#64; is replaced by the current time in default format </li>
	<li>&#64;TITLE&#64; is replaced with the title of the document </li>
	</ul>
	End Rem
	Method SetHeader(header:String, page:Int = wxPAGE_ALL)
		bmx_wxhtmleasyprinting_setheader(wxObjectPtr, header, page)
	End Method
	
	Rem
	bbdoc: Set page footer.
	about: The following macros can be used inside it: 
	<ul>
	<li>&#64;DATE&#64; is replaced by the current date in default format </li>
	<li>&#64;PAGENUM&#64; is replaced by page number </li>
	<li>&#64;PAGESCNT&#64; is replaced by total number of pages </li>
	<li>&#64;TIME&#64; is replaced by the current time in default format </li>
	<li>&#64;TITLE&#64; is replaced with the title of the document </li>
	</ul>
	End Rem
	Method SetFooter(footer:String, page:Int = wxPAGE_ALL)
		bmx_wxhtmleasyprinting_setfooter(wxObjectPtr, footer, page)
	End Method
	
	Rem
	bbdoc: Returns the wxPrintData instance used by this type.
	about: You can set its parameters (via SetXXXX methods).
	End Rem
	Method GetPrintData:wxPrintData()
		Return wxPrintData._create(bmx_wxhtmleasyprinting_getprintdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns a the wxPageSetupDialogData instance used by this type.
	about: You can set its parameters (via SetXXXX methods).
	End Rem
	Method GetPageSetupData:wxPageSetupDialogData()
		Return wxPageSetupDialogData._create(bmx_wxhtmleasyprinting_getpagesetupdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the parent window for dialogs.
	End Rem
	Method SetParentWindow(parent:wxWindow)
		bmx_wxhtmleasyprinting_setparentwindow(wxObjectPtr, parent.wxObjectPtr)
	End Method
	
End Type

