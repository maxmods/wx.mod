Strict

Import BRL.Graphics

Import BRL.Pixmap

Import Pub.OpenGL

'?Win32
'Import "wxGLGraphics.win32.c"
'?MacOS
'Import "wxGLGraphics.macos.m"
'?Linux
'Import "-lX11"
'Import "-lXxf86vm"
'Import "-lGL"
'Import "wxGLGraphics.linux.c"
'?

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

Global fontTex

Public

Type TwxGLGraphics Extends TGraphics

	Method Driver:TwxGLGraphicsDriver()
		Assert _context
		Return wxGLGraphicsDriver()
	End Method
	
	Method GetSettings( width Var,height Var,depth Var,hertz Var,flags Var )
		Assert _context
		Local w,h,d,r,f
		'bbwxGLGraphicsGetSettings _context,w,h,d,r,f
		width=w
		height=h
		depth=d
		hertz=r
		flags=f
	End Method
	
	Method Close()
		If Not _context Return
		'bbwxGLGraphicsClose( _context )
		_context=0
	End Method
	
	Field _context
	
End Type

Type TwxGLGraphicsDriver Extends TGraphicsDriver

	Method GraphicsModes:TGraphicsMode[]()
		Local buf[1024*4]
		Local count'=bbwxGLGraphicsGraphicsModes( buf,1024 )
		Local modes:TGraphicsMode[count],p:Int Ptr=buf
		For Local i=0 Until count
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
	
	Method AttachGraphics:TwxGLGraphics( widget,flags )
		Local t:TwxGLGraphics = New TwxGLGraphics
		't._context=bbwxGLGraphicsAttachGraphics( widget,flags )
		Return t
	End Method
	
	Method CreateGraphics:TwxGLGraphics( width,height,depth,hertz,flags )
		Local t:TwxGLGraphics=New TwxGLGraphics
		't._context=bbwxGLGraphicsCreateGraphics( width,height,depth,hertz,flags )
		Return t
	End Method
	
	Method SetGraphics( g:TGraphics )
		Local context
		Local t:TwxGLGraphics = TwxGLGraphics( g )
		If t context = t._context
		'bbwxGLGraphicsSetGraphics context
	End Method
	
	Method Flip( sync )
		'bbwxGLGraphicsFlip sync
		' SwapBuffers
	End Method
	
	Method SwapSharedContext()
		'bbwxGLGraphicsSwapSharedContext
	End Method
	
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

'----- Helper Functions -----

Private

Global ortho_mv![16],ortho_pj![16]

Function BeginOrtho()
	Local vp[4]
	
	glPushAttrib GL_ENABLE_BIT|GL_TEXTURE_BIT|GL_TRANSFORM_BIT
	
	glGetIntegerv GL_VIEWPORT,vp
	glGetDoublev GL_MODELVIEW_MATRIX,ortho_mv
	glGetDoublev GL_PROJECTION_MATRIX,ortho_pj
	
	glMatrixMode GL_MODELVIEW
	glLoadIdentity
	glMatrixMode GL_PROJECTION
	glLoadIdentity
	glOrtho 0,vp[2],vp[3],0,-1,1

	glDisable GL_CULL_FACE
	glDisable GL_ALPHA_TEST	
	glDisable GL_DEPTH_TEST
End Function

Function EndOrtho()
	glMatrixMode GL_PROJECTION
	glLoadMatrixd ortho_pj
	glMatrixMode GL_MODELVIEW
	glLoadMatrixd ortho_mv
	
	glPopAttrib
End Function

Public

Rem
bbdoc: Helper function to calculate nearest valid texture size
about: This functions rounds @width and @height up to the nearest valid texture size
End Rem
Function GLAdjustTexSize( width Var,height Var )
	Function Pow2Size( n )
		Local t=1
		While t<n
			t:*2
		Wend
		Return t
	End Function
	width=Pow2Size( width )
	height=Pow2Size( height )
	Repeat
		Local t
		glTexImage2D GL_PROXY_TEXTURE_2D,0,4,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,Null
		glGetTexLevelParameteriv GL_PROXY_TEXTURE_2D,0,GL_TEXTURE_WIDTH,Varptr t
		If t Return
		If width=1 And height=1 RuntimeError "Unable to calculate tex size"
		If width>1 width:/2
		If height>1 height:/2
	Forever
End Function

