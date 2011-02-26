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
bbdoc: wxFileDialog
End Rem
Module wx.wxFileDialog

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
bbdoc: This type represents the file chooser dialog.
about: In Windows, this is the common file selector dialog. In X, this is a file selector box with the same
functionality. The path and filename are distinct elements of a full file pathname. If path is empty, the current
directory will be used. If filename is empty, no default filename will be supplied. The wildcard determines what
files are displayed in the file selector, and file extension supplies a type extension for the required filename.
Flags may be a combination of wxFD_OPEN, wxFD_SAVE, wxFD_OVERWRITE_PROMPT or wxFD_FILE_MUST_EXIST. Note that wxFD_MULTIPLE can only
be used with wxFileDialog and not here as this function only returns a single file name.
<p>
Both the Unix and Windows versions implement a wildcard filter. Typing a filename containing wildcards
(*, ?) in the filename text item, and clicking on Ok, will result in only those files matching the pattern being
displayed.
</p>
<p>
The wildcard may be a specification for multiple types of file with a description for each, such as:
<pre>"BMP files (*.bmp)|*.bmp|GIF files (*.gif)|*.gif"</pre>
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxFD_DEFAULT_STYLE </td><td>Equivalent to wxFD_OPEN. </td></tr>
<tr><td>wxFD_OPEN </td><td>This is an open dialog; usually this means that the default button's label of the dialog is "Open".
Cannot be combined with wxFD_SAVE. </td></tr>
<tr><td>wxFD_SAVE </td><td>This is a save dialog; usually this means that the default button's label of the dialog is "Save".
Cannot be combined with wxFD_OPEN. </td></tr>
<tr><td>wxFD_OVERWRITE_PROMPT </td><td>For save dialog only: prompt for a confirmation if a file will be overwritten. </td></tr>
<tr><td>wxFD_FILE_MUST_EXIST </td><td>For open dialog only: the user may only select files that actually exist. </td></tr>
<tr><td>wxFD_MULTIPLE </td><td>For open dialog only: allows selecting multiple files. </td></tr>
<tr><td>wxFD_CHANGE_DIR </td><td>Change the current working directory to the directory where the file(s) chosen by the user are. </td></tr>
<tr><td>wxFD_PREVIEW </td><td>Show the preview of the selected files (currently only supported by wxGTK using GTK+ 2.4 or later). </td></tr>
</table>
</p>
<p>
See also <a href="../../wxwindow.mod/doc/commands.html#wxWindow">wxWindow</a> styles.
</p>
<p>
NB: Previous versions of wxWidgets used wxFD_CHANGE_DIR by default under MS Windows which allowed the program to simply remember the
last directory where user selected the files to open/save. This (desired) functionality must be implemented in the program itself now
(manually remember the last path used and pass it to the dialog the next time it is called) or by using this flag.
</p>
End Rem
Type wxFileDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Use wxFileDialog::ShowModal to show the dialog.
	controls.
	End Rem
	Function CreateFileDialog:wxFileDialog(parent:wxWindow, message:String = "Choose a file", defaultDir:String = "", ..
			defaultFile:String = "", wildcard:String = "*.*", style:Int = wxFD_DEFAULT_STYLE, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		Return New wxFileDialog.Create(parent, message, defaultDir, defaultFile, wildcard, style, x, y, w, h)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Use wxFileDialog::ShowModal to show the dialog.
	controls.
	End Rem
	Method Create:wxFileDialog(parent:wxWindow, message:String = "Choose a file", defaultDir:String = "", ..
			defaultFile:String = "", wildcard:String = "*.*", style:Int = wxFD_DEFAULT_STYLE, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxfiledialog_create(Self, parent.wxObjectPtr, message, defaultDir, defaultFile, wildcard, style, x, y, w, h)
		Else
			wxObjectPtr = bmx_wxfiledialog_create(Self, Null, message, defaultDir, defaultFile, wildcard, style, x, y, w, h)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the default directory.
	End Rem
	Method GetDirectory:String()
		Return bmx_wxfiledialog_getdirectory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the default filename.
	End Rem
	Method GetFilename:String()
		Return bmx_wxfiledialog_getfilename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array with the names of the files chosen.
	about: This method should only be used with the dialogs which have wxFD_MULTIPLE style, use
	GetFilename for the others.
	<p>
	Note that under Windows, if the user selects shortcuts, the filenames include paths, since
	the application cannot determine the full path of each referenced file by appending the
	directory containing the shortcuts to the filename.
	</p>
	End Rem
	Method GetFilenames:String[]()
		Return bmx_wxfiledialog_getfilenames(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index into the list of filters supplied, optionally, in the wildcard parameter.
	about: Before the dialog is shown, this is the index which will be used when the dialog is
	first displayed. After the dialog is shown, this is the index selected by the user.
	End Rem
	Method GetFilterIndex:Int()
		Return bmx_wxfiledialog_getfilterindex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the message that will be displayed on the dialog.
	End Rem
	Method GetMessage:String()
		Return bmx_wxfiledialog_getmessage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the full path (directory and filename) of the selected file.
	End Rem
	Method GetPath:String()
		Return bmx_wxfiledialog_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array with the full paths of the files chosen.
	about: This method should only be used with the dialogs which have wxFD_MULTIPLE style, use
	GetPath for the others.
	End Rem
	Method GetPaths:String[]()
		Return bmx_wxfiledialog_getpaths(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the file dialog wildcard.
	End Rem
	Method GetWildcard:String()
		Return bmx_wxfiledialog_getwildcard(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default directory.
	End Rem
	Method SetDirectory(directory:String)
		bmx_wxfiledialog_setdirectory(wxObjectPtr, directory)
	End Method
	
	Rem
	bbdoc: Sets the default filename.
	End Rem
	Method SetFilename(filename:String)
		bmx_wxfiledialog_setfilename(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Sets the default filter index, starting from zero.
	End Rem
	Method SetFilterIndex(index:Int)
		bmx_wxfiledialog_setfilterindex(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Sets the message that will be displayed on the dialog.
	End Rem
	Method SetMessage(message:String)
		bmx_wxfiledialog_setmessage(wxObjectPtr, message)
	End Method
	
	Rem
	bbdoc: Sets the path (the combined directory and filename that will be returned when the dialog is dismissed).
	End Rem
	Method SetPath(path:String)
		bmx_wxfiledialog_setpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets the wildcard, which can contain multiple file types
	about: For example:
	<pre>
	"BMP files (*.bmp)|*.bmp|GIF files (*.gif)|*.gif"
	</pre>
	End Rem
	Method SetWildcard(wildcard:String)
		bmx_wxfiledialog_setwildcard(wxObjectPtr, wildcard)
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxfiledialog_showmodal(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: Pops up a file selector box.
about: In Windows, this is the common file selector dialog. In X, this is a file selector box with the same
functionality. The path and filename are distinct elements of a full file pathname. If path is empty, the current
directory will be used. If filename is empty, no default filename will be supplied. The wildcard determines what
files are displayed in the file selector, and file extension supplies a type extension for the required filename.
Flags may be a combination of wxFD_OPEN, wxFD_SAVE, wxFD_OVERWRITE_PROMPT or wxFD_FILE_MUST_EXIST. Note that wxFD_MULTIPLE can only
be used with wxFileDialog and not here as this function only returns a single file name.
<p>
Both the Unix and Windows versions implement a wildcard filter. Typing a filename containing wildcards
(*, ?) in the filename text item, and clicking on Ok, will result in only those files matching the pattern being
displayed.
</p>
<p>
The wildcard may be a specification for multiple types of file with a description for each, such as:
<pre>"BMP files (*.bmp)|*.bmp|GIF files (*.gif)|*.gif"</pre>
</p>
End Rem
Function wxFileSelector:String(message:String, defaultPath:String = "", defaultFilename:String = "", ..
		defaultExtension:String = "", wildcard:String = "*.*", flags:Int = 0, parent:wxWindow = Null, x:Int = -1, y:Int = -1)
		
	If parent Then
		Return bmx_wxfileselector(message, defaultPath, defaultFilename, defaultExtension, wildcard, flags,  parent.wxObjectPtr, x, y)
	Else
		Return bmx_wxfileselector(message, defaultPath, defaultFilename, defaultExtension, wildcard, flags,  Null, x, y)
	End If

End Function

