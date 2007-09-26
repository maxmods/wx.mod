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
bbdoc: wxFileDialog
End Rem
Module wx.wxFileDialog

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
bbdoc: This type represents the file chooser dialog.
End Rem
Type wxFileDialog Extends wxDialog
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

