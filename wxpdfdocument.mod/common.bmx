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

Import wx.wx
Import wx.wxPrintData
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "include/*.h"

Import "src/pdfannotation.cpp"
Import "src/pdfbarcode.cpp"
Import "src/pdfcolor.cpp"
Import "src/pdfdecode.cpp"
Import "src/pdfdoc.cpp"
Import "src/pdfencrypt.cpp"
Import "src/pdffont.cpp"
Import "src/pdfform.cpp"
Import "src/pdfgraphics.cpp"
Import "src/pdfimage.cpp"
Import "src/pdfkernel.cpp"
Import "src/pdfobjects.cpp"
Import "src/pdfparser.cpp"
Import "src/pdfrijndael.cpp"
Import "src/pdftemplate.cpp"
Import "src/pdftruetype.cpp"
Import "src/pdfxml.cpp"


Import "glue.cpp"

Extern

	Function bmx_wxpdfdocument_free(handle:Byte Ptr)


	Function bmx_wxpdfdocument_create:Byte Ptr(handle:Object, orientation:Int, unit:String, format:Int)
	Function bmx_wxpdfdocument_addpage(handle:Byte Ptr, orientation:Int)
	Function bmx_wxpdfdocument_setfont(handle:Byte Ptr, family:String, style:String, size:Double)
	Function bmx_wxpdfdocument_cell(handle:Byte Ptr, w:Double, h:Double, txt:String, border:Int, ln:Int, align:Int, fill:Int, link:Byte Ptr)
	Function bmx_wxpdfdocument_saveasfile(handle:Byte Ptr, name:String)

	Function bmx_wxpdfdocument_addspotcolor(handle:Byte Ptr, name:String, cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfdocument_aliasnbpages(handle:Byte Ptr, _alias:String)
	Function bmx_wxpdfdocument_arrow(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, lineWidth:Double, height:Double, width:Double)
	Function bmx_wxpdfdocument_circle(handle:Byte Ptr, x0:Double, y0:Double, r:Double, astart:Double, afinish:Double, style:Int, nSeg:Int)
	Function bmx_wxpdfdocument_curve(handle:Byte Ptr, x0:Double, y0:Double, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, style:Int)
	Function bmx_wxpdfdocument_ellipse(handle:Byte Ptr, x0:Double, y0:Double, rx:Double, ry:Double, angle:Double, astart:Double, afinish:Double, style:Int, nSeg:Int)
	Function bmx_wxpdfdocument_image:Int(handle:Byte Ptr, file:String, x:Double, y:Double, w:Double, h:Double, mimeType:String, link:Byte Ptr, maskImage:Int)
	Function bmx_wxpdfdocument_ln(handle:Byte Ptr, h:Double)
	Function bmx_wxpdfdocument_sety(handle:Byte Ptr, y:Double)
	Function bmx_wxpdfdocument_pageno:Int(handle:Byte Ptr)

	Function bmx_wxpdfdocument_setx(handle:Byte Ptr, x:Double)
	Function bmx_wxpdfdocument_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxpdfdocument_setdrawcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_setfillcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_settextcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_getstringwidth:Double(handle:Byte Ptr, text:String)
	Function bmx_wxpdfdocument_setlinewidth(handle:Byte Ptr, width:Double)
	Function bmx_wxpdfdocument_setauthor(handle:Byte Ptr, author:String)
	Function bmx_wxpdfdocument_settextcolorgrayscale(handle:Byte Ptr, grayscale:Int)
	Function  bmx_wxpdfdocument_multicell:Int(handle:Byte Ptr, w:Double, h:Double, txt:String, border:Int, align:Int, fill:Int, maxline:Int)

End Extern

' Border options
Const wxPDF_BORDER_NONE:Int = $0000
Const wxPDF_BORDER_LEFT:Int = $0001
Const wxPDF_BORDER_RIGHT:Int = $0002
Const wxPDF_BORDER_TOP:Int = $0004
Const wxPDF_BORDER_BOTTOM:Int = $0008
Const wxPDF_BORDER_FRAME:Int = $000F

' Corner options
Const wxPDF_CORNER_NONE:Int = $0000
Const wxPDF_CORNER_TOP_LEFT:Int = $0001
Const wxPDF_CORNER_TOP_RIGHT:Int = $0002
Const wxPDF_CORNER_BOTTOM_LEFT:Int = $0004
Const wxPDF_CORNER_BOTTOM_RIGHT:Int = $0008
Const wxPDF_CORNER_ALL:Int = $000F

' Style options
Const wxPDF_STYLE_NOOP:Int = $0000
Const wxPDF_STYLE_DRAW:Int = $0001
Const wxPDF_STYLE_FILL:Int = $0002
Const wxPDF_STYLE_FILLDRAW:Int = $0003
Const wxPDF_STYLE_DRAWCLOSE:Int = $0004
Const wxPDF_STYLE_MASK:Int = $0007

' Font decoration options
Const wxPDF_FONT_NORMAL:Int = $0000
Const wxPDF_FONT_UNDERLINE:Int = $0001
Const wxPDF_FONT_OVERLINE:Int = $0002
Const wxPDF_FONT_STRIKEOUT:Int = $0004
Const wxPDF_FONT_DECORATION:Int = $0007 ' Mask all possible decorations

' Permission options
Const wxPDF_PERMISSION_NONE:Int = $0000  '< Allow nothing
Const wxPDF_PERMISSION_PRINT:Int = $0004  '< Allow printing
Const wxPDF_PERMISSION_MODIFY:Int = $0008  '< Allow modifying
Const wxPDF_PERMISSION_COPY:Int = $0010  '< Allow text copying
Const wxPDF_PERMISSION_ANNOT:Int = $0020  '< Allow annotations
Const wxPDF_PERMISSION_ALL:Int = $003C  '< Allow anything

' Encryption methods
Const wxPDF_ENCRYPTION_RC4V1:Int = 0
Const wxPDF_ENCRYPTION_RC4V2:Int = 1
Const wxPDF_ENCRYPTION_AESV2:Int = 2

' Color types
Const wxPDF_COLOURTYPE_UNKNOWN:Int = 0
Const wxPDF_COLOURTYPE_GRAY:Int = 1
Const wxPDF_COLOURTYPE_RGB:Int = 2
Const wxPDF_COLOURTYPE_CMYK:Int = 3
Const wxPDF_COLOURTYPE_SPOT:Int = 4

' Form Field border styles
Const wxPDF_BORDER_SOLID:Int = 0
Const wxPDF_BORDER_DASHED:Int = 1
Const wxPDF_BORDER_BEVELED:Int = 2
Const wxPDF_BORDER_INSET:Int = 3
Const wxPDF_BORDER_UNDERLINE:Int = 4

' Alignment options
Const wxPDF_ALIGN_LEFT:Int = 0
Const wxPDF_ALIGN_CENTER:Int = 1
Const wxPDF_ALIGN_RIGHT:Int = 2
Const wxPDF_ALIGN_JUSTIFY:Int = 3
Const wxPDF_ALIGN_TOP:Int = wxPDF_ALIGN_LEFT
Const wxPDF_ALIGN_MIDDLE:Int = wxPDF_ALIGN_CENTER
Const wxPDF_ALIGN_BOTTOM:Int = wxPDF_ALIGN_RIGHT

' Zoom options
Const wxPDF_ZOOM_FULLPAGE:Int = 0
Const wxPDF_ZOOM_FULLWIDTH:Int = 1
Const wxPDF_ZOOM_REAL:Int = 2
Const wxPDF_ZOOM_DEFAULT:Int = 3
Const wxPDF_ZOOM_FACTOR:Int = 4

' Layout options
Const wxPDF_LAYOUT_CONTINUOUS:Int = 0
Const wxPDF_LAYOUT_SINGLE:Int = 1
Const wxPDF_LAYOUT_TWO:Int = 2
Const wxPDF_LAYOUT_DEFAULT:Int = 3

' Viewer preferences
Const wxPDF_VIEWER_HIDETOOLBAR:Int = $0001
Const wxPDF_VIEWER_HIDEMENUBAR:Int = $0002
Const wxPDF_VIEWER_HIDEWINDOWUI:Int = $0004
Const wxPDF_VIEWER_FITWINDOW:Int = $0008
Const wxPDF_VIEWER_CENTERWINDOW:Int = $0010
Const wxPDF_VIEWER_DISPLAYDOCTITLE:Int = $0020

' Line Cap options
Const wxPDF_LINECAP_NONE:Int = -1
Const wxPDF_LINECAP_BUTT:Int = 0
Const wxPDF_LINECAP_ROUND:Int = 1
Const wxPDF_LINECAP_SQUARE:Int = 2

' Line join options
Const wxPDF_LINEJOIN_NONE:Int = -1
Const wxPDF_LINEJOIN_MITER:Int = 0
Const wxPDF_LINEJOIN_ROUND:Int = 1
Const wxPDF_LINEJOIN_BEVEL:Int = 2

' Marker symbols
Const wxPDF_MARKER_CIRCLE:Int = 0
Const wxPDF_MARKER_SQUARE:Int = 1
Const wxPDF_MARKER_TRIANGLE_UP:Int = 2
Const wxPDF_MARKER_TRIANGLE_DOWN:Int = 3
Const wxPDF_MARKER_TRIANGLE_LEFT:Int = 4
Const wxPDF_MARKER_TRIANGLE_RIGHT:Int = 5
Const wxPDF_MARKER_DIAMOND:Int = 6
Const wxPDF_MARKER_PENTAGON_UP:Int = 7
Const wxPDF_MARKER_PENTAGON_DOWN:Int = 8
Const wxPDF_MARKER_PENTAGON_LEFT:Int = 9
Const wxPDF_MARKER_PENTAGON_RIGHT:Int = 10
Const wxPDF_MARKER_STAR:Int = 11
Const wxPDF_MARKER_STAR4:Int = 12
Const wxPDF_MARKER_PLUS:Int = 13
Const wxPDF_MARKER_CROSS:Int = 14
Const wxPDF_MARKER_SUN:Int = 15
Const wxPDF_MARKER_BOWTIE_HORIZONTAL:Int = 16
Const wxPDF_MARKER_BOWTIE_VERTICAL:Int = 17
Const wxPDF_MARKER_ASTERISK:Int = 18

' Linear gradient types
Const wxPDF_LINEAR_GRADIENT_HORIZONTAL:Int = 0
Const wxPDF_LINEAR_GRADIENT_VERTICAL:Int = 1
Const wxPDF_LINEAR_GRADIENT_MIDHORIZONTAL:Int = 2
Const wxPDF_LINEAR_GRADIENT_MIDVERTICAL:Int = 3
Const wxPDF_LINEAR_GRADIENT_REFLECTION_LEFT:Int = 4
Const wxPDF_LINEAR_GRADIENT_REFLECTION_RIGHT:Int = 5
Const wxPDF_LINEAR_GRADIENT_REFLECTION_TOP:Int = 6
Const wxPDF_LINEAR_GRADIENT_REFLECTION_BOTTOM:Int = 7

Const wxPDF_BLENDMODE_NORMAL:Int = 0
Const wxPDF_BLENDMODE_MULTIPLY:Int = 1
Const wxPDF_BLENDMODE_SCREEN:Int = 2
Const wxPDF_BLENDMODE_OVERLAY:Int = 3
Const wxPDF_BLENDMODE_DARKEN:Int = 4
Const wxPDF_BLENDMODE_LIGHTEN:Int = 5
Const wxPDF_BLENDMODE_COLORDODGE:Int = 6
Const wxPDF_BLENDMODE_COLORBURN:Int = 7
Const wxPDF_BLENDMODE_HARDLIGHT:Int = 8
Const wxPDF_BLENDMODE_SOFTLIGHT:Int = 9
Const wxPDF_BLENDMODE_DIFFERENCE:Int = 10
Const wxPDF_BLENDMODE_EXCLUSION:Int = 11
Const wxPDF_BLENDMODE_HUE:Int = 12
Const wxPDF_BLENDMODE_SATURATION:Int = 12
Const wxPDF_BLENDMODE_COLOR:Int = 13
Const wxPDF_BLENDMODE_LUMINOSITY:Int = 14


Const wxPDF_SHAPEDTEXTMODE_ONETIME:Int = 0
Const wxPDF_SHAPEDTEXTMODE_STRETCHTOFIT:Int = 1
Const wxPDF_SHAPEDTEXTMODE_REPEAT:Int = 2


