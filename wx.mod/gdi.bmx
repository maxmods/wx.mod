' Copyright (c) 2007,2008 Bruce A Henderson
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

Import "base.bmx"

Rem
bbdoc: This type allows platforms to implement functionality to optimise GDI objects, such as wxPen,
wxBrush and wxFont. On Windows, the underling GDI objects are a scarce resource and are cleaned up when
a usage count goes to zero. On some platforms this class may not have any special functionality.
End Rem
Type wxGDIObject Extends wxObject


End Type

Rem
bbdoc: Returns the dimensions of the work area on the display.
about: On Windows this means the area not covered by the taskbar, etc. Other platforms are currently defaulting
to the whole display until a way is found to provide this info for all window managers, etc.
End Rem
Function wxClientDisplayRect(x:Int Var, y:Int Var, width:Int Var, height:Int Var)
	bmx_gdi_wxclientdisplayrect(Varptr x, Varptr y, Varptr width, Varptr height)
End Function

Rem
bbdoc: Returns True if the display is colour, False otherwise.
End Rem
Function wxColourDisplay:Int()
	Return bmx_gdi_wxcolourdisplay()
End Function

Rem
bbdoc: Returns the depth of the display (a value of 1 denotes a monochrome display).
End Rem
Function wxDisplayDepth:Int()
	Return bmx_gdi_wxdisplaydepth()
End Function

Rem
bbdoc: Returns the display size in pixels.
End Rem
Function wxDisplaySize(width:Int Var, height:Int Var)
	bmx_gdi_wxdisplaysize(Varptr width, Varptr height)
End Function

Rem
bbdoc: Returns the display size in millimeters.
End Rem
Function wxDisplaySizeMM(width:Int Var, height:Int Var)
	bmx_gdi_wxdisplaysizemm(Varptr width, Varptr height)
End Function

