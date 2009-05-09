' Copyright (c) 2007-2009 Bruce A Henderson
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
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: A wxDC is a device context onto which graphics and text can be drawn.
about: It is intended to represent a number of output devices in a generic way, so a window can have a
device context associated with it, and a printer also has a device context. In this way, the same piece
of code may write to a number of different devices, if the device context is used as a parameter.
<p>
Notice that wxDC is an abstract base class and can't be created directly, please use wxPaintDC, wxClientDC,
wxWindowDC, wxScreenDC, wxMemoryDC or wxPrinterDC.
</p>
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
	'Method ComputeScaleAndOrigin()
	'	wx_wxdc_computescaleandorigin(wxObjectPtr)
	'End Method
	
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
	Method DrawBitmap(bitmap:wxBitmap, x:Int, y:Int, transparent:Int = True)
		wx_wxdc_drawbitmap(wxObjectPtr, bitmap.wxObjectPtr, x, y, transparent)
	End Method
	
	Rem
	bbdoc: Draws a check mark inside the given rectangle.
	End Rem
	Method DrawCheckMark(x:Int, y:Int, w:Int, h:Int)
		wx_wxdc_drawcheckmark(wxObjectPtr, x, y, w, h)
	End Method

	Rem
	bbdoc: Draws a check mark inside the given rectangle.
	End Rem
	Method DrawCheckMarkRect(rect:wxRect)
		wx_wxdc_drawcheckmarkrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Draws a circle with the given centre and radius.
	End Rem
	Method DrawCircle(x:Int, y:Int, radius:Int)
		wx_wxdc_drawcircle(wxObjectPtr, x, y, radius)
	End Method
	
	Rem
	bbdoc: Draws an ellipse contained in the rectangle specified either with the given top left corner and the given size or directly. The current pen is used for the outline and the current brush for filling the shape.
	End Rem
	Method DrawEllipse(x:Int, y:Int, width:Int, height:Int)
		bmx_wxdc_drawellipse(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: Draws an ellipse contained in the rectangle specified either with the given top left corner and the given size or directly. The current pen is used for the outline and the current brush for filling the shape.
	End Rem
	Method DrawEllipseRect(rect:wxRect)
		bmx_wxdc_drawellipserect(wxObjectPtr, rect.wxObjectPtr)
	End Method

	Rem
	bbdoc: Draws an arc of an ellipse.
	about: The current pen is used for drawing the arc and the current brush is used for drawing the pie.
	<p>
	x and y specify the x and y coordinates of the upper-left corner of the rectangle that contains the ellipse.
	</p>
	<p>
	width and height specify the width and height of the rectangle that contains the ellipse.
	</p>
	<p>
	start and end specify the start and end of the arc relative to the three-o'clock position from the center
	of the rectangle. Angles are specified in degrees (360 is a complete circle). Positive values mean
	counter-clockwise motion. If start is equal to end, a complete ellipse will be drawn.
	</p>
	End Rem
	Method DrawEllipticArc(x:Int, y:Int, width:Int, height:Int, _start:Double, _end:Double)
		bmx_wxdc_drawellipticarc(wxObjectPtr, x, y, width, height, _start, _end)
	End Method
	
	Rem
	bbdoc: Draw an icon on the display (does nothing if the device context is PostScript).
	about: This can be the simplest way of drawing bitmaps on a window.
	End Rem
	Method DrawIcon(icon:wxIcon, x:Int, y:Int)
		bmx_wxdc_drawicon(wxObjectPtr, icon.wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Draw optional bitmap and the text into the given rectangle and aligns it as specified by alignment parameter.
	about: It also will emphasize the character with the given index if it is != -1.
	End Rem
	Method DrawLabel(text:String, x:Int, y:Int, width:Int, height:Int, image:wxBitmap = Null, ..
			alignment:Int = wxALIGN_LEFT | wxALIGN_TOP, indexAccel:Int = -1)
		If image Then
			bmx_wxdc_drawlabel(wxObjectPtr, text, x, y, width, height, image.wxObjectPtr, alignment, indexAccel)
		Else
			bmx_wxdc_drawlabel(wxObjectPtr, text, x, y, width, height, Null, alignment, indexAccel)
		End If
	End Method

	Rem
	bbdoc: Draw optional bitmap and the text into the given rectangle and aligns it as specified by alignment parameter.
	about: It also will emphasize the character with the given index if it is != -1.
	End Rem
	Method DrawLabelRect(text:String, rect:wxRect, image:wxBitmap = Null, ..
			alignment:Int = wxALIGN_LEFT | wxALIGN_TOP, indexAccel:Int = -1)
		If image Then
			bmx_wxdc_drawlabelrect(wxObjectPtr, text, rect.wxObjectPtr, image.wxObjectPtr, alignment, indexAccel)
		Else
			bmx_wxdc_drawlabelrect(wxObjectPtr, text, rect.wxObjectPtr, Null, alignment, indexAccel)
		End If
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
	bbdoc: Draws lines using an array of (x, y) points, adding the optional offset coordinate.
	about: The current pen is used for drawing the lines.
	End Rem
	Method DrawLines(points:Int[], xOffset:Int = 0, yOffset:Int = 0)
		bmx_wxdc_drawlines(wxObjectPtr, points, xOffset, yOffset)
	End Method
	
	Rem
	bbdoc: Draws a filled polygon using an array of (x, y) points, adding the optional offset coordinate.
	about: The last argument specifies the fill rule: wxODDEVEN_RULE (the default) or wxWINDING_RULE.
	<p>
	The current pen is used for drawing the outline, and the current brush for filling the shape.
	Using a transparent brush suppresses filling.
	</p>
	<p>
	Note that wxWidgets automatically closes the first and last points.
	</p>
	End Rem
	Method DrawPolygon(points:Int[], xOffset:Int = 0, yOffset:Int = 0, fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxdc_drawpolygon(wxObjectPtr, points, xOffset, yOffset, fillStyle)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawPolyPolygon()
	End Method
	
	Rem
	bbdoc: Draws a point using the color of the current pen.
	about: Note that the other properties of the pen are not used, such as width etc..
	End Rem
	Method DrawPoint(x:Int, y:Int)
		bmx_wxdc_drawpoint(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Draws a rectangle with the given top left corner, and with the given size.
	about: The current pen is used for the outline and the current brush for filling the shape.
	End Rem
	Method DrawRectangle(x:Int, y:Int, width:Int, height:Int)
		bmx_wxdc_drawrectangle(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: Draws a rectangle with the given @rect.
	about: The current pen is used for the outline and the current brush for filling the shape.
	End Rem
	Method DrawRectangleRect(rect:wxRect)
		bmx_wxdc_drawrectanglerect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Draws the text rotated by angle degrees.
	End Rem
	Method DrawRotatedText(text:String, x:Int, y:Int, angle:Double)
		bmx_wxdc_drawrotatedtext(wxObjectPtr, text, x, y, angle)
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
	bbdoc: Draws a rectangle with the given @rect.
	about: The corners are quarter-circles using the given radius. The current pen is used for the outline
	and the current brush for filling the shape.
	<p>
	If radius is positive, the value is assumed to be the radius of the rounded corner. If radius is negative,
	the absolute value is assumed to be the proportion of the smallest dimension of the rectangle. This means
	that the corner can be a sensible size relative to the size of the rectangle, and also avoids the strange
	effects X produces when the corners are too big for the rectangle.
	</p>
	End Rem
	Method DrawRoundedRectangleRect(rect:wxRect, radius:Double)
		bmx_wxdc_drawroundedrectanglerect(wxObjectPtr, rect.wxObjectPtr, radius)
	End Method
	
	Rem
	bbdoc: Draws a spline between all given (x, y) control points, using the current pen.
	End Rem
	Method DrawSpline(points:Int[])
		bmx_wxdc_drawspline(wxObjectPtr, points)
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
	bbdoc: Ends a document (only relevant when outputting to a printer).
	End Rem
	Method EndDoc()
		bmx_wxdc_enddoc(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Ends a document page (only relevant when outputting to a printer).
	End Rem
	Method EndPage()
		bmx_wxdc_endpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Flood fills the device context starting from the given point, using the current brush colour, and a style.
	returns: False if the operation failed.
	about: Valid styles are :
	<ul>
	<li>wxFLOOD_SURFACE: the flooding occurs until a colour other than the given colour is encountered.</li>
	<li>wxFLOOD_BORDER: the area to be flooded is bounded by the given colour.</li>
	</ul>
	<p>
	Note: The present implementation for non-Windows platforms may fail to find colour borders if the pixels
	do not match the colour exactly. However the function will still return true.
	</p>
	End Rem
	Method FloodFill:Int(x:Int, y:Int, colour:wxColour, style:Int = wxFLOOD_SURFACE)
		Return bmx_wxdc_floodfill(wxObjectPtr, x, y, colour.wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Gets the brush used for painting the background (see wxDC::SetBackground).
	End Rem
	Method GetBackground:wxBrush()
		Return wxBrush._create(bmx_wxdc_getbackground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the current background mode: wxSOLID or wxTRANSPARENT.
	End Rem
	Method GetBackgroundMode:Int()
		Return bmx_wxdc_getbackgroundmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the current brush (see wxDC::SetBrush).
	End Rem
	Method GetBrush:wxBrush()
		Return wxBrush._create(bmx_wxdc_getbrush(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the character height of the currently set font.
	End Rem
	Method GetCharHeight:Int()
		Return bmx_wxdc_getcharheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the average character width of the currently set font.
	End Rem
	Method GetCharWidth:Int()
		Return bmx_wxdc_getcharwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the rectangle surrounding the current clipping region.
	End Rem
	Method GetClippingBox(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxdc_getclippingbox(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the current font.
	about: Notice that even although each device context object has some default font after creation,
	this method would return a wxNullFont initially and only after calling wxDC::SetFont a valid font is
	returned.
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxdc_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the current layout direction of the device context.
	about: On platforms where RTL layout is supported, the return value will either be wxLayout_LeftToRight
	or wxLayout_RightToLeft. If RTL layout is not supported, the return value will be wxLayout_Default.
	End Rem
	Method GetLayoutDirection:Int()
		Return bmx_wxdc_getlayoutdirection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the current logical function (see wxDC::SetLogicalFunction).
	End Rem
	Method GetLogicalFunction:Int()
		Return bmx_wxdc_getlogicalfunction(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the mapping mode for the device context (see wxDC::SetMapMode).
	End Rem
	Method GetMapMode:Int()
		Return bmx_wxdc_getmapmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the dimensions of the string using the currently selected font.
	about: @text is the text string to measure, @heightLine is where to store the height of a single line.
	<p>
	The text extent is returned in @width and @height variables.
	</p>
	<p>
	Note that this method works both with single-line and multi-line strings.
	</p>
	End Rem
	Method GetMultiLineTextExtent(text:String, width:Int Var, height:Int Var, heightLine:Int Var)
		bmx_wxdc_getmultilinetextextent(wxObjectPtr, text, Varptr width, Varptr height, Varptr heightline)
	End Method
	
	Rem
	bbdoc: Returns an array of widths from the beginning of text to the corresponding character of text.
	about: The generic version simply builds a running total of the widths of each character using
	GetTextExtent, however if the various platforms have a native API function that is faster or more
	accurate than the generic implementation then it will be used instead. 
	End Rem
	Method GetPartialTextExtents:Int[](text:String)
		Return bmx_wxdc_getpartialtextextents(wxObjectPtr, text)
	End Method

	Rem
	bbdoc: Gets the current pen (see wxDC::SetPen).
	End Rem
	Method GetPen:wxPen()
		Return wxPen._create(bmx_wxdc_getpen(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the colour at the specified location.
	about: Not available for wxPostScriptDC or wxMetafileDC.
	End Rem
	Method GetPixel:wxColour(x:Int, y:Int)
		Return wxColour._create(bmx_wxdc_getpixel(wxObjectPtr, x, y))
	End Method
	
	Rem
	bbdoc: Returns the resolution of the device in pixels per inch.
	End Rem
	Method GetPPI(w:Int Var, h:Int Var)
		bmx_wxdc_getppi(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: This gets the horizontal and vertical resolution in device units.
	about: It can be used to scale graphics to fit the page. For example, if maxX and maxY represent the
	maximum horizontal and vertical 'pixel' values used in your application, the following code will scale
	the graphic to fit on the printer page:
	<pre>
	Local w:Int, h:Int
	dc.GetSize(w, h)
	Local scaleX:Double = (maxX / w) 
	Local scaleY:Double = = (maxY / h)
	dc.SetUserScale(Min(scaleX, scaleY), Min(scaleX, scaleY))
	</pre>
	End Rem
	Method GetSize(w:Int Var, h:Int Var)
		bmx_wxdc_getsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the horizontal and vertical resolution in millimetres.
	End Rem
	Method GetSizeMM(w:Int Var, h:Int Var)
		bmx_wxdc_getsizemm(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the current text background colour (see wxDC::SetTextBackground).
	End Rem
	Method GetTextBackground:wxColour()
		Return wxColour._create(bmx_wxdc_gettextbackground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTextExtent(text:String, w:Int Var, h:Int Var)
		bmx_wxdc_gettextextent(wxObjectPtr, text, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the current text foreground colour (see wxDC::SetTextForeground).
	End Rem
	Method GetTextForeground:wxColour()
		Return wxColour._create(bmx_wxdc_gettextforeground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the current user scale factor (set by SetUserScale).
	End Rem
	Method GetUserScale(x:Double Var, y:Double Var)
		bmx_wxdc_getuserscale(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Fill the area specified by rect with a radial gradient, starting from initialColour at the centre of the circle and fading to destColour on the circle outside.
	End Rem
	Method GradientFillConcentric(x:Int, y:Int, w:Int, h:Int, initialColour:wxColour, destColour:wxColour)
		bmx_wxdc_gradientfillconcentric(wxObjectPtr, x, y, w, h, initialColour.wxObjectPtr, destColour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Fill the area specified by rect with a radial gradient, starting from initialColour at the centre of the circle and fading to destColour on the circle outside.
	End Rem
	Method GradientFillConcentricRect(rect:wxRect, initialColour:wxColour, destColour:wxColour)
		bmx_wxdc_gradientfillconcentricrect(wxObjectPtr, rect.wxObjectPtr, initialColour.wxObjectPtr, destColour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Fill the area specified by rect with a radial gradient, starting from initialColour at the centre of the circle and fading to destColour on the circle outside.
	about: @centreX and @centreY are the relative coordinates of centre of the circle in the specified rect.
	End Rem
	Method GradientFillConcentricCentre(x:Int, y:Int, w:Int, h:Int, initialColour:wxColour, destColour:wxColour, centreX:Int, centreY:Int)
		bmx_wxdc_gradientfillconcentriccentre(wxObjectPtr, x, y, w, h, initialColour.wxObjectPtr, destColour.wxObjectPtr, centreX, centreY)
	End Method
	
	Rem
	bbdoc: Fill the area specified by rect with a radial gradient, starting from initialColour at the centre of the circle and fading to destColour on the circle outside.
	about: @centreX and @centreY are the relative coordinates of centre of the circle in the specified rect.
	End Rem
	Method GradientFillConcentricCentreRect(rect:wxRect, initialColour:wxColour, destColour:wxColour, centreX:Int, centreY:Int)
		bmx_wxdc_gradientfillconcentriccentrerect(wxObjectPtr, rect.wxObjectPtr, initialColour.wxObjectPtr, destColour.wxObjectPtr, centreX, centreY)
	End Method

	Rem
	bbdoc: Fill the area specified by rect with a linear gradient, starting from initialColour and eventually fading to destColour.
	about: The @direction specifies the direction of the colour change, default is to use initialColour on
	the left part of the rectangle and destColour on the right one.
	End Rem
	Method GradientFillLinear(x:Int, y:Int, w:Int, h:Int, initialColour:wxColour, destColour:wxColour, direction:Int = wxEAST)
		bmx_wxdc_gradientfilllinear(wxObjectPtr, x, y, w, h, initialColour.wxObjectPtr, destColour.wxObjectPtr, direction)
	End Method

	Rem
	bbdoc: Fill the area specified by rect with a linear gradient, starting from initialColour and eventually fading to destColour.
	about: The @direction specifies the direction of the colour change, default is to use initialColour on
	the left part of the rectangle and destColour on the right one.
	End Rem
	Method GradientFillLinearRect(rect:wxRect, initialColour:wxColour, destColour:wxColour, direction:Int = wxEAST)
		bmx_wxdc_gradientfilllinearrect(wxObjectPtr, rect.wxObjectPtr, initialColour.wxObjectPtr, destColour.wxObjectPtr, direction)
	End Method
	
	Rem
	bbdoc: Converts logical X coordinate to device coordinate, using the current mapping mode.
	End Rem
	Method LogicalToDeviceX:Int(x:Int)
		Return bmx_wxdc_logicaltodevicex(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Converts logical X coordinate to relative device coordinate, using the current mapping mode but ignoring the x axis orientation.
	about: Use this for converting a width, for example.
	End Rem
	Method LogicalToDeviceXRel:Int(x:Int)
		Return bmx_wxdc_logicaltodevicexrel(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Converts logical Y coordinate to device coordinate, using the current mapping mode.
	End Rem
	Method LogicalToDeviceY:Int(y:Int)
		Return bmx_wxdc_logicaltodevicey(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: Converts logical Y coordinate to relative device coordinate, using the current mapping mode but ignoring the y axis orientation.
	about: Use this for converting a height, for example.
	End Rem
	Method LogicalToDeviceYRel:Int(Y:Int)
		Return bmx_wxdc_logicaltodeviceyrel(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: Gets the maximum horizontal extent used in drawing commands so far.
	End Rem
	Method MaxX:Int()
		Return bmx_wxdc_maxx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the maximum vertical extent used in drawing commands so far.
	End Rem
	Method MaxY:Int()
		Return bmx_wxdc_maxy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the minimum horizontal extent used in drawing commands so far.
	End Rem
	Method MinX:Int()
		Return bmx_wxdc_minx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the minimum vertical extent used in drawing commands so far.
	End Rem
	Method MinY:Int()
		Return bmx_wxdc_miny(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the DC is ok to use.
	End Rem
	Method IsOk:Int()
		Return bmx_wxdc_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets the bounding box.
	about: After a call to this method, the bounding box doesn't contain anything.
	End Rem
	Method ResetBoundingBox()
		bmx_wxdc_resetboundingbox(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the x and y axis orientation (i.e., the direction from lowest to highest values on the axis).
	about: The default orientation is x axis from left to right and y axis from top down.
	End Rem
	Method SetAxisOrientation(leftRight:Int, topBottom:Int)
		bmx_wxdc_setaxisorientation(wxObjectPtr, leftRight, topBottom)
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
	Method SetBackgroundMode(Mode:Int)
		bmx_wxdc_setbackgroundmode(wxObjectPtr, Mode)
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
	bbdoc: Sets the clipping region for this device context to the intersection of the given region described by the parameters of this method and the previously set clipping region.
	about: You should call DestroyClippingRegion if you want to set the clipping region exactly to the
	region specified.
	<p>
	The clipping region is an area to which drawing is restricted. Possible uses for the clipping region
	are for clipping text or for speeding up window redraws when only a known area of the screen is damaged.
	</p>
	End Rem
	Method SetClippingRegionRegion(region:wxRegion)
		bmx_wxdc_setclippingregionregion(wxObjectPtr, region.wxObjectPtr)
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
	bbdoc: Sets the current layout direction for the device context.
	about: @dir may be either wxLayout_Default, wxLayout_LeftToRight or wxLayout_RightToLeft.
	End Rem
	Method SetLayoutDirection(dir:Int)
		bmx_wxdc_setlayoutdirection(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: Sets the current logical function for the device context.
	about: This determines how a source pixel (from a pen or brush colour, or source device context if
	using wxDC::Blit) combines with a destination pixel in the current device context.
	<p>
	The possible values and their meaning in terms of source and destination pixel values are as follows:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxAND</td><td>src AND dst</td></tr>
	<tr><td>wxAND_INVERT</td><td>(NOT src) AND dst</td></tr>
	<tr><td>wxAND_REVERSE</td><td>src AND (NOT dst)</td></tr>
	<tr><td>wxCLEAR</td><td>0</td></tr>
	<tr><td>wxCOPY</td><td>src</td></tr>
	<tr><td>wxEQUIV</td><td>(NOT src) XOR dst</td></tr>
	<tr><td>wxINVERT</td><td>NOT dst</td></tr>
	<tr><td>wxNAND</td><td>(NOT src) OR (NOT dst)</td></tr>
	<tr><td>wxNOR</td><td>(NOT src) AND (NOT dst)</td></tr>
	<tr><td>wxNO_OP</td><td>dst</td></tr>
	<tr><td>wxOR</td><td>src OR dst</td></tr>
	<tr><td>wxOR_INVERT</td><td>(NOT src) OR dst</td></tr>
	<tr><td>wxOR_REVERSE</td><td>src OR (NOT dst)</td></tr>
	<tr><td>wxSET</td><td>1</td></tr>
	<tr><td>wxSRC_INVERT</td><td>NOT src</td></tr>
	<tr><td>wxXOR</td><td>src XOR dst</td></tr>
	</table>
	</p>
	End Rem
	Method SetLogicalFunction(func:Int)
		bmx_wxdc_setlogicalfunction(wxObjectPtr, func)
	End Method
	
	Rem
	bbdoc: The mapping mode of the device context defines the unit of measurement used to convert logical units to device units.
	about: Note that in X, text drawing isn't handled consistently with the mapping mode; a font is always
	specified in point size. However, setting the user scale (see wxDC::SetUserScale) scales the text
	appropriately. In Windows, scalable TrueType fonts are always used; in X, results depend on availability
	of fonts, but usually a reasonable match is found.
	<p>
	The coordinate origin is always at the top left of the screen/printer.
	</p>
	<p>
	Drawing to a Windows printer device context uses the current mapping mode, but mapping mode is
	currently ignored for PostScript output.
	</p>
	End Rem
	Method SetMapMode(Mode:Int)
		bmx_wxdc_setmapmode(wxObjectPtr, Mode)
	End Method
	
	Rem
	bbdoc: If this is a window DC or memory DC, assigns the given palette to the window or bitmap associated with the DC.
	about: If the argument is wxNullPalette, the current palette is selected out of the device context,
	and the original palette restored.
	End Rem
	Method SetPalette(palette:wxPalette)
		bmx_wxdc_setpalette(wxObjectPtr, palette.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the current pen for the DC.
	about: If the argument is wxNullPen, the current pen is selected out of the device context, and the
	original pen restored.
	<p>
	See also wxMemoryDC for the interpretation of colours when drawing into a monochrome bitmap.
	</p>
	End Rem
	Method SetPen(pen:wxPen)
		bmx_wxdc_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the current text background colour for the DC.
	End Rem
	Method SetTextBackground(colour:wxColour)
		bmx_wxdc_settextbackground(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the current text foreground colour for the DC.
	about: See also wxMemoryDC for the interpretation of colours when drawing into a monochrome bitmap.
	End Rem
	Method SetTextForeground(colour:wxColour)
		bmx_wxdc_settextforeground(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the user scaling factor, useful for applications which require 'zooming'.
	End Rem
	Method SetUserScale(xScale:Double, yScale:Double)
		bmx_wxdc_setuserscale(wxObjectPtr, xScale, yScale)
	End Method
	
	Rem
	bbdoc: Starts a document (only relevant when outputting to a printer).
	about: @message is a message to show while printing.
	End Rem
	Method StartDoc:Int(message:String)
		bmx_wxdc_startdoc(wxObjectPtr, message)
	End Method
	
	Rem
	bbdoc: Starts a document page (only relevant when outputting to a printer).
	End Rem
	Method StartPage:Int()
		bmx_wxdc_startpage(wxObjectPtr)
	End Method

	Rem
	bbdoc: Frees up the device context.
	about: This is required when you are finished with it, since on Windows, not performing this action can result in
	undesired effects.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxdc_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
		
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
