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
bbdoc: wxPrintout
End Rem
Module wx.wxPrintout

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
bbdoc: This type encapsulates the functionality of printing out an application document.
about: A new type must be derived and methods overridden to respond to calls such as OnPrintPage and HasPage
and to render the print image onto an associated wxDC. Instances of this type are passed to wxPrinter::Print
or to a wxPrintPreview object to initiate printing or previewing.
<p>
Your derived wxPrintout is responsible for drawing both the preview image and the printed page. If your
windows' drawing routines accept an arbitrary DC as an argument, you can re-use those routines within your
wxPrintout sub-type to draw the printout image. You may also add additional drawing elements within your
wxPrintout sub-type, like headers, footers, and/or page numbers. However, the image on the printed page will
often differ from the image drawn on the screen, as will the print preview image -- not just in the presence
of headers and footers, but typically in scale. A high-resolution printer presents a much larger drawing
surface (i.e., a higher-resolution DC); a zoomed-out preview image presents a much smaller drawing surface
(lower-resolution DC). By using the routines FitThisSizeToXXX() and/or MapScreenSizeToXXX() within your
wxPrintout sub-type to set the user scale and origin of the associated DC, you can easily use a single
drawing routine to draw on your application's windows, to create the print preview image, and to create
the printed paper image, and achieve a common appearance to the preview image and the printed page.
</p>
End Rem
Type wxPrintout Extends wxObject

	Rem
	bbdoc: Constructor.
	about: Pass an optional title argument - the current filename would be a good idea. This
	will appear in the printing list (at least in MSW)
	End Rem
	Function CreatePrintout:wxPrintout(title:String = "Printout")
		Return New wxPrintout.Create(title)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass an optional title argument - the current filename would be a good idea. This
	will appear in the printing list (at least in MSW)
	End Rem
	Method Create:wxPrintout(title:String = "Printout")
		wxObjectPtr = bmx_wxprintout_create(Self, title)
		Return Self
	End Method

	' soft linking
	Function _create:wxPrintout(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPrintout = New wxPrintout
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxPrintout(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local printout:wxPrintout = wxPrintout(wxfind(wxObjectPtr))
			If Not printout Then
				Return wxPrintout._create(wxObjectPtr)
			End If
			Return printout
		End If
	End Function

	Rem
	bbdoc: Returns the device context associated with the printout (given to the printout at start of printing or previewing).
	about: This will be a wxPrinterDC if printing under Windows or Mac, a wxPostScriptDC if printing on
	other platforms, and a wxMemoryDC if previewing.
	End Rem
	Method GetDC:wxDC()
		Return wxDC._create(bmx_wxprintout_getdc(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Called by the framework to obtain information from the application about minimum and maximum page values that the user can select, and the required page range to be printed. 
	about: By default this returns 1, 32000 for the page minimum and maximum values, and 1, 1 for the
	required page range.
	<p>
	If minPage is zero, the page number controls in the print dialog will be disabled.
	</p>
	End Rem
	Method GetPageInfo(minPage:Int Var, maxPage:Int Var, pageFrom:Int Var, pageTo:Int Var)
		minPage = 1
		maxPage = 32000
		pageFrom = 1
		pageTo = 1
	End Method

	Function _GetPageInfo(obj:wxPrintout, minPage:Int Var, maxPage:Int Var, pageFrom:Int Var, pageTo:Int Var)
		obj.GetPageInfo(minPage, maxPage, pageFrom, pageTo)
	End Function

	Rem
	bbdoc: Returns the size of the printer page in millimetres.
	End Rem
	Method GetPageSizeMM(w:Int Var, h:Int Var)
		bmx_wxprintout_getpagesizemm(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the size of the printer page in pixels, called the page rectangle.
	about: The page rectangle has a top left corner at (0,0) and a bottom right corner at (w,h).
	These values may not be the same as the values returned from wxDC::GetSize; if the printout is being
	used for previewing, a memory device context is used, which uses a bitmap size reflecting the current
	preview zoom. The application must take this discrepancy into account if previewing is to be supported.
	End Rem
	Method GetPageSizePixels(w:Int Var, h:Int Var)
		bmx_wxprintout_getpagesizepixels(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the rectangle that corresponds to the entire paper in pixels, called the paper rectangle.
	about: This distinction between paper rectangle and page rectangle reflects the fact that most
	printers cannot print all the way to the edge of the paper. The page rectangle is a rectangle whose
	top left corner is at (0,0) and whose width and height are given by wxDC::GetPageSizePixels.
	On MSW and Mac, the page rectangle gives the printable area of the paper, while the paper rectangle
	represents the entire paper, including non-printable borders. Thus, the rectangle returned by
	GetPaperRectPixels will have a top left corner whose coordinates are small negative numbers and the
	bottom right corner will have values somewhat larger than the width and height given by
	wxDC::GetPageSizePixels. On other platforms and for PostScript printing, the paper is treated as if
	its entire area were printable, so this function will return the same rectangle as the page rectangle.
	End Rem
	Method GetPaperRectPixels(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxprintout_getpaperrectpixels(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the rectangle that corresponds to the entire paper in pixels, called the paper rectangle.
	about: This distinction between paper rectangle and page rectangle reflects the fact that most
	printers cannot print all the way to the edge of the paper. The page rectangle is a rectangle whose
	top left corner is at (0,0) and whose width and height are given by wxDC::GetPageSizePixels.
	On MSW and Mac, the page rectangle gives the printable area of the paper, while the paper rectangle
	represents the entire paper, including non-printable borders. Thus, the rectangle returned by
	GetPaperRectPixels will have a top left corner whose coordinates are small negative numbers and the
	bottom right corner will have values somewhat larger than the width and height given by
	wxDC::GetPageSizePixels. On other platforms and for PostScript printing, the paper is treated as if
	its entire area were printable, so this function will return the same rectangle as the page rectangle.
	End Rem
	Method GetPaperRectPixelsRect:wxRect()
		Return wxRect._create(bmx_wxprintout_getpaperrectpixelsrect(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the number of pixels per logical inch of the printer device context.
	about: Dividing the printer PPI by the screen PPI can give a suitable scaling factor for drawing text
	onto the printer. Remember to multiply this by a scaling factor to take the preview DC size into
	account. Or you can just use the FitThisSizeToXXX() and MapScreenSizeToXXX routines below, which do
	most of the scaling calculations for you.
	End Rem
	Method GetPPIPrinter(w:Int Var, h:Int Var)
		bmx_wxprintout_getppiprinter(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the number of pixels per logical inch of the screen device context.
	about: Dividing the printer PPI by the screen PPI can give a suitable scaling factor for drawing text
	onto the printer. If you are doing your own scaling, remember to multiply this by a scaling factor to
	take the preview DC size into account.
	End Rem
	Method GetPPIScreen(w:Int Var, h:Int Var)
		bmx_wxprintout_getppiscreen(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the title of the printout
	End Rem
	Method GetTitle:String()
		Return bmx_wxprintout_gettitle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Should be overridden to return true if the document has this page, or false if not.
	about: Returning false signifies the end of the document. By default, HasPage behaves as if the
	document has only one page.
	End Rem
	Method HasPage:Int(pageNum:Int)
		If pageNum = 1 Then
			Return True
		End If
		Return False
	End Method
	
	Function _HasPage:Int(obj:wxPrintout, pageNum:Int)
		Return obj.HasPage(pageNum)
	End Function
	
	Rem
	bbdoc: Returns true if the printout is currently being used for previewing.
	End Rem
	Method IsPreview:Int()
		Return bmx_wxprintout_ispreview(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the user scale and device origin of the wxDC associated with this wxPrintout so that the given image size fits entirely within the paper and the origin is at the top left corner of the paper.
	about: Note that with most printers, the region around the edges of the paper are not printable so
	that the edges of the image could be cut off. Use this if you're managing your own page margins.
	End Rem
	Method FitThisSizeToPaper(w:Int, h:Int)
		bmx_wxprintout_fitthissizetopaper(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Set the user scale and device origin of the wxDC associated with this wxPrintout so that the given image size fits entirely within the page rectangle and the origin is at the top left corner of the page rectangle.
	about: On MSW and Mac, the page rectangle is the printable area of the page. On other platforms and
	PostScript printing, the page rectangle is the entire paper. Use this if you want your printed image
	as large as possible, but with the caveat that on some platforms, portions of the image might be cut
	off at the edges.
	End Rem
	Method FitThisSizeToPage(w:Int, h:Int)
		bmx_wxprintout_fitthissizetopage(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Set the user scale and device origin of the wxDC associated with this wxPrintout so that the given image size fits entirely within the page margins set in the given wxPageSetupDialogData object.
	about: This method provides the greatest consistency across all platforms because it does not depend on
	having access to the printable area of the paper. Note that on Mac, the native wxPageSetupDialog does
	not let you set the page margins; you'll have to provide your own mechanism, or you can use the Mac-only
	type wxMacPageMarginsDialog.
	End Rem
	Method FitThisSizeToPageMargins(w:Int, h:Int, pageSetupData:wxPageSetupDialogData)
		bmx_wxprintout_fitthissizetopagemargins(wxObjectPtr, w, h, pageSetupData.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the user scale and device origin of the wxDC associated with this wxPrintout so that the printed page matches the screen size as closely as possible and the logical origin is in the top left corner of the paper rectangle.
	about: That is, a 100-pixel object on screen should appear at the same size on the printed page.
	(It will, of course, be larger or smaller in the preview image, depending on the zoom factor.) Use this
	if you want WYSIWYG behavior, e.g., in a text editor.
	End Rem
	Method MapScreenSizeToPaper()
		bmx_wxprintout_mapscreensizetopaper(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This sets the user scale of the wxDC assocated with this wxPrintout to the same scale as MapScreenSizeToPaper but sets the logical origin to the top left corner of the page rectangle.
	End Rem
	Method MapScreenSizeToPage()
		bmx_wxprintout_mapscreensizetopage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This sets the user scale of the wxDC assocated with this wxPrintout to the same scale as MapScreenSizeToPageMargins but sets the logical origin to the top left corner of the page margins specified by the given wxPageSetupDialogData object.
	End Rem
	Method MapScreenSizeToPageMargins(pageSetupData:wxPageSetupDialogData)
		bmx_wxprintout_mapscreensizetopagemargins(wxObjectPtr, pageSetupData.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the user scale and device origin of the wxDC associated with this wxPrintout so that one screen pixel maps to one device pixel on the DC.
	about: That is, the user scale is set to (1,1) and the device origin is set to (0,0). Use this if you
	want to do your own scaling prior to calling wxDC drawing calls, for example, if your underlying model
	is floating-point and you want to achieve maximum drawing precision on high-resolution printers. (Note
	that while the underlying drawing model of Mac OS X is floating-point, wxWidgets's drawing model scales
	from integer coordinates.) You can use the GetLogicalXXXRect() routines below to obtain the paper rectangle,
	page rectangle, or page margins rectangle to perform your own scaling.
	End Rem
	Method MapScreenSizeToDevice()
		bmx_wxprintout_mapscreensizetodevice(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the rectangle corresponding to the paper in the associated wxDC's logical coordinates for the current user scale and device origin.
	End Rem
	Method GetLogicalPaperRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxprintout_getlogicalpaperrect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Return the rectangle corresponding to the paper in the associated wxDC's logical coordinates for the current user scale and device origin.
	End Rem
	Method GetLogicalPaperRectRect:wxRect()
		Return wxRect._create(bmx_wxprintout_getlogicalpaperrectrect(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Return the rectangle corresponding to the page in the associated wxDC's logical coordinates for the current user scale and device origin.
	about: On MSW and Mac, this will be the printable area of the paper. On other platforms and PostScript
	printing, this will be the full paper rectangle.
	End Rem
	Method GetLogicalPageRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxprintout_getlogicalpagerect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Return the rectangle corresponding to the page in the associated wxDC's logical coordinates for the current user scale and device origin.
	about: On MSW and Mac, this will be the printable area of the paper. On other platforms and PostScript
	printing, this will be the full paper rectangle.
	End Rem
	Method GetLogicalPageRectRect:wxRect()
		Return wxRect._create(bmx_wxprintout_getlogicalpagerectrect(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Return the rectangle corresponding to the page margins specified by the given wxPageSetupDialogData object in the associated wxDC's logical coordinates for the current user scale and device origin.
	about: The page margins are specified with respect to the edges of the paper on all platforms.
	End Rem
	Method GetLogicalPageMarginsRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var, pageSetupData:wxPageSetupDialogData)
		bmx_wxprintout_getlogicalpagemarginsrect(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h, pageSetupData.wxObjectPtr)
	End Method

	Rem
	bbdoc: Return the rectangle corresponding to the page margins specified by the given wxPageSetupDialogData object in the associated wxDC's logical coordinates for the current user scale and device origin.
	about: The page margins are specified with respect to the edges of the paper on all platforms.
	End Rem
	Method GetLogicalPageMarginsRectRect:wxRect(pageSetupData:wxPageSetupDialogData)
		Return wxRect._create(bmx_wxprintout_getlogicalpagemarginsrectrect(wxObjectPtr, pageSetupData.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set the device origin of the associated wxDC so that the current logical point becomes the new logical origin.
	End Rem
	Method SetLogicalOrigin(x:Int, y:Int)
		bmx_wxprintout_setlogicalorigin(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Shift the device origin by an amount specified in logical coordinates.
	End Rem
	Method OffsetLogicalOrigin(xOff:Int, yOff:Int)
		bmx_wxprintout_offsetlogicalorigin(wxObjectPtr, xOff, yOff)
	End Method
	
	Rem
	bbdoc: Called by the framework at the start of document printing.
	about: Return false from this function cancels the print job. OnBeginDocument is called once for
	every copy printed.
	End Rem
	Method OnBeginDocument:Int(startPage:Int, endPage:Int)
	End Method

	Function _OnBeginDocument:Int(obj:wxPrintout, startPage:Int, endPage:Int)
		Return obj.OnBeginDocument(startPage, endPage)
	End Function
	
	Rem
	bbdoc: Called by the framework at the end of document printing.
	about: OnEndDocument is called once for every copy printed.
	End Rem
	Method OnEndDocument()
	End Method
	
	Function _OnEndDocument(obj:wxPrintout)
		obj.OnEndDocument()
	End Function
	
	Rem
	bbdoc: Called by the framework at the start of printing.
	about: OnBeginPrinting is called once for every print job (regardless of how many copies are being
	printed).
	End Rem
	Method OnBeginPrinting()
	End Method

	Function _OnBeginPrinting(obj:wxPrintout)
		obj.OnBeginPrinting()
	End Function

	Rem
	bbdoc: Called by the framework at the end of printing.
	about: OnEndPrinting is called once for every print job (regardless of how many copies are being printed).
	End Rem
	Method OnEndPrinting()
	End Method

	Function _OnEndPrinting(obj:wxPrintout)
		obj.OnEndPrinting()
	End Function

	Rem
	bbdoc: Called once by the framework before any other demands are made of the wxPrintout object.
	about: This gives the object an opportunity to calculate the number of pages in the document, for
	example.
	End Rem
	Method OnPreparePrinting()
	End Method

	Function _OnPreparePrinting(obj:wxPrintout)
		obj.OnPreparePrinting()
	End Function

	Rem
	bbdoc: Called by the framework when a page should be printed.
	about: Returning false cancels the print job. The application can use wxPrintout::GetDC to obtain a
	device context to draw on.
	End Rem
	Method OnPrintPage:Int(pageNum:Int)
	End Method

	Function _OnPrintPage:Int(obj:wxPrintout, pageNum:Int)
		Return obj.OnPrintPage(pageNum)
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_printout_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

