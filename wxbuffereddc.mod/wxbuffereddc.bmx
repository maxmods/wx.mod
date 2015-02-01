' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxBufferedDC
End Rem
Module wx.wxBufferedDC

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: This type provides a simple way to avoid flicker.
about: When drawing on it, everything is in fact first drawn on an in-memory buffer (a wxBitmap) and then copied
to the screen, using the associated wxDC, only once, when this object is destroyed. wxBufferedDC itself is typically
associated with wxClientDC, if you want to use it in your EVT_PAINT handler, you should look at wxBufferedPaintDC instead.
<p>
When used like this, a valid dc must be specified in the constructor while the buffer bitmap doesn't have to be
explicitly provided, by default this class will allocate the bitmap of required size itself. However using a dedicated
bitmap can speed up the redrawing process by eliminating the repeated creation and destruction of a possibly big bitmap.
Otherwise, wxBufferedDC can be used in the same way as any other device context. 
</p>
<p>
There is another possible use for wxBufferedDC is to use it to maintain a backing store for the window contents. In this
case, the associated dc may be NULL but a valid backing store bitmap should be specified.
</p>
<p>
Finally, please note that GTK+ 2.0 as well as OS X provide double buffering themselves natively. You can either use
wxWindow::IsDoubleBuffered to determine whether you need to use buffering or not, or use wxAutoBufferedPaintDC
to avoid needless double buffering on the systems which already do it automatically.
</p>
End Rem
Type wxBufferedDC Extends wxMemoryDC

	Rem
	bbdoc: 
	End Rem
	Function CreateBufferedDC:wxBufferedDC()
		Return New wxBufferedDC.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxBufferedDC()
		wxObjectPtr = bmx_wxbuffereddc_create()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateBufferedDCWithArea:wxBufferedDC(dc:wxDC = Null, w:Int = -1, h:Int = -1, style:Int = wxBUFFER_CLIENT_AREA)
		Return New wxBufferedDC.CreateWithArea(dc, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateWithArea:wxBufferedDC(dc:wxDC = Null, w:Int = -1, h:Int = -1, style:Int = wxBUFFER_CLIENT_AREA)
		If dc Then
			wxObjectPtr = bmx_wxbuffereddc_createwitharea(dc.wxObjectPtr, w, h, style)
		Else
			wxObjectPtr = bmx_wxbuffereddc_createwitharea(Null, w, h, style)
		End If
		
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function CreateBufferedDCWithBitmap:wxBufferedDC(dc:wxDC = Null, buffer:wxBitmap = Null, style:Int = wxBUFFER_CLIENT_AREA)
		Return New wxBufferedDC.CreateWithBitmap(dc, buffer, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateWithBitmap:wxBufferedDC(dc:wxDC = Null, buffer:wxBitmap = Null, style:Int = wxBUFFER_CLIENT_AREA)
		If dc Then
			If buffer Then
				wxObjectPtr = bmx_wxbuffereddc_createwithbitmap(dc.wxObjectPtr, buffer.wxObjectPtr, style)
			Else
				wxObjectPtr = bmx_wxbuffereddc_createwithbitmap(dc.wxObjectPtr, Null, style)
			End If
		Else
			If buffer Then
				wxObjectPtr = bmx_wxbuffereddc_createwithbitmap(Null, buffer.wxObjectPtr, style)
			Else
				wxObjectPtr = bmx_wxbuffereddc_createwithbitmap(Null, Null, style)
			End If
		End If
		
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InitWithArea(dc:wxDC, w:Int, h:Int, style:Int = wxBUFFER_CLIENT_AREA)
		bmx_wxbuffereddc_initwitharea(wxObjectPtr, dc.wxObjectPtr, w, h, style)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method InitWithBitmap(dc:wxDC, buffer:wxBitmap, style:Int = wxBUFFER_CLIENT_AREA)
		bmx_wxbuffereddc_initwithbitmap(wxObjectPtr, dc.wxObjectPtr, buffer.wxObjectPtr, style)
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxbuffereddc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

