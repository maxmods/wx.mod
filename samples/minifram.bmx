Rem

C++ Splitter sample author info from which this .bmx was ported:

/////////////////////////////////////////////////////////////////////////////
// Name:        Minifram.cpp
// Purpose:     wxMiniFrame sample
// Author:      Robert Roebling
// Modified by:
// Created:     04/01/98
// RCS-ID:      $Id: Minifram.cpp,v 1.13 2006/10/29 19:26:54 RR Exp $
// Copyright:   (c) Julian Smart and Robert Roebling
// Licence:     wxWindows licence
// BlitzMax port: Bruce A Henderson and David De Candia
/////////////////////////////////////////////////////////////////////////////

cpp MiniFrame renamed as BabyFrame for easier visual recognition

End Rem

SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxMiniFrame

Const		ID_TOOLBAR:Int				= 500,.. 
			ID_REPARENT:Int				= 501 

'	Run the sample app
New MyApp.run()
			
' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyApp Extends wxApp

	Field MainFrame:MyMainFrame
	Field BabyFrame:MyBabyFrame
	Field Button:wxButton
	
	Method OnInit:Int()
	
		'	Allow us to load in XPM's
		wxImage.AddHandler(New wxXPMHandler)

		' create the main frame window
		MainFrame = MyMainFrame(New MyMainFrame.CreateMyMainFrame(Self,Null,wxID_ANY,"wxMiniFrame Main", 100,100,300,200))
	
		' Create our "reparent me" button			
		Button = New wxButton.Create(MainFrame,ID_REPARENT,"Press to reparent!")
		
		' Create the Baby frame window
		BabyFrame = MyBabyFrame(New MyBabyFrame.CreateMyBabyFrame(Self,MainFrame,wxID_ANY,"wxMiniFrame Baby", 100,100,220,100))
		
		' This cannot be done in Main or Baby's OnInit() - it has to go here				
		MainFrame.Show(True)
		BabyFrame.Show(True)
		
		SetTopWindow(MainFrame)
				
		Return True
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method InitToolbar:Int(_tool_bar:wxToolBar)
	
		Const NUM_TOOLS:Int = 8
	
		If Not _tool_bar Throw "InitToolbar - Null tool_bar"
		
		_tool_bar.SetMargins(5,5)

		' Set up toolbar
		Local tool_bar_bitmaps:wxBitmap[NUM_TOOLS]
		Local s_bitmaps:String[]     = ["new.xpm","open.xpm","save.xpm","copy.xpm","cut.xpm","preview.xpm","print.xpm","help.xpm"]
		Local s_description:String[] = ["New file","Open file","Save file","Copy","Cut","Paste","Reparent the button","Help"]
		Local id:Int[]               = [wxID_NEW,wxID_OPEN,wxID_SAVE,wxID_COPY,wxID_CUT,wxID_PASTE,wxID_PRINT,wxID_HELP]
		
		For Local tool_id:Int = 0 Until NUM_TOOLS
		
			'	Create the tool bar tool icon bitmap
			tool_bar_bitmaps[tool_id] = New wxBitmap.CreateFromFile( "media/minifram/" +s_bitmaps[tool_id], wxBITMAP_TYPE_XPM )	

			'	Add a separator every 3rd menu tool item
			If tool_id And Not (tool_id Mod 3) Then _tool_bar.AddSeparator()
			
			'	Add the tool to the toolbar
			_tool_bar.AddTool(id[tool_id],"",tool_bar_bitmaps[tool_id],Null, wxITEM_NORMAL,s_description[tool_id])
					
			 ' Unnecessary as GC will tidy this for us but for the record: you may delete the bitmaps since they're reference counted
	'		tool_bar_bitmaps[tool_id] = Null
		
		Next
		
		_tool_bar.Realize()
		_tool_bar.EnableTool(wxID_HELP,False)
		
		Return True
	End Method

End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyBabyFrame Extends wxMiniFrame

	'	We need access to our creator's Fields. This simplifies this
	Field ParentApp:MyApp
	Field b_BabyFrameExists:Int

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method CreateMyBabyFrame:MyBabyFrame(_my_app:MyApp, _parent:wxFrame, _id:Int, _s_title:String, _x:Int,_y:Int,_w:Int,_h:Int )
	
		'	Remember who our creator was OR you could go: 	MyApp(wxApp.app)
		ParentApp = _my_app

		create(_parent,_id,_s_title,_x,_y,_w,_h)
		
		Return Self
		
	End Method	
		
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnCloseWindow(_event:wxEvent)
		
		'	Cast to correct event type
	'	Local event:wxCloseEvent = (wxCloseEvent)(_event)
		
		'	Discover the calling context
		Local baby_frame:MyBabyFrame = MyBabyFrame(_event.parent)

		'	Flag this frame no longer exists
		baby_frame.b_BabyFrameExists = False
		
		baby_frame.Destroy()
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()

		CreateToolBar(wxNO_BORDER|wxTB_HORIZONTAL|wxTB_FLAT, ID_TOOLBAR)
		ParentApp.InitToolbar(GetToolBar())
			
		ConnectAny(wxEVT_CLOSE_WINDOW, OnCloseWindow)
		Connect(ID_REPARENT,wxEVT_COMMAND_BUTTON_CLICKED, OnReparent)
		Connect(wxID_PRINT, wxEVT_COMMAND_MENU_SELECTED, OnReparent)
	
