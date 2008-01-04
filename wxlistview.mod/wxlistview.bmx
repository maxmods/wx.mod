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
bbdoc: wxListView
End Rem
Module wx.wxListView

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
bbdoc: This type currently simply presents a simpler to use interface for the wxListCtrl -- it can be thought of as a façade for that complicated type.
about: Using it is preferable to using wxListCtrl directly whenever possible because in the future some
ports might implement wxListView but not the full set of wxListCtrl features.
<p>
Other than different interface, this type is identical to wxListCtrl. In particular, it uses the same
events, same window styles and so on.
</p>
End Rem
Type wxListView Extends wxListCtrl

	Rem
	bbdoc: Constructor, creating and showing a list view.
	End Rem
	Function CreateListView:wxListView(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxLC_ICON)
		Return New wxListView.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the list view.
	about: See CreateListCtrl for further details.
	End Rem
	Method Create:wxListView(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxLC_ICON)
		wxObjectPtr = bmx_wxlistview_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method


	Rem
	bbdoc: Resets the column image -- after calling this method, no image will be shown.
	End Rem
	Method ClearColumnImage(col:Int)
		bmx_wxlistview_clearcolumnimage(wxObjectPtr, col)
	End Method

	Rem
	bbdoc: Sets focus to the item with the given index.
	End Rem
	Method Focus(index:Int)
		bmx_wxlistview_focus(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Returns the first selected item in a (presumably) multiple selection control.
	about: Together with GetNextSelected it can be used to iterate over all selected items in the control.
	End Rem
	Method GetFirstSelected:Int()
		Return bmx_wxlistview_getfirstselected(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the currently focused item or -1 if none.
	End Rem
	Method GetFocusedItem:Int()
		Return bmx_wxlistview_getfocuseditem(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Used together with GetFirstSelected to iterate over all selected items in the control.
	End Rem
	Method GetNextSelected:Int(item:Int)
		Return bmx_wxlistview_getnextselected(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns True if the item with the given index is selected, False otherwise.
	End Rem
	Method IsSelected:Int(index:Int)
		Return bmx_wxlistview_isselected(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Selects or unselects the given item.
	End Rem
	Method SelectItem(item:Int, on:Int = True)
		bmx_wxlistview_selectitem(wxObjectPtr, item, on)
	End Method
	
	Rem
	bbdoc: Sets the column image for the specified column.
	about: To use the column images, the control must have a valid image list with at least one image.
	End Rem
	Method SetColumnImage(col:Int, image:Int)
		bmx_wxlistview_setcolumnimage(wxObjectPtr, col, image)
	End Method
	
End Type

