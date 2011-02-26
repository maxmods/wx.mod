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
bbdoc: wxPrintData
End Rem
Module wx.wxPrintData

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
bbdoc: This type holds a variety of information related to printers and printer device contexts.
about: It is used to create a wxPrinterDC and a wxPostScriptDC. It is also used as a data member of
wxPrintDialogData and wxPageSetupDialogData, as part of the mechanism for transferring data between the
print dialogs and the application.
End Rem
Type wxPrintData Extends wxObject

	Function _create:wxPrintData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPrintData = New wxPrintData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates a new wxPrintData object.
	End Rem
	Function CreatePrintData:wxPrintData()
		Return New wxPrintData.Create()
	End Function
	
	Rem
	bbdoc: Default Constructor.
	End Rem
	Method Create:wxPrintData()
		wxObjectPtr = bmx_wxprintdata_create()
		Return Self
	End Method

	Rem
	bbdoc: Returns true if collation is on.
	End Rem
	Method GetCollate:Int()
		Return bmx_wxprintdata_getcollate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current bin (papersource).
	about: By default, the system is left to select the bin (wxPRINTBIN_DEFAULT is returned).
	<p>
	See SetBin() for the full list of bin values.
	</p>
	End Rem
	Method GetBin:Int()
		Return bmx_wxprintdata_getbin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if colour printing is on.
	End Rem
	Method GetColour:Int()
		Return bmx_wxprintdata_getcolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the duplex mode.
	about: One of @wxDUPLEX_SIMPLEX, @wxDUPLEX_HORIZONTAL, @wxDUPLEX_VERTICAL.
	End Rem
	Method GetDuplex:Int()
		Return bmx_wxprintdata_getduplex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of copies requested by the user.
	End Rem
	Method GetNoCopies:Int()
		Return bmx_wxprintdata_getnocopies(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the orientation.
	about: This can be @wxLANDSCAPE or @wxPORTRAIT.
	End Rem
	Method GetOrientation:Int()
		Return bmx_wxprintdata_getorientation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the paper size id.
	about: For more information, see wxPrintData::SetPaperId.
	End Rem
	Method GetPaperId:Int()
		Return bmx_wxprintdata_getpaperid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the printer name.
	about: If the printer name is the empty string, it indicates that the default printer
	should be used.
	End Rem
	Method GetPrinterName:String()
		Return bmx_wxprintdata_getprintername(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current print quality.
	about: This can be a positive integer, denoting the number of dots per inch, or one of the
	following identifiers:
	<ul>
	<li>wxPRINT_QUALITY_HIGH </li>
	<li>wxPRINT_QUALITY_MEDIUM </li>
	<li>wxPRINT_QUALITY_LOW </li>
	<li>wxPRINT_QUALITY_DRAFT </li>
	</ul>
	On input you should pass one of these identifiers, but on return you may get back a positive
	integer indicating the current resolution setting.
	End Rem
	Method GetQuality:Int()
		Return bmx_wxprintdata_getquality(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the print data is valid for using in print dialogs.
	about: This can return False on Windows if the current printer is not set, for example. On
	all other platforms, it returns True.
	End Rem
	Method IsOk:Int()
		Return bmx_wxprintdata_getisok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the current bin.
	about: Possible values are:
	<ul>
	<li>wxPRINTBIN_DEFAULT</li>
	<li>wxPRINTBIN_ONLYONE</li>
	<li>wxPRINTBIN_LOWER</li>
	<li>wxPRINTBIN_MIDDLE</li>
	<li>wxPRINTBIN_MANUAL</li>
	<li>wxPRINTBIN_ENVELOPE</li>
	<li>wxPRINTBIN_ENVMANUAL</li>
	<li>wxPRINTBIN_AUTO</li>
	<li>wxPRINTBIN_TRACTOR</li>
	<li>wxPRINTBIN_SMALLFMT</li>
	<li>wxPRINTBIN_LARGEFMT</li>
	<li>wxPRINTBIN_LARGECAPACITY</li>
	<li>wxPRINTBIN_CASSETTE</li>
	<li>wxPRINTBIN_FORMSOURCE</li>
	<li>wxPRINTBIN_USER</li>
	</ul>
	End Rem
	Method SetBin(flag:Int)
		bmx_wxprintdata_setbin(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets collation to on or off.
	End Rem
	Method SetCollate(flag:Int)
		bmx_wxprintdata_setcollate(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets colour printing on or off.
	End Rem
	Method SetColour(flag:Int)
		bmx_wxprintdata_setcolour(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the duplex mode.
	about: One of @wxDUPLEX_SIMPLEX, @wxDUPLEX_HORIZONTAL, @wxDUPLEX_VERTICAL.
	End Rem
	Method SetDuplex(mode:Int)
		bmx_wxprintdata_setduplex(wxObjectPtr, mode)
	End Method
	
	Rem
	bbdoc: Sets the default number of copies to be printed out.
	End Rem
	Method SetNoCopies(n:Int)
		bmx_wxprintdata_setnocopies(wxObjectPtr, n)
	End Method
	
	Rem
	bbdoc: Sets the orientation.
	about: This can be @wxLANDSCAPE or @wxPORTRAIT.
	End Rem
	Method SetOrientation(orientation:Int)
		bmx_wxprintdata_setorientation(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: Sets the paper id.
	about: This indicates the type of paper to be used.
	End Rem
	Method SetPaperId(paperId:Int)
		bmx_wxprintdata_setpaperid(wxObjectPtr, paperId)
	End Method
	
	Rem
	bbdoc: Sets the printer name.
	about: This can be the empty string to indicate that the default printer should be used.
	End Rem
	Method SetPrinterName(name:String)
		bmx_wxprintdata_setprintername(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Sets the desired print quality.
	about: This can be a positive integer, denoting the number of dots per inch, or one of the
	following identifiers:
	<ul>
	<li>wxPRINT_QUALITY_HIGH</li>
	<li>wxPRINT_QUALITY_MEDIUM</li>
	<li>wxPRINT_QUALITY_LOW</li>
	<li>wxPRINT_QUALITY_DRAFT</li>
	</ul>
	On input you should pass one of these identifiers, but on return you may get back a positive
	integer indicating the current resolution setting.
	End Rem
	Method SetQuality(quality:Int)
		bmx_wxprintdata_setquality(wxObjectPtr, quality)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxprintdata_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

