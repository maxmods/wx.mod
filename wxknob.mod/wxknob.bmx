' Copyright (c) 2007-2011 Bruce A Henderson
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

Module wx.wxKnob

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A rotary knob control
End Rem
Type wxKnob Extends wxControl

	Rem
	bbdoc: Creates a new wxKnob
	End Rem
	Function CreateKnob:wxKnob(parent:wxWindow, id:Int, value:Int, minValue:Int, ..
			maxValue:Int, minAngle:Int = 240, maxAngle:Int = 300, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxKnob.Create(parent, id, value, minValue, maxValue, minAngle, maxAngle, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxKnob.
	End Rem
	Method Create:wxKnob(parent:wxWindow, id:Int, value:Int, minValue:Int, ..
			maxValue:Int, minAngle:Int = 240, maxAngle:Int = 300, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxknob_create(Self, parent.wxObjectPtr, id, value, minValue, maxValue, minAngle, maxAngle, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the min/max range.
	End Rem
	Method SetRange(minValue:Int, maxValue:Int)
		bmx_wxknob_setrange(wxObjectPtr, minValue, maxValue)
	End Method
	
	Rem
	bbdoc: Gets the minimum value.
	End Rem
	Method GetMin:Int()
		Return bmx_wxknob_getmin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the maximum value.
	End Rem
	Method GetMax:Int()
		Return bmx_wxknob_getmax(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the minimum value.
	End Rem
	Method SetMin(value:Int)
		bmx_wxknob_setmin(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the maximum value.
	End Rem
	Method SetMax(value:Int)
		bmx_wxknob_setmax(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Gets the minimum turn angle.
	End Rem
	Method GetMinAngle:Int()
		Return bmx_wxknob_getminangle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the maximum turn angle.
	End Rem
	Method GetMaxAngle:Int()
		Return bmx_wxknob_getmaxangle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the current knob value.
	End Rem
	Method GetValue:Int()
		Return bmx_wxknob_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the knob value
	End Rem
	Method SetValue(value:Int)
		bmx_wxknob_setvalue(wxObjectPtr, value)
	End Method

End Type

