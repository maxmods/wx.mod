SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxGLCanvas
Import wx.wxTimer
Import brl.GLGraphics

SetGraphicsDriver GLGraphicsDriver(),GRAPHICS_BACKBUFFER|GRAPHICS_DEPTHBUFFER

' Start the app !!!!!
New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"glcube sample", 50, 50, 450, 340))

		frame.show()
		
		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

	Field canvas:MyCanvas

	Method OnInit:Int()

		canvas = MyCanvas(New MyCanvas.Create(Self, -1, GRAPHICS_BACKBUFFER|GRAPHICS_DEPTHBUFFER))
	
		ConnectAny(wxEVT_CLOSE, OnClose)
	End Method
	
	Function OnClose(event:wxEvent)
		MyFrame(event.parent).canvas.timer.Stop() ' we really need to stop the timer on Mac...
		event.Skip()
	End Function

End Type

Type MyCanvas Extends wxGLCanvas

	Field timer:wxTimer
	Field ax#, ay#, tim#

	Method OnInit:Int()

		timer = New wxTimer.Create(Self)


		ConnectAny(wxEVT_TIMER, OnTimer)
'		ConnectAny(wxEVT_PAINT, OnPaint)

		timer.Start(16)
	End Method

	Function OnTimer(event:wxEvent)
		MyCanvas(event.parent).Refresh()
	End Function
	
	Method OnPaint(event:wxPaintEvent)
		Render()
	End Method

	Method Render()
'DebugStop
		SetGraphics CanvasGraphics( )
		Local wid:Int, hgt:Int
		GetSize(wid, hgt)
		Local asp# = Float(wid)/Float(hgt)
		
		glViewport 0,0,wid,hgt
		glMatrixMode GL_PROJECTION
		glLoadIdentity
		gluPerspective 45, asp, 1, 100
		gltranslatef 0,0,-50+tim
		tim=20*Cos(MilliSecs()/10.0)
		
		glMatrixMode GL_MODELVIEW
		glLoadIdentity
		
		Local global_ambient#[]=[0.6#, 0.5#,  0.3#, 1.0#]
		Local light0pos#[]=     [0.0#, 5.0#, 10.0#, 1.0#]
		Local light0ambient#[]= [0.5#, 0.5#,  0.5#, 1.0#]
		Local light0diffuse#[]= [0.3#, 0.3#,  0.3#, 1.0#]
		Local light0specular#[]=[0.8#, 0.8#,  0.8#, 1.0#]
		
		Local lmodel_ambient#[]=[ 0.2#,0.2#,0.2#,1.0#]
		glLightModelfv(GL_LIGHT_MODEL_AMBIENT,lmodel_ambient)
		
		glLightModelfv(GL_LIGHT_MODEL_AMBIENT, global_ambient)
		glLightfv(GL_LIGHT0, GL_POSITION, light0pos)
		glLightfv(GL_LIGHT0, GL_AMBIENT, light0ambient)
		glLightfv(GL_LIGHT0, GL_DIFFUSE, light0diffuse)
		glLightfv(GL_LIGHT0, GL_SPECULAR, light0specular)
		glEnable(GL_LIGHTING)
		glEnable(GL_LIGHT0)
		glShadeModel(GL_SMOOTH)
		glMateriali(GL_FRONT, GL_SHININESS, 128)
		
								 
		glClearColor 0,0,0.5,1
		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
		
		glEnable(GL_DEPTH_TEST)
		
		glRotatef ax,1,0,0
		glRotatef ay,0,1,0
		ax:+1
		ay:+5
		DrawSizeCube(7)
	
		Flip
	
	End Method

	Method DrawSizeCube(size#)
	        size=-size
	        'Front Face
	        glBegin(GL_TRIANGLE_STRIP)
	                glNormal3f( 0.0, 0.0, 1.0)
	                glVertex3f( size, size,-size)
	                glNormal3f( 0.0, 0.0, 1.0)
	                glVertex3f(-size, size,-size)
	                glNormal3f( 0.0, 0.0, 1.0)
	                glVertex3f( size,-size,-size)
	                glNormal3f( 0.0, 0.0, 1.0)
	                glVertex3f(-size,-size,-size)
	        glEnd
	        'Back Face
	        glNormal3f( 0.0, 0.0, -1.0)
	        glBegin(GL_TRIANGLE_STRIP)
	                glVertex3f(-size, size, size)
	                glVertex3f( size, size, size)
	                glVertex3f(-size,-size, size)
	                glVertex3f( size,-size, size)
	        glEnd
	        'Right Face
	        glNormal3f( 1.0, 0.0, 0.0)
	        glBegin(GL_TRIANGLE_STRIP)
	                glVertex3f(-size, size,-size)
	                glVertex3f(-size, size, size)
	                glVertex3f(-size,-size,-size)
	                glVertex3f(-size,-size, size)
	        glEnd
	        'Left Face
	        glNormal3f( -1.0, 0.0, 0.0)
	        glBegin(GL_TRIANGLE_STRIP)
	                glVertex3f( size, size, size)
	                glVertex3f( size, size,-size)
	                glVertex3f( size,-size, size)
	                glVertex3f( size,-size,-size)
	        glEnd
	        'Bottom Face
	        glNormal3f( 0.0, -1.0, 0.0)
	        glBegin(GL_TRIANGLE_STRIP)
	                glVertex3f( size, size,-size)
	                glVertex3f( size, size, size)
	                glVertex3f(-size, size,-size)
	                glVertex3f(-size, size, size)
	        glEnd
	        'Top Face
	        glNormal3f( 0.0, 1.0, 0.0)
	        glBegin(GL_TRIANGLE_STRIP)
	                glVertex3f( size,-size,-size)
	                glVertex3f(-size,-size,-size)
	                glVertex3f( size,-size, size)
	                glVertex3f(-size,-size, size)
	    glEnd
	End Method

End Type
