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

	Function CreateGraphicsContext:wxGraphicsContext()
	End Function
	
	Method Create:wxGraphicsContext()
	End Method
	
	Method CreatePen:wxGraphicsPen(pen:wxPen)
		Return wxGraphicsPen._create(bmx_wxgraphicscontext_createpen(wxObjectPtr, pen.wxObjectPtr))
	End Method
	
	Method CreateBrush:wxGraphicsBrush(brush:wxBrush)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createbrush(wxObjectPtr, brush.wxObjectPtr))
	End Method
	
	Method CreateRadialGradientBrush:wxGraphicsBrush(xo:Double, yo:Double, xc:Double, yc:Double, radius:Double, ..
			oColour:wxColour, cColour:wxColour)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createradialgradientbrush(wxObjectPtr, xo, yo, xc, yc, radius, oColour.wxObjectPtr, cColour.wxObjectPtr))
	End Method
	
	Method CreateLinearGradientBrush:wxGraphicsBrush(x1:Double, y1:Double, x2:Double, y2:Double, ..
			c1:wxColour, c2:wxColour)
		Return wxGraphicsBrush._create(bmx_wxgraphicscontext_createlineargradientbrush(wxObjectPtr, x1, y1, x2, y2, c1.wxObjectPtr, c2.wxObjectPtr))
	End Method
	
	Method CreateFont:wxGraphicsFont(font:wxFont, col:wxColour = Null)
		If col Then
			Return wxGraphicsFont._create(bmx_wxgraphicscontext_createfont(wxObjectPtr, font.wxObjectPtr, col.wxObjectPtr))
		Else
			Return wxGraphicsFont._create(bmx_wxgraphicscontext_createfont(wxObjectPtr, font.wxObjectPtr, Null))
		End If
	End Method
	
	Method CreateMatrix:wxGraphicsMatrix(a:Double = 1.0, b:Double = 0, c:Double = 0, d:Double = 1.0, ..
			tx:Double = 0, ty:Double = 0)
		Return wxGraphicsMatrix._create(bmx_wxgraphicscontext_creatematrix(wxObjectPtr, a, b, c, d, tx, ty))
	End Method
	
	Method CreatePath:wxGraphicsPath()
		Return wxGraphicsPath._create(bmx_wxgraphicscontext_createpath(wxObjectPtr))
	End Method
	
	Method ResetClip()
		bmx_wxgraphicscontext_resetclip(wxObjectPtr)
	End Method
	
	Method DrawBitmap(bmp:wxBitmap, x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawbitmap(wxObjectPtr, bmp.wxObjectPtr, x, y, w, h)
	End Method
	
	Method DrawEllipse(x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawellipse(wxObjectPtr, x, y, w, h)
	End Method
	
	Method DrawIcon(icon:wxIcon, x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawicon(wxObjectPtr, icon.wxObjectPtr, x, y, w, h)
	End Method
	
	Method DrawLines(points:Double[], fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_drawlines(wxObjectPtr, points, fillStyle)
	End Method
	
	Method DrawPath(path:wxGraphicsPath, fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_drawpath(wxObjectPtr, path.wxObjectPtr, fillStyle)
	End Method
	
	Method DrawRectangle(x:Double, y:Double, w:Double, h:Double)
		bmx_wxgraphicscontext_drawrectangle(wxObjectPtr, x, y, w, h)
	End Method
	
	Method DrawRoundedRectangle(x:Double, y:Double, w:Double, h:Double, radius:Double)
		bmx_wxgraphicscontext_drawroundedrectangle(wxObjectPtr, x, y, w, h, radius)
	End Method
	
	Method DrawText(text:String, x:Double, y:Double, angle:Double = 0)
		bmx_wxgraphicscontext_drawtext(wxObjectPtr, text, x, y, angle)
	End Method
	
	Method FillPath(path:wxGraphicsPath, fillStyle:Int = wxODDEVEN_RULE)
		bmx_wxgraphicscontext_fillpath(wxObjectPtr, path.wxObjectPtr, fillStyle)
	End Method
	
	Method StrokePath(path:wxGraphicsPath)
		bmx_wxgraphicscontext_strokepath(wxObjectPtr, path.wxObjectPtr)
	End Method
	
	Method GetNativeContext:Byte Ptr()
		Return bmx_wxgraphicscontext_getnativecontext(wxObjectPtr)
	End Method
	
	Method GetPartialTextExtents:Double[](text:String)
		Return bmx_wxgraphicscontext_getpartialtextextents(wxObjectPtr, text)
	End Method
	
	Method GetTextExtent(text:String, width:Double Var, height:Double Var, descent:Double Var, ..
			externalLeading:Double Var)
		bmx_wxgraphicscontext_gettextextent(wxObjectPtr, text, Varptr width, Varptr height, Varptr descent, Varptr externalLeading)
	End Method
	
	Method Rotate(angle:Double)
		bmx_wxgraphicscontext_rotate(wxObjectPtr, angle)
	End Method
	
	Method Scale(xScale:Double, yScale:Double)
		bmx_wxgraphicscontext_scale(wxObjectPtr, xScale, yScale)
	End Method
	
	Method Translate(dx:Double, dy:Double)
		bmx_wxgraphicscontext_translate(wxObjectPtr, dx, dy)
	End Method
	
	Method GetTransform:wxGraphicsMatrix()
		Return wxGraphicsMatrix._create(bmx_wxgraphicscontext_gettransform(wxObjectPtr))
	End Method
	
	Method SetTransform(matrix:wxGraphicsMatrix)
		bmx_wxgraphicscontext_settransform(wxObjectPtr, matrix.wxObjectPtr)
	End Method
	
	Method ConcatTransform(matrix:wxGraphicsMatrix)
		bmx_wxgraphicscontext_concattransform(wxObjectPtr, matrix.wxObjectPtr)
	End Method
	
	Method SetBrush(brush:wxBrush)
		bmx_wxgraphicscontext_setbrush(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Method SetBrushNative(brush:wxGraphicsBrush)
		bmx_wxgraphicscontext_setbrushnative(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Method SetFont(font:wxFont, colour:wxColour)
		bmx_wxgraphicscontext_setfont(wxObjectPtr, font.wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetFontNative(font:wxGraphicsFont)
		bmx_wxgraphicscontext_setfontnative(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Method SetPen(pen:wxPen)
		bmx_wxgraphicscontext_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Method SetPenNative(pen:wxGraphicsPen)
		bmx_wxgraphicscontext_setpennative(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Method StrokeLine(x1:Double, y1:Double, x2:Double, y2:Double)
		bmx_wxgraphicscontext_strokeline(wxObjectPtr, x1, y1, x2, y2)
	End Method
	
	Method StrokeLines(points:Double[])
		bmx_wxgraphicscontext_strokelines(wxObjectPtr, points)
	End Method
	
End Type

Rem
bbdoc: 
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
bbdoc: 
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

