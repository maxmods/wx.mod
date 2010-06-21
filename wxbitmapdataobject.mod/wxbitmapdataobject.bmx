' Copyright (c) 2007-2010 Bruce A Henderson
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
bbdoc: wxBitmapDataObject
End Rem
Module wx.wxBitmapDataObject

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2010 Bruce A Henderson"


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
bbdoc: A specialization of wxDataObject for bitmap data.
about: It can be used without change to paste data into the wxClipboard or a wxDropSource. A
user may wish to derive a new class from this class for providing a bitmap on-demand in order to minimize
memory consumption when offering data in several formats, such as a bitmap and GIF.
End Rem
Type wxBitmapDataObject Extends wxDataObjectSimple

	Rem
	bbdoc: 
	End Rem
	Function CreateBitmapDataObject:wxBitmapDataObject(bitmap:wxBitmap = Null)
		Return New wxBitmapDataObject.Create(bitmap)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxBitmapDataObject(bitmap:wxBitmap = Null)
		If bitmap Then
			wxObjectPtr = bmx_wxbitmapdataobject_create(bitmap.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxbitmapdataobject_create(Null)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the bitmap associated with the data object.
	End Rem
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxbitmapdataobject_getbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the bitmap associated with the data object.
	End Rem
	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxbitmapdataobject_setbitmap(wxObjectPtr, Bitmap.wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr And owner Then
			bmx_wxbitmapdataobject_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type


