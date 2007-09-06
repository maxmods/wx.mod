' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: wxChoice
End Rem
Module wx.wxChoice

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
bbdoc: A choice item is used to select one of a list of strings.
about: Unlike a listbox, only the selection is visible until the user pulls down the menu of choices.
End Rem
Type wxChoice Extends wxControlWithItems

	Rem
	bbdoc: Constructor, creating and showing a choice.
	End Rem
	Function CreateChoice:wxChoice(parent:wxWindow, id:Int, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Local this:wxChoice = New wxChoice

		this.wxObjectPtr = bmx_wxchoice_create(this, parent.wxObjectPtr, id, choices, x, y, w, h, style)
	
		Return this
	End Function

	'Rem
	'bbdoc: Gets the number of columns in this choice item.
	'about: This is implemented For Motif only And always returns 1 For the other platforms.
	'End Rem
	'Method GetColumns:Int()
	'End Method
	
	Rem
	bbdoc: Unlike GetSelection which only returns the accepted selection value, i.e. the selection in the control once the user closes the dropdown list, this function returns the current selection.
	about: That is, while the dropdown list is shown, it returns the currently selected item in it.
	When it is not shown, its result is the same as for the other function.
	End Rem
	Method GetCurrentSelection:Int()
		Return bmx_wxchoice_getcurrentselection(wxObjectPtr)
	End Method
	
	'Method SetColumns(n:Int = 1)
	'End Method
	
	

End Type