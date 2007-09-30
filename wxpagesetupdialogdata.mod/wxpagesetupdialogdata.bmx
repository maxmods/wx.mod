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
bbdoc: wxPageSetupDialogData
End Rem
Module wx.wxPageSetupDialogData

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
bbdoc: This type holds a variety of information related to wxPageSetupDialog.
about: It contains a wxPrintData member which is used to hold basic printer configuration data
(as opposed to the user-interface configuration settings stored by wxPageSetupDialogData).
End Rem
Type wxPageSetupDialogData Extends wxObject

	Method EnableHelp(flag:Int)
	End Method
	
	Method EnableMargins(flag:Int)
	End Method
	
	Method EnableOrientation(flag:Int)
	End Method
	
	Method EnablePaper(flag:Int)
	End Method
	
	Method EnablePrinter(flag:Int)
	End Method
	
	Method GetDefaultMinMargins:Int()
	End Method
	
	Method GetEnableMargins:Int()
	End Method
	
	Method GetEnableOrientation:Int()
	End Method
	
	Method GetEnablePaper:Int()
	End Method
	
	Method GetEnablePrinter:Int()
	End Method
	
	Method GetEnableHelp:Int()
	End Method
	
	Method GetDefaultInfo:Int()
	End Method
	
	Method GetMarginTopLeft(leftMargin:Int Var, topMargin:Int Var)
	End Method
	
	Method GetMarginBottomRight(rightMargin:Int Var, bottomMargin:Int Var)
	End Method
	
	Method GetMinMarginTopLeft(leftMin:Int Var, topMin:Int Var)
	End Method
	
	Method GetMinMarginBottomRight(rightMin:Int Var, bottomMin:Int Var)
	End Method
	
	Method GetPaperId:Int()
	End Method
	
	Method GetPaperSize(w:Int Var, h:Int Var)
	End Method
	
	Method GetPrintData:wxPrintData()
	End Method
	
	Method IsOk:Int()
	End Method
	
	Method SetDefaultInfo(flag:Int)
	End Method
	
	Method SetDefaultMinMargins(flag:Int)
	End Method
	
	Method SetMarginTopLeft(leftMargin:Int, topMargin:Int)
	End Method
	
	Method SetMarginBottomRight(rightMargin:Int, bottomMargin:Int)
	End Method
	
	Method SetMinMarginTopLeft(leftMin:Int, topMin:Int)
	End Method
	
	Method SetMinMarginBottomRight(rightMin:Int, bottomMin:Int)
	End Method
	
	Method SetPaperId(id:Int)
	End Method
	
	Method SetPaperSize(w:Int, y:Int)
	End Method
	
	Method SetPrintData(printData:wxPrintData)
	End Method

End Type

