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

	Rem
	bbdoc: 
	End Rem
	Function CreatePageSetupDialogData:wxPageSetupDialogData(printData:wxPrintData = Null)
		Return New wxPageSetupDialogData.Create(printData)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPageSetupDialogData(printData:wxPrintData = Null)
		If printData Then
			wxObjectPtr = bmx_wxpagesetupdialogdata_create(printData.wxObjectptr)
		Else
			wxObjectPtr = bmx_wxpagesetupdialogdata_create(Null)
		End If
		Return Self
	End Method

	' soft linking
	Function _create:wxPageSetupDialogData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPageSetupDialogData = New wxPageSetupDialogData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Enables or disables the 'Help' button (Windows only).
	End Rem
	Method EnableHelp(flag:Int)
		bmx_wxpagesetupdialogdata_enablehelp(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the margin controls (Windows only).
	End Rem
	Method EnableMargins(flag:Int)
		bmx_wxpagesetupdialogdata_enablemargins(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the orientation control (Windows only).
	End Rem
	Method EnableOrientation(flag:Int)
		bmx_wxpagesetupdialogdata_enableorientation(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the paper size control (Windows only).
	End Rem
	Method EnablePaper(flag:Int)
		bmx_wxpagesetupdialogdata_enablepaper(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Enables or disables the @Printer button, which invokes a printer setup dialog.
	End Rem
	Method EnablePrinter(flag:Int)
		bmx_wxpagesetupdialogdata_enableprinter(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Returns true if the page setup dialog will take its minimum margin values from the currently selected printer properties (Windows only).
	End Rem
	Method GetDefaultMinMargins:Int()
		Return bmx_wxpagesetupdialogdata_getdefaultminmargins(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the margin controls are enabled (Windows only).
	End Rem
	Method GetEnableMargins:Int()
		Return bmx_wxpagesetupdialogdata_getenablemargins(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the orientation control is enabled (Windows only).
	End Rem
	Method GetEnableOrientation:Int()
		Return bmx_wxpagesetupdialogdata_getenableorientation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the paper size control is enabled (Windows only).
	End Rem
	Method GetEnablePaper:Int()
		Return bmx_wxpagesetupdialogdata_getenablepaper(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the printer setup button is enabled.
	End Rem
	Method GetEnablePrinter:Int()
		Return bmx_wxpagesetupdialogdata_getenableprinter(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the printer setup button is enabled.
	End Rem
	Method GetEnableHelp:Int()
		Return bmx_wxpagesetupdialogdata_getenablehelp(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the dialog will simply return default printer information (such as orientation) instead of showing a dialog (Windows only).
	End Rem
	Method GetDefaultInfo:Int()
		Return bmx_wxpagesetupdialogdata_getdefaultinfo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the left and top margins in millimetres.
	End Rem
	Method GetMarginTopLeft(leftMargin:Int Var, topMargin:Int Var)
		bmx_wxpagesetupdialogdata_getmargintopleft(wxObjectPtr, Varptr leftMargin, Varptr topMargin)
	End Method
	
	Rem
	bbdoc: Returns the right and bottom margins in millimetres.
	End Rem
	Method GetMarginBottomRight(rightMargin:Int Var, bottomMargin:Int Var)
		bmx_wxpagesetupdialogdata_getmarginbottomright(wxObjectPtr, Varptr rightMargin, Varptr bottomMargin)
	End Method
	
	Rem
	bbdoc: Returns the left and top minimum margins the user can enter (Windows only).
	about: Units are in millimetres
	End Rem
	Method GetMinMarginTopLeft(leftMin:Int Var, topMin:Int Var)
		bmx_wxpagesetupdialogdata_getminmargintopleft(wxObjectPtr, Varptr leftMin, Varptr topMin)
	End Method
	
	Rem
	bbdoc: Returns the right and bottom minimum margins the user can enter (Windows only).
	about: Units are in millimetres
	End Rem
	Method GetMinMarginBottomRight(rightMin:Int Var, bottomMin:Int Var)
		bmx_wxpagesetupdialogdata_getminmarginbottomright(wxObjectPtr, Varptr rightMin, Varptr bottomMin)
	End Method
	
	Rem
	bbdoc: Returns the paper id (stored in the internal wxPrintData object).
	End Rem
	Method GetPaperId:Int()
		Return bmx_wxpagesetupdialogdata_getpaperid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the paper size in millimetres.
	End Rem
	Method GetPaperSize(w:Int Var, h:Int Var)
		bmx_wxpagesetupdialogdata_getpapersize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns a reference to the print data associated with this object.
	End Rem
	Method GetPrintData:wxPrintData()
		Return wxPrintData._create(bmx_wxpagesetupdialogdata_getprintdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns true if the print data associated with the dialog data is valid.
	about: This can return false on Windows if the current printer is not set, for example. On all
	other platforms, it returns true.
	End Rem
	Method IsOk:Int()
		Return bmx_wxpagesetupdialogdata_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Pass true if the dialog will simply return default printer information (such as orientation) instead of showing a dialog (Windows only).
	End Rem
	Method SetDefaultInfo(flag:Int)
		bmx_wxpagesetupdialogdata_setdefaultinfo(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Pass true if the page setup dialog will take its minimum margin values from the currently selected printer properties (Windows only).
	about: Units are in millimetres
	End Rem
	Method SetDefaultMinMargins(flag:Int)
		bmx_wxpagesetupdialogdata_setdefaultminmargins(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the left and top margins in millimetres.
	End Rem
	Method SetMarginTopLeft(leftMargin:Int, topMargin:Int)
		bmx_wxpagesetupdialogdata_setmargintopleft(wxObjectPtr, leftMargin, topMargin)
	End Method
	
	Rem
	bbdoc: Sets the right and bottom margins in millimetres.
	End Rem
	Method SetMarginBottomRight(rightMargin:Int, bottomMargin:Int)
		bmx_wxpagesetupdialogdata_setmarginbottomright(wxObjectPtr, rightMargin, bottomMargin)
	End Method
	
	Rem
	bbdoc: Sets the left and top minimum margins the user can enter (Windows only).
	about: Units are in millimetres.
	End Rem
	Method SetMinMarginTopLeft(leftMin:Int, topMin:Int)
		bmx_wxpagesetupdialogdata_setminmargintopleft(wxObjectPtr, leftMin, topMin)
	End Method
	
	Rem
	bbdoc: Sets the right and bottom minimum margins the user can enter (Windows only).
	about: Units are in millimetres.
	End Rem
	Method SetMinMarginBottomRight(rightMin:Int, bottomMin:Int)
		bmx_wxpagesetupdialogdata_setminmarginbottomright(wxObjectPtr, rightMin, bottomMin)
	End Method
	
	Rem
	bbdoc: Sets the paper size id.
	about: For further information, see wxPrintData::SetPaperId.
	<p>
	Calling this method overrides the explicit paper dimensions passed in SetPaperSize.
	</p>
	End Rem
	Method SetPaperId(id:Int)
		bmx_wxpagesetupdialogdata_setpaperid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Sets the paper size in millimetres.
	about: If a corresponding paper id is found, it will be set in the internal wxPrintData object, 
	otherwise the paper size overrides the paper id.
	End Rem
	Method SetPaperSize(w:Int, h:Int)
		bmx_wxpagesetupdialogdata_setpapersize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Sets the print data associated with this object.
	End Rem
	Method SetPrintData(printData:wxPrintData)
		bmx_wxpagesetupdialogdata_setprintdata(wxObjectPtr, printData.wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpagesetupdialogdata_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

