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
bbdoc: wxRearrangeList
End Rem
Module wx.wxRearrangeList

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
bbdoc: A listbox-like control allowing the user to rearrange the items and to enable or disable them. 
about: This type allows to change the order of the items shown in it as well as to check or uncheck them
individually. The data structure used to allow this is the order array which contains the items indices
indexed by their position with an added twist that the unchecked items are represented by the bitwise
complement of the corresponding index (for any architecture using two's complement for negative numbers
representation (i.e. just about any at all) this means that a checked item N is represented by -N-1 in
unchecked state). In practice this means that you must apply the bitwise complement operator when constructing
the order array, e.g.
<pre>
        Local order:Int[2] 
        order[0] = 0  ' checked item #0
        order[1] = ~1 ' unchecked item #1
</pre>
So, for example, the array order [1 -3 0] used in conjunction with the items array
["first", "second", "third"] means that the items order is "second", "third", "first"
and the "third" item is unchecked while the other two are checked.
<p>
This convention is used both for the order argument of the control ctor or CreateList() and for the array
returned from GetCurrentOrder().
</p>
<p>
Usually this control will be used together with other controls allowing to move the items around in it
interactively. The simplest possible solution is to use wxRearrangeCtrl which combines it with two standard
buttons to move the current item up or down.
</p>
End Rem
Type wxRearrangeList Extends wxCheckListBox

	Function _create:wxRearrangeList(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxRearrangeList = New wxRearrangeList
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxRearrangeList(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local list:wxRearrangeList = wxRearrangeList(wxfind(wxObjectPtr))
			If Not list Then
				Return wxRearrangeList._create(wxObjectPtr)
			End If
			Return list
		End If
	End Function
	

	Rem
	bbdoc: 
	End Rem
	Function CreateRearrangeList:wxRearrangeList(parent:wxWindow, id:Int, items:String[], order:Int[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxRearrangeList.CreateList(parent, id, items, order, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateList:wxRearrangeList(parent:wxWindow, id:Int, items:String[], order:Int[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxrearrangelist_create(Self, parent.wxObjectPtr, id, items, order, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Returns the current order of the items.
	about: The order may be different from the one passed to the constructor if MoveCurrentUp() or MoveCurrentDown()
	were called. 
	End Rem
	Method GetCurrentOrder:Int[]()
		Return bmx_wxrearrangelist_getcurrentorder(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the currently selected item can be moved up.
	returns: True if the currently selected item can be moved up in the listbox, False if there is no selection or the current item is the first one.
	about: This method is useful for wxEVT_UPDATE_UI handler for the standard "Up" button often used together
	with this control and wxRearrangeCtrl uses it in this way.
	End Rem
	Method CanMoveCurrentUp:Int()
		Return bmx_wxrearrangelist_canmovecurrentup(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the currently selected item can be moved down. 
	returns: True if the currently selected item can be moved down in the listbox, False if there is no selection or the current item is the last one.
	End Rem
	Method CanMoveCurrentDown:Int()
		Return bmx_wxrearrangelist_canmovecurrentdown(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves the currently selected item one position above.
	returns: True if the item was moved or False if this couldn't be done.
	about: This method is useful to implement the standard "Up" button behaviour and wxRearrangeCtrl uses it for this.
	End Rem
	Method MoveCurrentUp:Int()
		Return bmx_wxrearrangelist_movecurrentup(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves the currently selected item one position below. 
	returns: True if the item was moved or False if this couldn't be done.
	End Rem
	Method MoveCurrentDown:Int()
		Return bmx_wxrearrangelist_movecurrentdown(wxObjectPtr)
	End Method

End Type

