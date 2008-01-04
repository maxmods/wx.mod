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
bbdoc: wxAutoBufferedPaintDC
End Rem
Module wx.wxAutoBufferedPaintDC

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
bbdoc: This wxDC derivative can be used inside of an OnPaint() event handler to achieve double-buffered drawing.
about: Just create an object of this class instead of wxPaintDC and make sure wxWindow::SetBackgroundStyle is called
with wxBG_STYLE_CUSTOM somewhere in the class initialization code, and that's all you have to do to (mostly)
avoid flicker.
<p>
The difference between wxBufferedPaintDC and this class, is the lightweigthness - on platforms which have native
double-buffering, wxAutoBufferedPaintDC is simply a typedef of wxPaintDC. Otherwise, it is a typedef of
wxBufferedPaintDC.
</p>
End Rem
Type wxAutoBufferedPaintDC Extends wxBufferedPaintDC

	Function CreateAutoBufferedPaintDC:wxAutoBufferedPaintDC(window:wxWindow)
		Return New wxAutoBufferedPaintDC.CreatePaintDC(window)
	End Function
	
	Method CreatePaintDC:wxAutoBufferedPaintDC(window:wxWindow)
		wxObjectPtr = bmx_wxautobufferedpaintdc_create(window.wxObjectPtr)
		Return Self
	End Method

	Method Free()
		If wxObjectPtr Then
			bmx_wxautobufferedpaintdc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

