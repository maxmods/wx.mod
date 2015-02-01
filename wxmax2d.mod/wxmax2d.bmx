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
bbdoc: wxMax2D
End Rem
Module wx.wxMax2D

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



Type TwxImageFrame Extends TImageFrame

	Field u0#,v0#,u1#,v1#

	Field name:Int,seq:Int
	Field bitmap:wxBitmap
	
	Field displayBitmap:wxBitmap
	
	Field driver:TwxMax2DDriver
	
	Field lastColour:wxColour
	
	Method New()
		seq=GraphicsSeq
	End Method
	
	Method Delete()
		If Not seq Return
		'GLGraphicsDriver().SwapSharedContext
		'glDeleteTextures 1,Varptr name
		'GLGraphicsDriver().SwapSharedContext
		'If seq=GraphicsSeq glDeleteTextures 1,Varptr name
		'seq=0
	End Method
	
	Method Draw( x0#,y0#,x1#,y1#,tx#,ty#,sx#,sy#,sw#,sh# )
		Assert seq=GraphicsSeq Else "Image does not exist"

		If Not lastColour Or Not lastColour.Equals(driver.pen.GetColour()) Then
			lastColour = driver.pen.GetColour()
			
			displayBitmap = bitmap.GetSubBitmap(0, 0, bitmap.GetWidth(), bitmap.GetHeight())
			displayBitmap.Colourize(lastColour)
		End If
		'EnableTex name
		'glBegin GL_QUADS
		'glTexCoord2f u0,v0
		'glVertex2f x0*ix+y0*iy+tx,x0*jx+y0*jy+ty
		'glTexCoord2f u1,v0
		'glVertex2f x1*ix+y0*iy+tx,x1*jx+y0*jy+ty
		'glTexCoord2f u1,v1
		'glVertex2f x1*ix+y1*iy+tx,x1*jx+y1*jy+ty
		'glTexCoord2f u0,v1
		'glVertex2f x0*ix+y1*iy+tx,x0*jx+y1*jy+ty
		'glEnd
		driver.DrawImage(x0, y0, x1, y1, tx, ty, displayBitmap)
	End Method
	
	Function CreateFromPixmap:TwxImageFrame( src:TPixmap, flags:Int )
	
		'determine tex size
		'Local tex_w=src.width
		'Local tex_h=src.height
		'AdjustTexSize tex_w,tex_h
		
		'make sure pixmap fits texture
		'Local width=Min( src.width,tex_w )
		'Local height=Min( src.height,tex_h )
		'If src.width<>width Or src.height<>height src=ResizePixmap( src,width,height )

		'create texture pixmap
		'Local tex:TPixmap=src
		
		'"smear" right/bottom edges if necessary
		'If width<tex_w Or height<tex_h
		'	tex=TPixmap.Create( tex_w,tex_h,PF_RGBA8888 )
		'	tex.Paste src,0,0
		'	If width<tex_w
		'		tex.Paste src.Window( width-1,0,1,height ),width,0
		'	EndIf
		'	If height<tex_h
		'		tex.Paste src.Window( 0,height-1,width,1 ),0,height
		'		If width<tex_w 
		'			tex.Paste src.Window( width-1,height-1,1,1 ),width,height
		'		EndIf
		'	EndIf
		'Else
		'	If tex.format<>PF_RGBA8888 tex=tex.Convert( PF_RGBA8888 )
		'EndIf
		
		'create tex
		'Local name=CreateTex( tex_w,tex_h,flags )
		
		'upload it
		'UploadTex tex,flags

		'done!
		Local frame:TwxImageFrame = New TwxImageFrame
		frame.bitmap = New wxBitmap.CreateFromPixmap(src)
		'frame.name=name
		'frame.u1=Float(width)/Float(tex_w)
		'frame.v1=Float(height)/Float(tex_h)
		Return frame

	End Function

End Type





Type TwxMax2DDriver Extends TMax2DDriver

	Field ix#,iy#,jx#,jy#

	Field clsColor:wxBrush = wxWHITE_BRUSH()
	Field brush:wxBrush = wxBLACK_BRUSH()
	Field pen:wxPen = wxBLACK_PEN()
	'Field textForeground:wxColour = wxBLACK()
	'Field textBackground:wxColour = wxWHITE()
	Field dc:wxDC = Null

	'graphics driver overrides
	Method GraphicsModes:TGraphicsMode[]()
		'Return GLGraphicsDriver().GraphicsModes()
	End Method
	
	Method AttachGraphics:TMax2DGraphics( widget:Int ,flags:Int )
		Local g:TwxGraphics=wxGraphicsDriver().AttachGraphics( widget,flags )
		If g Return TMax2DGraphics.Create( g,Self )
	End Method
	
	Method CreateGraphics:TMax2DGraphics( width:Int ,height:Int ,depth:Int ,hertz:Int ,flags:Int  )
		Local g:TwxGraphics=wxGraphicsDriver().CreateGraphics( width,height,depth,hertz,flags )
		If g Return TMax2DGraphics.Create( g,Self )
	End Method
	
	Method SetGraphics( g:TGraphics )
		Local t:TMax2DGraphics=TMax2DGraphics(g)
		Assert t And TwxGraphics( t._graphics )

		If TwxGraphics(t._graphics).target Then
			dc = New wxAutoBufferedPaintDC.CreatePaintDC(TwxGraphics(t._graphics).target)
			TwxGraphics(t._graphics).target.PrepareDC(dc)
			dc.setPen(pen)
			dc.setBrush(brush)
		End If
	
		wxGraphicsDriver().SetGraphics t._graphics

		' the first time round, we need to toggle the dc off and on, so that it isn't freed before we can
		' use it.
		Local tmp:wxDC
		If Not TwxGraphics(t._graphics).done Then
			tmp = dc
			dc = Null
		End If
		
		' this method calls Flip, which, if the DC is set, will free the DC.
		t.MakeCurrent
		
		' swap it back, if required :-)
		If tmp Then
			dc = tmp
			TwxGraphics(t._graphics).done = True
		End If
	End Method
	
	Method ResetGLContext( g:TGraphics )
		'Local gw,gh,gd,gr,gf
'		g.GetSettings gw,gh,gd,gr,gf
'		
'		state_blend=0
'		state_boundtex=0
'		state_texenabled=0
'		glDisable GL_TEXTURE_2D
'		glMatrixMode GL_PROJECTION
'		glLoadIdentity
'		glOrtho 0,gw,gh,0,-1,1
'		glMatrixMode GL_MODELVIEW
'		glViewport 0,0,gw,gh
	End Method
	
	Method Flip( sync:Int  )
'		GLGraphicsDriver().Flip sync
		If dc Then
			dc.Free()
			dc = Null
		End If
	End Method
	
	Method ToString$()
		Return "wx"
	End Method

	Method CreateFrameFromPixmap:TImageFrame( pixmap:TPixmap,flags:Int  )
		Local frame:TwxImageFrame
'		GLGraphicsDriver().SwapSharedContext
		frame = TwxImageFrame.CreateFromPixmap( pixmap, flags )
		frame.driver = Self
'		GLGraphicsDriver().SwapSharedContext
		Return frame
	End Method

	Method SetBlend( blend:Int  )
Rem
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
End Rem
	End Method

	Method SetAlpha( alpha# )
Rem
		If alpha>1.0 alpha=1.0
		If alpha<0.0 alpha=0.0
		color4ub[3]=alpha*255
		glColor4ubv color4ub
End Rem
	End Method

	Method SetLineWidth( width# )
		pen.SetWidth(width)
'		glLineWidth width
	End Method
	
	Method SetColor( red:Int ,green:Int ,blue:Int  )
		brush.SetFromRGB(red, green, blue)
		pen.SetFromRGB(red, green, blue)
'		textForeground.Set(red, green, blue)
'		color4ub[0]=Min(Max(red,0),255)
'		color4ub[1]=Min(Max(green,0),255)
'		color4ub[2]=Min(Max(blue,0),255)
'		glColor4ubv color4ub
	End Method

	Method SetClsColor( red:Int ,green:Int ,blue:Int  )
'		red=Min(Max(red,0),255)
'		green=Min(Max(green,0),255)
'		blue=Min(Max(blue,0),255)
'		glClearColor red/255.0,green/255.0,blue/255.0,1.0
	End Method
	
	Method SetViewport( x:Int ,y:Int ,w:Int ,h:Int  )
'		If x=0 And y=0 And w=GraphicsWidth() And h=GraphicsHeight()
'			glDisable GL_SCISSOR_TEST
'		Else
'			glEnable GL_SCISSOR_TEST
'			glScissor x,GraphicsHeight()-y-h,w,h
'		EndIf
	End Method

	Method SetTransform( xx#,xy#,yx#,yy# )
		ix=xx
		iy=xy
		jx=yx
		jy=yy
	End Method

	Method Cls()
		If dc Then
			If clsColor Then
				dc.SetBackground(clsColor)
			End If
			dc.Clear()
		End If
	End Method

	Method Plot( x#,y# )
		If dc Then
			dc.DrawPoint(x + 0.5, y + 0.5)
		End If
	End Method

	Method DrawLine( x0#,y0#,x1#,y1#,tx#,ty# )
		If dc Then
			dc.setPen(pen)
			dc.DrawLine x0*ix+y0*iy+tx+.5, x0*jx+y0*jy+ty+.5, x1*ix+y1*iy+tx+.5, x1*jx+y1*jy+ty+.5
		End If
	End Method

	Method DrawRect( x0#,y0#,x1#,y1#,tx#,ty# )
		If dc Then
			Global points:Int[] = New Int[8]
			points[0] = x0*ix+y0*iy+tx
			points[1] = x0*jx+y0*jy+ty
			points[2] = x1*ix+y0*iy+tx
			points[3] = x1*jx+y0*jy+ty
			points[4] = x1*ix+y1*iy+tx
			points[5] = x1*jx+y1*jy+ty
			points[6] = x0*ix+y1*iy+tx
			points[7] = x0*jx+y1*jy+ty
			dc.DrawPolygon(points)
		End If
	End Method
	
	Method DrawOval( x0#,y0#,x1#,y1#,tx#,ty# )
Rem	
		Local xr#=(x1-x0)*.5
		Local yr#=(y1-y0)*.5
		Local segs=Abs(xr)+Abs(yr)
		
		segs=Max(segs,12)&~3

		x0:+xr
		y0:+yr
		
		DisableTex
		glBegin GL_POLYGON
		For Local i=0 Until segs
			Local th#=i*360#/segs
			Local x#=x0+Cos(th)*xr
			Local y#=y0-Sin(th)*yr
			glVertex2f x*ix+y*iy+tx,x*jx+y*jy+ty
		Next
		glEnd
End Rem
	End Method
	
	Method DrawPoly( xy#[],handle_x#,handle_y#,origin_x#,origin_y# )
		If dc Then
			If xy.length<6 Or (xy.length&1) Return
		
			Local points:Int[] = New Int[xy.length]
			Local x:Float, y:Float
			For Local i:Int = 0 Until xy.length Step 2
				x = xy[i] + handle_x
				y = xy[i + 1] + handle_y
				points[i] = x*ix+y*iy+origin_x
				points[i + 1] = x*jx+y*jy+origin_y
			Next
		
		End If
Rem		
		DisableTex
		glBegin GL_POLYGON
		For Local i=0 Until Len xy Step 2
			Local x#=xy[i+0]+handle_x
			Local y#=xy[i+1]+handle_y
			glVertex2f x*ix+y*iy+origin_x,x*jx+y*jy+origin_y
		Next
		glEnd
End Rem
	End Method
		
	Method DrawPixmap( p:TPixmap,x:Int ,y:Int  )
Rem
		Local blend=state_blend
		DisableTex
		SetBlend SOLIDBLEND
		
		Local t:TPixmap=YFlipPixmap(p)
		If t.format<>PF_RGBA8888 t=ConvertPixmap( t,PF_RGBA8888 )
		glRasterPos2i 0,0
		glBitmap 0,0,0,0,x,-y-t.height,Null
		glDrawPixels t.width,t.height,GL_RGBA,GL_UNSIGNED_BYTE,t.pixels
		
		SetBlend blend
End Rem
	End Method
	
	Method DrawImage( x0#,y0#,x1#,y1#,tx#,ty#, bitmap:wxBitmap)
'DebugLog "x0 = " + x0 + ", y0 = " + y0 + ", x1 = " + x1 + ", y1 = " + y1
'DebugLog "tx = " + tx + ", ty = " + ty
		If dc Then
			dc.DrawBitmap(bitmap, tx, ty, False)
		End If
	End Method

	Method GrabPixmap:TPixmap( x:Int ,y:Int ,w:Int ,h:Int  )
Rem
		Local blend=state_blend
		SetBlend SOLIDBLEND
	
		Local p:TPixmap=CreatePixmap( w,h,PF_RGBA8888 )
		glReadPixels x,GraphicsHeight()-h-y,w,h,GL_RGBA,GL_UNSIGNED_BYTE,p.pixels
		p=YFlipPixmap(p)

		SetBlend blend
		Return p
End Rem
	End Method

	Method SetResolution(width:Float, height:Float)
	End Method
	
End Type

Function wxMax2DDriver:TwxMax2DDriver()
'DebugLog "wxMax2DDriver"
	Global _driver:TwxMax2DDriver=New TwxMax2DDriver
	Return _driver
End Function

	
SetGraphicsDriver wxMax2DDriver()


Function wxGraphics:TGraphics(widget:wxWindow)
	If Not widget._data Then
		Local g:TGraphics = BRL.Graphics.AttachGraphics(0, 0)
		widget._data = g
		TwxGraphics(TMax2DGraphics(g)._graphics).target = widget
		Return g
	Else
		Return TGraphics(widget._data)
	End If
End Function

Type TwxGraphics Extends TGraphics

	Field target:wxWindow
	Field done:Int

	Method Driver:TwxGraphicsDriver()
		'Assert _context
		Return wxGraphicsDriver()
	End Method
	
	Method GetSettings( width:Int Var,height:Int  Var,depth:Int Var,hertz:Int Var,flags:Int Var )
		'Assert _context
		'Local w,h,d,r,f
		'bbGLGraphicsGetSettings _context,w,h,d,r,f
		'width=w
		'height=h
		'depth=d
		'hertz=r
		'flags=f
	End Method
	
	Method Close()
		'If Not _context Return
		'bbGLGraphicsClose( _context )
		'_context=0
	End Method
	
	'Field _context
	
End Type

Type TwxGraphicsDriver Extends TGraphicsDriver

	Method GraphicsModes:TGraphicsMode[]()
'DebugLog "GraphicsModes"
		Return Null
	End Method
	
	Method AttachGraphics:TwxGraphics( widget:Int,flags:Int )
'DebugLog "AttachGraphics"
		Local t:TwxGraphics=New TwxGraphics
		't._context=bbGLGraphicsAttachGraphics( widget,flags )
		Return t
	End Method
	
	Method CreateGraphics:TwxGraphics( width:Int,height:Int,depth:Int,hertz:Int,flags:Int )
'DebugLog "CreateGraphics"
		Local t:TwxGraphics = New TwxGraphics
		'Local t:TGLGraphics=New TGLGraphics
		't._context=bbGLGraphicsCreateGraphics( width,height,depth,hertz,flags )
		Return t
	End Method
	
	Method SetGraphics( g:TGraphics )
'DebugLog "SetGraphics"
		'Local context
		'Local t:TGLGraphics=TGLGraphics( g )
		'If t context=t._context
		'bbGLGraphicsSetGraphics context
	End Method
	
	Method Flip( sync:Int )
'DebugLog "Flip"
		'bbGLGraphicsFlip sync
	End Method
	
	Method SwapSharedContext()
'DebugLog "SwapSharedContext"
		'bbGLGraphicsSwapSharedContext
	End Method
	
End Type

Function wxGraphicsDriver:TwxGraphicsDriver()
'DebugLog "wxGraphicsDriver"
	Global _driver:TwxGraphicsDriver=New TwxGraphicsDriver
	Return _driver
End Function

'SetGraphicsDriver wxGraphicsDriver()


