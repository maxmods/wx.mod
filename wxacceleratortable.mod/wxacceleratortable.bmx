' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: 
End Rem
Module wx.wxAcceleratorTable

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"


Rem
bbdoc: An accelerator table allows the application to specify a table of keyboard shortcuts for menus or other commands.
about: On Windows, menu or button commands are supported; on GTK, only menu commands are
supported.
<p>
The object wxNullAcceleratorTable is defined to be a table with no data, and is the initial
accelerator table for a window.
</p>
<p>
An accelerator takes precedence over normal processing and can be a convenient way to program
some event handling. For example, you can use an accelerator table to enable a dialog with
a multi-line text control to accept CTRL-Enter as meaning 'OK' (but not in GTK+ at present).
</p>
End Rem
Type wxAcceleratorTable Extends wxObject

	Function _create:wxAcceleratorTable(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxAcceleratorTable = New wxAcceleratorTable
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc:
	End Rem
	Function CreateAcceleratorTable:wxAcceleratorTable(entries:wxAcceleratorEntry[])
		Return New wxAcceleratorTable.Create(entries)
	End Function
	
	Rem
	bbdoc:
	End Rem
	Method Create:wxAcceleratorTable(entries:wxAcceleratorEntry[])
		wxObjectPtr = bmx_wxacceleratortable_create(entries)
		Return Self
	End Method
	
	Function _getEntry:Byte Ptr(entries:wxAcceleratorEntry[], index:Int)
		Return entries[index].wxAcceleratorPtr
	End Function

	Rem
	bbdoc:
	End Rem
	Method IsOk:Int()
		Return bmx_wxacceleratortable_isok(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxacceleratortable_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Extern
	Function bmx_wxacceleratortable_create:Byte Ptr(entries:wxAcceleratorEntry[])
End Extern
