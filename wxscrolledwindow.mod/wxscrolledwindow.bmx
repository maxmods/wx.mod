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
bbdoc: wxScrolledWindow
End Rem
Module wx.wxScrolledWindow

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
bbdoc: The wxScrolledWindow manages scrolling for its client area, transforming the coordinates according to the scrollbar positions, and setting the scroll positions, thumb sizes and ranges according to the area in view.
about: 
End Rem
Type wxScrolledWindow Extends wxPanel

	Rem
	bbdoc: Translates the logical coordinates to the device ones.
	about: For example, if a window is scrolled 10 pixels to the bottom, the device coordinates of
	the origin are (0, 0) (as always), but the logical coordinates are (0, 10) and so the call
	to CalcScrolledPosition(0, 10, xx, yy) will return 0 in yy.
	End Rem
	Method CalcScrolledPosition(x:Int, y:Int, xx:Int Var, yy:Int Var)
	End Method
	
	Rem
	bbdoc: Translates the device coordinates to the logical ones.
	about: For example, if a window is scrolled 10 pixels to the bottom, the device coordinates of the
	origin are (0, 0) (as always), but the logical coordinates are (0, 10) and so the call to
	CalcUnscrolledPosition(0, 0, xx, yy) will return 10 in yy.
	End Rem
	Method CalcUnScrolledPosition(x:Int, y:Int, xx:Int Var, yy:Int Var)
	End Method
	
	Rem
	bbdoc: Enable or disable physical scrolling in the given direction.
	about: Physical scrolling is the physical transfer of bits up or down the screen when a scroll event
	occurs. If the application scrolls by a variable amount (e.g. if there are different font sizes)
	then physical scrolling will not work, and you should switch it off. Note that you will have to
	reposition child windows yourself, if physical scrolling is disabled.
	End Rem
	Method EnableScrolling(xScrolling:Int, yScrolling:Int)
	End Method
	
End Type
