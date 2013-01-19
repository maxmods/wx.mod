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

Module wx.wxGLMax2D

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

Import BRL.Max2D
Import wx.wxGLCanvas

Private

Global GLGraphics:TwxGLGraphics

'Naughty!
Const GL_BGR:Int=$80E0
Const GL_BGRA:Int=$80E1
Const GL_CLAMP_TO_EDGE:Int=$812F
Const GL_CLAMP_TO_BORDER:Int=$812D

Global ix#,iy#,jx#,jy#
Global color4ub:Byte[4]

Global state_blend:Int
Global state_boundtex:Int
Global state_texenabled:Int

Function BindTex( name:Int )
	If name=state_boundtex Return
	glBindTexture GL_TEXTURE_2D,name
	state_boundtex=name
End Function

Function EnableTex( name:Int )
	BindTex name
	If state_texenabled Return
	glEnable GL_TEXTURE_2D
	state_texenabled=True
End Function

Function DisableTex()
	If Not state_texenabled Return
	glDisable GL_TEXTURE_2D
	state_texenabled=False
End Function

Function CreateTex:Int( width:Int,height:Int,flags:Int )

	Local name:Int
	glGenTextures 1,Varptr name

	glBindTexture GL_TEXTURE_2D,name
	'set texture parameters

	glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE
	glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE
	
	If flags & FILTEREDIMAGE
		glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
		If flags & MIPMAPPEDIMAGE
			glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR
		Else
			glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR
		EndIf
	Else
		glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST
		If flags & MIPMAPPEDIMAGE
			glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST_MIPMAP_NEAREST
		Else
			glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST
		EndIf
	EndIf

	Local mip_level:Int

	Repeat
		glTexImage2D GL_TEXTURE_2D,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,Null
		If Not (flags & MIPMAPPEDIMAGE) Exit
		If width=1 And height=1 Exit
		If width>1 width:/2
		If height>1 height:/2
		mip_level:+1
	Forever
	Return name
End Function

Function UploadTex( pixmap:TPixmap,flags:Int )
	Local mip_level:Int
	Repeat
		glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format]
		glTexSubImage2D GL_TEXTURE_2D,mip_level,0,0,pixmap.width,pixmap.height,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
		If Not (flags & MIPMAPPEDIMAGE) Exit
		If pixmap.width>1 And pixmap.height>1
			pixmap=ResizePixmap( pixmap,pixmap.width/2,pixmap.height/2 )
		Else If pixmap.width>1
			pixmap=ResizePixmap( pixmap,pixmap.width/2,pixmap.height )
		Else If pixmap.height>1
			pixmap=ResizePixmap( pixmap,pixmap.width,pixmap.height/2 )
		Else
			Exit
		EndIf
		mip_level:+1
	Forever
	glPixelStorei GL_UNPACK_ROW_LENGTH,0
End Function

Function AdjustTexSize( width:Int Var, height:Int Var )
	Global maxTexSize:Int

	If maxTexSize = 0 Then
		glGetIntegerv GL_MAX_TEXTURE_SIZE, Varptr maxTexSize
	End If
		
	width = Min(Max(1, Pow2Size(width)), maxTexSize)
	height = Min(Max(1, Pow2Size(height)), maxTexSize)

	Function Pow2Size:Int(n:Int)
		Local size:Int = 1
		
		While size < N
			size :Shl 1
		Wend

		Return size
	End Function

End Function

Public

Function CanvasGraphics2D:TGraphics(canvas:wxGLCanvas)
	If Not canvas._graphics Then
		canvas._graphics = GLMax2DDriver().AttachwxGraphics(canvas, 0)
	End If
	Return canvas._graphics
End Function

