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

Module wx.wxPageSetupDialog

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
bbdoc: This type represents the page setup common dialog.
about: In MSW, the page setup dialog is standard from Windows 95 on, replacing the print setup dialog
(which is retained in Windows and wxWidgets for backward compatibility). On Windows 95 and NT 4.0
and above, the page setup dialog is native to the windowing system, otherwise it is emulated.
<p>
The page setup dialog contains controls for paper size (A4, A5 etc.), orientation (landscape or
portrait), and controls for setting left, top, right and bottom margin sizes in millimetres.
</p>
<p>
On Macintosh, the native page setup dialog is used, which lets you select paper size and orientation
but it does not let you change the page margins.
</p>
<p>
On other platforms, a generic dialog is used.
</p>
<p>
When the dialog has been closed, you need to query the wxPageSetupDialogData object associated with
the dialog.
</p>
<p>
Note that the OK and Cancel buttons do not destroy the dialog; this must be done by the application.
</p>
End Rem
Type wxPageSetupDialog Extends wxDialog

	Rem
	bbdoc: 
	End Rem
	Function CreatePageSetupDialog:wxPageSetupDialog(parent:wxWindow, data:wxPageSetupDialogData = Null)
		Return New wxPageSetupDialog.Create(parent, data)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPageSetupDialog(parent:wxWindow, data:wxPageSetupDialogData = Null)
		If data Then
			wxObjectPtr = bmx_wxpagesetupdialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxpagesetupdialog_create(Self, parent.wxObjectPtr, Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Returns the page setup data associated with the dialog.
	End Rem
	Method GetPageSetupData:wxPageSetupDialogData()
		Return wxPageSetupDialogData._create(bmx_wxpagesetupdialog_getpagesetupdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxpagesetupdialog_showmodal(wxObjectPtr)
	End Method

End Type

