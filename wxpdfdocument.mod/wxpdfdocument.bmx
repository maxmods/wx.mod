' Copyright (c) 2007-2011 Bruce A Henderson
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
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A type which allows wxWidgets applications to generate PDF files.
about: The main features are:
<ul>
<li>Choice of measure unit, page format and margins</li>
<li>Page header and footer management</li>
<li>Automatic page break</li>
<li>Automatic line break and text justification</li>
<li>Image support (GIF, JPEG, PNG and WMF)</li>
<li>Colors (Grayscale, RGB, CMYK, Spot colors)</li>
<li>Links (internal and external)</li>
<li>14 Adobe standard fonts</li>
<li>TrueType and Type1 fonts (with or without embedding) and encoding support</li>
<li>TrueType Unicode and Type0 fonts (for Chinese, Japanese and Korean) support in the Unicode build</li>
<li>Page compression</li>
<li>Graphics primitives for the creation of simple drawings</li>
<li>Definition of clipping areas</li>
<li>Bookmarks for outlining the document</li>
<li>Rotation</li>
<li>Protecting the document by passwords and/or access permissions</li>
<li>Text annotations</li>
<li>PDF forms (supported field types: text, combo box, check box, radio button, push button)</li>
<li>JavaScript</li>
<li>Fill gradients</li>
<li>Templates</li>
</ul>
End Rem
Type wxPdfDocument

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Constructor.
	about:  Parameters :
	<ul>
	<li>@orientation - Defines the default page orientation. Possible values are wxPORTRAIT and wxLANDSCAPE.</li>
	<li>@unit - Defines the user units. Possible values are: 
	<ul>
	<li>"mm" millimeter (1 mm = 0.0394 in = 2.833 pt = 0.1 cm) (default)</li>
	<li>"cm" centimeter (1 cm = 0.394 in = 28.33 pt = 10 mm)</li>
	<li>"pt" points (1 pt = 1/72 in = 0.0353 cm = 0.353 mm)</li>
	<li>"in" inch (1 in = 72 pt = 2.54 cm = 25.4 mm)</li>
	</ul>
	</li>
	<li>@format - Defines the page format. All known wxWidgets paper types are allowed. (Default: wxPAPER_A4)</li>
	</ul>
	End Rem
	Function CreatePfdDocument:wxPdfDocument(orientation:Int = wxPORTRAIT, unit:String = "mm", format:Int = wxPAPER_A4)
		Return New wxPdfDocument.Create(orientation, unit, format)
	End Function
	
	Rem
	bbdoc: Constructor.
	about:  Parameters :
	<ul>
	<li>@orientation - Defines the default page orientation. Possible values are wxPORTRAIT and wxLANDSCAPE.</li>
	<li>@unit - Defines the user units. Possible values are: 
	<ul>
	<li>"mm" millimeter (1 mm = 0.0394 in = 2.833 pt = 0.1 cm) (default)</li>
	<li>"cm" centimeter (1 cm = 0.394 in = 28.33 pt = 10 mm)</li>
	<li>"pt" points (1 pt = 1/72 in = 0.0353 cm = 0.353 mm)</li>
	<li>"in" inch (1 in = 72 pt = 2.54 cm = 25.4 mm)</li>
	</ul>
	</li>
	<li>@format - Defines the page format. All known wxWidgets paper types are allowed. (Default: wxPAPER_A4)</li>
	</ul>
	End Rem
	Method Create:wxPdfDocument(orientation:Int = wxPORTRAIT, unit:String = "mm", format:Int = wxPAPER_A4)
		wxObjectPtr = bmx_wxpdfdocument_create(Self, orientation, unit, format)
		Return Self
	End Method
	
	Rem
	bbdoc: Whenever a page break condition is met, this method is called, and the break is issued or not depending on the returned value.
	about: The default implementation returns a value according to the mode selected by SetAutoPageBreak()
	<p>
	This method is called automatically and should not be called directly by the application.
	</p>
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
	bbdoc: Creates a new internal link and returns its identifier.
	about: An internal link is a clickable area which directs to another place within the
	document. The identifier can then be passed to #Cell(), #Write(), #Image() or #Link(). 
	The destination is defined with #SetLink().
	End Rem
	Method AddLink:Int()
		Return bmx_wxpdfdocument_addlink(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds a new page to the document.
	about: If a page is already present, the #Footer() method is called first to output the
	footer. Then the page is added, the current position set to the top-left corner
	according to the left and top margins, and Header() is called to display the header.
	The font which was set before calling is automatically restored. There is no need to
	call #SetFont() again if you want to continue with the same font. The same is true for
	colors and line width. The origin of the coordinate system is at the top-left corner
	and increasing ordinates go downwards.
	<p>Parameters:
	<ul>
	<li>@orientation - Page orientation. Possible values are, wxPORTRAIT and wxLANDSCAPE</li>
	</ul>
	</p>
	End Rem
	Method AddPage(orientation:Int = -1)
		bmx_wxpdfdocument_addpage(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: Add spot color.
	about: Add a spot color which can be referenced in color setting methods
	<p>Parameters :
	<ul>
	<li>@name - the name of the spot color (case sensitive)</li>
	<li>@cyan - indicates the cyan level. Value between 0 and 100 </li>
	<li>@magenta - indicates the magenta level. Value between 0 and 100 </li>
	<li>@yellow - indicates the yellow level. Value between 0 and 100 </li>
	<li>@black - indicates the black level. Value between 0 and 100 </li>
	</ul>
	</p>
	End Rem
	Method AddSpotColor(name:String, cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_addspotcolor(wxObjectPtr, name, cyan, magenta, yellow, black)
	End Method
	
	Rem
	bbdoc: Defines an alias for the total number of pages.
	about: It will be substituted as the document is closed.
	<p>Parameters :
	<ul>
	<li>@alias - The alias. Default value: {nb} </li>
	</ul>
	</p>
	End Rem
	Method AliasNbPages(_alias:String = "{nb}")
		bmx_wxpdfdocument_aliasnbpages(wxObjectPtr, _alias)
	End Method
	
	Rem
	bbdoc: Adds a text annotation.
	about: Parameters :
	<ul>
	<li>@x - abscissa of the annotation symbol</li>
	<li>@y - ordinate of the annotation symbol</li>
	<li>@text - annotation text </li>
	</ul>
	End Rem
	Method Annotate(x:Double, y:Double, text:String)
		bmx_wxpdfdocument_annotate(wxObjectPtr, x, y, text)
	End Method
	
	Rem
	bbdoc: Appends Javascript.
	about: Allows to append Javascript code to a Javascript object at the document level.
	<p>Parameters :
	<ul>
	<li>@javascript - Javascript code to be appended </li>
	</ul>
	</p>
	End Rem
	Method AppendJavascript(javascript:String)
		bmx_wxpdfdocument_appendjavascript(wxObjectPtr, javascript)
	End Method
	
	Rem
	bbdoc: Draws an arrow line between two points.
	about: Parameters :
	<ul>
	<li>@x1 - Abscissa of first point </li>
	<li>@y1 - Ordinate of first point </li>
	<li>@x2 - Abscissa of second point </li>
	<li>@y2 - Ordinate of second point </li>
	<li>@linewidth - line width </li>
	<li>@height - height of the arrow head </li>
	<li>@width - width of the arrow head </li>
	</ul>
	End Rem
	Method Arrow(x1:Double, y1:Double, x2:Double, y2:Double, lineWidth:Double, height:Double, width:Double)
		bmx_wxpdfdocument_arrow(wxObjectPtr, x1, y1, x2, y2, lineWidth, height, width)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method AxialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0, ..
			y1:Double = 0, x2:Double = 1, y2:Double = 0, intexp:Double = 1)
		Return bmx_wxpdfdocument_axialgradient(wxObjectPtr, col1.wxObjectPtr, col2.wxObjectPtr, x1, y1, x2, y2, intexp)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method BeginTemplate:Int(x:Double = 0, y:Double = 0, width:Double = 0, height:Double = 0)
		Return bmx_wxpdfdocument_begintemplate(wxObjectPtr, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Bookmark(txt:String, level:Int = 0, y:Double = 0)
		bmx_wxpdfdocument_bookmark(wxObjectPtr, txt, level, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Circle(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, nSeg:Int = 8)
		bmx_wxpdfdocument_circle(wxObjectPtr, x0, y0, r, astart, afinish, style, nSeg)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method CheckBox(name:String, width:Double, checked:Int = False)
		bmx_wxpdfdocument_checkbox(wxObjectPtr, name, width, checked)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method CheckBoxXy(name:String, x:Double, y:Double, width:Double, checked:Int = False)
		bmx_wxpdfdocument_checkboxxy(wxObjectPtr, name, x, y, width, checked)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ComboBox(name:String, width:Double, height:Double, values:String[])
		bmx_wxpdfdocument_combobox(wxObjectPtr, name, width, height, values)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ComboBoxXy(name:String, x:Double, y:Double, width:Double, height:Double, values:String[])
		bmx_wxpdfdocument_comboboxxy(wxObjectPtr, name, x, y, width, height, values)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ClippingPathShape(shape:wxPdfShape, style:Int = wxPDF_STYLE_NOOP)
		bmx_wxpdfdocument_clippingpathshape(wxObjectPtr, shape.wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ClippingPolygon(x:Double[], y:Double[], outline:Int = False)
		bmx_wxpdfdocument_clippingpolygon(wxObjectPtr, x, y, outline)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ClippingRect(x:Double, y:Double, w:Double, h:Double, outline:Int = False)
		bmx_wxpdfdocument_clippingrect(wxObjectPtr, x, y, w, h, outline)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ClippingText(x:Double, y:Double, txt:String, outline:Int = False)
		bmx_wxpdfdocument_clippingtext(wxObjectPtr, x, y, txt, outline)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ClosePath(style:Int = wxPDF_STYLE_NOOP)
		bmx_wxpdfdocument_closepath(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method CoonsPatchGradient:Int(mesh:wxPdfCoonsPatchMesh, minCoord:Double = 0, maxCoord:Double = 1)
		Return bmx_wxpdfdocument_coonspatchgradient(wxObjectPtr, mesh.wxObjectPtr, minCoord, maxCoord)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Curve(x0:Double, y0:Double, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_curve(wxObjectPtr, x0, y0, x1, y1, x2, y2, x3, y3, style)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method CurveTo(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double)
		bmx_wxpdfdocument_curveto(wxObjectPtr, x1, y1, x2, y2, x3, y3)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	bbdoc: This method is used to render the page footer.
	about: It is automatically called by #AddPage() and #Close() and should not be called
	directly by the application. The implementation in wxPdfDocument is empty, so you have
	to subclass it and override the method if you want a specific processing.
	End Rem
	Method Footer()
	End Method
	
	Function _Footer(doc:wxPdfDocument)
		doc.Footer()
	End Function
	
	Rem
	bbdoc: Returns the page break margin.
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
	
	Rem
	bbdoc: 
	End Rem
	Method GetDrawColor:wxPdfColour()
		Return wxPdfColour._create(bmx_wxpdfdocument_getdrawcolor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFillColor:wxPdfColour()
		Return wxPdfColour._create(bmx_wxpdfdocument_getfillcolor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFontDescription:wxPdfFontDescription()
		Return wxPdfFontDescription._create(bmx_wxpdfdocument_getfontdescription(wxObjectPtr))
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
	
	Rem
	bbdoc: 
	End Rem
	Method GetLineStyle:wxPdfLineStyle()
		Return wxPdfLineStyle._create(bmx_wxpdfdocument_getlinestyle(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the current line width.
	End Rem
	Method GetLineWidth:Double()
		Return bmx_wxpdfdocument_getlinewidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page height in units.
	End Rem
	Method GetPageHeight:Double()
		Return bmx_wxpdfdocument_getpageheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page width in units.
	End Rem
	Method GetPageWidth:Double()
		Return bmx_wxpdfdocument_getpagewidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the right margin.
	End Rem
	Method GetRightMargin:Double()
		Return bmx_wxpdfdocument_getrightmargin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the scale factor (number of points in user unit).
	End Rem
	Method GetScaleFactor:Double()
		Return bmx_wxpdfdocument_getscalefactor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method GetSourceInfo:Int(info:wxPdfInfo)
		Return bmx_wxpdfdocument_getsourceinfo(wxObjectPtr, info.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method GetStringWidth:Double(text:String)
		Return bmx_wxpdfdocument_getstringwidth(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method GetTemplateBBox(templateId:Int, x:Double Var, y:Double Var, width:Double Var, height:Double Var)
		bmx_wxpdfdocument_gettemplatebbox(wxObjectPtr, templateId, Varptr x, Varptr y, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method GetTemplateSize(templateId:Int, width:Double Var, height:Double Var)
		bmx_wxpdfdocument_gettemplatessize(wxObjectPtr, templateId, Varptr width, Varptr height)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetTextColor:wxPdfColour()
		Return wxPdfColour._create(bmx_wxpdfdocument_gettextcolor(wxObjectPtr))
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
	bbdoc: This method is used to render the page header.
	about: It is automatically called by @AddPage() and should not be called directly by
	the application. The implementation in wxPdfDocument is empty, so you have to subclass
	it and override the method if you want a specific processing.
	End Rem
	Method Header()
	End Method
	
	' callback
	Function _Header(doc:wxPdfDocument)
		doc.Header()
	End Function
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Image:Int(file:String, x:Double, y:Double, w:Double = 0, h:Double = 0, mimeType:String = "", ..
			link:wxPdfLink = Null, maskImage:Int = 0)
		If link Then
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, link.wxObjectPtr, maskImage)
		Else
			Return bmx_wxpdfdocument_image(wxObjectPtr, file, x, y, w, h, mimeType, Null, maskImage)
		End If
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ImageImage:Int(name:String, _image:wxImage, x:Double, y:Double, w:Double = 0, h:Double = 0, ..
			link:wxPdfLink = Null, maskImage:Int = 0)
		If link Then
			Return bmx_wxpdfdocument_imageimage(wxObjectPtr, name, _image.wxObjectPtr, x, y, w, h, link.wxObjectPtr, maskImage)
		Else
			Return bmx_wxpdfdocument_imageimage(wxObjectPtr, name, _image.wxObjectPtr, x, y, w, h, Null, maskImage)
		End If
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ImageMask:Int(file:String, mimeType:String = "")
		Return bmx_wxpdfdocument_imagemask(wxObjectPtr, file, mimeType)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ImageMaskImage:Int(name:String, _image:wxImage)
		Return bmx_wxpdfdocument_imagemaskimage(wxObjectPtr, name, _image.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ImportPage:Int(page:Int)
		Return bmx_wxpdfdocument_importpage(wxObjectPtr, page)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsInFooter:Int()
		Return bmx_wxpdfdocument_isinfooter(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Line(x1:Double, y1:Double, x2:Double, y2:Double)
		bmx_wxpdfdocument_line(wxObjectPtr, x1, y1, x2, y2)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method LinearGradient:Int(col1:wxPdfColour, col2:wxPdfColour, gradientType:Int = wxPDF_LINEAR_GRADIENT_HORIZONTAL)
		Return bmx_wxpdfdocument_lineargradient(wxObjectPtr, col1.wxObjectptr, col2.wxObjectPtr, gradientType)
	End Method
	
	Rem
	bbdoc: Counts the number of lines a text would occupy in respect to a given maximal width.
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method LineCount:Int(w:Double, txt:String)
		Return bmx_wxpdfdocument_linecount(wxObjectPtr, w, txt)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method LineTo(x:Double, y:Double)
		bmx_wxpdfdocument_lineto(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Link(x:Double, y:Double, w:Double, h:Double, _link:wxPdfLink)
		bmx_wxpdfdocument_link(wxObjectPtr, x, y, w, h, _link.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Ln(h:Double = -1)
		bmx_wxpdfdocument_ln(wxObjectPtr, h)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Marker(x:Double, y:Double, markerType:Int, size:Double)
		bmx_wxpdfdocument_marker(wxObjectPtr, x, y, markerType, size)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method MidAxialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0, ..
			y1:Double = 0, x2:Double = 1, y2:Double = 0, midpoint:Double = 0.5, intexp:Double = 1)
		bmx_wxpdfdocument_midaxialgradient(wxObjectPtr, col1.wxObjectPtr, col2.wxObjectPtr, x1, y1, x2, y2, midpoint, intexp)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method MirrorH(x:Double = -1)
		bmx_wxpdfdocument_mirrorh(wxObjectPtr, x)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method MirrorV(y:Double = -1)
		bmx_wxpdfdocument_mirrorv(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method MoveTo(x:Double, y:Double)
		bmx_wxpdfdocument_moveto(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Polygon(x:Double[], y:Double[], style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_polygon(wxObjectPtr, x, y, style)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method PushButton(name:String, width:Double, height:Double, caption:String, action:String)
		bmx_wxpdfdocument_pushbutton(wxObjectPtr, name, width, height, caption, action)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method PushButtonXy(name:String, x:Double, y:Double, width:Double, height:Double, caption:String, action:String)
		bmx_wxpdfdocument_pushbuttonxy(wxObjectPtr, name, x, y, width, height, caption, action)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RadialGradient:Int(col1:wxPdfColour, col2:wxPdfColour, x1:Double = 0.5, ..
			y1:Double = 0.5, r1:Double = 0, x2:Double = 0.5, y2:Double = 0.5, r2:Double = 1, intexp:Double = 1)
		Return bmx_wxpdfdocument_radialgradient(wxObjectPtr, col1.wxObjectPtr, col2.wxObjectPtr, x1, y1, r1, x2, y2, r2, intexp)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RadioButton(group:String, name:String, width:Double)
		bmx_wxpdfdocument_radiobutton(wxObjectPtr, group, name, width)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RadioButtonXY(group:String, name:String, x:Double, y:Double, width:Double)
		bmx_wxpdfdocument_radiobuttonxy(wxObjectPtr, group, name, x, y, width)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Rect(x:Double, y:Double, w:Double, h:Double, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_rect(wxObjectPtr, x, y, w, h, style)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RegularPolygon(x0:Double, y0:Double, r:Double, ns:Int, angle:Double = 0, circle:Int = False, ..
			style:Int = wxPDF_STYLE_DRAW, circleStyle:Int = wxPDF_STYLE_DRAW, ..
			circleLineStyle:wxPdfLineStyle = Null, circleFillColor:wxPdfColour = Null)
		If circleLineStyle Then
			If circleFillColor Then
				bmx_wxpdfdocument_regularpolygon(wxObjectPtr, x0, y0, r, ns, angle, circle, style, circleStyle, circleLineStyle.wxObjectPtr, circleFillColor.wxObjectPtr)
			Else
				bmx_wxpdfdocument_regularpolygon(wxObjectPtr, x0, y0, r, ns, angle, circle, style, circleStyle, circleLineStyle.wxObjectPtr, Null)
			End If
		Else
			If circleFillColor Then
				bmx_wxpdfdocument_regularpolygon(wxObjectPtr, x0, y0, r, ns, angle, circle, style, circleStyle, Null, circleFillColor.wxObjectPtr)
			Else
				bmx_wxpdfdocument_regularpolygon(wxObjectPtr, x0, y0, r, ns, angle, circle, style, circleStyle, Null, Null)
			End If
		End If
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Rotate(angle:Double, x:Double = -1, y:Double = -1)
		bmx_wxpdfdocument_rotate(wxObjectPtr, angle, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RotatedImage(file:String, x:Double, y:Double, w:Double, h:Double, angle:Double, ..
			imgType:String = "", link:wxPdfLink = Null, maskImage:Int = 0)
		If link Then
			bmx_wxpdfdocument_rotatedimage(wxObjectPtr, file, x, y, w, h, angle, imgType, link.wxObjectPtr, maskImage)
		Else
			bmx_wxpdfdocument_rotatedimage(wxObjectPtr, file, x, y, w, h, angle, imgType, Null, maskImage)
		End If
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method RotatedText(x:Double, y:Double, txt:String, angle:Double)
		bmx_wxpdfdocument_rotatedtext(wxObjectPtr, x, y, txt, angle)
	End Method
	
	Rem
	bbdoc: Draws a rounded rectangle.
	about: Parameters :
	<ul>
	<li>@x - Abscissa of upper-left corner</li>
	<li>@y - Ordinate of upper-left corner</li>
	<li>@w - Width</li>
	<li>@h - Height</li>
	<li>@r - Radius of the rounded corners</li>
	<li>@roundCorner - Draws rounded corner or not:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td> wxPDF_CORNER_NONE </td><td>no rounded corners</td></tr>
	<tr><td> wxPDF_CORNER_TOP_LEFT </td><td> top left corner </td></tr>
	<tr><td> wxPDF_CORNER_TOP_RIGHT </td><td> top right corner </td></tr>
	<tr><td> wxPDF_CORNER_BOTTOM_LEFT </td><td> bottom left corner </td></tr>
	<tr><td> wxPDF_CORNER_BOTTOM_RIGHT </td><td> bottom right corner </td></tr>
	<tr><td> wxPDF_CORNER_ALL </td><td> all corners </td></tr>
	</table>
	</li>
	<li>@style - Style of rectangle (draw and/or fill)</li>
	</ul>
	End Rem
	Method RoundedRect(x:Double, y:Double, w:Double, h:Double, r:Double, roundCorner:Int = wxPDF_CORNER_ALL, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_roundedrect(wxObjectPtr, x, y, w, h, r, roundCorner, style)
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
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Scale:Int(sx:Double, sy:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_scale(wxObjectPtr, sx, sy, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ScaleX:Int(sx:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_scalex(wxObjectPtr, sx, x, y)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ScaleY:Int(sy:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_scaley(wxObjectPtr, sy, x, y)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ScaleXY:Int(s:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_scalexy(wxObjectPtr, s, x, y)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Sector(x0:Double, y0:Double, r:Double, astart:Double = 0, afinish:Double = 360, ..
			style:Int = wxPDF_STYLE_DRAW, clockwise:Int = True, origin:Double = 90)
		bmx_wxpdfdocument_sector(wxObjectPtr, x0, y0, r, astart, afinish, style, clockwise, origin)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetAlpha:Int(lineAlpha:Double = 1, fillAlpha:Double = 1, blendMode:Int = wxPDF_BLENDMODE_NORMAL)
		Return bmx_wxpdfdocument_setalpha(wxObjectPtr, lineAlpha, fillAlpha, blendMode)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetAlphaState(state:Int)
		bmx_wxpdfdocument_setalphastate(wxObjectPtr, state)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetAuthor(author:String)
		bmx_wxpdfdocument_setauthor(wxObjectPtr, author)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetAutoPageBreak(autoPageBreak:Int, margin:Double = 0)
		bmx_wxpdfdocument_setautopagebreak(wxObjectPtr, autoPageBreak, margin)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetCellMargin(margin:Double)
		bmx_wxpdfdocument_setcellmargin(wxObjectPtr, margin)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetCompression(compress:Int)
		bmx_wxpdfdocument_setcompression(wxObjectPtr, compress)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetCreator(creator:String)
		bmx_wxpdfdocument_setcreator(wxObjectPtr, creator)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetDisplayMode(zoom:Int, layout:Int = wxPDF_LAYOUT_CONTINUOUS, zoomFactor:Double = 100)
		bmx_wxpdfdocument_setdisplaymode(wxObjectPtr, zoom, layout, zoomFactor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColorGrayScale(grayscale:Int)
		bmx_wxpdfdocument_setdrawcolorgrayscale(wxObjectPtr, grayscale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColor(colour:wxColour)
		bmx_wxpdfdocument_setdrawcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColorPdf(pdfColour:wxPdfColour)
		bmx_wxpdfdocument_setdrawcolorpdf(wxObjectPtr, pdfColour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColorRGB(red:Int, green:Int, blue:Int)
		bmx_wxpdfdocument_setdrawcolorrgb(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_setdrawcolorcmyk(wxObjectPtr, cyan, magenta, yellow, black)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawColorName(name:String, tint:Double = 100)
		bmx_wxpdfdocument_setdrawcolorname(wxObjectPtr, name, tint)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetFillColorGrayScale(grayscale:Int)
		bmx_wxpdfdocument_setfillcolorgrayscale(wxObjectPtr, grayscale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColor(colour:wxColour)
		bmx_wxpdfdocument_setfillcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColorPdf(pdfColour:wxPdfColour)
		bmx_wxpdfdocument_setfillcolorpdf(wxObjectPtr, pdfColour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColorRGB(red:Int, green:Int, blue:Int)
		bmx_wxpdfdocument_setfillcolorrgb(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_setfillcolorcmyk(wxObjectPtr, cyan, magenta, yellow, black)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFillColorName(name:String, tint:Double = 100)
		bmx_wxpdfdocument_setfillcolorname(wxObjectPtr, name, tint)
	End Method
	
	Method SetFillGradient(x:Double, y:Double, w:Double, h:Double, gradient:Int)
		bmx_wxpdfdocument_setfillgradient(wxObjectPtr, x, y, w, h, gradient)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(family:String, style:String = "", size:Double = 0)
		bmx_wxpdfdocument_setfont(wxObjectPtr, family, style, size)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetFontPath(fontPath:String = "")
		bmx_wxpdfdocument_setfontpath(wxObjectPtr, fontPath)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetFontSize(size:Double)
		bmx_wxpdfdocument_setfontsize(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetFontSubsetting(fontSubsetting:Int = True)
		bmx_wxpdfdocument_setfontsubsetting(wxObjectPtr, fontSubsetting)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetFormBorderStyle(borderStyle:Int = wxPDF_BORDER_SOLID, borderWidth:Double = -1)
		bmx_wxpdfdocument_setformborderstyle(wxObjectPtr, borderStyle, borderWidth)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetFormColors(borderColor:wxPdfColour = Null, backgroundColor:wxPdfColour = Null, ..
			textColor:wxPdfColour = Null)
		If borderColor Then
			If backgroundColor Then
				If textColor Then
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, borderColor.wxObjectPtr, backgroundColor.wxObjectPtr, textColor.wxObjectPtr)
				Else
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, borderColor.wxObjectPtr, backgroundColor.wxObjectPtr, Null)
				End If
			Else
				If textColor Then
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, borderColor.wxObjectPtr, Null, textColor.wxObjectPtr)
				Else
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, borderColor.wxObjectPtr, Null, Null)
				End If
			End If
		Else
			If backgroundColor Then
				If textColor Then
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, Null, backgroundColor.wxObjectPtr, textColor.wxObjectPtr)
				Else
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, Null, backgroundColor.wxObjectPtr, Null)
				End If
			Else
				If textColor Then
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, Null, Null, textColor.wxObjectPtr)
				Else
					bmx_wxpdfdocument_setformcolors(wxObjectPtr, Null, Null, Null)
				End If
			End If
		End If
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
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetLineStyle(style:wxPdfLineStyle)
		bmx_wxpdfdocument_setlinestyle(wxObjectPtr, style.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLineWidth(width:Double)
		bmx_wxpdfdocument_setlinewidth(wxObjectPtr, width)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetLink:Int(link:Int, y:Double = 0, page:Int = -1)
		Return bmx_wxpdfdocument_setlink(wxObjectPtr, link, y, page)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMargins(marginLeft:Double, marginTop:Double, marginRight:Double = -1)
		bmx_wxpdfdocument_setmargins(wxObjectPtr, marginLeft, marginTop, marginRight)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetProtection(permissions:Int, userPassword:String = "", ownerPassword:String = "", ..
			encryptionMethod:Int = wxPDF_ENCRYPTION_RC4V1, keyLength:Int = 0)
		bmx_wxpdfdocument_setprotection(wxObjectPtr, permissions, userPassword, ownerPassword, encryptionMethod, keyLength)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRightMargin(margin:Double)
		bmx_wxpdfdocument_setrightmargin(wxObjectPtr, margin)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetSourceFile:Int(filename:String, password:String = "")
		Return bmx_wxpdfdocument_setsourcefile(wxObjectPtr, filename, password)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetSubject(subject:String)
		bmx_wxpdfdocument_setsubject(wxObjectPtr, subject)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTemplateBBox(templateId:Int, x:Double, y:Double, width:Double, height:Double)
		bmx_wxpdfdocument_settemplatebbox(wxObjectPtr, templateId, x, y, width, height)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColorGrayScale(grayscale:Int)
		bmx_wxpdfdocument_settextcolorgrayscale(wxObjectPtr, grayscale)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColor(colour:wxColour)
		bmx_wxpdfdocument_settextcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColorPdf(pdfColour:wxPdfColour)
		bmx_wxpdfdocument_settextcolorpdf(wxObjectPtr, pdfColour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColorRGB(red:Int, green:Int, blue:Int)
		bmx_wxpdfdocument_settextcolorrgb(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColorCMYK(cyan:Double, magenta:Double, yellow:Double, black:Double)
		bmx_wxpdfdocument_settextcolorcmyk(wxObjectPtr, cyan, magenta, yellow, black)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTextColorName(name:String, tint:Double = 100)
		bmx_wxpdfdocument_settextcolorname(wxObjectPtr, name, tint)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTitle(title:String)
		bmx_wxpdfdocument_settitle(wxObjectPtr, title)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetTopMargin(margin:Double)
		bmx_wxpdfdocument_settopmargin(wxObjectPtr, margin)
	End Method
		
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetViewerPreferences(preferences:Int = 0)
		bmx_wxpdfdocument_setviewerpreferences(wxObjectPtr, preferences)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetX(x:Double)
		bmx_wxpdfdocument_setx(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetXY(x:Double, y:Double)
		bmx_wxpdfdocument_setxy(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SetY(y:Double)
		bmx_wxpdfdocument_sety(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Shape(_shape:wxPdfShape, style:Int = wxPDF_STYLE_DRAW)
		bmx_wxpdfdocument_shape(wxObjectPtr, _shape.wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method ShapedText(shape:wxPdfShape, text:String, mode:Int = wxPDF_SHAPEDTEXTMODE_STRETCHTOFIT)
		bmx_wxpdfdocument_shapedtext(wxObjectPtr, shape.wxObjectPtr, text, mode)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Skew:Int(xAngle:Double, yAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skew(wxObjectPtr, xAngle, yAngle, x, y)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SkewX:Int(xAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skewx(wxObjectPtr, xAngle, x, y)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method SkewY:Int(yAngle:Double, x:Double = -1, y:Double = -1)
		Return bmx_wxpdfdocument_skewy(wxObjectPtr, yAngle, x, y)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Text(x:Double, y:Double, txt:String)
		bmx_wxpdfdocument_text(wxObjectPtr, x, y, txt)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method TextBox:Int(w:Double, h:Double, txt:String, halign:Int = wxPDF_ALIGN_JUSTIFY, ..
			valign:Int = wxPDF_ALIGN_TOP, border:Int = 0, fill:Int = 0)
		Return bmx_wxpdfdocument_textbox(wxObjectPtr, w, h, txt, halign, valign, border, fill)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method TextField(name:String, width:Double, height:Double, value:String = "", multiline:Int = False)
		bmx_wxpdfdocument_textfield(wxObjectPtr, name, width, height, value, multiline)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method TextFieldXY(name:String, x:Double, y:Double, width:Double, height:Double, value:String = "", multiline:Int = False)
		bmx_wxpdfdocument_textfieldxy(wxObjectPtr, name, x, y, width, height, value, multiline)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Translate(tx:Double, ty:Double)
		bmx_wxpdfdocument_translate(wxObjectPtr, tx, ty)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method TranslateX(tx:Double)
		bmx_wxpdfdocument_translatex(wxObjectPtr, tx)
	End Method

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method UseTemplate(templateId:Int, x:Double = -1, y:Double = -1, width:Double = 0, height:Double = 0)
		bmx_wxpdfdocument_usetemplate(wxObjectPtr, templateId, x, y, width, height)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
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
bbdoc: Represents internal or external links.
End Rem
Type wxPdfLink

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfLink(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfLink = New wxPdfLink
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreatePdfLink:wxPdfLink(linkRef:Int)
		Return New wxPdfLink.Create(linkRef)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreatePdfLinkURL:wxPdfLink(linkURL:String)
		Return New wxPdfLink.CreateURL(linkURL)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPdfLink(linkRef:Int)
		wxObjectPtr = bmx_wxpdflink_create(linkRef)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateURL:wxPdfLink(linkURL:String)
		wxObjectPtr = bmx_wxpdflink_createurl(linkURL)
		Return Self
	End Method
	
	Method IsValid:Int()
	End Method
	
	Method IsLinkRef:Int()
	End Method
	
	Method GetLinkRef:Int()
	End Method
	
	Method GetLinkURL:String()
	End Method
	
	Method SetLink(page:Int, ypos:Double)
	End Method
	
	Method GetPage:Int()
	End Method
	
	Method GetPosition:Double()
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpdflink_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPdfColour
	
	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxPdfColour(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfColour = New wxPdfColour
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateColour:wxPdfColour(r:Int, g:Int, b:Int)
		Return New wxPdfColour.Create(r, g, b)
	End Function
	
	Rem
	bbdoc: Constructs a colour from red, green, and blue values.
	End Rem
	Method Create:wxPdfColour(r:Int, g:Int, b:Int)
		wxObjectPtr = bmx_wxpdfcolour_create(r, g, b)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateNamedColour:wxPdfColour(name:String)
		wxObjectPtr = bmx_wxpdfcolour_createforname(name)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CreateGrayscaleColour:wxPdfColour(grayscale:Int)
		wxObjectPtr = bmx_wxpdfcolour_creategrayscalecolour(grayscale)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CreateFromColour:wxPdfColour(colour:wxColour)
		wxObjectPtr = bmx_wxpdfcolour_createfromcolour(colour.wxObjectPtr)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CreateCMYKColour:wxPdfColour(cyan:Int, magenta:Int, yellow:Int, black:Int)
		wxObjectPtr = bmx_wxpdfcolour_createcmykcolour(cyan, magenta, yellow, black)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetColorType:Int()
		Return bmx_wxpdfcolour_getcolortype(wxObjectPtr)
	End Method


	Method Delete()
		If wxObjectPtr Then
			bmx_wxpdfcolour_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPdfLineStyle

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfLineStyle(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfLineStyle = New wxPdfLineStyle
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function CreatePdfLineStyle:wxPdfLineStyle(width:Double = -1, cap:Int = wxPDF_LINECAP_NONE, ..
			join:Int = wxPDF_LINEJOIN_NONE, dash:Double[] = Null, phase:Double = -1, ..
			colour:wxPdfColour = Null)
		Return New wxPdfLineStyle.Create(width, cap, join, dash, phase, colour)
	End Function
	
	Method Create:wxPdfLineStyle(width:Double = -1, cap:Int = wxPDF_LINECAP_NONE, ..
			join:Int = wxPDF_LINEJOIN_NONE, dash:Double[] = Null, phase:Double = -1, ..
			colour:wxPdfColour = Null)
		If colour Then
			wxObjectPtr = bmx_wxpdflinestyle_create(width, cap, join, dash, phase, colour.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxpdflinestyle_create(width, cap, join, dash, phase, Null)
		End If
		Return Self
	End Method
	
	Method IsSet:Int()
	End Method
	
	Method SetWidth(width:Double)
	End Method
	
	Method GetWidth:Double()
	End Method
	
	Method SetLineCap(cap:Int)
	End Method
	
	Method GetLineCap:Int()
	End Method
	
	Method SetLineJoin(join:Int)
	End Method
	
	Method GetLineJoin:Int()
	End Method
	
	Method SetDash(dash:Double[])
	End Method
	
	Method GetDash:Double[]()
	End Method
	
	Method SetPhase(phase:Double)
	End Method
	
	Method GetPhase:Double()
	End Method
	
	Method SetColour(colour:wxPdfColour)
	End Method
	
	Method GetColour:wxPdfColour()
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxpdflinestyle_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: 
End Rem
Type wxPdfShape

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfShape = New wxPdfShape
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreatePdfShape:wxPdfShape()
		Return New wxPdfShape.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPdfShape()
		wxObjectPtr = bmx_wxpdfshape_create()
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveTo(x:Double, y:Double)
		bmx_wxpdfshape_moveto(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LineTo(x:Double, y:Double)
		bmx_wxpdfshape_lineto(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CurveTo(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double)
		bmx_wxpdfshape_curveto(wxObjectPtr, x1, y1, x2, y2, x3, y3)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClosePath()
		bmx_wxpdfshape_closepath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSegmentCount:Int()
		Return bmx_wxpdfshape_getsegmentcount(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxpdfshape_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPdfCoonsPatchMesh

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfCoonsPatchMesh(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfCoonsPatchMesh = New wxPdfCoonsPatchMesh
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxPdfFontDescription

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfFontDescription(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfFontDescription = New wxPdfFontDescription
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

End Type

Rem
bbdoc: Represents a PDF document information dictionary.
End Rem
Type wxPdfInfo

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPdfInfo(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPdfInfo = New wxPdfInfo
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates a new wxPdfInfo object.
	End Rem
	Function CreatePdfInfo:wxPdfInfo()
		Return New wxPdfInfo.Create()
	End Function
	
	Rem
	bbdoc: Creates a new wxPdfInfo object.
	End Rem
	Method Create:wxPdfInfo()
		wxObjectPtr = bmx_wxpdfinfo_create()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetTitle:String()
		Return bmx_wxpdfinfo_gettitle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAuthor:String()
		Return bmx_wxpdfinfo_getauthor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSubject:String()
		Return bmx_wxpdfinfo_getsubject(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetKeywords:String()
		Return bmx_wxpdfinfo_getkeywords(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCreator:String()
		Return bmx_wxpdfinfo_getcreator(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetProducer:String()
		Return bmx_wxpdfinfo_getproducer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCreationDate:String()
		Return bmx_wxpdfinfo_getcreationdate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetModDate:String()
		Return bmx_wxpdfinfo_getmoddate(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxpdfinfo_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: A type representing barcode objects.
about: All supported barcodes are drawn directly in PDF without using an image or special font.
End Rem
Type wxPdfBarCodeCreator

	Field wxObjectPtr:Byte Ptr

	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Function CreatePdfBarCodeCreator:wxPdfBarCodeCreator(document:wxPdfDocument)
		Return New wxPdfBarCodeCreator.Create(document)
	End Function
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Create:wxPdfBarCodeCreator(document:wxPdfDocument)
		wxObjectPtr = bmx_wxpdfbarcodecreator_create(document.wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method EAN13:Int(x:Double, y:Double, barcode:String, w:Double = 0.35, h:Double = 16)
		Return bmx_wxpdfbarcodecreator_ean13(wxObjectptr, x, y, barcode, w, h)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method UPC_A:Int(x:Double, y:Double, barcode:String, w:Double = 0.35, h:Double = 16)
		Return bmx_wxpdfbarcodecreator_upc_a(wxObjectptr, x, y, barcode, w, h)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method Code39:Int(x:Double, y:Double, code:String, ext:Int = True, cks:Int = False, w:Double = 0.4, h:Double = 20, wide:Int = True)
		Return bmx_wxpdfbarcodecreator_code39(wxObjectptr, x, y, code, ext, cks, w, h, wide)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method I25:Int(x:Double, y:Double, code:String, basewidth:Double = 1, height:Double = 10)
		Return bmx_wxpdfbarcodecreator_I25(wxObjectptr, x, y, code, basewidth, height)
	End Method
	
	Rem
	bbdoc: 
	about: Parameters :
	<ul>
	<li>xxxxxxxxxxxxxx</li>
	</ul>
	End Rem
	Method PostNet:Int(x:Double, y:Double, zipcode:String)
		Return bmx_wxpdfbarcodecreator_postnet(wxObjectptr, x, y, zipcode)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxpdfbarcodecreator_free(wxObjectptr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