Type TGLImageFrame Extends TImageFrame

	Field u0#,v0#,u1#,v1#,uscale#,vscale#

	Field name:Int,seq:Int
	
	Method New()
		seq=GraphicsSeq
	End Method
	
	Method Delete()
		If Not seq Return
		wxGLGraphicsDriver().SwapSharedContext
		glDeleteTextures 1,Varptr name
		wxGLGraphicsDriver().SwapSharedContext
		If seq=GraphicsSeq glDeleteTextures 1,Varptr name
		seq=0
	End Method
	
	Method Draw( x0#,y0#,x1#,y1#,tx#,ty#,sx#,sy#,sw#,sh# )
		Assert seq=GraphicsSeq Else "Image does not exist"

		Local u0#=sx * uscale
		Local v0#=sy * vscale
		Local u1#=(sx+sw) * uscale
		Local v1#=(sy+sh) * vscale
		
		EnableTex name
		glBegin GL_QUADS
		glTexCoord2f u0,v0
		glVertex2f x0*ix+y0*iy+tx,x0*jx+y0*jy+ty
		glTexCoord2f u1,v0
		glVertex2f x1*ix+y0*iy+tx,x1*jx+y0*jy+ty
		glTexCoord2f u1,v1
		glVertex2f x1*ix+y1*iy+tx,x1*jx+y1*jy+ty
		glTexCoord2f u0,v1
		glVertex2f x0*ix+y1*iy+tx,x0*jx+y1*jy+ty
		glEnd
	End Method
	
	Function CreateFromPixmap:TGLImageFrame( src:TPixmap,flags:Int )
	
		'determine tex size
		Local tex_w:Int=src.width
		Local tex_h:Int=src.height
		AdjustTexSize tex_w,tex_h
		
		'make sure pixmap fits texture
		Local width:Int=Min( src.width,tex_w )
		Local height:Int=Min( src.height,tex_h )
		If src.width<>width Or src.height<>height src=ResizePixmap( src,width,height )

		'create texture pixmap
		Local tex:TPixmap=src
		
		'"smear" right/bottom edges if necessary
		If width<tex_w Or height<tex_h
			tex=TPixmap.Create( tex_w,tex_h,PF_RGBA8888 )
			tex.Paste src,0,0
			If width<tex_w
				tex.Paste src.Window( width-1,0,1,height ),width,0
			EndIf
			If height<tex_h
				tex.Paste src.Window( 0,height-1,width,1 ),0,height
				If width<tex_w 
					tex.Paste src.Window( width-1,height-1,1,1 ),width,height
				EndIf
			EndIf
		Else
			If tex.format<>PF_RGBA8888 tex=tex.Convert( PF_RGBA8888 )
		EndIf
		
		'create tex
		Local name:Int=CreateTex( tex_w,tex_h,flags )
		
		'upload it
		UploadTex tex,flags

		'done!
		Local frame:TGLImageFrame=New TGLImageFrame
		frame.name=name
		frame.uscale=1.0/tex_w
		frame.vscale=1.0/tex_h
		frame.u1=width * frame.uscale
		frame.v1=height * frame.vscale
		Return frame

	End Function

End Type

Type TGLMax2DDriver Extends TMax2DDriver

	'graphics driver overrides
	Method GraphicsModes:TGraphicsMode[]()
		Return wxGLGraphicsDriver().GraphicsModes()
	End Method
	
	Method AttachGraphics:TMax2DGraphics( widget:Int,flags:Int )
	'	Local g:TGLGraphics=wxGLGraphicsDriver().AttachGraphics( widget,flags )
	'	If g Return TMax2DGraphics.Create( g,Self )
	End Method

	Method AttachwxGraphics:TMax2DGraphics( widget:wxGLCanvas, flags:Int )
		Local g:TwxGLGraphics = New TwxGLGraphics
		g._context = widget
		
		If g Return TMax2DGraphics.Create( g,Self )
	End Method
	
	Method CreateGraphics:TMax2DGraphics( width:Int,height:Int,depth:Int,hertz:Int,flags:Int )
		Local g:TwxGLGraphics=wxGLGraphicsDriver().CreateGraphics( width,height,depth,hertz,flags )
		If g Return TMax2DGraphics.Create( g,Self )
	End Method
	
	Method SetGraphics( g:TGraphics )
		If Not g
			TMax2DGraphics.ClearCurrent
			wxGLGraphicsDriver().SetGraphics Null
			Return
		EndIf
	
		Local t:TMax2DGraphics=TMax2DGraphics(g)
		Assert t And TwxGLGraphics( t._graphics )

		wxGLGraphicsDriver().SetGraphics t._graphics

		ResetGLContext t
		
		t.MakeCurrent
	End Method
	
	Method ResetGLContext( g:TGraphics )
		Local gw:Int,gh:Int,gd:Int,gr:Int,gf:Int
		g.GetSettings gw,gh,gd,gr,gf
		state_blend=0
		state_boundtex=0
		state_texenabled=0
		glDisable GL_TEXTURE_2D
		glMatrixMode GL_PROJECTION
		glLoadIdentity
		glOrtho 0,gw,gh,0,-1,1
		glMatrixMode GL_MODELVIEW
		glViewport 0,0,gw,gh
	End Method
	
	Method Flip( sync:Int )
		wxGLGraphicsDriver().Flip sync
	End Method
	
	Method ToString$()
		Return "OpenGL"
	End Method

	Method CreateFrameFromPixmap:TGLImageFrame( pixmap:TPixmap,flags:Int )
		Local frame:TGLImageFrame
		frame=TGLImageFrame.CreateFromPixmap( pixmap,flags )
		Return frame
	End Method

	Method SetBlend( blend:Int )
		If blend=state_blend Return
		state_blend=blend
		Select blend
		Case MASKBLEND
			glDisable GL_BLEND
			glEnable GL_ALPHA_TEST
			glAlphaFunc GL_GEQUAL,.5
		Case SOLIDBLEND
			glDisable GL_BLEND
			glDisable GL_ALPHA_TEST
		Case ALPHABLEND
			glEnable GL_BLEND
			glBlendFunc GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA
			glDisable GL_ALPHA_TEST
		Case LIGHTBLEND
			glEnable GL_BLEND
			glBlendFunc GL_SRC_ALPHA,GL_ONE
			glDisable GL_ALPHA_TEST
		Case SHADEBLEND
			glEnable GL_BLEND
			glBlendFunc GL_DST_COLOR,GL_ZERO
			glDisable GL_ALPHA_TEST
		Default
			glDisable GL_BLEND
			glDisable GL_ALPHA_TEST
		End Select
	End Method

	Method SetAlpha( alpha# )
		If alpha>1.0 alpha=1.0
		If alpha<0.0 alpha=0.0
		color4ub[3]=alpha*255
		glColor4ubv color4ub
	End Method

	Method SetLineWidth( width# )
		glLineWidth width
	End Method
	
	Method SetColor( red:Int,green:Int,blue:Int )
		color4ub[0]=Min(Max(red,0),255)
		color4ub[1]=Min(Max(green,0),255)
		color4ub[2]=Min(Max(blue,0),255)
		glColor4ubv color4ub
	End Method

	Method SetClsColor( red:Int,green:Int,blue:Int )
		red=Min(Max(red,0),255)
		green=Min(Max(green,0),255)
		blue=Min(Max(blue,0),255)
		glClearColor red/255.0,green/255.0,blue/255.0,1.0
	End Method
	
	Method SetViewport( x:Int,y:Int,w:Int,h:Int )
		If x=0 And y=0 And w=GraphicsWidth() And h=GraphicsHeight()
			glDisable GL_SCISSOR_TEST
		Else
			glEnable GL_SCISSOR_TEST
			glScissor x,GraphicsHeight()-y-h,w,h
		EndIf
	End Method

	Method SetTransform( xx#,xy#,yx#,yy# )
		ix=xx
		iy=xy
		jx=yx
		jy=yy
	End Method

	Method Cls()
		glClear GL_COLOR_BUFFER_BIT
	End Method

	Method Plot( x#,y# )
		DisableTex
		glBegin GL_POINTS
		glVertex2f x+.5,y+.5
		glEnd
	End Method

	Method DrawLine( x0#,y0#,x1#,y1#,tx#,ty# )
		DisableTex
		glBegin GL_LINES
		glVertex2f x0*ix+y0*iy+tx+.5,x0*jx+y0*jy+ty+.5
		glVertex2f x1*ix+y1*iy+tx+.5,x1*jx+y1*jy+ty+.5
		glEnd
	End Method

	Method DrawRect( x0#,y0#,x1#,y1#,tx#,ty# )
		DisableTex
		glBegin GL_QUADS
		glVertex2f x0*ix+y0*iy+tx,x0*jx+y0*jy+ty
		glVertex2f x1*ix+y0*iy+tx,x1*jx+y0*jy+ty
		glVertex2f x1*ix+y1*iy+tx,x1*jx+y1*jy+ty
		glVertex2f x0*ix+y1*iy+tx,x0*jx+y1*jy+ty
		glEnd
	End Method
	
	Method DrawOval( x0#,y0#,x1#,y1#,tx#,ty# )
	
		Local xr#=(x1-x0)*.5
		Local yr#=(y1-y0)*.5
		Local segs:Int=Abs(xr)+Abs(yr)
		
		segs=Max(segs,12)&~3

		x0:+xr
		y0:+yr
		
		DisableTex
		glBegin GL_POLYGON
		For Local i:Int=0 Until segs
			Local th#=i*360#/segs
			Local x#=x0+Cos(th)*xr
			Local y#=y0-Sin(th)*yr
			glVertex2f x*ix+y*iy+tx,x*jx+y*jy+ty
		Next
		glEnd
		
	End Method
	
	Method DrawPoly( xy#[],handle_x#,handle_y#,origin_x#,origin_y# )
		If xy.length<6 Or (xy.length&1) Return
		
		DisableTex
		glBegin GL_POLYGON
		For Local i:Int=0 Until Len xy Step 2
			Local x#=xy[i+0]+handle_x
			Local y#=xy[i+1]+handle_y
			glVertex2f x*ix+y*iy+origin_x,x*jx+y*jy+origin_y
		Next
		glEnd
	End Method
		
	Method DrawPixmap( p:TPixmap,x:Int,y:Int )
		Local blend:Int=state_blend
		DisableTex
		SetBlend SOLIDBLEND
		
		Local t:TPixmap=YFlipPixmap(p)
		If t.format<>PF_RGBA8888 t=ConvertPixmap( t,PF_RGBA8888 )
		glRasterPos2i 0,0
		glBitmap 0,0,0,0,x,-y-t.height,Null
		glDrawPixels t.width,t.height,GL_RGBA,GL_UNSIGNED_BYTE,t.pixels
		
		SetBlend blend
	End Method

	Method GrabPixmap:TPixmap( x:Int,y:Int,w:Int,h:Int )
		Local blend:Int=state_blend
		SetBlend SOLIDBLEND
	
		Local p:TPixmap=CreatePixmap( w,h,PF_RGBA8888 )
		glReadPixels x,GraphicsHeight()-h-y,w,h,GL_RGBA,GL_UNSIGNED_BYTE,p.pixels
		p=YFlipPixmap(p)

		SetBlend blend
		Return p
	End Method

	Method SetResolution( width#,height# )
		glMatrixMode GL_PROJECTION
		glLoadIdentity
		glOrtho 0,width,height,0,-1,1
		glMatrixMode GL_MODELVIEW
	End Method
	
End Type

Rem
bbdoc: Get OpenGL Max2D Driver
about:
The returned driver can be used with #SetGraphicsDriver to enable OpenGL Max2D 
rendering.
End Rem
Function GLMax2DDriver:TGLMax2DDriver()
	Global _driver:TGLMax2DDriver=New TGLMax2DDriver
	Return _driver
End Function

SetGraphicsDriver GLMax2DDriver()