Rem
bbdoc: Helper function to create a texture from a pixmap
returns: Integer GL Texture name
about: @pixmap is resized to a valid texture size before conversion.
end rem
Function GLTexFromPixmap( pixmap:TPixmap,mipmap=True )
	If pixmap.format<>PF_RGBA8888 pixmap=pixmap.Convert( PF_RGBA8888 )
	Local width=pixmap.width,height=pixmap.height
	GLAdjustTexSize width,height
	If width<>pixmap.width Or height<>pixmap.height pixmap=ResizePixmap( pixmap,width,height )
	
	Local old_name,old_row_len
	glGetIntegerv GL_TEXTURE_BINDING_2D,Varptr old_name
	glGetIntegerv GL_UNPACK_ROW_LENGTH,Varptr old_row_len

	Local name
	glGenTextures 1,Varptr name
	glBindtexture GL_TEXTURE_2D,name
	
	Local mip_level
	Repeat
		glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format]
		glTexImage2D GL_TEXTURE_2D,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
		If Not mipmap Exit
		If width=1 And height=1 Exit
		If width>1 width:/2
		If height>1 height:/2
		pixmap=ResizePixmap( pixmap,width,height )
		mip_level:+1
	Forever
	
	glBindTexture GL_TEXTURE_2D,old_name
	glPixelStorei GL_UNPACK_ROW_LENGTH,old_row_len

	Return name
End Function

Rem
bbdoc:Helper function to output a simple rectangle
about:
Draws a rectangle relative to top-left of current viewport.
End Rem
Function GLDrawRect( x,y,width,height )
	BeginOrtho
	glBegin GL_QUADS
	glVertex2i x,y
	glVertex2i x+width,y
	glVertex2i x+width,y+height
	glVertex2i x,y+height
	glEnd
	EndOrtho
End Function

Rem
bbdoc: Helper function to output some simple 8x16 font text
about:
Draws text relative to top-left of current viewport.<br>
<br>
The font used is an internal fixed point 8x16 font.<br>
<br>
This function is intended for debugging purposes only - performance is unlikely to be stellar.
End Rem
Function GLDrawText( text$,x,y )
	If Not fontTex
		Local pixmap:TPixmap=TPixmap.Create( 1024,16,PF_RGBA8888 )
		Local p:Byte Ptr=IncbinPtr( "gldrawtextfont.bin" )
		For Local y=0 Until 16
			For Local x=0 Until 96
				Local b=p[x]
				For Local n=0 Until 8
					If b & (1 Shl n) 
						pixmap.WritePixel x*8+n,y,~0
					Else
						pixmap.WritePixel x*8+n,y,0
					EndIf
				Next
			Next
			p:+96
		Next
		wxGLGraphicsDriver().SwapSharedContext
		fontTex=GLTexFromPixmap( pixmap )
		wxGLGraphicsDriver().SwapSharedContext
	EndIf
	
	BeginOrtho
	
	glEnable GL_TEXTURE_2D
	glBindTexture GL_TEXTURE_2D,fontTex
	
	For Local i=0 Until text.length
		Local c=text[i]-32
		If c>=0 And c<96
			Const adv#=8/1024.0
			Local t#=c*adv;
			glBegin GL_QUADS
			glTexcoord2f t,0
			glVertex2f x,y
			glTexcoord2f t+adv,0
			glVertex2f x+8,y
			glTexcoord2f t+adv,1
			glVertex2f x+8,y+16
			glTexcoord2f t,1
			glVertex2f x,y+16
			glEnd
		EndIf
		x:+8
	Next

	EndOrtho
End Function

Rem
bbdoc: Helper function to draw a pixmap to a gl context
about:
Draws the pixmap relative to top-left of current viewport.<br>
<br>
This function is intended for debugging purposes only - performance is unlikely to be stellar.
End Rem
Function GLDrawPixmap( pixmap:TPixmap,x,y )
	BeginOrtho

	Local t:TPixmap=YFlipPixmap(pixmap)
	If t.format<>PF_RGBA8888 t=ConvertPixmap( t,PF_RGBA8888 )
	glRasterPos2i 0,0
	glBitmap 0,0,0,0,x,-y-t.height,Null
	glDrawPixels t.width,t.height,GL_RGBA,GL_UNSIGNED_BYTE,t.pixels

	EndOrtho
End Function
