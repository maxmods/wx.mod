' Copyright (c) 2009-2015 Bruce A Henderson
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
bbdoc: wxBitmapToggleButton
End Rem
Module wx.wxBitmapToggleButton

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2009-2015 Bruce A Henderson"


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
bbdoc: A wxToggleButton that contains a bitmap instead of text.
End Rem
Type wxBitmapToggleButton Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a bitmap toggle button.
	End Rem
	Function CreateToggleButton:wxBitmapToggleButton(parent:wxWindow, id:Int, bitmap:wxBitmap, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxBitmapToggleButton.Create(parent, id, bitmap, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Constructor, creating and showing a bitmap toggle button.
	End Rem
	Method Create:wxBitmapToggleButton(parent:wxWindow, id:Int, bitmap:wxBitmap, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)

		wxObjectPtr = bmx_wxbitmaptogglebutton_create(Self, parent.wxObjectPtr, id, bitmap.wxObjectPtr, x, y, w, h, style)

		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Gets the state of the toggle button. 
	End Rem
	Method GetValue:Int()
		Return bmx_wxbitmaptogglebutton_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the toggle button to the given state. 
	End Rem
	Method SetValue(value:Int)
		bmx_wxbitmaptogglebutton_setvalue(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Sets the button bitmap.
	End Rem
	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxbitmaptogglebutton_setbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
End Type

