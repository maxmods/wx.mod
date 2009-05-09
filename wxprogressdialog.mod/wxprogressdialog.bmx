' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxProgressDialog
End Rem
Module wx.wxProgressDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: This type represents a dialog that shows a short message and a progress bar.
about: Optionally, it can display ABORT and SKIP buttons, the elapsed, remaining and estimated
time for the end of the progress.
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxPD_APP_MODAL </td><td>Make the progress dialog modal. If this flag is not given, it is only "locally" modal - that is the
input to the parent window is disabled, but not to the other ones. </td></tr>
<tr><td>wxPD_AUTO_HIDE </td><td>Causes the progress dialog to disappear from screen as soon as the maximum value of the progress meter
has been reached. </td></tr>
<tr><td>wxPD_SMOOTH </td><td>Causes smooth progress of the gauge control. </td></tr>
<tr><td>wxPD_CAN_ABORT </td><td>This flag tells the dialog that it should have a "Cancel" button which the user may press. If this
happens, the next call to Update() will return false. </td></tr>
<tr><td>wxPD_CAN_SKIP </td><td>This flag tells the dialog that it should have a "Skip" button which the user may press. If this happens,
the next call to Update() will return true in its skip parameter. </td></tr>
<tr><td>wxPD_ELAPSED_TIME </td><td>This flag tells the dialog that it should show elapsed time (since creating the dialog). </td></tr>
<tr><td>wxPD_ESTIMATED_TIME </td><td>This flag tells the dialog that it should show estimated time. </td></tr>
<tr><td>wxPD_REMAINING_TIME </td><td>This flag tells the dialog that it should show remaining time. </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
End Rem
Type wxProgressDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Creates the dialog, displays it and disables user input for other windows, or,
	if wxPD_APP_MODAL flag is not given, for its parent window only.
	End Rem
	Function CreateProgressDialog:wxProgressDialog(title:String, message:String, maximum:Int = 100, ..
			parent:wxWindow = Null, style:Int = wxPD_AUTO_HIDE | wxPD_APP_MODAL)
		Return New wxProgressDialog.Create(title, message, maximum, parent, style)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Creates the dialog, displays it and disables user input for other windows, or,
	if wxPD_APP_MODAL flag is not given, for its parent window only.
	End Rem
	Method Create:wxProgressDialog(title:String, message:String, maximum:Int = 100, ..
			parent:wxWindow = Null, style:Int = wxPD_AUTO_HIDE | wxPD_APP_MODAL)
		If parent Then
			wxObjectPtr = bmx_wxprogressdialog_create(Self, title, message, maximum, parent.wxObjectPtr, style)
		Else
			wxObjectPtr = bmx_wxprogressdialog_create(Self, title, message, maximum, Null, style)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Can be used to continue with the dialog, after the user had chosen ABORT.
	End Rem
	Method Resume()
		bmx_wxprogressdialog_resume(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Updates the dialog, setting the progress bar to the new value and, if given changes the message above it.
	returns: True unless the Cancel button has been pressed.
	about: If false is returned, the application can either immediately destroy the dialog or
	ask the user for the confirmation and if the abort is not confirmed the dialog may be resumed
	with Resume method.
	End Rem
	Method UpdateProgress:Int(value:Int, newMessage:String = "", skip:Int Var)
		Return bmx_wxprogressdialog_updateprogress(wxObjectPtr, value, newMessage, Varptr skip)
	End Method
	
	Rem
	bbdoc: Just like Update but makes the gauge control run in indeterminate mode (see wxGauge documentation), sets the remaining and the estimated time labels (if present) to Unknown and moves the progress bar a bit to indicate that some progress was done.
	End Rem
	Method Pulse:Int(newMessage:String = "", skip:Int Var)
		Return bmx_wxprogressdialog_pulse(wxObjectPtr, newMessage, Varptr skip)
	End Method

End Type

