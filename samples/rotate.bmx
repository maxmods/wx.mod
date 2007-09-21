Rem

C++ Splitter sample author info from which this .bmx was ported:

/////////////////////////////////////////////////////////////////////////////
// Name:      rotate.cpp
// Purpose:   Image rotation test
// Author:    Carlos Moreno
// Modified by:
// Created:   6/2/2000
// RCS-ID:    $Id: rotate.cpp,v 1.18 2006/08/13 01:17:51 VZ Exp $
// Copyright: (c) 2000
// Licence:   wxWindows licence
/////////////////////////////////////////////////////////////////////////////
// BlitzMax port: Bruce A Henderson and David De Candia
/////////////////////////////////////////////////////////////////////////////

End Rem

SuperStrict

Framework wx.wxApp
Import brl.LinkedList
Import wx.wxFrame
Import wx.wxImage
Import wx.wxScrolledWindow
Import wx.wxMouseEvent
Import wx.wxLog
Import wx.wxNumberEntryDialog

'	Run the sample app
New MyApp.run()

Const	ID_QUIT:Int 	= 1,..
		ID_ANGLE:Int 	= 2,..
		ID_CLEAR:Int	= 3
			
Const 	M_PI:Float	= 3.14159265			

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyApp Extends wxApp

	Field m_Image:wxImage

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method GetImage:wxImage()

		Return m_Image

	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit:Int()
	
		'	Allow us to load in PNG's
		wxImage.AddHandler(New wxPNGHandler)
		
		'	Load the duck!
		m_Image = wxImage.CreateFromFile("media/rotate/duck.png", wxBITMAP_TYPE_PNG)

		'	NB REMOVE FALSE AND WHEN IS.OK IS WORKING
		'	Safety check
		If False And Not m_Image.IsOk()
			wxLogError("Can't load the test image, please copy it to the program directory")
			Return False
		EndIf

		' 	Create the main frame window
		Local frame:MyFrame = MyFrame(New MyFrame.CreateMyFrame(,,"wxWidgets rotate sample", 20,20,600,450))
		
		' 	This cannot be done in the frame's OnInit() - it has to go here				
		frame.Show(True)
		
		SetTopWindow(frame)
				
		Return True
	
	End Method
			
End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   A helper class to store duck image and location
	about:    
End Rem	
Type MyRenderedImage 

	Field m_Bitmap:wxBitmap
	Field m_X:Int
	Field m_Y:Int
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method create:MyRenderedImage(_bmp:wxBitmap, _x:Int, _y:Int)
	
		m_X 	= _x
		m_Y 	= _y
		m_Bitmap = _bmp
		
		Return Self
	
	End Method

End Type

' ----------------------------------------------------------------
Rem
	bbdoc:  The canvas we draw upon. 
	about:    
