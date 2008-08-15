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
bbdoc: wxStaticBitmap
End Rem
Module wx.wxStaticBitmap

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
bbdoc: A static bitmap control displays a bitmap.
about: It is meant for display of the small icons in the dialog boxes and is not meant to be a general
purpose image display control.
End Rem
Type wxStaticBitmap Extends wxControl

	Function _create:wxStaticBitmap(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxStaticBitmap = New wxStaticBitmap
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxStaticBitmap(wxObjectPtr:Byte Ptr)
		Return wxStaticBitmap._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a static bitmap control.
	End Rem
	Function CreateStaticBitmap:wxStaticBitmap(parent:wxWindow, id:Int, bitmap:wxBitmap, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxStaticBitmap.Create(parent, id, bitmap, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction.
	about: For details see CreateStaticBitmap.
	End Rem
	Method Create:wxStaticBitmap(parent:wxWindow, id:Int, bitmap:wxBitmap, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxstaticbitmap_create(Self, parent.wxObjectPtr, id, bitmap.wxObjectPtr, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the bitmap currently used in the control.
	about: Notice that this method can be called even if SetIcon had been used.
	End Rem
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxstaticbitmap_getbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the icon currently used in the control.
	about: Notice that this method can only be called if SetIcon had been used: an icon can't be
	retrieved from the control if a bitmap had been set (using SetBitmap).
	End Rem
	Method GetIcon:wxIcon()
		Return wxIcon._create(bmx_wxstaticbitmap_geticon(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the bitmap.
	End Rem
	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxstaticbitmap_setbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the control to the given icon.
	End Rem
	Method SetIcon(icon:wxIcon)
		bmx_wxstaticbitmap_seticon(wxObjectPtr, icon.wxObjectPtr)
	End Method
	
End Type


Type TStaticBitmapResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxstaticbitmap_addresourcehandler()
	End Method
		
End Type

New TStaticBitmapResourceFactory
