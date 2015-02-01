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
bbdoc: wxSlider
End Rem
Module wx.wxSlider

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
bbdoc: A slider is a control with a handle which can be pulled back and forth to change the value.
about: On Windows, the track bar control is used.
<p>
Slider events are handled in the same way as a scrollbar.
</p>
End Rem
Type wxSlider Extends wxControl

	Function _create:wxSlider(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSlider = New wxSlider
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxSlider(wxObjectPtr:Byte Ptr)
		Return wxSlider._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a slider.
	End Rem
	Function CreateSlider:wxSlider(parent:wxWindow, id:Int, value:Int, minValue:Int, maxValue:Int, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxSL_HORIZONTAL)
		Return New wxSlider.Create(parent, id, value, minValue, maxValue, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Used for two-step slider construction. See wxSlider::wxSlider for further details.
	End Rem
	Method Create:wxSlider(parent:wxWindow, id:Int, value:Int, minValue:Int, maxValue:Int, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxSL_HORIZONTAL)
		wxObjectPtr = bmx_wxslider_create(Self, parent.wxObjectPtr, id, value, minValue, maxValue, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the line size.
	End Rem
	Method GetLineSize:Int()
		Return bmx_wxslider_getlinesize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the maximum slider value.
	End Rem
	Method GetMax:Int()
		Return bmx_wxslider_getmax(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the minimum slider value.
	End Rem
	Method GetMin:Int()
		Return bmx_wxslider_getmin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page size.
	End Rem
	Method GetPageSize:Int()
		Return bmx_wxslider_getpagesize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the current slider value.
	End Rem
	Method GetValue:Int()
		Return bmx_wxslider_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the line size for the slider.
	End Rem
	Method SetLineSize(size:Int)
		bmx_wxslider_setlinesize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the page size for the slider.
	End Rem
	Method SetPageSize(size:Int)
		bmx_wxslider_setpagesize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: Sets the minimum and maximum slider values.
	End Rem
	Method SetRange(minValue:Int, maxValue:Int)
		bmx_wxslider_setrange(wxObjectPtr, minValue, maxValue)
	End Method
	
	Rem
	bbdoc: Sets the slider position.
	End Rem
	Method SetValue(value:Int)
		bmx_wxslider_setvalue(wxObjectPtr, value)
	End Method
	
End Type


Type TSliderResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxslider_addresourcehandler()
	End Method
		
End Type

New TSliderResourceFactory
