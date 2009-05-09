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
bbdoc: wxPreviewFrame
End Rem
Module wx.wxPreviewFrame

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
bbdoc: This type provides the default method of managing the print preview interface.
about: Member methods may be overridden to replace functionality, or the type may be used
without derivation.
End Rem
Type wxPreviewFrame Extends wxFrame

	Rem
	bbdoc: Constructor.
	about: Pass a print preview object plus other normal frame arguments. The print preview
	object will be destroyed by the frame when it closes.
	End Rem
	Function CreatePreviewFrame:wxPreviewFrame(preview:wxPrintPreview, parent:wxWindow, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
		Return New wxPreviewFrame.CreatePF(preview, parent, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass a print preview object plus other normal frame arguments. The print preview
	object will be destroyed by the frame when it closes.
	End Rem
	Method CreatePF:wxPreviewFrame(preview:wxPrintPreview, parent:wxWindow, title:String, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
		wxObjectPtr = bmx_wxpreviewframe_create(Self, preview.wxObjectPtr, parent.wxObjectPtr, title, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Creates a wxPreviewControlBar.
	about: Override this method to allow a user-defined preview control bar object to be created.
	End Rem
	Method CreateControlBar()
		bmx_wxpreviewframe_createcontrolbar(wxObjectPtr)
	End Method
	
	Function _CreateControlBar(frame:wxPreviewFrame)
		frame.CreateControlBar()
	End Function
	
	Rem
	bbdoc: Creates a wxPreviewCanvas.
	about: Override this method to allow a user-defined preview canvas object to be created.
	End Rem
	Method CreateCanvas()
		bmx_wxpreviewframe_createcanvas(wxObjectPtr)
	End Method
	
	Function _CreateCanvas(frame:wxPreviewFrame)
		frame.CreateCanvas()
	End Function

	Rem
	bbdoc: Creates the preview canvas and control bar, and calls wxWindow::MakeModal(True) to disable other top-level windows in the application.
	about: This method should be called by the application prior to showing the frame.
	End Rem
	Method Initialize()
		bmx_wxpreviewframe_initialize(wxObjectPtr)
	End Method

End Type

