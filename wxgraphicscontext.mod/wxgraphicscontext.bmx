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
bbdoc: wxGraphicsContext
End Rem
Module wx.wxGraphicsContext

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


Type wxGraphicsObject Extends wxObject

	Method IsNull:Int()
	End Method
	
End Type

Rem
bbdoc: A wxGraphicsContext instance is the object that is drawn upon.
about: It is created by a renderer using the CreateContext calls.., this can be either
directly using a renderer instance, or indirectly using the static convenience CreateXXX functions
of wxGraphicsContext that always delegate the task to the default renderer.
End Rem
Type wxGraphicsContext Extends wxGraphicsObject

	Rem
	bbdoc: 
	End Rem
	Function CreateGraphicsContext:wxGraphicsContext()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxGraphicsContext()
	End Method
	
	Rem
	bbdoc: Creates a native pen from a wxPen.
	End Rem
	Method CreatePen:wxGraphicsPen(pen:wxPen)
		Return wxGraphicsPen._create(bmx_wxgraphicscontext_createpen(wxObjectPtr, pen.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Creates a native brush from a wxBrush.
	End Rem
	Method CreateBrush:wxGraphicsBrush(brush:wxBrush)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createbrush(wxObjectPtr, brush.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Creates a native brush, having a radial gradient originating at (xo,yc) with color oColour and ends on a circle around (xc,yc) with radius and color cColour.
	End Rem
	Method CreateRadialGradientBrush:wxGraphicsBrush(xo:Double, yo:Double, xc:Double, yc:Double, radius:Double, ..
			oColour:wxColour, cColour:wxColour)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createradialgradientbrush(wxObjectPtr, xo, yo, xc, yc, radius, oColour.wxObjectPtr, cColour.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Creates a native brush, having a linear gradient, starting at (x1,y1) with color c1 to (x2,y2) with color c2
	End Rem
	Method CreateLinearGradientBrush:wxGraphicsBrush(x1:Double, y1:Double, x2:Double, y2:Double, ..
			c1:wxColour, c2:wxColour)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createlineargradientbrush(wxObjectPtr, x1, y1, x2, y2, c1.wxObjectPtr, c2.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Creates a native graphics font from a wxFont and a text colour.
	End Rem
	Method CreateFont:wxGraphicsFont(font:wxFont, col:wxColour = Null)
		If col Then
			Return wxGraphicsFont._create(bmx_wxgraphicscontext_createfont(wxObjectPtr, font.wxObjectPtr, col.wxObjectPtr))
		Else
			Return wxGraphicsFont._create(bmx_wxgraphicscontext_createfont(wxObjectPtr, font.wxObjectPtr, Null))
		End If
	End Method
	
	Rem
	bbdoc: Creates a native affine transformation matrix from the passed in values.
	about: The defaults result in an identity matrix.
	End Rem
	Method CreateMatrix:wxGraphicsMatrix(a:Double = 1.0, b:Double = 0, c:Double = 0, d:Double = 1.0, ..
			tx:Double = 0, ty:Double = 0)
		Return wxGraphicsMatrix._create(bmx_wxgraphicscontext_creatematrix(wxObjectPtr, a, b, c, d, tx, ty))
	End Method
	
	Rem
	bbdoc: Creates a native graphics path which is initially empty.
	End Rem
	Method CreatePath:wxGraphicsPath()
		Return wxGraphicsPath._create(bmx_wxgraphicscontext_createpath(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Clips drawings to the rectangle.
	End Rem
	Method Clip(x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_clip(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Clips drawings to the region, combined to current clipping region
	End Rem
	Method ClipRegion(region:wxRegion)
		bmx_wxgraphicscontext_clipregion(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets the clipping to original shape.
	End Rem
	Method ResetClip()
		bmx_wxgraphicscontext_resetclip(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Draws the bitmap.
	about: In case of a mono bitmap, this is treated as a mask and the current brushed is used for filling.
	End Rem
	Method DrawBitmap(bmp:wxBitmap, x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawbitmap(wxObjectPtr, bmp.wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Draws an ellipse.
	End Rem
	Method DrawEllipse(x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawellipse(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Draws the icon.
	End Rem
	Method DrawIcon(icon:wxIcon, x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawicon(wxObjectPtr, icon.wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Draws a polygon.
	End Rem
	Method DrawLines(points:Double[], fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_drawlines(wxObjectPtr, points, fillStyle)
	End Method
	
	Rem
	bbdoc: Draws the path by first filling and then stroking.
	End Rem
	Method DrawPath(path:wxGraphicsPath, fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_drawpath(wxObjectPtr, path.wxObjectPtr, fillStyle)
	End Method
	
	Rem
	bbdoc: Draws a rectangle.
	End Rem
	Method DrawRectangle(x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawrectangle(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Draws a rounded rectangle.
	End Rem
	Method DrawRoundedRectangle(x:Double, y:Double, w:Double, h:Double, radius:Double)
		bmx_wxgraphicscontext_drawroundedrectangle(wxObjectPtr, x, y, w, h, radius)
	End Method
	
	Rem
	bbdoc: Draws a text at the defined position, at the given angle, in degrees.
	End Rem
	Method DrawText(text:String, x:Double, y:Double, angle:Double = 0)
		bmx_wxgraphicscontext_drawtext(wxObjectPtr, text, x, y, angle)
	End Method
	
	Rem
	bbdoc: Fills the path with the current brush.
	End Rem
	Method FillPath(path:wxGraphicsPath, fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_fillpath(wxObjectPtr, path.wxObjectPtr, fillStyle)
	End Method
	
	Rem
	bbdoc: Strokes along a path with the current pen.
	End Rem
	Method StrokePath(path:wxGraphicsPath)
		bmx_wxgraphicscontext_strokepath(wxObjectPtr, path.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the native context (CGContextRef for Core Graphics, Graphics pointer for GDIPlus and cairo_t pointer for cairo).
	End Rem
	Method GetNativeContext:Byte Ptr()
		Return bmx_wxgraphicscontext_getnativecontext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the widths from the beginning of text to the corresponding character of text.
	End Rem
	Method GetPartialTextExtents:Double[](text:String)
		Return bmx_wxgraphicscontext_getpartialtextextents(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Gets the dimensions of the string using the currently selected font.
	about: @text is the string to measure, @width and @height are the total width and height
	respectively, @descent is the dimension from the baseline of the font to the bottom of the
	descender, and @externalLeading is any extra vertical space added to the font by the font
	designer (usually is zero).
	End Rem
	Method GetTextExtent(text:String, width:Double Var, height:Double Var, descent:Double Var, ..
			externalLeading:Double Var)
		bmx_wxgraphicscontext_gettextextent(wxObjectPtr, text, Varptr width, Varptr height, Varptr descent, Varptr externalLeading)
	End Method
	
	Rem
	bbdoc: Rotates the current transformation matrix (degrees).
	End Rem
	Method Rotate(angle:Double)
		bmx_wxgraphicscontext_rotate(wxObjectPtr, angle)
	End Method
	
	Rem
	bbdoc: Scales the current transformation matrix.
	End Rem
	Method Scale(xScale:Double, yScale:Double)
		bmx_wxgraphicscontext_scale(wxObjectPtr, xScale, yScale)
	End Method
	
	Rem
	bbdoc: Translates the current transformation matrix.
	End Rem
	Method Translate(dx:Double, dy:Double)
		bmx_wxgraphicscontext_translate(wxObjectPtr, dx, dy)
	End Method
	
	Rem
	bbdoc: Gets the current transformation matrix of this context.
	End Rem
	Method GetTransform:wxGraphicsMatrix()
		Return wxGraphicsMatrix._create(bmx_wxgraphicscontext_gettransform(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the current transformation matrix of this context.
	End Rem
	Method SetTransform(matrix:wxGraphicsMatrix)
		bmx_wxgraphicscontext_settransform(wxObjectPtr, matrix.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Concatenates the passed in transform with the current transform of this context.
	End Rem
	Method ConcatTransform(matrix:wxGraphicsMatrix)
		bmx_wxgraphicscontext_concattransform(wxObjectPtr, matrix.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the brush for filling paths.
	End Rem
	Method SetBrush(brush:wxBrush)
		bmx_wxgraphicscontext_setbrush(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the brush for filling paths.
	End Rem
	Method SetBrushNative(brush:wxGraphicsBrush)
		bmx_wxgraphicscontext_setbrushnative(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for drawing text.
	End Rem
	Method SetFont(font:wxFont, colour:wxColour)
		bmx_wxgraphicscontext_setfont(wxObjectPtr, font.wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for drawing text.
	End Rem
	Method SetFontNative(font:wxGraphicsFont)
		bmx_wxgraphicscontext_setfontnative(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the pen used for stroking.
	End Rem
	Method SetPen(pen:wxPen)
		bmx_wxgraphicscontext_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the pen used for stroking.
	End Rem
	Method SetPenNative(pen:wxGraphicsPen)
		bmx_wxgraphicscontext_setpennative(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Strokes a single line.
	End Rem
	Method StrokeLine(x1:Double, y1:Double, x2:Double, y2:Double)
		bmx_wxgraphicscontext_strokeline(wxObjectPtr, x1, y1, x2, y2)
	End Method
	
	Rem
	bbdoc: Strokes a set of connected lines.
	End Rem
	Method StrokeLines(points:Double[])
		bmx_wxgraphicscontext_strokelines(wxObjectPtr, points)
	End Method

	Rem
	bbdoc: Stroke disconnected lines from begin to end points, fastest method available for this purpose.
	End Rem
	Method StrokeDisconnectedLines(startPoints:Double[], endPoints:Double[])
		bmx_wxgraphicscontext_strokedisconnectedlines(wxObjectPtr, startPoints, endPoints)
	End Method
	
End Type

Rem
bbdoc: A wxGraphicsMatrix is a native representation of an affine matrix.
End Rem
Type wxGraphicsMatrix Extends wxGraphicsObject

	Function _create:wxGraphicsMatrix(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGraphicsMatrix = New wxGraphicsMatrix
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method Concat(t:wxGraphicsMatrix)
	End Method
	
	Method Get(a:Double Var, b:Double Var, c:Double Var, d:Double Var, tx:Double Var, ty:Double Var)
	End Method
	
	Method GetNativeMatrix:Byte Ptr()
	End Method
	
	Method Invert()
	End Method
	
	Method IsEqual:Int(t:wxGraphicsMatrix)
	End Method
	
	Method IsIdentity:Int()
	End Method
	
	Method Rotate(angle:Double)
	End Method
	
	Method Scale(xScale:Double, yScale:Double)
	End Method
	
	Method Translate(dx:Double, dy:Double)
	End Method
	
	Method Set(a:Double = 1.0, b:Double = 0, c:Double = 0, d:Double = 1.0, ..
			tx:Double = 0, ty:Double = 0)
	End Method
	
	Method TransformPoint(x:Double Var, y:Double Var)
	End Method
	
	Method TransformDistance(dx:Double Var, dy:Double Var)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxgraphicsmatrix_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: A wxGraphicsPath is a native representation of an geometric path.
End Rem
Type wxGraphicsPath Extends wxGraphicsObject

	Function _create:wxGraphicsPath(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGraphicsPath = New wxGraphicsPath
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method MoveToPoint(x:Double, y:Double)
	End Method
	
	Method AddArc(x:Double, y:Double, r:Double, startAngle:Double, endAngle:Double, clockwise:Int)
	End Method
	
	Method AddArcToPoint(x1:Double, y1:Double, x2:Double, y2:Double, radius:Double)
	End Method
	
	Method AddCircle(x:Double, y:Double, radius:Double)
	End Method
	
	Method AddCurveToPoint(cx1:Double, cy1:Double, cx2:Double, cy2:Double, x:Double, y:Double)
	End Method
	
	Method AddEllipse(x:Double, y:Double, w:Double, h:Double)
	End Method
	
	Method AddLineToPoint(x:Double, y:Double)
	End Method
	
	Method AddPath(path:wxGraphicsPath)
	End Method
	
	Method AddQuadCurveToPoint(cx:Double, cy:Double, x:Double, y:Double)
	End Method
	
	Method AddRectangle(x:Double, y:Double, w:Double, h:Double)
	End Method
	
	Method AddRoundedRectangle(x:Double, y:Double, w:Double, h:Double, radius:Double)
	End Method
	
	Method CloseSubpath()
	End Method
	
	Method Contains:Int(x:Double, y:Double, fillStyle:Int = wxODDEVEN_RULE)
	End Method
	
	Method GetBox(x:Double Var, y:Double Var, w:Double Var, h:Double Var)
	End Method
	
	Method GetCurrentPoint(x:Double Var, y:Double Var)
	End Method
	
	Method Transform(matrix:wxGraphicsMatrix)
	End Method
	
	Method GetNativePath:Byte Ptr()
	End Method
	
	Method UnGetNativePath(path:Byte Ptr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxgraphicspath_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: A wxGraphicsBrush is a native representation of a brush.
about: It is used for filling a path on a graphics context.
End Rem
Type wxGraphicsBrush Extends wxGraphicsObject

	Function _create:wxGraphicsBrush(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGraphicsBrush = New wxGraphicsBrush
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_wxgraphicsbrush_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: A wxGraphicsPen is a native representation of a pen.
about: It is used for stroking a path on a graphics context. 
End Rem
Type wxGraphicsPen Extends wxGraphicsObject

	Function _create:wxGraphicsPen(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGraphicsPen = New wxGraphicsPen
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_wxgraphicspen_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: A wxGraphicsFont is a native representation of a font (including text colour).
End Rem
Type wxGraphicsFont Extends wxGraphicsObject

	Function _create:wxGraphicsFont(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGraphicsFont = New wxGraphicsFont
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_wxgraphicsfont_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

