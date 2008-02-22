' Copyright (c) 2007,2008 Bruce A Henderson & Oliver Skawronek
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
bbdoc: wxGridBagSizer
End Rem
Module wx.wxGridBagSizer

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
bbdoc: A wxSizer that can lay out items in a virtual grid like a wxFlexGridSizer but in this case explicit positioning of the items is allowed using (row, col), and items can optionally span more than one row and/or column using (rowspan, colspan).
End Rem
Type wxGridBagSizer Extends wxFlexGridSizer

	Function _create:wxGridBagSizer(wxSizerPtr:Byte Ptr)
		If wxSizerPtr Then
			Local this: wxGridBagSizer= New wxGridBagSizer
			this.wxSizerPtr = wxSizerPtr
			Return this
		End If
		
		Return Null
	End Function

	Rem
	bbdoc: Creates a new wxGridBagSizer, optionally specifying the gap between the rows and columns.
	End Rem
	Function CreateGridBagSizer:wxGridBagSizer(vgap:Int = 0, hgap:Int = 0)
		Return New wxGridBagSizer.CreateGB(vgap, hgap)
	End Function
	
	Rem
	bbdoc: Creates a new wxGridBagSizer, optionally specifying the gap between the rows and columns.
	End Rem
	Method CreateGB:wxGridBagSizer(vgap:Int = 0, hgap:Int = 0)
		wxSizerPtr = bmx_wxgridbagsizer_create(Self, vgap, hgap)
		Return Self
	End Method
	
	Rem
	bbdoc: Adds the window at the specified position.
	returns: The sizer item or Null if something was already there.
	End Rem
	Method AddGB:wxSizerItem(window:wxWindow, row:Int = 0, col:Int = 0, rowspan:Int = 1, colspan:Int = 1, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_add(wxSizerPtr, window.wxObjectPtr, row, col, rowspan, colspan, flag, border))
	End Method

	Rem
	bbdoc: Adds the sizer at the specified position.
	returns: The sizer item or Null if something was already there.
	End Rem
	Method AddGBSizer:wxSizerItem(sizer:wxSizer, row:Int=0, col:Int=0, rowspan:Int=0, colspan:Int=0, flag:Int=0, border:Int=0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addsizer(wxSizerPtr, sizer.wxSizerPtr, row, col, rowspan, colspan, flag, border))
	End Method

	Rem
	bbdoc: Adds the spacer at the specified position.
	returns: The sizer item or Null if something was already there.
	End Rem
	Method AddGBSpacer:wxSizerItem(width:Int, height:Int, row:Int = 0, col:Int = 0, rowspan:Int = 1, colspan:Int = 1, flag:Int = 0, border:Int = 0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addspacer(wxSizerPtr, width, height, row, col, rowspan, colspan, flag, border))
	End Method
	
	Rem
	bbdoc: Adds the sizer item at the specified position.
	returns: The sizer item or Null if something was already there.
	End Rem
	Method AddGBSizerItem:wxSizerItem(item:wxGBSizerItem)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addgbsizeritem(wxSizerPtr, item.wxSizerItemPtr))
	End Method
	
	Rem
	bbdoc: Look at all items and see if any intersect (or would overlap) the given item.
	returns: True if so, False if there would be no overlap.
	about: If an excludeItem is given then it will not be checked for intersection, for example it may be the
	item we are checking the position of.
	End Rem
	Method CheckForIntersection:Int(item:wxGBSizerItem, excludeItem:wxGBSizerItem=Null)
		If excludeItem Then
			Return bmx_wxgridbagsizer_checkforintersection(wxSizerPtr, item.wxSizerItemPtr, excludeItem.wxSizerItemPtr)
		Else
			Return bmx_wxgridbagsizer_checkforintersection(wxSizerPtr, item.wxSizerItemPtr, Null)
		EndIf
	End Method
	
	Rem
	bbdoc: Look at all items and see if any intersect (or would overlap) the given position.
	returns: True if so, False if there would be no overlap.
	about: If an excludeItem is given then it will not be checked for intersection, for example it may be the
	item we are checking the position of.
	End Rem
	Method CheckForIntersectionPos:Int(row:Int, col:Int, rowspan:Int, colspan:Int, excludeItem:wxGBSizerItem=Null)
		If excludeItem Then
			Return bmx_wxgridbagsizer_checkforintersectionpos(wxSizerPtr, row, col, rowspan, colspan, excludeItem.wxSizerItemPtr)
		Else
			Return bmx_wxgridbagsizer_checkforintersectionpos(wxSizerPtr, row, col, rowspan, colspan, Null)
		EndIf
	End Method
	
	Rem
	bbdoc: Find the sizer item for the given window, returning NULL if not found. (non-recursive)
	End Rem
	Method FindItemWindow:wxGBSizerItem(window:wxWindow)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditemwindow(wxSizerPtr, window.wxObjectPtr))
	End Method

	Rem
	bbdoc: Find the sizer item for the given sub-sizer, returning NULL if not found. (non-recursive)
	End Rem
	Method FindItemSizer:wxGBSizerItem(sizer:wxSizer)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditemsizer(wxSizerPtr, sizer.wxSizerPtr))
	End Method
	
	Rem
	bbdoc: Return the sizer item located at the point given, or Null if there is no item at that point.
	about: The (x,y) coordinates correspond to the client coordinates of the window using the sizer for layout. (non-recursive)
	End Rem
	Method FindItemAtPoint:wxGBSizerItem(x:Int, y:Int)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditematpoint(wxSizerPtr, x, y))
	End Method

	Rem
	bbdoc: Returns the sizer item for the given grid cell, or Null if there is no item at that position. (non-recursive)
	End Rem
	Method FindItemAtPosition:wxGBSizerItem(row:Int, col:Int)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditematposition(wxSizerPtr, row, col))
	End Method
	
	Rem
	bbdoc: Get the size of the specified cell, including hgap and vgap.
	about: Only valid after a Layout.
	End Rem
	Method GetCellSize(row:Int, col:Int, width:Int Var, height:Int Var)
		bmx_wxgridbagsizer_getcellsize(wxSizerPtr, col, row, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Get the size used for cells in the grid with no item.
	End Rem
	Method GetEmptyCellSize(width:Int Var, height:Int Var)
		bmx_wxgridbagsizer_getemptycellsize(wxSizerPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Get the grid position of the specified window.
	End Rem
	Method GetItemPositionWindow(window:wxWindow, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitempositionwindow(wxSizerPtr, window.wxObjectPtr, Varptr row, Varptr col)
	End Method
	
	Rem
	bbdoc: Get the grid position of the specified sizer.
	End Rem
	Method GetItemPositionSizer(sizer:wxSizer, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitempositionsizer(wxSizerPtr, sizer.wxSizerPtr, Varptr row, Varptr col)
	End Method

	Rem
	bbdoc: Get the grid position of the specified item.
	End Rem
	Method GetItemPosition(index:Int, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitemposition(wxSizerPtr, index, Varptr row, Varptr col)
	End Method
	
	Rem
	bbdoc: Get the row/col spanning of the specified window.
	End Rem
	Method GetItemSpanWindow(window:wxWindow, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspanwindow(wxSizerPtr, window.wxObjectPtr, Varptr rowspan, Varptr colspan)
	End Method
	
	Rem
	bbdoc: Get the row/col spanning of the specified sizer.
	End Rem
	Method GetItemSpanSizer(sizer:wxSizer, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspansizer(wxSizerPtr, sizer.wxSizerPtr, Varptr rowspan, Varptr colspan)
	End Method

	Rem
	bbdoc: Get the row/col spanning of the specified item.
	End Rem
	Method GetItemSpan(index:Int, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspan(wxSizerPtr, index, Varptr rowspan, Varptr colspan)
	End Method
	
	Method RecalcSizes()
	End Method
	
	Rem
	bbdoc: Set the size used for cells in the grid with no item.
	End Rem
	Method SetEmptyCellSize(width:Int, height:Int)
		bmx_wxgridbagsizer_setemptycellsize(wxSizerPtr, width, height)
	End Method
	
	Rem
	bbdoc: Set the grid position of the specified window.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemPositionWindow:Int(window:wxWindow, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitempositionwindow(wxSizerPtr, window.wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: Set the grid position of the specified sizer.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemPositionSizer:Int(sizer:wxSizer, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitempositionsizer(wxSizerPtr, sizer.wxSizerPtr, row, col)
	End Method

	Rem
	bbdoc: Set the grid position of the specified item.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemPosition:Int(index:Int, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitemposition(wxSizerPtr, index, row, col)
	End Method

	Rem
	bbdoc: Set the row/col spanning of the specified window.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemSpanWindow:Int(window:wxWindow, rowspan:Int, colspan:Int)
		Return bmx_wxgridbagsizer_setitemspanwindow(wxSizerPtr, window.wxObjectPtr, rowspan, colspan)
	End Method
	
	Rem
	bbdoc: Set the row/col spanning of the specified sizer.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemSpanSizer:Int(sizer:wxSizer, rowspan:Int, colspan:Int)
		Return bmx_wxgridbagsizer_setitemspansizer(wxSizerPtr, sizer.wxSizerPtr, rowspan, colspan)
	End Method

	Rem
	bbdoc: Set the row/col spanning of the specified item.
	returns: True on success.
	about: If the move is not allowed (because an item is already there) then False is returned.
	End Rem
	Method SetItemSpan:Int(index:Int, rowspan:Int, colspan:Int)
		Return bmx_wxgridbagsizer_setitemspan(wxSizerPtr, index, rowspan, colspan)
	End Method

End Type

Rem
bbdoc: The wxGBSizerItem type is used by the wxGridBagSizer for tracking the items in the sizer.
about: It adds grid position and spanning information to the normal wxSizerItem by adding wxGBPosition
and wxGBSpan attrbibutes. Most of the time you will not need to use a wxGBSizerItem directly
in your code, but there are a couple of cases where it is handy.
End Rem
Type wxGBSizerItem Extends wxSizerItem

	Function _create:wxGBSizerItem(wxSizerItemPtr:Byte Ptr)
		Local this:wxGBSizerItem = New wxGBSizerItem
		this.wxSizerItemPtr = wxSizerItemPtr
		Return this
	End Function

End Type

