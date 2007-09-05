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
bbdoc: wxImage
End Rem
Module wx.wxImage

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
	
	Function CreateImage:wxImage(name:String, flag:Int)
	End Function
	
	Function CreateNullImage:wxImage()
	End Function
	
	Function CreateEmptyImage:wxImage(width:Int, height:Int)
		Local this:wxImage = New wxImage
		
		this.wxObjectPtr = bmx_wximage_createempty(width, height)
		
		Return this
	End Function
	
	Function CreateImageFromMime(name:String, mimeType:String)
	End Function

	Rem
	bbdoc: Sets the pixel at the given coordinate.
	about: This routine performs bounds-checks for the coordinate so it can be considered a safe way to
	manipulate the data, but in some cases this might be too slow so that the data will have to be set directly.
	In that case you will have to get access to the image data using the GetData method.
	End Rem
	Method SetRGB(x:Int, y:Int, red:Int, green:Int, blue:Int)
		bmx_wximage_setrgb(wxObjectPtr, x, y, red, green, blue)
	End Method
	
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
	bbdoc: 
	End Rem
	Method Blur:wxImage(blurRadius:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method BlurHorizontal:wxImage(blurRadius:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method BlurVertical:wxImage(blurRadius:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ConvertAlphaToMask:Int(threshold:Int = 128)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ConvertToGreyscale:wxImage(lr:Double = 0.299, lg:Double = 0.587, lb:Double = 0.114)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ConvertToMono:wxImage(r:Int, g:Int, b:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Copy:wxImage()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Destroy()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FindFirstUnusedColour:Int(r:Int Var, g:Int Var, b:Int Var, startR:Int = 1, startG:Int = 0, startB:Int = 0)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function GetImageExtWildcard:String()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetAlpha:Int(x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBlue:Int(x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetData:Byte Ptr()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGreen:Int(x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetHeight:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaskBlue:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaskGreen:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaskRed:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOrFindMaskColour:Int(r:Int Var, g:Int Var, b:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPalette()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRed:Int(x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSubImage:wxImage(x:Int, y:Int, w:Int, h:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetWidth:Int()
		Return bmx_wximage_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasAlpha:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasMask:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOption:String(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOptionInt:Int(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasOption:Int(name:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InitAlpha()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function InsertHandler(handler:wxImageHandler)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method IsTransparent:Int(x:Int, y:Int, threshold:Int = 128)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsOk:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function RemoveHandler:Int(name:String)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Mirror:wxImage(horizontally:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Replace(r1:Int, g1:Int, b1:Int, r2:Int, g2:Int, b2:Int)
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
	
End Type

Type wxImageHandler Extends wxObject

End Type

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

