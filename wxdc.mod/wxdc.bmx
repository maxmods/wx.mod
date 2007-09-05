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
bbdoc: 
End Rem
Type wxDC Extends _wxDC

	Function _create:wxDC(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxDC = New wxDC
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bdoc: 
	End Rem
	Method CalcBoundingBox(x:Int, y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method Clear()
		bmx_wxdc_clear(wxObjectPtr)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method CrossHair(x:Int, y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DestroyClippingRegion:Int()
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DeviceToLogicalX:Int(x:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DeviceToLogicalXRel:Int(x:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DeviceToLogicalY:Int(y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DeviceToLogicalYRe:Int(y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawArc(x1:Int, y1:Int, x2:Int, y2:Int, xc:Int, yc:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawBitmap(bitmap:wxBitmap, x:Int, y:Int, transparent:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawCheckMark(x:Int, y:Int, w:Int, h:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawCircle(x:Int, y:Int, radius:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawEllipse(x:Int, y:Int, width:Int, height:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawEllipticArc(x:Int, y:Int, width:Int, height:Int, _start:Double, _end:Double)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawIcon(icon:wxIcon, x:Int, y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawLabel(text:String, x:Int, y:Int, width:Int, height:Int, image:wxBitmap = Null, ..
			alignment:Int = wxALIGN_LEFT | wxALIGN_TOP, indexAccel:Int = -1)
	End Method
	
	Rem
	bdoc: Draws a line from the first point to the second.
	about: The current pen is used for drawing the line. Note that the point (x2, y2) is not part of
	the line and is not drawn by this function (this is consistent with the behaviour of many
	other toolkits).
	End Rem
	Method DrawLine(x1:Int, y1:Int, x2:Int, y2:Int)
		bmx_wxdc_drawline(wxObjectPtr, x1, y1, x2, y2)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawLines()
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawPolygon()
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawPolyPolygon()
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawPoint(x:Int, y:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawRectangle(x:Int, y:Int, width:Int, height:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawRotatedText(text:String, x:Int, y:Int, angle:Double)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawRoundedRectangle(x:Int, y:Int, width:Int, height:Int)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method DrawSpline()
	End Method
	
	Rem
	bdoc: Draws a text string at the specified point, using the current text font, and the current text foreground and background colours.
	about: The coordinates refer to the top-left corner of the rectangle bounding the string.
	See wxDC::GetTextExtent for how to get the dimensions of a text string, which can be used to position
	the text more precisely
	End Rem
	Method DrawText(text:String, x:Int, y:Int)
		bmx_wxdc_drawtext(wxObjectPtr, text, x, y)
	End Method
	
	Rem
	bdoc: 
	End Rem
	Method EndDoc()
	End Method
	
	Rem
	bdoc: 
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
bbdoc: A wxPaintDC must be constructed if an application wishes to paint on the client area of a window from within an OnPaint event.
about: This should normally be constructed as a temporary stack object; don't store a wxPaintDC object.
If you have an OnPaint handler, you must create a wxPaintDC object within it even if you don't actually use
it.
<p>
Using wxPaintDC within OnPaint is important because it automatically sets the clipping area to the damaged
area of the window. Attempts to draw outside this area do not appear.
</p>
<p>
To draw on a window from outside OnPaint, construct a wxClientDC object.
</p>
<p>
To draw on the whole window including decorations, construct a wxWindowDC object (Windows only).
</p>
End Rem
Type wxPaintDC Extends wxWindowDC

	Rem
	bbdoc: Constructor.
	about: Pass the window on which you wish to paint.
	End Rem
	Method Create:wxPaintDC(window:wxWindow)
		wxObjectPtr = bmx_wxpaintdc_create(window.wxObjectPtr)
		Return Self
	End Method

	Method Delete()
		Free()
	End Method

	Method Free()
		If wxObjectPtr Then
			bmx_wxpaintdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type


