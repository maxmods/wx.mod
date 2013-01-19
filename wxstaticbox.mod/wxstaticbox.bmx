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
bbdoc: wxStaticBox
End Rem
Module wx.wxStaticBox

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
bbdoc: A static box is a rectangle drawn around other panel items to denote a logical grouping of items.
about: Please note that a static box should <b>not</b> be used as the parent for the controls it contains,
instead they should be siblings of each other. Although using a static box as a parent might work
in some versions of wxWidgets, it results in a crash under, for example, wxGTK.
<p>
Also, please note that because of this, the order in which you create new controls is important.
Create your wxStaticBox control <b>before</b> any siblings that are to appear inside the wxStaticBox
in order to preserve the correct Z-Order of controls.
</p>
End Rem
Type wxStaticBox Extends wxControl

	' soft linking
	Function _create:wxStaticBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxStaticBox = New wxStaticBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxStaticBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxStaticBox = wxStaticBox(wxfind(wxObjectPtr))
			If Not window Then
				Return wxStaticBox._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Function _xrcNew:wxStaticBox(wxObjectPtr:Byte Ptr)
		Return wxStaticBox._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a static box.
	End Rem
	Function CreateStaticBox:wxStaticBox(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		Return New wxStaticBox.Create(parent, id, label, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateStaticBox.
	End Rem
	Method Create:wxStaticBox(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxstaticbox_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

End Type


Type TStaticBoxResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxstaticbox_addresourcehandler()
	End Method
		
End Type

New TStaticBoxResourceFactory
