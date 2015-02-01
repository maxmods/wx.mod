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
bbdoc: wxGradientButton
End Rem
Module wx.wxGradientButton

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
bbdoc: 
End Rem
Type wxGradientButton Extends wxWindow

	Function _create:wxGradientButton(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGradientButton = New wxGradientButton
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Constructor, creating and showing a gradient button.
	End Rem
	Function CreateGradientButton:wxGradientButton(parent:wxWindow, id:Int = wxID_ANY, label:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSIMPLE_BORDER|wxFULL_REPAINT_ON_RESIZE)
			
		Return New wxGradientButton.Create(parent, id, label, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creates the gradient button for two-step construction.
	End Rem
	Method Create:wxGradientButton(parent:wxWindow, id:Int = wxID_ANY, label:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxSIMPLE_BORDER|wxFULL_REPAINT_ON_RESIZE)
			
		wxObjectPtr = bmx_wxgradientbutton_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetLabel:String()
		Return bmx_wxgradientbutton_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabel(value:String)
		bmx_wxgradientbutton_setlabel(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGradientTopStartColour:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getgradienttopstartcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGradientTopStartColour(value:wxColour)
		bmx_wxgradientbutton_setgradienttopstartcolour(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGradientTopEndColour:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getgradienttopendcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGradientTopEndColour(value:wxColour)
		bmx_wxgradientbutton_setgradienttopendcolour(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGradientBottomStartColour:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getgradientbottomstartcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGradientBottomStartColour(value:wxColour)
		bmx_wxgradientbutton_setgradientbottomstartcolour(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGradientBottomEndColour:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getgradientbottomendcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGradientBottomEndColour(value:wxColour)
		bmx_wxgradientbutton_setgradientbottomendcolour(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPressedColourTop:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getpressedcolourtop(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPressedColourTop(value:wxColour)
		bmx_wxgradientbutton_setpressedcolourtop(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPressedColourBottom:wxColour()
		Return wxColour._create(bmx_wxgradientbutton_getpressedcolourbottom(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPressedColourBottom(value:wxColour)
		bmx_wxgradientbutton_setpressedcolourbottom(wxObjectPtr, value.wxObjectPtr)
	End Method
	
End Type

