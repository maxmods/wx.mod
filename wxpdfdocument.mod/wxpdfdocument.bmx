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
bbdoc: wxPdfDocument
End Rem
Module wx.wxPdfDocument

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
bbdoc: A type which allows wxWidgets applications to generate PDF files.
End Rem
Type wxPdfDocument

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Function CreatePfdDocument:wxPdfDocument(orientation:Int = wxPORTRAIT, unit:String = "mm", format:Int = wxPAPER_A4)
		Return New wxPdfDocument.Create(orientation, unit, format)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPdfDocument(orientation:Int = wxPORTRAIT, unit:String = "mm", format:Int = wxPAPER_A4)
		wxObjectPtr = bmx_wxpdfdocument_create(Self, orientation, unit, format)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AcceptPageBreak:Int()
		Return bmx_wxpdfdocument_acceptpagebreak(wxObjectPtr)
	End Method
	
	Function _AcceptPageBreak:Int(obj:wxPdfDocument)
		Return obj.AcceptPageBreak()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method AddFont:Int(family:String, style:String = "", file:String = "")
		Return bmx_wxpdfdocument_addfont(wxObjectPtr, family, style, file)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddFontCJK:Int(family:String)
		Return bmx_wxpdfdocument_addfontcjk(wxObjectPtr, family)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddLink:Int()
		Return bmx_wxpdfdocument_addlink(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddPage(orientation:Int = -1)
		bmx_wxpdfdocument_addpage(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddSpotColor(name:String, cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_addspotcolor(wxObjectPtr, name, cyan, magenta, yellow, black)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AliasNbPages(_alias:String = "{nb}")
		bmx_wxpdfdocument_aliasnbpages(wxObjectPtr, _alias)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Annotate(x:Double, y:Double, text:String)
		bmx_wxpdfdocument_annotate(wxObjectPtr, x, y, text)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AppendJavascript(javascript:String)
		bmx_wxpdfdocument_appendjavascript(wxObjectPtr, javascript)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Arrow(x1:Double, y1:Double, x2:Double, y2:Double, lineWidth:Double, height:Double, width:Double)
		bmx_wxpdfdocument_arrow(wxObjectPtr, x1, y1, x2, y2, lineWidth, height, width)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AxialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0, ..
			y1:Double = 0, x2:Double = 1, y2:Double = 0, intexp:Double = 1)
		Return bmx_wxpdfdocument_axialgradient(wxObjectPtr, col1.wxObjectPtr, col2.wxObjectPtr, x1, y1, x2, y2, intexp)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method BeginTemplate:Int(x:Double = 0, y:Double = 0, width:Double = 0, height:Double = 0)
		Return bmx_wxpdfdocument_begintemplate(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Bookmark(txt:String, level:Int = 0, y:Double = 0)
		bmx_wxpdfdocument_bookmark(wxObjectPtr, txt, level, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Cell(w:Double, h:Double = 0, txt:String = "", border:Int = wxPDF_BORDER_NONE, ln:Int = 0, ..
			align:Int = wxPDF_ALIGN_LEFT, fill:Int = 0, link:wxPdfLink = Null)
		If link Then
			bmx_wxpdfdocument_cell(wxObjectPtr, w, h, txt, border, ln, align, fill, link.wxObjectPtr)
		Else
			bmx_wxpdfdocument_cell(wxObjectPtr, w, h, txt, border, ln, align, fill, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Circle(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, nSeg:Int = 8)
		bmx_wxpdfdocument_circle(wxObjectPtr, x0, y0, r, astart, afinish, style, nSeg)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CheckBox(name:String, width:Double, checked:Int = False)
		bmx_wxpdfdocument_checkbox(wxObjectPtr, name, width, checked)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CheckBoxXy(name:String, x:Double, y:Double, width:Double, checked:Int = False)
		bmx_wxpdfdocument_checkboxxy(wxObjectPtr, name, x, y, width, checked)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ComboBox(name:String, width:Double, height:Double, values:String[])
		bmx_wxpdfdocument_combobox(wxObjectPtr, name, width, height, values)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ComboBoxXy(name:String, x:Double, y:Double, width:Double, height:Double, values:String[])
		bmx_wxpdfdocument_comboboxxy(wxObjectPtr, name, x, y, width, height, values)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippedCell(w:Double, h:Double = 0, txt:String = "", border:Int = wxPDF_BORDER_NONE, ..
			ln:Int = 0, align:Int = wxPDF_ALIGN_LEFT, fill:Int = 0, link:wxPdfLink = Null)
		If link Then
			bmx_wxpdfdocument_clippedcell(wxObjectPtr, w, h, txt, border, ln, align, fill, link.wxObjectPtr)
		Else
			bmx_wxpdfdocument_clippedcell(wxObjectPtr, w, h, txt, border, ln, align, fill, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingEllipse(x:Double, y:Double, rx:Double, ry:Double = 0, outline:Int = False)
		bmx_wxpdfdocument_clippingellipse(wxObjectPtr, x, y, rx, ry, outline)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingPath()
		bmx_wxpdfdocument_clippingpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingPathShape(shape:wxPdfShape, style:Int = wxPDF_STYLE_NOOP)
		bmx_wxpdfdocument_clippingpathshape(wxObjectPtr, shape.wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingPolygon(x:Double[], y:Double[], outline:Int = False)
		bmx_wxpdfdocument_clippingpolygon(wxObjectPtr, x, y, outline)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingRect(x:Double, y:Double, w:Double, h:Double, outline:Int = False)
		bmx_wxpdfdocument_clippingrect(wxObjectPtr, x, y, w, h, outline)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClippingText(x:Double, y:Double, txt:String, outline:Int = False)
		bmx_wxpdfdocument_clippingtext(wxObjectPtr, x, y, txt, outline)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClosePath(style:Int = wxPDF_STYLE_NOOP)
		bmx_wxpdfdocument_closepath(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CoonsPatchGradient:Int(mesh:wxPdfCoonsPatchMesh, minCoord:Double = 0, maxCoord:Double = 1)
		Return bmx_wxpdfdocument_coonspatchgradient(wxObjectPtr, mesh.wxObjectPtr, minCoord, maxCoord)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Curve(x0:Double, y0:Double, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_curve(wxObjectPtr, x0, y0, x1, y1, x2, y2, x3, y3, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CurveTo(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double)
		bmx_wxpdfdocument_curveto(wxObjectPtr, x1, y1, x2, y2, x3, y3)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Ellipse(x0:Double, y0:Double, rx:Double, ry:Double = 0, angle:Double = 0, astart:Double = 0, ..
			afinish:Double = 360, style:Int = wxPDF_STYLE_DRAW, nSeg:Int = 8)
		bmx_wxpdfdocument_ellipse(wxObjectPtr, x0, y0, rx, ry, angle, astart, afinish, style, nSeg)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndTemplate:Int()
		Return bmx_wxpdfdocument_endtemplate(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Footer()
	End Method
	
	Function _Footer(doc:wxPdfDocument)
		doc.Footer()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetBreakMargin:Double()
		Return bmx_wxpdfdocument_getbreakmargin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellMargin:Double()
		Return bmx_wxpdfdocument_getcellmargin(wxObjectPtr)
	End Method
	
	Method GetDrawColor:wxPdfColour()
	End Method
	
	Method GetFillColor:wxPdfColour()
	End Method
	
	Method GetFontDescription:wxPdfFontDescription()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontFamily:String()
		Return bmx_wxpdfdocument_getfontfamily(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontPath:String()
		Return bmx_wxpdfdocument_getfontpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontSize:Double()
		Return bmx_wxpdfdocument_getfontsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontStyle:String()
		Return bmx_wxpdfdocument_getfontstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontSubsetting:Int()
		Return bmx_wxpdfdocument_getfontsubsetting(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetImageScale:Double()
		Return bmx_wxpdfdocument_getimagescale(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLeftMargin:Double()
		Return bmx_wxpdfdocument_getleftmargin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLineHeight:Double()
		Return bmx_wxpdfdocument_getlineheight(wxObjectPtr)
	End Method
	
	Method GetLineStyle:wxPdfLineStyle()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLineWidth:Double()
		Return bmx_wxpdfdocument_getlinewidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPageHeight:Double()
		Return bmx_wxpdfdocument_getpageheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPageWidth:Double()
		Return bmx_wxpdfdocument_getpagewidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRightMargin:Double()
		Return bmx_wxpdfdocument_getrightmargin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScaleFactor:Double()
		Return bmx_wxpdfdocument_getscalefactor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSourceInfo:Int(info:wxPdfInfo)
		Return bmx_wxpdfdocument_getsourceinfo(wxObjectPtr, info.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetStringWidth:Double(text:String)
		Return bmx_wxpdfdocument_getstringwidth(wxObjectPtr, text)
	End Method
	
	Method GetTemplateBBox(templateId:Int, x:Double Var, y:Double Var, width:Double Var, height:Double Var)
	End Method
	
	Method GetTemplateSize(templateId:Int, width:Double Var, height:Double Var)
	End Method

	Method GetTextColor:wxPdfColour()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetTopMargin:Double()
		Return bmx_wxpdfdocument_gettopmargin(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetX:Double()
		Return bmx_wxpdfdocument_getx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetY:Double()
		Return bmx_wxpdfdocument_gety(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Header()
	End Method
	
	' callback
	Function _Header(doc:wxPdfDocument)
		doc.Header()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Image:Int(file:String, x:Double, y:Double, w:Double = 0, h:Double = 0, mimeType:String = "", ..
			link:wxPdfLink = Null, maskImage:Int = 0)
		If link Then
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, link.wxObjectPtr, maskImage)
		Else
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, Null, maskImage)
		End If
	End Method

	Method ImageImage:Int(name:String, _image:wxImage, x:Double, y:Double, w:Double = 0, h:Double = 0, ..
			link:wxPdfLink = Null, maskImage:Int = 0)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ImageMask:Int(file:String, mimeType:String = "")
		Return bmx_wxpdfdocument_imagemask(wxObjectPtr, file, mimeType)
	End Method
	
	Method ImageMaskImage:Int(name:String, _image:wxImage)
	End Method
	
	Method ImportPage:Int(page:Int)
	End Method

	Method IsInFooter:Int()
	End Method
	
	Method Line(x1:Double, y1:Double, x2:Double, y2:Double)
	End Method
	
	Method LinearGradient:Int(col1:wxPdfColour, col2:wxPdfColour, gradientType:Int = wxPDF_LINEAR_GRADIENT_HORIZONTAL)
	End Method
	
	Method LineCount:Int(w:Double, txt:String)
	End Method
	
	Method LineTo(x:Double, y:Double)
	End Method
	
	Method Link(x:Double, y:Double, w:Double, h:Double, _link:wxPdfLink)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Ln(h:Double = -1)
		bmx_wxpdfdocument_ln(wxObjectPtr, h)
	End Method
	
	Method Marker(x:Double, y:Double, markerType:Int, size:Double)
	End Method
	
	Method MidAxialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0, ..
			y1:Double = 0, x2:Double = 1, y2:Double = 0, midpoint:Double = 0.5, intexp:Double = 1)
	End Method
	
	Method MirrorH(x:Double = -1)
	End Method

	Method MirrorV(x:Double = -1)
	End Method
	
	Method MoveTo(x:Double, y:Double)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MultiCell:Int(w:Double, h:Double, txt:String, border:Int = 0, align:Int = wxPDF_ALIGN_JUSTIFY, ..
			fill:Int = 0, maxline:Int = 0)
		Return bmx_wxpdfdocument_multicell(wxObjectPtr, w, h, txt, border, align, fill, maxline)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PageNo:Int()
		Return bmx_wxpdfdocument_pageno(wxObjectPtr)
	End Method
	
	Method Polygon(x:Double[], y:Double[], style:Int = wxPDF_STYLE_DRAW)
	End Method

	Method PushButton(name:String, width:Double, height:Double, caption:String, action:String)
	End Method

	Method PushButtonXy(name:String, x:Double, y:Double, width:Double, height:Double, caption:String, action:String)
	End Method


	Method RadialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0.5, ..
			y1:Double = 0.5, r1:Double = 0, x2:Double = 0.5, y2:Double = 0.5, r2:Double = 1, intexp:Double = 1)
	End Method

	Method RadioButton(group:String, name:String, width:Double)
	End Method

	Method RadioButtonXY(group:String, name:String, x:Double, y:Double, width:Double)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Rect(x:Double, y:Double, w:Double, h:Double, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_rect(wxObjectPtr, x, y, w, h, style)
	End Method
	
	Method RegularPolygon(x0:Double, y0:Double, r:Double, ns:Int, angle:Double = 0, circle:Int = False, ..
			style:Int = wxPDF_STYLE_DRAW, circleStyle:Int = wxPDF_STYLE_DRAW, ..
			circleLineStyle:wxPdfLineStyle = Null, circleFillColor:wxPdfColour = Null)
	End Method
	
	Method Rotate(angle:Double, x:Double = -1, y:Double = -1)
	End Method
	
	Method RotatedImage(file:String, x:Double, y:Double, w:Double, h:Double, angle:Double, ..
			imgType:String = "", link:wxPdfLink = Null, maskImage:Int = 0)
	End Method
	
	Method RotatedText(x:Double, y:Double, txt:String, angle:Double)
	End Method
	
	Method RoundedRect(x:Double, y:Double, w:Double, h:Double, roundCorner:Int = wxPDF_CORNER_ALL, style:Int = wxPDF_STYLE_DRAW)
	End Method

	
	Rem
	bbdoc: Saves the document to a file on disk.
	about: The method first calls Close() if necessary to terminate the document. 
	<p>Parameters :
	<ul>
	<li>@name - The name of the file. If not given, the document will be named 'doc.pdf'</li>
	</ul>
	</p>
	End Rem
	Method SaveAsFile(name:String = "")
		bmx_wxpdfdocument_saveasfile(wxObjectPtr, name)
	End Method
	
	Method Scale:Int(sx:Double, sy:Double, x:Double = -1, y:Double = -1)
	End Method
	
	Method ScaleX:Int(sx:Double, x:Double = -1, y:Double = -1)
	End Method

	Method ScaleY:Int(sy:Double, x:Double = -1, y:Double = -1)
	End Method

	Method ScaleXY:Int(s:Double, x:Double = -1, y:Double = -1)
	End Method
	

	Method Sector(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, clockwise:Int = True, origin:Double = 90)
	End Method
	
	Method SetAlpha:Int(lineAlpha:Double = 1, fillAlpha:Double = 1, blendMode:Int = wxPDF_BLENDMODE_NORMAL)
		Return bmx_wxpdfdocument_setalpha(wxObjectPtr, lineAlpha, fillAlpha, blendMode)
	End Method
	
	Method SetAlphaState(state:Int)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetAuthor(author:String)
		bmx_wxpdfdocument_setauthor(wxObjectPtr, author)
	End Method

	Method SetAutoPageBreak(autoPageBreak:Int, margin:Double = 0)
	End Method
	
	Method SetCellMargin(margin:Double)
	End Method
	
	Method SetCompression(compress:Int)
	End Method
	
	Method SetCreator(creator:String)
	End Method
	
	Method SetDisplayMode(zoom:Int, layout:Int = wxPDF_LAYOUT_CONTINUOUS, zoomFactor:Double = 100)
	End Method
	
	Method SetDrawColorGrayScale(grayscale:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColor(colour:wxColour)
		bmx_wxpdfdocument_setdrawcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetDrawColorPdf(pdfColour:wxPdfColour)
	End Method
	
	Method SetDrawColorRGB(red:Int, green:Int, blue:Int)
	End Method
	
	Method SetDrawColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
	End Method
	
	Method SetDrawColorName(name:String, tint:Double = 100)
	End Method

	Method SetFillColorGrayScale(grayscale:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColor(colour:wxColour)
		bmx_wxpdfdocument_setfillcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetFillColorPdf(pdfColour:wxPdfColour)
	End Method
	
	Method SetFillColorRGB(red:Int, green:Int, blue:Int)
	End Method
	
	Method SetFillColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
	End Method
	
	Method SetFillColorName(name:String, tint:Double = 100)
	End Method
	
	Method SetFillGradient(x:Double, y:Double, w:Double, h:Double, gradient:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(family:String, style:String = "", size:Double = 0)
		bmx_wxpdfdocument_setfont(wxObjectPtr, family, style, size)
	End Method
	
	Method SetFontPath(fontPath:String = "")
	End Method
	
	Method SetFontSize(size:Double)
	End Method
	
	Method SetFontSubsetting(fontSubsetting:Int = True)
	End Method
	
	Method SetFormBorderStyle(borderStyle:Int = wxPDF_BORDER_SOLID, borderWidth:Double = -1)
	End Method
	
	Method SetFormColors(borderColour:wxPdfColour = Null, backgroundColor:wxPdfColour = Null, ..
			textColor:wxPdfColour = Null)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetImageScale(scale:Double)
		bmx_wxpdfdocument_setimagescale(wxObjectPtr, scale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetKeywords(keywords:String)
		bmx_wxpdfdocument_setkeywords(wxObjectPtr, keywords)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetLeftMargin(margin:Double)
		bmx_wxpdfdocument_setleftmargin(wxObjectPtr, margin)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLineHeight(height:Double)
		bmx_wxpdfdocument_setlineheight(wxObjectPtr, height)
	End Method
	
	Method SetLineStyle(style:wxPdfLineStyle)
		'bmx_wxpdfdocument_setlinestyle(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLineWidth(width:Double)
		bmx_wxpdfdocument_setlinewidth(wxObjectPtr, width)
	End Method

	Method SetLink:Int(link:Int, y:Double = 0, page:Int = -1)
		Return bmx_wxpdfdocument_setlink(wxObjectPtr, link, y, page)
	End Method
	
	Method SetMargins(marginLeft:Double, marginTop:Double, marginRight:Double = -1)
	End Method
	
	Method SetProtection(permissions:Int, userPassword:String = "", ownerPassword:String = "", ..
			encryptionMethod:Int = wxPDF_ENCRYPTION_RC4V1, keyLength:Int = 0)
		
	End Method
	
	Method SetRightMargin(margin:Double)
	End Method
	
	Method SetSourceFile:Int(filename:String, password:String = "")
	End Method
	
	Method SetSubject(subject:String)
	End Method
	
	Method SetTemplateBBox(templateId:Int, x:Double, y:Double, width:Double, height:Double)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetTextColorGrayScale(grayscale:Int)
		bmx_wxpdfdocument_settextcolorgrayscale(wxObjectPtr, grayscale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTextColor(colour:wxColour)
		bmx_wxpdfdocument_settextcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetTextColorPdf(pdfColour:wxPdfColour)
	End Method
	
	Method SetTextColorRGB(red:Int, green:Int, blue:Int)
	End Method
	
	Method SetTextColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
	End Method
	
	Method SetTextColorName(name:String, tint:Double = 100)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTitle(title:String)
		bmx_wxpdfdocument_settitle(wxObjectPtr, title)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetTopMargin(margin:Double)
		bmx_wxpdfdocument_settopmargin(wxObjectPtr, margin)
	End Method
		
	Rem
	bbdoc: 
	End Rem
	Method SetViewerPreferences(preferences:Int = 0)
		bmx_wxpdfdocument_setviewerpreferences(wxObjectPtr, preferences)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetX(x:Double)
		bmx_wxpdfdocument_setx(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetXY(x:Double, y:Double)
		bmx_wxpdfdocument_setxy(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetY(y:Double)
		bmx_wxpdfdocument_sety(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Shape(_shape:wxPdfShape, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_shape(wxObjectPtr, _shape.wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShapedText(shape:wxPdfShape, text:String, mode:Int = wxPDF_SHAPEDTEXTMODE_STRETCHTOFIT)
		bmx_wxpdfdocument_shapedtext(wxObjectPtr, shape.wxObjectPtr, text, mode)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Skew:Int(xAngle:Double, yAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skew(wxObjectPtr, xAngle, yAngle, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SkewX:Int(xAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skewx(wxObjectPtr, xAngle, x, y)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SkewY:Int(yAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skewy(wxObjectPtr, yAngle, x, y)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method StarPolygon(x0:Double, y0:Double, r:Double, nv:Int, nr:Int, angle:Double = 0, circle:Int = False, ..
			style:Int = wxPDF_STYLE_DRAW, circleStyle:Int = wxPDF_STYLE_DRAW, ..
			circleLineStyle:wxPdfLineStyle = Null, circleFillColor:wxPdfColour = Null)
		If circleLineStyle Then
			If circleFillColor Then
				bmx_wxpdfdocument_starpolygon(wxObjectPtr, x0, y0, r, nv, nr, angle, circle, style, circleStyle, circleLineStyle.wxObjectPtr, circleFillColor.wxObjectPtr)
			Else
				bmx_wxpdfdocument_starpolygon(wxObjectPtr, x0, y0, r, nv, nr, angle, circle, style, circleStyle, circleLineStyle.wxObjectPtr, Null)
			End If
		Else
			If circleFillColor Then
				bmx_wxpdfdocument_starpolygon(wxObjectPtr, x0, y0, r, nv, nr, angle, circle, style, circleStyle, Null, circleFillColor.wxObjectPtr)
			Else
				bmx_wxpdfdocument_starpolygon(wxObjectPtr, x0, y0, r, nv, nr, angle, circle, style, circleStyle, Null, Null)
			End If
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method StartTransform()
		bmx_wxpdfdocument_starttransform(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method StopTransform()
		bmx_wxpdfdocument_stoptransform(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Text(x:Double, y:Double, txt:String)
		bmx_wxpdfdocument_text(wxObjectPtr, x, y, txt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TextBox:Int(w:Double, h:Double, txt:String, halign:Int = wxPDF_ALIGN_JUSTIFY, ..
			valign:Int = wxPDF_ALIGN_TOP, border:Int = 0, fill:Int = 0)
		Return bmx_wxpdfdocument_textbox(wxObjectPtr, w, h, txt, halign, valign, border, fill)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method TextField(name:String, width:Double, height:Double, value:String = "", multiline:Int = False)
		bmx_wxpdfdocument_textfield(wxObjectPtr, name, width, height, value, multiline)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method TextFieldXY(name:String, x:Double, y:Double, width:Double, height:Double, value:String = "", multiline:Int = False)
		bmx_wxpdfdocument_textfieldxy(wxObjectPtr, name, x, y, width, height, value, multiline)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Translate(tx:Double, ty:Double)
		bmx_wxpdfdocument_translate(wxObjectPtr, tx, ty)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TranslateX(tx:Double)
		bmx_wxpdfdocument_translatex(wxObjectPtr, tx)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method TranslateY(ty:Double)
		bmx_wxpdfdocument_translatey(wxObjectPtr, ty)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method UnsetClipping()
		bmx_wxpdfdocument_unsetclipping(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method UseTemplate(templateId:Int, x:Double = -1, y:Double = -1, width:Double = 0, height:Double = 0)
		bmx_wxpdfdocument_usetemplate(wxObjectPtr, templateId, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Write(h:Double, txt:String, link:wxPdfLink = Null)
		If link Then
			bmx_wxpdfdocument_write(wxObjectPtr, h, txt, link.wxObjectPtr)
		Else
			bmx_wxpdfdocument_write(wxObjectPtr, h, txt, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WriteCell(h:Double, txt:String, border:Int = wxPDF_BORDER_NONE, fill:Int = 0, link:wxPdfLink = Null)
		If link Then
			bmx_wxpdfdocument_writecell(wxObjectPtr, h, txt, border, fill, link.wxObjectPtr)
		Else
			bmx_wxpdfdocument_writecell(wxObjectPtr, h, txt, border, fill, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WriteXml(txt:String)
		bmx_wxpdfdocument_writexml(wxObjectPtr, txt)
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxpdfdocument_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPdfLink

	Field wxObjectPtr:Byte Ptr

End Type

Rem
bbdoc: 
End Rem
Type wxPdfColour
	
	Field wxObjectPtr:Byte Ptr
	
	
End Type

Rem
bbdoc: 
End Rem
Type wxPdfLineStyle

	Field wxObjectPtr:Byte Ptr

End Type


Rem
bbdoc: 
End Rem
Type wxPdfShape

	Field wxObjectPtr:Byte Ptr

End Type

Rem
bbdoc: 
End Rem
Type wxPdfCoonsPatchMesh

	Field wxObjectPtr:Byte Ptr

End Type

Rem
bbdoc: 
End Rem
Type wxPdfFontDescription

	Field wxObjectPtr:Byte Ptr

End Type

Rem
bbdoc: 
End Rem
Type wxPdfInfo

	Field wxObjectPtr:Byte Ptr

End Type

Rem
bbdoc: A type representing barcode objects.
about: All supported barcodes are drawn directly in PDF without using an image or special font.
End Rem
Type wxPdfBarCodeCreator

	Field wxObjectPtr:Byte Ptr

	Function CreatePdfBarCodeCreator:wxPdfBarCodeCreator(document:wxPdfDocument)
		Return New wxPdfBarCodeCreator.Create(document)
	End Function
	
	Method Create:wxPdfBarCodeCreator(document:wxPdfDocument)
		
		Return Self
	End Method
	
	
End Type

