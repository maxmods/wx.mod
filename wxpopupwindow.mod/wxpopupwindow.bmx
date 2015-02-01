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
bbdoc: wxPopupWindow
End Rem
Module wx.wxPopupWindow

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
bbdoc: A special kind of top level window used for popup menus, combobox popups and such.
End Rem
Type wxPopupWindow Extends wxWindow

	Function CreatePopupWindow:wxPopupWindow(parent:wxWindow, flags:Int = wxBORDER_NONE)
		Return New wxPopupWindow.Create(parent, flags)
	End Function
	
	Rem
	bbdoc: Constructor.
	End Rem
	Method Create:wxPopupWindow(parent:wxWindow, flags:Int = wxBORDER_NONE)
		wxObjectPtr = bmx_wxpopupwindow_create(Self, parent.wxObjectPtr, flags)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Moves the popup window to the right position, i.e. such that it is entirely visible.
	about: The popup is positioned at ptOrigin + size if it opens below and to the right (default), at ptOrigin - sizePopup if
	it opens above and to the left etc.
	End Rem
	Method Position(x:Int, y:Int, w:Int, h:Int)
		bmx_wxpopupwindow_position(wxObjectPtr, x, y, w, h)
	End Method
	
	Function _Position(window:wxPopupWindow, x:Int, y:Int, w:Int, h:Int)
		window.Position(x, y, w, h)
	End Function
	
End Type