'		SetIcon(wxICON(mondrian))
	
		
		b_BabyFrameExists	= True

	End Method

	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnReparent(_event:wxEvent)
		
	'	Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local baby_frame:MyBabyFrame = MyBabyFrame(_event.parent)

		baby_frame.ParentApp.Button.Reparent(baby_frame.ParentApp.MainFrame)
		
		' We need to force the frame to size its (new) child correctly
  		baby_frame.ParentApp.MainFrame.SendSizeEvent();
				
	End Function
	
End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyMainFrame Extends wxFrame

	'	We need access to our creator's Fields. This simplifies this
	Field ParentApp:MyApp
	
	Const	ID_SET_SIZE_TO_150_150:Int 			= 100,..
			ID_SET_SIZE_TO_200_200:Int 			= 101,..
			ID_SET_MAX_SIZE_TO_150_150:Int 	= 102,..
			ID_SET_MAX_SIZE_TO_300_300:Int	= 103
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method CreateMyMainFrame:MyMainFrame(_my_app:MyApp, _parent:wxFrame, _id:Int, _s_title:String, _x:Int,_y:Int,_w:Int,_h:Int )
	
		'	Remember who our creator was
		ParentApp = _my_app

		create(_parent,_id,_s_title,_x,_y,_w,_h)
		
		Return Self
		
	End Method	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Function OnCloseWindow(_event:wxEvent)
		
		'	Cast to correct event type
	'	Local event:wxCloseEvent = (wxCloseEvent)(_event)
		
		'	Discover the calling context
		Local main_frame:MyMainFrame = MyMainFrame(_event.parent)
		
		main_frame.Destroy()
		
	End Function	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()

		SetSizeHints(100,100,400,400)
		
		Local file_menu:wxMenu = wxMenu.CreateMenu()
		file_menu.Append(wxID_EXIT,"E&xit~tAlt-Q")
		file_menu.Append(ID_SET_SIZE_TO_150_150, "Set frame size to 150,150~tF2")
		file_menu.Append(ID_SET_SIZE_TO_200_200, "Set frame size to 200,200~tF3")
		file_menu.Append(ID_SET_MAX_SIZE_TO_150_150, "Set frame max size to 150,150~tF4")
		file_menu.Append(ID_SET_MAX_SIZE_TO_300_300, "Set frame max size to 300,300~tF5")
	
		Local menu_bar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menu_bar.Append(file_menu,"&File")
		
		SetMenuBar(menu_bar)
		
		ConnectRange(ID_SET_SIZE_TO_150_150, wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, OnSetSize_150_150)
		ConnectRange(ID_SET_SIZE_TO_200_200, wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, OnSetSize_200_200)
		ConnectRange(ID_SET_MAX_SIZE_TO_150_150, wxID_ANY, wxEVT_COMMAND_MENU_SELECTED,OnSetMaxSize_150_150)
		ConnectRange(ID_SET_MAX_SIZE_TO_300_300, wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, OnSetMaxSize_300_300)

		CreateToolBar(wxNO_BORDER|wxTB_VERTICAL,ID_TOOLBAR)
		ParentApp.InitToolbar(GetToolBar())
	
		ConnectAny(wxEVT_CLOSE_WINDOW, OnCloseWindow)
		Connect(ID_REPARENT,wxEVT_COMMAND_BUTTON_CLICKED, OnReparent)
		Connect(wxID_PRINT, wxEVT_COMMAND_MENU_SELECTED, OnReparent)
		
'		SetIcon(wxICON(mondrian))
		

	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnReparent(_event:wxEvent)
		
		'Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local main_frame:MyMainFrame = MyMainFrame(_event.parent)

		If main_frame.ParentApp.BabyFrame.b_BabyFrameExists
			
			main_frame.ParentApp.Button.Reparent(main_frame.ParentApp.BabyFrame)
		
			' We need to force the frame to size its (new) child correctly
  			main_frame.ParentApp.BabyFrame.SendSizeEvent();
		
		Else
			wxMessageBox("The Babyframe no longer exists.~n You don't want to make this button an orphan do you?","You got to be kidding")
	
		EndIf
					
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnSetSize_150_150(_event:wxEvent)

	'	Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local main_frame:MyMainFrame = MyMainFrame(_event.parent)
		
		main_frame.SetSize(150,150)
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnSetSize_200_200(_event:wxEvent)

	'	Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local main_frame:wxFrame = MyMainFrame(_event.parent)
		
		main_frame.SetSize(200,200)
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnSetMaxSize_150_150(_event:wxEvent)

		'Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local main_frame:wxFrame = MyMainFrame(_event.parent)
		
		main_frame.SetSizeHints(-1,-1,150,150)
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem		
	Function OnSetMaxSize_300_300(_event:wxEvent)
		
		'Local event:wxCommandEvent = (wxCommandEvent)(_event)
	
		'	Discover the calling context
		Local main_frame:wxFrame = MyMainFrame(_event.parent)
		
		main_frame.SetSizeHints(-1,-1,300,300)
		
	End Function
End Type


