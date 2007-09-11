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
bbdoc: wxDC
End Rem
Module wx.wxDC

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
bbdoc: 
End Rem
Type wxDC Extends wxObject

	Function _create:wxDC(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDC = New wxDC
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Adds the specified point to the bounding box which can be retrieved with MinX, MaxX and MinY, MaxY methods.
	End Rem
	Method CalcBoundingBox(x:Int, y:Int)
		wx_wxdc_calcboundingbox(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Clears the device context using the current background brush.
	End Rem
	Method Clear()
		bmx_wxdc_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Performs all necessary computations for given platform and context type after each change of scale and origin parameters.
	about: Usually called automatically internally after such changes.
	End Rem
	Method ComputeScaleAndOrigin()
		wx_wxdc_computescaleandorigin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Displays a cross hair using the current pen.
	about: This is a vertical and horizontal line the height and width of the window, centred on the given point.
	End Rem
	Method CrossHair(x:Int, y:Int)
		wx_wxdc_crosshair(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Destroys the current clipping region so that none of the DC is clipped. See also wxDC::SetClippingRegion.
	End Rem
	Method DestroyClippingRegion()
		wx_wxdc_destroyclippingregion(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Convert device X coordinate to logical coordinate, using the current mapping mode.
	End Rem
	Method DeviceToLogicalX:Int(x:Int)
		Return wx_wxdc_devicetologicalx(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Convert device X coordinate to relative logical coordinate, using the current mapping mode but ignoring the x axis orientation.
	about: Use this method for converting a width, for example.
	End Rem
	Method DeviceToLogicalXRel:Int(x:Int)
		Return wx_wxdc_devicetologicalxrel(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Converts device Y coordinate to logical coordinate, using the current mapping mode.
	End Rem
	Method DeviceToLogicalY:Int(y:Int)
		Return wx_wxdc_devicetologicaly(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: Convert device Y coordinate to relative logical coordinate, using the current mapping mode but ignoring the y axis orientation.
	about: Use this method for converting a height, for example.
	End Rem
	Method DeviceToLogicalYRe:Int(y:Int)
		Return wx_wxdc_devicetologicalyrel(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: Draws an arc of a circle, centred on (xc, yc), with starting point (x1, y1) and ending at (x2, y2).
	about: The current pen is used for the outline and the current brush for filling the shape.
	<p>
	The arc is drawn in an anticlockwise direction from the start point to the end point.
	</p>
	End Rem
	Method DrawArc(x1:Int, y1:Int, x2:Int, y2:Int, xc:Int, yc:Int)
		wx_wxdc_drawarc(wxObjectPtr, x1, y1, x2, y2, xc, yc)
	End Method
	
	Rem
	bbdoc: Draw a bitmap on the device context at the specified point.
	about: If transparent is True and the bitmap has a transparency mask, the bitmap will be drawn
	transparently.
	<p>
	When drawing a mono-bitmap, the current text foreground colour will be used to draw the foreground of the
	bitmap (all bits set to 1), and the current text background colour to draw the background (all bits set
	to 0). See also SetTextForeground, SetTextBackground and wxMemoryDC.
	</p>
	End Rem
	Method DrawBitmap(bitmap:wxBitmap, x:Int, y:Int, transparent:Int)
		wx_wxdc_drawbitmap(wxObjectPtr, bitmap.wxObjectPtr, x, y, transparent)
	End Method
	
	Rem
	bbdoc: Draws a check mark inside the given rectangle.
	End Rem
	Method DrawCheckMark(x:Int, y:Int, w:Int, h:Int)
		wx_wxdc_drawcheckmark(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Draws a circle with the given centre and radius.
	End Rem
	Method DrawCircle(x:Int, y:Int, radius:Int)
		wx_wxdc_drawcircle(wxObjectPtr, x, y, radius)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawEllipse(x:Int, y:Int, width:Int, height:Int)
		bmx_wxdc_drawellipse(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawEllipticArc(x:Int, y:Int, width:Int, height:Int, _start:Double, _end:Double)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawIcon(icon:wxIcon, x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawLabel(text:String, x:Int, y:Int, width:Int, height:Int, image:wxBitmap = Null, ..
			alignment:Int = wxALIGN_LEFT | wxALIGN_TOP, indexAccel:Int = -1)
	End Method
	
	Rem
	bbdoc: Draws a line from the first point to the second.
	about: The current pen is used for drawing the line. Note that the point (x2, y2) is not part of
	the line and is not drawn by this function (this is consistent with the behaviour of many
	other toolkits).
	End Rem
	Method DrawLine(x1:Int, y1:Int, x2:Int, y2:Int)
		bmx_wxdc_drawline(wxObjectPtr, x1, y1, x2, y2)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawLines()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawPolygon()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawPolyPolygon()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawPoint(x:Int, y:Int)
	End Method
	
	Rem
	bbdoc: Draws a rectangle with the given top left corner, and with the given size.
	about: The current pen is used for the outline and the current brush for filling the shape.
	End Rem
	Method DrawRectangle(x:Int, y:Int, width:Int, height:Int)
		bmx_wxdc_drawrectangle(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawRotatedText(text:String, x:Int, y:Int, angle:Double)
	End Method
	
	Rem
	bbdoc: Draws a rectangle with the given top left corner, and with the given size.
	about: The corners are quarter-circles using the given radius. The current pen is used for the outline
	and the current brush for filling the shape.
	<p>
	If radius is positive, the value is assumed to be the radius of the rounded corner. If radius is negative,
	the absolute value is assumed to be the proportion of the smallest dimension of the rectangle. This means
	that the corner can be a sensible size relative to the size of the rectangle, and also avoids the strange
	effects X produces when the corners are too big for the rectangle.
	</p>
	End Rem
	Method DrawRoundedRectangle(x:Int, y:Int, width:Int, height:Int, radius:Double)
		bmx_wxdc_drawroundedrectangle(wxObjectPtr, x, y, width, height, radius)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawSpline()
	End Method
	
	Rem
	bbdoc: Draws a text string at the specified point, using the current text font, and the current text foreground and background colours.
	about: The coordinates refer to the top-left corner of the rectangle bounding the string.
	See wxDC::GetTextExtent for how to get the dimensions of a text string, which can be used to position
	the text more precisely
	End Rem
	Method DrawText(text:String, x:Int, y:Int)
		bmx_wxdc_drawtext(wxObjectPtr, text, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndDoc()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndPage()
	End Method
	
	Rem
	bbdoc: Gets the character height of the currently set font.
	End Rem
	Method GetCharHeight:Int()
		Return bmx_wxdc_getcharheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTextExtent(text:String, w:Int Var, h:Int Var)
		bmx_wxdc_gettextextent(wxObjectPtr, text, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Sets the current background brush for the DC.
	End Rem
	Method SetBackground(brush:wxBrush)
		bmx_wxdc_setbackground(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This setting determines whether text will be drawn with a background colour or not.
	about: @mode may be one of wxSOLID and wxTRANSPARENT.
	End Rem
	Method SetBackgroundMode(mode:Int)
		bmx_wxdc_setbackgroundmode(wxObjectPtr, mode)
	End Method
	
	Rem
	bbdoc: Sets the current brush for the DC.
	about: If the argument is wxNullBrush, the current brush is selected out of the device context,
	and the original brush restored, allowing the current brush to be destroyed safely.
	End Rem
	Method SetBrush(brush:wxBrush)
		bmx_wxdc_setbrush(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the clipping region for this device context to the intersection of the given region described by the parameters of this method and the previously set clipping region.
	about: You should call DestroyClippingRegion if you want to set the clipping region exactly to the
	region specified.
	<p>
	The clipping region is an area to which drawing is restricted. Possible uses for the clipping region
	are for clipping text or for speeding up window redraws when only a known area of the screen is damaged.
	</p>
	End Rem
	Method SetClippingRegion(x:Int, y:Int, width:Int, height:Int)
		bmx_wxdc_setclippingregion(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: Sets the device origin (i.e., the origin in pixels after scaling has been applied).
	about: This method may be useful in Windows printing operations for placing a graphic on a page.
	End Rem
	Method SetDeviceOrigin(x:Int, y:Int)
		bmx_wxdc_setdeviceorigin(wxObjectPtr, x, y)
	End Method	

	Rem
	bbdoc: Sets the current font for the DC.
	about: It must be a valid font, in particular you should not pass wxNullFont to this method.
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxdc_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMapMode(mode:Int)
		bmx_wxdc_setmapmode(wxObjectPtr, mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPalette()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPen(pen:wxPen)
		bmx_wxdc_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTextBackground(colour:wxColour)
		bmx_wxdc_settextbackground(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTextForeground(colour:wxColour)
		bmx_wxdc_settextforeground(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetUserScale(xScale:Double, yScale:Double)
		bmx_wxdc_setuserscale(wxObjectPtr, xScale, yScale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method StartDoc:Int(message:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method StartPage:Int()
	End Method

	Rem
	bbdoc: Frees up the device context.
	about: This is required when you are finished with it, since on Windows, not performing this action can result in
	undesired effects.
	End Rem
	Method Free()
	End Method

End Type

Type wxWindowDC Extends wxDC
End Type

Rem
bbdoc: wxMirrorDC is a simple wrapper which is always associated with a real wxDC object and either forwards all of its operations to it without changes (no mirroring takes place) or exchanges x and y coordinates which makes it possible to reuse the same code to draw a figure and its mirror -- i.e. reflection related to the diagonal line x == y.
End Rem
Type wxMirrorDC Extends wxDC

	Rem
	bbdoc: Creates a (maybe) mirrored DC associated with the real dc.
	about: Everything drawn on wxMirrorDC will appear (and maybe mirrored) on @dc.
	End Rem
	Function CreateMirrorDC:wxMirrorDC(dc:wxDC, mirror:Int)
		Return New wxMirrorDC.Create(dc, mirror)
	End Function
	
	Rem
	bbdoc: Creates a (maybe) mirrored DC associated with the real dc.
	about: Everything drawn on wxMirrorDC will appear (and maybe mirrored) on @dc.
	End Rem
	Method Create:wxMirrorDC(dc:wxDC, mirror:Int)
		wxObjectPtr = bmx_wxmirrordc_create(dc.wxObjectPtr, mirror)
		Return Self
	End Method
	
End Type
