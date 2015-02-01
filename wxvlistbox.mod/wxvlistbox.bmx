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
bbdoc: wxVListBox
End Rem
Module wx.wxVListBox

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
		wxObjectPtr = bmx_wxvlistbox_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Clear()
		bmx_wxvlistbox_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectAll:Int()
		Return bmx_wxvlistbox_deselectall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFirstSelected:Int(cookie:Int Var)
		Return bmx_wxvlistbox_getfirstselected(wxObjectPtr, Varptr cookie)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemCount:Int()
		Return bmx_wxvlistbox_getitemcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMargins(x:Int Var, y:Int Var)
		bmx_wxvlistbox_getmargins(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemRect(item:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxvlistbox_getitemrect(wxObjectPtr, item, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemRectRect:wxRect(item:Int)
		Return wxRect._create(bmx_wxvlistbox_getitemrectrect(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextSelected:Int(cookie:Int Var)
		Return bmx_wxvlistbox_getnextselected(wxObjectPtr, Varptr cookie)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectedCount:Int()
		Return bmx_wxvlistbox_getselectedcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelection:Int()
		Return bmx_wxvlistbox_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionBackground:wxColour()
		Return wxColour._create(bmx_wxvlistbox_getselectionbackground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasMultipleSelection:Int()
		Return bmx_wxvlistbox_hasmultipleselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCurrent:Int(item:Int)
		Return bmx_wxvlistbox_iscurrent(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsSelected:Int(item:Int)
		Return bmx_wxvlistbox_isselected(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectItem:Int(item:Int)
		Return bmx_wxvlistbox_selectitem(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectAll:Int()
		Return bmx_wxvlistbox_selectall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectRange:Int(rangeFrom:Int, rangeTo:Int)
		Return bmx_wxvlistbox_selectrange(wxObjectPtr, rangeFrom, rangeTo)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetItemCount(count:Int)
		bmx_wxvlistbox_setitemcount(wxObjectPtr, count)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelection(selection:Int)
		bmx_wxvlistbox_setselection(wxObjectPtr, selection)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionBackground(col:wxColour)
		bmx_wxvlistbox_setselectionbackground(wxObjectPtr, col.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Toggle(item:Int)
		bmx_wxvlistbox_toggle(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMargins(x:Int, y:Int)
		bmx_wxvlistbox_setmargins(wxObjectPtr, x, y)
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

