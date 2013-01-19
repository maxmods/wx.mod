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
bbdoc: wxSpinCtrlDbl
End Rem
Module wx.wxSpinCtrlDbl

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
bbdoc: A double valued wxSpinCtrl
End Rem
Type wxSpinCtrlDbl Extends wxControl

	Function CreateSpinCtrl:wxSpinCtrlDbl(parent:wxWindow, id:Int, value:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = 95, h:Int = -1, style:Int = 0, minimum:Int = 0, maximum:Int = 100, initial:Int = 0)
			
		Return New wxSpinCtrlDbl.Create(parent, id, value, x, y, w, h, style, minimum, maximum, initial)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateButton.
	End Rem
	Method Create:wxSpinCtrlDbl(parent:wxWindow, id:Int, value:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = 95, h:Int = -1, style:Int = 0, minimum:Int = 0, maximum:Int = 100, initial:Int = 0)
			
		'wxObjectPtr = bmx_wxspinctrldbl_create(Self, parent.wxObjectPtr, id, value, x, y, w, h, style, minimum, maximum, initial)
		
		Return Self
	End Method

	Method SetValue(value:Double)
	End Method
	
	Method SetTextValue(value:String, force:Int)
	End Method
	
	Method SetRange( minVal:Double, maxVal:Double)
	End Method
	
	Method SetIncrement(increment:Double, digits:Int = wxSPINCTRLDBL_AUTODIGITS, format:Int = FORMAT_LG)
	End Method
	
	Method SetDigits(digits:Int = wxSPINCTRLDBL_AUTODIGITS, format:Int = FORMAT_LG ) 
	End Method
	
	Method SetFormat(format:String)
	End Method
	
	Method ResetValue()
	End Method
	
	Method SetDefaultValue(value:Double)
	End Method
	
	Method GetValue:Double()
	End Method
	
	Method GetMin:Double()
	End Method
	
	Method GetMax:Double()
	End Method
	
	Method HasRange:Int()
	End Method
	
	Method InRange:Int(value:Double)
	End Method
	
	Method GetIncrement:Double()
	End Method
	
	Method GetDigits:Int()
	End Method
	
	Method GetFormat:String()
	End Method
	
	Method GetDefaultValue:Double()
	End Method
	
	Method GetSnapToTicks:Int()
	End Method
	
	Method IsDefaultValue:Int()
	End Method
	

End Type

