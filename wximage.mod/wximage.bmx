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

Rem
bbdoc: wxImage
End Rem
Module wx.wxImage

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
bbdoc: This type encapsulates a platform-independent image.
about: An image can be created from data, or using wxBitmap::ConvertToImage. An image can be loaded from a
file in a variety of formats, and is extensible to new formats via image format handlers. Functions are
available to set and get image bits, so it can be used for basic image manipulation.
<p>
A wxImage cannot (currently) be drawn directly to a wxDC. Instead, a platform-specific wxBitmap object must be
created from it using the wxBitmap::wxBitmap(wxImage,int depth) constructor. This bitmap can then be drawn in
a device context, using wxDC::DrawBitmap.
</p>
<p>
One colour value of the image may be used as a mask colour which will lead to the automatic creation of a wxMask
object associated to the bitmap object.
</p>
<h3>Alpha channel support</h3>
<p>
Starting from wxWidgets 2.5.0 wxImage supports alpha channel data, that is in addition to a byte for the red,
green and blue colour components for each pixel it also stores a byte representing the pixel opacity. An alpha
value of 0 corresponds to a transparent pixel (null opacity) while a value of 255 means that the pixel is 100% opaque.
</p>
<p>
Unlike RGB data, not all images have an alpha channel and before using GetAlpha you should check if this image
contains an alpha channel with HasAlpha. Note that currently only images loaded from PNG files with transparency
information will have an alpha channel but alpha support will be added to the other formats as well (as well as
support for saving images with alpha channel which also isn't implemented).
</p>
<h3>Available Image Handlers</h3>
<p>
The following image handlers are available. wxBMPHandler is always installed by default. To use other image formats, install the appropriate handler with wxImage::AddHandler or call wxInitAllImageHandlers.
wxBMPHandler 
For loading and saving, always installed. 
wxPNGHandler 
For loading (including alpha support) and saving. 
wxJPEGHandler 
For loading and saving. 
wxGIFHandler 
Only for loading, due to legal issues. 
wxPCXHandler 
For loading and saving (see below). 
wxPNMHandler 
For loading and saving (see below). 
wxTIFFHandler 
For loading and saving. 
wxTGAHandler 
For loading only. 
wxIFFHandler 
For loading only. 
wxXPMHandler 
For loading and saving. 
wxICOHandler 
For loading and saving. 
wxCURHandler 
For loading and saving. 
wxANIHandler 
For loading only. 
When saving in PCX format, wxPCXHandler will count the number of different colours in the image; if there are 256 or less colours, it will save as 8 bit, else it will save as 24 bit.
Loading PNMs only works for ASCII or raw RGB images. When saving in PNM format, wxPNMHandler will always save as raw RGB.
End Rem
Type wxImage Extends wxObject

	Function _create:wxImage(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxImage = New wxImage
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates an image from a filename, TStream or wxInputStream.
	about: Filenames support use of the '::' format.
	End Rem
	Method Create:wxImage(name:Object, kind:Int, index:Int = -1)
		
		If TStream(name) Then
			' create a maxInputStream and attempt to load
			Local stream:wxMaxInputStream = New wxMaxInputStream.Create(name)
			wxObjectPtr = bmx_wximage_createfromstream(stream.wxStreamPtr, kind, index)
			TStream(name).Close()
			
		Else If wxInputStream(name) Then
			' load using this input stream
			wxObjectPtr = bmx_wximage_createfromstream(wxInputStream(name).wxStreamPtr, kind, index)
		Else
			Local str:String = String(name)
			If str Then
				If str.Find( "::",0 ) > 0 Then
					' Create a stream and load it
					Local stream:TStream = ReadStream(str)
					Local inp:wxMaxInputStream = New wxMaxInputStream.Create(stream)
					wxObjectPtr = bmx_wximage_createfromstream(inp.wxStreamPtr, kind, index)
					stream.Close()
				Else
					' use the default loader
					wxObjectPtr = bmx_wximage_create(str, kind, index)
				End If
			Else
				' none of the above? Create a null image.
				wxObjectptr = bmx_wximage_createnull()
			End If
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Loads an image from a file/stream.
	End Rem
	Function CreateFromFile:wxImage(name:Object, kind:Int, index:Int = -1)
		Return New wxImage.Create(name, kind, index)
	End Function
	
	Function CreateNullImage:wxImage()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateEmptyImage:wxImage(width:Int, height:Int)
		Local this:wxImage = New wxImage
		
		this.wxObjectPtr = bmx_wximage_createempty(width, height)
		
		Return this
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateImageFromMime(name:String, mimeType:String)
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_wximage_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

	Rem
	bbdoc: Adds a handler to the end of the static list of format handlers.
	End Rem
	Function AddHandler(handler:wxImageHandler)
		bmx_wximage_addhandler(handler.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Blurs the image in both horizontal and vertical directions by the specified pixel blurRadius.
	about: This should not be used when using a single mask colour for transparency.
	End Rem
	Method Blur:wxImage(blurRadius:Int)
		Return _create(bmx_wximage_blur(wxObjectPtr, blurRadius))
	End Method
	
	Rem
	bbdoc: Blurs the image in the horizontal direction only.
	about: This should not be used when using a single mask colour for transparency.
	End Rem
	Method BlurHorizontal:wxImage(blurRadius:Int)
		Return _create(bmx_wximage_blurhorizontal(wxObjectPtr, blurRadius))
	End Method
	
	Rem
	bbdoc: Blurs the image in the vertical direction only.
	about: This should not be used when using a single mask colour for transparency.
	End Rem
	Method BlurVertical:wxImage(blurRadius:Int)
		Return _create(bmx_wximage_blurvertical(wxObjectPtr, blurRadius))
	End Method
	
	Rem
	bbdoc: If the image has alpha channel, this method converts it to mask.
	returns: False if FindFirstUnusedColour returns false, True otherwise.
	about: All pixels with alpha value less than threshold are replaced with mask colour and the alpha
	channel is removed. Mask colour is chosen automatically using FindFirstUnusedColour.
	<p>
	If the image image doesn't have alpha channel, ConvertAlphaToMask does nothing.
	</p>
	End Rem
	Method ConvertAlphaToMask:Int(threshold:Int = 128)
		Return bmx_wximage_convertalphatomask(wxObjectPtr, threshold)
	End Method
	
	Rem
	bbdoc: Returns a greyscale version of the image.
	about: The returned image uses the luminance component of the original to calculate the greyscale.
	Defaults to using ITU-T BT.601 when converting to YUV, where every pixel equals
	<tt>(R * lr) + (G * lg) + (B * lb)</tt>.
	End Rem
	Method ConvertToGreyscale:wxImage(lr:Double = 0.299:Double, lg:Double = 0.587:Double, lb:Double = 0.114:Double)
		Return _create(bmx_wximage_converttogreyscale(wxObjectPtr, lr, lg, lb))
	End Method
	
	Rem
	bbdoc: Returns monochromatic version of the image.
	about: The returned image has white colour where the original has (r,g,b) colour and black colour
	everywhere else.
	End Rem
	Method ConvertToMono:wxImage(r:Int, g:Int, b:Int)
		Return _create(bmx_wximage_converttomono(wxObjectPtr, r, g, b))
	End Method
	
	Rem
	bbdoc: Returns an identical copy of the image.
	End Rem
	Method Copy:wxImage()
		Return _create(bmx_wximage_copy(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Destroys the image data.
	End Rem
	Method Destroy()
		bmx_wximage_destroy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the first colour that is never used in the image.
	returns: False if there is no unused colour left, True on success.
	about: The search begins at given initial colour and continues by increasing R, G and B components
	(in this order) by 1 until an unused colour is found or the colour space exhausted.
	<p>
	Note that this method involves computing the histogram, which is computationally intensive operation.
	</p>
	End Rem
	Method FindFirstUnusedColour:Int(r:Int Var, g:Int Var, b:Int Var, startR:Int = 1, startG:Int = 0, startB:Int = 0)
		Return bmx_wximage_findfirstunusedcolour(wxObjectPtr, Varptr r, Varptr g, Varptr b, startR, startG, startB)
	End Method
	
	Rem
	bbdoc: Iterates all registered wxImageHandler objects, and returns a string containing file extension masks suitable for passing to file open/save dialog boxes.
	about: The format of the returned string is "(*.ext1;*.ext2)|*.ext1;*.ext2".
	End Rem
	Function GetImageExtWildcard:String()
		Return bmx_wximage_getimageextwildcard()
	End Function
	
	Rem
	bbdoc: Returns the alpha value for the given pixel.
	about: This method may only be called for the images with alpha channel, use HasAlpha to check for this.
	<p>
	The returned value is the opacity of the image, i.e. the value of 0 corresponds to the transparent pixels
	while the value of 255 -- to the opaque ones.
	</p>
	End Rem
	Method GetAlpha:Int(x:Int, y:Int)
		Return bmx_wximage_getalpha(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns the blue intensity at the given coordinate.
	End Rem
	Method GetBlue:Int(x:Int, y:Int)
		Return bmx_wximage_getblue(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns the image data as an (unsigned char) array.
	about: This is most often used when doing direct image manipulation. The return value points to an array
	of characters in RGBRGBRGB... format in the top-to-bottom, left-to-right order, that is the first RGB
	triplet corresponds to the pixel first pixel of the first row, the second one --- to the second pixel
	of the first row and so on until the end of the first row, with second row following after it and so on.
	<p>
	You should not delete the returned pointer nor pass it to wxImage::SetData.
	</p>
	End Rem
	Method GetData:Byte Ptr()
		Return bmx_wximage_getdata(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the green intensity at the given coordinate.
	End Rem
	Method GetGreen:Int(x:Int, y:Int)
		Return bmx_wximage_getgreen(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Gets the height of the image in pixels.
	End Rem
	Method GetHeight:Int()
		Return bmx_wximage_getheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the blue value of the mask colour.
	End Rem
	Method GetMaskBlue:Int()
		Return bmx_wximage_getmaskblue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the green value of the mask colour.
	End Rem
	Method GetMaskGreen:Int()
		Return bmx_wximage_getmaskgreen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the red value of the mask colour.
	End Rem
	Method GetMaskRed:Int()
		Return bmx_wximage_getmaskred(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the current mask colour or find a suitable unused colour that could be used as a mask colour.
	returns: True if the image currently has a mask.
	End Rem
	Method GetOrFindMaskColour:Int(r:Int Var, g:Int Var, b:Int Var)
		Return bmx_wximage_getorfindmaskcolour(wxObjectPtr, Varptr r, Varptr g, Varptr b)
	End Method
	
	Rem
	bbdoc: Returns the palette associated with the image.
	about: Currently the palette is only used when converting to wxBitmap under Windows. Some of the
	wxImage handlers have been modified to set the palette if one exists in the image file (usually 256
	or less colour images in GIF or PNG format).
	End Rem
	Method GetPalette:wxPalette()
	End Method
	
	Rem
	bbdoc: Returns the red intensity at the given coordinate.
	End Rem
	Method GetRed:Int(x:Int, y:Int)
		Return bmx_wximage_getred(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns a sub image of the current one as long as the rect belongs entirely to the image.
	End Rem
	Method GetSubImage:wxImage(x:Int, y:Int, w:Int, h:Int)
		Return _create(bmx_wximage_getsubimage(wxObjectPtr, x, y, w, h))
	End Method
	
	Rem
	bbdoc: Gets the width of the image in pixels.
	End Rem
	Method GetWidth:Int()
		Return bmx_wximage_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this image has alpha channel, false otherwise.
	End Rem
	Method HasAlpha:Int()
		Return bmx_wximage_hasalpha(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if there is a mask active, false otherwise.
	End Rem
	Method HasMask:Int()
		Return bmx_wximage_hasmask(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets a user-defined option.
	about: The method is case-insensitive to name.
	<p>
	For example, when saving as a JPEG file, the option quality is used, which is a number between 0 and 100
	(0 is terrible, 100 is very good).
	</p>
	End Rem
	Method GetOption:String(name:String)
		Return bmx_wximage_getoption(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Gets a user-defined option as an integer.
	about: The method is case-insensitive to name.
	<p>
	If the given option is not present, the function returns 0. Use wxImage::HasOption is 0 is a possibly valid
	value for the option.
	</p>
	End Rem
	Method GetOptionInt:Int(name:String)
		Return bmx_wximage_getoptionint(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Returns true if the given option is present.
	about: The method is case-insensitive to name.
	End Rem
	Method HasOption:Int(name:String)
		Return bmx_wximage_hasoption(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: Initializes the image alpha channel data.
	about: It is an error to call this if the image already has alpha data. If it doesn't, alpha data will
	be by default initialized to all pixels being fully opaque. But if the image has a a mask colour, all
	mask pixels will be completely transparent.
	End Rem
	Method InitAlpha()
		bmx_wximage_initalpha(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds a handler at the start of the static list of format handlers.
	End Rem
	Function InsertHandler(handler:wxImageHandler)
		bmx_wximage_inserthandler(handler.wxObjectPtr)
	End Function
	
	Rem
	bbdoc: Returns true if the given pixel is transparent, i.e. either has the mask colour if this image has a mask or if this image has alpha channel and alpha value of this pixel is strictly less than threshold.
	End Rem
	Method IsTransparent:Int(x:Int, y:Int, threshold:Int = 128)
		Return bmx_wximage_istransparent(wxObjectPtr, x, y, threshold)
	End Method
	
	Rem
	bbdoc: Returns true if image data is present.
	End Rem
	Method IsOk:Int()
		Return bmx_wximage_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the handler with the given name, and removes it.
	about: The handler is not deleted.
	End Rem
	Function RemoveHandler:Int(name:String)
		Return bmx_wximage_removehandler(name)
	End Function
	
	Rem
	bbdoc: Returns a mirrored copy of the image.
	about: The parameter @horizontally indicates the orientation.
	End Rem
	Method Mirror:wxImage(horizontally:Int = True)
		Return _create(bmx_wximage_mirror(wxObjectPtr, horizontally))
	End Method
	
	Rem
	bbdoc: Replaces the colour specified by r1,g1,b1 by the colour r2,g2,b2.
	End Rem
	Method Replace(r1:Int, g1:Int, b1:Int, r2:Int, g2:Int, b2:Int)
		bmx_wximage_replace(wxObjectPtr, r1, g1, b1, r2, g2, b2)
	End Method
	
	Rem
	bbdoc: Changes the size of the image in-place by scaling it.
	returns: The (modified) image itself.
	about: After a call to this method, the image will have the given width and height.
	For a description of the quality parameter, see the Scale method.
	End Rem
	Method Rescale:wxImage(width:Int, height:Int, quality:Int = wxIMAGE_QUALITY_NORMAL)
		bmx_wximage_rescale(wxObjectPtr, width, height, quality)
		Return Self
	End Method
	
	Rem
	bbdoc: Changes the size of the image in-place without scaling it by adding either a border with the given colour or cropping as necessary.
	returns: The (modified) image itself.
	about: The image is pasted into a new image with the given size and background colour at the position pos
	relative to the upper left of the new image. If red = green = blue = -1 then use either the current mask
	colour if set or find, use, and set a suitable mask colour for any newly exposed areas.
	End Rem
	Method Resize:wxImage(width:Int, height:Int, x:Int, y:Int, red:Int = -1, green:Int = -1, blue:Int = -1)
		bmx_wximage_resize(wxObjectPtr, width, height, x, y, red, green, blue)
		Return Self
	End Method
	
	Rem
	bbdoc: Rotates the image about the given point, by angle radians.
	returns: The rotated image, leaving this image intact.
	about: Passing true to interpolating results in better image quality, but is slower. If the image has a mask,
	then the mask colour is used for the uncovered pixels in the rotated image background. Else, black (rgb 0, 0, 0)
	will be used.
	End Rem
	Method Rotate:wxImage(angle:Double, centreX:Int, centreY:Int, interpolating:Int = True, offsetX:Int Var, offsetY:Int Var)
		Return wxImage._create(bmx_wximage_rotate(wxObjectPtr, angle, centreX, centreY, interpolating, Varptr offsetX, Varptr offsetY))
	End Method
	
	Rem
	bbdoc: Rotates the hue of each pixel in the image by angle, which is a double in the range of -1.0 to +1.0, where -1.0 corresponds to -360 degrees and +1.0 corresponds to +360 degrees.
	End Rem
	Method RotateHue(angle:Double)
		bmx_wximage_rotatehue(wxObjectPtr, angle)
	End Method
	
	Rem
	bbdoc: Returns a copy of the image rotated 90 degrees in the direction indicated by clockwise.
	End Rem
	Method Rotate90:wxImage(clockwise:Int = True)
		Return _create(bmx_wximage_rotate90(wxObjectPtr, clockwise))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SaveFile()
	End Method
	
	Rem
	bbdoc: Returns a scaled version of the image.
	about: This is also useful for scaling bitmaps in general as the only other way to scale bitmaps is
	to blit a wxMemoryDC into another wxMemoryDC.
	End Rem
	Method Scale:wxImage(width:Int, height:Int, quality:Int = wxIMAGE_QUALITY_NORMAL)
		Return _create(bmx_wximage_scale(wxObjectPtr, width, height, quality))
	End Method
	
	Rem
	bbdoc: Returns a resized version of this image without scaling it by adding either a border with the given colour or cropping as necessary.
	about: The image is pasted into a new image with the given size and background colour at the position pos
	relative to the upper left of the new image. If red = green = blue = -1 then use either the current mask
	colour if set or find, use, and set a suitable mask colour for any newly exposed areas.
	End Rem
	Method Size:wxImage(width:Int, height:Int, x:Int, y:Int, red:Int = -1, green:Int = -1, blue:Int = -1)
		Return _create(bmx_wximage_size(wxObjectPtr, width, height, x, y, red, green, blue))
	End Method
	
	Rem
	bbdoc: Sets the alpha value for the given pixel.
	about: This method should only be called if the image has alpha channel data, use HasAlpha to check for
	this.
	End Rem
	Method SetAlpha(x:Int, y:Int, alpha:Int)
		bmx_wximage_setalpha(wxObjectPtr, x, y, alpha)
	End Method
	
	Rem
	bbdoc: Sets the image data without performing checks.
	about: The data given must have the size (width*height*3) or results will be unexpected. Don't use this
	method if you aren't sure you know what you are doing.
	<p>
	The data must have been allocated with Blitz's MemAlloc() or C/C++'s malloc().
	</p>
	<p>
	After this call the pointer to the data is owned by the wxImage object, that will be responsible for deleting
	it. Do not pass to this method a pointer obtained through wxImage::GetData.
	</p>
	End Rem
	Method SetData(data:Byte Ptr)
		bmx_wximage_setdata(wxObjectPtr, data)
	End Method
	
	Rem
	bbdoc: Specifies whether there is a mask or not.
	about: The area of the mask is determined by the current mask colour.
	End Rem
	Method SetMask(hasMask:Int = True)
		bmx_wximage_setmask(wxObjectPtr, hasMask)
	End Method
	
	Rem
	bbdoc: Sets the mask colour for this image (and tells the image to use the mask).
	End Rem
	Method SetMaskColour(red:Int, green:Int, blue:Int)
		bmx_wximage_setmaskcolour(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: Sets image's mask so that the pixels that have RGB value of mr,mg,mb in mask will be masked in the image.
	about: This is done by first finding an unused colour in the image, setting this colour as the mask colour
	and then using this colour to draw all pixels in the image who corresponding pixel in mask has given RGB
	value.
	End Rem
	Method SetMaskFromImage:Int(mask:wxImage, mr:Int, mg:Int, mb:Int)
		Return bmx_wximage_setmaskfromimage(wxObjectPtr, mask.wxObjectPtr, mr, mg, mb)
	End Method
	
	Rem
	bbdoc: Sets a user-defined option.
	about: The method is case-insensitive to name.
	<p>
	For example, when saving as a JPEG file, the option <b>quality</b> is used, which is a number between
	0 and 100 (0 is terrible, 100 is very good).
	</p>
	End Rem
	Method SetOption(name:String, value:String)
		bmx_wximage_setoption(wxObjectPtr, name, value)
	End Method

	Rem
	bbdoc: Sets a user-defined option.
	about: The method is case-insensitive to name.
	<p>
	For example, when saving as a JPEG file, the option <b>quality</b> is used, which is a number between
	0 and 100 (0 is terrible, 100 is very good).
	</p>
	End Rem
	Method SetOptionInt(name:String, value:Int)
		bmx_wximage_setoptionint(wxObjectPtr, name, value)
	End Method
	
	Rem
	bbdoc: Associates a palette with the image.
	about: The palette may be used when converting wxImage to wxBitmap (MSW only at present) or in file
	save operations (none as yet).
	End Rem
	Method SetPalette(palette:wxPalette)
		bmx_wximage_setpalette(wxObjectPtr, palette.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the pixel at the given coordinate.
	about: This routine performs bounds-checks for the coordinate so it can be considered a safe way to
	manipulate the data, but in some cases this might be too slow so that the data will have to be set directly.
	In that case you will have to get access to the image data using the GetData method.
	End Rem
	Method SetRGB(x:Int, y:Int, red:Int, green:Int, blue:Int)
		bmx_wximage_setrgb(wxObjectPtr, x, y, red, green, blue)
	End Method
	
	Rem
	bbdoc: Sets the colour of the pixels within the given rectangle.
	about: This routine performs bounds-checks for the coordinate so it can be considered a safe way to
	manipulate the data.
	End Rem
	Method SetRGBRange(x:Int, y:Int, w:Int, h:Int, red:Int, green:Int, blue:Int)
		bmx_wximage_setrgbrange(wxObjectPtr, x, y, w, h, red, green, blue)
	End Method
	
	Rem
	bbdoc: Sets the colour of the pixels within the given rectangle.
	about: This routine performs bounds-checks for the coordinate so it can be considered a safe way to
	manipulate the data.
	End Rem
	Method SetRGBRect(rect:wxRect, red:Int, green:Int, blue:Int)
		bmx_wximage_setrgbrect(wxObjectPtr, rect.wxObjectPtr, red, green, blue)
	End Method

End Type

Rem
bbdoc: 
End Rem
Global wxNullImage:wxImage = wxImage._create(bmx_wximage_createnull())

Type wxImageHandler Extends wxObject

End Type

Rem
bbdoc: 
End Rem
Type wxPNGHandler Extends wxImageHandler

	Global keepAlive:wxPNGHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxpnghandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxXPMHandler Extends wxImageHandler

	Global keepAlive:wxXPMHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxxpmhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxGIFHandler Extends wxImageHandler

	Global keepAlive:wxGIFHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxgifhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type


Rem
bbdoc: 
End Rem
Type wxBMPHandler Extends wxImageHandler

	Global keepAlive:wxBMPHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxbmphandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxJPEGHandler Extends wxImageHandler

	Global keepAlive:wxJPEGHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxjpeghandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPCXHandler Extends wxImageHandler

	Global keepAlive:wxPCXHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxpcxhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPNMHandler Extends wxImageHandler

	Global keepAlive:wxPNMHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxpnmhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxTIFFHandler Extends wxImageHandler

	Global keepAlive:wxTIFFHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxtiffhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxTGAHandler Extends wxImageHandler

	Global keepAlive:wxTGAHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxtgahandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxICOHandler Extends wxImageHandler

	Global keepAlive:wxICOHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxicohandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxCURHandler Extends wxImageHandler

	Global keepAlive:wxCURHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxcurhandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxANIHandler Extends wxImageHandler

	Global keepAlive:wxANIHandler
	
	Method New()
		If Not keepAlive Then
			wxObjectPtr = bmx_wxanihandler_create()
			keepAlive = Self
		Else
			wxObjectPtr = keepAlive.wxObjectPtr
		End If
	End Method
	
End Type




