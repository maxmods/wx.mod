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
bbdoc: 
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
	Method AddPage(orientation:Int = -1)
		bmx_wxpdfdocument_addpage(wxObjectPtr, orientation)
	End Method
	
	Method AddSpotColor(name:String, cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_addspotcolor(wxObjectPtr, name, cyan, magenta, yellow, black)
	End Method
	
	Method AliasNbPages(_alias:String = "{nb}")
		bmx_wxpdfdocument_aliasnbpages(wxObjectPtr, _alias)
	End Method
	
	Method Arrow(x1:Double, y1:Double, x2:Double, y2:Double, lineWidth:Double, height:Double, width:Double)
		bmx_wxpdfdocument_arrow(wxObjectPtr, x1, y1, x2, y2, lineWidth, height, width)
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

	Method Circle(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, nSeg:Int = 8)
		bmx_wxpdfdocument_circle(wxObjectPtr, x0, y0, r, astart, afinish, style, nSeg)
	End Method

	Method Curve(x0:Double, y0:Double, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_curve(wxObjectPtr, x0, y0, x1, y1, x2, y2, x3, y3, style)
	End Method

	Method Ellipse(x0:Double, y0:Double, rx:Double, ry:Double = 0, angle:Double = 0, astart:Double = 0, ..
			afinish:Double = 360, style:Int = wxPDF_STYLE_DRAW, nSeg:Int = 8)
		bmx_wxpdfdocument_ellipse(wxObjectPtr, x0, y0, rx, ry, angle, astart, afinish, style, nSeg)
	End Method

	Method Footer()
	End Method
	
	Function _Footer(doc:wxPdfDocument)
		doc.Footer()
	End Function
	
	Method GetBreakMargin:Double()
	End Method
	
	Method GetCellMargin:Double()
	End Method
	
	Method GetDrawColor:wxPdfColour()
	End Method
	
	Method GetFillColor:wxPdfColour()
	End Method
	
	Method GetImageScale:Double()
	End Method
	
	Method GetLeftMargin:Double()
	End Method
	
	Method GetLineHeight:Double()
	End Method
	
	Method GetLineStyle:wxPdfLineStyle()
	End Method
	
	Method GetLineWidth:Double()
	End Method
	
	Method GetPageHeight:Double()
	End Method
	
	Method GetPageWidth:Double()
	End Method
	
	Method GetRightMargin:Double()
	End Method
	
	Method GetScaleFactor:Double()
	End Method
	
	Method GetStringWidth:Double(text:String)
		Return bmx_wxpdfdocument_getstringwidth(wxObjectPtr, text)
	End Method

	Method GetTextColor:wxPdfColour()
	End Method

	Method GetTopMargin:Double()
	End Method


	Method Header()
	End Method
	
	Function _Header(doc:wxPdfDocument)
		doc.Header()
	End Function
	
	Method Image:Int(file:String, x:Double, y:Double, w:Double = 0, h:Double = 0, mimeType:String = "", ..
			link:wxPdfLink = Null, maskImage:Int = 0)
		If link Then
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, link.wxObjectPtr, maskImage)
		Else
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, Null, maskImage)
		End If
	End Method

	Method IsInFooter:Int()
	End Method
	
	Method Line(x1:Double, y1:Double, x2:Double, y2:Double)
	End Method
	
	Method Ln(h:Double = -1)
		bmx_wxpdfdocument_ln(wxObjectPtr, h)
	End Method
	
	Method MultiCell:Int(w:Double, h:Double, txt:String, border:Int = 0, align:Int = wxPDF_ALIGN_JUSTIFY, ..
			fill:Int = 0, maxline:Int = 0)
		Return bmx_wxpdfdocument_multicell(wxObjectPtr, w, h, txt, border, align, fill, maxline)
	End Method
	
	Method PageNo:Int()
		Return bmx_wxpdfdocument_pageno(wxObjectPtr)
	End Method
	
	Method Rect(x:Double, y:Double, w:Double, h:Double, style:Int = wxPDF_STYLE_DRAW)
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

	Method Sector(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, clockwise:Int = True, origin:Double = 90)
	End Method

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
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(family:String, style:String = "", size:Double = 0)
		bmx_wxpdfdocument_setfont(wxObjectPtr, family, style, size)
	End Method
	
	
	Method SetImageScale(scale:Double)
	End Method
	
	Method SetKeywords(keywords:String)
	End Method

	Method SetLeftMargin(margin:Double)
	End Method
	
	Method SetLineHeight(height:Double)
	End Method
	
	Method SetLineStyle(style:wxPdfLineStyle)
	End Method
	
	Method SetLineWidth(width:Double)
		bmx_wxpdfdocument_setlinewidth(wxObjectPtr, width)
	End Method
	
	Method SetMargins(marginLeft:Double, marginTop:Double, marginRight:Double = -1)
	End Method
	
	Method SetProtection(permissions:Int, userPassword:String = "", ownerPassword:String = "", ..
			encryptionMethod:Int = wxPDF_ENCRYPTION_RC4V1, keyLength:Int = 0)
		
	End Method
	
	Method SetRightMargin(margin:Double)
	End Method
	
	Method SetSubject(subject:String)
	End Method

	Method SetTextColorGrayScale(grayscale:Int)
		bmx_wxpdfdocument_settextcolorgrayscale(wxObjectPtr, grayscale)
	End Method
	
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
	
	Method SetTitle(title:String)
		bmx_wxpdfdocument_settitle(wxObjectPtr, title)
	End Method

	Method SetTopMargin(margin:Double)
	End Method
		
	Method SetViewerPreferences(preferences:Int = 0)
	End Method
	
	Method SetX(x:Double)
		bmx_wxpdfdocument_setx(wxObjectPtr, x)
	End Method
	
	Method SetY(y:Double)
		bmx_wxpdfdocument_sety(wxObjectPtr, y)
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

Type wxPdfLink

	Field wxObjectPtr:Byte Ptr

End Type

Type wxPdfColour
	
	Field wxObjectPtr:Byte Ptr
	
	
End Type

Type wxPdfLineStyle

End Type


Type wxPdfShape

End Type

