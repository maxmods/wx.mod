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
bbdoc: wxDirDialog
End Rem
Module wx.wxDirDialog

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
bbdoc: This type represents the directory chooser dialog.
about:
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxDD_DEFAULT_STYLE </td><td>Equivalent to a combination of wxDEFAULT_DIALOG_STYLE and wxRESIZE_BORDER. </td></tr>
<tr><td>wxDD_DIR_MUST_EXIST </td><td>The dialog will allow the user to choose only an existing folder. When this style is not given,
a "Create new directory" button is added to the dialog (on Windows) or some other way is provided to the user to type the name
of a new folder. </td></tr>
<tr><td>wxDD_CHANGE_DIR </td><td>Change the current working directory to the directory chosen by the user. </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p>
NB: on Windows the new directory button is only available with recent versions of the common dialogs.
</p>
End Rem
Type wxDirDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Use wxDirDialog::ShowModal to show the dialog.
	controls.
	End Rem
	Function CreateDirDialog:wxDirDialog(parent:wxWindow, message:String = "Choose a directory", defaultPath:String = "", ..
			style:Int = wxDD_DEFAULT_STYLE, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		Return New wxDirDialog.Create(parent, message, defaultPath, style, x, y, w, h)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Use wxDirDialog::ShowModal to show the dialog.
	controls.
	End Rem
	Method Create:wxDirDialog(parent:wxWindow, message:String = "Choose a directory", defaultPath:String = "", ..
			style:Int = wxDD_DEFAULT_STYLE, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxdirdialog_create(Self, parent.wxObjectPtr, message, defaultPath, style, x, y, w, h)
		Else
			wxObjectPtr = bmx_wxdirdialog_create(Self, Null, message, defaultPath, style, x, y, w, h)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the default or user-selected path.
	End Rem
	Method GetPath:String()
		Return bmx_wxdirdialog_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the message that will be displayed on the dialog.
	End Rem
	Method GetMessage:String()
		Return bmx_wxdirdialog_getmessage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the message that will be displayed on the dialog.
	End Rem
	Method SetMessage(message:String)
		bmx_wxdirdialog_setmessage(wxObjectPtr, message)
	End Method
	
	Rem
	bbdoc: Sets the default path.
	End Rem
	Method SetPath(path:String)
		bmx_wxdirdialog_setpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxdirdialog_showmodal(wxObjectPtr)
	End Method
	
End Type


Rem
bbdoc: Pops up a directory selector dialog.
about: The arguments have the same meaning as those of wxDirDialog::wxDirDialog(). The message is displayed at the
top, and the default_path, if specified, is set as the initial selection.
<p>
The application must check for an empty return value (if the user pressed Cancel)
</p>
End Rem
Function wxDirSelector:String(message:String = wxDirSelectorPromptStr, defaultPath:String = "", style:Int = 0, ..
		x:Int = -1, y:Int = -1, parent:wxWindow = Null)
		
	If parent Then
		Return bmx_wxdirselector(message, defaultPath, style, x, y, parent.wxObjectPtr)
	Else
		Return bmx_wxdirselector(message, defaultPath, style, x, y, Null)
	End If
		
End Function

