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

Rem
bbdoc: A Null bitmap.
End Rem
Global wxNullBitmap:wxBitmap = New wxBitmap.CreateNull()

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
	bbdoc: Creates a new empty bitmap.
	about: A depth of -1 indicates the depth of the current screen or visual. Some platforms only support
	1 for monochrome and -1 for the current colour setting. A depth of 32 including an alpha channel is
	supported under MSW, Mac and GTK+.
	End Rem
	Method CreateEmpty:wxBitmap(width:Int, height:Int, depth:Int = -1)
		wxObjectPtr = bmx_wxbitmap_createempty(width, height, depth)
		Return Self
	End Method
	
	Rem
	bbdoc: Creates bitmap object from the image.
	about: This has to be done to actually display an image as you cannot draw an image directly on a
	window. The resulting bitmap will use the provided colour depth (or that of the current system if
	depth is -1) which entails that a colour reduction has to take place.
	<p>
	When in 8-bit mode (PseudoColour mode), the GTK port will use a color cube created on program
	start-up to look up colors. This ensures a very fast conversion, but the image quality won't be
	perfect (and could be better for photo images using more sophisticated dithering algorithms).
	</p>
	<p>
	On Windows, if there is a palette present (set with SetPalette), it will be used when creating the
	wxBitmap (most useful in 8-bit display mode). On other platforms, the palette is currently ignored.
	</p>
	End Rem
	Function CreateFromImage:wxBitmap(image:wxImage, depth:Int = -1)
		Return _create(bmx_wxbitmap_createfromimage(image.wxObjectPtr, depth))
	End Function
	
	Rem
	bbdoc: Loads a bitmap from a file or resource.
	End Rem
	Function CreateFromFile:wxBitmap(name:String, flag:Int)
		Return _create(bmx_wxbitmap_createfromfile(name, flag))
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
	
	Rem
	bbdoc: Gets the associated palette (if any) which may have been loaded from a file or set for the bitmap.
	End Rem
	Method GetPalette:wxPalette()
		Return wxPalette._create(bmx_wxbitmap_getpalette(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the associated mask (if any) which may have been loaded from a file or set for the bitmap.
	End Rem
	Method GetMask:wxMask()
		Return wxMask._create(bmx_wxbitmap_getmask(wxObjectPtr))
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
		Return wxbitmap._create(bmx_wxbitmap_getsubbitmap(wxObjectPtr, x, y, w, h))
	End Method
	
	Rem
	bbdoc: Sets the depth member (does not affect the bitmap data).
	End Rem
	Method SetDepth(depth:Int)
		bmx_wxbitmap_setdepth(wxObjectPtr, depth)
	End Method
	
	Rem
	bbdoc: Sets the height member (does not affect the bitmap data).
	End Rem
	Method SetHeight(height:Int)
		bmx_wxbitmap_setheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: Sets the mask for this bitmap.
	about: The bitmap object owns the mask once this has been called.
	End Rem
	Method SetMask(mask:wxMask)
		bmx_wxbitmap_setmask(wxObjectPtr, mask.wxObjectPtr)
		mask.wxObjectPtr = Null ' unlink, because the bitmap owns it now
	End Method
	
	Rem
	bbdoc: Sets the associated palette.
	about: (Not implemented under GTK+).
	End Rem
	Method SetPalette(palette:wxPalette)
		bmx_wxbitmap_setpalette(wxObjectPtr, palette.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the width member (does not affect the bitmap data).
	End Rem
	Method SetWidth(width:Int)
		bmx_wxbitmap_setwidth(wxObjectPtr, width)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxbitmap_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: This type encapsulates a monochrome mask bitmap, where the masked area is black and the unmasked area is white. When associated with a bitmap and drawn in a device context, the unmasked area of the bitmap will be drawn, and the masked area will not be drawn.
about: A mask may be associated with a wxBitmap. It is used in wxDC::Blit when the source device context
is a wxMemoryDC with wxBitmap selected into it that contains a mask.
End Rem
Type wxMask Extends wxObject
	
	Function _create:wxMask(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMask = New wxMask
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Constructs a mask from a bitmap and an optional colour that indicates the background.
	End Rem
	Function CreateMask:wxMask(bitmap:wxBitmap, colour:wxColour = Null)
		Return New wxMask.Create(bitmap, colour)
	End Function
	
	Rem
	bbdoc: Constructs a mask from a bitmap and an optional colour that indicates the background.
	End Rem
	Method Create:wxMask(bitmap:wxBitmap, colour:wxColour = Null)
		If colour Then
			wxObjectPtr = bmx_wxmask_create(bitmap.wxObjectPtr, colour.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxmask_create(bitmap.wxObjectPtr, Null)
		End If
		Return Self
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxmask_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type