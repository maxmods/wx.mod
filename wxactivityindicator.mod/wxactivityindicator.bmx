' Copyright (c) 2007-2018 Bruce A Henderson
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

Module wx.wxActivityIndicator

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2018 Bruce A Henderson"


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
bbdoc: Small control showing an animation indicating that the program is currently busy performing some background task.
End Rem
Type wxActivityIndicator Extends wxControl

	Function _create:wxActivityIndicator(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxActivityIndicator = New wxActivityIndicator
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxActivityIndicator(wxObjectPtr:Byte Ptr) { nomangle }
		Return wxActivityIndicator._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a checkbox.
	End Rem
	Function CreateActivityIndicator:wxActivityIndicator(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxActivityIndicator.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the checkbox for two-step construction.
	about: See CreateCheckBox for details.
	End Rem
	Method Create:wxActivityIndicator(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxactivityindicator_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Starts animation of the indicator.
	about: Does nothing if the indicator is already running.
	End Rem
	Method Start()
		bmx_wxactivityindicator_start(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Stops the animation of the indicator.
	about: Notice that the animation is stopped even if #Start() had been called multiple times before, 
	i.e. the calls are not cumulative.
	End Rem
	Method Stop()
		bmx_wxactivityindicator_stop(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the control is currently showing activity.
	returns: #False initially, #True once #Start() is called and #False again after calling #Stop().
	End Rem
	Method IsRunning:Int()
		Return bmx_wxactivityindicator_isrunning(wxObjectPtr)
	End Method

End Type

Type TActivityIndicatorResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxactivityindicator_addresourcehandler()
	End Method
		
End Type

New TActivityIndicatorResourceFactory
