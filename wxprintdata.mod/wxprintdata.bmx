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
bbdoc: wxPrintData
End Rem
Module wx.wxPrintData

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
bbdoc: This type holds a variety of information related to printers and printer device contexts.
about: It is used to create a wxPrinterDC and a wxPostScriptDC. It is also used as a data member of
wxPrintDialogData and wxPageSetupDialogData, as part of the mechanism for transferring data between the
print dialogs and the application.
End Rem
Type wxPrintData Extends wxObject

	Method GetCollate:Int()
	End Method
	
	Method GetBin:Int()
	End Method
	
	Method GetColour:Int()
	End Method
	
	Method GetDuplex:Int()
	End Method
	
	Method GetNoCopies:Int()
	End Method
	
	Method GetOrientation:Int()
	End Method
	
	Method GetPaperId:Int()
	End Method
	
	Method GetPrinterName:String()
	End Method
	
	Method GetQuality:Int()
	End Method
	
	Method IsOk:Int()
	End Method
	
	Method SetBin(flag:Int)
	End Method
	
	Method SetCollate(flag:Int)
	End Method
	
	Method SetColour(flag:Int)
	End Method
	
	Method SetDuplex(mode:Int)
	End Method
	
	Method SetNoCopies(n:Int)
	End Method
	
	Method SetOrientation(orientation:Int)
	End Method
	
	Method SetPaperId(paperId:Int)
	End Method
	
	Method SetPrinterName(name:String)
	End Method
	
	Method SetQuality(quality:Int)
	End Method

End Type

