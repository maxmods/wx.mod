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
bbdoc: wxGLCanvas
End Rem
Module wx.wxGLCanvas

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

Import BRL.Graphics
Import BRL.Pixmap
Import Pub.OpenGL

Rem
bbdoc: wxGLCanvas is a type for displaying OpenGL graphics.
End Rem
Type wxGLCanvas Extends wxWindow

	Field _graphics:TGraphics

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
	
	Rem
	bbdoc: 
	End Rem
	Method OnPaint(event:wxPaintEvent)
	End Method

	Function _OnPaintHook(event:wxEvent)
		bmx_wxglcanvas_onpainthook(event.parent.wxObjectPtr, event)
	End Function
	
	Function _OnPaint(event:wxPaintEvent)
		wxGLCanvas(event.parent).OnPaint(event)
	End Function
	
End Type




Private

Incbin "gldrawtextfont.bin"

'Extern
'	Function bbwxGLGraphicsGraphicsModes( buf:Byte Ptr,size )
'	Function bbwxGLGraphicsAttachGraphics( widget,flags )
'	Function bbwxGLGraphicsCreateGraphics( width,height,depth,hertz,flags )
'	Function bbwxGLGraphicsGetSettings( context,width Var,height Var,depth Var,hertz Var,flags Var )
'	Function bbwxGLGraphicsClose( context )	
'	Function bbwxGLGraphicsSetGraphics( context )
'	Function bbwxGLGraphicsFlip( sync )
'	Function bbwxGLGraphicsSwapSharedContext()
'End Extern

Global fontTex:Int

Public

Type TwxGLGraphics Extends TGraphics

	Method Driver:TwxGLGraphicsDriver()
		Assert _context
		Return wxGLGraphicsDriver()
	End Method
	
	Method GetSettings( width:Int Var,height:Int Var,depth:Int Var,hertz:Int Var,flags:Int Var )
		Assert _context
		Local w:Int,h:Int,d:Int,r:Int,f:Int
		'bbwxGLGraphicsGetSettings _context,w,h,d,r,f
		If _context Then
			_context.GetSize(width, height)
		End If
		'width=w
		'height=h
		depth=d
		hertz=r
		flags=f
	End Method
	
	Method Close()
		If Not _context Return
		'bbwxGLGraphicsClose( _context )
		_context=Null
	End Method
	
	Field _context:wxGLCanvas
	
End Type

Function CanvasGraphics:TGraphics(canvas:wxGLCanvas)
	If Not canvas._graphics Then
		canvas._graphics = wxGLGraphicsDriver().AttachwxGraphics(canvas, 0)
	End If
	Return canvas._graphics
End Function

Type TwxGLGraphicsDriver Extends TGraphicsDriver

	Method GraphicsModes:TGraphicsMode[]()
		Local buf:Int[1024*4]
		Local count:Int'=bbwxGLGraphicsGraphicsModes( buf,1024 )
		Local modes:TGraphicsMode[count],p:Int Ptr=buf
		For Local i:Int = 0 Until count
			Local t:TGraphicsMode=New TGraphicsMode
			t.width=p[0]
			t.height=p[1]
			t.depth=p[2]
			t.hertz=p[3]
			modes[i]=t
			p:+4
		Next
		Return modes
	End Method
	
	Method AttachGraphics:TwxGLGraphics( widget:Int, flags:Int )
		Local t:TwxGLGraphics = New TwxGLGraphics
'		t._context=bbwxGLGraphicsAttachGraphics( widget,flags )
		Return t
	End Method

	Method AttachwxGraphics:TwxGLGraphics( widget:wxGLCanvas, flags:Int )
		Local t:TwxGLGraphics = New TwxGLGraphics
		t._context = widget
		Return t
	End Method
	
	Method CreateGraphics:TwxGLGraphics( width:Int,height:Int,depth:Int,hertz:Int,flags:Int )
		Local t:TwxGLGraphics=New TwxGLGraphics
		't._context=bbwxGLGraphicsCreateGraphics( width,height,depth,hertz,flags )
		Return t
	End Method
	
	Method SetGraphics( g:TGraphics )
		Local context:wxGLCanvas
		Local t:TwxGLGraphics = TwxGLGraphics( g )
		If t context = t._context
		'bbwxGLGraphicsSetGraphics context
		currentContext = context
	End Method
	
	Method Flip( sync:Int )
		'bbwxGLGraphicsFlip sync
		' SwapBuffers
		currentContext.SwapBuffers()
	End Method
	
	Method SwapSharedContext()
		'bbwxGLGraphicsSwapSharedContext
	End Method
	
	Field currentContext:wxGLCanvas
	
End Type

Rem
bbdoc: Get OpenGL graphics driver
returns: An OpenGL graphics driver
about:
The returned driver can be used with #brl.graphics.SetGraphicsDriver
End Rem
Function wxGLGraphicsDriver:TwxGLGraphicsDriver()
	Global _driver:TwxGLGraphicsDriver=New TwxGLGraphicsDriver
	Return _driver
End Function

'Rem
'bbdoc: Create OpenGL Graphics
'returns: An OpenGL Graphics Object
'about:
'This is a convenience Function that allows you To easily create an OpenGL Graphics context.
'End Rem
'Function wxGLGraphics:TGraphics( width,height,depth=0,hertz=60,flags=GRAPHICS_BACKBUFFER|GRAPHICS_DEPTHBUFFER )
'	SetGraphicsDriver wxGLGraphicsDriver()
'	Return Graphics( width,height,depth,hertz,flags )
'End Function
	
SetGraphicsDriver wxGLGraphicsDriver()

