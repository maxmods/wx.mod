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
bbdoc: wxGauge
End Rem
Module wx.wxGauge

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
bbdoc: A gauge is a horizontal or vertical bar which shows a quantity (often time).
about: wxGauge supports two working modes: determinate and indeterminate progress.
<p>
The first is the usual working mode (see SetValue and SetRange) while the second can be used when the program is
doing some processing but you don't know how much progress is being done. In this case, you can periodically call
the Pulse function to make the progress bar switch to indeterminate mode (graphically it's usually a set of blocks
which move or bounce in the bar control).
</p>
<p>
wxGauge supports dynamic switching between these two work modes.
</p>
<p>
There are no user commands for the gauge.
</p>
End Rem
Type wxGauge Extends wxControl

	Function _create:wxGauge(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGauge = New wxGauge
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxGauge(wxObjectPtr:Byte Ptr)
		Return wxGauge._create(wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Constructor, creating and showing a gauge.
	End Rem
	Function CreateGauge:wxGauge(parent:wxWindow, id:Int, range:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxGA_HORIZONTAL)
			
		Return New wxGauge.Create(parent, id, range, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creates the gauge for two-step construction.
	about: See CreateGauge for further details.
	End Rem
	Method Create:wxGauge(parent:wxWindow, id:Int, range:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxgauge_create(Self, parent.wxObjectPtr, id, range, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the width of the 3D bezel face.
	about: This method is not implemented (returns 0) for most platforms.
	End Rem
	Method GetBezelFace:Int()
		Return bmx_wxgauge_getbezelface(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the maximum position of the gauge.
	End Rem
	Method GetRange:Int()
		Return bmx_wxgauge_getrange(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the 3D shadow margin width.
	about: This method is not implemented (returns 0) for most platforms.
	End Rem
	Method GetShadowWidth:Int()
		Return bmx_wxgauge_getshadowwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current position of the gauge.
	End Rem
	Method GetValue:Int()
		Return bmx_wxgauge_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the gauge is vertical (has wxGA_VERTICAL style) and False otherwise.
	End Rem
	Method IsVertical:Int()
		Return bmx_wxgauge_isvertical(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the 3D bezel face width.
	about: This method is not implemented (doesn't do anything) for most platforms.
	End Rem
	Method SetBezelFace(width:Int)
		bmx_wxgauge_setbezelface(wxObjectPtr, width)
	End Method
	
	Rem
	bbdoc: Sets the range (maximum value) of the gauge.
	about: This method makes the gauge switch to determinate mode, if it's not already.
	End Rem
	Method SetRange(range:Int)
		bmx_wxgauge_setrange(wxObjectPtr, range)
	End Method
	
	Rem
	bbdoc: Sets the 3D shadow width.
	about: This method is not implemented (doesn't do anything) for most platforms.
	End Rem
	Method SetShadowWidth(width:Int)
		bmx_wxgauge_setshadowwidth(wxObjectPtr, width)
	End Method
	
	Rem
	bbdoc: Sets the position of the gauge.
	about: This method makes the gauge switch to determinate mode, if it's not already.
	End Rem
	Method SetValue(pos:Int)
		bmx_wxgauge_setvalue(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Switch the gauge to indeterminate mode (if required) and makes the gauge move a bit to indicate the user that some progress has been made.
	about: Note that after calling this function the value returned by GetValue is undefined and thus you need to
	explicitely call SetValue if you want to restore the determinate mode.
	End Rem
	Method Pulse()
		bmx_wxgauge_pulse(wxObjectPtr)
	End Method
	
End Type


Type TGaugeResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxgauge_addresourcehandler()
	End Method
		
End Type

New TGaugeResourceFactory
