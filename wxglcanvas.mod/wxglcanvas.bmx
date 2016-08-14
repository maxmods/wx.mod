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
bbdoc: wxGLCanvas
End Rem
Module wx.wxGLCanvas

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

Import BRL.Graphics
Import BRL.Pixmap
Import Pub.OpenGL

Rem
bbdoc: wxGLCanvas is a type for displaying OpenGL graphics.
End Rem
Type wxGLCanvas Extends wxWindow

	Field _graphics:TGraphics
	
	Field _sync:Int = -999

	Function CreateGLCanvas:wxGLCanvas(parent:wxWindow, id:Int = wxID_ANY, flags:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxGLCanvas.Create(parent, id, flags, x, y, w, h, style)
	End Function
	
	Method Create:wxGLCanvas(parent:wxWindow, id:Int = wxID_ANY, flags:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxglcanvas_create(Self, parent.wxObjectPtr, id, flags, x, y, w, h, style)
		ConnectAny(wxEVT_PAINT, _OnPaintHook)
		OnInit()
		Return Self
	End Method
	
	Method SwapBuffers()
		bmx_wxglcanvas_swapbuffers(wxObjectPtr)
	End Method
	
	Method SetSwapInterval(sync:Int)
		bmx_wxglcanvas_setswapinterval(wxObjectPtr, sync)
	End Method
	
	Rem
	bbdoc: Override this to implemented your own canvas drawing.
	End Rem
	Method OnPaint(event:wxPaintEvent)
	End Method

	Function _OnPaintHook(event:wxEvent)
		bmx_wxglcanvas_onpainthook(event.parent.wxObjectPtr, event)
	End Function
	
	Function _OnPaint(event:wxPaintEvent) { nomangle }
		wxGLCanvas(event.parent).OnPaint(event)
	End Function
	
	Rem
	bbdoc: Makes the implicit rendering context of this canvas current with this canvas, so that subsequent OpenGL calls modify the OpenGL state of the implicit rendering context.
	about: Note that this method may only be called after the window has been shown.
	End Rem
	Method SetCurrent()
		bmx_wxglcanvas_setcurrent(wxObjectPtr)
	End Method

	Method CanvasGraphics:TGraphics()
		If Not _graphics Then
?bmxng
			_graphics = brl.Graphics.AttachGraphics(GetHandle(), 0 )
?Not bmxng
			_graphics = brl.Graphics.AttachGraphics(Int(GetHandle()), 0 )
?
		End If
		Return _graphics
	End Method

End Type

