' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxUIActionSimulator
End Rem
Module wx.wxUIActionSimulator

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
bbdoc: A type used to simulate user interface actions such as a mouse click or a key press.
about: Common usage would be to provide playback and record (aka macro recording) functionality for users,
or to drive unit tests by simulating user sessions.
End Rem
Type wxUIActionSimulator

	Field wxObjectPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Function CreateUIActionSimulator:wxUIActionSimulator()
		Return New wxUIActionSimulator.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxUIActionSimulator()
		wxObjectPtr = bmx_wxuiactionsimulator_create()
		Return Self
	End Method

	Rem
	bbdoc: Move the mouse to the specified coordinates. 
	End Rem
	Method MouseMove:Int(x:Int, y:Int)
		Return bmx_wxuiactionsimulator_mousemove(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Press a mouse button. 
	End Rem
	Method MouseDown:Int(button:Int = wxMOUSE_BTN_LEFT)
		Return bmx_wxuiactionsimulator_mousedown(wxObjectPtr, button)
	End Method
	
	Rem
	bbdoc: Release a mouse button. 
	End Rem
	Method MouseUp:Int(button:Int = wxMOUSE_BTN_LEFT)
		Return bmx_wxuiactionsimulator_mouseup(wxObjectPtr, button)
	End Method
	
	Rem
	bbdoc: Click a mouse button.
	End Rem
	Method MouseClick:Int(button:Int = wxMOUSE_BTN_LEFT)
		Return bmx_wxuiactionsimulator_mouseclick(wxObjectPtr, button)
	End Method
	
	Rem
	bbdoc: Double-click a mouse button. 
	End Rem
	Method MouseDblClick:Int(button:Int = wxMOUSE_BTN_LEFT)
		Return bmx_wxuiactionsimulator_mousedblclick(wxObjectPtr, button)
	End Method
	
	Rem
	bbdoc: Perform a drag and drop operation. 
	End Rem
	Method MouseDragDrop:Int(x1:Int, y1:Int, x2:Int, y2:Int, button:Int = wxMOUSE_BTN_LEFT)
		Return bmx_wxuiactionsimulator_mousedragdrop(wxObjectPtr, x1, y1, x2, y2, button)
	End Method
	
	Rem
	bbdoc: Press a key. 
	End Rem
	Method KeyDown:Int(keycode:Int, modifiers:Int = wxMOD_NONE)
		Return bmx_wxuiactionsimulator_keydown(wxObjectPtr, keycode, modifiers)
	End Method
	
	Rem
	bbdoc: Release a key. 
	End Rem
	Method KeyUp:Int(keycode:Int, modifiers:Int = wxMOD_NONE)
		Return bmx_wxuiactionsimulator_keyup(wxObjectPtr, keycode, modifiers)
	End Method
	
	Rem
	bbdoc: Press and release a key.
	End Rem
	Method Char:Int(keycode:Int, modifiers:Int = wxMOD_NONE)
		Return bmx_wxuiactionsimulator_char(wxObjectPtr, keycode, modifiers)
	End Method
	
	Rem
	bbdoc: Emulate typing in the keys representing the given string.
	End Rem
	Method Text:Int(txt:String)
		Return bmx_wxuiactionsimulator_text(wxObjectPtr, txt)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxuiactionsimulator_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type
