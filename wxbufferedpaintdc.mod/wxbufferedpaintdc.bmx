' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxBufferedPaintDC
End Rem
Module wx.wxBufferedPaintDC

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This is a subclass of wxBufferedDC which can be used inside of an OnPaint() event handler.
about: Just create an object of this class instead of wxPaintDC and make sure wxWindow::SetBackgroundStyle is called
with wxBG_STYLE_CUSTOM somewhere in the class initialization code, and that's all you have to do to (mostly) avoid flicker.
The only thing to watch out for is that if you are using this type together with wxScrolledWindow, you probably do not
want to call PrepareDC on it as it already does this internally for the real underlying wxPaintDC.
End Rem
Type wxBufferedPaintDC Extends wxBufferedDC

	Rem
	bbdoc: 
	about: As with wxBufferedDC, you may either provide the bitmap to be used for buffering or let this object create
	one internally (in the latter case, the size of the client part of the window is used).
	<p>
	Pass wxBUFFER_CLIENT_AREA for the style parameter to indicate that just the client area of the window is buffered,
	or wxBUFFER_VIRTUAL_AREA to indicate that the buffer bitmap covers the virtual area (in which case PrepareDC is
	automatically called for the actual window device context).
	</p>
	End Rem
	Function CreateBufferedPaintDCForWindow:wxBufferedPaintDC(window:wxWindow, buffer:wxBitmap = Null, style:Int = wxBUFFER_CLIENT_AREA)
		Return New wxBufferedPaintDC.CreateForWindow(window, buffer, style)
	End Function
	
	Rem
	bbdoc: 
	about: As with wxBufferedDC, you may either provide the bitmap to be used for buffering or let this object create
	one internally (in the latter case, the size of the client part of the window is used).
	<p>
	Pass wxBUFFER_CLIENT_AREA for the style parameter to indicate that just the client area of the window is buffered,
	or wxBUFFER_VIRTUAL_AREA to indicate that the buffer bitmap covers the virtual area (in which case PrepareDC is
	automatically called for the actual window device context).
	</p>
	End Rem
	Method CreateForWindow:wxBufferedPaintDC(window:wxWindow, buffer:wxBitmap = Null, style:Int = wxBUFFER_CLIENT_AREA)
		If buffer Then
			wxObjectPtr = bmx_wxbufferedpaintdc_createforwindow(window.wxObjectPtr, buffer.wxObjectPtr, style)
		Else
			wxObjectPtr = bmx_wxbufferedpaintdc_createforwindow(window.wxObjectPtr, Null, style)
		End If
		
		Return Self
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxbufferedpaintdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type


