' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxVListBox
End Rem
Module wx.wxVListBox

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
bbdoc: 
End Rem
Type wxVListBox Extends wxVScrolledWindow

	Function _create:wxVListBox(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxVListBox = New wxVListBox
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateVlistBox:wxVListBox(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxVListBox.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxVListBox(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		'wxObjectPtr = bmx_wxvlistbox_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Method Clear()
	End Method
	
	Method DeselectAll:Int()
	End Method
	
	Method GetFirstSelected:Int(cookie:Int Var)
	End Method
	
	Method GetItemCount:Int()
	End Method
	
	Method GetMargins(x:Int Var, y:Int Var)
	End Method
	
	Method GetItemRect(item:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
	End Method
	
	Method GetItemRectRect:wxRect(item:Int)
	End Method
	
	Method GetNextSelected:Int(cookie:Int Var)
	End Method
	
	Method GetSelectedCount:Int()
	End Method
	
	Method GetSelection:Int()
	End Method
	
	Method GetSelectionBackground:wxColour()
	End Method
	
	Method HasMultipleSelection:Int()
	End Method
	
	Method IsCurrent:Int(item:Int)
	End Method
	
	Method IsSelected:Int(item:Int)
	End Method
	
	Method SelectItem:Int(item:Int)
	End Method
	
	Method SelectAll:Int()
	End Method
	
	Method SelectRange:Int(rangeFrom:Int, rangeTo:Int)
	End Method
	
	Method SetItemCount(count:Int)
	End Method
	
	Method SetSelection(selection:Int)
	End Method
	
	Method SetSelectionBackground(col:wxColour)
	End Method
	
	Method Toggle(item:Int)
	End Method
	
	Method SetMargins(x:Int, y:Int)
	End Method

	
	Method OnDrawItem(dc:wxDC, x:Int, y:Int, w:Int, h:Int, n:Int)
	' override me
	End Method
	
	Method OnDrawBackground(dc:wxDC, x:Int, y:Int, w:Int, h:Int, n:Int)
	' override me
	End Method
	
	Method OnDrawSeparator(dc:wxDC, x:Int, y:Int, w:Int, h:Int, n:Int)
	' override me
	End Method

	Method OnMeasureItem:Int(n:Int)
	' override me
	End Method

End Type