End Rem	
Type MyCanvas Extends wxScrolledWindow

	'	This will be a list of MyRenderedImage (duck images + coords)
	Field m_Images:TList
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method ClearImages()
	
		'	Clear the image list 
		If m_Images Then m_Images.Clear()
		
		'	Redraw the canvas
		Refresh(True)
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method CreateMyCanvas:MyCanvas( _parent:wxWindow, _id:Int )
	
		'	Invoke the wxScrolledWindow create
		create(_parent,_id)
		
		Return Self
		
	End Method	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method OnInit()
	
		'	Set a particularly ugly background colour
		SetBackgroundColour(New wxColour.Create(0,80,60))
		
		'	And clear the window background
		ClearBackground()
		
		'	Create a new list
		m_Images = New TList
				
		'	Connect the functions to the events
		ConnectAny(wxEVT_LEFT_UP,OnMouseLeftUp)
		ConnectAny(wxEVT_RIGHT_UP,OnMouseRightUp)
		ConnectAny(wxEVT_PAINT,OnPaint)
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   Rotate with interpolation and with offset correction
	End Rem	
	Function OnMouseLeftUp(_event:wxEvent)

		Local event:wxMouseEvent = (wxMouseEvent)(_event)
		Local my_canvas:MyCanvas= (MyCanvas)(event.parent)
		Local my_frame:MyFrame = (MyFrame)(my_canvas.GetParent())
		Local offset_x:Int
		Local offset_y:Int
		
		'	wxGetApp() = wxApp.app
		Local base_image:wxImage = MyApp(wxGetApp()).GetImage()
		Local rotated_image:wxImage = base_image.Rotate(my_frame.m_Angle, base_image.GetWidth()/2,base_image.GetHeight()/2,True,offset_x,offset_y)
		
		'	Add this rotated image at the mouse x,y to the image list
		my_canvas.m_Images.AddLast(MyRenderedImage(New MyRenderedImage.Create(wxBitmap.CreateFromImage(rotated_image),offset_x + event.GetX(),offset_y + event.GetY())))
		
		my_canvas.Refresh(False)
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   Rotate without interpolation, and without offset correction
	End Rem	
	Function OnMouseRightUp(_event:wxEvent)
		
		Local event:wxMouseEvent = (wxMouseEvent)(_event)
		Local my_canvas:MyCanvas= (MyCanvas)(event.parent)
		Local my_frame:MyFrame = (MyFrame)(my_canvas.GetParent())
		
		'	We are ignoring the offset coords this time
		Local dummy_1:Int
		Local dummy_2:Int
		
		Local base_image:wxImage = MyApp(wxGetApp()).GetImage()
		Local rotated_image:wxImage = base_image.Rotate(my_frame.m_Angle, base_image.GetWidth()/2,base_image.GetHeight()/2,False,dummy_1,dummy_2)
	
		'	Add this rotated image at the mouse x,y to the image list
		my_canvas.m_Images.AddLast(MyRenderedImage(New MyRenderedImage.Create(wxBitmap.CreateFromImage(rotated_image),event.GetX(),event.GetY())))
		
		my_canvas.Refresh(False)
			
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Function OnPaint(_event:wxEvent)
	
			
		' We *must* create a wxPaintDC in an OnPaint
		Local dc:wxPaintDC = New wxPaintDC.Create(wxScrolledWindow(_event.parent))
		Local my_canvas:MyCanvas= (MyCanvas)(_event.parent)
	
		'	Display a text message
		dc.SetTextForeground(New wxColour.create(255,255,255))
		dc.DrawText("Click on the canvas to draw a duck.",10,10)
		
		'	Draw all the ducks
		For Local duck:MyRenderedImage = EachIn my_canvas.m_Images
		
			dc.DrawBitmap(duck.m_Bitmap,duck.m_X,duck.m_Y,True)
		
		Next

		' Manual free as we can't afford to rely on timely auto garbage collection 
		dc.Free
	
	End Function

End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyFrame Extends wxFrame

	'	We need access to our creator's Fields. This simplifies this
	Field m_Canvas:MyCanvas
	Field m_Angle:Float
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method CreateMyFrame:MyFrame( _parent:wxFrame = Null, _id:Int = wxID_ANY, _s_title:String, _x:Int,_y:Int,_w:Int,_h:Int )
	
		create(_parent,_id,_s_title,_x,_y,_w,_h)
		
		Return Self
		
	End Method	

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnAngle(_event:wxEvent)
		
		Local my_frame:MyFrame =  (MyFrame)(_event.parent)
		
		Local degrees:Int = Int((180.0 * my_frame.m_Angle)/M_PI)
		
		degrees = wxGetNumberFromUser("Change the image rotation angle","Angle in degrees:","wxWidgets rotate sample",degrees,-180,180,my_frame)
		
		If degrees <> -1 Then my_frame.m_Angle = (degrees * M_PI) / 180.0
		
	End Function	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnClear(_event:wxEvent)

		 (MyFrame)(_event.parent).m_Canvas.ClearImages()
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()

		'	The angle to start drawing ducks
		m_Angle = 0.1
		
		'	Create our drawing canvas
		m_Canvas = (MyCanvas)(New MyCanvas.CreateMyCanvas(Self,wxID_ANY))
		
		'	Construct the menu items
		Local menu_file:wxMenu =  New wxMenu.Create()
		
		menu_file.Append(ID_ANGLE,"Set &angle...~tCrtl-A")
		menu_file.Append(ID_CLEAR,"&Clear all ducks~tCrtl-C")
		menu_file.AppendSeparator()
		menu_file.Append(ID_QUIT,"E&xit~tAlt-X")
	
		'	Attach these items to a menu bar
		Local menu_bar:wxMenuBar = New wxMenuBar.Create()
		menu_bar.Append(menu_file,"&File")
		
		'	Attach the menu bar to the frame
		SetMenuBar(menu_bar)
		
		'	Hook up the menus with their functions
		Connect(ID_QUIT,wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(ID_ANGLE,wxEVT_COMMAND_MENU_SELECTED, OnAngle)
		Connect(ID_CLEAR,wxEVT_COMMAND_MENU_SELECTED, OnClear)

	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnQuit(_event:wxEvent)
		
		 (MyFrame)(_event.parent).Close(True)
		
	End Function
	
	
End Type
