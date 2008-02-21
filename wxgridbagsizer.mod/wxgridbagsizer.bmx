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
bbdoc: 
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

	Function CreateGridBagSizer:wxGridBagSizer(vgap:Int=0, hgap:Int=0)
		Return New wxGridBagSizer.CreateGB(vgap, hgap)
	End Function
	
	Method CreateGB:wxGridBagSizer(vgap:Int=0, hgap:Int=0)
		wxSizerPtr = bmx_wxgridbagsizer_create(Self, vgap, hgap)
		Return Self
	End Method
	
	Method AddGB:wxSizerItem(window:wxWindow, row:Int=0, col:Int=0, rowspan:Int=0, colspan:Int=0, flag:Int=0, border:Int=0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_add(wxSizerPtr, window.wxObjectPtr, row, col, rowspan, colspan, flag, border))
	End Method

	Method AddGBSizer:wxSizerItem(sizer:wxSizer, row:Int=0, col:Int=0, rowspan:Int=0, colspan:Int=0, flag:Int=0, border:Int=0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addsizer(wxSizerPtr, sizer.wxSizerPtr, row, col, rowspan, colspan, flag, border))
	End Method

	Method AddGBSpacer:wxSizerItem(width:Int, height:Int, row:Int=0, col:Int=0, rowspan:Int=0, colspan:Int=0, flag:Int=0, border:Int=0)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addspacer(wxSizerPtr, width, height, row, col, rowspan, colspan, flag, border))
	End Method
	
	Method AddGBSizerItem:wxSizerItem(item:wxGBSizerItem)
		Return wxSizerItem._create(bmx_wxgridbagsizer_addgbsizeritem(wxSizerPtr, item.wxSizerItemPtr))
	End Method
	
	Method CheckForIntersection:Int(item:wxGBSizerItem, excludeItem:wxGBSizerItem=Null)
		If excludeItem Then
			Return bmx_wxgridbagsizer_checkforintersection(wxSizerPtr, item.wxSizerItemPtr, excludeItem.wxSizerItemPtr)
		Else
			Return bmx_wxgridbagsizer_checkforintersection(wxSizerPtr, item.wxSizerItemPtr, Null)
		EndIf
	End Method
	
	Method CheckForIntersectionPos:Int(row:Int, col:Int, rowspan:Int, colspan:Int, excludeItem:wxGBSizerItem=Null)
		If excludeItem Then
			Return bmx_wxgridbagsizer_checkforintersectionpos(wxSizerPtr, row, col, rowspan, colspan, excludeItem.wxSizerItemPtr)
		Else
			Return bmx_wxgridbagsizer_checkforintersectionpos(wxSizerPtr, row, col, rowspan, colspan, Null)
		EndIf
	End Method
	
	Method FindItemWindow:wxGBSizerItem(window:wxWindow)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditemwindow(wxSizerPtr, window.wxObjectPtr))
	End Method

	Method FindItemSizer:wxGBSizerItem(sizer:wxSizer)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditemsizer(wxSizerPtr, sizer.wxSizerPtr))
	End Method
	
	Method FindItemAtPoint:wxGBSizerItem(x:Int, y:Int)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditematpoint(wxSizerPtr, x, y))
	End Method

	Method FindItemAtPosition:wxGBSizerItem(row:Int, col:Int)
		Return wxGBSizerItem._create(bmx_wxgridbagsizer_finditematposition(wxSizerPtr, row, col))
	End Method
	
	Method GetCellSize(row:Int, col:Int, width:Int Var, height:Int Var)
		bmx_wxgridbagsizer_getcellsize(wxSizerPtr, col, row, Varptr width, Varptr height)
	End Method
	
	Method GetEmptyCellSize(width:Int Var, height:Int Var)
		bmx_wxgridbagsizer_getemptycellsize(wxSizerPtr, Varptr width, Varptr height)
	End Method
	
	Method GetItemPositionWindow(window:wxWindow, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitempositionwindow(wxSizerPtr, window.wxObjectPtr, Varptr row, Varptr col)
	End Method
	
	Method GetItemPositionSizer(sizer:wxSizer, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitempositionsizer(wxSizerPtr, sizer.wxSizerPtr, Varptr row, Varptr col)
	End Method

	Method GetItemPosition(index:Int, row:Int Var, col:Int Var)
		bmx_wxgridbagsizer_getitemposition(wxSizerPtr, index, Varptr row, Varptr col)
	End Method
	
	Method GetItemSpanWindow(window:wxWindow, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspanwindow(wxSizerPtr, window.wxObjectPtr, Varptr rowspan, Varptr colspan)
	End Method
	
	Method GetItemSpanSizer(sizer:wxSizer, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspansizer(wxSizerPtr, sizer.wxSizerPtr, Varptr rowspan, Varptr colspan)
	End Method

	Method GetItemSpan(index:Int, rowspan:Int Var, colspan:Int Var)
		bmx_wxgridbagsizer_getitemspan(wxSizerPtr, index, Varptr rowspan, Varptr colspan)
	End Method
	
	Method RecalcSizes()
	End Method
	
	Method SetEmptyCellSize(width:Int, height:Int)
		bmx_wxgridbagsizer_setemptycellsize(wxSizerPtr, width, height)
	End Method
	
	Method SetItemPositionWindow:Int(window:wxWindow, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitempositionwindow(wxSizerPtr, window.wxObjectPtr, row, col)
	End Method
	
	Method SetItemPositionSizer:Int(sizer:wxSizer, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitempositionsizer(wxSizerPtr, sizer.wxSizerPtr, row, col)
	End Method

	Method SetItemPosition:Int(index:Int, row:Int, col:Int)
		Return bmx_wxgridbagsizer_setitemposition(wxSizerPtr, index, row, col)
	End Method

	Method SetItemSpanWindow:Int(window:wxWindow, rowspan:Int, colspan:Int)
		Return bmx_wxgridbagsizer_setitemspanwindow(wxSizerPtr, window.wxObjectPtr, rowspan, colspan)
	End Method
	
	Method SetItemSpanSizer:Int(sizer:wxSizer, rowspan:Int, colspan:Int)
		Return bmx_wxgridbagsizer_setitemspansizer(wxSizerPtr, sizer.wxSizerPtr, rowspan, colspan)
	End Method

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

