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
bbdoc: wxSplashScreen
End Rem
Module wx.wxSplashScreen

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
bbdoc: wxSplashScreen shows a window with a thin border, displaying a bitmap describing your application.
about: Show it in application initialisation, and then either explicitly destroy it or let it time-out.
End Rem
Type wxSplashScreen Extends wxFrame

	Rem
	bbdoc: 
	End Rem
	Function CreateSplashScreen:wxSplashScreen(bitmap:wxBitmap, splashStyle:Int, milliseconds:Int, ..
			parent:wxWindow = Null, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSIMPLE_BORDER | wxFRAME_NO_TASKBAR | wxSTAY_ON_TOP)
		
		Return New wxSplashScreen.Splash(bitmap, splashStyle, milliseconds, parent, id, x, y, w, h, style)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Splash:wxSplashScreen(bitmap:wxBitmap, splashStyle:Int, milliseconds:Int, ..
			parent:wxWindow = Null, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSIMPLE_BORDER | wxFRAME_NO_TASKBAR | wxSTAY_ON_TOP)
		
		If parent Then
			wxObjectPtr = bmx_wxsplashscreen_create(Self, bitmap.wxObjectPtr, splashStyle, milliseconds, ..
				parent.wxObjectPtr, id, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxsplashscreen_create(Self, bitmap.wxObjectPtr, splashStyle, milliseconds, ..
				Null, id, x, y, w, h, style)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the splash style.
	End Rem
	Method GetSplashStyle:Int()
		Return bmx_wxsplashscreen_getsplashstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the window used to display the bitmap.
	End Rem
	Method GetSplashWindow:wxWindow()
		Return wxWindow._create(bmx_wxsplashscreen_getsplashwindow(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the timeout in milliseconds.
	End Rem
	Method GetTimeout:Int()
		Return bmx_wxsplashscreen_gettimeout(wxObjectPtr)
	End Method
	
End Type
