' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxOwnerDrawnComboBox
End Rem
Module wx.wxOwnerDrawnComboBox

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: 
End Rem
Type wxOwnerDrawnComboBox Extends wxControlWithItems

	Function _create:wxOwnerDrawnComboBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxOwnerDrawnComboBox = New wxOwnerDrawnComboBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxOwnerDrawnComboBox(wxObjectPtr:Byte Ptr)
		Return wxOwnerDrawnComboBox._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateOwnerDrawnComboBox:wxOwnerDrawnComboBox(parent:wxWindow, id:Int, value:String = Null, choices:String[] = Null, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxOwnerDrawnComboBox.Create(parent, id, value, choices, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxOwnerDrawnComboBox(parent:wxWindow, id:Int, value:String = Null, choices:String[] = Null, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxownerdrawncombobox_create(Self, parent.wxObjectPtr, id, value, choices, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

End Type

Type TOwnerDrawnComboBoxResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxownerdrawncombobox_addresourcehandler()
	End Method
		
End Type

New TOwnerDrawnComboBoxResourceFactory
