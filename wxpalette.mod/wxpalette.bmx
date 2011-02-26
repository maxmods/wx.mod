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

Rem
bbdoc: wxPalette
End Rem
Module wx.wxPalette

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
bbdoc: A palette is a table that maps pixel values to RGB colours.
about: It allows the colours of a low-depth bitmap, for example, to be mapped to the available colours in 
a display. The notion of palettes is becoming more and more obsolete nowadays and only the MSW port is still
using a native palette. All other ports use generic code which is basically just an array of colours.
<p> 
It is likely that in the future the only use for palettes within wxWidgets will be for representing colour
indeces from images (such as GIF or PNG). The image handlers for these formats have been modified to create
a palette if there is such information in the original image file (usually 256 or less colour images). See
wxImage for more information.
</p>
End Rem
Type wxPalette Extends wxGDIObject

	Function _create:wxPalette(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPalette = New wxPalette
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Creates a palette from arrays of size n, one for each red, blue or green component.
	End Rem
	Function CreatePalette:wxPalette(red:Int[], green:Int[], blue:Int[])
		Return New wxPalette.Create(red, green, blue)
	End Function
	
	Rem
	bbdoc: Creates a palette from arrays of size n, one for each red, blue or green component.
	End Rem
	Method Create:wxPalette(red:Int[], green:Int[], blue:Int[])
		Local r:Byte[] = New Byte[red.length]
		Local g:Byte[] = New Byte[red.length]
		Local b:Byte[] = New Byte[red.length]
		For Local i:Int = 0 Until red.length
			r[i] = red[i]
			g[i] = green[i]
			b[i] = blue[i]
		Next
		wxObjectPtr = bmx_wxpalette_create(r, g, b)
		Return Self
	End Method

	Rem
	bbdoc: Returns number of entries in palette.
	End Rem
	Method GetColoursCount:Int()
		Return bmx_wxpalette_getcolourscount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a pixel value (index into the palette) for the given RGB values.
	about: The nearest palette index or wxNOT_FOUND for unexpected errors.
	End Rem
	Method GetPixel:Int(red:Int, green:Int, blue:Int)
		Return bmx_wxpalette_getpixel(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: Returns RGB values for a given palette index.
	End Rem
	Method GetRGB:Int(pixel:Int, red:Int Var, green:Int Var, blue:Int Var)
		Return bmx_wxpalette_getrgb(wxObjectPtr, pixel, Varptr red, Varptr green, Varptr blue)
	End Method
	
	Rem
	bbdoc: Returns true if palette data is present.
	End Rem
	Method IsOk:Int()
		Return bmx_wxpalette_isok(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpalette_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

