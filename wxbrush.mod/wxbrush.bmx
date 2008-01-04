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
bbdoc: wxBrush
End Rem
Module wx.wxBrush

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
bbdoc: A brush is a drawing tool for filling in areas.
about: It is used for painting the background of rectangles, ellipses, etc. It has a colour and a style.
End Rem
Type wxBrush Extends wxGDIObject

	Function _create:wxBrush(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBrush = New wxBrush
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a brush from a colour name and style.
	End Rem
	Method Create:wxBrush(name:String, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxbrush_create(name, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a brush from a colour object and style.
	End Rem
	Method CreateFromColour:wxBrush(colour:wxColour, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxbrush_createfromcolour(colour.wxObjectPtr, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns a reference to the brush colour.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxbrush_getcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the stipple bitmap.
	about: If the brush does not have a wxSTIPPLE style, this bitmap may be non-NULL but uninitialised
	(wxBitmap:IsOk returns false).
	End Rem
	Method GetStipple:wxBitmap()
		Return wxBitmap._create(bmx_wxbrush_getstipple(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the brush style
	about: One of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxTRANSPARENT</td><td>Transparent (no fill). </td></tr>
	<tr><td>wxSOLID</td><td>Solid. </td></tr>
	<tr><td>wxBDIAGONAL_HATCH</td><td>Backward diagonal hatch. </td></tr>
	<tr><td>wxCROSSDIAG_HATCH</td><td>Cross-diagonal hatch. </td></tr>
	<tr><td>wxFDIAGONAL_HATCH</td><td>Forward diagonal hatch. </td></tr>
	<tr><td>wxCROSS_HATCH</td><td>Cross hatch. </td></tr>
	<tr><td>wxHORIZONTAL_HATCH</td><td>Horizontal hatch. </td></tr>
	<tr><td>wxVERTICAL_HATCH</td><td>Vertical hatch. </td></tr>
	<tr><td>wxSTIPPLE</td><td>Stippled using a bitmap. </td></tr>
	<tr><td>wxSTIPPLE_MASK_OPAQUE</td><td>Stippled using a bitmap's mask. </td></tr>
	</table>
	End Rem
	Method GetStyle:Int()
		Return bmx_wxbrush_getstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the style of the brush is any of hatched fills.
	End Rem
	Method IsHatch:Int()
		Return bmx_wxbrush_ishatch(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the brush is initialised.
	about: It will return false if the default constructor has been used (for example, the brush is a
	member of a class, or NULL has been assigned to it).
	End Rem
	Method IsOk:Int()
		Return bmx_wxbrush_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the brush colour using a colour name from the colour database.
	End Rem
	Method SetColour(colour:String)
		bmx_wxbrush_setcolour(wxObjectPtr, colour:String)
	End Method
	
	Rem
	bbdoc: Sets the brush colour using a reference to a colour object.
	End Rem
	Method SetFromColour(colour:wxColour)
		bmx_wxbrush_setfromcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the brush colour using a reference to a colour object.
	End Rem
	Method SetFromRGB(red:Int, green:Int, blue:Int)
		bmx_wxbrush_setfromrgb(wxObjectPtr, red, green, blue)
	End Method

	Rem
	bbdoc: Sets the stipple bitmap.
	about: The style will be set to wxSTIPPLE, unless the bitmap has a mask associated to it, in which
	case the style will be set to wxSTIPPLE_MASK_OPAQUE.
	<p>
	If the wxSTIPPLE variant is used, the bitmap will be used to fill out the area to be drawn. If the
	wxSTIPPLE_MASK_OPAQUE is used, the current text foreground and text background determine what colours
	are used for displaying and the bits in the mask (which is a mono-bitmap actually) determine where to
	draw what.
	</p>
	<p>
	Note that Windows 98 and NT as well as GTK support arbitrary bitmaps.
	</p>
	End Rem
	Method SetStipple(bitmap:wxBitmap)
		bmx_wxbrush_setstipple(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the brush style.
	about: @style is one of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxTRANSPARENT</td><td>Transparent (no fill). </td></tr>
	<tr><td>wxSOLID</td><td>Solid. </td></tr>
	<tr><td>wxBDIAGONAL_HATCH</td><td>Backward diagonal hatch. </td></tr>
	<tr><td>wxCROSSDIAG_HATCH</td><td>Cross-diagonal hatch. </td></tr>
	<tr><td>wxFDIAGONAL_HATCH</td><td>Forward diagonal hatch. </td></tr>
	<tr><td>wxCROSS_HATCH</td><td>Cross hatch. </td></tr>
	<tr><td>wxHORIZONTAL_HATCH</td><td>Horizontal hatch. </td></tr>
	<tr><td>wxVERTICAL_HATCH</td><td>Vertical hatch. </td></tr>
	<tr><td>wxSTIPPLE</td><td>Stippled using a bitmap. </td></tr>
	<tr><td>wxSTIPPLE_MASK_OPAQUE</td><td>Stippled using a bitmap's mask. </td></tr>
	</table>
	End Rem
	Method SetStyle(style:Int)
		bmx_wxbrush_setstyle(wxObjectPtr, style)
	End Method
		

	Method Delete()
		If wxObjectPtr Then
			bmx_wxbrush_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Function wxBLACK_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_black())
End Function

Function wxBLUE_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_blue())
End Function

Function wxCYAN_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_cyan())
End Function

Function wxGREEN_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_green())
End Function

Function wxGREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_grey())
End Function

Function wxLIGHT_GREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_lightgrey())
End Function

Function wxMEDIUM_GREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_mediumgrey())
End Function

Function wxRED_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_red())
End Function

Function wxTRANSPARENT_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_transparent())
End Function

Function wxWHITE_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_white())
End Function

