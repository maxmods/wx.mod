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
bbdoc: wxRearrangeCtrl
End Rem
Module wx.wxRearrangeCtrl

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
bbdoc: A composite control containing a wxRearrangeList and the buttons allowing to move the items in it.
about: This control is in fact a panel containing the wxRearrangeList control and the "Up" and "Down"
buttons to move the currently selected item up or down. It is used as the main part of a wxRearrangeDialog.
End Rem
Type wxRearrangeCtrl Extends wxPanel

	Function _create:wxRearrangeCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxRearrangeCtrl = New wxRearrangeCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxRearrangeCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local ctl:wxRearrangeCtrl = wxRearrangeCtrl(wxfind(wxObjectPtr))
			If Not ctl Then
				Return wxRearrangeCtrl._create(wxObjectPtr)
			End If
			Return ctl
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateRearrangeCtl:wxRearrangeCtrl(parent:wxWindow, id:Int, items:String[], order:Int[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = 0)
		Return New wxRearrangeCtrl.CreateCtrl(parent, id, items, order, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateCtrl:wxRearrangeCtrl(parent:wxWindow, id:Int, items:String[], order:Int[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = 0)
		wxObjectPtr = bmx_wxrearrangectrl_create(Self, parent, id, items, order, x, y, w, h, style)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the listbox which is the main part of this control. 
	End Rem
	Method GetList:wxRearrangeList()
		Return wxRearrangeList._find(bmx_wxrearrangectrl_getlist(wxObjectPtr))
	End Method

End Type

