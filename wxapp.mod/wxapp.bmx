' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: 
End Rem
Module wx.wxApp

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
bbdoc: TODO
End Rem
Type wxApp Abstract

	Global app:wxApp
	
	Method New()
		app = Self
	End Method

	Rem
	bbdoc: TODO
	End Rem
	Method OnInit:Int() Abstract

	Function _OnInit:Int()
		Return app.OnInit()
	End Function

	Rem
	bbdoc: TODO
	End Rem
	Method Run:Int()
		Return bmx_app_wxentry()
	End Method
	
	Method SetTopWindow(window:wxWindow)
		bmx_wxapp_settopwindow(window.wxObjectPtr)
	End Method
	
	
	Method SetAppName(name:String)
		bmx_wxapp_setappname(name)
	End Method
	
	Rem
	bbdoc: Yields control to pending messages in the windowing system.
	about: This can be useful, for example, when a time-consuming process writes to a text window.
	Without an occasional yield, the text window will not be updated properly, and on systems with
	cooperative multitasking, such as Windows 3.1 other processes will not respond.
	<p>
	Caution should be exercised, however, since yielding may allow the user to perform actions which
	are not compatible with the current task. Disabling menu items or whole menus during processing
	can avoid unwanted reentrance of code: see ::wxSafeYield for a better function.
	</p>
	<p>
	Note that Yield() will not flush the message logs. This is intentional as calling Yield() is
	usually done to quickly update the screen and popping up a message box dialog may be undesirable.
	If you do wish to flush the log messages immediately (otherwise it will be done during the next
	idle loop iteration), call wxLog::FlushActive.
	</p>
	<p>
	Calling Yield() recursively is normally an error and an assert failure is raised in debug build
	if such situation is detected. However if the onlyIfNeeded parameter is true, the method will just
	silently return false instead.
	</p>
	End Rem
	Method Yield:Int(onlyIfNeeded:Int = False)
		Return bmx_wxapp_yield(onlyIfNeeded)
	End Method
	
End Type


