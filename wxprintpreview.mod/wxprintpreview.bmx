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
bbdoc: wxPrintPreview
End Rem
Module wx.wxPrintPreview

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
bbdoc: Objects of this type manage the print preview process.
about: The object is passed a wxPrintout object, and the wxPrintPreview object itself is passed
to a wxPreviewFrame object. Previewing is started by initializing and showing the preview frame.
Unlike wxPrinter::Print, flow of control returns to the application immediately after the frame
is shown.
End Rem
Type wxPrintPreview Extends wxObject

	Rem
	bbdoc: Constructor.
	about: Pass a printout object, an optional printout object to be used for actual printing,
	and optional printer data, which will be copied to the print preview object's print data.
	<p>
	If printoutForPrinting is non-NULL, a Print... button will be placed on the preview frame
	so that the user can print directly from the preview interface.
	</p>
	<p>
	Do not explicitly delete the printout objects once this destructor has been called, since
	they will be deleted in the wxPrintPreview constructor. The same does not apply to the data
	argument.
	</p>
	<p>
	Test IsOk() to check whether the wxPrintPreview object was created correctly. Ok could
	return false if there was a problem initializing the printer device context (current printer
	not set, for example).
	</p>
	End Rem
	Function CreatePrintPreview:wxPrintPreview(printout:wxPrintout, printoutForPrinting:wxPrintout = Null, data:wxPrintData = Null)
		Return New wxPrintPreview.Create(printout, printoutForPrinting, data)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass a printout object, an optional printout object to be used for actual printing,
	and optional printer data, which will be copied to the print preview object's print data.
	<p>
	If printoutForPrinting is non-NULL, a Print... button will be placed on the preview frame
	so that the user can print directly from the preview interface.
	</p>
	<p>
	Do not explicitly delete the printout objects once this destructor has been called, since
	they will be deleted in the wxPrintPreview constructor. The same does not apply to the data
	argument.
	</p>
	<p>
	Test IsOk() to check whether the wxPrintPreview object was created correctly. Ok could
	return false if there was a problem initializing the printer device context (current printer
	not set, for example).
	</p>
	End Rem
	Method Create:wxPrintPreview(printout:wxPrintout, printoutForPrinting:wxPrintout = Null, data:wxPrintData = Null)
		If data Then
			If printoutForPrinting Then
				wxObjectPtr = bmx_wxprintpreview_create(Self, printout.wxObjectPtr, printoutForPrinting.wxObjectPtr, data.wxObjectPtr)
			Else
				wxObjectPtr = bmx_wxprintpreview_create(Self, printout.wxObjectPtr, Null, data.wxObjectPtr)
			End If
		Else
			If printoutForPrinting Then
				wxObjectPtr = bmx_wxprintpreview_create(Self, printout.wxObjectPtr, printoutForPrinting.wxObjectPtr, Null)
			Else
				wxObjectPtr = bmx_wxprintpreview_create(Self, printout.wxObjectPtr, Null, Null)
			End If
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Gets the preview window used for displaying the print preview image.
	End Rem
	Method GetCanvas:wxPreviewCanvas()
		Return wxPreviewCanvas._create(bmx_wxprintpreview_getcanvas(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the page currently being previewed.
	End Rem
	Method GetCurrentPage:Int()
		Return bmx_wxprintpreview_getcurrentpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the frame used for displaying the print preview canvas and control bar.
	End Rem
	Method GetFrame:wxFrame()
		Return wxFrame._find(bmx_wxprintpreview_getframe(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the maximum page number.
	End Rem
	Method GetMaxPage:Int()
		Return bmx_wxprintpreview_getmaxpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the minimum page number.
	End Rem
	Method GetMinPage:Int()
		Return bmx_wxprintpreview_getminpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the preview printout object associated with the wxPrintPreview object.
	End Rem
	Method GetPrintout:wxPrintout()
		Return wxPrintout._find(bmx_wxprintpreview_getprintout(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the printout object to be used for printing from within the preview interface, or NULL if none exists.
	End Rem
	Method GetPrintoutForPrinting:wxPrintout()
		Return wxPrintout._find(bmx_wxprintpreview_getprintoutforprinting(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns True if the wxPrintPreview is valid, false otherwise.
	about: It could return False if there was a problem initializing the printer device context
	(current printer not set, for example).
	End Rem
	Method IsOk:Int()
		Return bmx_wxprintpreview_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This refreshes the preview window with the preview image.
	about: It must be called from the preview window's OnPaint member.
	<p>
	The implementation simply blits the preview bitmap onto the canvas, creating a new preview
	bitmap if none exists.
	</p>
	End Rem
	Method PaintPage:Int(canvas:wxPreviewCanvas, dc:wxDC)
		Return bmx_wxprintpreview_paintpage_default(wxObjectPtr, canvas.wxObjectPtr, dc.wxObjectPtr)
	End Method
	
	Function _PaintPage:Int(preview:wxPrintPreview, canvas:Byte Ptr, dc:Byte Ptr)
		preview.PaintPage(wxPreviewCanvas._create(canvas), wxDC._create(dc))
	End Function
	
	Rem
	bbdoc: Invokes the print process using the second wxPrintout object supplied in the wxPrintPreview constructor.
	returns: False in case of error -- call wxPrinter::GetLastError to get detailed information about the kind of the error.
	about: Will normally be called by the Print... panel item on the preview frame's control
	bar.
	End Rem
	Method Print:Int(prompt:Int)
		Return bmx_wxprintpreview_print(wxObjectPtr, prompt)
	End Method
	
	Rem
	bbdoc: Renders a page into a wxMemoryDC. Used internally by wxPrintPreview.
	End Rem
	Method RenderPage:Int(pageNum:Int)
		' nothing to see here, move along, move along ! ! !
	End Method
	
	Rem
	bbdoc: Sets the window to be used for displaying the print preview image.
	End Rem
	Method SetCanvas(canvas:wxPreviewCanvas)
		bmx_wxprintpreview_setCanvas(wxObjectPtr, canvas.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the current page to be previewed.
	End Rem
	Method SetCurrentPage(pageNum:Int)
		bmx_wxprintpreview_setcurrentpage(wxObjectPtr, pageNum)
	End Method
	
	Rem
	bbdoc: Sets the frame to be used for displaying the print preview canvas and control bar.
	End Rem
	Method SetFrame(frame:wxFrame)
		bmx_wxprintpreview_setframe(wxObjectPtr, frame.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Associates a printout object with the wxPrintPreview object.
	End Rem
	Method SetPrintout(printout:wxPrintout)
		bmx_wxprintpreview_setprintout(wxObjectPtr, printout.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the percentage preview zoom, and refreshes the preview canvas accordingly.
	End Rem
	Method SetZoom(percent:Int)
		bmx_wxprintpreview_setzoom(wxObjectPtr, percent)
	End Method

	Rem
	bbdoc: Frees/Deletes the preview.
	about: Usually, this will be handled when you close the frame, but depending on other factors
	you may wish to do it yourself.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxprintpreview_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method


End Type

Rem
bbdoc: A preview canvas is the default canvas used by the print preview system to display the preview.
End Rem
Type wxPreviewCanvas Extends wxScrolledWindow

	Function _create:wxPreviewCanvas(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPreviewCanvas = New wxPreviewCanvas
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

End Type

