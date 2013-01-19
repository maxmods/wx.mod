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
bbdoc: wxMemoryDC
End Rem
Module wx.wxMemoryDC

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
bbdoc: A memory device context provides a means to draw graphics onto a bitmap.
about: When drawing in to a mono-bitmap, using wxWHITE, wxWHITE_PEN and wxWHITE_BRUSH will draw the
background colour (i.e. 0) whereas all other colours will draw the foreground colour (i.e. 1).
End Rem
Type wxMemoryDC Extends wxDC

	Rem
	bbdoc: Constructs a new memory device context.
	about: Use the IsOk() method to test whether the constructor was successful in creating a usable device
	context. Don't forget to select a bitmap into the DC before drawing on it.
	End Rem
	Method Create:wxMemoryDC()
		wxObjectPtr = bmx_wxmemorydc_create()
		Return Self
	End Method

	Rem
	bbdoc: Works exactly like SelectObjectAsSource but this is the method you should use when you select a bitmap because you want to modify it, e.g. drawing on this DC.
	about: Be careful to use this method and not SelectObjectAsSource when you want to modify the bitmap you
	are selecting otherwise you may incur in some problems related to wxBitmap being a reference counted object.
	End Rem
	Method SelectObject(bitmap:wxBitmap)
		bmx_wxmemorydc_selectobject(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Rem
	bbdoc: Selects the given bitmap into the device context, to use as the memory bitmap.
	about: Selecting the bitmap into a memory DC allows you to draw into the DC (and therefore the bitmap)
	and also to use wxDC::Blit to copy the bitmap to a window. For this purpose, you may find wxDC::DrawIcon
	easier to use instead.
	<p>
	If the argument is wxNullBitmap (or some other uninitialised wxBitmap) the current bitmap is selected out of
	the device context, and the original bitmap restored, allowing the current bitmap to be destroyed safely.
	</p>
	End Rem
	Method SelectObjectAsSource(bitmap:wxBitmap)
		bmx_wxmemorydc_selectobjectassource(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxmemorydc_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type
