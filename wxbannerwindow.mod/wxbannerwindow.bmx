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

Module wx.wxBannerWindow

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
bbdoc: A simple banner window showing either a bitmap or text.
about: Banner windows can be used to present some overview of the current window contents
to the user in an aesthetically pleasant way. They are typically positioned along the left
or top edge of the window (although this class also supports right- and bottom-aligned banners)
and show either a bitmap with a logo or a few lines of text on a gradient-filled background.
End Rem
Type wxBannerWindow Extends wxWindow

	Function _create:wxBannerWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBannerWindow = New wxBannerWindow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxBannerWindow(wxObjectPtr:Byte Ptr)
		Return wxBannerWindow._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateBannerWindow:wxBannerWindow(parent:wxWindow, id:Int, dir:Int = wxLEFT, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxBannerWindow.Create(parent, id, dir, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxBannerWindow(parent:wxWindow, id:Int, dir:Int = wxLEFT, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxbannerwindow_create(Self, parent.wxObjectPtr, id, dir, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxbannerwindow_setbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Method SetText(title:String, message:String)
		bmx_wxbannerwindow_settext(wxObjectPtr, title, message)
	End Method
	
	Method SetGradient(colStart:wxColour, colEnd:wxColour)
		bmx_wxbannerwindow_setgradient(wxObjectPtr, colStart.wxObjectPtr, colEnd.wxObjectPtr)
	End Method
	
End Type

Type TBannerWindowResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxbannerwindow_addresourcehandler()
	End Method
		
End Type

New TBannerWindowResourceFactory
