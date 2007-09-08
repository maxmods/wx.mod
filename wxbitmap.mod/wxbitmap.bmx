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
bbdoc: wxBitmap
End Rem
Module wx.wxBitmap

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

Function wxNullBitmap:wxBitmap()
	Return New wxBitmap.CreateNull()
End Function

Rem
bbdoc: This type encapsulates the concept of a platform-dependent bitmap, either monochrome or colour or colour with alpha channel support.
End Rem
Type wxBitmap Extends wxGDIObject

	Function _create:wxBitmap(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBitmap = New wxBitmap
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Default Constructor.
	End Rem
	Function CreateBitmap:wxBitmap()
		Return New wxBitmap.Create()
	End Function
	
	Rem
	bbdoc: Default Constructor.
	End Rem
	Method Create:wxBitmap()
		wxObjectPtr = bmx_wxbitmap_create(False)
		Return Self
	End Method
	
	Method CreateNull:wxBitmap()
		wxObjectPtr = bmx_wxbitmap_create(True)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateEmpty:wxBitmap(width:Int, height:Int, depth:Int = -1)
		wxObjectPtr = bmx_wxbitmap_createempty(width, height, depth)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function CreateFromImage:wxBitmap(image:wxImage, depth:Int = -1)
		Return _create(bmx_wxbitmap_createfromimage(image.wxObjectPtr, depth))
	End Function
	
	Rem
	bbdoc: Creates an image from a platform-dependent bitmap.
	about: This preserves mask information so that bitmaps and images can be converted back and forth
	without loss in that respect.
	End Rem
	Method ConvertToImage:wxImage()
		Return wxImage._create(bmx_wxbitmap_converttoimage(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Loads a bitmap from a file or resource.
	End Rem
	Method LoadFile:Int(name:String, kind:Int)
		Return bmx_wxbitmap_loadfile(wxObjectPtr, name, kind)
	End Method
	
	Rem
	bbdoc: Gets the colour depth of the bitmap.
	about: A value of 1 indicates a monochrome bitmap.
	End Rem
	Method GetDepth:Int()
		Return bmx_wxbitmap_getdepth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the height of the bitmap in pixels.
	End Rem
	Method GetHeight:Int()
		Return bmx_wxbitmap_getheight(wxObjectPtr)
	End Method
	
	Method GetPalette()
	End Method
	
	Method GetMask()
	End Method
	
	Rem
	bbdoc: Gets the width of the bitmap in pixels.
	End Rem
	Method GetWidth:Int()
		Return bmx_wxbitmap_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a sub bitmap of the current one as long as the rect belongs entirely to the bitmap.
	about: This method preserves bit depth and mask information.
	End Rem
	Method GetSubBitmap:wxBitmap(x:Int, y:Int, w:Int, h:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDepth(depth:Int)
		bmx_wxbitmap_setdepth(wxObjectPtr, depth)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetHeight(height:Int)
		bmx_wxbitmap_setheight(wxObjectPtr, height)
	End Method
	
	Method SetMask()
	End Method
	
	Method SetPalette()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetWidth(width:Int)
		bmx_wxbitmap_setwidth(wxObjectPtr, width)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			'bmx_wxbitmap_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

